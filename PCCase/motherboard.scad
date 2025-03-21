use <../Dollo/NEW_long_ties/include.scad>;
use <../Dollo/NEW_long_ties/extention.scad>;
use <../Dollo/NEW_long_ties/long_tie.scad>;
use <../Dollo/NEW_long_ties/long_bow_tie.scad>;
include <../PCParts/common.scad>;
include <variables.scad>;
use <frame_parts.scad>;


//debug_motherboard_back_plates();
//debug_motherboard_ee_atx_parts();
//debug_motherboard_tray();
//debug_motherboard_io_cover();
//debug_motherboard_io_cover_top_offset();
//debug_motherboard_ee_atx_io_cover();
//debug_motherboard_card_cover();
//debug_motherboard_card_cover_top_offset();
//debug_motherboard_card_cover_ee_atx();

//motherboard_tray_atx(430);
//motherboard_tray_atx(430, render_threads=false);
//motherboard_tray_atx(500);
//motherboard_tray_atx(500, render_threads=false);
//motherboard_tray_ee_atx(540, render_threads=false);
//motherboard_tray_ee_atx(540, render_threads=true);
//motherboard_tray_ee_atx_1_1(540, render_threads=true);
//motherboard_tray_ee_atx_1_2(540, render_threads=true);
//motherboard_tray_ee_atx_2_1(540, render_threads=true);
//motherboard_tray_ee_atx_2_2(540, render_threads=true);

//motherboard_tray_mount_1();
//motherboard_tray_mount_2();
//motherboard_tray_mount_top_1();
//motherboard_tray_mount_top_2();
//motherboard_tray_mount_top_1(top_offset=28);
//motherboard_tray_mount_top_2(top_offset=28);
//motherboard_tray_long_bow_tie_half();

//motherboard_tray_screw();
//motherboard_tray_screw_reinforced();

//motherboard_back_plate(230, 480);
//motherboard_back_plate(230, 520);
//motherboard_back_plate(230, 520, top_offset=28);
//motherboard_back_plate_1(230, 480);
//motherboard_back_plate_2(230, 480);
//motherboard_back_plate_clip();
//motherboard_back_plate_clip(scaling=1.02);
//motherboard_io_cover(230);

//motherboard_back_plate_long_tie_half();

//motherboard_back_plate_ee_atx(240, 525);
//motherboard_back_plate_ee_atx(240, 550);
//motherboard_io_cover_ee_atx(240);

//motherboard_card_cover(230, 480);
//motherboard_card_cover(230, 520);
//motherboard_card_cover(240, 525);
//motherboard_card_cover(240, 550, ee_atx=true);


module debug_motherboard_back_plates() {
    intersection() {
        motherboard_back_plate_1(230, 480);

        translate([-1, 3, -1])
        cube([200, 200, 8]);
    }

    intersection() {
        motherboard_back_plate_2(230, 480);

//        translate([-1, 3, -1])
//        cube([400, 200, 7]);

        translate([-1, 0, -1])
        cube([309, 200, 14]);
    }

    %translate([200, -15.2, 15.4])
    rotate([0, 90, 0])
    extention(60/30, support=false);

    translate([308, -0.2, 15.4])
    rotate([180, 0, 90])
    motherboard_back_plate_clip();
}

module debug_motherboard_tray() {
    translate([0, 0, 300])
    rotate([0, 90, 0])
    motherboard_tray_atx(
        430, render_threads=debug_threads
    );

    translate([-15, -3, 26])
    rotate([0, -90, -90])
    motherboard_tray_mount_1();

    translate([-29, 9, 41])
    rotate([0, 90, 0])
    motherboard_tray_screw(
        render_threads=false
    );
}

module debug_motherboard_ee_atx_parts() {
    motherboard_tray_ee_atx_1_1(
        540, render_threads=false
    );
    motherboard_tray_ee_atx_1_2(
        540, render_threads=false
    );
    motherboard_tray_ee_atx_2_1(
        540, render_threads=false
    );
    motherboard_tray_ee_atx_2_2(
        540, render_threads=false
    );
}

module debug_motherboard_ee_atx_io_cover() {
    motherboard_back_plate_ee_atx(240, 550);

    translate([202.1/2 + 7.7, 117.5, 2])
    motherboard_io_cover_ee_atx(240);
}

module debug_motherboard_ee_atx_io_cover_top_offset() {
    motherboard_back_plate_ee_atx(240, 550);

    translate([202.1/2 + 7.7, 117.5, 2])
    motherboard_io_cover_ee_atx(240);
}

module debug_motherboard_io_cover_top_offset() {
    motherboard_back_plate(230, 520, top_offset=28);

    translate([
        (160 + 28)/2 + 7.7, 112.5, 2
    ])
    motherboard_io_cover(230, top_offset=28);
}

module debug_motherboard_card_cover() {
    motherboard_back_plate(230, 480);

    translate([245.5, 139.7, 10 + 6.4])
    rotate([0, 180, 0])
    motherboard_card_cover(230, 480);
}

module debug_motherboard_card_cover_top_offset() {
    motherboard_back_plate(230, 520, top_offset=28);

    translate([
        251.5 + 28, 139.7, 10 + 6.4
    ])
    rotate([0, 180, 0])
    motherboard_card_cover(230, 520, top_offset=28);
}

module debug_motherboard_card_cover_ee_atx() {

    motherboard_back_plate_ee_atx(240, 550);

    translate([301.5, 144.7, 10 + 6.4])
    rotate([0, 180, 0])
    intersection() {
        motherboard_card_cover_ee_atx(
            240, 550
        );

//        translate([200/2, 0, 0])
//        cube([200, 100, 100], center=true);
    }
}

module _joiner_form(w, d, h) {
    intersection() {
        rotate([45, 0, 0])
        cube([w, d, d], center=true);

        cube([w, d*2, h], center=true);
    }
}

module _mount_thread(h, render_threads) {
    if (render_threads) {
        v_screw(
            h=h + 2, screw_d=mount_screw_d + 0.3,
            pitch=mount_screw_pitch,
            direction=0, steps=100,
            depth=0.1, chamfer=false
        );
    } else {
        cylinder(d=mount_screw_d, h=h + 2, $fn=30);
    }

