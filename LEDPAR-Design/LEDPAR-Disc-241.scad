$fn = 64;

Main();

module Main() {
    projection(){
        Panel();
    }
//    Panel();
}

module Panel() {

    panel_radius = 172/2; // + 5/2;
    panel_height = 4;
    hole_wire_radius = 10;
    home_screw_radius = 1;  // M2

    translate([panel_radius, panel_radius, 0]) {
        difference() {
            union() {
                cylinder(r=panel_radius, h=panel_height);
            }
            union() {
                translate([0, 0, -panel_height/2]) {
                    Hole();
                    VentHoles();
                    for (margin = [9, 29, 49, 69]) {
                        ScrewHoles(margin);
                    }
                }
            }
        }
    }

    module Hole() {
        hull(){
            cylinder(r=hole_wire_radius, h=panel_height*2);
            translate([panel_radius, 0, 0]) {
                cylinder(r=hole_wire_radius, h=panel_height*2);
            }
        }
    }

    module VentHoles() {
        for (i = [1, 2]) {
            distance = panel_radius - (i-1)*2.25*hole_wire_radius - hole_wire_radius-5;
            for (angle = [0, 30, 60, 120, 150, 180, 210, 240, 270, 300, 330]) {
                translate([sin(angle)*distance, cos(angle)*distance, 0]) {
                    cylinder(r=hole_wire_radius/i, h=panel_height*2);
                }
            }
        }
    }

    module ScrewHoles(margin=9) {
        distance = panel_radius - margin;
        for (angle = [0+45, 90+45, 180+45, 270+45]) {
            translate([sin(angle)*distance, cos(angle)*distance, 0]) {
                ScrewHole();
            }
        }
        module ScrewHole() {
            cylinder(r=home_screw_radius, h=panel_height*2);
        }
    }

}

