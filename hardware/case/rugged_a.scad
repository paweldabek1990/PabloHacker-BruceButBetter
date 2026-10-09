// Pablo Hacker / BruceButBetter — Rugged A parametric enclosure
// STATUS: PARAMETRIC PROTOTYPE; PHOTO_ESTIMATE values are not mounting-verified.
// Set dimensions from caliper measurements before exporting STL.

variant = "A1"; // "A1" touch-only or "A2" optional BACK/SELECT provisions

// ---------------- PHOTO_ESTIMATE / MEASURE_REQUIRED ----------------
// Based on the supplied mat photographs; do not use for final mounting.
tft_w = 52.0;          // PHOTO_ESTIMATE: red PCB outer width, observed ~50–54
tft_h = 89.0;          // PHOTO_ESTIMATE: red PCB outer height, observed ~88–90
tft_t = 4.0;           // MEASURE_REQUIRED: PCB/display stack thickness
tft_window_w = 43.0;  // PHOTO_ESTIMATE: active window only; verify bezel/offset
tft_window_h = 70.0;  // PHOTO_ESTIMATE: active window only; verify bezel/offset
tft_hole_d = 3.2;      // MEASURE_REQUIRED: mounting hole diameter
tft_hole_x = 5.0;      // MEASURE_REQUIRED: transverse hole-center inset
tft_hole_y = 4.25;     // PHOTO_ESTIMATE: longitudinal inset; verify each hole
tft_hole_spacing_y = 80.5; // PHOTO_ESTIMATE: longitudinal center spacing ~79–82

// Reference envelope from espboards.dev; verify against the user's V1.4 board
// before final export. Source: https://www.espboards.dev/esp32/yd-esp32-s3/
esp_w = 58.0;          // PHOTO_ESTIMATE: observed ~57–59; reference was 57.15
esp_h = 28.0;          // PHOTO_ESTIMATE: observed ~28; reference was 27.94
esp_pitch = 2.54;      // VERIFIED REFERENCE: header pitch (mm)
esp_t = 12.0;          // MEASURE_REQUIRED: tallest component
usb_x = 8.0;           // MEASURE_REQUIRED: USB-C center offset
usb_z = 8.0;           // MEASURE_REQUIRED: USB-C height
usb_orientation = "SAME_END_PHOTO_ESTIMATE"; // verify connector side/orientation
usb_center_spacing = 9.0; // MEASURE_REQUIRED: spacing between connector centers
usb_slot_w = 10.0;     // MEASURE_REQUIRED: plug opening width
usb_slot_h = 6.0;      // MEASURE_REQUIRED: plug opening height

batt_w = 22.0;         // MEASURE_REQUIRED: protected 18650 holder width
batt_l = 78.0;         // MEASURE_REQUIRED: holder length
batt_h = 22.0;         // MEASURE_REQUIRED: holder height
stylus_d = 6.5;        // PHOTO_ESTIMATE: max diameter ~6–7
stylus_l = 79.5;       // PHOTO_ESTIMATE: length ~79–80
stylus_tip_d = 3.5;    // MEASURE_REQUIRED: tapered tip diameter
stylus_clip_w = 2.0;   // design parameter; verify fit against actual clip

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
        for (y=[tft_hole_y, tft_hole_y+tft_hole_spacing_y])
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
        // Both USB-C openings are provisioned on one short end according to the
        // photo orientation; center spacing and exact height remain measured inputs.
        translate([(case_w-usb_center_spacing)/2-usb_slot_w/2, -1, usb_z])
            cube([usb_slot_w, wall+2, usb_slot_h]);
        translate([(case_w+usb_center_spacing)/2-usb_slot_w/2, -1, usb_z])
            cube([usb_slot_w, wall+2, usb_slot_h]);
        // Bottom header and microSD access are kept as service clearances.
        translate([(case_w-32)/2, case_h-tft_h-2, -1]) cube([32, 7, depth+2]);
        translate([case_w-20, case_h/2-15, depth-4]) cube([18, 30, 6]);
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
        // Thick cradle for a tapered stylus, with a flexible-looking retaining
        // clip geometry. Dimensions are estimates until the real stylus is measured.
        translate([case_w+4, 12, 4]) cube([stylus_d+6, stylus_l+5, stylus_d+9]);
        translate([case_w+7, 14, 7])
            hull() {
                cylinder(d=stylus_d+0.8,h=stylus_l+2,$fn=32);
                translate([0,stylus_l,0]) cylinder(d=stylus_tip_d+0.8,h=stylus_l+2,$fn=32);
            }
        // Open slot and clip clearance; avoids a brittle closed cylinder.
        translate([case_w+4, stylus_l/2+12, stylus_d+4]) cube([stylus_d+6, 3, 7]);
    }
    translate([case_w+4, 12+stylus_l-8, stylus_d+10]) cube([stylus_d+6, 8, 2]);
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