    translate([0, 0, -6])
    difference() {
        translate([0, 0, 10/2])
        chamfered_cube(20.4, 21, 10, 1.9, center=true);

        cube([13.6, 60, 30], center=true);

        translate([0, 0, 10 + 10/2 - 1.9])
        chamfered_cube(17, 60, 10, 1.9, center=true);

        // chamfers
        translate([0, 24/2, 13])
        rotate([45, 0, 0])
        cube([60, 15, 15], center=true);

        translate([0, -24/2, 13])
        rotate([45, 0, 0])
        cube([60, 15, 15], center=true);

    }
}

module _mount_stud() {
    cylinder(d=7, h=3.1, $fn=20);
}

module _mounts(h, hole_matrix) {
    difference() {
        union() {
            children();

            for(xy = hole_matrix) {
                translate([xy[0], xy[1], h - 0.1])
                _mount_stud();
            }
        }
        for(xy = hole_matrix) {
            translate([xy[0], xy[1], -0.1]) {
                cylinder(
                    d=3.5,h=h*4,
                    center=true,$fn=30
                );

                M3_nut(
                    h=h - 3, cone=false,
                    bridging=true
                );
            }
        }
    }
}

module motherboard_tray_atx(
    depth, render_threads=true,
    _render=true
) {

    h = motherboard_tray_h;

    module _mb() {
        difference() {
            union() {
                difference() {
                    _mounts(h, atx_mobo_holes)
                    translate([0, 5, 0])
                    rounded_cube_side(
                        atx_mobo_w - 8, atx_mobo_l - 6,
                        h, 10, $fn=40
                    );

                    translate([25, atx_mobo_l - 11, 0])
                    difference() {
                        union() {
                            rounded_cube_side(
                                120, 30, h + 2, 10, $fn=40
                            );

                            translate([-10, 5, 0])
                            cube([140, 20, h + 2]);
                        }
                        translate([-50, -30 + 10, 0])
                        rounded_cube_side(
                            50, 30, h + 2, 10, $fn=40
                        );
             
                        translate([120, -30 + 10, 0])
                        rounded_cube_side(
                            50, 30, h + 2, 10, $fn=40
                        );
                    }

                    translate([
                        atx_mobo_w - 30 - 90,
                        atx_mobo_l - 11, 0
                    ])
                    difference() {
                        union() {
                            rounded_cube_side(
                                90, 30, h + 2, 10, $fn=40
                            );

                            translate([-10, 5, 0])
                            cube([110, 20, h + 2]);
                        }
                        translate([-50, -30 + 10, 0])
                        rounded_cube_side(
                            50, 30, h + 2, 10, $fn=40
                        );

                        translate([90, -30 + 10, 0])
                        rounded_cube_side(
                            50, 30, h + 2, 10, $fn=40
                        );
                    }
                    translate([25, 25, 0])
                    rounded_cube_side(
                        125, 120, h + 2, 10, $fn=40
                    );

                    translate([25, atx_mobo_l - 70, 0])
                    rounded_cube_side(
                        125, 40, h + 2, 10, $fn=40
                    );

                    translate([atx_mobo_w - 30 - 95, 25, 0])
                    rounded_cube_side(
                        95, 120, h + 2, 10, $fn=40
                    );

                    translate([
                        atx_mobo_w - 30 - 95,
                        atx_mobo_l - 70, 0
                    ])
                    rounded_cube_side(
                        95, 40, h + 2, 10, $fn=40
                    );

                    // forced infill
                    #translate([13, -1, 2])
                    cube([0.1, atx_mobo_l + 2, 1]);

                    #translate([170, -1, 2])
                    cube([0.1, atx_mobo_l + 2, 1]);

                    #translate([atx_mobo_w - 22, -1, 2])
                    cube([0.1, atx_mobo_l + 2, 1]);

                    #translate([-1, 18, 2])
                    cube([atx_mobo_w + 2, 0.1, 1]);

                    #translate([-1, 159, 2])
                    cube([atx_mobo_w + 2, 0.1, 1]);

                    #translate([-1, atx_mobo_l - 20, 2])
                    cube([atx_mobo_w + 2, 0.1, 1]);
                }

                // mount hole bodies
                translate([44, 9, h/2])
                chamfered_cube_side(
                    26, 23, h, 3, center=true
                );

                translate([atx_mobo_w - 46, 9, h/2])
                chamfered_cube_side(
                    26, 23, h, 3, center=true
                );

                translate([44, depth - 215, h/2])
                chamfered_cube_side(
                    26, 23, h, 3, center=true
                );

                translate([
                    atx_mobo_w - 46, depth - 215,
                    h/2
                ])
                chamfered_cube_side(
                    26, 23, h, 3, center=true
                );

                hull() {
                    translate([44, depth - 215, h/2])
                    cube([26, 1, h], center=true);

                    translate([
                        44, atx_mobo_l - 20, h/2
                    ])
                    cube([50, 1, h], center=true);
                }

                hull() {
                    translate([
                        atx_mobo_w - 46, depth - 215, h/2
                    ])
                    cube([26, 1, h], center=true);

                    translate([
                        atx_mobo_w - 46,
                        atx_mobo_l - 20, h/2
                    ])
                    cube([50, 1, h], center=true);
                }
            }

            // mount holes
            translate([44, 9, 0])
            _mount_thread(h, render_threads);

            translate([atx_mobo_w - 46, 9, 0])
            _mount_thread(h, render_threads);

            translate([44, depth - 215, 0])
            _mount_thread(h, render_threads);

            translate([
                atx_mobo_w - 46, depth - 215, 0
            ])
            _mount_thread(h, render_threads);

        }
    }

    if (_render) {
        render()
        _mb();
    } else {
        _mb();
    }
}

