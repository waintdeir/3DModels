use <../Dollo/NEW_long_ties/include.scad>;
use <common.scad>;


g3_8_d = 16.6;
g1_4_d = 13.3;

thread_slop = 0.4;


//debug();
adapter_g1_2_g1_4();
//adapter_g1_2_g1_4(threads=false);
//fitting_adapter_Eheim();

module adapter_g1_2_g1_4(threads=true) {

    // G1/2 outer, G1/4 inner
    difference() {
        union() {
            if (threads) {
                translate([0, 0, 5])
                g1_2_thread(
                    14.5, slop=0
                );
            } else {
                translate([0, 0, 5])
                cylinder(
                    d=20.9,
                    h=14.5,
                    $fn=40
                );
            }

            hexagon(22, height=5.7);
        }

        if (threads) {
            translate([0, 0, -1])
            g1_4_thread(
                12, slop=thread_slop
            );
        } else {
            translate([0, 0, -1])
            cylinder(
                d=13.5,
                h=12,
                $fn=40
            );
        }

        translate([0, 0, 10.9])
        cylinder(d=11.5, h=20, $fn=60);

        // chamfer
        translate([0, 0, -0.1])
        cylinder(d1=14.2, d2=12, h=1.1, $fn=40);
    }
}


module fitting_adapter_Eheim() {
    // G3/8 outer, G1/4 inner
    difference() {
        union() {
            cylinder(d=17.5, h=6, $fn=50);

            translate([0, 0, 5])
            g3_8_thread(
                10, slop=-thread_slop
            );

            cylinder(d=21, h=4, $fn=6);
        }

        intersection() {
            g1_4_thread(
                6, slop=thread_slop
            );

            cylinder(
                d1=11 + 2*6, d2=11,
                h=6, $fn=60
            );
        }
        cylinder(d=11, h=20, $fn=60);
    }
}

module debug() {
    intersection() {
        fitting_adapter_Eheim();

        translate([0, 30/2, 0])
        cube([30, 30, 60], center=true);
    }
}
