// Modulith (Jerrari Gen2) drawer insert generator
// Drop-in dividers for Modulith drawers, with or without a floor. Options follow Gridfinity Extended's
// basic cup where they apply (no lip, stacking, magnets or base pads).
//
// Cavity formulas measured from the v2609 "decor drawer" STLs (59-270 deep, 1W-4W, 0.5H-2H):
//   width = 88*W - 17    depth = D - 14    height (floor top to rim) = 56*H - 7.8
// Drawer floor 1.8 thick, square cavity corners, no inside fillets or ribs. 2H drawers thin the side
// walls 0.4 mm mid-height; the rim still gates at 88W-17. Case: rim-to-ceiling gap 0.8 mm; stopper pins
// in the center floor rib hang 2 mm below the ceiling.
//
// Axes: X = width, Y = depth (Y=0 is the drawer front), Z up. Origin = outer front-left-bottom.
// Separator positions and spans may be given as negative percentages of the inner span (-50 = 50%).

/* [Drawer] */
// Modulith depth series
drawer_depth = 240; // [59, 115, 165, 185, 240, 270]
// Drawer width in Modulith units (1-4 measured, others extrapolated)
drawer_width = 1; // 0.5
// Drawer height in Modulith units (0.5-2 measured, others extrapolated)
drawer_height = 1; // [0.5, 1, 1.5, 2, 2.5, 3]
// Insert height; 0 = as tall as the drawer allows (see Fit Tweaking for headroom)
height = 0; // 0.1
// Case stopper pins hang into the drawer; when fitted, stopper depth is added to the headroom
drawer_stoppers = true;
// Curve smoothness of the model: draft renders fastest, fine is smoothest (slower)
quality = "normal"; // [draft, normal, fine]

/* [Perimeter Walls and Floor] */
// Outer wall thickness, mm. 0 = no outer walls, just dividers
wall_thickness = 1.2; // 0.1
// Floor thickness, mm. 0 = no floor
floor_thickness = 1.0; // 0.1

/* [Subdivisions] */
// Equal pockets across the width (dividers run front to back)
vertical_chambers = 1;
// Equal pockets front to back (dividers run left to right)
horizontal_chambers = 1;
// Place front-to-back dividers yourself instead of equally
vertical_irregular_subdivisions = false;
// Each divider: position from the left inner wall, or [position, from, to] for a partial divider measured
// from the front inner wall (to = 0 reaches the back). Negative values are percentages: -50 = 50%.
vertical_separator_config = [20, 45];
// Place left-to-right dividers yourself instead of equally
horizontal_irregular_subdivisions = false;
// Each divider: position from the front inner wall, or [position, from, to] measured from the left inner wall
horizontal_separator_config = [60, 120];

/* [Label] */
// normal = a shelf to stick a label on; pred = socket for pred's printable snap-in labels (Printables 592545)
label_style = "disabled"; // [disabled, normal, pred]
// Where the label sits along the wall; the *chamber options give every pocket its own label
label_position = "left"; // [left, right, center, leftchamber, rightchamber, centerchamber]
// Label shelf: width (0 = full wall or pocket), depth, height (0 = same as depth), edge radius; mm
label_size = [0, 14, 0, 0.8]; // 0.1
// Pocket in the shelf: width, depth, pocket depth; mm. 0 = fit the stock 1U pred label (normal: 0 = no pocket)
label_relief = [0, 0, 0]; // 0.1
// Outer walls that get labels: front, back, left, right
label_walls = [0, 1, 0, 0]; // [0:1:1]
// Labels on dividers too: on the front face of left-to-right dividers, the left face of front-to-back ones
label_dividers = "disabled"; // [disabled, horizontal, vertical, both]

/* [Finger Slide] */
// Rounded or sloped fill where the floor meets a wall, so small parts slide out to your fingers
fingerslide = "none"; // [none, rounded, chamfered]
// Size of the slide, mm; negative = a fraction of the pocket (-3 = one third)
fingerslide_radius = -3;
// Sides of each pocket that get a slide: front, back, left, right
fingerslide_walls = [1, 0, 0, 0]; // [0:1:1]