module motherboard_tray_ee_atx(
    depth, render_threads=true,
    _render=true
) {

    h = motherboard_tray_h;

    module _mb() {
        difference() {
            union() {
                difference() {
                    _mounts(h, ee_atx_mobo_holes)
                    translate([1, 5, 0])
                    rounded_cube_side(
                        ee_atx_mobo_w - 6,
                        ee_atx_mobo_l - 6,
                        h, 10, $fn=40
                    );

                    // end indent 1
                    translate([25, ee_atx_mobo_l - 11, 0])
                    difference() {
                        union() {
                            rounded_cube_side(
                                70, 30, h + 2, 10, $fn=40
                            );

                            translate([-10, 5, 0])
                            cube([90, 20, h + 2]);
                        }
                        translate([-50, -30 + 10, 0])
                        rounded_cube_side(
                            50, 30, h + 2, 10, $fn=40
                        );
             
                        translate([70, -30 + 10, 0])
                        rounded_cube_side(
                            50, 30, h + 2, 10, $fn=40
                        );
                    }

                    // end indent 2
                    translate([126, ee_atx_mobo_l - 11, 0])
                    difference() {
                        union() {
                            rounded_cube_side(
                                108, 30, h + 2, 10, $fn=40
                            );

                            translate([-10, 5, 0])
                            cube([126, 20, h + 2]);
                        }
                        translate([-50, -30 + 10, 0])
                        rounded_cube_side(
                            50, 30, h + 2, 10, $fn=40
                        );
             
                        translate([108, -30 + 10, 0])
                        rounded_cube_side(
                            50, 30, h + 2, 10, $fn=40
                        );
                    }

                    // end indent 3
                    translate([
                        ee_atx_mobo_w - 30 - 50,
                        ee_atx_mobo_l - 11, 0
                    ])
                    difference() {
                        union() {
                            rounded_cube_side(
                                50, 30, h + 2, 10, $fn=40
                            );

                            translate([-10, 5, 0])
                            cube([70, 20, h + 2]);
                        }
                        translate([-50, -30 + 10, 0])
                        rounded_cube_side(
                            50, 30, h + 2, 10, $fn=40
                        );

                        translate([50, -30 + 10, 0])
                        rounded_cube_side(
                            50, 30, h + 2, 10, $fn=40
                        );
                    }

                    // large holes
                    translate([25, 25, 0])
                    rounded_cube_side(
                        130, 125, h + 2, 10, $fn=40
                    );

                    translate([25, ee_atx_mobo_l - 145, 0])
                    rounded_cube_side(
                        130, 115, h + 2, 10, $fn=40
                    );

                    translate([
                        ee_atx_mobo_w - 30 - 125,
                        25, 0
                    ])
                    rounded_cube_side(
                        125, 125, h + 2, 10, $fn=40
                    );

                    translate([
                        ee_atx_mobo_w - 30 - 125,
                        ee_atx_mobo_l - 145, 0
                    ])
                    difference() {
                        rounded_cube_side(
                            125, 115, h + 2, 10, $fn=40
                        );

                        translate([
                            125/2 - 20/2 - 3, -16/2, 0
                        ])
                        rounded_cube_side(
                            20, 16, h + 2, 6, $fn=40
                        );
                    }

                    // forced infill
                    #translate([14, -1, 2])
                    cube([0.1, ee_atx_mobo_l + 2, 1]);

                    #translate([160, -1, 2])
                    cube([0.1, ee_atx_mobo_l + 2, 1]);

                    #translate([186, -1, 2])
                    cube([0.1, ee_atx_mobo_l + 2, 1]);

                    #translate([ee_atx_mobo_w - 22, -1, 2])
                    cube([0.1, ee_atx_mobo_l + 2, 1]);

                    #translate([-1, 19, 2])
                    cube([ee_atx_mobo_w + 2, 0.1, 1]);

                    #translate([-1, 157, 2])
                    cube([ee_atx_mobo_w + 2, 0.1, 1]);

                    #translate([-1, 182, 2])
                    cube([ee_atx_mobo_w + 2, 0.1, 1]);

                    #translate([-1, ee_atx_mobo_l - 22, 2])
                    cube([ee_atx_mobo_w + 2, 0.1, 1]);
                }

                // mount hole bodies
                translate([44, 9, h/2])
                chamfered_cube_side(
                    26, 23, h, 3, center=true
                );

                translate([
                    ee_atx_mobo_w - 46, 9, h/2
                ])
                chamfered_cube_side(
                    26, 23, h, 3, center=true
                );

                translate([44, depth - 215, h/2])
                    chamfered_cube_side(
                        26, 23, h, 3, center=true
                );

                translate([
                        ee_atx_mobo_w - 46,
                        depth - 215, h/2
                    ])
                    chamfered_cube_side(
                        26, 23, h, 3, center=true
                );

                hull() {
                    translate([
                        44, depth - 215, h/2
                    ])
                    cube([26, 1, h], center=true);

                    translate([
                        44, ee_atx_mobo_l - 20, h/2
                    ])
                    cube([50, 1, h], center=true);
                }

                hull() {
                    translate([
                        ee_atx_mobo_w - 46,
                        depth - 215, h/2
                    ])
                    cube([26, 1, h], center=true);

                    translate([
                        ee_atx_mobo_w - 46,
                        ee_atx_mobo_l - 20, h/2
                    ])
                    cube([50, 1, h], center=true);
                }
            }

            // mount holes
            translate([44, 9, 0])
            _mount_thread(h, render_threads);

            translate([ee_atx_mobo_w - 46, 9, 0])
            _mount_thread(h, render_threads);

            translate([44, depth - 215, 0])
            _mount_thread(h, render_threads);

            translate([
                ee_atx_mobo_w - 46,
                depth - 215, 0
            ])
            _mount_thread(h, render_threads);
        }
    }

    if (_render) {
        render()
        _mb();
    } else {
        _mb();
    }
}

module _mb_joiner(length, scaling=1) {
    scale(scaling)
    intersection() {
        rotate([0, 45, 0])
        cube([15, length, 15], center=true);

        cube([
            100, 100, motherboard_tray_h
        ], center=true);
    }
}

// EE ATX part variables
ee_w1_1 = (ee_atx_mobo_w - 6)/2 - 2 + 12;
ee_w1_2 = ee_w1_1;
ee_w2_1 = (ee_atx_mobo_w - 6)/2 - 2;
ee_w2_2 = ee_w1_1;

