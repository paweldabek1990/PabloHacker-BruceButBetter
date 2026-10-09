// Cheap fit coupon for Rugged A1.
// STATUS: must be parameterized from caliper measurements before export.
// This is intentionally not the final enclosure.

// PHOTO_ESTIMATE: supplied photographs only; replace with caliper values.
tft_hole_spacing_x = 42.0; // transverse spacing MEASURE_REQUIRED
tft_hole_spacing_y = 80.5; // PHOTO_ESTIMATE from supplied ~79–82 mm
tft_hole_d = 3.2;
tft_window_w = 58.0;
tft_window_h = 78.0;
usb_center_spacing = 9.0; // MEASURE_REQUIRED; both ports appear on one end
usb_w = 10.0;
usb_h = 5.0;
plate_t = 3.0;
edge = 12.0;

plate_w = tft_hole_spacing_x + 2*edge;
plate_h = tft_hole_spacing_y + 2*edge;

difference() {
    cube([plate_w, plate_h, plate_t]);
    // TFT mounting-hole test pattern.
    for (x=[edge, edge+tft_hole_spacing_x])
        for (y=[edge, edge+tft_hole_spacing_y])
            translate([x,y,-1]) cylinder(d=tft_hole_d,h=plate_t+2,$fn=32);
    // Active-window test aperture.
    translate([(plate_w-tft_window_w)/2,(plate_h-tft_window_h)/2,-1])
        cube([tft_window_w,tft_window_h,plate_t+2]);
    // Two same-end USB-C gauge slots; position/orientation must be measured.
    translate([(plate_w-usb_center_spacing)/2-usb_w/2, -1, 0]) cube([usb_w,edge+2,usb_h]);
    translate([(plate_w+usb_center_spacing)/2-usb_w/2, -1, 0]) cube([usb_w,edge+2,usb_h]);
}