/* [Wall Cutout] */
// Finger notches in left-to-right walls: outer front/back and/or the dividers between pocket rows
wallcutout_vertical = "disabled"; // [disabled, enabled, inneronly, wallsonly, frontonly, backonly]
// Finger notches in front-to-back walls: outer left/right and/or the dividers between pocket columns
wallcutout_horizontal = "disabled"; // [disabled, enabled, inneronly, wallsonly, leftonly, rightonly]
// Where along each pocket, mm from its start; -2 = centered (other negatives = a fraction)
wallcutout_position = -2; // 0.1
// Notch width at its bottom, mm; 0 = half the pocket
wallcutout_width = 0; // 0.1
// Slope of the notch sides, degrees from horizontal
wallcutout_angle = 70;
// Notch depth from the top, mm; 0 = halfway down, -1 = to the floor
wallcutout_height = 0; // 0.1
// Rounding of the notch corners, mm
wallcutout_corner_radius = 5; // 0.1

/* [Bottom Text] */
// Engrave the drawer size on the underside (needs a floor)
text_1 = false;
// Engrave your own line too
text_2 = false;
text_2_text = "";
// Letter height, mm; 0 = automatic
text_size = 0; // 0.1
// Engraving depth, mm
text_depth = 0.3; // 0.01
text_font = "Liberation Sans";

/* [Fit Tweaking] */
// Fit slack: total mm removed from the insert's width and depth
clearance = [0.4, 0.4]; // 0.1
// Gap kept between the insert top and the drawer rim when height is 0 or a %; stopper depth is added to it if stoppers are on
headroom = 1.0; // 0.1
// How far the case stopper reaches below the ceiling, mm (used when drawer stoppers is on)
stopper_depth = 2; // 0.1
// Divider thickness at the bottom and top, mm; a thinner top makes a tapered divider
chamber_wall_thickness = [1.2, 1.2]; // 0.1
// Dividers end this far below the insert top, mm
chamber_wall_headroom = 0; // 0.1

/* [OpenSCAD Detail] */
// Expert override of quality: OpenSCAD $fa / $fs / $fn; 0 = set by quality
fa = 0;
fs = 0;
fn = 0;

/* [Hidden] */
q = quality == "draft" ? [12, 1] : quality == "fine" ? [3, 0.2] : [6, 0.4];   // [$fa, $fs] per quality
$fa = fa > 0 ? fa : q[0]; $fs = fs > 0 ? fs : q[1]; $fn = fn;
eps = 0.01;

// ---------------------------------------------------------------- derived sizes
cavity = [88 * drawer_width - 17, drawer_depth - 14, 56 * drawer_height - 7.8];
W = cavity.x - clearance.x;
D = cavity.y - clearance.y;
head = headroom + (drawer_stoppers ? stopper_depth : 0);
H = height > 0 ? height : (cavity.z - head) * (height < 0 ? -height / 100 : 1);
wt = wall_thickness;
ft = floor_thickness;
iw = W - 2 * wt;           // inner cavity of the insert
id = D - 2 * wt;
cwb = chamber_wall_thickness[0];
cwtop = chamber_wall_thickness[1];
sep_top = H - chamber_wall_headroom;

// separator centerlines, relative to the inner cavity origin
function equal_seps(n, len) = [for (i = [1 : 1 : n - 1]) i * (len - (n - 1) * cwb) / n + (i - 0.5) * cwb];
function rel(v, len) = v < 0 ? -v / 100 * len : v;                                    // -50 -> 50% of len
function sep_pos(e, across) = rel(is_list(e) ? e[0] : e, across);
// OpenSCAD has no sort(): quicksort the separator entries by position so they can be listed in any order
function by_pos(v, across) = len(v) <= 1 ? v : let (p = sep_pos(v[0], across), rest = [for (i = [1 : 1 : len(v) - 1]) v[i]])
    concat(by_pos([for (e = rest) if (sep_pos(e, across) < p) e], across), [v[0]], by_pos([for (e = rest) if (sep_pos(e, across) >= p) e], across));