ee_d1_1 = (ee_atx_mobo_l - 6)/2 - 2;
ee_d1_2 = ee_d1_1;
ee_d2_1 = ee_d1_1 + 15;
ee_d2_2 = ee_d1_2 + 15;


module motherboard_tray_ee_atx_1_1(
    depth, render_threads=true
) {

    intersection() {
        motherboard_tray_ee_atx(
            depth, render_threads
        );

        difference() {
            union() {
                translate([
                    ee_w1_1/2 - slop,
                    ee_d1_1/2 - 10/2, 0])
                cube([
                    ee_w1_1, ee_d1_1 + 10, 50],
                    center=true
                );

                translate([
                    23, ee_d1_1, motherboard_tray_h/2
                ])
                _mb_joiner(24);

                translate([
                    67, ee_d1_1, motherboard_tray_h/2
                ])
                _mb_joiner(24);

                translate([68, ee_d1_1 + 6, 0])
                cylinder(d=11, h=20);

                translate([
                    67 + 45, ee_d1_1, motherboard_tray_h/2
                ])
                _mb_joiner(24);

                translate([
                    67 + 45 + 40, ee_d1_1,
                    motherboard_tray_h/2
                ])
                _mb_joiner(24);
            }

            translate([
                ee_w1_1, 23, motherboard_tray_h/2
            ])
            rotate([0, 0, 90])
            _mb_joiner(25, 1.02);

            translate([
                ee_w1_1, 23 + 40, motherboard_tray_h/2
            ])
            rotate([0, 0, 90])
            _mb_joiner(25, 1.02);

            translate([
                ee_w1_1, 23 + 40*2, motherboard_tray_h/2
            ])
            rotate([0, 0, 90])
            _mb_joiner(25, 1.02);

            translate([
                ee_w1_1, 23 + 40*3, motherboard_tray_h/2
            ])
            rotate([0, 0, 90])
            _mb_joiner(25, 1.02);

            // bolt holes
            #translate([
                50, ee_d1_1 - 11.5,
                motherboard_tray_h/2
            ])
            rotate([-90, 0, 0]) {
                cylinder(d=3.3, h=60, $fn=30);

                rotate([0, 0, 30])
                M3_nut(6, cone=false);
            }

            #translate([
                ee_w1_1 - 50, ee_d1_1 - 11.5,
                motherboard_tray_h/2
            ])
            rotate([-90, 0, 0]) {
                cylinder(d=3.3, h=60, $fn=30);

                rotate([0, 0, 30])
                M3_nut(6, cone=false);
            }

            #translate([
                ee_w1_1 - 26.2, 45,
                motherboard_tray_h/2
            ])
            rotate([0, 90, 0]) {
                cylinder(d=3.3, h=60, $fn=30);

                M3_nut(6, cone=false);
            }

            #translate([
                ee_w1_1 - 26.2, ee_d1_1 - 40,
                motherboard_tray_h/2
            ])
            rotate([0, 90, 0]) {
                cylinder(d=3.3, h=60, $fn=30);

                M3_nut(6, cone=false);
            }
         }
    }

}

module motherboard_tray_ee_atx_1_2(
    depth, render_threads=true
) {

    intersection() {
        motherboard_tray_ee_atx(
            depth, render_threads
        );

        difference() {
            union() {
                translate([
                    ee_w1_1 + ee_w1_2/2,
                    ee_d1_2/2 - 10/2, 0
                ])
                cube([
                    ee_w1_2, ee_d1_2 + 10, 50],
                    center=true
                );

                translate([
                    ee_w1_1, 23,
                    motherboard_tray_h/2
                ])
                rotate([0, 0, 90])
                _mb_joiner(24);

                translate([
                    ee_w1_1, 23 + 40,
                    motherboard_tray_h/2
                ])
                rotate([0, 0, 90])
                _mb_joiner(24);

                translate([
                    ee_w1_1, 23 + 40*2,
                    motherboard_tray_h/2
                ])
                rotate([0, 0, 90])
                _mb_joiner(24);

                translate([
                    ee_w1_1, 23 + 40*3,
                    motherboard_tray_h/2
                ])
                rotate([0, 0, 90])
                _mb_joiner(24);

                translate([
                    ee_w1_1 + 18, ee_d1_2,
                    motherboard_tray_h/2
                ])
                _mb_joiner(24);

                translate([
                    ee_w1_1 + 62, ee_d1_2,
                    motherboard_tray_h/2
                ])
                _mb_joiner(24);

                translate([
                    ee_w1_1 + 62 + 45, ee_d1_2,
                    motherboard_tray_h/2
                ])
                _mb_joiner(24);

                translate([
                    ee_w1_1 + 62 + 45 + 40, ee_d1_2,
                    motherboard_tray_h/2
                ])
                _mb_joiner(24);
            }

            // bolt holes
            #translate([
                ee_w1_1 + 40, ee_d1_2 - 11.5,
                motherboard_tray_h/2
            ])
            rotate([-90, 0, 0]) {
                cylinder(d=3.3, h=60, $fn=30);

                rotate([0, 0, 30])
                M3_nut(6, cone=false);
            }

            #translate([
                ee_w1_1 + ee_w1_2 - 72,
                ee_d1_2 - 11.5,
                motherboard_tray_h/2
            ])
            rotate([-90, 0, 0]) {
                cylinder(d=3.3, h=60, $fn=30);

                rotate([0, 0, 30])
                M3_nut(6, cone=false);
            }

            #translate([
                ee_w1_1 + 12, 45,
                motherboard_tray_h/2
            ])
            rotate([0, -90, 0]) {
                cylinder(d=3.3, h=60, $fn=30);

                cylinder(d=6.6, h=4, $fn=30);
            }

            #translate([
                ee_w1_1 + 12, ee_d1_1 - 40,
                motherboard_tray_h/2
            ])
            rotate([0, -90, 0]) {
                cylinder(d=3.3, h=60, $fn=30);

                cylinder(d=6.6, h=4, $fn=30);
            }
        }
    }
}

