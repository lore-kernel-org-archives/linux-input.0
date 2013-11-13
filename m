From: Christopher Heiny <cheiny@synaptics.com>
Subject: [PATCH 04/04] input synaptics-rmi4: RMI4 F11 2D sensing
Date: Wed, 13 Nov 2013 15:39:32 -0800
Message-ID: <1384385972-1686-5-git-send-email-cheiny@synaptics.com>
References: <1384385972-1686-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:16061 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751035Ab3KMXkA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Nov 2013 18:40:00 -0500
In-Reply-To: <1384385972-1686-1-git-send-email-cheiny@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Christopher Heiny <cheiny@synaptics.com>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>

* eliminate packed struct bitfield definitions.

* removes sysfs/debugfs implementations.

* refactors register definitions into rmi_f11.h for use by external mod=
ules
implementing sysfs/debugfs control and debug functions.


Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus Walleij <linus.walleij@stericsson.com>
Cc: Joeri de Gram <j.de.gram@gmail.com>

---

 drivers/input/rmi4/rmi_f11.c | 1788 ++++++++--------------------------=
--------
 drivers/input/rmi4/rmi_f11.h |  547 +++++++++++++
 2 files changed, 874 insertions(+), 1461 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f11.c b/drivers/input/rmi4/rmi_f11.=
c
index 017c8ff..83a699d 100644
--- a/drivers/input/rmi4/rmi_f11.c
+++ b/drivers/input/rmi4/rmi_f11.c
@@ -8,19 +8,22 @@
  */
=20
 #define FUNCTION_DATA f11_data
+#define FUNCTION_NUMBER 0x11
=20
 #include <linux/kernel.h>
-#include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/fs.h>
 #include <linux/input.h>
 #include <linux/input/mt.h>
 #include <linux/kconfig.h>
 #include <linux/rmi.h>
 #include <linux/slab.h>
+#include <linux/uaccess.h>
+
 #include "rmi_driver.h"
+#include "rmi_f11.h"
=20
-#define F11_MAX_NUM_OF_SENSORS		8
 #define F11_MAX_NUM_OF_FINGERS		10
 #define F11_MAX_NUM_OF_TOUCH_SHAPES	16
=20
@@ -38,968 +41,21 @@
 #define DEFAULT_MAX_ABS_MT_ORIENTATION 1
 #define DEFAULT_MIN_ABS_MT_TRACKING_ID 1
 #define DEFAULT_MAX_ABS_MT_TRACKING_ID 10
