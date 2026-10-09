// Rugged A1 placement preview only; not a printable enclosure.
// Uses the same PHOTO_ESTIMATE parameters as rugged_a.scad.
use <rugged_a.scad>;

// OpenSCAD `use` imports modules but not top-level variables; keep this
// preview explicitly synchronized with rugged_a.scad's current parameters.
tft_w = 52.0; tft_h = 89.0; tft_t = 4.0;
esp_w = 58.0; esp_h = 28.0; esp_t = 12.0;
batt_w = 22.0; batt_l = 78.0; batt_h = 22.0;
stylus_d = 6.5; stylus_l = 79.5;
wall = 2.8; case_w = max(tft_w, esp_w + 2*wall) + 2*wall + 8;
case_h = max(tft_h, batt_l) + 2*wall + 8;

// The components are deliberately separate colored solids so the placement
// and remaining measurement assumptions are visible in the render.
color("#8b0000") translate([10, 10, 2]) cube([tft_w, tft_h, tft_t]);
color("#202020") translate([10, tft_h + 22, 2]) cube([esp_w, esp_h, esp_t]);
color("#303030") translate([case_w - batt_w - 8, 10, 2]) cube([batt_w, batt_l, batt_h]);
color("#39FF14") translate([case_w + 6, 10, 4])
    rotate([90,0,0]) cylinder(d=stylus_d, h=stylus_l, $fn=32);

// Reference outline only; it is not exported as a final case.
color([0.1,0.1,0.1,0.18]) translate([0,0,0])
    difference() {
        cube([case_w, case_h, 2]);
        translate([wall,wall,-1]) cube([case_w-2*wall,case_h-2*wall,4]);
    }