module motherboard_tray_ee_atx_2_1(
    depth, render_threads=true
) {

    intersection() {
        motherboard_tray_ee_atx(
            depth, render_threads
        );

        difference() {
            union() {
                translate([
                    ee_w2_1/2,
                    ee_d2_1/2 + ee_d1_1 + slop, 0
                ])
                cube([ee_w2_1, ee_d2_1, 50], center=true);

                translate([
                    ee_w2_1, ee_d1_1 + 24,
                    motherboard_tray_h/2
                ])
                rotate([0, 0, 90])
                _mb_joiner(24);

                translate([
                    ee_w2_1, ee_d1_1 + 24 + 40,
                    motherboard_tray_h/2
                ])
                rotate([0, 0, 90])
                _mb_joiner(24);

                translate([
                    ee_w2_1, ee_d1_1 + 24 + 40*2,
                    motherboard_tray_h/2
                ])
                rotate([0, 0, 90])
                _mb_joiner(24);

                translate([
                    ee_w2_1, ee_d1_1 + 24 + 40*3,
                    motherboard_tray_h/2
                ])
                rotate([0, 0, 90])
                _mb_joiner(24);
             }

            translate([68, ee_d1_1 + 6, 0])
            cylinder(d=11, h=20);

            translate([
                23, ee_d1_1, motherboard_tray_h/2
            ])
            _mb_joiner(25, 1.02);

            translate([
                67, ee_d1_1, motherboard_tray_h/2
            ])
            _mb_joiner(25, 1.02);

            translate([
                67 + 45, ee_d1_1,
                motherboard_tray_h/2
            ])
            _mb_joiner(25, 1.02);

            translate([
                67 + 45 + 40, ee_d1_1,
                motherboard_tray_h/2
            ])
            _mb_joiner(25, 1.02);

            // bolt holes
            #translate([
                50, ee_d1_1 + 26.5,
                motherboard_tray_h/2
            ])
            rotate([90, 0, 0]) {
                cylinder(d=3.3, h=60, $fn=30);

                cylinder(d=6.6, h=4, $fn=30);
            }

            #translate([
                ee_w1_1 - 50, ee_d1_1 + 26.5,
                motherboard_tray_h/2
            ])
            rotate([90, 0, 0]) {
                cylinder(d=3.3, h=60, $fn=30);

                cylinder(d=6.6, h=4, $fn=30);
            }

            #translate([
                ee_w2_1 - 14.2, ee_d1_1 + 45,
                motherboard_tray_h/2
            ])
            rotate([0, 90, 0]) {
                cylinder(d=3.3, h=60, $fn=30);

                M3_nut(6, cone=false);
            }

            #translate([
                ee_w2_1 - 14.2,
                ee_d1_1 + ee_d2_1 - 55,
                motherboard_tray_h/2
            ])
            rotate([0, 90, 0]) {
                cylinder(d=3.3, h=60, $fn=30);

                M3_nut(6, cone=false);
            }
         }
    }
}

module motherboard_tray_ee_atx_2_2(
    depth, render_threads=true
) {

    intersection() {
        motherboard_tray_ee_atx(
            depth, render_threads
        );

        difference() {

            translate([
                ee_w2_1 + ee_w2_2/2 + slop,
                ee_d2_2/2 + ee_d1_2 + slop, 0
            ])
            cube([ee_w2_2, ee_d2_2, 50], center=true);

            translate([
                ee_w1_1 + 18, ee_d1_2,
                motherboard_tray_h/2
            ])
            _mb_joiner(25, 1.02);

            translate([
                ee_w1_1 + 62, ee_d1_2,
                motherboard_tray_h/2
            ])
            _mb_joiner(25, 1.02);

            translate([
                ee_w1_1 + 62 + 45, ee_d1_2,
                motherboard_tray_h/2
            ])
            _mb_joiner(25, 1.02);

            translate([
                ee_w1_1 + 62 + 45 + 40,
                ee_d1_2, motherboard_tray_h/2
            ])
            _mb_joiner(25, 1.02);

            translate([
                ee_w2_1, ee_d1_1 + 24,
                motherboard_tray_h/2
            ])
            rotate([0, 0, 90])
            _mb_joiner(25, 1.02);

            translate([
                ee_w2_1, ee_d1_1 + 24 + 40,
                motherboard_tray_h/2
            ])
            rotate([0, 0, 90])
            _mb_joiner(25, 1.02);

            translate([
                ee_w2_1, ee_d1_1 + 24 + 40*2,
                motherboard_tray_h/2
            ])
            rotate([0, 0, 90])
            _mb_joiner(25, 1.02);

            translate([
                ee_w2_1, ee_d1_1 + 24 + 40*3,
                motherboard_tray_h/2
            ])
            rotate([0, 0, 90])
            _mb_joiner(25, 1.02);

            // bolt holes
            #translate([
                ee_w2_1 + 24.1, ee_d1_1 + 45,
                motherboard_tray_h/2
            ])
            rotate([0, -90, 0]) {
                cylinder(d=3.3, h=60, $fn=30);

                cylinder(d=6.6, h=4, $fn=30);
            }

            #translate([
                ee_w2_1 + 24.1,
                ee_d1_1 + ee_d2_1 - 55,
                motherboard_tray_h/2
            ])
            rotate([0, -90, 0]) {
                cylinder(d=3.3, h=60, $fn=30);

                cylinder(d=6.6, h=4, $fn=30);
            }

            #translate([
                ee_w1_1 + 40, ee_d1_2 + 26.5,
                motherboard_tray_h/2
            ])
            rotate([90, 0, 0]) {
                cylinder(d=3.3, h=60, $fn=30);

                cylinder(d=6.6, h=4, $fn=30);
            }

            #translate([
                ee_w1_1 + ee_w1_2 - 72,
                ee_d1_2 + 26.5,
                motherboard_tray_h/2
            ])
            rotate([90, 0, 0]) {
                cylinder(d=3.3, h=60, $fn=30);

                cylinder(d=6.6, h=4, $fn=30);
            }
         }
    }
}