xcfg = by_pos(vertical_irregular_subdivisions ? vertical_separator_config : equal_seps(vertical_chambers, iw), iw);
ycfg = by_pos(horizontal_irregular_subdivisions ? horizontal_separator_config : equal_seps(horizontal_chambers, id), id);
function sep_span(e, len) = is_list(e) ? [rel(e[1], len), e[2] == 0 ? len : rel(e[2], len)] : [0, len];   // [from, to] along the separator
xs = [for (e = xcfg) sep_pos(e, iw)];
ys = [for (e = ycfg) sep_pos(e, id)];
// several separators may share a position (different spans); grid lines are the distinct positions
function uniq(v) = [for (i = [0 : 1 : len(v) - 1]) if (i == 0 || v[i] - v[i - 1] > 0.01) v[i]];
// pockets along one wall face: the face's span split only at crossing separators that actually reach it.
// cross: crossing separators' configs/positions, cross_len: their length axis, at: this face's position on that
// axis, lo..hi: this wall's own span.
function touches(sp, at) = sp[0] <= at + 0.01 && sp[1] >= at - 0.01;
function wall_cells(cross, cross_pos, cross_len, at, lo, hi) = let (
    cuts = uniq([for (i = [0 : 1 : len(cross) - 1]) if (touches(sep_span(cross[i], cross_len), at) && cross_pos[i] > lo && cross_pos[i] < hi) cross_pos[i]]),
    edges = concat([lo], [for (c = cuts) each [c - cwb / 2, c + cwb / 2]], [hi]))
    [for (i = [0 : 2 : len(edges) - 2]) [edges[i], edges[i + 1]]];
// ponytail: cols x rows is still the full grid (chamber-size echo, slide radius). Wall-attached features (labels,
// slides, cutouts) use wall_cells() below, which only splits a wall where a separator really meets it.
// chamber spans [start, end] between separator faces
function spans(seps, len) = [for (i = [0 : len(seps)])
    [i == 0 ? 0 : seps[i - 1] + cwb / 2, i == len(seps) ? len : seps[i] - cwb / 2]];
uxs = uniq(xs); uys = uniq(ys);
cols = spans(uxs, iw);
rows = spans(uys, id);
function gi(v, list) = [for (i = [0 : 1 : len(list) - 1]) if (abs(list[i] - v) <= 0.01) i][0];   // grid-line index of a position

assert(search(drawer_depth, [59, 115, 165, 185, 240, 270]) != [], "drawer_depth must be 59/115/165/185/240/270");
assert(iw > 0 && id > 0 && H > ft, "insert has no interior");
assert(min([for (c = cols) c[1] - c[0]]) > 0 && min([for (r = rows) r[1] - r[0]]) > 0, "a chamber has zero or negative width");
assert(cwtop <= cwb, "chamber_wall_thickness top must be <= bottom (prints without support)");
assert(min(concat([1], [for (e = xcfg) let (sp = sep_span(e, id)) sp[1] - sp[0]], [for (e = ycfg) let (sp = sep_span(e, iw)) sp[1] - sp[0]])) > 0, "partial separator: 'to' must be beyond 'from'");

echo(str("Modulith ", drawer_depth, " ", drawer_width, "W ", drawer_height, "H  cavity=", cavity,
         "  insert=", [W, D, H], "  headroom=", head, "  chambers X=", [for (c = cols) c[1] - c[0]], " Y=", [for (r = rows) r[1] - r[0]]));

