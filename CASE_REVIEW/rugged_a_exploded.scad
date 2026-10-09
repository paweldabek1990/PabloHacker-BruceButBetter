// Rugged A1 exploded placement review only; not a printable enclosure.
// Component solids are placeholders and intentionally colored for review.
use <rugged_a.scad>;

tft_w=52; tft_h=89; tft_t=4;
esp_w=58; esp_h=28; esp_t=12;
batt_w=22; batt_l=78; batt_h=22;
stylus_d=6.5; stylus_l=79.5;
wall=2.8; case_w=max(tft_w,esp_w+2*wall)+2*wall+8;
case_h=max(tft_h,batt_l)+2*wall+8;
depth=34;

// enclosure shell and replaceable rear cover
color("#303030") front_shell();
color("#505050") translate([case_w+18,0,0]) back_cover();

// PHOTO_ESTIMATE / MEASURE_REQUIRED component envelopes
color("#a00000") translate([8,8,depth+8]) cube([tft_w,tft_h,tft_t]);
color("#202020") translate([8,tft_h+25,depth+8]) cube([esp_w,esp_h,esp_t]);
color("#404040") translate([case_w-batt_w-8,8,depth+8]) cube([batt_w,batt_l,batt_h]);
color("#39FF14") translate([case_w+8,8,depth+10]) rotate([90,0,0]) cylinder(d=stylus_d,h=stylus_l,$fn=32);