module motherboard_tray_mount_1() {
    difference() {
        union() {
            hull() {
                translate([0, 0, 10/2])
                cube([50, 15, 10], center=true);

                translate([50/2 - 20/2, 0, 19/2 + 2])
                cube([20, 15, 19], center=true);
            }

            translate([50/2 - 20/2, 18/2, 21/2])
            chamfered_cube_side(
                20, 18, 21, 1.2, center=true
            );

        }
        translate([-30, 0, -0.01])
        rotate([90, 0, 90])
        male_dovetail(60, bridge_extra=0.2);

        translate([50/2 - 20/2, 0, 18/2 + 3])
        rotate([-90, 30, 0])
        cylinder(
            d=mount_screw_d + 0.5, h=50,
            center=true, $fn=40
        );

        // mount groove
        translate([50/2 - 20/2, 15 + 10/2, 0])
        cube([14, 10, 80], center=true);

        translate([50/2 - 20/2, 18 + 10/2 - 1.2, 0])
        chamfered_cube_side(17, 10, 80, 1.5, center=true);

        // chamfers
        translate([0, 21, 0])
        rotate([45, 0, 0])
        cube([60, 15, 15], center=true);

        translate([0, 21, 24])
        rotate([45, 0, 0])
        cube([60, 15, 15], center=true);

    }
}

module motherboard_tray_mount_2() {
    mirror([1, 0, 0])
    motherboard_tray_mount_1();
}

module motherboard_tray_mount_top_1(top_offset=0) {
    difference() {
        union() {
            motherboard_tray_mount_1();

            translate([-top_offset/2 - 19, 0, 45/2])
            cube([50 + top_offset, 15, 45], center=true);
           
        }

        hull() {
            translate([-15 - top_offset, 0, 24])
            rotate([90, 0, 0])
            cylinder(d=20, h=60, center=true, $fn=30);

            translate([5.9, 0, 19.57])
            rotate([90, 0, 0])
            cylinder(d=2, h=60, center=true, $fn=80);

            translate([-top_offset/2, 0, 60])
            cube([90 + top_offset, 60, 1], center=true);
        }

        // chamfer
        translate([-50/2 - 19 - top_offset, 0, 0])
        rotate([0, 45, 0])
        cube([15, 60, 15], center=true);

        translate([-150, 0, -0.01])
        rotate([90, 0, 90])
        male_dovetail(400, bridge_extra=0.2);

        translate([-50/2 - 19.01  - top_offset, 0, 0])
        rotate([0, 0, -90])
        male_dovetail(100, bridge_extra=0.2);
        
    }
}

module motherboard_tray_mount_top_2(top_offset=0) {
    mirror([1, 0, 0])
    motherboard_tray_mount_top_1(top_offset=top_offset);
}

module motherboard_tray_screw(render_threads=true) {

    module _screw_thread() {
        if (render_threads) {
            v_screw(
                h=9, screw_d=mount_screw_d - 0.2,
                pitch=mount_screw_pitch,
                direction=0, steps=100,
                depth=0.1, chamfer=true
            );
        } else {
            cylinder(
                d=mount_screw_d - 0.2, h=9, $fn=30
            );
        }
    }

    difference() {
        union() {
            translate([0, 0, 6.5/2])
            hull() {
                cylinder(
                    d=17.7, h=5.1, center=true, $fn=6
                );
                cylinder(
                    d=15.7, h=6.5, center=true, $fn=6
                );
            }

            cylinder(
                d=mount_screw_d, h=6.5 + 22.3, $fn=30
            );

            translate([0, 0, 6.5 + 22.2])
            _screw_thread();
        }

        translate([0, 0, 1])
        cylinder(d=2, h=40, $fn=20);
    }
}

module motherboard_tray_screw_reinforced(
    render_threads=true
) {
    difference() {
        motherboard_tray_screw(
            render_threads=render_threads
        );

        cylinder(d=3.2, h=100, center=true, $fn=30);

        translate([0, 0, 6.5 + 22.2 + 9 - 2])
        cylinder(d1=3.2, d2=6, h=2.1, $fn=30);

        M3_nut(cone=false, bridging=true);
    }
}