// ---------------------------------------------------------------- helpers
// Place children defined along +X (wall face at y=0, growing into +y, base at z=0) onto a wall.
// side: 0 front(+y), 1 back(-y), 2 left(+x), 3 right(-x). a0 = start along the wall, face = wall face coord.
module on_wall(side, a0, face, z) {
    if (side == 0) translate([a0, face, z]) children();
    if (side == 1) translate([a0, face, z]) mirror([0, 1, 0]) children();
    if (side == 2) translate([face, a0, z]) mirror([1, 0, 0]) rotate([0, 0, 90]) children();
    if (side == 3) translate([face, a0, z]) rotate([0, 0, 90]) children();
}
module prism_x(len) rotate([90, 0, 90]) linear_extrude(len) children();   // 2D (y,z) profile swept along +X

// chamber-side geometry: face coordinate of a chamber (c = column index, r = row index) on each side
function face(side, c, r) = side == 0 ? wt + rows[r][0] : side == 1 ? wt + rows[r][1]
                          : side == 2 ? wt + cols[c][0] : wt + cols[c][1];
function along(side, c, r) = side < 2 ? cols[c] : rows[r];      // span along the wall
function across(side, c, r) = side < 2 ? rows[r] : cols[c];     // span perpendicular to the wall

// position of a label of width lw within a span of length len
function label_offset(len, lw) =
    label_position == "right" || label_position == "rightchamber" ? len - lw
  : label_position == "center" || label_position == "centerchamber" ? (len - lw) / 2 : 0;
label_per_chamber = label_position == "leftchamber" || label_position == "rightchamber" || label_position == "centerchamber";
label_d = label_size[1];
label_h = label_size[2] == 0 ? label_d : label_size[2] == -1 ? label_d * 3 / 4 : label_size[2];
function label_w(len) = label_size[0] > 0 ? min(label_size[0], len) : len;

// ---------------------------------------------------------------- parts
// Floor. ponytail: flat slab; swap this body for a Gridfinity base / magnet pockets later.
module floor_slab() cube([W, D, ft]);

module perimeter() if (wt > 0) difference() {
    cube([W, D, H]);
    translate([wt, wt, -eps]) cube([iw, id, H + 2 * eps]);
}

// tapered separator: hull of a bottom slab and a top slab
module separator(along_y, pos, len) {
    hull() {
        translate(along_y ? [wt + pos - cwb / 2, wt, ft] : [wt, wt + pos - cwb / 2, ft])
            cube(along_y ? [cwb, len, eps] : [len, cwb, eps]);
        translate(along_y ? [wt + pos - cwtop / 2, wt, sep_top - eps] : [wt, wt + pos - cwtop / 2, sep_top - eps])
            cube(along_y ? [cwtop, len, eps] : [len, cwtop, eps]);
    }
}
module separators() {
    for (e = xcfg) let (sp = sep_span(e, id)) translate([0, sp[0], 0]) separator(true, sep_pos(e, iw), sp[1] - sp[0]);
    for (e = ycfg) let (sp = sep_span(e, iw)) translate([sp[0], 0, 0]) separator(false, sep_pos(e, id), sp[1] - sp[0]);
}

// label tab: 45-degree triangle rounded by r (GFX shape). pred cuts its socket into the top face:
// rounded pocket for the label body + a 6.7 mm slot 1 mm longer each side for the 1.9 x 5.7 snap tabs
// (measured from GridfinityBinLabel_X1_12_Blank.step: 37.8 x 11.5 x 0.8 overall, body 34.0). GFX's socket
// shape, but fixed to the stock label instead of stretched to the shelf width; X numbers equal GFX's for a 1U shelf.
label_r = label_size[3];
pred = label_style == "pred";
// socket [width, depth(Y), pocket depth]. pred: stock label; normal: sticker recess, off unless a pocket depth is given
sock_z = label_relief[2] > 0 ? label_relief[2] : pred ? 1 : 0;
sock_y = label_relief[1] > 0 ? label_relief[1] : pred ? 11.8 : label_d - label_r - 1.3;
function sock_x(len) = label_relief[0] > 0 ? label_relief[0] : pred ? 36.2 : len - 2;
sock_pad = pred ? 2 : 1;                  // tab length needed beyond the pocket: slots (1 each side) + 1 mm margin, or just the margin
socketed = sock_z > 0;
assert(!socketed || 2 * label_r >= sock_z + 0.6, "label socket: raise label_size[3] to >= (pocket depth + 0.6) / 2");
assert(!socketed || label_d - label_r - 0.3 - sock_y >= 0.5, "label socket: label_size[1] must be >= socket depth + radius + 0.8");

