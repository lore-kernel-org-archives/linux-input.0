From: Christopher Heiny <cheiny@synaptics.com>
Subject: =?UTF-8?q?=5BRFC=20PATCH=2006/06=5D=20input/rmi4=3A=20F11=20-=202D=20touch=20interface?=
Date: Fri, 16 Nov 2012 19:58:54 -0800
Message-ID: <1353124734-16803-7-git-send-email-cheiny@synaptics.com>
References: <1353124734-16803-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1353124734-16803-1-git-send-email-cheiny@synaptics.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jean Delvare <khali@linux-fr.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Christopher Heiny <cheiny@synaptics.com>, Allie Xiong <axiong@synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Alexandra Chin <alexandra.chin@tw.synaptics.com>, Joerie de Gram <j.de.gram@gmail.com>, Wolfram Sang <w.sang@pengutronix.de>, Mathieu Poirier <mathieu.poirier@linaro.org>, Linus Walleij <linus.walleij@stericsson.com>, Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>
List-Id: linux-input@vger.kernel.org

rmi_f11.c is a driver for 2D touch sensors using the RMI4 protocol.  It=
 supports
both touchscreen and touchpad input, in both absolute and relative form=
ats.
Support for Type-B multitouch is the default, Type-A support is include=
d for
certain legacy sensors.


Signed-off-by: Christopher Heiny <cheiny@synaptics.com>

To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus Walleij <linus.walleij@stericsson.com>
Cc: Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>
Cc: Joeri de Gram <j.de.gram@gmail.com>

---

 drivers/input/rmi4/rmi_f11.c | 2813 ++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 2813 insertions(+), 0 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f11.c b/drivers/input/rmi4/rmi_f11.=