-#define NAME_BUFFER_SIZE 256
-#define FUNCTION_NUMBER 0x11
-
-/** A note about RMI4 F11 register structure.
- *
- *  There may be one or more individual 2D touch surfaces associated w=
ith an
- * instance for F11.  For example, a handheld device might have a touc=
hscreen
- * display on the front, and a touchpad on the back.  F11 represents t=
hese touch
- * surfaces as individual sensors, up to 7 on a given RMI4 device.
- *
- * The properties for
- * a given sensor are described by its query registers.  The number of=
 query
- * registers and the layout of their contents are described by the F11=
 device
- * queries as well as the per-sensor query information.  The query reg=
isters
- * for sensor[n+1] immediately follow those for sensor[n], so the star=
t address
- * of the sensor[n+1] queries can only be computed if you know the siz=
e of the
- * sensor[n] queries.  Because each of the sensors may have different
- * properties, the size of the query registers for each sensor must be
- * calculated on a sensor by sensor basis.
- *
- * Similarly, each sensor has control registers that govern its behavi=
or.  The
- * size and layout of the control registers for a given sensor can be =
determined
- * by parsing that sensors query registers.  The control registers for
- * sensor[n+1] immediately follow those for sensor[n], so you can only=
 know
- * the start address for the sensor[n+1] controls if you know the size=
 (and
- * location) of the sensor[n] controls.
- *
- * And in a likewise fashion, each sensor has data registers where it =
reports
- * its touch data and other interesting stuff.  The size and layout of=
 a
- * sensors data registers must be determined by parsing its query regi=
sters.
- * The data registers for sensor[n+1] immediately follow those for sen=
sor[n],
- * so you can only know the start address for the sensor[n+1] controls=
 if you
- * know the size (and location) of the sensor[n] controls.
- *
- * The short story is that we need to read and parse a lot of query
- * registers in order to determine the attributes of a sensor[0].  The=
n
- * we need to use that data to compute the size of the control and dat=
a
- * registers for sensor[0].  Once we have that figured out, we can the=
n do
- * the same thing for each subsequent sensor.
- *
- * The end result is that we have a number of structs that aren't used=
 to
- * directly generate the input events, but their size, location and co=
ntents
- * are critical to determining where the data we are interested in liv=
es.
- *
- * At this time, the driver does not yet comprehend all possible F11
- * configuration options, but it should be sufficient to cover 99% of =
RMI4 F11
- * devices currently in the field.
- */
-
-/**
- * @rezero - writing 1 to this will cause the sensor to calibrate to t=
he
- * current capacitive state.
- */
-struct f11_2d_commands {
-	u8 rezero:1;
-	u8 reserved:7;
-} __attribute__((__packed__));
-
-/** This query is always present, and is on a per device basis.  All o=
ther
- * queries are on a per-sensor basis.
- *
- * @nbr_of_sensors - the number of 2D sensors on the touch device.
- * @has_query9 - indicates the F11_2D_Query9 register exists.
- * @has_query11 - indicates the F11_2D_Query11 register exists.
- * @has_query12 - indicates the F11_2D_Query12 register exists.
- */
-struct f11_2d_device_query {
-	u8 nbr_of_sensors:3;
-	u8 has_query9:1;
-	u8 has_query11:1;
-	u8 has_query12:1;
-	u8 has_query27:1;
-	u8 has_query28:1;
-} __attribute__((__packed__));
-
-/** Query registers 1 through 4 are always present.
- * @number_of_fingers - describes the maximum number of fingers the 2-=
D sensor
- * supports.
- * @has_rel - the sensor supports relative motion reporting.
- * @has_abs - the sensor supports absolute poition reporting.
- * @has_gestures - the sensor supports gesture reporting.
- * @has_sensitivity_adjust - the sensor supports a global sensitivity
- * adjustment.
- * @configurable - the sensor supports various configuration options.
- * @num_of_x_electrodes -  the maximum number of electrodes the 2-D se=
nsor
- * supports on the X axis.
- * @num_of_y_electrodes -  the maximum number of electrodes the 2-D se=
nsor
- * supports on the Y axis.
- * @max_electrodes - the total number of X and Y electrodes that may b=
e
- * configured.
- */
-struct f11_2d_sensor_info {
-	/* query1 */
-	u8 number_of_fingers:3;
-	u8 has_rel:1;
-	u8 has_abs:1;
-	u8 has_gestures:1;
-	u8 has_sensitivity_adjust:1;
-	u8 configurable:1;
-	/* query2 */
-	u8 num_of_x_electrodes:7;
-	u8 reserved_1:1;
-	/* query3 */
-	u8 num_of_y_electrodes:7;
-	u8 reserved_2:1;
-	/* query4 */
-	u8 max_electrodes:7;
-	u8 reserved_3:1;
-} __attribute__((__packed__));
-
-/** Query 5 - this is present if the has_abs bit is set.
- *
- * @abs_data_size - describes the format of data reported by the absol=
ute
- * data source.  Only one format (the kind used here) is supported at =
this
- * time.
- * @has_anchored_finger - then the sensor supports the high-precision =
second
- * finger tracking provided by the manual tracking and motion sensitiv=
ity
- * options.
- * @has_adjust_hyst - the difference between the finger release thresh=
old and
- * the touch threshold.
- * @has_dribble - the sensor supports the generation of dribble interr=
upts,
- * which may be enabled or disabled with the dribble control bit.
- * @has_bending_correction - Bending related data registers 28 and 36,=
 and
- * control register 52..57 are present.
- * @has_large_object_suppression - control register 58 and data regist=
er 28
- * exist.
- * @has_jitter_filter - query 13 and control 73..76 exist.
- */
-struct f11_2d_abs_info {
-	u8 abs_data_size:2;
-	u8 has_anchored_finger:1;
-	u8 has_adj_hyst:1;
-	u8 has_dribble:1;
-	u8 has_bending_correction:1;
-	u8 has_large_object_suppression:1;
-	u8 has_jitter_filter:1;
-} __attribute__((__packed__));
-
-/** Gesture information queries 7 and 8 are present if has_gestures bi=
t is set.
- *
- * @has_single_tap - a basic single-tap gesture is supported.
- * @has_tap_n_hold - tap-and-hold gesture is supported.
- * @has_double_tap - double-tap gesture is supported.
- * @has_early_tap - early tap is supported and reported as soon as the=
 finger
- * lifts for any tap event that could be interpreted as either a singl=
e tap
- * or as the first tap of a double-tap or tap-and-hold gesture.
- * @has_flick - flick detection is supported.
- * @has_press - press gesture reporting is supported.
- * @has_pinch - pinch gesture detection is supported.
- * @has_palm_det - the 2-D sensor notifies the host whenever a large c=
onductive
- * object such as a palm or a cheek touches the 2-D sensor.
- * @has_rotate - rotation gesture detection is supported.
- * @has_touch_shapes - TouchShapes are supported.  A TouchShape is a f=
ixed
- * rectangular area on the sensor that behaves like a capacitive butto=
n.
- * @has_scroll_zones - scrolling areas near the sensor edges are suppo=
rted.
- * @has_individual_scroll_zones - if 1, then 4 scroll zones are suppor=
ted;
- * if 0, then only two are supported.
- * @has_multi_finger_scroll - the multifinger_scrolling bit will be se=
t when
- * more than one finger is involved in a scrolling action.
- */
-struct f11_2d_gesture_info {
-	u8 has_single_tap:1;
-	u8 has_tap_n_hold:1;
-	u8 has_double_tap:1;
-	u8 has_early_tap:1;
-	u8 has_flick:1;
-	u8 has_press:1;
-	u8 has_pinch:1;
-	u8 has_chiral:1;
-
-	u8 has_palm_det:1;
-	u8 has_rotate:1;
-	u8 has_touch_shapes:1;
-	u8 has_scroll_zones:1;
-	u8 has_individual_scroll_zones:1;
-	u8 has_multi_finger_scroll:1;
-	u8 has_mf_edge_motion:1;
-	u8 has_mf_scroll_inertia:1;
-} __attribute__((__packed__));
-
-/** Utility for checking bytes in the gesture info registers.  This is=
 done
- * often enough that we put it here to declutter the conditionals.
- */
-static bool has_gesture_bits(const struct f11_2d_gesture_info *info,
-			     const u8 byte) {
-	return ((u8 *) info)[byte] !=3D 0;
-}
-
-/**
- * @has_pen - detection of a stylus is supported and registers F11_2D_=
Ctrl20
- * and F11_2D_Ctrl21 exist.
- * @has_proximity - detection of fingers near the sensor is supported =
and
- * registers F11_2D_Ctrl22 through F11_2D_Ctrl26 exist.
- * @has_palm_det_sensitivity -  the sensor supports the palm detect se=
nsitivity
- * feature and register F11_2D_Ctrl27 exists.
- * @has_two_pen_thresholds - is has_pen is also set, then F11_2D_Ctrl3=
5 exists.
- * @has_contact_geometry - the sensor supports the use of contact geom=
etry to
- * map absolute X and Y target positions and registers F11_2D_Data18.*=
 through
- * F11_2D_Data27 exist.
- */
-struct f11_2d_query9 {
-	u8 has_pen:1;
-	u8 has_proximity:1;
-	u8 has_palm_det_sensitivity:1;
-	u8 has_suppress_on_palm_detect:1;
-	u8 has_two_pen_thresholds:1;
-	u8 has_contact_geometry:1;
-	u8 has_pen_hover_discrimination:1;
-	u8 has_pen_filters:1;
-} __attribute__((__packed__));
-
-/** Touch shape info (query 10) is present if has_touch_shapes is set.
- *
- * @nbr_touch_shapes - the total number of touch shapes supported.
- */
-struct f11_2d_ts_info {
-	u8 nbr_touch_shapes:5;
-	u8 reserved:3;
-} __attribute__((__packed__));
-
-/** Query 11 is present if the has_query11 bit is set in query 0.
- *
- * @has_z_tuning - if set, the sensor supports Z tuning and registers
- * F11_2D_Ctrl29 through F11_2D_Ctrl33 exist.
- * @has_algorithm_selection - controls choice of noise suppression alg=
orithm
- * @has_w_tuning - the sensor supports Wx and Wy scaling and registers
- * F11_2D_Ctrl36 through F11_2D_Ctrl39 exist.
- * @has_pitch_info - the X and Y pitches of the sensor electrodes can =
be
- * configured and registers F11_2D_Ctrl40 and F11_2D_Ctrl41 exist.
- * @has_finger_size -  the default finger width settings for the
- * sensor can be configured and registers F11_2D_Ctrl42 through F11_2D=
_Ctrl44
- * exist.
- * @has_segmentation_aggressiveness - the sensor=E2=80=99s ability to =
distinguish
- * multiple objects close together can be configured and register F11_=
2D_Ctrl45
- * exists.
- * @has_XY_clip -  the inactive outside borders of the sensor can be
- * configured and registers F11_2D_Ctrl46 through F11_2D_Ctrl49 exist.
- * @has_drumming_filter - the sensor can be configured to distinguish
- * between a fast flick and a quick drumming movement and registers
- * F11_2D_Ctrl50 and F11_2D_Ctrl51 exist.
- */
-struct f11_2d_query11 {
-	u8 has_z_tuning:1;
-	u8 has_algorithm_selection:1;
-	u8 has_w_tuning:1;
-	u8 has_pitch_info:1;
-	u8 has_finger_size:1;
-	u8 has_segmentation_aggressiveness:1;
-	u8 has_XY_clip:1;
-	u8 has_drumming_filter:1;
-} __attribute__((__packed__));
-
-/**
- * @has_gapless_finger - control registers relating to gapless finger =
are
- * present.
- * @has_gapless_finger_tuning - additional control and data registers =
relating
- * to gapless finger are present.
- * @has_8bit_w - larger W value reporting is supported.
- * @has_adjustable_mapping - TBD
- * @has_info2 - the general info query14 is present
- * @has_physical_props - additional queries describing the physical pr=
operties
- * of the sensor are present.
- * @has_finger_limit - indicates that F11 Ctrl 80 exists.
- * @has_linear_coeff - indicates that F11 Ctrl 81 exists.
- */
-struct f11_2d_query12 {
-	u8 has_gapless_finger:1;
-	u8 has_gapless_finger_tuning:1;
-	u8 has_8bit_w:1;
-	u8 has_adjustable_mapping:1;
-	u8 has_info2:1;
-	u8 has_physical_props:1;
-	u8 has_finger_limit:1;
-	u8 has_linear_coeff_2:1;
-} __attribute__((__packed__));
-
-/** This register is present if Query 5's has_jitter_filter bit is set=
=2E
- * @jitter_window_size - used by Design Studio 4.
- * @jitter_filter_type - used by Design Studio 4.
- */
-struct f11_2d_query13 {
-	u8 jtter_window_size:5;
-	u8 jitter_filter_type:2;
-	u8 reserved:1;
-} __attribute__((__packed__));
-
-/** This register is present if query 12's has_general_info2 flag is s=
et.
- *
- * @light_control - Indicates what light/led control features are pres=
ent, if
- * any.
- * @is_clear - if set, this is a clear sensor (indicating direct point=
ing
- * application), otherwise it's opaque (indicating indirect pointing).
- * @clickpad_props - specifies if this is a clickpad, and if so what s=
ort of
- * mechanism it uses
- * @mouse_buttons - specifies the number of mouse buttons present (if =
any).
- * @has_advanced_gestures - advanced driver gestures are supported.
- */
-struct f11_2d_query14 {
-	u8 light_control:2;
-	u8 is_clear:1;
-	u8 clickpad_props:2;
-	u8 mouse_buttons:2;
-	u8 has_advanced_gestures:1;
-} __attribute__((__packed__));
-
-#define F11_LIGHT_CTL_NONE 0x00
-#define F11_LUXPAD	   0x01
-#define F11_DUAL_MODE      0x02
-
-#define F11_NOT_CLICKPAD     0x00
-#define F11_HINGED_CLICKPAD  0x01
-#define F11_UNIFORM_CLICKPAD 0x02
-
-/** See notes above for information about specific query register sets=
=2E
- */
-struct f11_2d_sensor_queries {
-	struct f11_2d_sensor_info info;
-	struct f11_2d_abs_info abs_info;
-	u8 f11_2d_query6;
-	struct f11_2d_gesture_info gesture_info;
-	struct f11_2d_query9 query9;
-	struct f11_2d_ts_info ts_info;
-	struct f11_2d_query11 features_1;
-	struct f11_2d_query12 features_2;
-	struct f11_2d_query13 jitter_filter;
-	struct f11_2d_query14 info_2;
-};
-
-/**
- * @reporting_mode - controls how often finger position data is report=
ed.
- * @abs_pos_filt - when set, enables various noise and jitter filterin=
g
- * algorithms for absolute reports.
- * @rel_pos_filt - when set, enables various noise and jitter filterin=
g
- * algorithms for relative reports.
- * @rel_ballistics - enables ballistics processing for the relative fi=
nger
- * motion on the 2-D sensor.
- * @dribble - enables the dribbling feature.
- * @report_beyond_clip - when this is set, fingers outside the active =
area
- * specified by the x_clip and y_clip registers will be reported, but =
with
- * reported finger position clipped to the edge of the active area.
- * @palm_detect_thresh - the threshold at which a wide finger is consi=
dered a
- * palm. A value of 0 inhibits palm detection.
- * @motion_sensitivity - specifies the threshold an anchored finger mu=
st move
- * before it is considered no longer anchored.  High values mean more
- * sensitivity.
- * @man_track_en - for anchored finger tracking, whether the host (1) =
or the
- * device (0) determines which finger is the tracked finger.
- * @man_tracked_finger - when man_track_en is 1, specifies whether fin=
ger 0 or
- * finger 1 is the tracked finger.
- * @delta_x_threshold - 2-D position update interrupts are inhibited u=
nless
- * the finger moves more than a certain threshold distance along the X=
 axis.
- * @delta_y_threshold - 2-D position update interrupts are inhibited u=
nless
- * the finger moves more than a certain threshold distance along the Y=
 axis.
- * @velocity - When rel_ballistics is set, this register defines the
- * velocity ballistic parameter applied to all relative motion events.
- * @acceleration - When rel_ballistics is set, this register defines t=
he
- * acceleration ballistic parameter applied to all relative motion eve=
nts.
- * @sensor_max_x_pos - the maximum X coordinate reported by the sensor=
=2E
- * @sensor_max_y_pos - the maximum Y coordinate reported by the sensor=
=2E
- */
-struct f11_2d_ctrl0_9 {
-	/* F11_2D_Ctrl0 */
-	u8 reporting_mode:3;
-	u8 abs_pos_filt:1;
-	u8 rel_pos_filt:1;
-	u8 rel_ballistics:1;
-	u8 dribble:1;
-	u8 report_beyond_clip:1;
-	/* F11_2D_Ctrl1 */
-	u8 palm_detect_thres:4;
-	u8 motion_sensitivity:2;
-	u8 man_track_en:1;
-	u8 man_tracked_finger:1;
-	/* F11_2D_Ctrl2 and 3 */
-	u8 delta_x_threshold:8;
-	u8 delta_y_threshold:8;
-	/* F11_2D_Ctrl4 and 5 */
-	u8 velocity:8;
-	u8 acceleration:8;
-	/* F11_2D_Ctrl6 thru 9 */
-	u16 sensor_max_x_pos:12;
-	u8 ctrl7_reserved:4;
-	u16 sensor_max_y_pos:12;
-	u8 ctrl9_reserved:4;
-} __attribute__((__packed__));
-
-/**
- * @single_tap_int_enable - enable tap gesture recognition.
- * @tap_n_hold_int_enable - enable tap-and-hold gesture recognition.
- * @double_tap_int_enable - enable double-tap gesture recognition.
- * @early_tap_int_enable - enable early tap notification.
- * @flick_int_enable - enable flick detection.
- * @press_int_enable - enable press gesture recognition.
- * @pinch_int_enable - enable pinch detection.
- */
-struct f11_2d_ctrl10 {
-	u8 single_tap_int_enable:1;
-	u8 tap_n_hold_int_enable:1;
-	u8 double_tap_int_enable:1;
-	u8 early_tap_int_enable:1;
-	u8 flick_int_enable:1;
-	u8 press_int_enable:1;
-	u8 pinch_int_enable:1;
-	u8 reserved:1;
-} __attribute__((__packed__));
-
-/**
- * @palm_detect_int_enable - enable palm detection feature.
- * @rotate_int_enable - enable rotate gesture detection.
- * @touch_shape_int_enable - enable the TouchShape feature.
- * @scroll_zone_int_enable - enable scroll zone reporting.
- * @multi_finger_scroll_int_enable - enable the multfinger scroll feat=
ure.
- */
-struct f11_2d_ctrl11 {
-	u8 palm_detect_int_enable:1;
-	u8 rotate_int_enable:1;
-	u8 touch_shape_int_enable:1;
-	u8 scroll_zone_int_enable:1;
-	u8 multi_finger_scroll_int_enable:1;
-	u8 reserved:3;
-} __attribute__((__packed__));
-
-/**
- * @sens_adjustment - allows a host to alter the overall sensitivity o=
f a
- * 2-D sensor. A positive value in this register will make the sensor =
more
- * sensitive than the factory defaults, and a negative value will make=
 it
- * less sensitive.
- * @hyst_adjustment - increase the touch/no-touch hysteresis by 2 Z-un=
its for
- * each one unit increment in this setting.
- */
-struct f11_2d_ctrl14 {
-	s8 sens_adjustment:5;
-	u8 hyst_adjustment:3;
-} __attribute__((__packed__));
-
-/**
- * @max_tap_time - the maximum duration of a tap, in 10-millisecond un=
its.
- */
-struct f11_2d_ctrl15 {
-	u8 max_tap_time:8;
-} __attribute__((__packed__));
-
-/**
- * @min_press_time - The minimum duration required for stationary fing=
er(s) to
- * generate a press gesture, in 10-millisecond units.
- */
-struct f11_2d_ctrl16 {
-	u8 min_press_time:8;
-} __attribute__((__packed__));
-
-/**
- * @max_tap_distance - Determines the maximum finger movement allowed =
during
- * a tap, in 0.1-millimeter units.
- */
-struct f11_2d_ctrl17 {
-	u8 max_tap_distance:8;
-} __attribute__((__packed__));
-
-/**
- * @min_flick_distance - the minimum finger movement for a flick gestu=
re,
- * in 1-millimeter units.
- * @min_flick_speed - the minimum finger speed for a flick gesture, in
- * 10-millimeter/second units.
- */
-struct f11_2d_ctrl18_19 {
-	u8 min_flick_distance:8;
-	u8 min_flick_speed:8;
-} __attribute__((__packed__));
-
-/**
- * @pen_detect_enable - enable reporting of stylus activity.
- * @pen_jitter_filter_enable - Setting this enables the stylus anti-ji=
tter
- * filter.
- * @pen_z_threshold - This is the stylus-detection lower threshold. Sm=
aller
- * values result in higher sensitivity.
- */
-struct f11_2d_ctrl20_21 {
-	u8 pen_detect_enable:1;
-	u8 pen_jitter_filter_enable:1;
-	u8 ctrl20_reserved:6;
-	u8 pen_z_threshold:8;
-} __attribute__((__packed__));
-
-/**
- * These are not accessible through sysfs yet.
- *
- * @proximity_detect_int_en - enable proximity detection feature.
- * @proximity_jitter_filter_en - enables an anti-jitter filter on prox=
imity
- * data.
- * @proximity_detection_z_threshold - the threshold for finger-proximi=
ty
- * detection.
- * @proximity_delta_x_threshold - In reduced-reporting modes, this is =
the
- * threshold for proximate-finger movement in the direction parallel t=
o the
- * X-axis.
- * @proximity_delta_y_threshold - In reduced-reporting modes, this is =
the
- * threshold for proximate-finger movement in the direction parallel t=
o the
- * Y-axis.
- * * @proximity_delta_Z_threshold - In reduced-reporting modes, this i=
s the
- * threshold for proximate-finger movement in the direction parallel t=
o the
- * Z-axis.
- */
-struct f11_2d_ctrl22_26 {
-	/* control 22 */
-	u8 proximity_detect_int_en:1;
-	u8 proximity_jitter_filter_en:1;
-	u8 f11_2d_ctrl6_b3__7:6;
-
-	/* control 23 */
-	u8 proximity_detection_z_threshold;
-
-	/* control 24 */
-	u8 proximity_delta_x_threshold;
-
-	/* control 25 */
-	u8 proximity_delta_y_threshold;
-
-	/* control 26 */
-	u8 proximity_delta_z_threshold;
-} __attribute__((__packed__));
-
-/**
- * @palm_detecy_sensitivity - When this value is small, smaller object=
s will
- * be identified as palms; when this value is large, only larger objec=
ts will
- * be identified as palms. 0 represents the factory default.
- * @suppress_on_palm_detect - when set, all F11 interrupts except palm=
_detect
- * are suppressed while a palm is detected.
- */
-struct f11_2d_ctrl27 {
-	s8 palm_detect_sensitivity:4;
-	u8 suppress_on_palm_detect:1;
-	u8 f11_2d_ctrl27_b5__7:3;
-} __attribute__((__packed__));
-
-/**
- * @multi_finger_scroll_mode - allows choice of multi-finger scroll mo=
de and
- * determines whether and how X or Y displacements are reported.
- * @edge_motion_en - enables the edge_motion feature.
- * @multi_finger_scroll_momentum - controls the length of time that sc=
rolling
- * continues after fingers have been lifted.
- */
-struct f11_2d_ctrl28 {
-	u8 multi_finger_scroll_mode:2;
-	u8 edge_motion_en:1;
-	u8 f11_2d_ctrl28b_3:1;
-	u8 multi_finger_scroll_momentum:4;
-} __attribute__((__packed__));
-
-/**
- * @z_touch_threshold - Specifies the finger-arrival Z threshold. Larg=
e values
- * may cause smaller fingers to be rejected.
- * @z_touch_hysteresis - Specifies the difference between the finger-a=
rrival
- * Z threshold and the finger-departure Z threshold.
- */
-struct f11_2d_ctrl29_30 {
-	u8 z_touch_threshold;
-	u8 z_touch_hysteresis;
-} __attribute__((__packed__));
-
-
-struct f11_2d_ctrl {
-	struct f11_2d_ctrl0_9		 *ctrl0_9;
-	u16				ctrl0_9_address;
-	struct f11_2d_ctrl10		*ctrl10;
-	struct f11_2d_ctrl11		*ctrl11;
-	u8				ctrl12_size;
-	struct f11_2d_ctrl14		*ctrl14;
-	struct f11_2d_ctrl15		*ctrl15;
-	struct f11_2d_ctrl16		*ctrl16;
-	struct f11_2d_ctrl17		*ctrl17;
-	struct f11_2d_ctrl18_19		*ctrl18_19;
-	struct f11_2d_ctrl20_21		*ctrl20_21;
-	struct f11_2d_ctrl22_26		*ctrl22_26;
-	struct f11_2d_ctrl27		*ctrl27;
-	struct f11_2d_ctrl28		*ctrl28;
-	struct f11_2d_ctrl29_30		*ctrl29_30;
-};
-
-/**
- * @x_msb - top 8 bits of X finger position.
- * @y_msb - top 8 bits of Y finger position.
- * @x_lsb - bottom 4 bits of X finger position.
- * @y_lsb - bottom 4 bits of Y finger position.
- * @w_y - contact patch width along Y axis.
- * @w_x - contact patch width along X axis.
- * @z - finger Z value (proxy for pressure).
- */
-struct f11_2d_data_1_5 {
-	u8 x_msb;
-	u8 y_msb;
-	u8 x_lsb:4;
-	u8 y_lsb:4;
-	u8 w_y:4;
-	u8 w_x:4;
-	u8 z;
-} __attribute__((__packed__));
-
-/**
- * @delta_x - relative motion along X axis.
- * @delta_y - relative motion along Y axis.
- */
-struct f11_2d_data_6_7 {
-	s8 delta_x;
-	s8 delta_y;
-} __attribute__((__packed__));
-
-/**
- * @single_tap - a single tap was recognized.
- * @tap_and_hold - a tap-and-hold gesture was recognized.
- * @double_tap - a double tap gesture was recognized.
- * @early_tap - a tap gesture might be happening.
- * @flick - a flick gesture was detected.
- * @press - a press gesture was recognized.
- * @pinch - a pinch gesture was detected.
- */
-struct f11_2d_data_8 {
-	bool single_tap:1;
-	bool tap_and_hold:1;
-	bool double_tap:1;
-	bool early_tap:1;
-	bool flick:1;
-	bool press:1;
-	bool pinch:1;
-} __attribute__((__packed__));
-
-/**
- * @palm_detect - a palm or other large object is in contact with the =
sensor.
- * @rotate - a rotate gesture was detected.
- * @shape - a TouchShape has been activated.
- * @scrollzone - scrolling data is available.
- * @finger_count - number of fingers involved in the reported gesture.
- */
-struct f11_2d_data_9 {
-	bool palm_detect:1;
-	bool rotate:1;
-	bool shape:1;
-	bool scrollzone:1;
-	u8 finger_count:3;
-} __attribute__((__packed__));
-
-/**
- * @pinch_motion - when a pinch gesture is detected, this is the chang=
e in
- * distance between the two fingers since this register was last read.
- */
-struct f11_2d_data_10 {
-	s8 pinch_motion;
-} __attribute__((__packed__));
-
-/**
- * @x_flick_dist - when a flick gesture is detected,  the distance of =
flick
- * gesture in X direction.
- * @y_flick_dist - when a flick gesture is detected,  the distance of =
flick
- * gesture in Y direction.
- * @flick_time - the total time of the flick gesture, in 10ms units.
- */
-struct f11_2d_data_10_12 {
-	s8 x_flick_dist;
-	s8 y_flick_dist;
-	u8 flick_time;
-} __attribute__((__packed__));
-
-/**
- * @motion - when a rotate gesture is detected, the accumulated distan=
ce
- * of the rotate motion. Clockwise motion is positive and counterclock=
wise
- * motion is negative.
- * @finger_separation - when a rotate gesture is detected, the distanc=
e
- * between the fingers.
- */
-struct f11_2d_data_11_12 {
-	s8 motion;
-	u8 finger_separation;
-} __attribute__((__packed__));
-
-/**
- * @shape_n - a bitmask of the currently activate TouchShapes (if any)=
=2E
- */
-struct f11_2d_data_13 {
-	u8 shape_n;
-} __attribute__((__packed__));
-
-/**
- * @horizontal - chiral scrolling distance in the X direction.
- * @vertical - chiral scrolling distance in the Y direction.
- */
-struct f11_2d_data_14_15 {
-	s8 horizontal;
-	s8 vertical;
-} __attribute__((__packed__));
-
-/**
- * @x_low - scroll zone motion along the lower edge of the sensor.
- * @y_right - scroll zone motion along the right edge of the sensor.
- * @x_upper - scroll zone motion along the upper edge of the sensor.
- * @y_left - scroll zone motion along the left edge of the sensor.
- */
-struct f11_2d_data_14_17 {
-	s8 x_low;
-	s8 y_right;
-	s8 x_upper;
-	s8 y_left;
-} __attribute__((__packed__));
-
-struct f11_2d_data {
-	u8				*f_state;
-	const struct f11_2d_data_1_5	*abs_pos;
-	const struct f11_2d_data_6_7	*rel_pos;
-	const struct f11_2d_data_8	*gest_1;
-	const struct f11_2d_data_9	*gest_2;
-	const struct f11_2d_data_10	*pinch;
-	const struct f11_2d_data_10_12	*flick;
-	const struct f11_2d_data_11_12	*rotate;
-	const struct f11_2d_data_13	*shapes;
-	const struct f11_2d_data_14_15	*multi_scroll;
-	const struct f11_2d_data_14_17	*scroll_zones;
-};
-
-/**
- * @axis_align - controls parameters that are useful in system prototy=
ping
- * and bring up.
- * @sens_query - query registers for this particular sensor.
- * @data - the data reported by this sensor, mapped into a collection =
of
- * structs.
- * @max_x - The maximum X coordinate that will be reported by this sen=
sor.
- * @max_y - The maximum Y coordinate that will be reported by this sen=
sor.
- * @nbr_fingers - How many fingers can this sensor report?
- * @data_pkt - buffer for data reported by this sensor.
- * @pkt_size - number of bytes in that buffer.
- * @sensor_index - identifies this particular 2D touch sensor
- * @type_a - some early RMI4 2D sensors do not reliably track the fing=
er
- * position when two fingers are on the device.  When this is true, we
- * assume we have one of those sensors and report events appropriately=
=2E
- * @sensor_type - indicates whether we're touchscreen or touchpad.
- * @input - input device for absolute pointing stream
- * @mouse_input - input device for relative pointing stream.
- * @input_phys - buffer for the absolute phys name for this sensor.
- * @input_phys_mouse - buffer for the relative phys name for this sens=
or.
- */
-struct f11_2d_sensor {
-	struct rmi_f11_2d_axis_alignment axis_align;
-	struct f11_2d_sensor_queries sens_query;
-	struct f11_2d_data data;
-	u16 max_x;
-	u16 max_y;
-	u8 nbr_fingers;
-	u8 *data_pkt;
-	int pkt_size;
-	u8 sensor_index;
-	u32 type_a;	/* boolean but debugfs API requires u32 */
-	enum rmi_f11_sensor_type sensor_type;
-	struct input_dev *input;
-	struct input_dev *mouse_input;
-	struct rmi_function *fn;
-	char input_phys[NAME_BUFFER_SIZE];
-	char input_phys_mouse[NAME_BUFFER_SIZE];
-};
-
-/** Data pertaining to F11 in general.  For per-sensor data, see struc=
t
- * f11_2d_sensor.
- *
- * @dev_query - F11 device specific query registers.
- * @dev_controls - F11 device specific control registers.
- * @dev_controls_mutex - lock for the control registers.
- * @rezero_wait_ms - if nonzero, upon resume we will wait this many
- * milliseconds before rezeroing the sensor(s).  This is useful in sys=
tems with
- * poor electrical behavior on resume, where the initial calibration o=
f the
- * sensor(s) coming out of sleep state may be bogus.
- * @sensors - per sensor data structures.
- * @debugfs_rezero_wait - allows control of the rezero_wait value.  Us=
eful
- * during system prototyping.
- */
-struct f11_data {
-	struct f11_2d_device_query dev_query;
-	struct f11_2d_ctrl dev_controls;
-	struct mutex dev_controls_mutex;
-	u16 rezero_wait_ms;
-	struct f11_2d_sensor sensors[F11_MAX_NUM_OF_SENSORS];
-};
=20
 enum finger_state_values {
 	F11_NO_FINGER	=3D 0x00,
 	F11_PRESENT	=3D 0x01,
 	F11_INACCURATE	=3D 0x02,
-	F11_RESERVED	=3D 0x03
+	F11_PRODUCT_SPECIFIC	=3D 0x03
 };