// positive: 45-degree triangle rounded by r (GFX shape), 0.05 overlap into the walls at each end
// (a tab that only touches a wall face leaves CGAL an internal interface)
module label_tab(len) translate([-0.05, 0, 0]) prism_x(len + 0.1)
    translate([0, -label_r]) offset(r = label_r) polygon([[0, 0], [label_d - label_r, 0], [0, -label_h]]);

// negative: pocket in the tab's top face, placed left/center/right inside the tab like the tab inside its wall.
// pred adds the 6.7 mm slots 1 mm past the pocket for the label's 1.9 x 5.7 snap tabs.
module label_socket(len) if (socketed) {
    sx = sock_x(len);
    assert(len >= sx + 2 * sock_pad, str("label socket needs ", sx + 2 * sock_pad, " mm of tab; this tab is ", len, " mm"));
    translate([sock_pad + label_offset(len - 2 * sock_pad, sx), label_d - label_r - 0.3 - sock_y, -sock_z]) {
        linear_extrude(sock_z + eps) offset(r = 1) offset(delta = -1) square([sx, sock_y]);
        if (pred) translate([-1, (sock_y - 6.7) / 2, 0]) cube([sx + 2, 6.7, sock_z + eps]);
    }
}

// one placement loop for both parts: part = "tab" (union) or "socket" (subtracted after the union, so a
// separator running under a tab never fills the pocket back in)
module label_part(part, len) { if (part == "tab") label_tab(len); else label_socket(len); }
module labels(part) if (label_style != "disabled") {
    // outer walls
    for (side = [0 : 3]) if (label_walls[side] != 0) {
        wall_face = side == 0 ? wt : side == 1 ? wt + id : side == 2 ? wt : wt + iw;
        chambers = !label_per_chamber ? (side < 2 ? [[0, iw]] : [[0, id]])
                 : side == 0 ? wall_cells(xcfg, xs, id, 0, 0, iw) : side == 1 ? wall_cells(xcfg, xs, id, id, 0, iw)
                 : side == 2 ? wall_cells(ycfg, ys, iw, 0, 0, id) : wall_cells(ycfg, ys, iw, iw, 0, id);
        for (ch = chambers) let (len = ch[1] - ch[0], lw = label_w(len))
            on_wall(side, wt + ch[0] + label_offset(len, lw), wall_face, H) label_part(part, lw);
    }
    // separators: horizontal ones carry a tab on the -Y face, vertical ones on the -X face, along their own span
    if (label_dividers == "horizontal" || label_dividers == "both")
        for (i = [0 : 1 : len(ys) - 1]) let (sp = sep_span(ycfg[i], iw))
            for (ch = label_per_chamber ? wall_cells(xcfg, xs, id, ys[i], sp[0], sp[1]) : [sp]) let (len = ch[1] - ch[0], lw = label_w(len))
                on_wall(1, wt + ch[0] + label_offset(len, lw), wt + ys[i] - cwtop / 2, sep_top) label_part(part, lw);
    if (label_dividers == "vertical" || label_dividers == "both")
        for (i = [0 : 1 : len(xs) - 1]) let (sp = sep_span(xcfg[i], id))
            for (ch = label_per_chamber ? wall_cells(ycfg, ys, iw, xs[i], sp[0], sp[1]) : [sp]) let (len = ch[1] - ch[0], lw = label_w(len))
                on_wall(3, wt + ch[0] + label_offset(len, lw), wt + xs[i] - cwtop / 2, sep_top) label_part(part, lw);
}