c
new file mode 100644
index 0000000..b9a84bc
--- /dev/null
+++ b/drivers/input/rmi4/rmi_f11.c
@@ -0,0 +1,2813 @@
+/*
+ * Copyright (c) 2011,2012 Synaptics Incorporated
+ * Copyright (c) 2011 Unixphere
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License as published b=
y
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#define FUNCTION_DATA f11_data
+#define FNUM 11
+
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/input.h>
+#include <linux/input/mt.h>
+#include <linux/kconfig.h>
+#include <linux/rmi.h>
+#include <linux/slab.h>
+#include "rmi_driver.h"
+
+#ifdef CONFIG_RMI4_DEBUG
+#include <linux/debugfs.h>
+#include <linux/fs.h>
+#include <linux/uaccess.h>
+#endif
+
+#define F11_MAX_NUM_OF_SENSORS		8
+#define F11_MAX_NUM_OF_FINGERS		10
+#define F11_MAX_NUM_OF_TOUCH_SHAPES	16
+
+#define F11_REL_POS_MIN		-128
+#define F11_REL_POS_MAX		127
+
+#define FINGER_STATE_MASK	0x03
+
+#define F11_CTRL_SENSOR_MAX_X_POS_OFFSET	6
+#define F11_CTRL_SENSOR_MAX_Y_POS_OFFSET	8
+
+#define DEFAULT_XY_MAX 9999
+#define DEFAULT_MAX_ABS_MT_PRESSURE 255
+#define DEFAULT_MAX_ABS_MT_TOUCH 15
+#define DEFAULT_MAX_ABS_MT_ORIENTATION 1
+#define DEFAULT_MIN_ABS_MT_TRACKING_ID 1
+#define DEFAULT_MAX_ABS_MT_TRACKING_ID 10
+#define NAME_BUFFER_SIZE 256
+#define FUNCTION_NUMBER 0x11
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
+ * @rezero - writing 1 to this will cause the sensor to calibrate to t=
he
+ * current capacitive state.
+ */
+struct f11_2d_commands {
+	bool rezero:1;
+	u8 reserved:7;
+} __attribute__((__packed__));
+
+/** This query is always present, and is on a per device basis.  All o=
ther
+ * queries are on a per-sensor basis.
+ *
+ * @nbr_of_sensors - the number of 2D sensors on the touch device.
+ * @has_query9 - indicates the F11_2D_Query9 register exists.
+ * @has_query11 - indicates the F11_2D_Query11 register exists.
+ * @has_query12 - indicates the F11_2D_Query12 register exists.
+ */
+struct f11_2d_device_query {
+	u8 nbr_of_sensors:3;
+	bool has_query9:1;
+	bool has_query11:1;
+	bool has_query12:1;
+	bool has_query27:1;
+	bool has_query28:1;
+} __attribute__((__packed__));
+
+/** Query registers 1 through 4 are always present.
+ * @number_of_fingers - describes the maximum number of fingers the 2-=
D sensor
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
+ */
+struct f11_2d_sensor_info {
+	/* query1 */
+	u8 number_of_fingers:3;
+	bool has_rel:1;
+	bool has_abs:1;
+	bool has_gestures:1;
+	bool has_sensitivity_adjust:1;
+	bool configurable:1;
+	/* query2 */
+	u8 num_of_x_electrodes:7;
+	u8 reserved_1:1;
+	/* query3 */
+	u8 num_of_y_electrodes:7;
+	u8 reserved_2:1;
+	/* query4 */
+	u8 max_electrodes:7;
+	u8 reserved_3:1;
+} __attribute__((__packed__));
+
+/** Query 5 - this is present if the has_abs bit is set.
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
+ */
+struct f11_2d_abs_info {
+	u8 abs_data_size:2;
+	bool has_anchored_finger:1;
+	bool has_adj_hyst:1;
+	bool has_dribble:1;
+	bool has_bending_correction:1;
+	bool has_large_object_suppression:1;
+	bool has_jitter_filter:1;
+} __attribute__((__packed__));
+
+/** Gesture information queries 7 and 8 are present if has_gestures bi=
t is set.
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
+ * @has_multi_finger_scroll - the multifinger_scrolling bit will be se=
t when
+ * more than one finger is involved in a scrolling action.
+ */
+struct f11_2d_gesture_info {
+	bool has_single_tap:1;
+	bool has_tap_n_hold:1;
+	bool has_double_tap:1;
+	bool has_early_tap:1;
+	bool has_flick:1;
+	bool has_press:1;
+	bool has_pinch:1;
+	bool has_chiral:1;
+
+	bool has_palm_det:1;
+	bool has_rotate:1;
+	bool has_touch_shapes:1;
+	bool has_scroll_zones:1;
+	bool has_individual_scroll_zones:1;
+	bool has_multi_finger_scroll:1;
+	bool has_mf_edge_motion:1;
+	bool has_mf_scroll_inertia:1;
+} __attribute__((__packed__));
+
+/** Utility for checking bytes in the gesture info registers.  This is=
 done
+ * often enough that we put it here to declutter the conditionals.
+ */
+static bool has_gesture_bits(const struct f11_2d_gesture_info *info,
+			     const u8 byte) {
+	return ((u8 *) info)[byte] !=3D 0;
+}
+
+/**
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
+ * map absolute X and Y target positions and registers F11_2D_Data18.*=
 through
+ * F11_2D_Data27 exist.
+ */
+struct f11_2d_query9 {
+	bool has_pen:1;
+	bool has_proximity:1;
+	bool has_palm_det_sensitivity:1;
+	bool has_suppress_on_palm_detect:1;
+	bool has_two_pen_thresholds:1;
+	bool has_contact_geometry:1;
+	bool has_pen_hover_discrimination:1;
+	bool has_pen_filters:1;
+} __attribute__((__packed__));
+
+/** Touch shape info (query 10) is present if has_touch_shapes is set.
+ *
+ * @nbr_touch_shapes - the total number of touch shapes supported.
+ */
+struct f11_2d_ts_info {
+	u8 nbr_touch_shapes:5;
+	u8 reserved:3;
+} __attribute__((__packed__));
+
+/** Query 11 is present if the has_query11 bit is set in query 0.
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
+ */
+struct f11_2d_query11 {
+	bool has_z_tuning:1;
+	bool has_algorithm_selection:1;
+	bool has_w_tuning:1;
+	bool has_pitch_info:1;
+	bool has_finger_size:1;
+	bool has_segmentation_aggressiveness:1;
+	bool has_XY_clip:1;
+	bool has_drumming_filter:1;
+} __attribute__((__packed__));
+
+/**
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
+ */
+struct f11_2d_query12 {
+	bool has_gapless_finger:1;
+	bool has_gapless_finger_tuning:1;
+	bool has_8bit_w:1;
+	bool has_adjustable_mapping:1;
+	bool has_info2:1;
+	bool has_physical_props:1;
+	bool has_finger_limit:1;
+	bool has_linear_coeff_2:1;
+} __attribute__((__packed__));
+
+/** This register is present if Query 5's has_jitter_filter bit is set=
=2E
+ * @jitter_window_size - used by Design Studio 4.
+ * @jitter_filter_type - used by Design Studio 4.
+ */
+struct f11_2d_query13 {
+	u8 jtter_window_size:5;
+	u8 jitter_filter_type:2;
+	u8 reserved:1;
+} __attribute__((__packed__));
+
+/** This register is present if query 12's has_general_info2 flag is s=
et.
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
+struct f11_2d_query14 {
+	u8 light_control:2;
+	bool is_clear:1;
+	u8 clickpad_props:2;
+	u8 mouse_buttons:2;
+	bool has_advanced_gestures:1;
+} __attribute__((__packed__));
+
+#define F11_LIGHT_CTL_NONE 0x00
+#define F11_LUXPAD	   0x01
+#define F11_DUAL_MODE      0x02
+
+#define F11_NOT_CLICKPAD     0x00
+#define F11_HINGED_CLICKPAD  0x01
+#define F11_UNIFORM_CLICKPAD 0x02
+
+/** See notes above for information about specific query register sets=
=2E
+ */
+struct f11_2d_sensor_queries {
+	struct f11_2d_sensor_info info;
+
+	struct f11_2d_abs_info abs_info;
+
+	u8 f11_2d_query6;
+
+	struct f11_2d_gesture_info gesture_info;
+
+	struct f11_2d_query9 query9;
+
+	struct f11_2d_ts_info ts_info;
+
+	struct f11_2d_query11 features_1;
+
+	struct f11_2d_query12 features_2;
+
+	struct f11_2d_query13 jitter_filter;
+
+	struct f11_2d_query14 info_2;
+};
+
+/**
+ * @reporting_mode - controls how often finger position data is report=
ed.
+ * @abs_pos_filt - when set, enables various noise and jitter filterin=
g
+ * algorithms for absolute reports.
+ * @rel_pos_filt - when set, enables various noise and jitter filterin=
g
+ * algorithms for relative reports.
+ * @rel_ballistics - enables ballistics processing for the relative fi=
nger
+ * motion on the 2-D sensor.
+ * @dribble - enables the dribbling feature.
+ * @report_beyond_clip - when this is set, fingers outside the active =
area
+ * specified by the x_clip and y_clip registers will be reported, but =
with
+ * reported finger position clipped to the edge of the active area.
+ * @palm_detect_thresh - the threshold at which a wide finger is consi=
dered a
+ * palm. A value of 0 inhibits palm detection.
+ * @motion_sensitivity - specifies the threshold an anchored finger mu=
st move
+ * before it is considered no longer anchored.  High values mean more
+ * sensitivity.
+ * @man_track_en - for anchored finger tracking, whether the host (1) =
or the
+ * device (0) determines which finger is the tracked finger.
+ * @man_tracked_finger - when man_track_en is 1, specifies whether fin=
ger 0 or
+ * finger 1 is the tracked finger.
+ * @delta_x_threshold - 2-D position update interrupts are inhibited u=
nless
+ * the finger moves more than a certain threshold distance along the X=
 axis.
+ * @delta_y_threshold - 2-D position update interrupts are inhibited u=
nless
+ * the finger moves more than a certain threshold distance along the Y=
 axis.
+ * @velocity - When rel_ballistics is set, this register defines the
+ * velocity ballistic parameter applied to all relative motion events.
+ * @acceleration - When rel_ballistics is set, this register defines t=
he
+ * acceleration ballistic parameter applied to all relative motion eve=
nts.
+ * @sensor_max_x_pos - the maximum X coordinate reported by the sensor=
=2E
+ * @sensor_max_y_pos - the maximum Y coordinate reported by the sensor=
=2E
+ */
+struct f11_2d_ctrl0_9 {
+	/* F11_2D_Ctrl0 */
+	u8 reporting_mode:3;
+	bool abs_pos_filt:1;
+	bool rel_pos_filt:1;
+	bool rel_ballistics:1;
+	bool dribble:1;
+	bool report_beyond_clip:1;
+	/* F11_2D_Ctrl1 */
+	u8 palm_detect_thres:4;
+	u8 motion_sensitivity:2;
+	bool man_track_en:1;
+	bool man_tracked_finger:1;
+	/* F11_2D_Ctrl2 and 3 */
+	u8 delta_x_threshold:8;
+	u8 delta_y_threshold:8;
+	/* F11_2D_Ctrl4 and 5 */
+	u8 velocity:8;
+	u8 acceleration:8;
+	/* F11_2D_Ctrl6 thru 9 */
+	u16 sensor_max_x_pos:12;
+	u8 ctrl7_reserved:4;
+	u16 sensor_max_y_pos:12;
+	u8 ctrl9_reserved:4;
+} __attribute__((__packed__));
+
+/**
+ * @single_tap_int_enable - enable tap gesture recognition.
+ * @tap_n_hold_int_enable - enable tap-and-hold gesture recognition.
+ * @double_tap_int_enable - enable double-tap gesture recognition.
+ * @early_tap_int_enable - enable early tap notification.
+ * @flick_int_enable - enable flick detection.
+ * @press_int_enable - enable press gesture recognition.
+ * @pinch_int_enable - enable pinch detection.
+ */
+struct f11_2d_ctrl10 {
+	bool single_tap_int_enable:1;
+	bool tap_n_hold_int_enable:1;
+	bool double_tap_int_enable:1;
+	bool early_tap_int_enable:1;
+	bool flick_int_enable:1;
+	bool press_int_enable:1;
+	bool pinch_int_enable:1;
+	u8 reserved:1;
+} __attribute__((__packed__));
+
+/**
+ * @palm_detect_int_enable - enable palm detection feature.
+ * @rotate_int_enable - enable rotate gesture detection.
+ * @touch_shape_int_enable - enable the TouchShape feature.
+ * @scroll_zone_int_enable - enable scroll zone reporting.
+ * @multi_finger_scroll_int_enable - enable the multfinger scroll feat=
ure.
+ */
+struct f11_2d_ctrl11 {
+	bool palm_detect_int_enable:1;
+	bool rotate_int_enable:1;
+	bool touch_shape_int_enable:1;
+	bool scroll_zone_int_enable:1;
+	bool multi_finger_scroll_int_enable:1;
+	u8 reserved:3;
+} __attribute__((__packed__));
+
+/**
+ * @sens_adjustment - allows a host to alter the overall sensitivity o=
f a
+ * 2-D sensor. A positive value in this register will make the sensor =
more
+ * sensitive than the factory defaults, and a negative value will make=
 it
+ * less sensitive.
+ * @hyst_adjustment - increase the touch/no-touch hysteresis by 2 Z-un=
its for
+ * each one unit increment in this setting.
+ */
+struct f11_2d_ctrl14 {
+	s8 sens_adjustment:5;
+	u8 hyst_adjustment:3;
+} __attribute__((__packed__));
+
+/**
+ * @max_tap_time - the maximum duration of a tap, in 10-millisecond un=
its.
+ */
+struct f11_2d_ctrl15 {
+	u8 max_tap_time:8;
+} __attribute__((__packed__));
+
+/**
+ * @min_press_time - The minimum duration required for stationary fing=
er(s) to
+ * generate a press gesture, in 10-millisecond units.
+ */
+struct f11_2d_ctrl16 {
+	u8 min_press_time:8;
+} __attribute__((__packed__));
+
+/**
+ * @max_tap_distance - Determines the maximum finger movement allowed =
during
+ * a tap, in 0.1-millimeter units.
+ */
+struct f11_2d_ctrl17 {
+	u8 max_tap_distance:8;
+} __attribute__((__packed__));
+
+/**
+ * @min_flick_distance - the minimum finger movement for a flick gestu=
re,
+ * in 1-millimeter units.
+ * @min_flick_speed - the minimum finger speed for a flick gesture, in
+ * 10-millimeter/second units.
+ */
+struct f11_2d_ctrl18_19 {
+	u8 min_flick_distance:8;
+	u8 min_flick_speed:8;
+} __attribute__((__packed__));
+
+/**
+ * @pen_detect_enable - enable reporting of stylus activity.
+ * @pen_jitter_filter_enable - Setting this enables the stylus anti-ji=
tter
+ * filter.
+ * @pen_z_threshold - This is the stylus-detection lower threshold. Sm=
aller
+ * values result in higher sensitivity.
+ */
+struct f11_2d_ctrl20_21 {
+	bool pen_detect_enable:1;
+	bool pen_jitter_filter_enable:1;
+	u8 ctrl20_reserved:6;
+	u8 pen_z_threshold:8;
+} __attribute__((__packed__));
+
+/**
+ * These are not accessible through sysfs yet.
+ *
+ * @proximity_detect_int_en - enable proximity detection feature.
+ * @proximity_jitter_filter_en - enables an anti-jitter filter on prox=
imity
+ * data.
+ * @proximity_detection_z_threshold - the threshold for finger-proximi=
ty
+ * detection.
+ * @proximity_delta_x_threshold - In reduced-reporting modes, this is =
the
+ * threshold for proximate-finger movement in the direction parallel t=
o the
+ * X-axis.
+ * @proximity_delta_y_threshold - In reduced-reporting modes, this is =
the
+ * threshold for proximate-finger movement in the direction parallel t=
o the
+ * Y-axis.
+ * * @proximity_delta_Z_threshold - In reduced-reporting modes, this i=
s the
+ * threshold for proximate-finger movement in the direction parallel t=
o the
+ * Z-axis.
+ */
+struct f11_2d_ctrl22_26 {
+	/* control 22 */
+	bool proximity_detect_int_en:1;
+	bool proximity_jitter_filter_en:1;
+	u8 f11_2d_ctrl6_b3__7:6;
+
+	/* control 23 */
+	u8 proximity_detection_z_threshold;
+
+	/* control 24 */
+	u8 proximity_delta_x_threshold;
+
+	/* control 25 */
+	u8 proximity_delta_y_threshold;
+
+	/* control 26 */
+	u8 proximity_delta_z_threshold;
+} __attribute__((__packed__));
+
+/**
+ * @palm_detecy_sensitivity - When this value is small, smaller object=
s will
+ * be identified as palms; when this value is large, only larger objec=
ts will
+ * be identified as palms. 0 represents the factory default.
+ * @suppress_on_palm_detect - when set, all F11 interrupts except palm=
_detect
+ * are suppressed while a palm is detected.
+ */
+struct f11_2d_ctrl27 {
+	s8 palm_detect_sensitivity:4;
+	bool suppress_on_palm_detect:1;
+	u8 f11_2d_ctrl27_b5__7:3;
+} __attribute__((__packed__));
+
+/**
+ * @multi_finger_scroll_mode - allows choice of multi-finger scroll mo=
de and
+ * determines whether and how X or Y displacements are reported.
+ * @edge_motion_en - enables the edge_motion feature.
+ * @multi_finger_scroll_momentum - controls the length of time that sc=
rolling
+ * continues after fingers have been lifted.
+ */
+struct f11_2d_ctrl28 {
+	u8 multi_finger_scroll_mode:2;
+	bool edge_motion_en:1;
+	bool f11_2d_ctrl28b_3:1;
+	u8 multi_finger_scroll_momentum:4;
+} __attribute__((__packed__));
+
+/**
+ * @z_touch_threshold - Specifies the finger-arrival Z threshold. Larg=
e values
+ * may cause smaller fingers to be rejected.
+ * @z_touch_hysteresis - Specifies the difference between the finger-a=
rrival
+ * Z threshold and the finger-departure Z threshold.
+ */
+struct f11_2d_ctrl29_30 {
+	u8 z_touch_threshold;
+	u8 z_touch_hysteresis;
+} __attribute__((__packed__));
+
+
+struct f11_2d_ctrl {
+	struct f11_2d_ctrl0_9		 *ctrl0_9;
+	u16				ctrl0_9_address;
+	struct f11_2d_ctrl10		*ctrl10;
+	struct f11_2d_ctrl11		*ctrl11;
+	u8				ctrl12_size;
+	struct f11_2d_ctrl14		*ctrl14;
+	struct f11_2d_ctrl15		*ctrl15;
+	struct f11_2d_ctrl16		*ctrl16;
+	struct f11_2d_ctrl17		*ctrl17;
+	struct f11_2d_ctrl18_19		*ctrl18_19;
+	struct f11_2d_ctrl20_21		*ctrl20_21;
+	struct f11_2d_ctrl22_26		*ctrl22_26;
+	struct f11_2d_ctrl27		*ctrl27;
+	struct f11_2d_ctrl28		*ctrl28;
+	struct f11_2d_ctrl29_30		*ctrl29_30;
+};
+
+/**
+ * @x_msb - top 8 bits of X finger position.
+ * @y_msb - top 8 bits of Y finger position.
+ * @x_lsb - bottom 4 bits of X finger position.
+ * @y_lsb - bottom 4 bits of Y finger position.
+ * @w_y - contact patch width along Y axis.
+ * @w_x - contact patch width along X axis.
+ * @z - finger Z value (proxy for pressure).
+ */
+struct f11_2d_data_1_5 {
+	u8 x_msb;
+	u8 y_msb;
+	u8 x_lsb:4;
+	u8 y_lsb:4;
+	u8 w_y:4;
+	u8 w_x:4;
+	u8 z;
+} __attribute__((__packed__));
+
+/**
+ * @delta_x - relative motion along X axis.
+ * @delta_y - relative motion along Y axis.
+ */
+struct f11_2d_data_6_7 {
+	s8 delta_x;
+	s8 delta_y;
+} __attribute__((__packed__));
+
+/**
+ * @single_tap - a single tap was recognized.
+ * @tap_and_hold - a tap-and-hold gesture was recognized.
+ * @double_tap - a double tap gesture was recognized.
+ * @early_tap - a tap gesture might be happening.
+ * @flick - a flick gesture was detected.
+ * @press - a press gesture was recognized.
+ * @pinch - a pinch gesture was detected.
+ */
+struct f11_2d_data_8 {
+	bool single_tap:1;
+	bool tap_and_hold:1;
+	bool double_tap:1;
+	bool early_tap:1;
+	bool flick:1;
+	bool press:1;
+	bool pinch:1;
+} __attribute__((__packed__));
+
+/**
+ * @palm_detect - a palm or other large object is in contact with the =
sensor.
+ * @rotate - a rotate gesture was detected.
+ * @shape - a TouchShape has been activated.
+ * @scrollzone - scrolling data is available.
+ * @finger_count - number of fingers involved in the reported gesture.
+ */
+struct f11_2d_data_9 {
+	bool palm_detect:1;
+	bool rotate:1;
+	bool shape:1;
+	bool scrollzone:1;
+	u8 finger_count:3;
+} __attribute__((__packed__));
+
+/**
+ * @pinch_motion - when a pinch gesture is detected, this is the chang=
e in
+ * distance between the two fingers since this register was last read.
+ */
+struct f11_2d_data_10 {
+	s8 pinch_motion;
+} __attribute__((__packed__));
+
+/**
+ * @x_flick_dist - when a flick gesture is detected,  the distance of =
flick
+ * gesture in X direction.
+ * @y_flick_dist - when a flick gesture is detected,  the distance of =
flick
+ * gesture in Y direction.
+ * @flick_time - the total time of the flick gesture, in 10ms units.
+ */
+struct f11_2d_data_10_12 {
+	s8 x_flick_dist;
+	s8 y_flick_dist;
+	u8 flick_time;
+} __attribute__((__packed__));
+
+/**
+ * @motion - when a rotate gesture is detected, the accumulated distan=
ce
+ * of the rotate motion. Clockwise motion is positive and counterclock=
wise
+ * motion is negative.
+ * @finger_separation - when a rotate gesture is detected, the distanc=
e
+ * between the fingers.
+ */
+struct f11_2d_data_11_12 {
+	s8 motion;
+	u8 finger_separation;
+} __attribute__((__packed__));
+
+/**
+ * @shape_n - a bitmask of the currently activate TouchShapes (if any)=
=2E
+ */
+struct f11_2d_data_13 {
+	u8 shape_n;
+} __attribute__((__packed__));
+
+/**
+ * @horizontal - chiral scrolling distance in the X direction.
+ * @vertical - chiral scrolling distance in the Y direction.
+ */
+struct f11_2d_data_14_15 {
+	s8 horizontal;
+	s8 vertical;
+} __attribute__((__packed__));
+
+/**
+ * @x_low - scroll zone motion along the lower edge of the sensor.
+ * @y_right - scroll zone motion along the right edge of the sensor.
+ * @x_upper - scroll zone motion along the upper edge of the sensor.
+ * @y_left - scroll zone motion along the left edge of the sensor.
+ */
+struct f11_2d_data_14_17 {
+	s8 x_low;
+	s8 y_right;
+	s8 x_upper;
+	s8 y_left;
+} __attribute__((__packed__));
+
+struct f11_2d_data {
+	u8				*f_state;
+	const struct f11_2d_data_1_5	*abs_pos;
+	const struct f11_2d_data_6_7	*rel_pos;
+	const struct f11_2d_data_8	*gest_1;
+	const struct f11_2d_data_9	*gest_2;
+	const struct f11_2d_data_10	*pinch;
+	const struct f11_2d_data_10_12	*flick;
+	const struct f11_2d_data_11_12	*rotate;
+	const struct f11_2d_data_13	*shapes;
+	const struct f11_2d_data_14_15	*multi_scroll;
+	const struct f11_2d_data_14_17	*scroll_zones;
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
+ * @input_mouse_phys - buffer for the relative phys name for this sens=
or.
+ * @debugfs_flip - inverts one or both axes.  Useful in prototyping ne=
w
+ * systems.
+ * @debugfs_flip - coordinate clipping range for one or both axes.  Us=
eful in
+ * prototyping new systems.
+ * @debugfs_delta_threshold - adjusts motion sensitivity for relative =
reports
+ * and (in reduced reporting mode) absolute reports.  Useful in protot=
yping new
+ * systems.
+ * @debugfs_offset - offsets one or both axes.  Useful in prototyping =
new
+ * systems.
+ * @debugfs_swap - swaps X and Y axes.  Useful in prototyping new syst=
ems.
+ * @debugfs_type_a - forces type A behavior.  Useful in bringing up ol=
d systems
+ * when you're not sure if you've got a Type A or Type B sensor.
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
+	bool type_a;
+	enum rmi_f11_sensor_type sensor_type;
+	struct input_dev *input;
+	struct input_dev *mouse_input;
+	struct rmi_function_container *fc;
+	char input_phys[NAME_BUFFER_SIZE];
+	char input_phys_mouse[NAME_BUFFER_SIZE];
+
+#ifdef CONFIG_RMI4_DEBUG
+	struct dentry *debugfs_flip;
+	struct dentry *debugfs_clip;
+	struct dentry *debugfs_delta_threshold;
+	struct dentry *debugfs_offset;
+	struct dentry *debugfs_swap;
+	struct dentry *debugfs_type_a;
+#endif
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
+ * @debugfs_rezero_wait - allows control of the rezero_wait value.  Us=
eful
+ * during system prototyping.
+ */
+struct f11_data {
+	struct f11_2d_device_query dev_query;
+	struct f11_2d_ctrl dev_controls;
+	struct mutex dev_controls_mutex;
+	u16 rezero_wait_ms;
+	struct f11_2d_sensor sensors[F11_MAX_NUM_OF_SENSORS];
+
+#ifdef CONFIG_RMI4_DEBUG
+	struct dentry *debugfs_rezero_wait;
+#endif
+};
+
+enum finger_state_values {
+	F11_NO_FINGER	=3D 0x00,
+	F11_PRESENT	=3D 0x01,
+	F11_INACCURATE	=3D 0x02,
+	F11_RESERVED	=3D 0x03
+};
+
+static ssize_t f11_maxPos_show(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	struct rmi_function_container *fc;
+	struct f11_data *data;
+
+	fc =3D to_rmi_function_container(dev);
+	data =3D fc->data;
+
+	return snprintf(buf, PAGE_SIZE, "%u %u\n",
+			data->sensors[0].max_x, data->sensors[0].max_y);
+}
+
+static ssize_t f11_relreport_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct rmi_function_container *fc;
+	struct f11_data *instance_data;
+
+	fc =3D to_rmi_function_container(dev);
+	instance_data =3D fc->data;
+
+	return snprintf(buf, PAGE_SIZE, "%u\n",
+			instance_data->
+			sensors[0].axis_align.rel_report_enabled);
+}
+
+static ssize_t f11_relreport_store(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf,
+					 size_t count)
+{
+	struct rmi_function_container *fc;
+	struct f11_data *instance_data;
+	unsigned int new_value;
+
+	fc =3D to_rmi_function_container(dev);
+	instance_data =3D fc->data;
+
+
+	if (sscanf(buf, "%u", &new_value) !=3D 1)
+		return -EINVAL;
+	if (new_value > 1)
+		return -EINVAL;
+	instance_data->sensors[0].axis_align.rel_report_enabled =3D new_value=
;
+
+	return count;
+}
+
+static ssize_t f11_rezero_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct rmi_function_container *fc =3D NULL;
+	unsigned int rezero;
+	int retval =3D 0;
+
+	fc =3D to_rmi_function_container(dev);
+
+	if (sscanf(buf, "%u", &rezero) !=3D 1)
+		return -EINVAL;
+	if (rezero > 1)
+		return -EINVAL;
+
+	/* Per spec, 0 has no effect, so we skip it entirely. */
+	if (rezero) {
+		/* Command register always reads as 0, so just use a local. */
+		struct f11_2d_commands commands =3D {
+			.rezero =3D true,
+		};
+
+		retval =3D rmi_write_block(fc->rmi_dev, fc->fd.command_base_addr,
+				&commands, sizeof(commands));
+		if (retval < 0) {
+			dev_err(dev, "%s: failed to issue rezero command, error =3D %d.",
+				__func__, retval);
+			return retval;
+		}
+	}
+
+	return count;
+}
+
+static struct device_attribute attrs[] =3D {
+	__ATTR(relreport, RMI_RW_ATTR, f11_relreport_show, f11_relreport_stor=
e),
+	__ATTR(maxPos, RMI_RO_ATTR, f11_maxPos_show, NULL),
+	__ATTR(rezero, RMI_WO_ATTR, NULL, f11_rezero_store)
+};
+
+#ifdef CONFIG_RMI4_DEBUG
+
+struct sensor_debugfs_data {
+	bool done;
+	struct f11_2d_sensor *sensor;
+};
+
+static int sensor_debug_open(struct inode *inodep, struct file *filp)
+{
+	struct sensor_debugfs_data *data;
+	struct f11_2d_sensor *sensor =3D inodep->i_private;
+
+	data =3D kzalloc(sizeof(struct sensor_debugfs_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->sensor =3D sensor;
+	filp->private_data =3D data;
+	return 0;
+}
+
+static int sensor_debug_release(struct inode *inodep, struct file *fil=
p)
+{
+	kfree(filp->private_data);
+	return 0;
+}
+
+static ssize_t flip_read(struct file *filp, char __user *buffer, size_=
t size,
+		    loff_t *offset) {
+	int retval;
+	char *local_buf;
+	struct sensor_debugfs_data *data =3D filp->private_data;
+
+	if (data->done)
+		return 0;
+
+	local_buf =3D kcalloc(size, sizeof(u8), GFP_KERNEL);
+	if (!local_buf)
+		return -ENOMEM;
+
+	data->done =3D 1;
+
+	retval =3D snprintf(local_buf, size, "%u %u\n",
+			data->sensor->axis_align.flip_x,
+			data->sensor->axis_align.flip_y);
+
+	if (retval <=3D 0 || copy_to_user(buffer, local_buf, retval))
+		retval =3D -EFAULT;
+	kfree(local_buf);
+
+	return retval;
+}
+
+static ssize_t flip_write(struct file *filp, const char __user *buffer=
,
+			   size_t size, loff_t *offset) {
+	int retval;
+	char *local_buf;
+	unsigned int new_X;
+	unsigned int new_Y;
+	struct sensor_debugfs_data *data =3D filp->private_data;
+
+	local_buf =3D kcalloc(size, sizeof(u8), GFP_KERNEL);
+	if (!local_buf)
+		return -ENOMEM;
+
+	retval =3D copy_from_user(local_buf, buffer, size);
+	if (retval) {
+		kfree(local_buf);
+		return -EFAULT;
+	}
+
+	retval =3D sscanf(local_buf, "%u %u", &new_X, &new_Y);
+	kfree(local_buf);
+	if (retval !=3D 2 || new_X > 1 || new_Y > 1)
+		return -EINVAL;
+
+	data->sensor->axis_align.flip_x =3D new_X;
+	data->sensor->axis_align.flip_y =3D new_Y;
+
+	return size;
+}
+
+static const struct file_operations flip_fops =3D {
+	.owner =3D THIS_MODULE,
+	.open =3D sensor_debug_open,
+	.release =3D sensor_debug_release,
+	.read =3D flip_read,
+	.write =3D flip_write,
+};
+
+static ssize_t delta_threshold_read(struct file *filp, char __user *bu=
ffer,
+		size_t size, loff_t *offset) {
+	int retval;
+	char *local_buf;
+	struct sensor_debugfs_data *data =3D filp->private_data;
+	struct f11_data *f11 =3D data->sensor->fc->data;
+	struct f11_2d_ctrl *ctrl =3D &f11->dev_controls;
+
+	if (data->done)
+		return 0;
+
+	local_buf =3D kcalloc(size, sizeof(u8), GFP_KERNEL);
+	if (!local_buf)
+		return -ENOMEM;
+
+	data->done =3D 1;
+
+	retval =3D snprintf(local_buf, size, "%u %u\n",
+			ctrl->ctrl0_9->delta_x_threshold,
+			ctrl->ctrl0_9->delta_y_threshold);
+
+	if (retval <=3D 0 || copy_to_user(buffer, local_buf, retval))
+		retval =3D -EFAULT;
+	kfree(local_buf);
+
+	return retval;
+
+}
+
+static ssize_t delta_threshold_write(struct file *filp,
+		const char __user *buffer, size_t size, loff_t *offset) {
+	int retval;
+	char *local_buf;
+	unsigned int new_X, new_Y;
+	u8 save_X, save_Y;
+	int rc;
+	struct sensor_debugfs_data *data =3D filp->private_data;
+	struct f11_data *f11 =3D data->sensor->fc->data;
+	struct f11_2d_ctrl *ctrl =3D &f11->dev_controls;
+	struct rmi_device *rmi_dev =3D  data->sensor->fc->rmi_dev;
+
+	local_buf =3D kcalloc(size, sizeof(u8), GFP_KERNEL);
+	if (!local_buf)
+		return -ENOMEM;
+
+	retval =3D copy_from_user(local_buf, buffer, size);
+	if (retval) {
+		kfree(local_buf);
+		return -EFAULT;
+	}
+
+	retval =3D sscanf(local_buf, "%u %u", &new_X, &new_Y);
+	kfree(local_buf);
+	if (retval !=3D 2 || new_X > 1 || new_Y > 1)
+		return -EINVAL;
+
+	save_X =3D ctrl->ctrl0_9->delta_x_threshold;
+	save_Y =3D ctrl->ctrl0_9->delta_y_threshold;
+
+	ctrl->ctrl0_9->delta_x_threshold =3D new_X;
+	ctrl->ctrl0_9->delta_y_threshold =3D new_Y;
+	rc =3D rmi_write_block(rmi_dev, ctrl->ctrl0_9_address,
+			ctrl->ctrl0_9, sizeof(*ctrl->ctrl0_9));
+	if (rc < 0) {
+		dev_warn(&data->sensor->fc->dev,
+			"Failed to write to delta_threshold. Code: %d.\n",
+			rc);
+		ctrl->ctrl0_9->delta_x_threshold =3D save_X;
+		ctrl->ctrl0_9->delta_y_threshold =3D save_Y;
+	}
+
+	return size;
+}
+
+static const struct file_operations delta_threshold_fops =3D {
+	.owner =3D THIS_MODULE,
+	.open =3D sensor_debug_open,
+	.release =3D sensor_debug_release,
+	.read =3D delta_threshold_read,
+	.write =3D delta_threshold_write,
+};
+
+static ssize_t offset_read(struct file *filp, char __user *buffer, siz=
e_t size,
+		    loff_t *offset) {
+	int retval;
+	char *local_buf;
+	struct sensor_debugfs_data *data =3D filp->private_data;
+
+	if (data->done)
+		return 0;
+
+	local_buf =3D kcalloc(size, sizeof(u8), GFP_KERNEL);
+	if (!local_buf)
+		return -ENOMEM;
+
+	data->done =3D 1;
+
+	retval =3D snprintf(local_buf, size, "%u %u\n",
+			data->sensor->axis_align.offset_X,
+			data->sensor->axis_align.offset_Y);
+
+	if (retval <=3D 0 || copy_to_user(buffer, local_buf, retval))
+		retval =3D -EFAULT;
+	kfree(local_buf);
+
+	return retval;
+}
+
+static ssize_t offset_write(struct file *filp, const char __user *buff=
er,
+			   size_t size, loff_t *offset)
+{
+	int retval;
+	char *local_buf;
+	int new_X;
+	int new_Y;
+	struct sensor_debugfs_data *data =3D filp->private_data;
+
+	local_buf =3D kcalloc(size, sizeof(u8), GFP_KERNEL);
+	if (!local_buf)
+		return -ENOMEM;
+
+	retval =3D copy_from_user(local_buf, buffer, size);
+	if (retval) {
+		kfree(local_buf);
+		return -EFAULT;
+	}
+	retval =3D sscanf(local_buf, "%u %u", &new_X, &new_Y);
+	kfree(local_buf);
+	if (retval !=3D 2)
+		return -EINVAL;
+
+	data->sensor->axis_align.offset_X =3D new_X;
+	data->sensor->axis_align.offset_Y =3D new_Y;
+
+	return size;
+}
+
+static const struct file_operations offset_fops =3D {
+	.owner =3D THIS_MODULE,
+	.open =3D sensor_debug_open,
+	.release =3D sensor_debug_release,
+	.read =3D offset_read,
+	.write =3D offset_write,
+};
+
+static ssize_t clip_read(struct file *filp, char __user *buffer, size_=
t size,
+		    loff_t *offset) {
+	int retval;
+	char *local_buf;
+	struct sensor_debugfs_data *data =3D filp->private_data;
+
+	if (data->done)
+		return 0;
+
+	local_buf =3D kcalloc(size, sizeof(u8), GFP_KERNEL);
+	if (!local_buf)
+		return -ENOMEM;
+
+	data->done =3D 1;
+
+	retval =3D snprintf(local_buf, size, "%u %u %u %u\n",
+			data->sensor->axis_align.clip_X_low,
+			data->sensor->axis_align.clip_X_high,
+			data->sensor->axis_align.clip_Y_low,
+			data->sensor->axis_align.clip_Y_high);
+
+	if (retval <=3D 0 || copy_to_user(buffer, local_buf, retval))
+		retval =3D -EFAULT;
+	kfree(local_buf);
+
+	return retval;
+}
+
+static ssize_t clip_write(struct file *filp, const char __user *buffer=
,
+			   size_t size, loff_t *offset)
+{
+	int retval;
+	char *local_buf;
+	unsigned int new_X_low, new_X_high, new_Y_low, new_Y_high;
+	struct sensor_debugfs_data *data =3D filp->private_data;
+
+	local_buf =3D kcalloc(size, sizeof(u8), GFP_KERNEL);
+	if (!local_buf)
+		return -ENOMEM;
+
+	retval =3D copy_from_user(local_buf, buffer, size);
+	if (retval) {
+		kfree(local_buf);
+		return -EFAULT;
+	}
+
+	retval =3D sscanf(local_buf, "%u %u %u %u",
+		&new_X_low, &new_X_high, &new_Y_low, &new_Y_high);
+	kfree(local_buf);
+	if (retval !=3D 4)
+		return -EINVAL;
+
+	if (new_X_low >=3D new_X_high || new_Y_low >=3D new_Y_high)
+		return -EINVAL;
+
+	data->sensor->axis_align.clip_X_low =3D new_X_low;
+	data->sensor->axis_align.clip_X_high =3D new_X_high;
+	data->sensor->axis_align.clip_Y_low =3D new_Y_low;
+	data->sensor->axis_align.clip_Y_high =3D new_Y_high;
+
+	return size;
+}
+
+static const struct file_operations clip_fops =3D {
+	.owner =3D THIS_MODULE,
+	.open =3D sensor_debug_open,
+	.release =3D sensor_debug_release,
+	.read =3D clip_read,
+	.write =3D clip_write,
+};
+
+static ssize_t swap_read(struct file *filp, char __user *buffer, size_=
t size,
+		    loff_t *offset) {
+	int retval;
+	char *local_buf;
+	struct sensor_debugfs_data *data =3D filp->private_data;
+
+	if (data->done)
+		return 0;
+
+	local_buf =3D kcalloc(size, sizeof(u8), GFP_KERNEL);
+	if (!local_buf)
+		return -ENOMEM;
+
+	data->done =3D 1;
+
+	retval =3D snprintf(local_buf, size, "%u\n",
+			data->sensor->axis_align.swap_axes);
+
+	if (retval <=3D 0 || copy_to_user(buffer, local_buf, retval))
+		retval =3D -EFAULT;
+	kfree(local_buf);
+
+	return retval;
+}
+
+static ssize_t swap_write(struct file *filp, const char __user *buffer=
,
+			   size_t size, loff_t *offset)
+{
+	int retval;
+	char *local_buf;
+	int new_value;
+	struct sensor_debugfs_data *data =3D filp->private_data;
+
+	local_buf =3D kcalloc(size, sizeof(u8), GFP_KERNEL);
+	if (!local_buf)
+		return -ENOMEM;
+
+	retval =3D copy_from_user(local_buf, buffer, size);
+	if (retval) {
+		kfree(local_buf);
+		return -EFAULT;
+	}
+	retval =3D sscanf(local_buf, "%u", &new_value);
+	kfree(local_buf);
+	if (retval !=3D 1 || new_value > 1)
+		return -EINVAL;
+
+	data->sensor->axis_align.swap_axes =3D new_value;
+	return size;
+}
+
+static const struct file_operations swap_fops =3D {
+	.owner =3D THIS_MODULE,
+	.open =3D sensor_debug_open,
+	.release =3D sensor_debug_release,
+	.read =3D swap_read,
+	.write =3D swap_write,
+};
+
+static ssize_t type_a_read(struct file *filp, char __user *buffer, siz=
e_t size,
+		    loff_t *offset) {
+	int retval;
+	char *local_buf;
+	struct sensor_debugfs_data *data =3D filp->private_data;
+
+	if (data->done)
+		return 0;
+
+	local_buf =3D kcalloc(size, sizeof(u8), GFP_KERNEL);
+	if (!local_buf)
+		return -ENOMEM;
+
+	data->done =3D 1;
+
+	retval =3D snprintf(local_buf, size, "%u\n",
+			data->sensor->type_a);
+
+	if (retval <=3D 0 || copy_to_user(buffer, local_buf, retval))
+		retval =3D -EFAULT;
+	kfree(local_buf);
+
+	return retval;
+}
+
+static ssize_t type_a_write(struct file *filp, const char __user *buff=
er,
+			   size_t size, loff_t *offset)
+{
+	int retval;
+	char *local_buf;
+	int new_value;
+	struct sensor_debugfs_data *data =3D filp->private_data;
+
+	local_buf =3D kcalloc(size, sizeof(u8), GFP_KERNEL);
+	if (!local_buf)
+		return -ENOMEM;
+
+	retval =3D copy_from_user(local_buf, buffer, size);
+	if (retval) {
+		kfree(local_buf);
+		return -EFAULT;
+	}
+
+	retval =3D sscanf(local_buf, "%u", &new_value);
+	kfree(local_buf);
+	if (retval !=3D 1 || new_value > 1)
+		return -EINVAL;
+
+	data->sensor->type_a =3D new_value;
+	return size;
+}
+
+static const struct file_operations type_a_fops =3D {
+	.owner =3D THIS_MODULE,
+	.open =3D sensor_debug_open,
+	.release =3D sensor_debug_release,
+	.read =3D type_a_read,
+	.write =3D type_a_write,
+};
+
+static int setup_sensor_debugfs(struct f11_2d_sensor *sensor)
+{
+	int retval =3D 0;
+	char fname[NAME_BUFFER_SIZE];
+	struct rmi_function_container *fc =3D sensor->fc;
+
+	if (!fc->debugfs_root)
+		return -ENODEV;
+
+	retval =3D snprintf(fname, NAME_BUFFER_SIZE, "flip.%d",
+			  sensor->sensor_index);
+	sensor->debugfs_flip =3D debugfs_create_file(fname, RMI_RW_ATTR,
+				fc->debugfs_root, sensor, &flip_fops);
+	if (!sensor->debugfs_flip)
+		dev_warn(&fc->dev, "Failed to create debugfs %s.\n",
+			 fname);
+
+	retval =3D snprintf(fname, NAME_BUFFER_SIZE, "clip.%d",
+			  sensor->sensor_index);
+	sensor->debugfs_clip =3D debugfs_create_file(fname, RMI_RW_ATTR,
+				fc->debugfs_root, sensor, &clip_fops);
+	if (!sensor->debugfs_clip)
+		dev_warn(&fc->dev, "Failed to create debugfs %s.\n",
+			 fname);
+
+	retval =3D snprintf(fname, NAME_BUFFER_SIZE, "delta_threshold.%d",
+			  sensor->sensor_index);
+	sensor->debugfs_clip =3D debugfs_create_file(fname, RMI_RW_ATTR,
+				fc->debugfs_root, sensor,
+				&delta_threshold_fops);
+	if (!sensor->debugfs_delta_threshold)
+		dev_warn(&fc->dev, "Failed to create debugfs %s.\n",
+			 fname);
+
+	retval =3D snprintf(fname, NAME_BUFFER_SIZE, "offset.%d",
+			  sensor->sensor_index);
+	sensor->debugfs_offset =3D debugfs_create_file(fname, RMI_RW_ATTR,
+				fc->debugfs_root, sensor, &offset_fops);
+	if (!sensor->debugfs_offset)
+		dev_warn(&fc->dev, "Failed to create debugfs %s.\n",
+			 fname);
+
+	retval =3D snprintf(fname, NAME_BUFFER_SIZE, "swap.%d",
+			  sensor->sensor_index);
+	sensor->debugfs_swap =3D debugfs_create_file(fname, RMI_RW_ATTR,
+				fc->debugfs_root, sensor, &swap_fops);
+	if (!sensor->debugfs_swap)
+		dev_warn(&fc->dev, "Failed to create debugfs %s.\n",
+			 fname);
+
+	retval =3D snprintf(fname, NAME_BUFFER_SIZE, "type_a.%d",
+			  sensor->sensor_index);
+	sensor->debugfs_type_a =3D debugfs_create_file(fname, RMI_RW_ATTR,
+				fc->debugfs_root, sensor, &type_a_fops);
+	if (!sensor->debugfs_type_a)
+		dev_warn(&fc->dev, "Failed to create debugfs %s.\n",
+			 fname);
+
+	return retval;
+}
+
+static void teardown_sensor_debugfs(struct f11_2d_sensor *sensor)
+{
+	if (sensor->debugfs_flip)
+		debugfs_remove(sensor->debugfs_flip);
+
+	if (sensor->debugfs_clip)
+		debugfs_remove(sensor->debugfs_clip);
+
+	if (sensor->debugfs_offset)
+		debugfs_remove(sensor->debugfs_offset);
+
+	if (sensor->debugfs_swap)
+		debugfs_remove(sensor->debugfs_swap);
+
+	if (sensor->debugfs_type_a)
+		debugfs_remove(sensor->debugfs_type_a);
+}
+
+struct f11_debugfs_data {
+	bool done;
+	struct rmi_function_container *fc;
+};
+
+static int f11_debug_open(struct inode *inodep, struct file *filp)
+{
+	struct f11_debugfs_data *data;
+	struct rmi_function_container *fc =3D inodep->i_private;
+
+	data =3D devm_kzalloc(&fc->dev, sizeof(struct f11_debugfs_data),
+		GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->fc =3D fc;
+	filp->private_data =3D data;
+	return 0;
+}
+
+static ssize_t rezero_wait_read(struct file *filp, char __user *buffer=
,
+		size_t size, loff_t *offset) {
+	int retval;
+	char *local_buf;
+	struct f11_debugfs_data *data =3D filp->private_data;
+	struct f11_data *f11 =3D data->fc->data;
+
+	if (data->done)
+		return 0;
+
+	local_buf =3D kcalloc(size, sizeof(u8), GFP_KERNEL);
+	if (!local_buf)
+		return -ENOMEM;
+
+	data->done =3D 1;
+
+	retval =3D snprintf(local_buf, size, "%u\n", f11->rezero_wait_ms);
+
+	if (retval <=3D 0 || copy_to_user(buffer, local_buf, retval))
+		retval =3D -EFAULT;
+	kfree(local_buf);
+
+	return retval;
+}
+
+static ssize_t rezero_wait_write(struct file *filp, const char __user =
*buffer,
+			   size_t size, loff_t *offset)
+{
+	int retval;
+	char *local_buf;
+	int new_value;
+	struct f11_debugfs_data *data =3D filp->private_data;
+	struct f11_data *f11 =3D data->fc->data;
+
+	local_buf =3D kcalloc(size, sizeof(u8), GFP_KERNEL);
+	if (!local_buf)
+		return -ENOMEM;
+
+	retval =3D copy_from_user(local_buf, buffer, size);
+	if (retval) {
+		kfree(local_buf);
+		return -EFAULT;
+	}
+
+	retval =3D sscanf(local_buf, "%u", &new_value);
+	kfree(local_buf);
+	if (retval !=3D 1 || new_value > 65535)
+		return -EINVAL;
+
+	f11->rezero_wait_ms =3D new_value;
+	return size;
+}
+
+static const struct file_operations rezero_wait_fops =3D {
+	.owner =3D THIS_MODULE,
+	.open =3D f11_debug_open,
+	.read =3D rezero_wait_read,
+	.write =3D rezero_wait_write,
+};
+
+static int setup_f11_debugfs(struct rmi_function_container *fc)
+{
+	struct f11_data *f11 =3D fc->data;
+
+	if (!fc->debugfs_root)
+		return -ENODEV;
+
+	f11->debugfs_rezero_wait =3D debugfs_create_file("rezero_wait",
+		RMI_RW_ATTR, fc->debugfs_root, fc, &rezero_wait_fops);
+	if (!f11->debugfs_rezero_wait)
+		dev_warn(&fc->dev,
+			 "Failed to create debugfs rezero_wait.\n");
+
+	return 0;
+}
+
+static void teardown_f11_debugfs(struct f11_data *f11)
+{
+	if (f11->debugfs_rezero_wait)
+		debugfs_remove(f11->debugfs_rezero_wait);
+}
+#endif
+/* End adding debugfs */
+
+/** F11_INACCURATE state is overloaded to indicate pen present. */
+#define F11_PEN F11_INACCURATE
+
+static int get_tool_type(struct f11_2d_sensor *sensor, u8 finger_state=
)
+{
+	if (IS_ENABLED(CONFIG_RMI4_F11_PEN) &&
+			sensor->sens_query.query9.has_pen &&
+			finger_state =3D=3D F11_PEN)
+		return MT_TOOL_PEN;
+	return MT_TOOL_FINGER;
+}
+
+static void rmi_f11_rel_pos_report(struct f11_2d_sensor *sensor, u8 n_=
finger)
+{
+	struct f11_2d_data *data =3D &sensor->data;
+	struct rmi_f11_2d_axis_alignment *axis_align =3D &sensor->axis_align;
+	s8 x, y;
+	s8 temp;
+
+	x =3D data->rel_pos[n_finger].delta_x;
+	y =3D data->rel_pos[n_finger].delta_y;
+
+	x =3D min(F11_REL_POS_MAX, max(F11_REL_POS_MIN, (int)x));
+	y =3D min(F11_REL_POS_MAX, max(F11_REL_POS_MIN, (int)y));
+
+	if (axis_align->swap_axes) {
+		temp =3D x;
+		x =3D y;
+		y =3D temp;
+	}
+	if (axis_align->flip_x)
+		x =3D min(F11_REL_POS_MAX, -x);
+	if (axis_align->flip_y)
+		y =3D min(F11_REL_POS_MAX, -y);
+
+	if (x || y) {
+		input_report_rel(sensor->input, REL_X, x);
+		input_report_rel(sensor->input, REL_Y, y);
+		input_report_rel(sensor->mouse_input, REL_X, x);
+		input_report_rel(sensor->mouse_input, REL_Y, y);
+	}
+	input_sync(sensor->mouse_input);
+}
+
+static void rmi_f11_abs_pos_report(struct f11_data *f11,
+				   struct f11_2d_sensor *sensor,
+				   u8 finger_state, u8 n_finger)
+{
+	struct f11_2d_data *data =3D &sensor->data;
+	struct rmi_f11_2d_axis_alignment *axis_align =3D &sensor->axis_align;
+	int x, y, z;
+	int w_x, w_y, w_max, w_min, orient;
+	int temp;
+
+	if (finger_state) {
+		x =3D ((data->abs_pos[n_finger].x_msb << 4) |
+			data->abs_pos[n_finger].x_lsb);
+		y =3D ((data->abs_pos[n_finger].y_msb << 4) |
+			data->abs_pos[n_finger].y_lsb);
+		z =3D data->abs_pos[n_finger].z;
+		w_x =3D data->abs_pos[n_finger].w_x;
+		w_y =3D data->abs_pos[n_finger].w_y;
+		w_max =3D max(w_x, w_y);
+		w_min =3D min(w_x, w_y);
+
+		if (axis_align->swap_axes) {
+			temp =3D x;
+			x =3D y;
+			y =3D temp;
+			temp =3D w_x;
+			w_x =3D w_y;
+			w_y =3D temp;
+		}
+
+		orient =3D w_x > w_y ? 1 : 0;
+
+		if (axis_align->flip_x)
+			x =3D max(sensor->max_x - x, 0);
+
+		if (axis_align->flip_y)
+			y =3D max(sensor->max_y - y, 0);
+
+		/*
+		* here checking if X offset or y offset are specified is
+		*  redundant.  We just add the offsets or, clip the values
+		*
+		* note: offsets need to be done before clipping occurs,
+		* or we could get funny values that are outside
+		* clipping boundaries.
+		*/
+		x +=3D axis_align->offset_X;
+		y +=3D axis_align->offset_Y;
+		x =3D  max(axis_align->clip_X_low, x);
+		y =3D  max(axis_align->clip_Y_low, y);
+		if (axis_align->clip_X_high)
+			x =3D min(axis_align->clip_X_high, x);
+		if (axis_align->clip_Y_high)
+			y =3D  min(axis_align->clip_Y_high, y);
+
+	}
+
+	/* Some UIs ignore W of zero, so we fudge it to 1 for pens.  This
+	 * only appears to be an issue when reporting pens, not plain old
+	 * fingers. */
+	if (IS_ENABLED(CONFIG_RMI4_F11_PEN) &&
+			get_tool_type(sensor, finger_state) =3D=3D MT_TOOL_PEN) {
+		w_max =3D max(1, w_max);
+		w_min =3D max(1, w_min);
+	}
+
+	if (sensor->type_a) {
+		input_report_abs(sensor->input, ABS_MT_TRACKING_ID, n_finger);
+		input_report_abs(sensor->input, ABS_MT_TOOL_TYPE,
+					get_tool_type(sensor, finger_state));
+	} else {
+		input_mt_slot(sensor->input, n_finger);
+		input_mt_report_slot_state(sensor->input,
+			get_tool_type(sensor, finger_state), finger_state);
+	}
+
+	if (finger_state) {
+		input_report_abs(sensor->input, ABS_MT_PRESSURE, z);
+		input_report_abs(sensor->input, ABS_MT_TOUCH_MAJOR, w_max);
+		input_report_abs(sensor->input, ABS_MT_TOUCH_MINOR, w_min);
+		input_report_abs(sensor->input, ABS_MT_ORIENTATION, orient);
+		input_report_abs(sensor->input, ABS_MT_POSITION_X, x);
+		input_report_abs(sensor->input, ABS_MT_POSITION_Y, y);
+		dev_dbg(&sensor->fc->dev,
+			"finger[%d]:%d - x:%d y:%d z:%d w_max:%d w_min:%d\n",
+			n_finger, finger_state, x, y, z, w_max, w_min);
+	}
+	/* MT sync between fingers */
+	if (sensor->type_a)
+		input_mt_sync(sensor->input);
+}
+
+static void rmi_f11_finger_handler(struct f11_data *f11,
+				   struct f11_2d_sensor *sensor)
+{
+	const u8 *f_state =3D sensor->data.f_state;
+	u8 finger_state;
+	u8 finger_pressed_count;
+	u8 i;
+
+	for (i =3D 0, finger_pressed_count =3D 0; i < sensor->nbr_fingers; i+=
+) {
+		/* Possible of having 4 fingers per f_statet register */
+		finger_state =3D (f_state[i / 4] >> (2 * (i % 4))) &
+					FINGER_STATE_MASK;
+		if (finger_state =3D=3D F11_RESERVED) {
+			pr_err("%s: Invalid finger state[%d]:0x%02x.", __func__,
+					i, finger_state);
+			continue;
+		} else if ((finger_state =3D=3D F11_PRESENT) ||
+				(finger_state =3D=3D F11_INACCURATE)) {
+			finger_pressed_count++;
+		}
+
+		if (sensor->data.abs_pos)
+			rmi_f11_abs_pos_report(f11, sensor, finger_state, i);
+
+		if (sensor->data.rel_pos)
+			rmi_f11_rel_pos_report(sensor, i);
+	}
+	input_mt_sync(sensor->input);
+	input_sync(sensor->input);
+}
+
+static int f11_2d_construct_data(struct f11_2d_sensor *sensor)
+{
+	struct f11_2d_sensor_queries *query =3D &sensor->sens_query;
+	struct f11_2d_data *data =3D &sensor->data;
+	int i;
+
+	sensor->nbr_fingers =3D (query->info.number_of_fingers =3D=3D 5 ? 10 =
:
+				query->info.number_of_fingers + 1);
+
+	sensor->pkt_size =3D DIV_ROUND_UP(sensor->nbr_fingers, 4);
+
+	if (query->info.has_abs)
+		sensor->pkt_size +=3D (sensor->nbr_fingers * 5);
+
+	if (query->info.has_rel)
+		sensor->pkt_size +=3D  (sensor->nbr_fingers * 2);
+
+	/* Check if F11_2D_Query7 is non-zero */
+	if (has_gesture_bits(&query->gesture_info, 0))
+		sensor->pkt_size +=3D sizeof(u8);
+
+	/* Check if F11_2D_Query7 or F11_2D_Query8 is non-zero */
+	if (has_gesture_bits(&query->gesture_info, 0) ||
+				has_gesture_bits(&query->gesture_info, 1))
+		sensor->pkt_size +=3D sizeof(u8);
+
+	if (query->gesture_info.has_pinch || query->gesture_info.has_flick
+			|| query->gesture_info.has_rotate) {
+		sensor->pkt_size +=3D 3;
+		if (!query->gesture_info.has_flick)
+			sensor->pkt_size--;
+		if (!query->gesture_info.has_rotate)
+			sensor->pkt_size--;
+	}
+
+	if (query->gesture_info.has_touch_shapes)
+		sensor->pkt_size +=3D
+			DIV_ROUND_UP(query->ts_info.nbr_touch_shapes + 1, 8);
+
+	sensor->data_pkt =3D kzalloc(sensor->pkt_size, GFP_KERNEL);
+	if (!sensor->data_pkt)
+		return -ENOMEM;
+
+	data->f_state =3D sensor->data_pkt;
+	i =3D DIV_ROUND_UP(sensor->nbr_fingers, 4);
+
+	if (query->info.has_abs) {
+		data->abs_pos =3D (struct f11_2d_data_1_5 *)
+				&sensor->data_pkt[i];
+		i +=3D (sensor->nbr_fingers * 5);
+	}
+
+	if (query->info.has_rel) {
+		data->rel_pos =3D (struct f11_2d_data_6_7 *)
+				&sensor->data_pkt[i];
+		i +=3D (sensor->nbr_fingers * 2);
+	}
+
+	if (has_gesture_bits(&query->gesture_info, 0)) {
+		data->gest_1 =3D (struct f11_2d_data_8 *)&sensor->data_pkt[i];
+		i++;
+	}
+
+	if (has_gesture_bits(&query->gesture_info, 0) ||
+				has_gesture_bits(&query->gesture_info, 1)) {
+		data->gest_2 =3D (struct f11_2d_data_9 *)&sensor->data_pkt[i];
+		i++;
+	}
+
+	if (query->gesture_info.has_pinch) {
+		data->pinch =3D (struct f11_2d_data_10 *)&sensor->data_pkt[i];
+		i++;
+	}
+
+	if (query->gesture_info.has_flick) {
+		if (query->gesture_info.has_pinch) {
+			data->flick =3D (struct f11_2d_data_10_12 *)data->pinch;
+			i +=3D 2;
+		} else {
+			data->flick =3D (struct f11_2d_data_10_12 *)
+					&sensor->data_pkt[i];
+			i +=3D 3;
+		}
+	}
+
+	if (query->gesture_info.has_rotate) {
+		if (query->gesture_info.has_flick) {
+			data->rotate =3D (struct f11_2d_data_11_12 *)
+					(data->flick + 1);
+		} else {
+			data->rotate =3D (struct f11_2d_data_11_12 *)
+					&sensor->data_pkt[i];
+			i +=3D 2;
+		}
+	}
+
+	if (query->gesture_info.has_touch_shapes)
+		data->shapes =3D (struct f11_2d_data_13 *)&sensor->data_pkt[i];
+
+	return 0;
+}
+
+static int f11_read_control_regs(struct rmi_function_container *fc,
+				struct f11_2d_ctrl *ctrl, u16 ctrl_base_addr) {
+	struct rmi_device *rmi_dev =3D fc->rmi_dev;
+	u16 read_address =3D ctrl_base_addr;
+	int error =3D 0;
+
+	ctrl->ctrl0_9_address =3D read_address;
+	error =3D rmi_read_block(rmi_dev, read_address, ctrl->ctrl0_9,
+		sizeof(*ctrl->ctrl0_9));
+	if (error < 0) {
+		dev_err(&fc->dev, "Failed to read ctrl0, code: %d.\n", error);
+		return error;
+	}
+	read_address +=3D sizeof(*ctrl->ctrl0_9);
+
+	if (ctrl->ctrl10) {
+		error =3D rmi_read_block(rmi_dev, read_address,
+			ctrl->ctrl10, sizeof(*ctrl->ctrl10));
+		if (error < 0) {
+			dev_err(&fc->dev,
+				"Failed to read ctrl10, code: %d.\n", error);
+			return error;
+		}
+		read_address +=3D sizeof(*ctrl->ctrl10);
+	}
+
+	if (ctrl->ctrl11) {
+		error =3D rmi_read_block(rmi_dev, read_address,
+			ctrl->ctrl11, sizeof(*ctrl->ctrl11));
+		if (error < 0) {
+			dev_err(&fc->dev,
+				"Failed to read ctrl11, code: %d.\n", error);
+			return error;
+		}
+		read_address +=3D sizeof(*ctrl->ctrl11);
+	}
+
+	if (ctrl->ctrl14) {
+		error =3D rmi_read_block(rmi_dev, read_address,
+			ctrl->ctrl14, sizeof(*ctrl->ctrl14));
+		if (error < 0) {
+			dev_err(&fc->dev,
+				"Failed to read ctrl14, code: %d.\n", error);
+			return error;
+		}
+		read_address +=3D sizeof(*ctrl->ctrl14);
+	}
+
+	if (ctrl->ctrl15) {
+		error =3D rmi_read_block(rmi_dev, read_address,
+			ctrl->ctrl15, sizeof(*ctrl->ctrl15));
+		if (error < 0) {
+			dev_err(&fc->dev,
+				"Failed to read ctrl15, code: %d.\n", error);
+			return error;
+		}
+		read_address +=3D sizeof(*ctrl->ctrl15);
+	}
+
+	if (ctrl->ctrl16) {
+		error =3D rmi_read_block(rmi_dev, read_address,
+			ctrl->ctrl16, sizeof(*ctrl->ctrl16));
+		if (error < 0) {
+			dev_err(&fc->dev,
+				"Failed to read ctrl16, code: %d.\n", error);
+			return error;
+		}
+		read_address +=3D sizeof(*ctrl->ctrl16);
+	}
+
+	if (ctrl->ctrl17) {
+		error =3D rmi_read_block(rmi_dev, read_address,
+			ctrl->ctrl17, sizeof(*ctrl->ctrl17));
+		if (error < 0) {
+			dev_err(&fc->dev,
+				"Failed to read ctrl17, code: %d.\n", error);
+			return error;
+		}
+		read_address +=3D sizeof(*ctrl->ctrl17);
+	}
+
+	if (ctrl->ctrl18_19) {
+		error =3D rmi_read_block(rmi_dev, read_address,
+			ctrl->ctrl18_19, sizeof(*ctrl->ctrl18_19));
+		if (error < 0) {
+			dev_err(&fc->dev,
+				"Failed to read ctrl18_19, code: %d.\n", error);
+			return error;
+		}
+		read_address +=3D sizeof(*ctrl->ctrl18_19);
+	}
+
+	if (ctrl->ctrl20_21) {
+		error =3D rmi_read_block(rmi_dev, read_address,
+			ctrl->ctrl20_21, sizeof(*ctrl->ctrl20_21));
+		if (error < 0) {
+			dev_err(&fc->dev,
+				"Failed to read ctrl20_21, code: %d.\n", error);
+			return error;
+		}
+		read_address +=3D sizeof(*ctrl->ctrl20_21);
+	}
+
+	if (ctrl->ctrl22_26) {
+		error =3D rmi_read_block(rmi_dev, read_address,
+			ctrl->ctrl22_26, sizeof(*ctrl->ctrl22_26));
+		if (error < 0) {
+			dev_err(&fc->dev,
+				"Failed to read ctrl22_26, code: %d.\n", error);
+			return error;
+		}
+		read_address +=3D sizeof(*ctrl->ctrl22_26);
+	}
+
+	if (ctrl->ctrl27) {
+		error =3D rmi_read_block(rmi_dev, read_address,
+			ctrl->ctrl27, sizeof(*ctrl->ctrl27));
+		if (error < 0) {
+			dev_err(&fc->dev,
+				"Failed to read ctrl27, code: %d.\n", error);
+			return error;
+		}
+		read_address +=3D sizeof(*ctrl->ctrl27);
+	}
+
+	if (ctrl->ctrl28) {
+		error =3D rmi_read_block(rmi_dev, read_address,
+			ctrl->ctrl28, sizeof(*ctrl->ctrl28));
+		if (error < 0) {
+			dev_err(&fc->dev,
+				"Failed to read ctrl28, code: %d.\n", error);
+			return error;
+		}
+		read_address +=3D sizeof(*ctrl->ctrl28);
+	}
+
+	if (ctrl->ctrl29_30) {
+		error =3D rmi_read_block(rmi_dev, read_address,
+			ctrl->ctrl29_30, sizeof(*ctrl->ctrl29_30));
+		if (error < 0) {
+			dev_err(&fc->dev,
+				"Failed to read ctrl29_30, code: %d.\n", error);
+			return error;
+		}
+		read_address +=3D sizeof(*ctrl->ctrl29_30);
+	}
+	return 0;
+}
+
+static int f11_allocate_control_regs(struct rmi_function_container *fc=
,
+				struct f11_2d_device_query *device_query,
+				struct f11_2d_sensor_queries *sensor_query,
+				struct f11_2d_ctrl *ctrl,
+				u16 ctrl_base_addr) {
+
+	ctrl->ctrl0_9 =3D devm_kzalloc(&fc->dev, sizeof(struct f11_2d_ctrl0_9=
),
+				       GFP_KERNEL);
+	if (!ctrl->ctrl0_9)
+		return -ENOMEM;
+	if (has_gesture_bits(&sensor_query->gesture_info, 0)) {
+		ctrl->ctrl10 =3D devm_kzalloc(&fc->dev,
+			sizeof(struct f11_2d_ctrl10), GFP_KERNEL);
+		if (!ctrl->ctrl10)
+			return -ENOMEM;
+	}
+
+	if (has_gesture_bits(&sensor_query->gesture_info, 1)) {
+		ctrl->ctrl11 =3D devm_kzalloc(&fc->dev,
+			sizeof(struct f11_2d_ctrl11), GFP_KERNEL);
+		if (!ctrl->ctrl11)
+			return -ENOMEM;
+	}
+
+	if (device_query->has_query9 && sensor_query->query9.has_pen) {
+		ctrl->ctrl20_21 =3D devm_kzalloc(&fc->dev,
+			sizeof(struct f11_2d_ctrl20_21), GFP_KERNEL);
+		if (!ctrl->ctrl20_21)
+			return -ENOMEM;
+	}
+
+	if (device_query->has_query9 && sensor_query->query9.has_proximity) {
+		ctrl->ctrl22_26 =3D devm_kzalloc(&fc->dev,
+			sizeof(struct f11_2d_ctrl22_26), GFP_KERNEL);
+		if (!ctrl->ctrl22_26)
+			return -ENOMEM;
+	}
+
+	if (device_query->has_query9 &&
+		(sensor_query->query9.has_palm_det_sensitivity ||
+		sensor_query->query9.has_suppress_on_palm_detect)) {
+		ctrl->ctrl27 =3D devm_kzalloc(&fc->dev,
+			sizeof(struct f11_2d_ctrl27), GFP_KERNEL);
+		if (!ctrl->ctrl27)
+			return -ENOMEM;
+	}
+
+	if (sensor_query->gesture_info.has_multi_finger_scroll) {
+		ctrl->ctrl28 =3D devm_kzalloc(&fc->dev,
+			sizeof(struct f11_2d_ctrl28), GFP_KERNEL);
+		if (!ctrl->ctrl28)
+			return -ENOMEM;
+	}
+
+	if (device_query->has_query11 &&
+			sensor_query->features_1.has_z_tuning) {
+		ctrl->ctrl29_30 =3D devm_kzalloc(&fc->dev,
+			sizeof(struct f11_2d_ctrl29_30), GFP_KERNEL);
+		if (!ctrl->ctrl29_30)
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static int f11_write_control_regs(struct rmi_function_container *fc,
+					struct f11_2d_sensor_queries *query,
+					struct f11_2d_ctrl *ctrl,
+					u16 ctrl_base_addr)
+{
+	struct rmi_device *rmi_dev =3D fc->rmi_dev;
+	u16 write_address =3D ctrl_base_addr;
+	int error;
+
+	error =3D rmi_write_block(rmi_dev, write_address,
+				ctrl->ctrl0_9,
+				 sizeof(*ctrl->ctrl0_9));
+	if (error < 0)
+		return error;
+	write_address +=3D sizeof(ctrl->ctrl0_9);
+
+	if (ctrl->ctrl10) {
+		error =3D rmi_write_block(rmi_dev, write_address,
+					ctrl->ctrl10, sizeof(*ctrl->ctrl10));
+		if (error < 0)
+			return error;
+		write_address++;
+	}
+
+	if (ctrl->ctrl11) {
+		error =3D rmi_write_block(rmi_dev, write_address,
+					ctrl->ctrl11, sizeof(*ctrl->ctrl11));
+		if (error < 0)
+			return error;
+		write_address++;
+	}
+
+	if (ctrl->ctrl14) {
+		error =3D rmi_write_block(rmi_dev, write_address,
+				ctrl->ctrl14, sizeof(ctrl->ctrl14));
+		if (error < 0)
+			return error;
+		write_address +=3D sizeof(*ctrl->ctrl15);
+	}
+
+	if (ctrl->ctrl15) {
+		error =3D rmi_write_block(rmi_dev, write_address,
+				ctrl->ctrl15, sizeof(*ctrl->ctrl15));
+		if (error < 0)
+			return error;
+		write_address +=3D sizeof(*ctrl->ctrl15);
+	}
+
+	if (ctrl->ctrl16) {
+		error =3D rmi_write_block(rmi_dev, write_address,
+				ctrl->ctrl16, sizeof(*ctrl->ctrl16));
+		if (error < 0)
+			return error;
+		write_address +=3D sizeof(*ctrl->ctrl16);
+	}
+
+	if (ctrl->ctrl17) {
+		error =3D rmi_write_block(rmi_dev, write_address,
+				ctrl->ctrl17, sizeof(*ctrl->ctrl17));
+		if (error < 0)
+			return error;
+		write_address +=3D sizeof(*ctrl->ctrl17);
+	}
+
+	if (ctrl->ctrl18_19) {
+		error =3D rmi_write_block(rmi_dev, write_address,
+			ctrl->ctrl18_19, sizeof(*ctrl->ctrl18_19));
+		if (error < 0)
+			return error;
+		write_address +=3D sizeof(*ctrl->ctrl18_19);
+	}
+
+	if (ctrl->ctrl20_21) {
+		error =3D rmi_write_block(rmi_dev, write_address,
+			ctrl->ctrl20_21, sizeof(*ctrl->ctrl20_21));
+		if (error < 0)
+			return error;
+		write_address +=3D sizeof(*ctrl->ctrl20_21);
+	}
+
+	if (ctrl->ctrl22_26) {
+		error =3D rmi_write_block(rmi_dev, write_address,
+			ctrl->ctrl22_26, sizeof(*ctrl->ctrl22_26));
+		if (error < 0)
+			return error;
+		write_address +=3D sizeof(*ctrl->ctrl22_26);
+	}
+
+	if (ctrl->ctrl27) {
+		error =3D rmi_write_block(rmi_dev, write_address,
+			ctrl->ctrl27, sizeof(*ctrl->ctrl27));
+		if (error < 0)
+			return error;
+		write_address +=3D sizeof(*ctrl->ctrl27);
+	}
+
+	if (ctrl->ctrl28) {
+		error =3D rmi_write_block(rmi_dev, write_address,
+			ctrl->ctrl28, sizeof(*ctrl->ctrl28));
+		if (error < 0)
+			return error;
+		write_address +=3D sizeof(*ctrl->ctrl28);
+	}
+
+	if (ctrl->ctrl29_30) {
+		error =3D rmi_write_block(rmi_dev, write_address,
+					ctrl->ctrl29_30,
+					sizeof(struct f11_2d_ctrl29_30));
+		if (error < 0)
+			return error;
+		write_address +=3D sizeof(struct f11_2d_ctrl29_30);
+	}
+
+	return 0;
+}
+
+static int rmi_f11_get_query_parameters(struct rmi_device *rmi_dev,
+			struct f11_2d_device_query *dev_query,
+			struct f11_2d_sensor_queries *sensor_query,
+			u16 query_base_addr)
+{
+	int query_size;
+	int rc;
+
+	rc =3D rmi_read_block(rmi_dev, query_base_addr,
+			    &sensor_query->info, sizeof(sensor_query->info));
+	if (rc < 0)
+		return rc;
+	query_size =3D sizeof(sensor_query->info);
+
+	if (sensor_query->info.has_abs) {
+		rc =3D rmi_read(rmi_dev, query_base_addr + query_size,
+					&sensor_query->abs_info);
+		if (rc < 0)
+			return rc;
+		query_size++;
+	}
+
+	if (sensor_query->info.has_rel) {
+		rc =3D rmi_read(rmi_dev, query_base_addr + query_size,
+					&sensor_query->f11_2d_query6);
+		if (rc < 0)
+			return rc;
+		query_size++;
+	}
+
+	if (sensor_query->info.has_gestures) {
+		rc =3D rmi_read_block(rmi_dev, query_base_addr + query_size,
+					&sensor_query->gesture_info,
+					sizeof(sensor_query->gesture_info));
+		if (rc < 0)
+			return rc;
+		query_size +=3D sizeof(sensor_query->gesture_info);
+	}
+
+	if (dev_query->has_query9) {
+		rc =3D rmi_read_block(rmi_dev, query_base_addr + query_size,
+					&sensor_query->query9,
+					sizeof(sensor_query->query9));
+		if (rc < 0)
+			return rc;
+		query_size +=3D sizeof(sensor_query->query9);
+	}
+
+	if (sensor_query->gesture_info.has_touch_shapes) {
+		rc =3D rmi_read_block(rmi_dev, query_base_addr + query_size,
+					&sensor_query->ts_info,
+					sizeof(sensor_query->ts_info));
+		if (rc < 0)
+			return rc;
+		query_size +=3D sizeof(sensor_query->ts_info);
+	}
+
+	if (dev_query->has_query11) {
+		rc =3D rmi_read_block(rmi_dev, query_base_addr + query_size,
+					&sensor_query->features_1,
+					sizeof(sensor_query->features_1));
+		if (rc < 0)
+			return rc;
+		query_size +=3D sizeof(sensor_query->features_1);
+	}
+
+	if (dev_query->has_query12) {
+		rc =3D rmi_read_block(rmi_dev, query_base_addr + query_size,
+					&sensor_query->features_2,
+					sizeof(sensor_query->features_2));
+		if (rc < 0)
+			return rc;
+		query_size +=3D sizeof(sensor_query->features_2);
+	}
+
+	if (sensor_query->abs_info.has_jitter_filter) {
+		rc =3D rmi_read_block(rmi_dev, query_base_addr + query_size,
+					&sensor_query->jitter_filter,
+					sizeof(sensor_query->jitter_filter));
+		if (rc < 0)
+			return rc;
+		query_size +=3D sizeof(sensor_query->jitter_filter);
+	}
+
+	if (dev_query->has_query12 && sensor_query->features_2.has_info2) {
+		rc =3D rmi_read_block(rmi_dev, query_base_addr + query_size,
+				    &sensor_query->info_2,
+					sizeof(sensor_query->info_2));
+		if (rc < 0)
+			return rc;
+		query_size +=3D sizeof(sensor_query->info_2);
+	}
+
+	return query_size;
+}
+
+/* This operation is done in a number of places, so we have a handy ro=
utine
+ * for it.
+ */
+static void f11_set_abs_params(struct rmi_function_container *fc, int =
index)
+{
+	struct f11_data *f11 =3D fc->data;
+	struct f11_2d_sensor *sensor =3D &f11->sensors[index];
+	struct input_dev *input =3D sensor->input;
+	int device_x_max =3D
+		f11->dev_controls.ctrl0_9->sensor_max_x_pos;
+	int device_y_max =3D
+		f11->dev_controls.ctrl0_9->sensor_max_y_pos;
+	int x_min, x_max, y_min, y_max;
+	unsigned int input_flags;
+
+	/* We assume touchscreen unless demonstrably a touchpad or specified
+	 * as a touchpad in the platform data
+	 */
+	if (sensor->sensor_type =3D=3D rmi_f11_sensor_touchpad ||
+			(sensor->sens_query.features_2.has_info2 &&
+				!sensor->sens_query.info_2.is_clear))
+		input_flags =3D INPUT_PROP_POINTER;
+	else
+		input_flags =3D INPUT_PROP_DIRECT;
+	set_bit(input_flags, input->propbit);
+
+	if (sensor->axis_align.swap_axes) {
+		int temp =3D device_x_max;
+		device_x_max =3D device_y_max;
+		device_y_max =3D temp;
+	}
+	/* Use the max X and max Y read from the device, or the clip values,
+	 * whichever is stricter.
+	 */
+	x_min =3D sensor->axis_align.clip_X_low;
+	if (sensor->axis_align.clip_X_high)
+		x_max =3D min((int) device_x_max,
+			sensor->axis_align.clip_X_high);
+	else
+		x_max =3D device_x_max;
+
+	y_min =3D sensor->axis_align.clip_Y_low;
+	if (sensor->axis_align.clip_Y_high)
+		y_max =3D min((int) device_y_max,
+			sensor->axis_align.clip_Y_high);
+	else
+		y_max =3D device_y_max;
+
+	dev_dbg(&fc->dev, "Set ranges X=3D[%d..%d] Y=3D[%d..%d].",
+			x_min, x_max, y_min, y_max);
+
+	input_set_abs_params(input, ABS_MT_PRESSURE, 0,
+			DEFAULT_MAX_ABS_MT_PRESSURE, 0, 0);
+	input_set_abs_params(input, ABS_MT_TOUCH_MAJOR,
+			0, DEFAULT_MAX_ABS_MT_TOUCH, 0, 0);
+	input_set_abs_params(input, ABS_MT_TOUCH_MINOR,
+			0, DEFAULT_MAX_ABS_MT_TOUCH, 0, 0);
+	input_set_abs_params(input, ABS_MT_ORIENTATION,
+			0, DEFAULT_MAX_ABS_MT_ORIENTATION, 0, 0);
+	input_set_abs_params(input, ABS_MT_TRACKING_ID,
+			DEFAULT_MIN_ABS_MT_TRACKING_ID,
+			DEFAULT_MAX_ABS_MT_TRACKING_ID, 0, 0);
+	/* TODO get max_x_pos (and y) from control registers. */
+	input_set_abs_params(input, ABS_MT_POSITION_X,
+			x_min, x_max, 0, 0);
+	input_set_abs_params(input, ABS_MT_POSITION_Y,
+			y_min, y_max, 0, 0);
+	if (!sensor->type_a)
+		input_mt_init_slots(input, sensor->nbr_fingers, input_flags);
+	if (IS_ENABLED(CONFIG_RMI4_F11_PEN) &&
+			sensor->sens_query.query9.has_pen)
+		input_set_abs_params(input, ABS_MT_TOOL_TYPE,
+				     0, MT_TOOL_MAX, 0, 0);
+	else
+		input_set_abs_params(input, ABS_MT_TOOL_TYPE,
+				     0, MT_TOOL_FINGER, 0, 0);
+}
+
+static int rmi_f11_initialize(struct rmi_function_container *fc)
+{
+	struct rmi_device *rmi_dev =3D fc->rmi_dev;
+	struct f11_data *f11;
+	struct f11_2d_ctrl *ctrl;
+	u8 query_offset;
+	u16 query_base_addr;
+	u16 control_base_addr;
+	u16 max_x_pos, max_y_pos, temp;
+	int rc;
+	int i;
+	struct rmi_device_platform_data *pdata =3D to_rmi_platform_data(rmi_d=
ev);
+
+	dev_dbg(&fc->dev, "Initializing F11 values for %s.\n",
+		 pdata->sensor_name);
+
+	/*
+	** init instance data, fill in values and create any sysfs files
+	*/
+	f11 =3D devm_kzalloc(&fc->dev, sizeof(struct f11_data), GFP_KERNEL);
+	if (!f11)
+		return -ENOMEM;
+
+	fc->data =3D f11;
+	f11->rezero_wait_ms =3D pdata->f11_rezero_wait;
+
+	query_base_addr =3D fc->fd.query_base_addr;
+	control_base_addr =3D fc->fd.control_base_addr;
+
+	rc =3D rmi_read(rmi_dev, query_base_addr, &f11->dev_query);
+	if (rc < 0)
+		return rc;
+
+	query_offset =3D (query_base_addr + 1);
+	/* Increase with one since number of sensors is zero based */
+	for (i =3D 0; i < (f11->dev_query.nbr_of_sensors + 1); i++) {
+		struct f11_2d_sensor *sensor =3D &f11->sensors[i];
+		sensor->sensor_index =3D i;
+		sensor->fc =3D fc;
+
+		rc =3D rmi_f11_get_query_parameters(rmi_dev, &f11->dev_query,
+				&sensor->sens_query, query_offset);
+		if (rc < 0)
+			return rc;
+		query_offset +=3D rc;
+
+		rc =3D f11_allocate_control_regs(fc,
+				&f11->dev_query, &sensor->sens_query,
+				&f11->dev_controls, control_base_addr);
+		if (rc < 0) {
+			dev_err(&fc->dev,
+				"Failed to allocate F11 control params.\n");
+			return rc;
+		}
+
+		rc =3D f11_read_control_regs(fc, &f11->dev_controls,
+				control_base_addr);
+		if (rc < 0) {
+			dev_err(&fc->dev,
+				"Failed to read F11 control params.\n");
+			return rc;
+		}
+
+		if (i < pdata->f11_sensor_count) {
+			sensor->axis_align =3D
+				pdata->f11_sensor_data[i].axis_align;
+			sensor->type_a =3D pdata->f11_sensor_data[i].type_a;
+			sensor->sensor_type =3D
+					pdata->f11_sensor_data[i].sensor_type;
+		}
+
+		rc =3D rmi_read_block(rmi_dev,
+			control_base_addr + F11_CTRL_SENSOR_MAX_X_POS_OFFSET,
+			(u8 *)&max_x_pos, sizeof(max_x_pos));
+		if (rc < 0)
+			return rc;
+
+		rc =3D rmi_read_block(rmi_dev,
+			control_base_addr + F11_CTRL_SENSOR_MAX_Y_POS_OFFSET,
+			(u8 *)&max_y_pos, sizeof(max_y_pos));
+		if (rc < 0)
+			return rc;
+
+		if (sensor->axis_align.swap_axes) {
+			temp =3D max_x_pos;
+			max_x_pos =3D max_y_pos;
+			max_y_pos =3D temp;
+		}
+		sensor->max_x =3D max_x_pos;
+		sensor->max_y =3D max_y_pos;
+
+		rc =3D f11_2d_construct_data(sensor);
+		if (rc < 0)
+			return rc;
+
+		ctrl =3D &f11->dev_controls;
+		if (sensor->axis_align.delta_x_threshold) {
+			ctrl->ctrl0_9->delta_x_threshold =3D
+				sensor->axis_align.delta_x_threshold;
+			rc =3D rmi_write_block(rmi_dev,
+					ctrl->ctrl0_9_address,
+					ctrl->ctrl0_9,
+					sizeof(*ctrl->ctrl0_9));
+			if (rc < 0)
+				dev_warn(&fc->dev, "Failed to write to delta_x_threshold %d. Code:=
 %d.\n",
+					i, rc);
+
+		}
+
+		if (sensor->axis_align.delta_y_threshold) {
+			ctrl->ctrl0_9->delta_y_threshold =3D
+				sensor->axis_align.delta_y_threshold;
+			rc =3D rmi_write_block(rmi_dev,
+					ctrl->ctrl0_9_address,
+					ctrl->ctrl0_9,
+					sizeof(*ctrl->ctrl0_9));
+			if (rc < 0)
+				dev_warn(&fc->dev, "Failed to write to delta_y_threshold %d. Code:=
 %d.\n",
+					i, rc);
+		}
+
+		if (IS_ENABLED(CONFIG_RMI4_DEBUG)) {
+			rc =3D setup_sensor_debugfs(sensor);
+			if (rc < 0)
+				dev_warn(&fc->dev, "Failed to setup debugfs for F11 sensor %d. Cod=
e: %d.\n",
+					i, rc);
+		}
+	}
+
+	if (IS_ENABLED(CONFIG_RMI4_DEBUG)) {
+		rc =3D setup_f11_debugfs(fc);
+		if (rc < 0)
+			dev_warn(&fc->dev, "Failed to setup debugfs for F11. Code: %d.\n",
+				rc);
+	}
+
+	mutex_init(&f11->dev_controls_mutex);
+	return 0;
+}
+
+static int rmi_f11_register_devices(struct rmi_function_container *fc)
+{
+	struct rmi_device *rmi_dev =3D fc->rmi_dev;
+	struct f11_data *f11 =3D fc->data;
+	struct input_dev *input_dev;
+	struct input_dev *input_dev_mouse;
+	struct rmi_driver_data *driver_data =3D dev_get_drvdata(&rmi_dev->dev=
);
+	struct rmi_driver *driver =3D rmi_dev->driver;
+	int sensors_itertd =3D 0;
+	int i;
+	int rc;
+	int board, version;
+
+	board =3D driver_data->board;
+	version =3D driver_data->rev;
+
+	for (i =3D 0; i < (f11->dev_query.nbr_of_sensors + 1); i++) {
+		struct f11_2d_sensor *sensor =3D &f11->sensors[i];
+		sensors_itertd =3D i;
+		input_dev =3D input_allocate_device();
+		if (!input_dev) {
+			rc =3D -ENOMEM;
+			goto error_unregister;
+		}
+
+		sensor->input =3D input_dev;
+		if (driver->set_input_params) {
+			rc =3D driver->set_input_params(rmi_dev, input_dev);
+			if (rc < 0) {
+				dev_err(&fc->dev,
+				"%s: Error in setting input device.\n",
+				__func__);
+				goto error_unregister;
+			}
+		}
+		sprintf(sensor->input_phys, "%s.abs%d/input0",
+			dev_name(&fc->dev), i);
+		input_dev->phys =3D sensor->input_phys;
+		input_dev->dev.parent =3D &rmi_dev->dev;
+		input_set_drvdata(input_dev, f11);
+
+		set_bit(EV_SYN, input_dev->evbit);
+		set_bit(EV_ABS, input_dev->evbit);
+		input_set_capability(input_dev, EV_KEY, BTN_TOUCH);
+
+		f11_set_abs_params(fc, i);
+
+		if (sensor->sens_query.info.has_rel) {
+			set_bit(EV_REL, input_dev->evbit);
+			set_bit(REL_X, input_dev->relbit);
+			set_bit(REL_Y, input_dev->relbit);
+		}
+		rc =3D input_register_device(input_dev);
+		if (rc < 0) {
+			input_free_device(input_dev);
+			sensor->input =3D NULL;
+			goto error_unregister;
+		}
+
+		if (sensor->sens_query.info.has_rel) {
+			/*create input device for mouse events  */
+			input_dev_mouse =3D input_allocate_device();
+			if (!input_dev_mouse) {
+				rc =3D -ENOMEM;
+				goto error_unregister;
+			}
+
+			sensor->mouse_input =3D input_dev_mouse;
+			if (driver->set_input_params) {
+				rc =3D driver->set_input_params(rmi_dev,
+					input_dev_mouse);
+				if (rc < 0) {
+					dev_err(&fc->dev,
+					"%s: Error in setting input device.\n",
+					__func__);
+					goto error_unregister;
+				}
+			}
+			sprintf(sensor->input_phys_mouse, "%s.rel%d/input0",
+				dev_name(&fc->dev), i);
+			set_bit(EV_REL, input_dev_mouse->evbit);
+			set_bit(REL_X, input_dev_mouse->relbit);
+			set_bit(REL_Y, input_dev_mouse->relbit);
+
+			set_bit(BTN_MOUSE, input_dev_mouse->evbit);
+			/* Register device's buttons and keys */
+			set_bit(EV_KEY, input_dev_mouse->evbit);
+			set_bit(BTN_LEFT, input_dev_mouse->keybit);
+			set_bit(BTN_MIDDLE, input_dev_mouse->keybit);
+			set_bit(BTN_RIGHT, input_dev_mouse->keybit);
+
+			rc =3D input_register_device(input_dev_mouse);
+			if (rc < 0) {
+				input_free_device(input_dev_mouse);
+				sensor->mouse_input =3D NULL;
+				goto error_unregister;
+			}
+
+			set_bit(BTN_RIGHT, input_dev_mouse->keybit);
+		}
+
+	}
+
+	return 0;
+
+error_unregister:
+	for (; sensors_itertd > 0; sensors_itertd--) {
+		if (f11->sensors[sensors_itertd].input) {
+			if (f11->sensors[sensors_itertd].mouse_input) {
+				input_unregister_device(
+				   f11->sensors[sensors_itertd].mouse_input);
+				f11->sensors[sensors_itertd].mouse_input =3D NULL;
+			}
+			input_unregister_device(f11->sensors[i].input);
+			f11->sensors[i].input =3D NULL;
+		}
+	}
+
+	return rc;
+}
+
+static void rmi_f11_free_devices(struct rmi_function_container *fc)
+{
+	struct f11_data *f11 =3D fc->data;
+	int i;
+
+	for (i =3D 0; i < (f11->dev_query.nbr_of_sensors + 1); i++) {
+		if (f11->sensors[i].input)
+			input_unregister_device(f11->sensors[i].input);
+		if (f11->sensors[i].mouse_input)
+			input_unregister_device(f11->sensors[i].mouse_input);
+	}
+}
+
+static int rmi_f11_create_sysfs(struct rmi_function_container *fc)
+{
+	int attr_count =3D 0;
+	int rc;
+
+	for (attr_count =3D 0; attr_count < ARRAY_SIZE(attrs); attr_count++) =
{
+		if (sysfs_create_file
+		    (&fc->dev.kobj, &attrs[attr_count].attr) < 0) {
+			dev_err(&fc->dev, "Failed to create sysfs file for %s.",
+				attrs[attr_count].attr.name);
+			rc =3D -ENODEV;
+			goto err_remove_sysfs;
+		}
+	}
+
+	return 0;
+
+err_remove_sysfs:
+	for (attr_count--; attr_count >=3D 0; attr_count--)
+		sysfs_remove_file(&fc->dev.kobj, &attrs[attr_count].attr);
+	return rc;
+}
+
+static int rmi_f11_config(struct rmi_function_container *fc)
+{
+	struct f11_data *f11 =3D fc->data;
+	int i;
+	int rc;
+
+	for (i =3D 0; i < (f11->dev_query.nbr_of_sensors + 1); i++) {
+		rc =3D f11_write_control_regs(fc, &f11->sensors[i].sens_query,
+				   &f11->dev_controls, fc->fd.query_base_addr);
+		if (rc < 0)
+			return rc;
+	}
+
+	return 0;
+}
+
+int rmi_f11_attention(struct rmi_function_container *fc,
+						unsigned long *irq_bits)
+{
+	struct rmi_device *rmi_dev =3D fc->rmi_dev;
+	struct f11_data *f11 =3D fc->data;
+	u16 data_base_addr =3D fc->fd.data_base_addr;
+	u16 data_base_addr_offset =3D 0;
+	int error;
+	int i;
+
+	for (i =3D 0; i < f11->dev_query.nbr_of_sensors + 1; i++) {
+		error =3D rmi_read_block(rmi_dev,
+				data_base_addr + data_base_addr_offset,
+				f11->sensors[i].data_pkt,
+				f11->sensors[i].pkt_size);
+		if (error < 0)
+			return error;
+
+		rmi_f11_finger_handler(f11, &f11->sensors[i]);
+		data_base_addr_offset +=3D f11->sensors[i].pkt_size;
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int rmi_f11_resume(struct rmi_function_container *fc)
+{
+	struct rmi_device *rmi_dev =3D fc->rmi_dev;
+	struct f11_data *data =3D fc->data;
+	/* Command register always reads as 0, so we can just use a local. */
+	struct f11_2d_commands commands =3D {
+		.rezero =3D true,
+	};
+	int retval =3D 0;
+
+	dev_dbg(&fc->dev, "Resuming...\n");
+	if (!data->rezero_wait_ms)
+		return 0;
+
+	mdelay(data->rezero_wait_ms);
+
+	retval =3D rmi_write_block(rmi_dev, fc->fd.command_base_addr,
+			&commands, sizeof(commands));
+	if (retval < 0) {
+		dev_err(&fc->dev, "%s: failed to issue rezero command, error =3D %d.=
",
+			__func__, retval);
+		return retval;
+	}
+
+	return retval;
+}
+#endif /* CONFIG_PM */
+
+static int f11_remove_device(struct device *dev)
+{
+	int attr_count =3D 0;
+	struct f11_data *f11;
+	struct rmi_function_container *fc =3D to_rmi_function_container(dev);
+
+	f11 =3D fc->data;
+
+	if (IS_ENABLED(CONFIG_RMI4_DEBUG)) {
+		int i;
+
+		for (i =3D 0; i < f11->dev_query.nbr_of_sensors + 1; i++)
+			teardown_sensor_debugfs(&f11->sensors[i]);
+		teardown_f11_debugfs(f11);
+	}
+
+	for (attr_count =3D 0; attr_count < ARRAY_SIZE(attrs); attr_count++)
+		sysfs_remove_file(&fc->dev.kobj, &attrs[attr_count].attr);
+
+	rmi_f11_free_devices(fc);
+	return 0;
+}
+
+static int f11_device_init(struct rmi_function_container *fc)
+{
+	int rc;
+
+	rc =3D rmi_f11_initialize(fc);
+	if (rc < 0)
+		return rc;
+
+	rc =3D rmi_f11_register_devices(fc);
+	if (rc < 0)
+		return rc;
+
+	rc =3D rmi_f11_create_sysfs(fc);
+	if (rc < 0)
+		return rc;
+
+	return 0;
+}
+
+static __devinit int f11_probe(struct device *dev)
+{
+	struct rmi_function_container *fc;
+
+	if (dev->type !=3D &rmi_function_type)
+		return 1;
+
+	fc =3D to_rmi_function_container(dev);
+	if (fc->fd.function_number !=3D FUNCTION_NUMBER)
+		return 1;
+
+	return f11_device_init(fc);
+}
+
+
+static struct rmi_function_handler function_handler =3D {
+	.driver =3D {
+		.owner =3D THIS_MODULE,
+		.name =3D "rmi_f11",
+		.bus =3D &rmi_bus_type,
+		.probe =3D f11_probe,
+		.remove =3D f11_remove_device,
+	},
+	.func =3D FUNCTION_NUMBER,
+	.config =3D rmi_f11_config,
+	.attention =3D rmi_f11_attention,
+#ifdef CONFIG_HAS_EARLYSUSPEND
+	.late_resume =3D rmi_f11_resume
+#elif defined(CONFIG_PM)
+	.resume =3D rmi_f11_resume
+#endif  /* defined(CONFIG_HAS_EARLYSUSPEND) */
+};
+
+static int __init rmi_f11_module_init(void)
+{
+	int error;
+
+	error =3D driver_register(&function_handler.driver);
+	if (error < 0) {
+		pr_err("%s: register driver failed!\n", __func__);
+		return error;
+	}
+
+	return 0;
+}
+
+static void __exit rmi_f11_module_exit(void)
+{
+	driver_unregister(&function_handler.driver);
+}
+
+module_init(rmi_f11_module_init);
+module_exit(rmi_f11_module_exit);
+
+MODULE_AUTHOR("Christopher Heiny <cheiny@synaptics.com");
+MODULE_DESCRIPTION("RMI F11 module");
+MODULE_LICENSE("GPL");
+MODULE_VERSION(RMI_DRIVER_VERSION);