=20
-static ssize_t rmi_f11_rezero_store(struct device *dev,
-				    struct device_attribute *attr,
-				    const char *buf, size_t count)
-{
-	struct rmi_function *fn =3D to_rmi_function(dev);
-	unsigned int rezero;
-	int error;
-
-	error =3D kstrtouint(buf, 0, &rezero);
-	if (error)
-		return error;
-
-	if (rezero > 1)
-		return -ERANGE;
-
-	/* Per spec, 0 has no effect, so we skip it entirely. */
-	if (rezero) {
-		/* Command register always reads as 0, so just use a local. */
-		struct f11_2d_commands commands =3D {
-			.rezero =3D true,
-		};
-
-		error =3D rmi_write_block(fn->rmi_dev, fn->fd.command_base_addr,
-					&commands, sizeof(commands));
-		if (error < 0) {
-			dev_err(dev,
-				"%s: failed to issue rezero command, error =3D %d.",
-				__func__, error);
-			return error;
-		}
-	}
-
-	return count;
-}
-
-static DEVICE_ATTR(rezero, RMI_WO_ATTR, NULL, rmi_f11_rezero_store);
-
-static struct attribute *rmi_f11_attrs[] =3D {
-	&dev_attr_rezero.attr,
-	NULL
-};
-
-static struct attribute_group rmi_f11_attr_group =3D {
-	.attrs =3D rmi_f11_attrs,
-};
-
-#ifdef CONFIG_RMI4_DEBUG
-static void rmi_f11_setup_sensor_debugfs(struct f11_2d_sensor *sensor)
-{
-	struct rmi_function *fn =3D sensor->fn;
-	struct dentry *sensor_root;
-	char dirname[sizeof("sensorNNN")];
-
-	if (!fn->debugfs_root)
-		return;
-
-	snprintf(dirname, sizeof(dirname), "input%3u", sensor->sensor_index);
-	sensor_root =3D debugfs_create_dir(dirname, fn->debugfs_root);
-	if (!sensor_root) {
-		dev_warn(&fn->dev,
-			 "Failed to create debugfs directory %s for sensor %d\n",
-			 dirname, sensor->sensor_index);
-		return;
-	}
-
-	if (!debugfs_create_bool("type_a", RMI_RW_ATTR, sensor_root,
-				 &sensor->type_a))
-		dev_warn(&fn->dev,
-			 "Failed to create debugfs type_a for sensor %d.\n",
-			 sensor->sensor_index);
-
-	if (!debugfs_create_u16("max_x", RMI_RW_ATTR, sensor_root,
-				&sensor->max_x))
-		dev_warn(&fn->dev,
-			 "Failed to create debugfs max_x for sensor %d.\n",
-			 sensor->sensor_index);
-
-	if (!debugfs_create_u16("max_xy", RMI_RW_ATTR, sensor_root,
-				&sensor->max_y))
-		dev_warn(&fn->dev,
-			 "Failed to create debugfs max_y for sensor %d.\n",
-			 sensor->sensor_index);
-
-	if (!debugfs_create_bool("flip_x", RMI_RW_ATTR, sensor_root,
-				 &sensor->axis_align.flip_x))
-		dev_warn(&fn->dev,
-			 "Failed to create debugfs flip_x for sensor %d.\n",
-			 sensor->sensor_index);
-
-	if (!debugfs_create_bool("flip_y", RMI_RW_ATTR, sensor_root,
-				 &sensor->axis_align.flip_y))
-		dev_warn(&fn->dev,
-			 "Failed to create debugfs flip_y for sensor %d.\n",
-			 sensor->sensor_index);
-
-	if (!debugfs_create_u16("clip_x_low", RMI_RW_ATTR, sensor_root,
-				&sensor->axis_align.clip_x_low))
-		dev_warn(&fn->dev,
-			 "Failed to create debugfs clip_x_low for sensor %d.\n",
-			 sensor->sensor_index);
-
-	if (!debugfs_create_u16("clip_x_high", RMI_RW_ATTR, sensor_root,
-				&sensor->axis_align.clip_x_high))
-		dev_warn(&fn->dev,
-			 "Failed to create debugfs clip_x_high for sensor %d.\n",
-			 sensor->sensor_index);
-
-	if (!debugfs_create_u16("clip_y_low", RMI_RW_ATTR, sensor_root,
-				 &sensor->axis_align.clip_y_low))
-		dev_warn(&fn->dev,
-			 "Failed to create debugfs clip_y_low for sensor %d.\n",
-			 sensor->sensor_index);
-
-	if (!debugfs_create_u16("clip_y_high", RMI_RW_ATTR, sensor_root,
-				 &sensor->axis_align.clip_y_high))
-		dev_warn(&fn->dev,
-			 "Failed to create debugfs clip_y_high for sensor %d.\n",
-			 sensor->sensor_index);
-
-	if (!debugfs_create_u8("delta_x_threshold", RMI_RW_ATTR, sensor_root,
-				&sensor->axis_align.delta_x_threshold))
-		dev_warn(&fn->dev,
-			 "Failed to create debugfs delta_x_threshold for sensor %d.\n",
-			 sensor->sensor_index);
-
-	if (!debugfs_create_u8("delta_y_threshold", RMI_RW_ATTR, sensor_root,
-				&sensor->axis_align.delta_y_threshold))
-		dev_warn(&fn->dev,
-			 "Failed to create debugfs delta_y_threshold for sensor %d.\n",
-			 sensor->sensor_index);
-
-	if (!debugfs_create_u16("offset_x", RMI_RW_ATTR, sensor_root,
-				 &sensor->axis_align.offset_x))
-		dev_warn(&fn->dev,
-			 "Failed to create debugfs offset_x for sensor %d.\n",
-			 sensor->sensor_index);
-
-	if (!debugfs_create_u16("offset_x", RMI_RW_ATTR, sensor_root,
-				 &sensor->axis_align.offset_x))
-		dev_warn(&fn->dev,
-			 "Failed to create debugfs offset_y for sensor %d.\n",
-			 sensor->sensor_index);
-
-	if (!debugfs_create_bool("swap", RMI_RW_ATTR, sensor_root,
-				 &sensor->axis_align.swap_axes))
-		dev_warn(&fn->dev,
-			 "Failed to create debugfs swap for sensor %d.\n",
-			 sensor->sensor_index);
-}
-
-static void rmi_f11_setup_debugfs(struct rmi_function *fn)
-{
-	struct f11_data *f11 =3D fn->data;
-
-	if (fn->debugfs_root)
-		if (!debugfs_create_u16("rezero_wait", RMI_RW_ATTR,
-					fn->debugfs_root,
-					&f11->rezero_wait_ms))
-			dev_warn(&fn->dev,
-				 "Failed to create debugfs rezero_wait.\n");
-}
-#else
-static inline void rmi_f11_setup_sensor_debugfs(struct f11_2d_sensor *=
sensor)
-{
-}
-static inline void rmi_f11_setup_debugfs(struct rmi_function *fn)
-{
-}
-#endif
-/* End adding debugfs */
-
 /** F11_INACCURATE state is overloaded to indicate pen present. */
 #define F11_PEN F11_INACCURATE
