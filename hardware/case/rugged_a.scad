// Pablo Hacker / BruceButBetter — Rugged A parametric enclosure
// STATUS: PARAMETRIC PROTOTYPE; MEASURE_REQUIRED values are not verified.
// Set dimensions from caliper measurements before exporting STL.

variant = "A1"; // "A1" touch-only or "A2" optional BACK/SELECT provisions

// ---------------- MEASURE_REQUIRED ----------------
tft_w = 76.0;          // MEASURE_REQUIRED: TPM408 PCB outer width
tft_h = 105.0;         // MEASURE_REQUIRED: TPM408 PCB outer height
tft_t = 4.0;           // MEASURE_REQUIRED: PCB/display stack thickness
tft_window_w = 58.0;   // MEASURE_REQUIRED: visible active window
tft_window_h = 78.0;   // MEASURE_REQUIRED: visible active window
tft_hole_d = 3.2;      // MEASURE_REQUIRED: mounting hole diameter
tft_hole_x = 5.0;      // MEASURE_REQUIRED: hole center inset
tft_hole_y = 5.0;      // MEASURE_REQUIRED: hole center inset

esp_w = 55.0;          // MEASURE_REQUIRED: carrier width
esp_h = 28.0;          // MEASURE_REQUIRED: carrier length
esp_t = 12.0;          // MEASURE_REQUIRED: tallest component
usb_x = 8.0;           // MEASURE_REQUIRED: USB-C center offset
usb_z = 8.0;           // MEASURE_REQUIRED: USB-C height

batt_w = 22.0;         // MEASURE_REQUIRED: protected 18650 holder width
batt_l = 78.0;         // MEASURE_REQUIRED: holder length
batt_h = 22.0;         // MEASURE_REQUIRED: holder height
stylus_d = 8.0;        // MEASURE_REQUIRED: stylus diameter
stylus_l = 105.0;      // MEASURE_REQUIRED: stylus length

// Design allowances, adjustable after measurements.
wall = 2.8;
clearance = 1.2;
corner_r = 7;
front_lip = 2.0;
depth = 34.0;           // MEASURE_REQUIRED after stack-up and battery layout

case_w = max(tft_w, esp_w + 2*wall) + 2*wall + 8;
case_h = max(tft_h, batt_l) + 2*wall + 8;

module_t = tft_t + clearance;

module_holes() {
    for (x=[tft_hole_x, tft_w-tft_hole_x])
        for (y=[tft_hole_y, tft_h-tft_hole_y])
            translate([x,y,-1]) cylinder(d=tft_hole_d+0.5,h=depth+2,$fn=32);
}

rounded_box(w,h,d,r) {
    hull() {
        for (x=[r,w-r]) for (y=[r,h-r])
            translate([x,y,0]) cylinder(r=r,h=d,$fn=32);
    }
}

front_shell() {
    difference() {
        rounded_box(case_w, case_h, depth, corner_r);
        // TFT opening: placeholder position until active-window offsets are measured.
        translate([(case_w-tft_window_w)/2, case_h-tft_window_h-7, depth-3])
            cube([tft_window_w,tft_window_h,6]);
        // Four TFT mounting hole channels, shown as a common mounting pattern placeholder.
        translate([(case_w-tft_w)/2, case_h-tft_h-4, 0]) module_holes();
        // Two USB-C side openings; exact positions must be measured on the carrier.
        translate([-1, 10, usb_z]) cube([wall+2, 10, 6]);
        translate([case_w-wall-1, 10, usb_z]) cube([wall+2, 10, 6]);
        // Battery bay access volume.
        translate([(case_w-batt_w)/2, 5, wall]) cube([batt_w+2*clearance,batt_l+2*clearance,batt_h+2*clearance]);
    }
}

back_cover() {
    difference() {
        rounded_box(case_w, case_h, 4, corner_r);
        // Ventilation and cable relief are intentionally conservative placeholders.
        for (x=[case_w/2-12,case_w/2+12]) translate([x,8,-1]) cylinder(d=4,h=6,$fn=24);
    }
}

stylus_holder() {
    difference() {
        // Thick open-top cradle: no fragile snap hooks.
        translate([case_w+4, 12, 4]) cube([stylus_d+5, stylus_l+4, stylus_d+8]);
        translate([case_w+6.5, 14, 7]) cylinder(d=stylus_d+0.8,h=stylus_l+2,$fn=32);
    }
}

button_provisions() {
    if (variant == "A2") {
        // Mechanical provisions only. GPIO assignment is intentionally absent.
        for (y=[case_h/2-10, case_h/2+10])
            translate([case_w/2-6,y,-1]) cylinder(d=8,h=6,$fn=32);
    }
}

// Exploded layout preview: move covers and cradle for inspection.
front_shell();
translate([case_w+18,0,0]) back_cover();
translate([case_w+18,case_h+12,0]) stylus_holder();
button_provisions();