module slide_profile(r) {
    if (fingerslide == "rounded") difference() { square(r); translate([r, r]) circle(r); }
    if (fingerslide == "chamfered") polygon([[0, 0], [r, 0], [0, r]]);
}
// one fillet per physical wall face along the wall's real extent (outer walls: full span; separators: their span),
// so a partial separator leaves no gap in the fillet of the chamber it does not reach. Radius comes from the
// grid cell behind the face. Fillets under a crossing wall simply merge into it.
function slide_r(depth) = let (hgt = sep_top - ft, want = fingerslide_radius > 0 ? fingerslide_radius : min(hgt, depth) / abs(fingerslide_radius))
    min(want, hgt, depth / 2);
module finger_slides() if (fingerslide != "none") {
    // walls running along X (sides 0 front / 1 back): [face y, span along x, cell depth]
    fx = concat(
        fingerslide_walls[0] ? concat([[wt, [0, iw], rows[0][1] - rows[0][0]]],
            [for (i = [0 : 1 : len(ycfg) - 1]) let (r = rows[gi(ys[i], uys) + 1]) [wt + ys[i] + cwb / 2, sep_span(ycfg[i], iw), r[1] - r[0]]]) : [],
        []);
    for (w = fx) on_wall(0, wt + w[1][0], w[0], ft) prism_x(w[1][1] - w[1][0]) slide_profile(slide_r(w[2]));
    bx = fingerslide_walls[1] ? concat([[wt + id, [0, iw], rows[len(rows) - 1][1] - rows[len(rows) - 1][0]]],
            [for (i = [0 : 1 : len(ycfg) - 1]) let (r = rows[gi(ys[i], uys)]) [wt + ys[i] - cwb / 2, sep_span(ycfg[i], iw), r[1] - r[0]]]) : [];
    for (w = bx) on_wall(1, wt + w[1][0], w[0], ft) prism_x(w[1][1] - w[1][0]) slide_profile(slide_r(w[2]));
    // walls running along Y (sides 2 left / 3 right)
    lx = fingerslide_walls[2] ? concat([[wt, [0, id], cols[0][1] - cols[0][0]]],
            [for (i = [0 : 1 : len(xcfg) - 1]) let (c = cols[gi(xs[i], uxs) + 1]) [wt + xs[i] + cwb / 2, sep_span(xcfg[i], id), c[1] - c[0]]]) : [];
    for (w = lx) on_wall(2, wt + w[1][0], w[0], ft) prism_x(w[1][1] - w[1][0]) slide_profile(slide_r(w[2]));
    rx = fingerslide_walls[3] ? concat([[wt + iw, [0, id], cols[len(cols) - 1][1] - cols[len(cols) - 1][0]]],
            [for (i = [0 : 1 : len(xcfg) - 1]) let (c = cols[gi(xs[i], uxs)]) [wt + xs[i] - cwb / 2, sep_span(xcfg[i], id), c[1] - c[0]]]) : [];
    for (w = rx) on_wall(3, wt + w[1][0], w[0], ft) prism_x(w[1][1] - w[1][0]) slide_profile(slide_r(w[2]));
}

// GFX WallCutout: trapezoid notch, angled sides, filleted bottom corners, origin at the wall top center
module wall_cutout(lowerWidth, wallAngle, hgt, thickness, cornerRadius) {
    topHeight = cornerRadius * 4;
    topWidth = lowerWidth + (hgt / tan(wallAngle)) * 2;
    rotate([90, 0, 0]) translate([0, 0, -thickness / 2]) linear_extrude(thickness) intersection() {
        translate([0, -hgt / 2 + topHeight / 2]) square([topWidth + cornerRadius * 2, hgt + topHeight], true);
        offset(r = -cornerRadius) offset(r = 2 * cornerRadius) offset(r = -cornerRadius) union() {
            translate([0, topHeight / 2]) square([topWidth * 2, topHeight], true);
            hull() {
                translate([0, topHeight / 2]) square([topWidth, topHeight], true);
                translate([0, -hgt / 2]) square([lowerWidth, hgt], true);
            }
        }
    }
}
// walls to notch: [centerline, thickness] lists for each direction
function pick(mode, outer_near, outer_far, inner, near_name, far_name) =
    mode == "disabled" ? [] :
    concat(mode == "enabled" || mode == "wallsonly" || mode == near_name ? outer_near : [],
           mode == "enabled" || mode == "inneronly" ? inner : [],
           mode == "enabled" || mode == "wallsonly" || mode == far_name ? outer_far : []);