module motherboard_back_plate(
    width, height, top_offset=0
) {

    w = height - 160;
    d = width - 60;

    gap = w - 320 - top_offset;

    module _main() {

        union() {
            translate([5.4 + top_offset, 3.4, 0])
            mobo_backplate();

            translate([w/2, 8/2, 12/2])
            cube([w, 8, 12], center=true);

            translate([
                w/2,
                -8/2 + d - 0.4, 12/2])
            cube([w, 8, 12], center=true);

            translate([
                10/2, (d - 0.4)/2, 12/2
            ])
            cube([10, d - 0.4, 12], center=true);

//            #translate([
//                -10/2 + 327.5 + top_offset,
//                119.8/2, 12/2
//            ])
//            cube([10, 119.8, 12], center=true);

            translate([
                -10/2 + w + 7.5,
                (d - 0.4)/2, 12/2
            ])
            cube([10, d - 0.4, 12], center=true);

            translate([
                327.5 + (10 + w - 327.5 - top_offset)/2
                - 10/2 + top_offset,
                119.8 - 6/2, 12/2
            ])
            cube([
                10 + w - 327.5 - top_offset,
                6, 12
            ], center=true);

            // middle beam
            translate([
                165.5 + 8/2 + top_offset,
                62.4 + (d - 70)/2,
                12/2
            ])
            cube([8, d - 70, 12], center=true);

            if (top_offset > 0) {
                translate([top_offset/2 + 7, 60, 12/2])
                cube([top_offset, 7, 12], center=true);

                translate([
                    (top_offset + 5)/2 + 3,
                    55/2 + 5, 1.6/2
                ])
                cube([
                    top_offset + 5, 55, 1.6
                ], center=true);
            }

            if (gap > 10) {
                translate([w - gap/2, 120/2, 1.6/2])
                cube([
                    w - 320 - top_offset,
                    119, 1.6
                ], center=true);
            }
        }
    }

    union() {
        difference() {
            _main();

            // outer
            translate([-0.2, d/2, 4])
            rotate([0, 0, -90])
            male_dovetail();

            translate([50, -0.2, 4])
            male_dovetail();

            translate([50, d - 0.2, 4])
            rotate([0, 0, 180])
            male_dovetail();

            translate([130, -0.2, 4])
            male_dovetail();

            translate([215, -0.2, 4])
            male_dovetail();

            translate([130, d - 0.2, 4])
            rotate([0, 0, 180])
            male_dovetail();

            translate([215, d - 0.2, 4])
            rotate([0, 0, 180])
            male_dovetail();

            translate([w - 15, -0.2, 4])
            male_dovetail();

            translate([w - 15, d - 0.2, 4])
            rotate([0, 0, 180])
            male_dovetail();

            // card slot
            translate([
                171.5 + (w - 172 - top_offset)/2
                + top_offset,
                115.7 + (d - 122)/2, 12
            ])
            cube([
                w - 172 - top_offset,
                d - 122, 4
            ], center=true);

            translate([
                w - 3.5,
                d - 4.4 - (d - 122)/2, 5
            ])
            rotate([0, 0, -90])
            male_dovetail();

            translate([
                174.5 + top_offset,
                d - 4.4 - (d - 122)/2,
                5
            ])
            rotate([0, 0, 90])
            male_dovetail();

            translate([205 + top_offset, d - 1.4 - 8, 5])
            rotate([0, 0, 0])
            male_dovetail();

            translate([w - 35, d - 1.4 - 8, 5])
            rotate([0, 0, 0])
            male_dovetail();

            // over I/O
            translate([
                7.5 + (160.5 + top_offset)/2,
                61 + (d - 67)/2,
                12/2 + 2
            ])
            cube([
                160.5 + top_offset,
                d - 67, 12
            ], center=true);

            // chamfers
            rotate([0, 0, -45])
            cube([30, 10, 30], center=true);

            translate([0, d - 0.4, 0])
            rotate([0, 0, 45])
            cube([30, 10, 30], center=true);

        }

        translate([205 + top_offset, 117.8, 12])
        rotate([90, 90, 0])
        _joiner_form(7.5, 10, 4);

        translate([w - 35, 117.8, 12])
        rotate([90, 90, 0])
        _joiner_form(7.5, 10, 4);

        // over I/O joiners
        translate([6, 61 + (d - 68)/2, 10/2])
        rotate([90, 0, 90])
        long_tie(10);

        translate([
            169.5 + top_offset,
            61 + (d - 68)/2, 10/2
        ])
        rotate([90, 0, -90])
        long_tie(10);

        translate([87.5 + top_offset/2, d - 4.5, 10/2])
        rotate([90, 0, 0])
        long_tie(10);

        translate([87.5 + top_offset/2, 59.5, 10/2])
        rotate([90, 0, 180])
        long_tie(10);
    }

//    %translate([60, 110, 10])
//    mock_fan_92mm();
}

module motherboard_back_plate_1(width, height) {
    difference() {
        intersection() {
            motherboard_back_plate(width, height);

            cube([165, 170, 15]);
        }

        translate([165, 8/2, 12/2])
        rotate([90, 0, 0])
        _joiner_form(30, 7, 4);

        translate([165, 8/2 + 53.2, 12/2])
        rotate([90, 0, 0])
        _joiner_form(30, 7, 4);

        translate([165, 170 - 8/2 + 0.3, 12/2])
        rotate([90, 0, 0])
        _joiner_form(30, 7, 3.4);
    }
}

module motherboard_back_plate_2(width, height) {
    difference() {
        union() {
            intersection() {
                motherboard_back_plate(width, height);

                translate([165.1, 0, 0])
                cube([175, 170, 15]);
            }

            translate([165 - 15/2 + 0.3, 8/2, 12/2])
            rotate([90, 0, 0])
            _joiner_form(15, 7 - slop, 4 - slop);

            translate([165 - 15/2 + 0.3, 8/2 + 53.2, 12/2])
            rotate([90, 0, 0])
            _joiner_form(15, 7 - slop, 4 - slop);

            translate([
                165 - 15/2 + 0.3, 170 - 8/2 + 0.3, 12/2
            ])
            rotate([90, 0, 0])
            _joiner_form(15, 7 - slop, 3.4 - slop);
        }

        // infill
        translate([165 - 15/2 + 0.5, 8/2, 4])
        cube([30, 0.2, 0.2], center=true);

        translate([165 - 15/2 + 0.5, 8/2, 6])
        cube([30, 0.2, 0.2], center=true);

        translate([165 - 15/2 + 0.5, 8/2, 8])
        cube([30, 0.2, 0.2], center=true);

        translate([165 - 15/2 + 0.5, 8/2 + 53.2, 4])
        cube([30, 0.2, 0.2], center=true);

        translate([165 - 15/2 + 0.5, 8/2 + 53.2, 6])
        cube([30, 0.2, 0.2], center=true);

        translate([165 - 15/2 + 0.5, 8/2 + 53.2, 8])
        cube([30, 0.2, 0.2], center=true);

        translate([165 - 15/2 + 0.5, 170 - 8/2 + 0.3, 4])
        cube([30, 0.2, 0.2], center=true);

        translate([165 - 15/2 + 0.5, 170 - 8/2 + 0.3, 6])
        cube([30, 0.2, 0.2], center=true);

        translate([165 - 15/2 + 0.5, 170 - 8/2 + 0.3, 8])
        cube([30, 0.2, 0.2], center=true);
    }

    // supports
    translate([165 - 15/2 - 0.5, 8/2, 1.4/2])
    cube([15, 2, 1.4], center=true);

    translate([165 - 15/2 - 0.5, 8/2 + 53.2, 1.4/2])
    cube([15, 2, 1.4], center=true);

    translate([165 - 15/2 - 0.5, 170 - 8/2 + 0.3, 1.4/2])
    cube([15, 2, 1.4], center=true);
}

module motherboard_back_plate_clip(scaling=1.0) {
    difference() {
        union() {
            difference() {
                long_bow_tie_half(30);

                translate([10/2, 0, 2/2 + 3.4])
                cube([10, 40, 2], center=true);
            }

            translate([6/2, 0, 3.4/2])
            cube([6, 30, 3.4], center=true);

            scale([1, scaling, 1])
            translate([0, 0, 11/2])
            rotate([90, 0, 90])
            long_tie(11);
        }

        translate([7, -30/2, 0])
        rotate([0, 0, -25])
        cube([10, 30, 10], center=true);

        translate([7, 30/2, 0])
        rotate([0, 0, 25])
        cube([10, 30, 10], center=true);
    }
}