=20
 static int get_tool_type(struct f11_2d_sensor *sensor, u8 finger_state=
)
 {
 	if (IS_ENABLED(CONFIG_RMI4_F11_PEN) &&
-			sensor->sens_query.query9.has_pen &&
+			sensor->sens_query.has_pen &&
 			finger_state =3D=3D F11_PEN)
 		return MT_TOOL_PEN;
 	return MT_TOOL_FINGER;
@@ -1012,8 +68,8 @@ static void rmi_f11_rel_pos_report(struct f11_2d_se=
nsor *sensor, u8 n_finger)
 	s8 x, y;
 	s8 temp;
=20
-	x =3D data->rel_pos[n_finger].delta_x;
-	y =3D data->rel_pos[n_finger].delta_y;
+	x =3D data->rel_pos[n_finger * 2];
+	y =3D data->rel_pos[n_finger * 2 + 1];
=20
 	x =3D min(F11_REL_POS_MAX, max(F11_REL_POS_MIN, (int)x));
 	y =3D min(F11_REL_POS_MAX, max(F11_REL_POS_MIN, (int)y));
@@ -1044,19 +100,23 @@ static void rmi_f11_abs_pos_report(struct f11_da=
ta *f11,
 	struct f11_2d_data *data =3D &sensor->data;
 	struct rmi_f11_2d_axis_alignment *axis_align =3D &sensor->axis_align;
 	u16 x, y, z;
-	int w_x, w_y, w_max, w_min, orient;
+	u16 w_x, w_y, w_max, w_min;
+	int orient;
 	int temp;
+	u8 abs_base =3D n_finger * RMI_F11_ABS_BYTES;
+
+	x =3D y =3D z =3D w_x =3D w_y =3D w_min =3D w_max =3D orient =3D 0;
=20
 	if (finger_state) {
-		x =3D ((data->abs_pos[n_finger].x_msb << 4) |
-			data->abs_pos[n_finger].x_lsb);
-		y =3D ((data->abs_pos[n_finger].y_msb << 4) |
-			data->abs_pos[n_finger].y_lsb);
-		z =3D data->abs_pos[n_finger].z;
-		w_x =3D data->abs_pos[n_finger].w_x;
-		w_y =3D data->abs_pos[n_finger].w_y;
+		x =3D (data->abs_pos[abs_base] << 4) |
+			(data->abs_pos[abs_base + 2] & 0x0F);
+		y =3D (data->abs_pos[abs_base + 1] << 4) |
+			(data->abs_pos[abs_base + 2] >> 4);
+		w_x =3D data->abs_pos[abs_base + 3] & 0x0F;
+		w_y =3D data->abs_pos[abs_base + 3] >> 4;
 		w_max =3D max(w_x, w_y);
 		w_min =3D min(w_x, w_y);
+		z =3D data->abs_pos[abs_base + 4];
=20
 		if (axis_align->swap_axes) {
 			temp =3D x;
@@ -1099,8 +159,8 @@ static void rmi_f11_abs_pos_report(struct f11_data=
 *f11,
 	 * fingers. */
 	if (IS_ENABLED(CONFIG_RMI4_F11_PEN) &&
 			get_tool_type(sensor, finger_state) =3D=3D MT_TOOL_PEN) {
-		w_max =3D max(1, w_max);
-		w_min =3D max(1, w_min);
+		w_max =3D max_t(u16, 1, w_max);
+		w_min =3D max_t(u16, 1, w_min);
 	}
=20
 	if (sensor->type_a) {
@@ -1138,12 +198,10 @@ static void rmi_f11_finger_handler(struct f11_da=
ta *f11,
 	u8 i;
=20
 	for (i =3D 0, finger_pressed_count =3D 0; i < sensor->nbr_fingers; i+=
+) {
-		/* Possible of having 4 fingers per f_statet register */
+		/* Possible of having 4 fingers per f_state register */
 		finger_state =3D (f_state[i / 4] >> (2 * (i % 4))) &
 					FINGER_STATE_MASK;
-		if (finger_state =3D=3D F11_RESERVED) {
-			pr_err("%s: Invalid finger state[%d]:0x%02x.", __func__,
-					i, finger_state);
+		if (finger_state =3D=3D F11_PRODUCT_SPECIFIC) {
 			continue;
 		} else if ((finger_state =3D=3D F11_PRESENT) ||
 				(finger_state =3D=3D F11_INACCURATE)) {
@@ -1156,7 +214,9 @@ static void rmi_f11_finger_handler(struct f11_data=
 *f11,
 		if (sensor->data.rel_pos)
 			rmi_f11_rel_pos_report(sensor, i);
 	}
-	input_mt_sync(sensor->input);
+
+	input_report_key(sensor->input, BTN_TOUCH, finger_pressed_count);
+
 	input_sync(sensor->input);
 }
=20
@@ -1166,38 +226,36 @@ static int f11_2d_construct_data(struct f11_2d_s=
ensor *sensor)
 	struct f11_2d_data *data =3D &sensor->data;
 	int i;
=20
-	sensor->nbr_fingers =3D (query->info.number_of_fingers =3D=3D 5 ? 10 =
:
-				query->info.number_of_fingers + 1);
+	sensor->nbr_fingers =3D (query->nr_fingers =3D=3D 5 ? 10 :
+				query->nr_fingers + 1);
=20
 	sensor->pkt_size =3D DIV_ROUND_UP(sensor->nbr_fingers, 4);
=20
-	if (query->info.has_abs)
+	if (query->has_abs)
 		sensor->pkt_size +=3D (sensor->nbr_fingers * 5);
=20
-	if (query->info.has_rel)
+	if (query->has_rel)
 		sensor->pkt_size +=3D  (sensor->nbr_fingers * 2);
=20
 	/* Check if F11_2D_Query7 is non-zero */
-	if (has_gesture_bits(&query->gesture_info, 0))
+	if (query->query7_nonzero)
 		sensor->pkt_size +=3D sizeof(u8);
=20
 	/* Check if F11_2D_Query7 or F11_2D_Query8 is non-zero */
-	if (has_gesture_bits(&query->gesture_info, 0) ||
-				has_gesture_bits(&query->gesture_info, 1))
+	if (query->query7_nonzero || query->query8_nonzero)
 		sensor->pkt_size +=3D sizeof(u8);
=20
-	if (query->gesture_info.has_pinch || query->gesture_info.has_flick
-			|| query->gesture_info.has_rotate) {
+	if (query->has_pinch || query->has_flick || query->has_rotate) {
 		sensor->pkt_size +=3D 3;
-		if (!query->gesture_info.has_flick)
+		if (!query->has_flick)
 			sensor->pkt_size--;
-		if (!query->gesture_info.has_rotate)
+		if (!query->has_rotate)
 			sensor->pkt_size--;
 	}
=20
-	if (query->gesture_info.has_touch_shapes)
+	if (query->has_touch_shapes)
 		sensor->pkt_size +=3D
-			DIV_ROUND_UP(query->ts_info.nbr_touch_shapes + 1, 8);
+			DIV_ROUND_UP(query->nr_touch_shapes + 1, 8);
=20
 	sensor->data_pkt =3D kzalloc(sensor->pkt_size, GFP_KERNEL);
 	if (!sensor->data_pkt)
@@ -1206,272 +264,65 @@ static int f11_2d_construct_data(struct f11_2d_=
sensor *sensor)
 	data->f_state =3D sensor->data_pkt;
 	i =3D DIV_ROUND_UP(sensor->nbr_fingers, 4);
=20
-	if (query->info.has_abs) {
-		data->abs_pos =3D (struct f11_2d_data_1_5 *)
-				&sensor->data_pkt[i];
-		i +=3D (sensor->nbr_fingers * 5);
+	if (query->has_abs) {
+		data->abs_pos =3D &sensor->data_pkt[i];
+		i +=3D (sensor->nbr_fingers * RMI_F11_ABS_BYTES);
 	}
=20
-	if (query->info.has_rel) {
-		data->rel_pos =3D (struct f11_2d_data_6_7 *)
-				&sensor->data_pkt[i];
-		i +=3D (sensor->nbr_fingers * 2);
+	if (query->has_rel) {
+		data->rel_pos =3D &sensor->data_pkt[i];
+		i +=3D (sensor->nbr_fingers * RMI_F11_REL_BYTES);
 	}
=20
-	if (has_gesture_bits(&query->gesture_info, 0)) {
-		data->gest_1 =3D (struct f11_2d_data_8 *)&sensor->data_pkt[i];
+	if (query->query7_nonzero) {
+		data->gest_1 =3D &sensor->data_pkt[i];
 		i++;
 	}
=20
-	if (has_gesture_bits(&query->gesture_info, 0) ||
-				has_gesture_bits(&query->gesture_info, 1)) {
-		data->gest_2 =3D (struct f11_2d_data_9 *)&sensor->data_pkt[i];
+	if (query->query7_nonzero || query->query8_nonzero) {
+		data->gest_2 =3D &sensor->data_pkt[i];
 		i++;
 	}
=20
-	if (query->gesture_info.has_pinch) {
-		data->pinch =3D (struct f11_2d_data_10 *)&sensor->data_pkt[i];
+	if (query->has_pinch) {
+		data->pinch =3D &sensor->data_pkt[i];
 		i++;
 	}
=20
-	if (query->gesture_info.has_flick) {
-		if (query->gesture_info.has_pinch) {
-			data->flick =3D (struct f11_2d_data_10_12 *)data->pinch;
+	if (query->has_flick) {
+		if (query->has_pinch) {
+			data->flick =3D data->pinch;
 			i +=3D 2;
 		} else {
-			data->flick =3D (struct f11_2d_data_10_12 *)
-					&sensor->data_pkt[i];
+			data->flick =3D &sensor->data_pkt[i];
 			i +=3D 3;
 		}
 	}
=20
-	if (query->gesture_info.has_rotate) {
-		if (query->gesture_info.has_flick) {
-			data->rotate =3D (struct f11_2d_data_11_12 *)
-					(data->flick + 1);
+	if (query->has_rotate) {
+		if (query->has_flick) {
+			data->rotate =3D data->flick + 1;
 		} else {
-			data->rotate =3D (struct f11_2d_data_11_12 *)
-					&sensor->data_pkt[i];
+			data->rotate =3D &sensor->data_pkt[i];
 			i +=3D 2;
 		}
 	}
=20
-	if (query->gesture_info.has_touch_shapes)
-		data->shapes =3D (struct f11_2d_data_13 *)&sensor->data_pkt[i];
-
 	return 0;
 }
=20
 static int f11_read_control_regs(struct rmi_function *fn,
 				struct f11_2d_ctrl *ctrl, u16 ctrl_base_addr) {
 	struct rmi_device *rmi_dev =3D fn->rmi_dev;
-	u16 read_address =3D ctrl_base_addr;
-	int error =3D 0;
+	int error;
=20
-	ctrl->ctrl0_9_address =3D read_address;
-	error =3D rmi_read_block(rmi_dev, read_address, ctrl->ctrl0_9,
-		sizeof(*ctrl->ctrl0_9));
+	ctrl->ctrl0_9_address =3D ctrl_base_addr;
+	error =3D rmi_read_block(rmi_dev, ctrl_base_addr, ctrl->ctrl0_9,
+				RMI_F11_CTRL_REG_COUNT);
 	if (error < 0) {
 		dev_err(&fn->dev, "Failed to read ctrl0, code: %d.\n", error);
 		return error;
 	}
-	read_address +=3D sizeof(*ctrl->ctrl0_9);
-
-	if (ctrl->ctrl10) {
-		error =3D rmi_read_block(rmi_dev, read_address,
-			ctrl->ctrl10, sizeof(*ctrl->ctrl10));
-		if (error < 0) {
-			dev_err(&fn->dev,
-				"Failed to read ctrl10, code: %d.\n", error);
-			return error;
-		}
-		read_address +=3D sizeof(*ctrl->ctrl10);
-	}
-
-	if (ctrl->ctrl11) {
-		error =3D rmi_read_block(rmi_dev, read_address,
-			ctrl->ctrl11, sizeof(*ctrl->ctrl11));
-		if (error < 0) {
-			dev_err(&fn->dev,
-				"Failed to read ctrl11, code: %d.\n", error);
-			return error;
-		}
-		read_address +=3D sizeof(*ctrl->ctrl11);
-	}
-
-	if (ctrl->ctrl14) {
-		error =3D rmi_read_block(rmi_dev, read_address,
-			ctrl->ctrl14, sizeof(*ctrl->ctrl14));
-		if (error < 0) {
-			dev_err(&fn->dev,
-				"Failed to read ctrl14, code: %d.\n", error);
-			return error;
-		}
-		read_address +=3D sizeof(*ctrl->ctrl14);
-	}
-
-	if (ctrl->ctrl15) {
-		error =3D rmi_read_block(rmi_dev, read_address,
-			ctrl->ctrl15, sizeof(*ctrl->ctrl15));
-		if (error < 0) {
-			dev_err(&fn->dev,
-				"Failed to read ctrl15, code: %d.\n", error);
-			return error;
-		}
-		read_address +=3D sizeof(*ctrl->ctrl15);
-	}
-
-	if (ctrl->ctrl16) {
-		error =3D rmi_read_block(rmi_dev, read_address,
-			ctrl->ctrl16, sizeof(*ctrl->ctrl16));
-		if (error < 0) {
-			dev_err(&fn->dev,
-				"Failed to read ctrl16, code: %d.\n", error);
-			return error;
-		}
-		read_address +=3D sizeof(*ctrl->ctrl16);
-	}
-
-	if (ctrl->ctrl17) {
-		error =3D rmi_read_block(rmi_dev, read_address,
-			ctrl->ctrl17, sizeof(*ctrl->ctrl17));
-		if (error < 0) {
-			dev_err(&fn->dev,
-				"Failed to read ctrl17, code: %d.\n", error);
-			return error;
-		}
-		read_address +=3D sizeof(*ctrl->ctrl17);
-	}
-
-	if (ctrl->ctrl18_19) {
-		error =3D rmi_read_block(rmi_dev, read_address,
-			ctrl->ctrl18_19, sizeof(*ctrl->ctrl18_19));
-		if (error < 0) {
-			dev_err(&fn->dev,
-				"Failed to read ctrl18_19, code: %d.\n", error);
-			return error;
-		}
-		read_address +=3D sizeof(*ctrl->ctrl18_19);
-	}
-
-	if (ctrl->ctrl20_21) {
-		error =3D rmi_read_block(rmi_dev, read_address,
-			ctrl->ctrl20_21, sizeof(*ctrl->ctrl20_21));
-		if (error < 0) {
-			dev_err(&fn->dev,
-				"Failed to read ctrl20_21, code: %d.\n", error);
-			return error;
-		}
-		read_address +=3D sizeof(*ctrl->ctrl20_21);
-	}
-
-	if (ctrl->ctrl22_26) {
-		error =3D rmi_read_block(rmi_dev, read_address,
-			ctrl->ctrl22_26, sizeof(*ctrl->ctrl22_26));
-		if (error < 0) {
-			dev_err(&fn->dev,
-				"Failed to read ctrl22_26, code: %d.\n", error);
-			return error;
-		}
-		read_address +=3D sizeof(*ctrl->ctrl22_26);
-	}
-
-	if (ctrl->ctrl27) {
-		error =3D rmi_read_block(rmi_dev, read_address,
-			ctrl->ctrl27, sizeof(*ctrl->ctrl27));
-		if (error < 0) {
-			dev_err(&fn->dev,
-				"Failed to read ctrl27, code: %d.\n", error);
-			return error;
-		}
-		read_address +=3D sizeof(*ctrl->ctrl27);
-	}
-
-	if (ctrl->ctrl28) {
-		error =3D rmi_read_block(rmi_dev, read_address,
-			ctrl->ctrl28, sizeof(*ctrl->ctrl28));
-		if (error < 0) {
-			dev_err(&fn->dev,
-				"Failed to read ctrl28, code: %d.\n", error);
-			return error;
-		}
-		read_address +=3D sizeof(*ctrl->ctrl28);
-	}
-
-	if (ctrl->ctrl29_30) {
-		error =3D rmi_read_block(rmi_dev, read_address,
-			ctrl->ctrl29_30, sizeof(*ctrl->ctrl29_30));
-		if (error < 0) {
-			dev_err(&fn->dev,
-				"Failed to read ctrl29_30, code: %d.\n", error);
-			return error;
-		}
-		read_address +=3D sizeof(*ctrl->ctrl29_30);
-	}
-	return 0;
-}
-
-static int f11_allocate_control_regs(struct rmi_function *fn,
-				struct f11_2d_device_query *device_query,
-				struct f11_2d_sensor_queries *sensor_query,
-				struct f11_2d_ctrl *ctrl,
-				u16 ctrl_base_addr) {
-
-	ctrl->ctrl0_9 =3D devm_kzalloc(&fn->dev, sizeof(struct f11_2d_ctrl0_9=
),
-				       GFP_KERNEL);
-	if (!ctrl->ctrl0_9)
-		return -ENOMEM;
-	if (has_gesture_bits(&sensor_query->gesture_info, 0)) {
-		ctrl->ctrl10 =3D devm_kzalloc(&fn->dev,
-			sizeof(struct f11_2d_ctrl10), GFP_KERNEL);
-		if (!ctrl->ctrl10)
-			return -ENOMEM;
-	}
-
-	if (has_gesture_bits(&sensor_query->gesture_info, 1)) {
-		ctrl->ctrl11 =3D devm_kzalloc(&fn->dev,
-			sizeof(struct f11_2d_ctrl11), GFP_KERNEL);
-		if (!ctrl->ctrl11)
-			return -ENOMEM;
-	}
-
-	if (device_query->has_query9 && sensor_query->query9.has_pen) {
-		ctrl->ctrl20_21 =3D devm_kzalloc(&fn->dev,
-			sizeof(struct f11_2d_ctrl20_21), GFP_KERNEL);
-		if (!ctrl->ctrl20_21)
-			return -ENOMEM;
-	}
-
-	if (device_query->has_query9 && sensor_query->query9.has_proximity) {
-		ctrl->ctrl22_26 =3D devm_kzalloc(&fn->dev,
-			sizeof(struct f11_2d_ctrl22_26), GFP_KERNEL);
-		if (!ctrl->ctrl22_26)
-			return -ENOMEM;
-	}
-
-	if (device_query->has_query9 &&
-		(sensor_query->query9.has_palm_det_sensitivity ||
-		sensor_query->query9.has_suppress_on_palm_detect)) {
-		ctrl->ctrl27 =3D devm_kzalloc(&fn->dev,
-			sizeof(struct f11_2d_ctrl27), GFP_KERNEL);
-		if (!ctrl->ctrl27)
-			return -ENOMEM;
-	}
-
-	if (sensor_query->gesture_info.has_multi_finger_scroll) {
-		ctrl->ctrl28 =3D devm_kzalloc(&fn->dev,
-			sizeof(struct f11_2d_ctrl28), GFP_KERNEL);
-		if (!ctrl->ctrl28)
-			return -ENOMEM;
-	}
-
-	if (device_query->has_query11 &&
-			sensor_query->features_1.has_z_tuning) {
-		ctrl->ctrl29_30 =3D devm_kzalloc(&fn->dev,
-			sizeof(struct f11_2d_ctrl29_30), GFP_KERNEL);
-		if (!ctrl->ctrl29_30)
-			return -ENOMEM;
-	}
=20
 	return 0;
 }
@@ -1482,139 +333,70 @@ static int f11_write_control_regs(struct rmi_fu=
nction *fn,
 					u16 ctrl_base_addr)
 {
 	struct rmi_device *rmi_dev =3D fn->rmi_dev;
-	u16 write_address =3D ctrl_base_addr;
 	int error;
=20
-	error =3D rmi_write_block(rmi_dev, write_address,
-				ctrl->ctrl0_9,
-				 sizeof(*ctrl->ctrl0_9));
+	error =3D rmi_write_block(rmi_dev, ctrl_base_addr, ctrl->ctrl0_9,
+				RMI_F11_CTRL_REG_COUNT);
 	if (error < 0)
 		return error;
-	write_address +=3D sizeof(ctrl->ctrl0_9);
-
-	if (ctrl->ctrl10) {
-		error =3D rmi_write_block(rmi_dev, write_address,
-					ctrl->ctrl10, sizeof(*ctrl->ctrl10));
-		if (error < 0)
-			return error;
-		write_address++;
-	}
-
-	if (ctrl->ctrl11) {
-		error =3D rmi_write_block(rmi_dev, write_address,
-					ctrl->ctrl11, sizeof(*ctrl->ctrl11));
-		if (error < 0)
-			return error;
-		write_address++;
-	}
-
-	if (ctrl->ctrl14) {
-		error =3D rmi_write_block(rmi_dev, write_address,
-				ctrl->ctrl14, sizeof(ctrl->ctrl14));
-		if (error < 0)
-			return error;
-		write_address +=3D sizeof(*ctrl->ctrl15);
-	}
-
-	if (ctrl->ctrl15) {
-		error =3D rmi_write_block(rmi_dev, write_address,
-				ctrl->ctrl15, sizeof(*ctrl->ctrl15));
-		if (error < 0)
-			return error;
-		write_address +=3D sizeof(*ctrl->ctrl15);
-	}
-
-	if (ctrl->ctrl16) {
-		error =3D rmi_write_block(rmi_dev, write_address,
-				ctrl->ctrl16, sizeof(*ctrl->ctrl16));
-		if (error < 0)
-			return error;
-		write_address +=3D sizeof(*ctrl->ctrl16);
-	}
-
-	if (ctrl->ctrl17) {
-		error =3D rmi_write_block(rmi_dev, write_address,
-				ctrl->ctrl17, sizeof(*ctrl->ctrl17));
-		if (error < 0)
-			return error;
-		write_address +=3D sizeof(*ctrl->ctrl17);
-	}
-
-	if (ctrl->ctrl18_19) {
-		error =3D rmi_write_block(rmi_dev, write_address,
-			ctrl->ctrl18_19, sizeof(*ctrl->ctrl18_19));
-		if (error < 0)
-			return error;
-		write_address +=3D sizeof(*ctrl->ctrl18_19);
-	}
-
-	if (ctrl->ctrl20_21) {
-		error =3D rmi_write_block(rmi_dev, write_address,
-			ctrl->ctrl20_21, sizeof(*ctrl->ctrl20_21));
-		if (error < 0)
-			return error;
-		write_address +=3D sizeof(*ctrl->ctrl20_21);
-	}
-
-	if (ctrl->ctrl22_26) {
-		error =3D rmi_write_block(rmi_dev, write_address,
-			ctrl->ctrl22_26, sizeof(*ctrl->ctrl22_26));
-		if (error < 0)
-			return error;
-		write_address +=3D sizeof(*ctrl->ctrl22_26);
-	}
-
-	if (ctrl->ctrl27) {
-		error =3D rmi_write_block(rmi_dev, write_address,
-			ctrl->ctrl27, sizeof(*ctrl->ctrl27));
-		if (error < 0)
-			return error;
-		write_address +=3D sizeof(*ctrl->ctrl27);
-	}
-
-	if (ctrl->ctrl28) {
-		error =3D rmi_write_block(rmi_dev, write_address,
-			ctrl->ctrl28, sizeof(*ctrl->ctrl28));
-		if (error < 0)
-			return error;
-		write_address +=3D sizeof(*ctrl->ctrl28);
-	}
-
-	if (ctrl->ctrl29_30) {
-		error =3D rmi_write_block(rmi_dev, write_address,
-					ctrl->ctrl29_30,
-					sizeof(struct f11_2d_ctrl29_30));
-		if (error < 0)
-			return error;
-		write_address +=3D sizeof(struct f11_2d_ctrl29_30);
-	}
=20
 	return 0;
 }
=20
 static int rmi_f11_get_query_parameters(struct rmi_device *rmi_dev,
-			struct f11_2d_device_query *dev_query,
+			struct f11_data *f11,
 			struct f11_2d_sensor_queries *sensor_query,
 			u16 query_base_addr)
 {
 	int query_size;
 	int rc;
+	u8 query_buf[RMI_F11_QUERY_SIZE];
=20
-	rc =3D rmi_read_block(rmi_dev, query_base_addr,
-			    &sensor_query->info, sizeof(sensor_query->info));
+	rc =3D rmi_read_block(rmi_dev, query_base_addr, query_buf,
+				RMI_F11_QUERY_SIZE);
 	if (rc < 0)
 		return rc;
-	query_size =3D sizeof(sensor_query->info);
=20
-	if (sensor_query->info.has_abs) {
-		rc =3D rmi_read(rmi_dev, query_base_addr + query_size,
-					&sensor_query->abs_info);
+	sensor_query->nr_fingers =3D query_buf[0] & RMI_F11_NR_FINGERS_MASK;
+	sensor_query->has_rel =3D !!(query_buf[0] & RMI_F11_HAS_REL);
+	sensor_query->has_abs =3D !!(query_buf[0] & RMI_F11_HAS_ABS);
+	sensor_query->has_gestures =3D !!(query_buf[0] & RMI_F11_HAS_GESTURES=
);
+	sensor_query->has_sensitivity_adjust =3D
+	!!(query_buf[0] && RMI_F11_HAS_SENSITIVITY_ADJ);
+	sensor_query->configurable =3D !!(query_buf[0] & RMI_F11_CONFIGURABLE=
);
+
+	sensor_query->nr_x_electrodes =3D
+				query_buf[1] & RMI_F11_NR_ELECTRODES_MASK;
+	sensor_query->nr_y_electrodes =3D
+				query_buf[2] & RMI_F11_NR_ELECTRODES_MASK;
+	sensor_query->max_electrodes =3D
+				query_buf[3] & RMI_F11_NR_ELECTRODES_MASK;
+
+	query_size =3D RMI_F11_QUERY_SIZE;
+
+	if (sensor_query->has_abs) {
+		rc =3D rmi_read(rmi_dev, query_base_addr + query_size, query_buf);
 		if (rc < 0)
 			return rc;
+
+		sensor_query->abs_data_size =3D
+			query_buf[0] & RMI_F11_ABS_DATA_SIZE_MASK;
+		sensor_query->has_anchored_finger =3D
+			!!(query_buf[0] & RMI_F11_HAS_ANCHORED_FINGER);
+		sensor_query->has_adj_hyst =3D
+			!!(query_buf[0] & RMI_F11_HAS_ADJ_HYST);
+		sensor_query->has_dribble =3D
+			!!(query_buf[0] & RMI_F11_HAS_DRIBBLE);
+		sensor_query->has_bending_correction =3D
+			!!(query_buf[0] & RMI_F11_HAS_BENDING_CORRECTION);
+		sensor_query->has_large_object_suppression =3D
+		!!(query_buf[0] && RMI_F11_HAS_LARGE_OBJECT_SUPPRESSION);
+		sensor_query->has_jitter_filter =3D
+			!!(query_buf[0] & RMI_F11_HAS_JITTER_FILTER);
 		query_size++;
 	}
=20
-	if (sensor_query->info.has_rel) {
+	if (sensor_query->has_rel) {
 		rc =3D rmi_read(rmi_dev, query_base_addr + query_size,
 					&sensor_query->f11_2d_query6);
 		if (rc < 0)
@@ -1622,67 +404,173 @@ static int rmi_f11_get_query_parameters(struct =
rmi_device *rmi_dev,
 		query_size++;
 	}
=20
-	if (sensor_query->info.has_gestures) {
+	if (sensor_query->has_gestures) {
 		rc =3D rmi_read_block(rmi_dev, query_base_addr + query_size,
-					&sensor_query->gesture_info,
-					sizeof(sensor_query->gesture_info));
+					query_buf, RMI_F11_QUERY_GESTURE_SIZE);
 		if (rc < 0)
 			return rc;
-		query_size +=3D sizeof(sensor_query->gesture_info);
-	}
=20
-	if (dev_query->has_query9) {
-		rc =3D rmi_read_block(rmi_dev, query_base_addr + query_size,
-					&sensor_query->query9,
-					sizeof(sensor_query->query9));
+		sensor_query->has_single_tap =3D
+			!!(query_buf[0] & RMI_F11_HAS_SINGLE_TAP);
+		sensor_query->has_tap_n_hold =3D
+			!!(query_buf[0] & RMI_F11_HAS_TAP_AND_HOLD);
+		sensor_query->has_double_tap =3D
+			!!(query_buf[0] & RMI_F11_HAS_DOUBLE_TAP);
+		sensor_query->has_early_tap =3D
+			!!(query_buf[0] & RMI_F11_HAS_EARLY_TAP);
+		sensor_query->has_flick =3D
+			!!(query_buf[0] & RMI_F11_HAS_FLICK);
+		sensor_query->has_press =3D
+			!!(query_buf[0] & RMI_F11_HAS_PRESS);
+		sensor_query->has_pinch =3D
+			!!(query_buf[0] & RMI_F11_HAS_PINCH);
+		sensor_query->has_chiral =3D
+			!!(query_buf[0] & RMI_F11_HAS_CHIRAL);
+
+		/* query 8 */
+		sensor_query->has_palm_det =3D
+			!!(query_buf[1] & RMI_F11_HAS_PALM_DET);
+		sensor_query->has_rotate =3D
+			!!(query_buf[1] & RMI_F11_HAS_ROTATE);
+		sensor_query->has_touch_shapes =3D
+			!!(query_buf[1] & RMI_F11_HAS_TOUCH_SHAPES);
+		sensor_query->has_scroll_zones =3D
+			!!(query_buf[1] & RMI_F11_HAS_SCROLL_ZONES);
+		sensor_query->has_individual_scroll_zones =3D
+			!!(query_buf[1] & RMI_F11_HAS_INDIVIDUAL_SCROLL_ZONES);
+		sensor_query->has_mf_scroll =3D
+			!!(query_buf[1] & RMI_F11_HAS_MF_SCROLL);
+		sensor_query->has_mf_edge_motion =3D
+			!!(query_buf[1] & RMI_F11_HAS_MF_EDGE_MOTION);
+		sensor_query->has_mf_scroll_inertia =3D
+			!!(query_buf[1] & RMI_F11_HAS_MF_SCROLL_INERTIA);
+
+		sensor_query->query7_nonzero =3D !!(query_buf[0]);
+		sensor_query->query8_nonzero =3D !!(query_buf[1]);
+
+		query_size +=3D 2;
+	}
+
+	if (f11->has_query9) {
+		rc =3D rmi_read(rmi_dev, query_base_addr + query_size, query_buf);
 		if (rc < 0)
 			return rc;
-		query_size +=3D sizeof(sensor_query->query9);
+
+		sensor_query->has_pen =3D
+			!!(query_buf[0] & RMI_F11_HAS_PEN);
+		sensor_query->has_proximity =3D
+			!!(query_buf[0] & RMI_F11_HAS_PROXIMITY);
+		sensor_query->has_palm_det_sensitivity =3D
+			!!(query_buf[0] & RMI_F11_HAS_PALM_DET_SENSITIVITY);
+		sensor_query->has_suppress_on_palm_detect =3D
+			!!(query_buf[0] & RMI_F11_HAS_SUPPRESS_ON_PALM_DETECT);
+		sensor_query->has_two_pen_thresholds =3D
+			!!(query_buf[0] & RMI_F11_HAS_TWO_PEN_THRESHOLDS);
+		sensor_query->has_contact_geometry =3D
+			!!(query_buf[0] & RMI_F11_HAS_CONTACT_GEOMETRY);
+		sensor_query->has_pen_hover_discrimination =3D
+			!!(query_buf[0] & RMI_F11_HAS_PEN_HOVER_DISCRIMINATION);
+		sensor_query->has_pen_filters =3D
+			!!(query_buf[0] & RMI_F11_HAS_PEN_FILTERS);
+
+		query_size++;
 	}
=20
-	if (sensor_query->gesture_info.has_touch_shapes) {
-		rc =3D rmi_read_block(rmi_dev, query_base_addr + query_size,
-					&sensor_query->ts_info,
-					sizeof(sensor_query->ts_info));
+	if (sensor_query->has_touch_shapes) {
+		rc =3D rmi_read(rmi_dev, query_base_addr + query_size, query_buf);
 		if (rc < 0)
 			return rc;
-		query_size +=3D sizeof(sensor_query->ts_info);
+
+		sensor_query->nr_touch_shapes =3D query_buf[0] &
+				RMI_F11_NR_TOUCH_SHAPES_MASK;
+
+		query_size++;
 	}
=20
-	if (dev_query->has_query11) {
-		rc =3D rmi_read_block(rmi_dev, query_base_addr + query_size,
-					&sensor_query->features_1,
-					sizeof(sensor_query->features_1));
+	if (f11->has_query11) {
+		rc =3D rmi_read(rmi_dev, query_base_addr + query_size, query_buf);
 		if (rc < 0)
 			return rc;
-		query_size +=3D sizeof(sensor_query->features_1);
+
+		sensor_query->has_z_tuning =3D
+			!!(query_buf[0] & RMI_F11_HAS_Z_TUNING);
+		sensor_query->has_algorithm_selection =3D
+			!!(query_buf[0] & RMI_F11_HAS_ALGORITHM_SELECTION);
+		sensor_query->has_w_tuning =3D
+			!!(query_buf[0] & RMI_F11_HAS_W_TUNING);
+		sensor_query->has_pitch_info =3D
+			!!(query_buf[0] & RMI_F11_HAS_PITCH_INFO);
+		sensor_query->has_finger_size =3D
+			!!(query_buf[0] & RMI_F11_HAS_FINGER_SIZE);
+		sensor_query->has_segmentation_aggressiveness =3D
+			!!(query_buf[0] &
+				RMI_F11_HAS_SEGMENTATION_AGGRESSIVENESS);
+		sensor_query->has_XY_clip =3D
+			!!(query_buf[0] & RMI_F11_HAS_XY_CLIP);
+		sensor_query->has_drumming_filter =3D
+			!!(query_buf[0] & RMI_F11_HAS_DRUMMING_FILTER);
+
+		query_size++;
 	}
=20
-	if (dev_query->has_query12) {
-		rc =3D rmi_read_block(rmi_dev, query_base_addr + query_size,
-					&sensor_query->features_2,
-					sizeof(sensor_query->features_2));
+	if (f11->has_query12) {
+		rc =3D rmi_read(rmi_dev, query_base_addr + query_size, query_buf);
 		if (rc < 0)
 			return rc;
-		query_size +=3D sizeof(sensor_query->features_2);
+
+		sensor_query->has_gapless_finger =3D
+			!!(query_buf[0] & RMI_F11_HAS_GAPLESS_FINGER);
+		sensor_query->has_gapless_finger_tuning =3D
+			!!(query_buf[0] & RMI_F11_HAS_GAPLESS_FINGER_TUNING);
+		sensor_query->has_8bit_w =3D
+			!!(query_buf[0] & RMI_F11_HAS_8BIT_W);
+		sensor_query->has_adjustable_mapping =3D
+			!!(query_buf[0] & RMI_F11_HAS_ADJUSTABLE_MAPPING);
+		sensor_query->has_info2 =3D
+			!!(query_buf[0] & RMI_F11_HAS_INFO2);
+		sensor_query->has_physical_props =3D
+			!!(query_buf[0] & RMI_F11_HAS_PHYSICAL_PROPS);
+		sensor_query->has_finger_limit =3D
+			!!(query_buf[0] & RMI_F11_HAS_FINGER_LIMIT);
+		sensor_query->has_linear_coeff_2 =3D
+			!!(query_buf[0] & RMI_F11_HAS_LINEAR_COEFF);
+
+		query_size++;
 	}
=20
-	if (sensor_query->abs_info.has_jitter_filter) {
-		rc =3D rmi_read_block(rmi_dev, query_base_addr + query_size,
-					&sensor_query->jitter_filter,
-					sizeof(sensor_query->jitter_filter));
+	if (sensor_query->has_jitter_filter) {
+		rc =3D rmi_read(rmi_dev, query_base_addr + query_size, query_buf);
 		if (rc < 0)
 			return rc;
-		query_size +=3D sizeof(sensor_query->jitter_filter);
+
+		sensor_query->jitter_window_size =3D query_buf[0] &
+			RMI_F11_JITTER_WINDOW_MASK;
+		sensor_query->jitter_filter_type =3D (query_buf[0] &
+			RMI_F11_JITTER_FILTER_MASK) >>
+			RMI_F11_JITTER_FILTER_SHIFT;
+
+		query_size++;
 	}
=20
-	if (dev_query->has_query12 && sensor_query->features_2.has_info2) {
-		rc =3D rmi_read_block(rmi_dev, query_base_addr + query_size,
-				    &sensor_query->info_2,
-					sizeof(sensor_query->info_2));
+	if (f11->has_query12 && sensor_query->has_info2) {
+		rc =3D rmi_read(rmi_dev, query_base_addr + query_size, query_buf);
 		if (rc < 0)
 			return rc;
-		query_size +=3D sizeof(sensor_query->info_2);
+
+		sensor_query->light_control =3D
+			query_buf[0] & RMI_F11_LIGHT_CONTROL_MASK;
+		sensor_query->is_clear =3D
+			!!(query_buf[0] & RMI_F11_IS_CLEAR);
+		sensor_query->clickpad_props =3D
+			(query_buf[0] & RMI_F11_CLICKPAD_PROPS_MASK) >>
+			RMI_F11_CLICKPAD_PROPS_SHIFT;
+		sensor_query->mouse_buttons =3D
+			(query_buf[0] & RMI_F11_MOUSE_BUTTONS_MASK) >>
+			RMI_F11_MOUSE_BUTTONS_SHIFT;
+		sensor_query->has_advanced_gestures =3D
+			!!(query_buf[0] & RMI_F11_HAS_ADVANCED_GESTURES);
+
+		query_size++;
 	}
=20
 	return query_size;
@@ -1696,10 +584,15 @@ static void f11_set_abs_params(struct rmi_functi=
on *fn, int index)
 	struct f11_data *f11 =3D fn->data;
 	struct f11_2d_sensor *sensor =3D &f11->sensors[index];
 	struct input_dev *input =3D sensor->input;
-	u16 device_x_max =3D
-		f11->dev_controls.ctrl0_9->sensor_max_x_pos;
-	u16 device_y_max =3D
-		f11->dev_controls.ctrl0_9->sensor_max_y_pos;
+	/* These two lines are not doing what we want them to.  So we use
+	 * some shifts instead.
+	int device_x_max =3D le16_to_cpu(*(f11->dev_controls.ctrl0_9 + 6));
+	int device_y_max =3D le16_to_cpu(*(f11->dev_controls.ctrl0_9 + 8));
+	 */
+	u16 device_x_max =3D f11->dev_controls.ctrl0_9[6] |
+		((f11->dev_controls.ctrl0_9[7] & 0x0F) << 8);
+	u16 device_y_max =3D f11->dev_controls.ctrl0_9[8] |
+		((f11->dev_controls.ctrl0_9[9] & 0x0F) << 8);
 	u16 x_min, x_max, y_min, y_max;
 	unsigned int input_flags;
=20
@@ -1707,8 +600,8 @@ static void f11_set_abs_params(struct rmi_function=
 *fn, int index)
 	 * as a touchpad in the platform data
 	 */
 	if (sensor->sensor_type =3D=3D rmi_f11_sensor_touchpad ||
-			(sensor->sens_query.features_2.has_info2 &&
-				!sensor->sens_query.info_2.is_clear))
+			(sensor->sens_query.has_info2 &&
+				!sensor->sens_query.is_clear))
 		input_flags =3D INPUT_PROP_POINTER;
 	else
 		input_flags =3D INPUT_PROP_DIRECT;
@@ -1724,21 +617,16 @@ static void f11_set_abs_params(struct rmi_functi=
on *fn, int index)
 	 */
 	x_min =3D sensor->axis_align.clip_x_low;
 	if (sensor->axis_align.clip_x_high)
-		x_max =3D min(device_x_max,
-			sensor->axis_align.clip_x_high);
+		x_max =3D min(device_x_max, sensor->axis_align.clip_x_high);
 	else
 		x_max =3D device_x_max;
=20
 	y_min =3D sensor->axis_align.clip_y_low;
 	if (sensor->axis_align.clip_y_high)
-		y_max =3D min(device_y_max,
-			sensor->axis_align.clip_y_high);
+		y_max =3D min(device_y_max, sensor->axis_align.clip_y_high);
 	else
 		y_max =3D device_y_max;
=20
-	dev_dbg(&fn->dev, "Set ranges X=3D[%d..%d] Y=3D[%d..%d].",
-			x_min, x_max, y_min, y_max);
-
 	input_set_abs_params(input, ABS_MT_PRESSURE, 0,
 			DEFAULT_MAX_ABS_MT_PRESSURE, 0, 0);
 	input_set_abs_params(input, ABS_MT_TOUCH_MAJOR,
@@ -1756,9 +644,8 @@ static void f11_set_abs_params(struct rmi_function=
 *fn, int index)
 	input_set_abs_params(input, ABS_MT_POSITION_Y,
 			y_min, y_max, 0, 0);
 	if (!sensor->type_a)
-		input_mt_init_slots(input, sensor->nbr_fingers, input_flags);
-	if (IS_ENABLED(CONFIG_RMI4_F11_PEN) &&
-			sensor->sens_query.query9.has_pen)
+		input_mt_init_slots(input, sensor->nbr_fingers, 0);
+	if (IS_ENABLED(CONFIG_RMI4_F11_PEN) && sensor->sens_query.has_pen)
 		input_set_abs_params(input, ABS_MT_TOOL_TYPE,
 				     0, MT_TOOL_MAX, 0, 0);
 	else
@@ -1778,13 +665,8 @@ static int rmi_f11_initialize(struct rmi_function=
 *fn)
 	int rc;
 	int i;
 	struct rmi_device_platform_data *pdata =3D to_rmi_platform_data(rmi_d=
ev);
+	u8 buf;
=20
-	dev_dbg(&fn->dev, "Initializing F11 values for %s.\n",
-		 pdata->sensor_name);
-
-	/*
-	** init instance data, fill in values and create any sysfs files
-	*/
 	f11 =3D devm_kzalloc(&fn->dev, sizeof(struct f11_data), GFP_KERNEL);
 	if (!f11)
 		return -ENOMEM;
@@ -1795,32 +677,30 @@ static int rmi_f11_initialize(struct rmi_functio=
n *fn)
 	query_base_addr =3D fn->fd.query_base_addr;
 	control_base_addr =3D fn->fd.control_base_addr;
=20
-	rc =3D rmi_read(rmi_dev, query_base_addr, &f11->dev_query);
+	rc =3D rmi_read(rmi_dev, query_base_addr, &buf);
 	if (rc < 0)
 		return rc;
=20
+	f11->nr_sensors =3D buf & RMI_F11_NR_SENSORS_MASK;
+	f11->has_query9 =3D !!(buf & RMI_F11_HAS_QUERY9);
+	f11->has_query11 =3D !!(buf & RMI_F11_HAS_QUERY11);
+	f11->has_query12 =3D !!(buf & RMI_F11_HAS_QUERY12);
+	f11->has_query27 =3D !!(buf & RMI_F11_HAS_QUERY27);
+	f11->has_query28 =3D !!(buf & RMI_F11_HAS_QUERY28);
+
 	query_offset =3D (query_base_addr + 1);
 	/* Increase with one since number of sensors is zero based */
-	for (i =3D 0; i < (f11->dev_query.nbr_of_sensors + 1); i++) {
+	for (i =3D 0; i < (f11->nr_sensors + 1); i++) {
 		struct f11_2d_sensor *sensor =3D &f11->sensors[i];
 		sensor->sensor_index =3D i;
 		sensor->fn =3D fn;
=20
-		rc =3D rmi_f11_get_query_parameters(rmi_dev, &f11->dev_query,
+		rc =3D rmi_f11_get_query_parameters(rmi_dev, f11,
 				&sensor->sens_query, query_offset);
 		if (rc < 0)
 			return rc;
 		query_offset +=3D rc;
=20
-		rc =3D f11_allocate_control_regs(fn,
-				&f11->dev_query, &sensor->sens_query,
-				&f11->dev_controls, control_base_addr);
-		if (rc < 0) {
-			dev_err(&fn->dev,
-				"Failed to allocate F11 control params.\n");
-			return rc;
-		}
-
 		rc =3D f11_read_control_regs(fn, &f11->dev_controls,
 				control_base_addr);
 		if (rc < 0) {
@@ -1863,12 +743,11 @@ static int rmi_f11_initialize(struct rmi_functio=
n *fn)
=20
 		ctrl =3D &f11->dev_controls;
 		if (sensor->axis_align.delta_x_threshold) {
-			ctrl->ctrl0_9->delta_x_threshold =3D
+			ctrl->ctrl0_9[RMI_F11_DELTA_X_THRESHOLD] =3D
 				sensor->axis_align.delta_x_threshold;
-			rc =3D rmi_write_block(rmi_dev,
-					ctrl->ctrl0_9_address,
-					ctrl->ctrl0_9,
-					sizeof(*ctrl->ctrl0_9));
+			rc =3D rmi_write_block(rmi_dev, ctrl->ctrl0_9_address,
+					     ctrl->ctrl0_9,
+					     RMI_F11_CTRL_REG_COUNT);
 			if (rc < 0)
 				dev_warn(&fn->dev, "Failed to write to delta_x_threshold %d. Code:=
 %d.\n",
 					i, rc);
@@ -1876,22 +755,16 @@ static int rmi_f11_initialize(struct rmi_functio=
n *fn)
 		}
=20
 		if (sensor->axis_align.delta_y_threshold) {
-			ctrl->ctrl0_9->delta_y_threshold =3D
+			ctrl->ctrl0_9[RMI_F11_DELTA_Y_THRESHOLD] =3D
 				sensor->axis_align.delta_y_threshold;
-			rc =3D rmi_write_block(rmi_dev,
-					ctrl->ctrl0_9_address,
-					ctrl->ctrl0_9,
-					sizeof(*ctrl->ctrl0_9));
+			rc =3D rmi_write_block(rmi_dev, ctrl->ctrl0_9_address,
+					ctrl->ctrl0_9, RMI_F11_CTRL_REG_COUNT);
 			if (rc < 0)
 				dev_warn(&fn->dev, "Failed to write to delta_y_threshold %d. Code:=
 %d.\n",
 					i, rc);
 		}
-
-		rmi_f11_setup_sensor_debugfs(sensor);
 	}
=20
-	rmi_f11_setup_debugfs(fn);
-
 	mutex_init(&f11->dev_controls_mutex);
 	return 0;
 }
@@ -1907,8 +780,12 @@ static int rmi_f11_register_devices(struct rmi_fu=
nction *fn)
 	int sensors_itertd =3D 0;
 	int i;
 	int rc;
+	int board, version;
+
+	board =3D driver_data->board;
+	version =3D driver_data->rev;
=20
-	for (i =3D 0; i < (f11->dev_query.nbr_of_sensors + 1); i++) {
+	for (i =3D 0; i < (f11->nr_sensors + 1); i++) {
 		struct f11_2d_sensor *sensor =3D &f11->sensors[i];
 		sensors_itertd =3D i;
 		input_dev =3D input_allocate_device();
@@ -1927,8 +804,8 @@ static int rmi_f11_register_devices(struct rmi_fun=
ction *fn)
 				goto error_unregister;
 			}
 		}
-		sprintf(sensor->input_phys, "%s.abs%d/input0",
-			dev_name(&fn->dev), i);
+		snprintf(sensor->input_phys, NAME_BUFFER_SIZE,
+			 "%s.abs%d/input0", dev_name(&fn->dev), i);
 		input_dev->phys =3D sensor->input_phys;
 		input_dev->dev.parent =3D &rmi_dev->dev;
 		input_set_drvdata(input_dev, f11);
@@ -1939,7 +816,7 @@ static int rmi_f11_register_devices(struct rmi_fun=
ction *fn)
=20
 		f11_set_abs_params(fn, i);
=20
-		if (sensor->sens_query.info.has_rel) {
+		if (sensor->sens_query.has_rel) {
 			set_bit(EV_REL, input_dev->evbit);
 			set_bit(REL_X, input_dev->relbit);
 			set_bit(REL_Y, input_dev->relbit);
@@ -1951,7 +828,7 @@ static int rmi_f11_register_devices(struct rmi_fun=
ction *fn)
 			goto error_unregister;
 		}
=20
-		if (sensor->sens_query.info.has_rel) {
+		if (sensor->sens_query.has_rel) {
 			/*create input device for mouse events  */
 			input_dev_mouse =3D input_allocate_device();
 			if (!input_dev_mouse) {
@@ -1964,14 +841,13 @@ static int rmi_f11_register_devices(struct rmi_f=
unction *fn)
 				rc =3D driver->set_input_params(rmi_dev,
 					input_dev_mouse);
 				if (rc < 0) {
-					dev_err(&fn->dev,
-					"%s: Error in setting input device.\n",
+					dev_err(&fn->dev, "%s: Error in setting input device.\n",
 					__func__);
 					goto error_unregister;
 				}
 			}
-			sprintf(sensor->input_phys_mouse, "%s.rel%d/input0",
-				dev_name(&fn->dev), i);
+			snprintf(sensor->input_phys_mouse, NAME_BUFFER_SIZE,
+				 "%s.rel%d/input0", dev_name(&fn->dev), i);
 			set_bit(EV_REL, input_dev_mouse->evbit);
 			set_bit(REL_X, input_dev_mouse->relbit);
 			set_bit(REL_Y, input_dev_mouse->relbit);
@@ -2018,7 +894,7 @@ static void rmi_f11_free_devices(struct rmi_functi=
on *fn)
 	struct f11_data *f11 =3D fn->data;
 	int i;
=20
-	for (i =3D 0; i < (f11->dev_query.nbr_of_sensors + 1); i++) {
+	for (i =3D 0; i < (f11->nr_sensors + 1); i++) {
 		if (f11->sensors[i].input)
 			input_unregister_device(f11->sensors[i].input);
 		if (f11->sensors[i].mouse_input)
@@ -2032,9 +908,9 @@ static int rmi_f11_config(struct rmi_function *fn)
 	int i;
 	int rc;
=20
-	for (i =3D 0; i < (f11->dev_query.nbr_of_sensors + 1); i++) {
+	for (i =3D 0; i < (f11->nr_sensors + 1); i++) {
 		rc =3D f11_write_control_regs(fn, &f11->sensors[i].sens_query,
-				   &f11->dev_controls, fn->fd.query_base_addr);
+				&f11->dev_controls, fn->fd.query_base_addr);
 		if (rc < 0)
 			return rc;
 	}
@@ -2052,7 +928,9 @@ int rmi_f11_attention(struct rmi_function *fn,
 	int error;
 	int i;
=20
-	for (i =3D 0; i < f11->dev_query.nbr_of_sensors + 1; i++) {
+	f11->report_count++;
+
+	for (i =3D 0; i < f11->nr_sensors + 1; i++) {
 		error =3D rmi_read_block(rmi_dev,
 				data_base_addr + data_base_addr_offset,
 				f11->sensors[i].data_pkt,
@@ -2067,79 +945,67 @@ int rmi_f11_attention(struct rmi_function *fn,
 	return 0;
 }
=20
-#ifdef CONFIG_PM_SLEEP
+#ifdef CONFIG_PM
 static int rmi_f11_resume(struct device *dev)
 {
 	struct rmi_function *fn =3D to_rmi_function(dev);
 	struct rmi_device *rmi_dev =3D fn->rmi_dev;
 	struct f11_data *data =3D fn->data;
-	/* Command register always reads as 0, so we can just use a local. */
-	struct f11_2d_commands commands =3D {
-		.rezero =3D true,
-	};
-	int error;
+	int retval =3D 0;
=20
 	dev_dbg(&fn->dev, "Resuming...\n");
 	if (!data->rezero_wait_ms)
 		return 0;
=20
-	mdelay(data->rezero_wait_ms);
+	msleep(data->rezero_wait_ms);
=20
-	error =3D rmi_write_block(rmi_dev, fn->fd.command_base_addr,
-				&commands, sizeof(commands));
-	if (error < 0) {
-		dev_err(&fn->dev,
-			"%s: failed to issue rezero command, error =3D %d.",
-			__func__, error);
-		return error;
+	retval =3D rmi_write(rmi_dev, fn->fd.command_base_addr, RMI_F11_REZER=
O);
+	if (retval < 0) {
+		dev_err(&fn->dev, "%s: failed to issue rezero command, error =3D %d.=
",
+			__func__, retval);
+		return retval;
 	}
=20
-	return 0;
+	return retval;
 }
 #endif /* CONFIG_PM_SLEEP */
=20
 static SIMPLE_DEV_PM_OPS(rmi_f11_pm_ops, NULL, rmi_f11_resume);
=20
-static int rmi_f11_probe(struct rmi_function *fn)
+static int rmi_f11_remove(struct rmi_function *fn)
 {
-	int error;
-
-	error =3D rmi_f11_initialize(fn);
-	if (error)
-		return error;
-
-	error =3D rmi_f11_register_devices(fn);
-	if (error)
-		return error;
-
-	error =3D sysfs_create_group(&fn->dev.kobj, &rmi_f11_attr_group);
-	if (error)
-		return error;
-
+	rmi_f11_free_devices(fn);
 	return 0;
 }
=20
-static void rmi_f11_remove(struct rmi_function *fn)
+static int rmi_f11_probe(struct rmi_function *fn)
 {
-	debugfs_remove_recursive(fn->debugfs_root);
-	sysfs_remove_group(&fn->dev.kobj, &rmi_f11_attr_group);
+	int rc;
=20
-	rmi_f11_free_devices(fn);
+	rc =3D rmi_f11_initialize(fn);
+	if (rc < 0)
+		return rc;
+
+	rc =3D rmi_f11_register_devices(fn);
+	if (rc < 0)
+		return rc;
+
+	return 0;
 }
=20
-static struct rmi_function_handler rmi_f11_handler =3D {
+static struct rmi_function_driver function_driver =3D {
 	.driver =3D {
-		.name	=3D "rmi_f11",
-		.pm	=3D &rmi_f11_pm_ops,
+		.name =3D "rmi_f11",
+		.pm =3D &rmi_f11_pm_ops,
 	},
-	.func		=3D 0x11,
-	.probe		=3D rmi_f11_probe,
-	.remove		=3D rmi_f11_remove,
-	.config		=3D rmi_f11_config,
-	.attention	=3D rmi_f11_attention,
+	.func =3D FUNCTION_NUMBER,
+	.probe =3D rmi_f11_probe,
+	.remove =3D rmi_f11_remove,
+	.config =3D rmi_f11_config,
+	.attention =3D rmi_f11_attention,
 };
=20
-module_rmi_driver(rmi_f11_handler);
+module_rmi_function_driver(function_driver);
=20
 MODULE_AUTHOR("Christopher Heiny <cheiny@synaptics.com");
 MODULE_DESCRIPTION("RMI F11 module");
diff --git a/drivers/input/rmi4/rmi_f11.h b/drivers/input/rmi4/rmi_f11.=
h
new file mode 100644
index 0000000..35467e2
--- /dev/null
+++ b/drivers/input/rmi4/rmi_f11.h
@@ -0,0 +1,547 @@
+/*
+ * Copyright (c) 2013 Synaptics Incorporated
+ *
+ * This program is free software; you can redistribute it and/or modif=
y it
+ * under the terms of the GNU General Public License version 2 as publ=
ished by
+ * the Free Software Foundation.
+ */
+
+#ifndef RMI_F11_CONTROL_H
+#define RMI_F11_CONTROL_H
+
+#define F11_MAX_NUM_OF_SENSORS 8
+
+#define NAME_BUFFER_SIZE 256
+
+/** A note about RMI4 F11 register structure.
+ *
+ *  There may be one or more individual 2D touch surfaces associated w=
ith an
+ * instance for F11.  For example, a handheld device might have a touc=
hscreen
+ * display on the front, and a touchpad on the back.  F11 represents t=
hese touch
+ * surfaces as individual sensors, up to 7 on a given RMI4 device.
+ *
+ * The properties for
+ * a given sensor are described by its query registers.  The number of=
 query
+ * registers and the layout of their contents are described by the F11=
 device
+ * queries as well as the per-sensor query information.  The query reg=
isters
+ * for sensor[n+1] immediately follow those for sensor[n], so the star=
t address
+ * of the sensor[n+1] queries can only be computed if you know the siz=
e of the
+ * sensor[n] queries.  Because each of the sensors may have different
+ * properties, the size of the query registers for each sensor must be
+ * calculated on a sensor by sensor basis.
+ *
+ * Similarly, each sensor has control registers that govern its behavi=
or.  The
+ * size and layout of the control registers for a given sensor can be =
determined
+ * by parsing that sensors query registers.  The control registers for
+ * sensor[n+1] immediately follow those for sensor[n], so you can only=
 know
+ * the start address for the sensor[n+1] controls if you know the size=
 (and
+ * location) of the sensor[n] controls.
+ *
+ * And in a likewise fashion, each sensor has data registers where it =
reports
+ * its touch data and other interesting stuff.  The size and layout of=
 a
+ * sensors data registers must be determined by parsing its query regi=
sters.
+ * The data registers for sensor[n+1] immediately follow those for sen=
sor[n],
+ * so you can only know the start address for the sensor[n+1] controls=
 if you
+ * know the size (and location) of the sensor[n] controls.
+ *
+ * The short story is that we need to read and parse a lot of query
+ * registers in order to determine the attributes of a sensor[0].  The=
n
+ * we need to use that data to compute the size of the control and dat=
a
+ * registers for sensor[0].  Once we have that figured out, we can the=
n do
+ * the same thing for each subsequent sensor.
+ *
+ * The end result is that we have a number of structs that aren't used=
 to
+ * directly generate the input events, but their size, location and co=
ntents
+ * are critical to determining where the data we are interested in liv=
es.
+ *
+ * At this time, the driver does not yet comprehend all possible F11
+ * configuration options, but it should be sufficient to cover 99% of =
RMI4 F11
+ * devices currently in the field.
+ */
+
+/**
+ * @rezero - writing this to the F11 command register will cause the s=
ensor to
+ * calibrate to the current capacitive state.
+ */
+#define RMI_F11_REZERO  0x01
+
+/** Nr sensors will be going away in the near future, but for now we s=
till
+ * need to worry about it.
+ */
+#define RMI_F11_NR_SENSORS_MASK		0x07
+#define RMI_F11_HAS_QUERY9		(1 << 3)
+#define RMI_F11_HAS_QUERY11		(1 << 4)
+#define RMI_F11_HAS_QUERY12		(1 << 5)
+#define RMI_F11_HAS_QUERY27		(1 << 6)
+#define RMI_F11_HAS_QUERY28		(1 << 7)
+
+/** Defs for Query 1 */
+
+#define RMI_F11_NR_FINGERS_MASK 0x07
+#define RMI_F11_HAS_REL			(1 << 3)
+#define RMI_F11_HAS_ABS			(1 << 4)
+#define RMI_F11_HAS_GESTURES		(1 << 5)
+#define RMI_F11_HAS_SENSITIVITY_ADJ	(1 << 6)
+#define RMI_F11_CONFIGURABLE		(1 << 7)
+
+/** Defs for Query 2, 3, and 4. */
+#define RMI_F11_NR_ELECTRODES_MASK	0x7F
+
+/** Defs for Query 5 */
+
+#define RMI_F11_ABS_DATA_SIZE_MASK	0x03
+#define RMI_F11_HAS_ANCHORED_FINGER	(1 << 2)
+#define RMI_F11_HAS_ADJ_HYST		(1 << 3)
+#define RMI_F11_HAS_DRIBBLE		(1 << 4)
+#define RMI_F11_HAS_BENDING_CORRECTION	(1 << 5)
+#define RMI_F11_HAS_LARGE_OBJECT_SUPPRESSION	(1 << 6)
+#define RMI_F11_HAS_JITTER_FILTER	(1 << 7)
+
+/** Defs for Query 7 */
+#define RMI_F11_HAS_SINGLE_TAP			(1 << 0)
+#define RMI_F11_HAS_TAP_AND_HOLD		(1 << 1)
+#define RMI_F11_HAS_DOUBLE_TAP			(1 << 2)
+#define RMI_F11_HAS_EARLY_TAP			(1 << 3)
+#define RMI_F11_HAS_FLICK			(1 << 4)
+#define RMI_F11_HAS_PRESS			(1 << 5)
+#define RMI_F11_HAS_PINCH			(1 << 6)
+#define RMI_F11_HAS_CHIRAL			(1 << 7)
+
+/** Defs for Query 8 */
+#define RMI_F11_HAS_PALM_DET			(1 << 0)
+#define RMI_F11_HAS_ROTATE			(1 << 1)
+#define RMI_F11_HAS_TOUCH_SHAPES		(1 << 2)
+#define RMI_F11_HAS_SCROLL_ZONES		(1 << 3)
+#define RMI_F11_HAS_INDIVIDUAL_SCROLL_ZONES	(1 << 4)
+#define RMI_F11_HAS_MF_SCROLL			(1 << 5)
+#define RMI_F11_HAS_MF_EDGE_MOTION		(1 << 6)
+#define RMI_F11_HAS_MF_SCROLL_INERTIA		(1 << 7)
+
+/** Defs for Query 9. */
+#define RMI_F11_HAS_PEN				(1 << 0)
+#define RMI_F11_HAS_PROXIMITY			(1 << 1)
+#define RMI_F11_HAS_PALM_DET_SENSITIVITY	(1 << 2)
+#define RMI_F11_HAS_SUPPRESS_ON_PALM_DETECT	(1 << 3)
+#define RMI_F11_HAS_TWO_PEN_THRESHOLDS		(1 << 4)
+#define RMI_F11_HAS_CONTACT_GEOMETRY		(1 << 5)
+#define RMI_F11_HAS_PEN_HOVER_DISCRIMINATION	(1 << 6)
+#define RMI_F11_HAS_PEN_FILTERS			(1 << 7)
+
+/** Defs for Query 10. */
+#define RMI_F11_NR_TOUCH_SHAPES_MASK		0x1F
+
+/** Defs for Query 11 */
+
+#define RMI_F11_HAS_Z_TUNING			(1 << 0)
+#define RMI_F11_HAS_ALGORITHM_SELECTION		(1 << 1)
+#define RMI_F11_HAS_W_TUNING			(1 << 2)
+#define RMI_F11_HAS_PITCH_INFO			(1 << 3)
+#define RMI_F11_HAS_FINGER_SIZE			(1 << 4)
+#define RMI_F11_HAS_SEGMENTATION_AGGRESSIVENESS	(1 << 5)
+#define RMI_F11_HAS_XY_CLIP			(1 << 6)
+#define RMI_F11_HAS_DRUMMING_FILTER		(1 << 7)
+
+/** Defs for Query 12. */
+
+#define RMI_F11_HAS_GAPLESS_FINGER		(1 << 0)
+#define RMI_F11_HAS_GAPLESS_FINGER_TUNING	(1 << 1)
+#define RMI_F11_HAS_8BIT_W			(1 << 2)
+#define RMI_F11_HAS_ADJUSTABLE_MAPPING		(1 << 3)
+#define RMI_F11_HAS_INFO2			(1 << 4)
+#define RMI_F11_HAS_PHYSICAL_PROPS		(1 << 5)
+#define RMI_F11_HAS_FINGER_LIMIT		(1 << 6)
+#define RMI_F11_HAS_LINEAR_COEFF		(1 << 7)
+
+/** Defs for Query 13. */
+
+#define RMI_F11_JITTER_WINDOW_MASK		0x1F
+#define RMI_F11_JITTER_FILTER_MASK		0x60
+#define RMI_F11_JITTER_FILTER_SHIFT		5
+
+/** Defs for Query 14. */
+#define RMI_F11_LIGHT_CONTROL_MASK		0x03
+#define RMI_F11_IS_CLEAR			(1 << 2)
+#define RMI_F11_CLICKPAD_PROPS_MASK		0x18
+#define RMI_F11_CLICKPAD_PROPS_SHIFT		3
+#define RMI_F11_MOUSE_BUTTONS_MASK		0x60
+#define RMI_F11_MOUSE_BUTTONS_SHIFT		5
+#define RMI_F11_HAS_ADVANCED_GESTURES		(1 << 7)
+
+#define RMI_F11_QUERY_SIZE			4
+#define RMI_F11_QUERY_GESTURE_SIZE		2
+
+#define F11_LIGHT_CTL_NONE 0x00
+#define F11_LUXPAD	   0x01
+#define F11_DUAL_MODE      0x02
+
+#define F11_NOT_CLICKPAD     0x00
+#define F11_HINGED_CLICKPAD  0x01
+#define F11_UNIFORM_CLICKPAD 0x02
+
+/**
+ * Query registers 1 through 4 are always present.
+ *
+ * @nr_fingers - describes the maximum number of fingers the 2-D senso=
r
+ * supports.
+ * @has_rel - the sensor supports relative motion reporting.
+ * @has_abs - the sensor supports absolute poition reporting.
+ * @has_gestures - the sensor supports gesture reporting.
+ * @has_sensitivity_adjust - the sensor supports a global sensitivity
+ * adjustment.
+ * @configurable - the sensor supports various configuration options.
+ * @num_of_x_electrodes -  the maximum number of electrodes the 2-D se=
nsor
+ * supports on the X axis.
+ * @num_of_y_electrodes -  the maximum number of electrodes the 2-D se=
nsor
+ * supports on the Y axis.
+ * @max_electrodes - the total number of X and Y electrodes that may b=
e
+ * configured.
+ *
+ * Query 5 is present if the has_abs bit is set.
+ *
+ * @abs_data_size - describes the format of data reported by the absol=
ute
+ * data source.  Only one format (the kind used here) is supported at =
this
+ * time.
+ * @has_anchored_finger - then the sensor supports the high-precision =
second
+ * finger tracking provided by the manual tracking and motion sensitiv=
ity
+ * options.
+ * @has_adjust_hyst - the difference between the finger release thresh=
old and
+ * the touch threshold.
+ * @has_dribble - the sensor supports the generation of dribble interr=
upts,
+ * which may be enabled or disabled with the dribble control bit.
+ * @has_bending_correction - Bending related data registers 28 and 36,=
 and
+ * control register 52..57 are present.
+ * @has_large_object_suppression - control register 58 and data regist=
er 28
+ * exist.
+ * @has_jitter_filter - query 13 and control 73..76 exist.
+ *
+ * Gesture information queries 7 and 8 are present if has_gestures bit=
 is set.
+ *
+ * @has_single_tap - a basic single-tap gesture is supported.
+ * @has_tap_n_hold - tap-and-hold gesture is supported.
+ * @has_double_tap - double-tap gesture is supported.
+ * @has_early_tap - early tap is supported and reported as soon as the=
 finger
+ * lifts for any tap event that could be interpreted as either a singl=
e tap
+ * or as the first tap of a double-tap or tap-and-hold gesture.
+ * @has_flick - flick detection is supported.
+ * @has_press - press gesture reporting is supported.
+ * @has_pinch - pinch gesture detection is supported.
+ * @has_palm_det - the 2-D sensor notifies the host whenever a large c=
onductive
+ * object such as a palm or a cheek touches the 2-D sensor.
+ * @has_rotate - rotation gesture detection is supported.
+ * @has_touch_shapes - TouchShapes are supported.  A TouchShape is a f=
ixed
+ * rectangular area on the sensor that behaves like a capacitive butto=
n.
+ * @has_scroll_zones - scrolling areas near the sensor edges are suppo=
rted.
+ * @has_individual_scroll_zones - if 1, then 4 scroll zones are suppor=
ted;
+ * if 0, then only two are supported.
+ * @has_mf_scroll - the multifinger_scrolling bit will be set when
+ * more than one finger is involved in a scrolling action.
+ *
+ * Convenience for checking bytes in the gesture info registers.  This=
 is done
+ * often enough that we put it here to declutter the conditionals
+ *
+ * @query7_nonzero - true if none of the query 7 bits are set
+ * @query8_nonzero - true if none of the query 8 bits are set
+ *
+ * Query 9 is present if the has_query9 is set.
+ *
+ * @has_pen - detection of a stylus is supported and registers F11_2D_=
Ctrl20
+ * and F11_2D_Ctrl21 exist.
+ * @has_proximity - detection of fingers near the sensor is supported =
and
+ * registers F11_2D_Ctrl22 through F11_2D_Ctrl26 exist.
+ * @has_palm_det_sensitivity -  the sensor supports the palm detect se=
nsitivity
+ * feature and register F11_2D_Ctrl27 exists.
+ * @has_two_pen_thresholds - is has_pen is also set, then F11_2D_Ctrl3=
5 exists.
+ * @has_contact_geometry - the sensor supports the use of contact geom=
etry to
+ * map absolute X and Y target positions and registers F11_2D_Data18
+ * through F11_2D_Data27 exist.
+ *
+ * Touch shape info (query 10) is present if has_touch_shapes is set.
+ *
+ * @nr_touch_shapes - the total number of touch shapes supported.
+ *
+ * Query 11 is present if the has_query11 bit is set in query 0.
+ *
+ * @has_z_tuning - if set, the sensor supports Z tuning and registers
+ * F11_2D_Ctrl29 through F11_2D_Ctrl33 exist.
+ * @has_algorithm_selection - controls choice of noise suppression alg=
orithm
+ * @has_w_tuning - the sensor supports Wx and Wy scaling and registers
+ * F11_2D_Ctrl36 through F11_2D_Ctrl39 exist.
+ * @has_pitch_info - the X and Y pitches of the sensor electrodes can =
be
+ * configured and registers F11_2D_Ctrl40 and F11_2D_Ctrl41 exist.
+ * @has_finger_size -  the default finger width settings for the
+ * sensor can be configured and registers F11_2D_Ctrl42 through F11_2D=
_Ctrl44
+ * exist.
+ * @has_segmentation_aggressiveness - the sensor=E2=80=99s ability to =
distinguish
+ * multiple objects close together can be configured and register F11_=
2D_Ctrl45
+ * exists.
+ * @has_XY_clip -  the inactive outside borders of the sensor can be
+ * configured and registers F11_2D_Ctrl46 through F11_2D_Ctrl49 exist.
+ * @has_drumming_filter - the sensor can be configured to distinguish
+ * between a fast flick and a quick drumming movement and registers
+ * F11_2D_Ctrl50 and F11_2D_Ctrl51 exist.
+ *
+ * Query 12 is present if hasQuery12 bit is set.
+ *
+ * @has_gapless_finger - control registers relating to gapless finger =
are
+ * present.
+ * @has_gapless_finger_tuning - additional control and data registers =
relating
+ * to gapless finger are present.
+ * @has_8bit_w - larger W value reporting is supported.
+ * @has_adjustable_mapping - TBD
+ * @has_info2 - the general info query14 is present
+ * @has_physical_props - additional queries describing the physical pr=
operties
+ * of the sensor are present.
+ * @has_finger_limit - indicates that F11 Ctrl 80 exists.
+ * @has_linear_coeff - indicates that F11 Ctrl 81 exists.
+ *
+ * Query 13 is present if Query 5's has_jitter_filter bit is set.
+ * @jitter_window_size - used by Design Studio 4.
+ * @jitter_filter_type - used by Design Studio 4.
+ *
+ * Query 14 is present if query 12's has_general_info2 flag is set.
+ *
+ * @light_control - Indicates what light/led control features are pres=
ent, if
+ * any.
+ * @is_clear - if set, this is a clear sensor (indicating direct point=
ing
+ * application), otherwise it's opaque (indicating indirect pointing).
+ * @clickpad_props - specifies if this is a clickpad, and if so what s=
ort of
+ * mechanism it uses
+ * @mouse_buttons - specifies the number of mouse buttons present (if =
any).
+ * @has_advanced_gestures - advanced driver gestures are supported.
+ */
+struct f11_2d_sensor_queries {
+	/* query1 */
+	u8 nr_fingers;
+	bool has_rel;
+	bool has_abs;
+	bool has_gestures;
+	bool has_sensitivity_adjust;
+	bool configurable;
+
+	/* query2 */
+	u8 nr_x_electrodes;
+
+	/* query3 */
+	u8 nr_y_electrodes;
+
+	/* query4 */
+	u8 max_electrodes;
+
+	/* query5 */
+	u8 abs_data_size;
+	bool has_anchored_finger;
+	bool has_adj_hyst;
+	bool has_dribble;
+	bool has_bending_correction;
+	bool has_large_object_suppression;
+	bool has_jitter_filter;
+
+	u8 f11_2d_query6;
+
+	/* query 7 */
+	bool has_single_tap;
+	bool has_tap_n_hold;
+	bool has_double_tap;
+	bool has_early_tap;
+	bool has_flick;
+	bool has_press;
+	bool has_pinch;
+	bool has_chiral;
+
+	bool query7_nonzero;
+
+	/* query 8 */
+	bool has_palm_det;
+	bool has_rotate;
+	bool has_touch_shapes;
+	bool has_scroll_zones;
+	bool has_individual_scroll_zones;
+	bool has_mf_scroll;
+	bool has_mf_edge_motion;
+	bool has_mf_scroll_inertia;
+
+	bool query8_nonzero;
+
+	/* Query 9 */
+	bool has_pen;
+	bool has_proximity;
+	bool has_palm_det_sensitivity;
+	bool has_suppress_on_palm_detect;
+	bool has_two_pen_thresholds;
+	bool has_contact_geometry;
+	bool has_pen_hover_discrimination;
+	bool has_pen_filters;
+
+	/* Query 10 */
+	u8 nr_touch_shapes;
+
+	/* Query 11. */
+	bool has_z_tuning;
+	bool has_algorithm_selection;
+	bool has_w_tuning;
+	bool has_pitch_info;
+	bool has_finger_size;
+	bool has_segmentation_aggressiveness;
+	bool has_XY_clip;
+	bool has_drumming_filter;
+
+	/* Query 12 */
+	bool has_gapless_finger;
+	bool has_gapless_finger_tuning;
+	bool has_8bit_w;
+	bool has_adjustable_mapping;
+	bool has_info2;
+	bool has_physical_props;
+	bool has_finger_limit;
+	bool has_linear_coeff_2;
+
+	/* Query 13 */
+	u8 jitter_window_size;
+	u8 jitter_filter_type;
+
+	/* Query 14 */
+	u8 light_control;
+	bool is_clear;
+	u8 clickpad_props;
+	u8 mouse_buttons;
+	bool has_advanced_gestures;
+};
+
+/* Defs for Ctrl0. */
+#define RMI_F11_REPORT_MODE_MASK	0x07
+#define RMI_F11_ABS_POS_FILT		(1 << 3)
+#define RMI_F11_REL_POS_FILT		(1 << 4)
+#define RMI_F11_REL_BALLISTICS		(1 << 5)
+#define RMI_F11_DRIBBLE			(1 << 6)
+#define RMI_F11_REPORT_BEYOND_CLIP	(1 << 7)
+
+/* Defs for Ctrl1. */
+#define RMI_F11_PALM_DETECT_THRESH_MASK	0x0F
+#define RMI_F11_MOTION_SENSITIVITY_MASK	0x30
+#define RMI_F11_MANUAL_TRACKING		(1 << 6)
+#define RMI_F11_MANUAL_TRACKED_FINGER	(1 << 7)
+
+#define RMI_F11_DELTA_X_THRESHOLD	2
+#define RMI_F11_DELTA_Y_THRESHOLD	3
+
+#define RMI_F11_CTRL_REG_COUNT		10
+
+struct f11_2d_ctrl {
+	u8		ctrl0_9[RMI_F11_CTRL_REG_COUNT];
+	u16		ctrl0_9_address;
+};
+
+#define RMI_F11_ABS_BYTES 5
+#define RMI_F11_REL_BYTES 2
+
+/* Defs for Data 8 */
+
+#define RMI_F11_SINGLE_TAP		(1 << 0)
+#define RMI_F11_TAP_AND_HOLD		(1 << 1)
+#define RMI_F11_DOUBLE_TAP		(1 << 2)
+#define RMI_F11_EARLY_TAP		(1 << 3)
+#define RMI_F11_FLICK			(1 << 4)
+#define RMI_F11_PRESS			(1 << 5)
+#define RMI_F11_PINCH			(1 << 6)
+
+/* Defs for Data 9 */
+
+#define RMI_F11_PALM_DETECT			(1 << 0)
+#define RMI_F11_ROTATE				(1 << 1)
+#define RMI_F11_SHAPE				(1 << 2)
+#define RMI_F11_SCROLLZONE			(1 << 3)
+#define RMI_F11_GESTURE_FINGER_COUNT_MASK	0x70
+
+/** Handy pointers into our data buffer.
+ *
+ * @f_state - start of finger state registers.
+ * @abs_pos - start of absolute position registers (if present).
+ * @rel_pos - start of relative data registers (if present).
+ * @gest_1  - gesture flags (if present).
+ * @gest_2  - gesture flags & finger count (if present).
+ * @pinch   - pinch motion register (if present).
+ * @flick   - flick distance X & Y, flick time (if present).
+ * @rotate  - rotate motion and finger separation.
+ * @multi_scroll - chiral deltas for X and Y (if present).
+ * @scroll_zones - scroll deltas for 4 regions (if present).
+ */
+struct f11_2d_data {
+	u8	*f_state;
+	u8	*abs_pos;
+	s8	*rel_pos;
+	u8	*gest_1;
+	u8	*gest_2;
+	s8	*pinch;
+	u8	*flick;
+	u8	*rotate;
+	s8	*multi_scroll;
+	s8	*scroll_zones;
+};
+
+/**
+ * @axis_align - controls parameters that are useful in system prototy=
ping
+ * and bring up.
+ * @sens_query - query registers for this particular sensor.
+ * @data - the data reported by this sensor, mapped into a collection =
of
+ * structs.
+ * @max_x - The maximum X coordinate that will be reported by this sen=
sor.
+ * @max_y - The maximum Y coordinate that will be reported by this sen=
sor.
+ * @nbr_fingers - How many fingers can this sensor report?
+ * @data_pkt - buffer for data reported by this sensor.
+ * @pkt_size - number of bytes in that buffer.
+ * @sensor_index - identifies this particular 2D touch sensor
+ * @type_a - some early RMI4 2D sensors do not reliably track the fing=
er
+ * position when two fingers are on the device.  When this is true, we
+ * assume we have one of those sensors and report events appropriately=
=2E
+ * @sensor_type - indicates whether we're touchscreen or touchpad.
+ * @input - input device for absolute pointing stream
+ * @mouse_input - input device for relative pointing stream.
+ * @input_phys - buffer for the absolute phys name for this sensor.
+ * @input_phys_mouse - buffer for the relative phys name for this sens=
or.
+ */
+struct f11_2d_sensor {
+	struct rmi_f11_2d_axis_alignment axis_align;
+	struct f11_2d_sensor_queries sens_query;
+	struct f11_2d_data data;
+	u16 max_x;
+	u16 max_y;
+	u8 nbr_fingers;
+	u8 *data_pkt;
+	int pkt_size;
+	u8 sensor_index;
+	u8 *button_map;
+	u32 type_a;
+	enum rmi_f11_sensor_type sensor_type;
+	struct input_dev *input;
+	struct input_dev *mouse_input;
+	struct rmi_function *fn;
+	char input_phys[NAME_BUFFER_SIZE];
+	char input_phys_mouse[NAME_BUFFER_SIZE];
+};
+
+/** Data pertaining to F11 in general.  For per-sensor data, see struc=
t
+ * f11_2d_sensor.
+ *
+ * @dev_query - F11 device specific query registers.
+ * @dev_controls - F11 device specific control registers.
+ * @dev_controls_mutex - lock for the control registers.
+ * @rezero_wait_ms - if nonzero, upon resume we will wait this many
+ * milliseconds before rezeroing the sensor(s).  This is useful in sys=
tems with
+ * poor electrical behavior on resume, where the initial calibration o=
f the
+ * sensor(s) coming out of sleep state may be bogus.
+ * @sensors - per sensor data structures.
+ */
+struct f11_data {
+	u8 nr_sensors;
+	bool has_query9;
+	bool has_query11;
+	bool has_query12;
+	bool has_query27;
+	bool has_query28;
+	struct f11_2d_ctrl dev_controls;
+	struct mutex dev_controls_mutex;
+	u16 rezero_wait_ms;
+	u64 report_count;
+	struct f11_2d_sensor sensors[F11_MAX_NUM_OF_SENSORS];
+};
+#endif
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
