$fn=120;


wheel_width = 10;
bracket_thickness = 5;
spacer_width = 3 + bracket_thickness;
spacer_diameter = 13;
axel_diameter = 8.5;
screw_hole_diameter = 3.5;
clearance = 0.3;

module shaft(){
    translate([0, 0, -wheel_width]) union() {
        difference() {
            cylinder(d=axel_diameter, h=wheel_width + spacer_width);
            cylinder(d=screw_hole_diameter, h=wheel_width + spacer_width);
            translate([0, 0, wheel_width]) cutout();
        }
        hull(){
            translate([0, 0, -2]) cylinder(d=spacer_diameter, h=2);
            translate([0, 0, -4]) cylinder(d=spacer_diameter - 4, h=4);
        }
    }
}

module cutout() {
    difference() {
        cylinder(d=axel_diameter * 2, h=spacer_width);
        cylinder(d=axel_diameter, h=spacer_width, $fn=6);
    }
}

module spacer() {
    difference() {
        cylinder(d=spacer_diameter, h=spacer_width);
        cylinder(d=axel_diameter + clearance, h=spacer_width);
    }
}


module spacer_v2() {
    // NOTE: Printing on its side would eliminate support and reduce risk of tab breaking off during install, but adds risk of shaft torque splitting hole
    difference() {
        union() {
            cylinder(d=spacer_diameter, h=spacer_width);
            translate([0, 0, spacer_width - bracket_thickness]) {
                cylinder(d=spacer_diameter * 1.155, h=bracket_thickness, $fn=6);
                translate([0, -spacer_diameter/2, 0]) cube([23, spacer_diameter, bracket_thickness]);
                translate([21, -spacer_diameter/2, 0]) cube([bracket_thickness, spacer_diameter, 15 + bracket_thickness]);
            }
        }
        cylinder(d=axel_diameter + clearance, h=spacer_width, $fn=6);
    }
}


shaft();
spacer_v2();
