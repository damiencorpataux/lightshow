$fn = 64;

Main();

module Main() {
    projection(){
//        Panel();
    }
    Panel();
}

module Panel() {

    panel_radius = 172/2; // + 5/2;
    panel_height = 4;
    hole_wire_radius = 12.5;
    home_screw_radius = 1;  // M2

    translate([panel_radius, panel_radius, 0]) {
        difference() {
            union() {
                cylinder(r=panel_radius, h=panel_height);
            }
            union() {
                translate([0, 0, -panel_height/2]) {
                    #Hole();
                    #ScrewHoles();
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

    module ScrewHoles() {
        margin = 9;
        radius = panel_radius - margin;
        for (angle = [0+45, 90+45, 180+45, 270+45]) {
            translate([sin(angle)*radius, cos(angle)*radius, 0]) {
                ScrewHole();
            }
        }
        module ScrewHole() {
            cylinder(r=home_screw_radius, h=panel_height*2);
        }
    }

}

