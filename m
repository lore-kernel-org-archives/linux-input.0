From: Courtney Cavin <courtney.cavin@sonymobile.com>
Subject: [PATCH 09/15] Input: synaptics-rmi4 - remove unused defines and variables
Date: Thu, 23 Jan 2014 16:00:17 -0800
Message-ID: <1390521623-6491-10-git-send-email-courtney.cavin@sonymobile.com>
References: <1390521623-6491-1-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-2-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-3-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-4-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-5-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-6-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-7-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-8-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-9-git-send-email-courtney.cavin@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from seldrel01.sonyericsson.com ([212.209.106.2]:19810 "EHLO
	seldrel01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752837AbaAWX7w convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jan 2014 18:59:52 -0500
In-Reply-To: <1390521623-6491-9-git-send-email-courtney.cavin@sonymobile.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, cheiny@synaptics.com

This is neither a library nor documentation, so it doesn't need to
contain all of the information available.  Remove most of the unused
struct members and defines.  If they are need to implement some
functionality at a later point, they can be added back at that point.

Cc: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Courtney Cavin <courtney.cavin@sonymobile.com>
---
 drivers/input/rmi4/rmi_bus.h    |   1 -
 drivers/input/rmi4/rmi_driver.c |   3 -
 drivers/input/rmi4/rmi_f01.c    |  40 -----
 drivers/input/rmi4/rmi_f11.c    | 375 --------------------------------=
--------
 4 files changed, 419 deletions(-)

diff --git a/drivers/input/rmi4/rmi_bus.h b/drivers/input/rmi4/rmi_bus.=
h
index 62fd544..a21e4c4 100644
--- a/drivers/input/rmi4/rmi_bus.h
+++ b/drivers/input/rmi4/rmi_bus.h
@@ -278,7 +278,6 @@ static inline int rmi_write_block(struct rmi_device=
 *d, u16 addr,
=20
 int rmi_register_transport_device(struct rmi_transport_dev *xport);
 void rmi_unregister_transport_device(struct rmi_transport_dev *xport);
-int rmi_for_each_dev(void *data, int (*func)(struct device *dev, void =
*data));
=20
 /**
  * module_rmi_driver() - Helper macro for registering a function drive=
r
diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_d=
river.c
index e44eff7..9ec7b93 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -32,15 +32,12 @@
=20
 #define RMI4_MAX_N_IRQS 256
=20
-#define HAS_NONSTANDARD_PDT_MASK 0x40
 #define RMI4_MAX_PAGE 0xff
 #define RMI4_PAGE_SIZE 0x100
=20
 #define RMI_DEVICE_RESET_CMD	0x01
 #define DEFAULT_RESET_DELAY_MS	100
=20
-#define DEFAULT_POLL_INTERVAL_MS	13
-
 static irqreturn_t rmi_irq_thread(int irq, void *p)
 {
 	struct rmi_transport_dev *xport =3D p;
diff --git a/drivers/input/rmi4/rmi_f01.c b/drivers/input/rmi4/rmi_f01.=
c
index 98bc65a9..4cb9fcb 100644
--- a/drivers/input/rmi4/rmi_f01.c
+++ b/drivers/input/rmi4/rmi_f01.c
@@ -15,27 +15,11 @@
 #include "rmi_driver.h"
=20
 #define RMI_PRODUCT_ID_LENGTH    10
-#define RMI_PRODUCT_INFO_LENGTH   2
-
-#define RMI_DATE_CODE_LENGTH      3
-
-#define PRODUCT_ID_OFFSET 0x10
-#define PRODUCT_INFO_OFFSET 0x1E
-
-
-/* Force a firmware reset of the sensor */
-#define RMI_F01_CMD_DEVICE_RESET	1
=20
 /* Various F01_RMI_QueryX bits */
-
-#define RMI_F01_QRY1_CUSTOM_MAP		(1 << 0)
-#define RMI_F01_QRY1_NON_COMPLIANT	(1 << 1)
 #define RMI_F01_QRY1_HAS_LTS		(1 << 2)
-#define RMI_F01_QRY1_HAS_SENSOR_ID	(1 << 3)
-#define RMI_F01_QRY1_HAS_CHARGER_INP	(1 << 4)
 #define RMI_F01_QRY1_HAS_ADJ_DOZE	(1 << 5)
 #define RMI_F01_QRY1_HAS_ADJ_DOZE_HOFF	(1 << 6)
-#define RMI_F01_QRY1_HAS_PROPS_2	(1 << 7)
=20
 #define RMI_F01_QRY5_YEAR_MASK		0x1f
 #define RMI_F01_QRY6_MONTH_MASK		0x0f
@@ -52,7 +36,6 @@ struct f01_basic_properties {
 	bool has_adjustable_doze_holdoff;
 	char dom[11]; /* YYYY/MM/DD + '\0' */
 	u8 product_id[RMI_PRODUCT_ID_LENGTH + 1];
-	u16 productinfo;
 };
=20
 /* F01 device status bits */
@@ -87,19 +70,6 @@ struct f01_basic_properties {
 #define RMI_F01_CRTL0_NOSLEEP_BIT	(1 << 2)
=20
 /*
- * When this bit is set, the touch controller employs a noise-filterin=
g
- * algorithm designed for use with a connected battery charger.
- */
-#define RMI_F01_CRTL0_CHARGER_BIT	(1 << 5)
-
-/*
- * Sets the report rate for the device. The effect of this setting is
- * highly product dependent. Check the spec sheet for your particular
- * touch sensor.
- */
-#define RMI_F01_CRTL0_REPORTRATE_BIT	(1 << 6)
-
-/*
  * Written by the host as an indicator that the device has been
  * successfully configured.
  */
@@ -127,7 +97,6 @@ struct f01_data {
 	struct f01_basic_properties properties;
=20
 	struct f01_device_control device_control;
-	struct mutex control_mutex;
=20
 	u8 device_status;
=20
@@ -135,11 +104,9 @@ struct f01_data {
 	u16 doze_interval_addr;
 	u16 wakeup_threshold_addr;
 	u16 doze_holdoff_addr;
-	int irq_count;
 	int num_of_irq_regs;
=20
 #ifdef CONFIG_PM_SLEEP
-	bool suspended;
 	bool old_nosleep;
 #endif
 };
@@ -199,10 +166,6 @@ static int rmi_f01_read_properties(struct rmi_devi=
ce *rmi_dev,
 		RMI_PRODUCT_ID_LENGTH);
 	props->product_id[RMI_PRODUCT_ID_LENGTH] =3D '\0';
=20
-	props->productinfo =3D
-			((basic_query[2] & RMI_F01_QRY2_PRODINFO_MASK) << 7) |
-			(basic_query[3] & RMI_F01_QRY2_PRODINFO_MASK);
-
 	return 0;
 }
=20
@@ -216,8 +179,6 @@ static int rmi_f01_initialize(struct rmi_function *=
fn)
 	struct f01_data *data =3D fn->data;
 	struct rmi_device_platform_data *pdata =3D to_rmi_platform_data(rmi_d=
ev);
=20
-	mutex_init(&data->control_mutex);
-
 	/*
 	 * Set the configured bit and (optionally) other important stuff
 	 * in the device control register.
@@ -263,7 +224,6 @@ static int rmi_f01_initialize(struct rmi_function *=
fn)
 		return error;
 	}
=20
-	data->irq_count =3D driver_data->irq_count;
 	data->num_of_irq_regs =3D driver_data->num_of_irq_regs;
 	ctrl_base_addr +=3D sizeof(u8);
=20
diff --git a/drivers/input/rmi4/rmi_f11.c b/drivers/input/rmi4/rmi_f11.=
c
index 9d94b1a..b114f25 100644
--- a/drivers/input/rmi4/rmi_f11.c
+++ b/drivers/input/rmi4/rmi_f11.c
@@ -7,8 +7,6 @@
  * the Free Software Foundation.
  */
=20
-#define FUNCTION_DATA f11_data
-
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -19,9 +17,6 @@
 #include <linux/slab.h>
 #include "rmi_driver.h"
=20
-#define F11_MAX_NUM_OF_FINGERS		10
-#define F11_MAX_NUM_OF_TOUCH_SHAPES	16
-
 #define F11_REL_POS_MIN		-128
 #define F11_REL_POS_MAX		127
=20
@@ -30,14 +25,12 @@
 #define F11_CTRL_SENSOR_MAX_X_POS_OFFSET	6
 #define F11_CTRL_SENSOR_MAX_Y_POS_OFFSET	8
=20
-#define DEFAULT_XY_MAX 9999
 #define DEFAULT_MAX_ABS_MT_PRESSURE 255
 #define DEFAULT_MAX_ABS_MT_TOUCH 15
 #define DEFAULT_MAX_ABS_MT_ORIENTATION 1
 #define DEFAULT_MIN_ABS_MT_TRACKING_ID 1
 #define DEFAULT_MAX_ABS_MT_TRACKING_ID 10
 #define NAME_BUFFER_SIZE 256
-#define FUNCTION_NUMBER 0x11
=20
 /** A note about RMI4 F11 register structure.
  *
@@ -81,108 +74,37 @@
 #define RMI_F11_HAS_QUERY28             (1 << 7)
=20
 /** Defs for Query 1 */
-
 #define RMI_F11_NR_FINGERS_MASK 0x07
 #define RMI_F11_HAS_REL                 (1 << 3)
 #define RMI_F11_HAS_ABS                 (1 << 4)
 #define RMI_F11_HAS_GESTURES            (1 << 5)
-#define RMI_F11_HAS_SENSITIVITY_ADJ     (1 << 6)
-#define RMI_F11_CONFIGURABLE            (1 << 7)
-
-/** Defs for Query 2, 3, and 4. */
-#define RMI_F11_NR_ELECTRODES_MASK      0x7F
=20
 /** Defs for Query 5 */
-
-#define RMI_F11_ABS_DATA_SIZE_MASK      0x03
-#define RMI_F11_HAS_ANCHORED_FINGER     (1 << 2)
-#define RMI_F11_HAS_ADJ_HYST            (1 << 3)
-#define RMI_F11_HAS_DRIBBLE             (1 << 4)
-#define RMI_F11_HAS_BENDING_CORRECTION  (1 << 5)
-#define RMI_F11_HAS_LARGE_OBJECT_SUPPRESSION    (1 << 6)
 #define RMI_F11_HAS_JITTER_FILTER       (1 << 7)
=20
 /** Defs for Query 7 */
-#define RMI_F11_HAS_SINGLE_TAP                  (1 << 0)
-#define RMI_F11_HAS_TAP_AND_HOLD                (1 << 1)
-#define RMI_F11_HAS_DOUBLE_TAP                  (1 << 2)
-#define RMI_F11_HAS_EARLY_TAP                   (1 << 3)
 #define RMI_F11_HAS_FLICK                       (1 << 4)
-#define RMI_F11_HAS_PRESS                       (1 << 5)
 #define RMI_F11_HAS_PINCH                       (1 << 6)
-#define RMI_F11_HAS_CHIRAL                      (1 << 7)
=20
 /** Defs for Query 8 */
-#define RMI_F11_HAS_PALM_DET                    (1 << 0)
 #define RMI_F11_HAS_ROTATE                      (1 << 1)
 #define RMI_F11_HAS_TOUCH_SHAPES                (1 << 2)
-#define RMI_F11_HAS_SCROLL_ZONES                (1 << 3)
-#define RMI_F11_HAS_INDIVIDUAL_SCROLL_ZONES     (1 << 4)
-#define RMI_F11_HAS_MF_SCROLL                   (1 << 5)
-#define RMI_F11_HAS_MF_EDGE_MOTION              (1 << 6)
-#define RMI_F11_HAS_MF_SCROLL_INERTIA           (1 << 7)
=20
 /** Defs for Query 9. */
 #define RMI_F11_HAS_PEN                         (1 << 0)
-#define RMI_F11_HAS_PROXIMITY                   (1 << 1)
-#define RMI_F11_HAS_PALM_DET_SENSITIVITY        (1 << 2)
-#define RMI_F11_HAS_SUPPRESS_ON_PALM_DETECT     (1 << 3)
-#define RMI_F11_HAS_TWO_PEN_THRESHOLDS          (1 << 4)
-#define RMI_F11_HAS_CONTACT_GEOMETRY            (1 << 5)
-#define RMI_F11_HAS_PEN_HOVER_DISCRIMINATION    (1 << 6)
-#define RMI_F11_HAS_PEN_FILTERS                 (1 << 7)
=20
 /** Defs for Query 10. */
 #define RMI_F11_NR_TOUCH_SHAPES_MASK            0x1F
=20
-/** Defs for Query 11 */
-
-#define RMI_F11_HAS_Z_TUNING                    (1 << 0)
-#define RMI_F11_HAS_ALGORITHM_SELECTION         (1 << 1)
-#define RMI_F11_HAS_W_TUNING                    (1 << 2)
-#define RMI_F11_HAS_PITCH_INFO                  (1 << 3)
-#define RMI_F11_HAS_FINGER_SIZE                 (1 << 4)
-#define RMI_F11_HAS_SEGMENTATION_AGGRESSIVENESS (1 << 5)
-#define RMI_F11_HAS_XY_CLIP                     (1 << 6)
-#define RMI_F11_HAS_DRUMMING_FILTER             (1 << 7)
-
 /** Defs for Query 12. */
-
-#define RMI_F11_HAS_GAPLESS_FINGER              (1 << 0)
-#define RMI_F11_HAS_GAPLESS_FINGER_TUNING       (1 << 1)
-#define RMI_F11_HAS_8BIT_W                      (1 << 2)
-#define RMI_F11_HAS_ADJUSTABLE_MAPPING          (1 << 3)
 #define RMI_F11_HAS_INFO2                       (1 << 4)
-#define RMI_F11_HAS_PHYSICAL_PROPS              (1 << 5)
-#define RMI_F11_HAS_FINGER_LIMIT                (1 << 6)
-#define RMI_F11_HAS_LINEAR_COEFF                (1 << 7)
-
-/** Defs for Query 13. */
-
-#define RMI_F11_JITTER_WINDOW_MASK              0x1F
-#define RMI_F11_JITTER_FILTER_MASK              0x60
-#define RMI_F11_JITTER_FILTER_SHIFT             5
=20
 /** Defs for Query 14. */
-#define RMI_F11_LIGHT_CONTROL_MASK              0x03
 #define RMI_F11_IS_CLEAR                        (1 << 2)
-#define RMI_F11_CLICKPAD_PROPS_MASK             0x18
-#define RMI_F11_CLICKPAD_PROPS_SHIFT            3
-#define RMI_F11_MOUSE_BUTTONS_MASK              0x60
-#define RMI_F11_MOUSE_BUTTONS_SHIFT             5
-#define RMI_F11_HAS_ADVANCED_GESTURES           (1 << 7)
=20
 #define RMI_F11_QUERY_SIZE                      4
 #define RMI_F11_QUERY_GESTURE_SIZE              2
=20
-#define F11_LIGHT_CTL_NONE 0x00
-#define F11_LUXPAD	   0x01
-#define F11_DUAL_MODE      0x02
-
-#define F11_NOT_CLICKPAD     0x00
-#define F11_HINGED_CLICKPAD  0x01
-#define F11_UNIFORM_CLICKPAD 0x02
-
 /**
  * Query registers 1 through 4 are always present.
  *
@@ -191,55 +113,18 @@
  * @has_rel - the sensor supports relative motion reporting.
  * @has_abs - the sensor supports absolute poition reporting.
  * @has_gestures - the sensor supports gesture reporting.
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
  *
  * Query 5 is present if the has_abs bit is set.
  *
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
  * @has_jitter_filter - query 13 and control 73..76 exist.
  *
  * Gesture information queries 7 and 8 are present if has_gestures bit=
 is set.
  *
- * @has_single_tap - a basic single-tap gesture is supported.
- * @has_tap_n_hold - tap-and-hold gesture is supported.
- * @has_double_tap - double-tap gesture is supported.
- * @has_early_tap - early tap is supported and reported as soon as the=
 finger
- * lifts for any tap event that could be interpreted as either a singl=
e tap
- * or as the first tap of a double-tap or tap-and-hold gesture.
  * @has_flick - flick detection is supported.
- * @has_press - press gesture reporting is supported.
  * @has_pinch - pinch gesture detection is supported.
- * @has_palm_det - the 2-D sensor notifies the host whenever a large c=
onductive
- * object such as a palm or a cheek touches the 2-D sensor.
  * @has_rotate - rotation gesture detection is supported.
  * @has_touch_shapes - TouchShapes are supported.  A TouchShape is a f=
ixed
  * rectangular area on the sensor that behaves like a capacitive butto=
n.
- * @has_scroll_zones - scrolling areas near the sensor edges are suppo=
rted.
- * @has_individual_scroll_zones - if 1, then 4 scroll zones are suppor=
ted;
- * if 0, then only two are supported.
- * @has_mf_scroll - the multifinger_scrolling bit will be set when
- * more than one finger is involved in a scrolling action.
  *
  * Convenience for checking bytes in the gesture info registers.  This=
 is done
  * often enough that we put it here to declutter the conditionals
@@ -251,68 +136,21 @@
  *
  * @has_pen - detection of a stylus is supported and registers F11_2D_=
Ctrl20
  * and F11_2D_Ctrl21 exist.
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
- * map absolute X and Y target positions and registers F11_2D_Data18
- * through F11_2D_Data27 exist.
  *
  * Touch shape info (query 10) is present if has_touch_shapes is set.
  *
  * @nr_touch_shapes - the total number of touch shapes supported.
  *
  * Query 11 is present if the has_query11 bit is set in query 0.
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
- *
  * Query 12 is present if hasQuery12 bit is set.
  *
- * @has_gapless_finger - control registers relating to gapless finger =
are
- * present.
- * @has_gapless_finger_tuning - additional control and data registers =
relating
- * to gapless finger are present.
- * @has_8bit_w - larger W value reporting is supported.
- * @has_adjustable_mapping - TBD
  * @has_info2 - the general info query14 is present
- * @has_physical_props - additional queries describing the physical pr=
operties
- * of the sensor are present.
- * @has_finger_limit - indicates that F11 Ctrl 80 exists.
- * @has_linear_coeff - indicates that F11 Ctrl 81 exists.
  *
  * Query 13 is present if Query 5's has_jitter_filter bit is set.
- * @jitter_window_size - used by Design Studio 4.
- * @jitter_filter_type - used by Design Studio 4.
- *
  * Query 14 is present if query 12's has_general_info2 flag is set.
  *
- * @light_control - Indicates what light/led control features are pres=
ent, if
- * any.
  * @is_clear - if set, this is a clear sensor (indicating direct point=
ing
  * application), otherwise it's opaque (indicating indirect pointing).
- * @clickpad_props - specifies if this is a clickpad, and if so what s=
ort of
- * mechanism it uses
- * @mouse_buttons - specifies the number of mouse buttons present (if =
any).
- * @has_advanced_gestures - advanced driver gestures are supported.
  */
 struct f11_2d_sensor_queries {
 	/* query1 */
@@ -320,112 +158,34 @@ struct f11_2d_sensor_queries {
 	bool has_rel;
 	bool has_abs;
 	bool has_gestures;
-	bool has_sensitivity_adjust;
-	bool configurable;
-
-	/* query2 */
-	u8 nr_x_electrodes;
=20
-	/* query3 */
-	u8 nr_y_electrodes;
-
-	/* query4 */
-	u8 max_electrodes;
-
-	/* query5 */
-	u8 abs_data_size;
-	bool has_anchored_finger;
-	bool has_adj_hyst;
-	bool has_dribble;
-	bool has_bending_correction;
-	bool has_large_object_suppression;
 	bool has_jitter_filter;
=20
 	u8 f11_2d_query6;
=20
 	/* query 7 */
-	bool has_single_tap;
-	bool has_tap_n_hold;
-	bool has_double_tap;
-	bool has_early_tap;
 	bool has_flick;
-	bool has_press;
 	bool has_pinch;
-	bool has_chiral;
-
 	bool query7_nonzero;
=20
 	/* query 8 */
-	bool has_palm_det;
 	bool has_rotate;
 	bool has_touch_shapes;
-	bool has_scroll_zones;
-	bool has_individual_scroll_zones;
-	bool has_mf_scroll;
-	bool has_mf_edge_motion;
-	bool has_mf_scroll_inertia;
-
 	bool query8_nonzero;
=20
 	/* Query 9 */
 	bool has_pen;
-	bool has_proximity;
-	bool has_palm_det_sensitivity;
-	bool has_suppress_on_palm_detect;
-	bool has_two_pen_thresholds;
-	bool has_contact_geometry;
-	bool has_pen_hover_discrimination;
-	bool has_pen_filters;
=20
 	/* Query 10 */
 	u8 nr_touch_shapes;
=20
-	/* Query 11. */
-	bool has_z_tuning;
-	bool has_algorithm_selection;
-	bool has_w_tuning;
-	bool has_pitch_info;
-	bool has_finger_size;
-	bool has_segmentation_aggressiveness;
-	bool has_XY_clip;
-	bool has_drumming_filter;
-
 	/* Query 12 */
-	bool has_gapless_finger;
-	bool has_gapless_finger_tuning;
-	bool has_8bit_w;
-	bool has_adjustable_mapping;
 	bool has_info2;
-	bool has_physical_props;
-	bool has_finger_limit;
-	bool has_linear_coeff_2;
-
-	/* Query 13 */
-	u8 jitter_window_size;
-	u8 jitter_filter_type;
=20
 	/* Query 14 */
-	u8 light_control;
 	bool is_clear;
-	u8 clickpad_props;
-	u8 mouse_buttons;
-	bool has_advanced_gestures;
 };
=20
-/* Defs for Ctrl0. */
-#define RMI_F11_REPORT_MODE_MASK        0x07
-#define RMI_F11_ABS_POS_FILT            (1 << 3)
-#define RMI_F11_REL_POS_FILT            (1 << 4)
-#define RMI_F11_REL_BALLISTICS          (1 << 5)
-#define RMI_F11_DRIBBLE                 (1 << 6)
-#define RMI_F11_REPORT_BEYOND_CLIP      (1 << 7)
-
-/* Defs for Ctrl1. */
-#define RMI_F11_PALM_DETECT_THRESH_MASK 0x0F
-#define RMI_F11_MOTION_SENSITIVITY_MASK 0x30
-#define RMI_F11_MANUAL_TRACKING         (1 << 6)
-#define RMI_F11_MANUAL_TRACKED_FINGER   (1 << 7)
-
 #define RMI_F11_DELTA_X_THRESHOLD       2
 #define RMI_F11_DELTA_Y_THRESHOLD       3
=20
@@ -439,24 +199,6 @@ struct f11_2d_ctrl {
 #define RMI_F11_ABS_BYTES 5
 #define RMI_F11_REL_BYTES 2
=20
-/* Defs for Data 8 */
-
-#define RMI_F11_SINGLE_TAP              (1 << 0)
-#define RMI_F11_TAP_AND_HOLD            (1 << 1)
-#define RMI_F11_DOUBLE_TAP              (1 << 2)
-#define RMI_F11_EARLY_TAP               (1 << 3)
-#define RMI_F11_FLICK                   (1 << 4)
-#define RMI_F11_PRESS                   (1 << 5)
-#define RMI_F11_PINCH                   (1 << 6)
-
-/* Defs for Data 9 */
-
-#define RMI_F11_PALM_DETECT                     (1 << 0)
-#define RMI_F11_ROTATE                          (1 << 1)
-#define RMI_F11_SHAPE                           (1 << 2)
-#define RMI_F11_SCROLLZONE                      (1 << 3)
-#define RMI_F11_GESTURE_FINGER_COUNT_MASK       0x70
-
 /** Handy pointers into our data buffer.
  *
  * @f_state - start of finger state registers.
@@ -467,8 +209,6 @@ struct f11_2d_ctrl {
  * @pinch   - pinch motion register (if present).
  * @flick   - flick distance X & Y, flick time (if present).
  * @rotate  - rotate motion and finger separation.
- * @multi_scroll - chiral deltas for X and Y (if present).
- * @scroll_zones - scroll deltas for 4 regions (if present).
  */
 struct f11_2d_data {
 	u8	*f_state;
@@ -480,8 +220,6 @@ struct f11_2d_data {
 	u8	*flick;
 	u8	*rotate;
 	u8	*shapes;
-	s8	*multi_scroll;
-	s8	*scroll_zones;
 };
=20
 /**
@@ -495,7 +233,6 @@ struct f11_2d_data {
  * @nbr_fingers - How many fingers can this sensor report?
  * @data_pkt - buffer for data reported by this sensor.
  * @pkt_size - number of bytes in that buffer.
- * @sensor_index - identifies this particular 2D touch sensor
  * @type_a - some early RMI4 2D sensors do not reliably track the fing=
er
  * position when two fingers are on the device.  When this is true, we
  * assume we have one of those sensors and report events appropriately=
=2E
@@ -514,7 +251,6 @@ struct f11_2d_sensor {
 	u8 nbr_fingers;
 	u8 *data_pkt;
 	int pkt_size;
-	u8 sensor_index;
 	bool type_a;
 	enum rmi_f11_sensor_type sensor_type;
 	struct input_dev *input;
@@ -529,7 +265,6 @@ struct f11_2d_sensor {
  *
  * @dev_query - F11 device specific query registers.
  * @dev_controls - F11 device specific control registers.
- * @dev_controls_mutex - lock for the control registers.
  * @rezero_wait_ms - if nonzero, upon resume we will wait this many
  * milliseconds before rezeroing the sensor(s).  This is useful in sys=
tems with
  * poor electrical behavior on resume, where the initial calibration o=
f the
@@ -543,7 +278,6 @@ struct f11_data {
 	bool has_query27;
 	bool has_query28;
 	struct f11_2d_ctrl dev_controls;
-	struct mutex dev_controls_mutex;
 	u16 rezero_wait_ms;
 	struct f11_2d_sensor sensor;
 };
@@ -871,16 +605,6 @@ static int rmi_f11_get_query_parameters(struct rmi=
_device *rmi_dev,
 	sensor_query->has_rel =3D !!(query_buf[0] & RMI_F11_HAS_REL);
 	sensor_query->has_abs =3D !!(query_buf[0] & RMI_F11_HAS_ABS);
 	sensor_query->has_gestures =3D !!(query_buf[0] & RMI_F11_HAS_GESTURES=
);
-	sensor_query->has_sensitivity_adjust =3D
-		!!(query_buf[0] && RMI_F11_HAS_SENSITIVITY_ADJ);
-	sensor_query->configurable =3D !!(query_buf[0] & RMI_F11_CONFIGURABLE=
);
-
-	sensor_query->nr_x_electrodes =3D
-				query_buf[1] & RMI_F11_NR_ELECTRODES_MASK;
-	sensor_query->nr_y_electrodes =3D
-				query_buf[2] & RMI_F11_NR_ELECTRODES_MASK;
-	sensor_query->max_electrodes =3D
-				query_buf[3] & RMI_F11_NR_ELECTRODES_MASK;
=20
 	query_size =3D RMI_F11_QUERY_SIZE;
=20
@@ -889,18 +613,6 @@ static int rmi_f11_get_query_parameters(struct rmi=
_device *rmi_dev,
 		if (rc < 0)
 			return rc;
=20
-		sensor_query->abs_data_size =3D
-			query_buf[0] & RMI_F11_ABS_DATA_SIZE_MASK;
-		sensor_query->has_anchored_finger =3D
-			!!(query_buf[0] & RMI_F11_HAS_ANCHORED_FINGER);
-		sensor_query->has_adj_hyst =3D
-			!!(query_buf[0] & RMI_F11_HAS_ADJ_HYST);
-		sensor_query->has_dribble =3D
-			!!(query_buf[0] & RMI_F11_HAS_DRIBBLE);
-		sensor_query->has_bending_correction =3D
-			!!(query_buf[0] & RMI_F11_HAS_BENDING_CORRECTION);
-		sensor_query->has_large_object_suppression =3D
-		!!(query_buf[0] && RMI_F11_HAS_LARGE_OBJECT_SUPPRESSION);
 		sensor_query->has_jitter_filter =3D
 			!!(query_buf[0] & RMI_F11_HAS_JITTER_FILTER);
 		query_size++;
@@ -920,40 +632,16 @@ static int rmi_f11_get_query_parameters(struct rm=
i_device *rmi_dev,
 		if (rc < 0)
 			return rc;
=20
-		sensor_query->has_single_tap =3D
-			!!(query_buf[0] & RMI_F11_HAS_SINGLE_TAP);
-		sensor_query->has_tap_n_hold =3D
-			!!(query_buf[0] & RMI_F11_HAS_TAP_AND_HOLD);
-		sensor_query->has_double_tap =3D
-			!!(query_buf[0] & RMI_F11_HAS_DOUBLE_TAP);
-		sensor_query->has_early_tap =3D
-			!!(query_buf[0] & RMI_F11_HAS_EARLY_TAP);
 		sensor_query->has_flick =3D
 			!!(query_buf[0] & RMI_F11_HAS_FLICK);
-		sensor_query->has_press =3D
-			!!(query_buf[0] & RMI_F11_HAS_PRESS);
 		sensor_query->has_pinch =3D
 			!!(query_buf[0] & RMI_F11_HAS_PINCH);
-		sensor_query->has_chiral =3D
-			!!(query_buf[0] & RMI_F11_HAS_CHIRAL);
=20
 		/* query 8 */
-		sensor_query->has_palm_det =3D
-			!!(query_buf[1] & RMI_F11_HAS_PALM_DET);
 		sensor_query->has_rotate =3D
 			!!(query_buf[1] & RMI_F11_HAS_ROTATE);
 		sensor_query->has_touch_shapes =3D
 			!!(query_buf[1] & RMI_F11_HAS_TOUCH_SHAPES);
-		sensor_query->has_scroll_zones =3D
-			!!(query_buf[1] & RMI_F11_HAS_SCROLL_ZONES);
-		sensor_query->has_individual_scroll_zones =3D
-			!!(query_buf[1] & RMI_F11_HAS_INDIVIDUAL_SCROLL_ZONES);
-		sensor_query->has_mf_scroll =3D
-			!!(query_buf[1] & RMI_F11_HAS_MF_SCROLL);
-		sensor_query->has_mf_edge_motion =3D
-			!!(query_buf[1] & RMI_F11_HAS_MF_EDGE_MOTION);
-		sensor_query->has_mf_scroll_inertia =3D
-			!!(query_buf[1] & RMI_F11_HAS_MF_SCROLL_INERTIA);
=20
 		sensor_query->query7_nonzero =3D !!(query_buf[0]);
 		sensor_query->query8_nonzero =3D !!(query_buf[1]);
@@ -968,20 +656,6 @@ static int rmi_f11_get_query_parameters(struct rmi=
_device *rmi_dev,
=20
 		sensor_query->has_pen =3D
 			!!(query_buf[0] & RMI_F11_HAS_PEN);
-		sensor_query->has_proximity =3D
-			!!(query_buf[0] & RMI_F11_HAS_PROXIMITY);
-		sensor_query->has_palm_det_sensitivity =3D
-			!!(query_buf[0] & RMI_F11_HAS_PALM_DET_SENSITIVITY);
-		sensor_query->has_suppress_on_palm_detect =3D
-			!!(query_buf[0] & RMI_F11_HAS_SUPPRESS_ON_PALM_DETECT);
-		sensor_query->has_two_pen_thresholds =3D
-			!!(query_buf[0] & RMI_F11_HAS_TWO_PEN_THRESHOLDS);
-		sensor_query->has_contact_geometry =3D
-			!!(query_buf[0] & RMI_F11_HAS_CONTACT_GEOMETRY);
-		sensor_query->has_pen_hover_discrimination =3D
-			!!(query_buf[0] & RMI_F11_HAS_PEN_HOVER_DISCRIMINATION);
-		sensor_query->has_pen_filters =3D
-			!!(query_buf[0] & RMI_F11_HAS_PEN_FILTERS);
=20
 		query_size++;
 	}
@@ -1002,24 +676,6 @@ static int rmi_f11_get_query_parameters(struct rm=
i_device *rmi_dev,
 		if (rc < 0)
 			return rc;
=20
-		sensor_query->has_z_tuning =3D
-			!!(query_buf[0] & RMI_F11_HAS_Z_TUNING);
-		sensor_query->has_algorithm_selection =3D
-			!!(query_buf[0] & RMI_F11_HAS_ALGORITHM_SELECTION);
-		sensor_query->has_w_tuning =3D
-			!!(query_buf[0] & RMI_F11_HAS_W_TUNING);
-		sensor_query->has_pitch_info =3D
-			!!(query_buf[0] & RMI_F11_HAS_PITCH_INFO);
-		sensor_query->has_finger_size =3D
-			!!(query_buf[0] & RMI_F11_HAS_FINGER_SIZE);
-		sensor_query->has_segmentation_aggressiveness =3D
-			!!(query_buf[0] &
-				RMI_F11_HAS_SEGMENTATION_AGGRESSIVENESS);
-		sensor_query->has_XY_clip =3D
-			!!(query_buf[0] & RMI_F11_HAS_XY_CLIP);
-		sensor_query->has_drumming_filter =3D
-			!!(query_buf[0] & RMI_F11_HAS_DRUMMING_FILTER);
-
 		query_size++;
 	}
=20
@@ -1028,22 +684,8 @@ static int rmi_f11_get_query_parameters(struct rm=
i_device *rmi_dev,
 		if (rc < 0)
 			return rc;
=20
-		sensor_query->has_gapless_finger =3D
-			!!(query_buf[0] & RMI_F11_HAS_GAPLESS_FINGER);
-		sensor_query->has_gapless_finger_tuning =3D
-			!!(query_buf[0] & RMI_F11_HAS_GAPLESS_FINGER_TUNING);
-		sensor_query->has_8bit_w =3D
-			!!(query_buf[0] & RMI_F11_HAS_8BIT_W);
-		sensor_query->has_adjustable_mapping =3D
-			!!(query_buf[0] & RMI_F11_HAS_ADJUSTABLE_MAPPING);
 		sensor_query->has_info2 =3D
 			!!(query_buf[0] & RMI_F11_HAS_INFO2);
-		sensor_query->has_physical_props =3D
-			!!(query_buf[0] & RMI_F11_HAS_PHYSICAL_PROPS);
-		sensor_query->has_finger_limit =3D
-			!!(query_buf[0] & RMI_F11_HAS_FINGER_LIMIT);
-		sensor_query->has_linear_coeff_2 =3D
-			!!(query_buf[0] & RMI_F11_HAS_LINEAR_COEFF);
=20
 		query_size++;
 	}
@@ -1053,12 +695,6 @@ static int rmi_f11_get_query_parameters(struct rm=
i_device *rmi_dev,
 		if (rc < 0)
 			return rc;
=20
-		sensor_query->jitter_window_size =3D query_buf[0] &
-			RMI_F11_JITTER_WINDOW_MASK;
-		sensor_query->jitter_filter_type =3D (query_buf[0] &
-			RMI_F11_JITTER_FILTER_MASK) >>
-			RMI_F11_JITTER_FILTER_SHIFT;
-
 		query_size++;
 	}
=20
@@ -1067,18 +703,8 @@ static int rmi_f11_get_query_parameters(struct rm=
i_device *rmi_dev,
 		if (rc < 0)
 			return rc;
=20
-		sensor_query->light_control =3D
-			query_buf[0] & RMI_F11_LIGHT_CONTROL_MASK;
 		sensor_query->is_clear =3D
 			!!(query_buf[0] & RMI_F11_IS_CLEAR);
-		sensor_query->clickpad_props =3D
-			(query_buf[0] & RMI_F11_CLICKPAD_PROPS_MASK) >>
-			RMI_F11_CLICKPAD_PROPS_SHIFT;
-		sensor_query->mouse_buttons =3D
-			(query_buf[0] & RMI_F11_MOUSE_BUTTONS_MASK) >>
-			RMI_F11_MOUSE_BUTTONS_SHIFT;
-		sensor_query->has_advanced_gestures =3D
-			!!(query_buf[0] & RMI_F11_HAS_ADVANCED_GESTURES);
=20
 		query_size++;
 	}
@@ -1276,7 +902,6 @@ static int rmi_f11_initialize(struct rmi_function =
*fn)
 				rc);
 	}
=20
-	mutex_init(&f11->dev_controls_mutex);
 	return 0;
 }
=20
--=20
1.8.1.5

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