module motherboard_back_plate_long_tie_half() {
    long_tie_half_30();
}

module motherboard_tray_long_bow_tie_half() {
    long_bow_tie_half_40();
}


module motherboard_back_plate_ee_atx(width, height) {
    w = height - 160;
    d = width - 60;

    motherboard_back_plate(
        width, height, top_offset=42
    );
}

module _motherboard_io_cover(width, top_offset=0) {

    w = 160 + top_offset;
    d = width - 60 - 67.4;
    f_d = d - 10;

    module _io_cover(fan_d) {
        echo(fan_d);
        difference() {
            translate([0, 0, 10/2])
            rounded_cube_side(
                w, d, 10, 3, center=true, $fn=30
            );

            translate([-1.9 - w/2, -0.5, -1.5])
            rotate([0, 0, -90])
            male_dovetail(15);

            translate([1.9 + w/2, -0.5, -1.5])
            rotate([0, 0, 90])
            male_dovetail(15);

            translate([-0.25, d/2 + 1.9, -1.5])
            rotate([0, 0, 180])
            male_dovetail(15);

            translate([-0.25, -d/2 - 1.9, -1.5])
            male_dovetail(15);

            difference() {
                translate([0, 0, 20/2 + 1.6])
                //cube([w - 6, d - 6, 20], center=true);
                chamfered_cube(w - 5, d - 5, 20, 2, center=true);

                translate([-w/2 - 1, -0.5, 0])
                rounded_cube_side(
                    12, 12, 40, 2, center=true, $fn=30
                );

                translate([w/2 + 1, -0.5, 0])
                rounded_cube_side(
                    12, 12, 40, 2, center=true, $fn=30
                );

                translate([-0.25, d/2 + 1, 0])
                rounded_cube_side(
                    12, 12, 40, 2, center=true, $fn=30
                );

                translate([-0.25, -d/2 - 1, 0])
                rounded_cube_side(
                    12, 12, 40, 2, center=true, $fn=30
                );
            }

            // fan hole
            translate([w/2 - fan_d/2 - 15, 0, 0])
            cylinder(
                d=fan_d, h=40, center=true,
                $fn=50
            );

            translate([w/2 - fan_d/2 - 15, 0, 0])
            fan_mount_holes(fan_d);

            %translate([w/2 - fan_d/2 - 15, 0, 25/2 + 1.6])
            cube([fan_d + 0.3, fan_d + 0.3, 25], center=true);
        }
    }
    
    if (f_d > 120 && f_d < 140) {
        _io_cover(120);
    } else if (f_d >= 100 && f_d < 120) {
        _io_cover(100);
    } else if (f_d >= 92 && f_d < 100) {
        _io_cover(92);
    } else if (f_d >= 80 && f_d < 92) {
        _io_cover(80);
    } else if (f_d >= 60 && f_d < 80) {
        _io_cover(60);
    }
}

module motherboard_io_cover(width, top_offset=0) {
    _motherboard_io_cover(width, top_offset=top_offset);
}

module motherboard_io_cover_ee_atx(width) {
    difference() {
        _motherboard_io_cover(width, ee_atx=true);

        // extra 92mm holes
        translate([202.1/2 - 100/2 - 15, 0, 0])
        fan_mount_holes(92);
    }
}

module motherboard_card_cover(
    width, height, top_offset=0
) {

    w = height - 160 - 172.5 - top_offset;
    d = width - 182.5;

    slit_count = floor((w - 15)/8);
    slit_offset = (w - 15)/(slit_count - 1);

    difference() {
        union() {
            translate([0, 0, 6.4/2])
            rounded_cube_side(
                w, d, 6.4, 3, center=true, $fn=30
            );

            translate([-w/2 + 2.5, 1.9, 10/2])
            rotate([90, 0, -90])
            long_tie(10);

            translate([w/2 - 2.5, 1.9, 10/2])
            rotate([90, 0, 90])
            long_tie(10);

            translate([w/2 - 33.25, d/2 - 2.65, 10/2])
            rotate([90, 0, 180])
            long_tie(10);

            translate([-w/2 + 34.25, d/2 - 2.65, 10/2])
            rotate([90, 0, 180])
            long_tie(10);

        }

        difference() {
            translate([0, 0, 20/2 + 1.6])
            chamfered_cube(
                w - 4, d - 4, 20,
                1, center=true
            );

            translate([-w/2 + 34.25, -d/2, 20/2])
            chamfered_cube(21, 11, 25, 4, center=true);

            translate([w/2 - 33.25, -d/2, 20/2])
            chamfered_cube(21, 11, 25, 4, center=true);
        }

        translate([-w/2 + 34.25, -d/2 + 4/2 - 0.15, 0.6 + 7.5/2])
        rotate([90, 90, 0])
        _joiner_form(7.5, 10.2, 4);

        translate([w/2 - 33.25, -d/2 + 4/2 - 0.15, 0.6 + 7.5/2])
        rotate([90, 90, 0])
        _joiner_form(7.5, 10.2, 4);

        // chamfers
        translate([-w/2 - 12, 0, 0])
        rotate([0, 45, 0])
        cube([20, d + 10, 20], center=true);

        translate([w/2 + 12, 0, 0])
        rotate([0, 45, 0])
        cube([20, d + 10, 20], center=true);

        translate([0, d/2 + 12, 0])
        rotate([45, 0, 0])
        cube([w + 10, 20, 20], center=true);

        for (i = [0: slit_count - 1]) {
            translate([
                -w/2  + 15/2 + i*slit_offset,
                0, 0])
            hull() {
                translate([2, d/2 - 10, 0])
                cylinder(
                    d=2, h=20,
                    center=true, $fn=20
                );

                translate([-2, -d/2 + 10, 0])
                cylinder(
                    d=2, h=20,
                    center=true, $fn=20
                );

            }
        }
    }
}

module motherboard_card_cover_ee_atx(
    width, height, top_offset=0
) {
    motherboard_card_cover(
        width, height, top_offset=42 + top_offset
    );
}