$fn = 32;

panel_width = 320;
panel_height = 10;
hole_wire_radius = 15;
home_screw_radius = 1.5;

projection(){
    Panel();
}
//Panel();

module Panel() {
    difference() {
        union() {
            cube([panel_width, panel_width, panel_height]);
            translate([0, 0, panel_height]) {
//                PanelLines();
            }
        }
        union() {
            for (i = [0:3]) {
                translate([0, i*panel_width/4, 0]) {
                    PanelHolesRowDoubleSided();
                }
            }
            ScrewHoles();
        }
    }
}

module PanelHolesRowDoubleSided() {
    margin_y = 20;
    translate([0, margin_y, 0]) {
        PanelHolesRow();
    }
    translate([0, panel_width/4-margin_y, 0]) {
        PanelHolesRow();
    }
}

module PanelHolesRow() {
    margin_x = 40;
    translate([0, 0, panel_height/2]) {
        translate([margin_x, 0, 0]) {
            PanelHole();
        }
        translate([panel_width/2, 0, 0]) {
            PanelHole();
        }
        translate([panel_width-margin_x, 0, 0]) {
            PanelHole();
        }
    }
    module PanelHole() {
        translate([0, 0, 0]) {
            #cylinder(r=hole_wire_radius, h=panel_height*2, center=true);
        }
//            square_size = 1.75;
//            translate([-square_size/2, -square_size/2, 0]) {
//                cube([square_size, square_size, 3]);
//            }
    }
}

module ScrewHoles() {
    margin = 15;
    translate([0, 0, -panel_height/2]) {
        for (x = [margin, margin, panel_width-margin],
             y = [margin, panel_width-margin, margin, panel_width-margin]
        ) {
            translate([x, y, 0]) {
                ScrewHole();
            }
        }
    }
    module ScrewHole() {
        #cylinder(r=home_screw_radius, h=panel_height*2, center=false);
    }
}

module PanelLines() {
    // Panel limit line
    line_width = 1;
    for (i = [1:3]) {
        translate([0, i*panel_width/4-line_width/2, 0]) {
            #cube([panel_width, line_width, 1]);
        }
    }
}