// [centerline, thickness, pockets along the wall]
cut_walls_x = pick(wallcutout_vertical, wt > 0 ? [[wt / 2, wt, wall_cells(xcfg, xs, id, 0, 0, iw)]] : [],
                   wt > 0 ? [[D - wt / 2, wt, wall_cells(xcfg, xs, id, id, 0, iw)]] : [],
                   [for (i = [0 : 1 : len(ys) - 1]) let (sp = sep_span(ycfg[i], iw)) [wt + ys[i], cwb, wall_cells(xcfg, xs, id, ys[i], sp[0], sp[1])]],
                   "frontonly", "backonly");
cut_walls_y = pick(wallcutout_horizontal, wt > 0 ? [[wt / 2, wt, wall_cells(ycfg, ys, iw, 0, 0, id)]] : [],
                   wt > 0 ? [[W - wt / 2, wt, wall_cells(ycfg, ys, iw, iw, 0, id)]] : [],
                   [for (i = [0 : 1 : len(xs) - 1]) let (sp = sep_span(xcfg[i], id)) [wt + xs[i], cwb, wall_cells(ycfg, ys, iw, xs[i], sp[0], sp[1])]],
                   "leftonly", "rightonly");
wall_h = H - ft;
cut_h = wallcutout_height == 0 ? wall_h / 2 : wallcutout_height == -1 ? wall_h
      : wallcutout_height < 0 ? wall_h / abs(wallcutout_height) : wallcutout_height;
function cut_pos(len) = wallcutout_position == -2 ? len / 2
                      : wallcutout_position < 0 ? len / abs(wallcutout_position) : wallcutout_position;
function cut_w(len) = wallcutout_width > 0 ? wallcutout_width : len / 2;

module wall_cutouts() {
    for (w = cut_walls_x, ch = w[2]) let (len = ch[1] - ch[0])
        translate([wt + ch[0] + cut_pos(len), w[0], H])
            wall_cutout(cut_w(len), wallcutout_angle, cut_h, w[1] + 2 * eps, wallcutout_corner_radius);
    for (w = cut_walls_y, ch = w[2]) let (len = ch[1] - ch[0])
        translate([w[0], wt + ch[0] + cut_pos(len), H]) rotate([0, 0, 90])
            wall_cutout(cut_w(len), wallcutout_angle, cut_h, w[1] + 2 * eps, wallcutout_corner_radius);
}

module bottom_text() if (ft > 0 && (text_1 || text_2)) {
    line1 = str(drawer_depth, " ", drawer_width, "W ", drawer_height, "H");
    ts = text_size > 0 ? text_size : min(7, iw / (0.72 * max(len(line1), len(text_2_text))));
    translate([W / 2, D / 2, -eps]) mirror([1, 0, 0]) linear_extrude(text_depth + eps) {
        if (text_1) translate([0, text_2 ? ts * 0.7 : 0]) text(line1, size = ts, font = text_font, halign = "center", valign = "center");
        if (text_2) translate([0, text_1 ? -ts * 0.7 : 0]) text(text_2_text, size = ts, font = text_font, halign = "center", valign = "center");
    }
}

// ---------------------------------------------------------------- assembly
module insert() difference() {
    union() {
        if (ft > 0) floor_slab();
        perimeter();
        separators();
        labels("tab");
        finger_slides();
    }
    labels("socket");
    wall_cutouts();
    bottom_text();
}

insert();
