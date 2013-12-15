From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input synaptics-rmi4: Eliminate packed structs in
 rmi_f11.c
Date: Sun, 15 Dec 2013 03:57:04 -0800
Message-ID: <20131215115702.GD14818@core.coreip.homeip.net>
References: <1386729594-5471-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:40418 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753297Ab3LOL5J (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 15 Dec 2013 06:57:09 -0500
Received: by mail-pd0-f180.google.com with SMTP id q10so4234111pdj.11
        for <linux-input@vger.kernel.org>; Sun, 15 Dec 2013 03:57:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1386729594-5471-1-git-send-email-cheiny@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On Tue, Dec 10, 2013 at 06:39:54PM -0800, Christopher Heiny wrote:
> This converts rmi_f11.c from using bitfields in packed structs, converting
> to bitmasks and shifts to parse out bitfields, nibbles, and so on.
> 
> Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Jean Delvare <khali@linux-fr.org>
> Cc: Linus Walleij <linus.walleij@stericsson.com>
> Cc: Joerie de Gram <j.de.gram@gmail.com>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 

Applied, thank you.

> 
> 
> > ---
> > 
> > This patch implements changes to the synaptics-rmi4 branch of
> > Dmitry's input tree.  The base for the patch is commit
> > f154022b208a59b048f52b7b5d58a5ec1949b96e.
> > 
> >  drivers/input/rmi4/rmi_f11.c | 1526 +++++++++++++++---------------------------
> >  1 file changed, 553 insertions(+), 973 deletions(-)
> > 
> > diff --git a/drivers/input/rmi4/rmi_f11.c b/drivers/input/rmi4/rmi_f11.c
> > index d3a9ba8..d63ef31 100644
> > --- a/drivers/input/rmi4/rmi_f11.c
> > +++ b/drivers/input/rmi4/rmi_f11.c
> > @@ -69,33 +69,124 @@
> >   */
> >  
> >  /**
> > - * @rezero - writing 1 to this will cause the sensor to calibrate to the
> > - * current capacitive state.
> > + * @rezero - writing this to the F11 command register will cause the sensor to
> > + * calibrate to the current capacitive state.
> >   */
> > -struct f11_2d_commands {
> > -	u8 rezero:1;
> > -	u8 reserved:7;
> > -} __attribute__((__packed__));
> > +#define RMI_F11_REZERO  0x01
> > +
> > +#define RMI_F11_HAS_QUERY9              (1 << 3)
> > +#define RMI_F11_HAS_QUERY11             (1 << 4)
> > +#define RMI_F11_HAS_QUERY12             (1 << 5)
> > +#define RMI_F11_HAS_QUERY27             (1 << 6)
> > +#define RMI_F11_HAS_QUERY28             (1 << 7)
> > +
> > +/** Defs for Query 1 */
> > +
> > +#define RMI_F11_NR_FINGERS_MASK 0x07
> > +#define RMI_F11_HAS_REL                 (1 << 3)
> > +#define RMI_F11_HAS_ABS                 (1 << 4)
> > +#define RMI_F11_HAS_GESTURES            (1 << 5)
> > +#define RMI_F11_HAS_SENSITIVITY_ADJ     (1 << 6)
> > +#define RMI_F11_CONFIGURABLE            (1 << 7)
> > +
> > +/** Defs for Query 2, 3, and 4. */
> > +#define RMI_F11_NR_ELECTRODES_MASK      0x7F
> > +
> > +/** Defs for Query 5 */
> > +
> > +#define RMI_F11_ABS_DATA_SIZE_MASK      0x03
> > +#define RMI_F11_HAS_ANCHORED_FINGER     (1 << 2)
> > +#define RMI_F11_HAS_ADJ_HYST            (1 << 3)
> > +#define RMI_F11_HAS_DRIBBLE             (1 << 4)
> > +#define RMI_F11_HAS_BENDING_CORRECTION  (1 << 5)
> > +#define RMI_F11_HAS_LARGE_OBJECT_SUPPRESSION    (1 << 6)
> > +#define RMI_F11_HAS_JITTER_FILTER       (1 << 7)
> > +
> > +/** Defs for Query 7 */
> > +#define RMI_F11_HAS_SINGLE_TAP                  (1 << 0)
> > +#define RMI_F11_HAS_TAP_AND_HOLD                (1 << 1)
> > +#define RMI_F11_HAS_DOUBLE_TAP                  (1 << 2)
> > +#define RMI_F11_HAS_EARLY_TAP                   (1 << 3)
> > +#define RMI_F11_HAS_FLICK                       (1 << 4)
> > +#define RMI_F11_HAS_PRESS                       (1 << 5)
> > +#define RMI_F11_HAS_PINCH                       (1 << 6)
> > +#define RMI_F11_HAS_CHIRAL                      (1 << 7)
> > +
> > +/** Defs for Query 8 */
> > +#define RMI_F11_HAS_PALM_DET                    (1 << 0)
> > +#define RMI_F11_HAS_ROTATE                      (1 << 1)
> > +#define RMI_F11_HAS_TOUCH_SHAPES                (1 << 2)
> > +#define RMI_F11_HAS_SCROLL_ZONES                (1 << 3)
> > +#define RMI_F11_HAS_INDIVIDUAL_SCROLL_ZONES     (1 << 4)
> > +#define RMI_F11_HAS_MF_SCROLL                   (1 << 5)
> > +#define RMI_F11_HAS_MF_EDGE_MOTION              (1 << 6)
> > +#define RMI_F11_HAS_MF_SCROLL_INERTIA           (1 << 7)
> > +
> > +/** Defs for Query 9. */
> > +#define RMI_F11_HAS_PEN                         (1 << 0)
> > +#define RMI_F11_HAS_PROXIMITY                   (1 << 1)
> > +#define RMI_F11_HAS_PALM_DET_SENSITIVITY        (1 << 2)
> > +#define RMI_F11_HAS_SUPPRESS_ON_PALM_DETECT     (1 << 3)
> > +#define RMI_F11_HAS_TWO_PEN_THRESHOLDS          (1 << 4)
> > +#define RMI_F11_HAS_CONTACT_GEOMETRY            (1 << 5)
> > +#define RMI_F11_HAS_PEN_HOVER_DISCRIMINATION    (1 << 6)
> > +#define RMI_F11_HAS_PEN_FILTERS                 (1 << 7)
> > +
> > +/** Defs for Query 10. */
> > +#define RMI_F11_NR_TOUCH_SHAPES_MASK            0x1F
> > +
> > +/** Defs for Query 11 */
> > +
> > +#define RMI_F11_HAS_Z_TUNING                    (1 << 0)
> > +#define RMI_F11_HAS_ALGORITHM_SELECTION         (1 << 1)
> > +#define RMI_F11_HAS_W_TUNING                    (1 << 2)
> > +#define RMI_F11_HAS_PITCH_INFO                  (1 << 3)
> > +#define RMI_F11_HAS_FINGER_SIZE                 (1 << 4)
> > +#define RMI_F11_HAS_SEGMENTATION_AGGRESSIVENESS (1 << 5)
> > +#define RMI_F11_HAS_XY_CLIP                     (1 << 6)
> > +#define RMI_F11_HAS_DRUMMING_FILTER             (1 << 7)
> > +
> > +/** Defs for Query 12. */
> > +
> > +#define RMI_F11_HAS_GAPLESS_FINGER              (1 << 0)
> > +#define RMI_F11_HAS_GAPLESS_FINGER_TUNING       (1 << 1)
> > +#define RMI_F11_HAS_8BIT_W                      (1 << 2)
> > +#define RMI_F11_HAS_ADJUSTABLE_MAPPING          (1 << 3)
> > +#define RMI_F11_HAS_INFO2                       (1 << 4)
> > +#define RMI_F11_HAS_PHYSICAL_PROPS              (1 << 5)
> > +#define RMI_F11_HAS_FINGER_LIMIT                (1 << 6)
> > +#define RMI_F11_HAS_LINEAR_COEFF                (1 << 7)
> > +
> > +/** Defs for Query 13. */
> > +
> > +#define RMI_F11_JITTER_WINDOW_MASK              0x1F
> > +#define RMI_F11_JITTER_FILTER_MASK              0x60
> > +#define RMI_F11_JITTER_FILTER_SHIFT             5
> > +
> > +/** Defs for Query 14. */
> > +#define RMI_F11_LIGHT_CONTROL_MASK              0x03
> > +#define RMI_F11_IS_CLEAR                        (1 << 2)
> > +#define RMI_F11_CLICKPAD_PROPS_MASK             0x18
> > +#define RMI_F11_CLICKPAD_PROPS_SHIFT            3
> > +#define RMI_F11_MOUSE_BUTTONS_MASK              0x60
> > +#define RMI_F11_MOUSE_BUTTONS_SHIFT             5
> > +#define RMI_F11_HAS_ADVANCED_GESTURES           (1 << 7)
> > +
> > +#define RMI_F11_QUERY_SIZE                      4
> > +#define RMI_F11_QUERY_GESTURE_SIZE              2
> >  
> > -/** This query is always present, and is on a per device basis.  All other
> > - * queries are on a per-sensor basis.
> > +#define F11_LIGHT_CTL_NONE 0x00
> > +#define F11_LUXPAD	   0x01
> > +#define F11_DUAL_MODE      0x02
> > +
> > +#define F11_NOT_CLICKPAD     0x00
> > +#define F11_HINGED_CLICKPAD  0x01
> > +#define F11_UNIFORM_CLICKPAD 0x02
> > +
> > +/**
> > + * Query registers 1 through 4 are always present.
> >   *
> > - * @nbr_of_sensors - the number of 2D sensors on the touch device.
> > - * @has_query9 - indicates the F11_2D_Query9 register exists.
> > - * @has_query11 - indicates the F11_2D_Query11 register exists.
> > - * @has_query12 - indicates the F11_2D_Query12 register exists.
> > - */
> > -struct f11_2d_device_query {
> > -	u8 nbr_of_sensors:3;
> > -	u8 has_query9:1;
> > -	u8 has_query11:1;
> > -	u8 has_query12:1;
> > -	u8 has_query27:1;
> > -	u8 has_query28:1;
> > -} __attribute__((__packed__));
> > -
> > -/** Query registers 1 through 4 are always present.
> > - * @number_of_fingers - describes the maximum number of fingers the 2-D sensor
> > + * @nr_fingers - describes the maximum number of fingers the 2-D sensor
> >   * supports.
> >   * @has_rel - the sensor supports relative motion reporting.
> >   * @has_abs - the sensor supports absolute poition reporting.
> > @@ -109,27 +200,8 @@ struct f11_2d_device_query {
> >   * supports on the Y axis.
> >   * @max_electrodes - the total number of X and Y electrodes that may be
> >   * configured.
> > - */
> > -struct f11_2d_sensor_info {
> > -	/* query1 */
> > -	u8 number_of_fingers:3;
> > -	u8 has_rel:1;
> > -	u8 has_abs:1;
> > -	u8 has_gestures:1;
> > -	u8 has_sensitivity_adjust:1;
> > -	u8 configurable:1;
> > -	/* query2 */
> > -	u8 num_of_x_electrodes:7;
> > -	u8 reserved_1:1;
> > -	/* query3 */
> > -	u8 num_of_y_electrodes:7;
> > -	u8 reserved_2:1;
> > -	/* query4 */
> > -	u8 max_electrodes:7;
> > -	u8 reserved_3:1;
> > -} __attribute__((__packed__));
> > -
> > -/** Query 5 - this is present if the has_abs bit is set.
> > + *
> > + * Query 5 is present if the has_abs bit is set.
> >   *
> >   * @abs_data_size - describes the format of data reported by the absolute
> >   * data source.  Only one format (the kind used here) is supported at this
> > @@ -146,18 +218,8 @@ struct f11_2d_sensor_info {
> >   * @has_large_object_suppression - control register 58 and data register 28
> >   * exist.
> >   * @has_jitter_filter - query 13 and control 73..76 exist.
> > - */
> > -struct f11_2d_abs_info {
> > -	u8 abs_data_size:2;
> > -	u8 has_anchored_finger:1;
> > -	u8 has_adj_hyst:1;
> > -	u8 has_dribble:1;
> > -	u8 has_bending_correction:1;
> > -	u8 has_large_object_suppression:1;
> > -	u8 has_jitter_filter:1;
> > -} __attribute__((__packed__));
> > -
> > -/** Gesture information queries 7 and 8 are present if has_gestures bit is set.
> > + *
> > + * Gesture information queries 7 and 8 are present if has_gestures bit is set.
> >   *
> >   * @has_single_tap - a basic single-tap gesture is supported.
> >   * @has_tap_n_hold - tap-and-hold gesture is supported.
> > @@ -176,38 +238,17 @@ struct f11_2d_abs_info {
> >   * @has_scroll_zones - scrolling areas near the sensor edges are supported.
> >   * @has_individual_scroll_zones - if 1, then 4 scroll zones are supported;
> >   * if 0, then only two are supported.
> > - * @has_multi_finger_scroll - the multifinger_scrolling bit will be set when
> > + * @has_mf_scroll - the multifinger_scrolling bit will be set when
> >   * more than one finger is involved in a scrolling action.
> > - */
> > -struct f11_2d_gesture_info {
> > -	u8 has_single_tap:1;
> > -	u8 has_tap_n_hold:1;
> > -	u8 has_double_tap:1;
> > -	u8 has_early_tap:1;
> > -	u8 has_flick:1;
> > -	u8 has_press:1;
> > -	u8 has_pinch:1;
> > -	u8 has_chiral:1;
> > -
> > -	u8 has_palm_det:1;
> > -	u8 has_rotate:1;
> > -	u8 has_touch_shapes:1;
> > -	u8 has_scroll_zones:1;
> > -	u8 has_individual_scroll_zones:1;
> > -	u8 has_multi_finger_scroll:1;
> > -	u8 has_mf_edge_motion:1;
> > -	u8 has_mf_scroll_inertia:1;
> > -} __attribute__((__packed__));
> > -
> > -/** Utility for checking bytes in the gesture info registers.  This is done
> > - * often enough that we put it here to declutter the conditionals.
> > - */
> > -static bool has_gesture_bits(const struct f11_2d_gesture_info *info,
> > -			     const u8 byte) {
> > -	return ((u8 *) info)[byte] != 0;
> > -}
> > -
> > -/**
> > + *
> > + * Convenience for checking bytes in the gesture info registers.  This is done
> > + * often enough that we put it here to declutter the conditionals
> > + *
> > + * @query7_nonzero - true if none of the query 7 bits are set
> > + * @query8_nonzero - true if none of the query 8 bits are set
> > + *
> > + * Query 9 is present if the has_query9 is set.
> > + *
> >   * @has_pen - detection of a stylus is supported and registers F11_2D_Ctrl20
> >   * and F11_2D_Ctrl21 exist.
> >   * @has_proximity - detection of fingers near the sensor is supported and
> > @@ -216,30 +257,14 @@ static bool has_gesture_bits(const struct f11_2d_gesture_info *info,
> >   * feature and register F11_2D_Ctrl27 exists.
> >   * @has_two_pen_thresholds - is has_pen is also set, then F11_2D_Ctrl35 exists.
> >   * @has_contact_geometry - the sensor supports the use of contact geometry to
> > - * map absolute X and Y target positions and registers F11_2D_Data18.* through
> > - * F11_2D_Data27 exist.
> > - */
> > -struct f11_2d_query9 {
> > -	u8 has_pen:1;
> > -	u8 has_proximity:1;
> > -	u8 has_palm_det_sensitivity:1;
> > -	u8 has_suppress_on_palm_detect:1;
> > -	u8 has_two_pen_thresholds:1;
> > -	u8 has_contact_geometry:1;
> > -	u8 has_pen_hover_discrimination:1;
> > -	u8 has_pen_filters:1;
> > -} __attribute__((__packed__));
> > -
> > -/** Touch shape info (query 10) is present if has_touch_shapes is set.
> > + * map absolute X and Y target positions and registers F11_2D_Data18
> > + * through F11_2D_Data27 exist.
> >   *
> > - * @nbr_touch_shapes - the total number of touch shapes supported.
> > - */
> > -struct f11_2d_ts_info {
> > -	u8 nbr_touch_shapes:5;
> > -	u8 reserved:3;
> > -} __attribute__((__packed__));
> > -
> > -/** Query 11 is present if the has_query11 bit is set in query 0.
> > + * Touch shape info (query 10) is present if has_touch_shapes is set.
> > + *
> > + * @nr_touch_shapes - the total number of touch shapes supported.
> > + *
> > + * Query 11 is present if the has_query11 bit is set in query 0.
> >   *
> >   * @has_z_tuning - if set, the sensor supports Z tuning and registers
> >   * F11_2D_Ctrl29 through F11_2D_Ctrl33 exist.
> > @@ -259,19 +284,9 @@ struct f11_2d_ts_info {
> >   * @has_drumming_filter - the sensor can be configured to distinguish
> >   * between a fast flick and a quick drumming movement and registers
> >   * F11_2D_Ctrl50 and F11_2D_Ctrl51 exist.
> > - */
> > -struct f11_2d_query11 {
> > -	u8 has_z_tuning:1;
> > -	u8 has_algorithm_selection:1;
> > -	u8 has_w_tuning:1;
> > -	u8 has_pitch_info:1;
> > -	u8 has_finger_size:1;
> > -	u8 has_segmentation_aggressiveness:1;
> > -	u8 has_XY_clip:1;
> > -	u8 has_drumming_filter:1;
> > -} __attribute__((__packed__));
> > -
> > -/**
> > + *
> > + * Query 12 is present if hasQuery12 bit is set.
> > + *
> >   * @has_gapless_finger - control registers relating to gapless finger are
> >   * present.
> >   * @has_gapless_finger_tuning - additional control and data registers relating
> > @@ -283,29 +298,12 @@ struct f11_2d_query11 {
> >   * of the sensor are present.
> >   * @has_finger_limit - indicates that F11 Ctrl 80 exists.
> >   * @has_linear_coeff - indicates that F11 Ctrl 81 exists.
> > - */
> > -struct f11_2d_query12 {
> > -	u8 has_gapless_finger:1;
> > -	u8 has_gapless_finger_tuning:1;
> > -	u8 has_8bit_w:1;
> > -	u8 has_adjustable_mapping:1;
> > -	u8 has_info2:1;
> > -	u8 has_physical_props:1;
> > -	u8 has_finger_limit:1;
> > -	u8 has_linear_coeff_2:1;
> > -} __attribute__((__packed__));
> > -
> > -/** This register is present if Query 5's has_jitter_filter bit is set.
> > + *
> > + * Query 13 is present if Query 5's has_jitter_filter bit is set.
> >   * @jitter_window_size - used by Design Studio 4.
> >   * @jitter_filter_type - used by Design Studio 4.
> > - */
> > -struct f11_2d_query13 {
> > -	u8 jtter_window_size:5;
> > -	u8 jitter_filter_type:2;
> > -	u8 reserved:1;
> > -} __attribute__((__packed__));
> > -
> > -/** This register is present if query 12's has_general_info2 flag is set.
> > + *
> > + * Query 14 is present if query 12's has_general_info2 flag is set.
> >   *
> >   * @light_control - Indicates what light/led control features are present, if
> >   * any.
> > @@ -316,422 +314,174 @@ struct f11_2d_query13 {
> >   * @mouse_buttons - specifies the number of mouse buttons present (if any).
> >   * @has_advanced_gestures - advanced driver gestures are supported.
> >   */
> > -struct f11_2d_query14 {
> > -	u8 light_control:2;
> > -	u8 is_clear:1;
> > -	u8 clickpad_props:2;
> > -	u8 mouse_buttons:2;
> > -	u8 has_advanced_gestures:1;
> > -} __attribute__((__packed__));
> > -
> > -#define F11_LIGHT_CTL_NONE 0x00
> > -#define F11_LUXPAD	   0x01
> > -#define F11_DUAL_MODE      0x02
> > -
> > -#define F11_NOT_CLICKPAD     0x00
> > -#define F11_HINGED_CLICKPAD  0x01
> > -#define F11_UNIFORM_CLICKPAD 0x02
> > -
> > -/** See notes above for information about specific query register sets.
> > - */
> >  struct f11_2d_sensor_queries {
> > -	struct f11_2d_sensor_info info;
> > -	struct f11_2d_abs_info abs_info;
> > -	u8 f11_2d_query6;
> > -	struct f11_2d_gesture_info gesture_info;
> > -	struct f11_2d_query9 query9;
> > -	struct f11_2d_ts_info ts_info;
> > -	struct f11_2d_query11 features_1;
> > -	struct f11_2d_query12 features_2;
> > -	struct f11_2d_query13 jitter_filter;
> > -	struct f11_2d_query14 info_2;
> > -};
> > -
> > -/**
> > - * @reporting_mode - controls how often finger position data is reported.
> > - * @abs_pos_filt - when set, enables various noise and jitter filtering
> > - * algorithms for absolute reports.
> > - * @rel_pos_filt - when set, enables various noise and jitter filtering
> > - * algorithms for relative reports.
> > - * @rel_ballistics - enables ballistics processing for the relative finger
> > - * motion on the 2-D sensor.
> > - * @dribble - enables the dribbling feature.
> > - * @report_beyond_clip - when this is set, fingers outside the active area
> > - * specified by the x_clip and y_clip registers will be reported, but with
> > - * reported finger position clipped to the edge of the active area.
> > - * @palm_detect_thresh - the threshold at which a wide finger is considered a
> > - * palm. A value of 0 inhibits palm detection.
> > - * @motion_sensitivity - specifies the threshold an anchored finger must move
> > - * before it is considered no longer anchored.  High values mean more
> > - * sensitivity.
> > - * @man_track_en - for anchored finger tracking, whether the host (1) or the
> > - * device (0) determines which finger is the tracked finger.
> > - * @man_tracked_finger - when man_track_en is 1, specifies whether finger 0 or
> > - * finger 1 is the tracked finger.
> > - * @delta_x_threshold - 2-D position update interrupts are inhibited unless
> > - * the finger moves more than a certain threshold distance along the X axis.
> > - * @delta_y_threshold - 2-D position update interrupts are inhibited unless
> > - * the finger moves more than a certain threshold distance along the Y axis.
> > - * @velocity - When rel_ballistics is set, this register defines the
> > - * velocity ballistic parameter applied to all relative motion events.
> > - * @acceleration - When rel_ballistics is set, this register defines the
> > - * acceleration ballistic parameter applied to all relative motion events.
> > - * @sensor_max_x_pos - the maximum X coordinate reported by the sensor.
> > - * @sensor_max_y_pos - the maximum Y coordinate reported by the sensor.
> > - */
> > -struct f11_2d_ctrl0_9 {
> > -	/* F11_2D_Ctrl0 */
> > -	u8 reporting_mode:3;
> > -	u8 abs_pos_filt:1;
> > -	u8 rel_pos_filt:1;
> > -	u8 rel_ballistics:1;
> > -	u8 dribble:1;
> > -	u8 report_beyond_clip:1;
> > -	/* F11_2D_Ctrl1 */
> > -	u8 palm_detect_thres:4;
> > -	u8 motion_sensitivity:2;
> > -	u8 man_track_en:1;
> > -	u8 man_tracked_finger:1;
> > -	/* F11_2D_Ctrl2 and 3 */
> > -	u8 delta_x_threshold:8;
> > -	u8 delta_y_threshold:8;
> > -	/* F11_2D_Ctrl4 and 5 */
> > -	u8 velocity:8;
> > -	u8 acceleration:8;
> > -	/* F11_2D_Ctrl6 thru 9 */
> > -	u16 sensor_max_x_pos:12;
> > -	u8 ctrl7_reserved:4;
> > -	u16 sensor_max_y_pos:12;
> > -	u8 ctrl9_reserved:4;
> > -} __attribute__((__packed__));
> > -
> > -/**
> > - * @single_tap_int_enable - enable tap gesture recognition.
> > - * @tap_n_hold_int_enable - enable tap-and-hold gesture recognition.
> > - * @double_tap_int_enable - enable double-tap gesture recognition.
> > - * @early_tap_int_enable - enable early tap notification.
> > - * @flick_int_enable - enable flick detection.
> > - * @press_int_enable - enable press gesture recognition.
> > - * @pinch_int_enable - enable pinch detection.
> > - */
> > -struct f11_2d_ctrl10 {
> > -	u8 single_tap_int_enable:1;
> > -	u8 tap_n_hold_int_enable:1;
> > -	u8 double_tap_int_enable:1;
> > -	u8 early_tap_int_enable:1;
> > -	u8 flick_int_enable:1;
> > -	u8 press_int_enable:1;
> > -	u8 pinch_int_enable:1;
> > -	u8 reserved:1;
> > -} __attribute__((__packed__));
> > -
> > -/**
> > - * @palm_detect_int_enable - enable palm detection feature.
> > - * @rotate_int_enable - enable rotate gesture detection.
> > - * @touch_shape_int_enable - enable the TouchShape feature.
> > - * @scroll_zone_int_enable - enable scroll zone reporting.
> > - * @multi_finger_scroll_int_enable - enable the multfinger scroll feature.
> > - */
> > -struct f11_2d_ctrl11 {
> > -	u8 palm_detect_int_enable:1;
> > -	u8 rotate_int_enable:1;
> > -	u8 touch_shape_int_enable:1;
> > -	u8 scroll_zone_int_enable:1;
> > -	u8 multi_finger_scroll_int_enable:1;
> > -	u8 reserved:3;
> > -} __attribute__((__packed__));
> > -
> > -/**
> > - * @sens_adjustment - allows a host to alter the overall sensitivity of a
> > - * 2-D sensor. A positive value in this register will make the sensor more
> > - * sensitive than the factory defaults, and a negative value will make it
> > - * less sensitive.
> > - * @hyst_adjustment - increase the touch/no-touch hysteresis by 2 Z-units for
> > - * each one unit increment in this setting.
> > - */
> > -struct f11_2d_ctrl14 {
> > -	s8 sens_adjustment:5;
> > -	u8 hyst_adjustment:3;
> > -} __attribute__((__packed__));
> > -
> > -/**
> > - * @max_tap_time - the maximum duration of a tap, in 10-millisecond units.
> > - */
> > -struct f11_2d_ctrl15 {
> > -	u8 max_tap_time:8;
> > -} __attribute__((__packed__));
> > -
> > -/**
> > - * @min_press_time - The minimum duration required for stationary finger(s) to
> > - * generate a press gesture, in 10-millisecond units.
> > - */
> > -struct f11_2d_ctrl16 {
> > -	u8 min_press_time:8;
> > -} __attribute__((__packed__));
> > +	/* query1 */
> > +	u8 nr_fingers;
> > +	bool has_rel;
> > +	bool has_abs;
> > +	bool has_gestures;
> > +	bool has_sensitivity_adjust;
> > +	bool configurable;
> >  
> > -/**
> > - * @max_tap_distance - Determines the maximum finger movement allowed during
> > - * a tap, in 0.1-millimeter units.
> > - */
> > -struct f11_2d_ctrl17 {
> > -	u8 max_tap_distance:8;
> > -} __attribute__((__packed__));
> > +	/* query2 */
> > +	u8 nr_x_electrodes;
> >  
> > -/**
> > - * @min_flick_distance - the minimum finger movement for a flick gesture,
> > - * in 1-millimeter units.
> > - * @min_flick_speed - the minimum finger speed for a flick gesture, in
> > - * 10-millimeter/second units.
> > - */
> > -struct f11_2d_ctrl18_19 {
> > -	u8 min_flick_distance:8;
> > -	u8 min_flick_speed:8;
> > -} __attribute__((__packed__));
> > +	/* query3 */
> > +	u8 nr_y_electrodes;
> >  
> > -/**
> > - * @pen_detect_enable - enable reporting of stylus activity.
> > - * @pen_jitter_filter_enable - Setting this enables the stylus anti-jitter
> > - * filter.
> > - * @pen_z_threshold - This is the stylus-detection lower threshold. Smaller
> > - * values result in higher sensitivity.
> > - */
> > -struct f11_2d_ctrl20_21 {
> > -	u8 pen_detect_enable:1;
> > -	u8 pen_jitter_filter_enable:1;
> > -	u8 ctrl20_reserved:6;
> > -	u8 pen_z_threshold:8;
> > -} __attribute__((__packed__));
> > +	/* query4 */
> > +	u8 max_electrodes;
> >  
> > -/**
> > - * These are not accessible through sysfs yet.
> > - *
> > - * @proximity_detect_int_en - enable proximity detection feature.
> > - * @proximity_jitter_filter_en - enables an anti-jitter filter on proximity
> > - * data.
> > - * @proximity_detection_z_threshold - the threshold for finger-proximity
> > - * detection.
> > - * @proximity_delta_x_threshold - In reduced-reporting modes, this is the
> > - * threshold for proximate-finger movement in the direction parallel to the
> > - * X-axis.
> > - * @proximity_delta_y_threshold - In reduced-reporting modes, this is the
> > - * threshold for proximate-finger movement in the direction parallel to the
> > - * Y-axis.
> > - * * @proximity_delta_Z_threshold - In reduced-reporting modes, this is the
> > - * threshold for proximate-finger movement in the direction parallel to the
> > - * Z-axis.
> > - */
> > -struct f11_2d_ctrl22_26 {
> > -	/* control 22 */
> > -	u8 proximity_detect_int_en:1;
> > -	u8 proximity_jitter_filter_en:1;
> > -	u8 f11_2d_ctrl6_b3__7:6;
> > +	/* query5 */
> > +	u8 abs_data_size;
> > +	bool has_anchored_finger;
> > +	bool has_adj_hyst;
> > +	bool has_dribble;
> > +	bool has_bending_correction;
> > +	bool has_large_object_suppression;
> > +	bool has_jitter_filter;
> >  
> > -	/* control 23 */
> > -	u8 proximity_detection_z_threshold;
> > +	u8 f11_2d_query6;
> >  
> > -	/* control 24 */
> > -	u8 proximity_delta_x_threshold;
> > +	/* query 7 */
> > +	bool has_single_tap;
> > +	bool has_tap_n_hold;
> > +	bool has_double_tap;
> > +	bool has_early_tap;
> > +	bool has_flick;
> > +	bool has_press;
> > +	bool has_pinch;
> > +	bool has_chiral;
> > +
> > +	bool query7_nonzero;
> > +
> > +	/* query 8 */
> > +	bool has_palm_det;
> > +	bool has_rotate;
> > +	bool has_touch_shapes;
> > +	bool has_scroll_zones;
> > +	bool has_individual_scroll_zones;
> > +	bool has_mf_scroll;
> > +	bool has_mf_edge_motion;
> > +	bool has_mf_scroll_inertia;
> > +
> > +	bool query8_nonzero;
> > +
> > +	/* Query 9 */
> > +	bool has_pen;
> > +	bool has_proximity;
> > +	bool has_palm_det_sensitivity;
> > +	bool has_suppress_on_palm_detect;
> > +	bool has_two_pen_thresholds;
> > +	bool has_contact_geometry;
> > +	bool has_pen_hover_discrimination;
> > +	bool has_pen_filters;
> > +
> > +	/* Query 10 */
> > +	u8 nr_touch_shapes;
> > +
> > +	/* Query 11. */
> > +	bool has_z_tuning;
> > +	bool has_algorithm_selection;
> > +	bool has_w_tuning;
> > +	bool has_pitch_info;
> > +	bool has_finger_size;
> > +	bool has_segmentation_aggressiveness;
> > +	bool has_XY_clip;
> > +	bool has_drumming_filter;
> > +
> > +	/* Query 12 */
> > +	bool has_gapless_finger;
> > +	bool has_gapless_finger_tuning;
> > +	bool has_8bit_w;
> > +	bool has_adjustable_mapping;
> > +	bool has_info2;
> > +	bool has_physical_props;
> > +	bool has_finger_limit;
> > +	bool has_linear_coeff_2;
> > +
> > +	/* Query 13 */
> > +	u8 jitter_window_size;
> > +	u8 jitter_filter_type;
> > +
> > +	/* Query 14 */
> > +	u8 light_control;
> > +	bool is_clear;
> > +	u8 clickpad_props;
> > +	u8 mouse_buttons;
> > +	bool has_advanced_gestures;
> > +};
> >  
> > -	/* control 25 */
> > -	u8 proximity_delta_y_threshold;
> > +/* Defs for Ctrl0. */
> > +#define RMI_F11_REPORT_MODE_MASK        0x07
> > +#define RMI_F11_ABS_POS_FILT            (1 << 3)
> > +#define RMI_F11_REL_POS_FILT            (1 << 4)
> > +#define RMI_F11_REL_BALLISTICS          (1 << 5)
> > +#define RMI_F11_DRIBBLE                 (1 << 6)
> > +#define RMI_F11_REPORT_BEYOND_CLIP      (1 << 7)
> >  
> > -	/* control 26 */
> > -	u8 proximity_delta_z_threshold;
> > -} __attribute__((__packed__));
> > +/* Defs for Ctrl1. */
> > +#define RMI_F11_PALM_DETECT_THRESH_MASK 0x0F
> > +#define RMI_F11_MOTION_SENSITIVITY_MASK 0x30
> > +#define RMI_F11_MANUAL_TRACKING         (1 << 6)
> > +#define RMI_F11_MANUAL_TRACKED_FINGER   (1 << 7)
> >  
> > -/**
> > - * @palm_detecy_sensitivity - When this value is small, smaller objects will
> > - * be identified as palms; when this value is large, only larger objects will
> > - * be identified as palms. 0 represents the factory default.
> > - * @suppress_on_palm_detect - when set, all F11 interrupts except palm_detect
> > - * are suppressed while a palm is detected.
> > - */
> > -struct f11_2d_ctrl27 {
> > -	s8 palm_detect_sensitivity:4;
> > -	u8 suppress_on_palm_detect:1;
> > -	u8 f11_2d_ctrl27_b5__7:3;
> > -} __attribute__((__packed__));
> > -
> > -/**
> > - * @multi_finger_scroll_mode - allows choice of multi-finger scroll mode and
> > - * determines whether and how X or Y displacements are reported.
> > - * @edge_motion_en - enables the edge_motion feature.
> > - * @multi_finger_scroll_momentum - controls the length of time that scrolling
> > - * continues after fingers have been lifted.
> > - */
> > -struct f11_2d_ctrl28 {
> > -	u8 multi_finger_scroll_mode:2;
> > -	u8 edge_motion_en:1;
> > -	u8 f11_2d_ctrl28b_3:1;
> > -	u8 multi_finger_scroll_momentum:4;
> > -} __attribute__((__packed__));
> > -
> > -/**
> > - * @z_touch_threshold - Specifies the finger-arrival Z threshold. Large values
> > - * may cause smaller fingers to be rejected.
> > - * @z_touch_hysteresis - Specifies the difference between the finger-arrival
> > - * Z threshold and the finger-departure Z threshold.
> > - */
> > -struct f11_2d_ctrl29_30 {
> > -	u8 z_touch_threshold;
> > -	u8 z_touch_hysteresis;
> > -} __attribute__((__packed__));
> > +#define RMI_F11_DELTA_X_THRESHOLD       2
> > +#define RMI_F11_DELTA_Y_THRESHOLD       3
> >  
> > +#define RMI_F11_CTRL_REG_COUNT          10
> >  
> >  struct f11_2d_ctrl {
> > -	struct f11_2d_ctrl0_9		 *ctrl0_9;
> > -	u16				ctrl0_9_address;
> > -	struct f11_2d_ctrl10		*ctrl10;
> > -	struct f11_2d_ctrl11		*ctrl11;
> > -	u8				ctrl12_size;
> > -	struct f11_2d_ctrl14		*ctrl14;
> > -	struct f11_2d_ctrl15		*ctrl15;
> > -	struct f11_2d_ctrl16		*ctrl16;
> > -	struct f11_2d_ctrl17		*ctrl17;
> > -	struct f11_2d_ctrl18_19		*ctrl18_19;
> > -	struct f11_2d_ctrl20_21		*ctrl20_21;
> > -	struct f11_2d_ctrl22_26		*ctrl22_26;
> > -	struct f11_2d_ctrl27		*ctrl27;
> > -	struct f11_2d_ctrl28		*ctrl28;
> > -	struct f11_2d_ctrl29_30		*ctrl29_30;
> > +	u8              ctrl0_9[RMI_F11_CTRL_REG_COUNT];
> > +	u16             ctrl0_9_address;
> >  };
> >  
> > -/**
> > - * @x_msb - top 8 bits of X finger position.
> > - * @y_msb - top 8 bits of Y finger position.
> > - * @x_lsb - bottom 4 bits of X finger position.
> > - * @y_lsb - bottom 4 bits of Y finger position.
> > - * @w_y - contact patch width along Y axis.
> > - * @w_x - contact patch width along X axis.
> > - * @z - finger Z value (proxy for pressure).
> > - */
> > -struct f11_2d_data_1_5 {
> > -	u8 x_msb;
> > -	u8 y_msb;
> > -	u8 x_lsb:4;
> > -	u8 y_lsb:4;
> > -	u8 w_y:4;
> > -	u8 w_x:4;
> > -	u8 z;
> > -} __attribute__((__packed__));
> > -
> > -/**
> > - * @delta_x - relative motion along X axis.
> > - * @delta_y - relative motion along Y axis.
> > - */
> > -struct f11_2d_data_6_7 {
> > -	s8 delta_x;
> > -	s8 delta_y;
> > -} __attribute__((__packed__));
> > -
> > -/**
> > - * @single_tap - a single tap was recognized.
> > - * @tap_and_hold - a tap-and-hold gesture was recognized.
> > - * @double_tap - a double tap gesture was recognized.
> > - * @early_tap - a tap gesture might be happening.
> > - * @flick - a flick gesture was detected.
> > - * @press - a press gesture was recognized.
> > - * @pinch - a pinch gesture was detected.
> > - */
> > -struct f11_2d_data_8 {
> > -	bool single_tap:1;
> > -	bool tap_and_hold:1;
> > -	bool double_tap:1;
> > -	bool early_tap:1;
> > -	bool flick:1;
> > -	bool press:1;
> > -	bool pinch:1;
> > -} __attribute__((__packed__));
> > -
> > -/**
> > - * @palm_detect - a palm or other large object is in contact with the sensor.
> > - * @rotate - a rotate gesture was detected.
> > - * @shape - a TouchShape has been activated.
> > - * @scrollzone - scrolling data is available.
> > - * @finger_count - number of fingers involved in the reported gesture.
> > - */
> > -struct f11_2d_data_9 {
> > -	bool palm_detect:1;
> > -	bool rotate:1;
> > -	bool shape:1;
> > -	bool scrollzone:1;
> > -	u8 finger_count:3;
> > -} __attribute__((__packed__));
> > -
> > -/**
> > - * @pinch_motion - when a pinch gesture is detected, this is the change in
> > - * distance between the two fingers since this register was last read.
> > - */
> > -struct f11_2d_data_10 {
> > -	s8 pinch_motion;
> > -} __attribute__((__packed__));
> > +#define RMI_F11_ABS_BYTES 5
> > +#define RMI_F11_REL_BYTES 2
> >  
> > -/**
> > - * @x_flick_dist - when a flick gesture is detected,  the distance of flick
> > - * gesture in X direction.
> > - * @y_flick_dist - when a flick gesture is detected,  the distance of flick
> > - * gesture in Y direction.
> > - * @flick_time - the total time of the flick gesture, in 10ms units.
> > - */
> > -struct f11_2d_data_10_12 {
> > -	s8 x_flick_dist;
> > -	s8 y_flick_dist;
> > -	u8 flick_time;
> > -} __attribute__((__packed__));
> > +/* Defs for Data 8 */
> >  
> > -/**
> > - * @motion - when a rotate gesture is detected, the accumulated distance
> > - * of the rotate motion. Clockwise motion is positive and counterclockwise
> > - * motion is negative.
> > - * @finger_separation - when a rotate gesture is detected, the distance
> > - * between the fingers.
> > - */
> > -struct f11_2d_data_11_12 {
> > -	s8 motion;
> > -	u8 finger_separation;
> > -} __attribute__((__packed__));
> > +#define RMI_F11_SINGLE_TAP              (1 << 0)
> > +#define RMI_F11_TAP_AND_HOLD            (1 << 1)
> > +#define RMI_F11_DOUBLE_TAP              (1 << 2)
> > +#define RMI_F11_EARLY_TAP               (1 << 3)
> > +#define RMI_F11_FLICK                   (1 << 4)
> > +#define RMI_F11_PRESS                   (1 << 5)
> > +#define RMI_F11_PINCH                   (1 << 6)
> >  
> > -/**
> > - * @shape_n - a bitmask of the currently activate TouchShapes (if any).
> > - */
> > -struct f11_2d_data_13 {
> > -	u8 shape_n;
> > -} __attribute__((__packed__));
> > +/* Defs for Data 9 */
> >  
> > -/**
> > - * @horizontal - chiral scrolling distance in the X direction.
> > - * @vertical - chiral scrolling distance in the Y direction.
> > - */
> > -struct f11_2d_data_14_15 {
> > -	s8 horizontal;
> > -	s8 vertical;
> > -} __attribute__((__packed__));
> > +#define RMI_F11_PALM_DETECT                     (1 << 0)
> > +#define RMI_F11_ROTATE                          (1 << 1)
> > +#define RMI_F11_SHAPE                           (1 << 2)
> > +#define RMI_F11_SCROLLZONE                      (1 << 3)
> > +#define RMI_F11_GESTURE_FINGER_COUNT_MASK       0x70
> >  
> > -/**
> > - * @x_low - scroll zone motion along the lower edge of the sensor.
> > - * @y_right - scroll zone motion along the right edge of the sensor.
> > - * @x_upper - scroll zone motion along the upper edge of the sensor.
> > - * @y_left - scroll zone motion along the left edge of the sensor.
> > +/** Handy pointers into our data buffer.
> > + *
> > + * @f_state - start of finger state registers.
> > + * @abs_pos - start of absolute position registers (if present).
> > + * @rel_pos - start of relative data registers (if present).
> > + * @gest_1  - gesture flags (if present).
> > + * @gest_2  - gesture flags & finger count (if present).
> > + * @pinch   - pinch motion register (if present).
> > + * @flick   - flick distance X & Y, flick time (if present).
> > + * @rotate  - rotate motion and finger separation.
> > + * @multi_scroll - chiral deltas for X and Y (if present).
> > + * @scroll_zones - scroll deltas for 4 regions (if present).
> >   */
> > -struct f11_2d_data_14_17 {
> > -	s8 x_low;
> > -	s8 y_right;
> > -	s8 x_upper;
> > -	s8 y_left;
> > -} __attribute__((__packed__));
> > -
> >  struct f11_2d_data {
> > -	u8				*f_state;
> > -	const struct f11_2d_data_1_5	*abs_pos;
> > -	const struct f11_2d_data_6_7	*rel_pos;
> > -	const struct f11_2d_data_8	*gest_1;
> > -	const struct f11_2d_data_9	*gest_2;
> > -	const struct f11_2d_data_10	*pinch;
> > -	const struct f11_2d_data_10_12	*flick;
> > -	const struct f11_2d_data_11_12	*rotate;
> > -	const struct f11_2d_data_13	*shapes;
> > -	const struct f11_2d_data_14_15	*multi_scroll;
> > -	const struct f11_2d_data_14_17	*scroll_zones;
> > +	u8	*f_state;
> > +	u8	*abs_pos;
> > +	s8	*rel_pos;
> > +	u8	*gest_1;
> > +	u8	*gest_2;
> > +	s8	*pinch;
> > +	u8	*flick;
> > +	u8	*rotate;
> > +	u8	*shapes;
> > +	s8	*multi_scroll;
> > +	s8	*scroll_zones;
> >  };
> >  
> >  /**
> > @@ -785,11 +535,13 @@ struct f11_2d_sensor {
> >   * poor electrical behavior on resume, where the initial calibration of the
> >   * sensor(s) coming out of sleep state may be bogus.
> >   * @sensors - per sensor data structures.
> > - * @debugfs_rezero_wait - allows control of the rezero_wait value.  Useful
> > - * during system prototyping.
> >   */
> >  struct f11_data {
> > -	struct f11_2d_device_query dev_query;
> > +	bool has_query9;
> > +	bool has_query11;
> > +	bool has_query12;
> > +	bool has_query27;
> > +	bool has_query28;
> >  	struct f11_2d_ctrl dev_controls;
> >  	struct mutex dev_controls_mutex;
> >  	u16 rezero_wait_ms;
> > @@ -809,7 +561,7 @@ enum finger_state_values {
> >  static int get_tool_type(struct f11_2d_sensor *sensor, u8 finger_state)
> >  {
> >  	if (IS_ENABLED(CONFIG_RMI4_F11_PEN) &&
> > -			sensor->sens_query.query9.has_pen &&
> > +			sensor->sens_query.has_pen &&
> >  			finger_state == F11_PEN)
> >  		return MT_TOOL_PEN;
> >  	return MT_TOOL_FINGER;
> > @@ -822,8 +574,8 @@ static void rmi_f11_rel_pos_report(struct f11_2d_sensor *sensor, u8 n_finger)
> >  	s8 x, y;
> >  	s8 temp;
> >  
> > -	x = data->rel_pos[n_finger].delta_x;
> > -	y = data->rel_pos[n_finger].delta_y;
> > +	x = data->rel_pos[n_finger * 2];
> > +	y = data->rel_pos[n_finger * 2 + 1];
> >  
> >  	x = min(F11_REL_POS_MAX, max(F11_REL_POS_MIN, (int)x));
> >  	y = min(F11_REL_POS_MAX, max(F11_REL_POS_MIN, (int)y));
> > @@ -856,17 +608,18 @@ static void rmi_f11_abs_pos_report(struct f11_data *f11,
> >  	u16 x, y, z;
> >  	int w_x, w_y, w_max, w_min, orient;
> >  	int temp;
> > +	u8 abs_base = n_finger * RMI_F11_ABS_BYTES;
> >  
> >  	if (finger_state) {
> > -		x = ((data->abs_pos[n_finger].x_msb << 4) |
> > -			data->abs_pos[n_finger].x_lsb);
> > -		y = ((data->abs_pos[n_finger].y_msb << 4) |
> > -			data->abs_pos[n_finger].y_lsb);
> > -		z = data->abs_pos[n_finger].z;
> > -		w_x = data->abs_pos[n_finger].w_x;
> > -		w_y = data->abs_pos[n_finger].w_y;
> > +		x = (data->abs_pos[abs_base] << 4) |
> > +			(data->abs_pos[abs_base + 2] & 0x0F);
> > +		y = (data->abs_pos[abs_base + 1] << 4) |
> > +			(data->abs_pos[abs_base + 2] >> 4);
> > +		w_x = data->abs_pos[abs_base + 3] & 0x0F;
> > +		w_y = data->abs_pos[abs_base + 3] >> 4;
> >  		w_max = max(w_x, w_y);
> >  		w_min = min(w_x, w_y);
> > +		z = data->abs_pos[abs_base + 4];
> >  
> >  		if (axis_align->swap_axes) {
> >  			temp = x;
> > @@ -976,38 +729,36 @@ static int f11_2d_construct_data(struct f11_2d_sensor *sensor)
> >  	struct f11_2d_data *data = &sensor->data;
> >  	int i;
> >  
> > -	sensor->nbr_fingers = (query->info.number_of_fingers == 5 ? 10 :
> > -				query->info.number_of_fingers + 1);
> > +	sensor->nbr_fingers = (query->nr_fingers == 5 ? 10 :
> > +				query->nr_fingers + 1);
> >  
> >  	sensor->pkt_size = DIV_ROUND_UP(sensor->nbr_fingers, 4);
> >  
> > -	if (query->info.has_abs)
> > +	if (query->has_abs)
> >  		sensor->pkt_size += (sensor->nbr_fingers * 5);
> >  
> > -	if (query->info.has_rel)
> > +	if (query->has_rel)
> >  		sensor->pkt_size +=  (sensor->nbr_fingers * 2);
> >  
> >  	/* Check if F11_2D_Query7 is non-zero */
> > -	if (has_gesture_bits(&query->gesture_info, 0))
> > +	if (query->query7_nonzero)
> >  		sensor->pkt_size += sizeof(u8);
> >  
> >  	/* Check if F11_2D_Query7 or F11_2D_Query8 is non-zero */
> > -	if (has_gesture_bits(&query->gesture_info, 0) ||
> > -				has_gesture_bits(&query->gesture_info, 1))
> > +	if (query->query7_nonzero || query->query8_nonzero)
> >  		sensor->pkt_size += sizeof(u8);
> >  
> > -	if (query->gesture_info.has_pinch || query->gesture_info.has_flick
> > -			|| query->gesture_info.has_rotate) {
> > +	if (query->has_pinch || query->has_flick || query->has_rotate) {
> >  		sensor->pkt_size += 3;
> > -		if (!query->gesture_info.has_flick)
> > +		if (!query->has_flick)
> >  			sensor->pkt_size--;
> > -		if (!query->gesture_info.has_rotate)
> > +		if (!query->has_rotate)
> >  			sensor->pkt_size--;
> >  	}
> >  
> > -	if (query->gesture_info.has_touch_shapes)
> > +	if (query->has_touch_shapes)
> >  		sensor->pkt_size +=
> > -			DIV_ROUND_UP(query->ts_info.nbr_touch_shapes + 1, 8);
> > +			DIV_ROUND_UP(query->nr_touch_shapes + 1, 8);
> >  
> >  	sensor->data_pkt = kzalloc(sensor->pkt_size, GFP_KERNEL);
> >  	if (!sensor->data_pkt)
> > @@ -1016,58 +767,52 @@ static int f11_2d_construct_data(struct f11_2d_sensor *sensor)
> >  	data->f_state = sensor->data_pkt;
> >  	i = DIV_ROUND_UP(sensor->nbr_fingers, 4);
> >  
> > -	if (query->info.has_abs) {
> > -		data->abs_pos = (struct f11_2d_data_1_5 *)
> > -				&sensor->data_pkt[i];
> > -		i += (sensor->nbr_fingers * 5);
> > +	if (query->has_abs) {
> > +		data->abs_pos = &sensor->data_pkt[i];
> > +		i += (sensor->nbr_fingers * RMI_F11_ABS_BYTES);
> >  	}
> >  
> > -	if (query->info.has_rel) {
> > -		data->rel_pos = (struct f11_2d_data_6_7 *)
> > -				&sensor->data_pkt[i];
> > -		i += (sensor->nbr_fingers * 2);
> > +	if (query->has_rel) {
> > +		data->rel_pos = &sensor->data_pkt[i];
> > +		i += (sensor->nbr_fingers * RMI_F11_REL_BYTES);
> >  	}
> >  
> > -	if (has_gesture_bits(&query->gesture_info, 0)) {
> > -		data->gest_1 = (struct f11_2d_data_8 *)&sensor->data_pkt[i];
> > +	if (query->query7_nonzero) {
> > +		data->gest_1 = &sensor->data_pkt[i];
> >  		i++;
> >  	}
> >  
> > -	if (has_gesture_bits(&query->gesture_info, 0) ||
> > -				has_gesture_bits(&query->gesture_info, 1)) {
> > -		data->gest_2 = (struct f11_2d_data_9 *)&sensor->data_pkt[i];
> > +	if (query->query7_nonzero || query->query8_nonzero) {
> > +		data->gest_2 = &sensor->data_pkt[i];
> >  		i++;
> >  	}
> >  
> > -	if (query->gesture_info.has_pinch) {
> > -		data->pinch = (struct f11_2d_data_10 *)&sensor->data_pkt[i];
> > +	if (query->has_pinch) {
> > +		data->pinch = &sensor->data_pkt[i];
> >  		i++;
> >  	}
> >  
> > -	if (query->gesture_info.has_flick) {
> > -		if (query->gesture_info.has_pinch) {
> > -			data->flick = (struct f11_2d_data_10_12 *)data->pinch;
> > +	if (query->has_flick) {
> > +		if (query->has_pinch) {
> > +			data->flick = data->pinch;
> >  			i += 2;
> >  		} else {
> > -			data->flick = (struct f11_2d_data_10_12 *)
> > -					&sensor->data_pkt[i];
> > +			data->flick = &sensor->data_pkt[i];
> >  			i += 3;
> >  		}
> >  	}
> >  
> > -	if (query->gesture_info.has_rotate) {
> > -		if (query->gesture_info.has_flick) {
> > -			data->rotate = (struct f11_2d_data_11_12 *)
> > -					(data->flick + 1);
> > +	if (query->has_rotate) {
> > +		if (query->has_flick) {
> > +			data->rotate = data->flick + 1;
> >  		} else {
> > -			data->rotate = (struct f11_2d_data_11_12 *)
> > -					&sensor->data_pkt[i];
> > +			data->rotate = &sensor->data_pkt[i];
> >  			i += 2;
> >  		}
> >  	}
> >  
> > -	if (query->gesture_info.has_touch_shapes)
> > -		data->shapes = (struct f11_2d_data_13 *)&sensor->data_pkt[i];
> > +	if (query->has_touch_shapes)
> > +		data->shapes = &sensor->data_pkt[i];
> >  
> >  	return 0;
> >  }
> > @@ -1075,213 +820,16 @@ static int f11_2d_construct_data(struct f11_2d_sensor *sensor)
> >  static int f11_read_control_regs(struct rmi_function *fn,
> >  				struct f11_2d_ctrl *ctrl, u16 ctrl_base_addr) {
> >  	struct rmi_device *rmi_dev = fn->rmi_dev;
> > -	u16 read_address = ctrl_base_addr;
> >  	int error = 0;
> >  
> > -	ctrl->ctrl0_9_address = read_address;
> > -	error = rmi_read_block(rmi_dev, read_address, ctrl->ctrl0_9,
> > -		sizeof(*ctrl->ctrl0_9));
> > +	ctrl->ctrl0_9_address = ctrl_base_addr;
> > +	error = rmi_read_block(rmi_dev, ctrl_base_addr, ctrl->ctrl0_9,
> > +				RMI_F11_CTRL_REG_COUNT);
> >  	if (error < 0) {
> >  		dev_err(&fn->dev, "Failed to read ctrl0, code: %d.\n", error);
> >  		return error;
> >  	}
> > -	read_address += sizeof(*ctrl->ctrl0_9);
> >  
> > -	if (ctrl->ctrl10) {
> > -		error = rmi_read_block(rmi_dev, read_address,
> > -			ctrl->ctrl10, sizeof(*ctrl->ctrl10));
> > -		if (error < 0) {
> > -			dev_err(&fn->dev,
> > -				"Failed to read ctrl10, code: %d.\n", error);
> > -			return error;
> > -		}
> > -		read_address += sizeof(*ctrl->ctrl10);
> > -	}
> > -
> > -	if (ctrl->ctrl11) {
> > -		error = rmi_read_block(rmi_dev, read_address,
> > -			ctrl->ctrl11, sizeof(*ctrl->ctrl11));
> > -		if (error < 0) {
> > -			dev_err(&fn->dev,
> > -				"Failed to read ctrl11, code: %d.\n", error);
> > -			return error;
> > -		}
> > -		read_address += sizeof(*ctrl->ctrl11);
> > -	}
> > -
> > -	if (ctrl->ctrl14) {
> > -		error = rmi_read_block(rmi_dev, read_address,
> > -			ctrl->ctrl14, sizeof(*ctrl->ctrl14));
> > -		if (error < 0) {
> > -			dev_err(&fn->dev,
> > -				"Failed to read ctrl14, code: %d.\n", error);
> > -			return error;
> > -		}
> > -		read_address += sizeof(*ctrl->ctrl14);
> > -	}
> > -
> > -	if (ctrl->ctrl15) {
> > -		error = rmi_read_block(rmi_dev, read_address,
> > -			ctrl->ctrl15, sizeof(*ctrl->ctrl15));
> > -		if (error < 0) {
> > -			dev_err(&fn->dev,
> > -				"Failed to read ctrl15, code: %d.\n", error);
> > -			return error;
> > -		}
> > -		read_address += sizeof(*ctrl->ctrl15);
> > -	}
> > -
> > -	if (ctrl->ctrl16) {
> > -		error = rmi_read_block(rmi_dev, read_address,
> > -			ctrl->ctrl16, sizeof(*ctrl->ctrl16));
> > -		if (error < 0) {
> > -			dev_err(&fn->dev,
> > -				"Failed to read ctrl16, code: %d.\n", error);
> > -			return error;
> > -		}
> > -		read_address += sizeof(*ctrl->ctrl16);
> > -	}
> > -
> > -	if (ctrl->ctrl17) {
> > -		error = rmi_read_block(rmi_dev, read_address,
> > -			ctrl->ctrl17, sizeof(*ctrl->ctrl17));
> > -		if (error < 0) {
> > -			dev_err(&fn->dev,
> > -				"Failed to read ctrl17, code: %d.\n", error);
> > -			return error;
> > -		}
> > -		read_address += sizeof(*ctrl->ctrl17);
> > -	}
> > -
> > -	if (ctrl->ctrl18_19) {
> > -		error = rmi_read_block(rmi_dev, read_address,
> > -			ctrl->ctrl18_19, sizeof(*ctrl->ctrl18_19));
> > -		if (error < 0) {
> > -			dev_err(&fn->dev,
> > -				"Failed to read ctrl18_19, code: %d.\n", error);
> > -			return error;
> > -		}
> > -		read_address += sizeof(*ctrl->ctrl18_19);
> > -	}
> > -
> > -	if (ctrl->ctrl20_21) {
> > -		error = rmi_read_block(rmi_dev, read_address,
> > -			ctrl->ctrl20_21, sizeof(*ctrl->ctrl20_21));
> > -		if (error < 0) {
> > -			dev_err(&fn->dev,
> > -				"Failed to read ctrl20_21, code: %d.\n", error);
> > -			return error;
> > -		}
> > -		read_address += sizeof(*ctrl->ctrl20_21);
> > -	}
> > -
> > -	if (ctrl->ctrl22_26) {
> > -		error = rmi_read_block(rmi_dev, read_address,
> > -			ctrl->ctrl22_26, sizeof(*ctrl->ctrl22_26));
> > -		if (error < 0) {
> > -			dev_err(&fn->dev,
> > -				"Failed to read ctrl22_26, code: %d.\n", error);
> > -			return error;
> > -		}
> > -		read_address += sizeof(*ctrl->ctrl22_26);
> > -	}
> > -
> > -	if (ctrl->ctrl27) {
> > -		error = rmi_read_block(rmi_dev, read_address,
> > -			ctrl->ctrl27, sizeof(*ctrl->ctrl27));
> > -		if (error < 0) {
> > -			dev_err(&fn->dev,
> > -				"Failed to read ctrl27, code: %d.\n", error);
> > -			return error;
> > -		}
> > -		read_address += sizeof(*ctrl->ctrl27);
> > -	}
> > -
> > -	if (ctrl->ctrl28) {
> > -		error = rmi_read_block(rmi_dev, read_address,
> > -			ctrl->ctrl28, sizeof(*ctrl->ctrl28));
> > -		if (error < 0) {
> > -			dev_err(&fn->dev,
> > -				"Failed to read ctrl28, code: %d.\n", error);
> > -			return error;
> > -		}
> > -		read_address += sizeof(*ctrl->ctrl28);
> > -	}
> > -
> > -	if (ctrl->ctrl29_30) {
> > -		error = rmi_read_block(rmi_dev, read_address,
> > -			ctrl->ctrl29_30, sizeof(*ctrl->ctrl29_30));
> > -		if (error < 0) {
> > -			dev_err(&fn->dev,
> > -				"Failed to read ctrl29_30, code: %d.\n", error);
> > -			return error;
> > -		}
> > -		read_address += sizeof(*ctrl->ctrl29_30);
> > -	}
> > -	return 0;
> > -}
> > -
> > -static int f11_allocate_control_regs(struct rmi_function *fn,
> > -				struct f11_2d_device_query *device_query,
> > -				struct f11_2d_sensor_queries *sensor_query,
> > -				struct f11_2d_ctrl *ctrl,
> > -				u16 ctrl_base_addr) {
> > -
> > -	ctrl->ctrl0_9 = devm_kzalloc(&fn->dev, sizeof(struct f11_2d_ctrl0_9),
> > -				       GFP_KERNEL);
> > -	if (!ctrl->ctrl0_9)
> > -		return -ENOMEM;
> > -	if (has_gesture_bits(&sensor_query->gesture_info, 0)) {
> > -		ctrl->ctrl10 = devm_kzalloc(&fn->dev,
> > -			sizeof(struct f11_2d_ctrl10), GFP_KERNEL);
> > -		if (!ctrl->ctrl10)
> > -			return -ENOMEM;
> > -	}
> > -
> > -	if (has_gesture_bits(&sensor_query->gesture_info, 1)) {
> > -		ctrl->ctrl11 = devm_kzalloc(&fn->dev,
> > -			sizeof(struct f11_2d_ctrl11), GFP_KERNEL);
> > -		if (!ctrl->ctrl11)
> > -			return -ENOMEM;
> > -	}
> > -
> > -	if (device_query->has_query9 && sensor_query->query9.has_pen) {
> > -		ctrl->ctrl20_21 = devm_kzalloc(&fn->dev,
> > -			sizeof(struct f11_2d_ctrl20_21), GFP_KERNEL);
> > -		if (!ctrl->ctrl20_21)
> > -			return -ENOMEM;
> > -	}
> > -
> > -	if (device_query->has_query9 && sensor_query->query9.has_proximity) {
> > -		ctrl->ctrl22_26 = devm_kzalloc(&fn->dev,
> > -			sizeof(struct f11_2d_ctrl22_26), GFP_KERNEL);
> > -		if (!ctrl->ctrl22_26)
> > -			return -ENOMEM;
> > -	}
> > -
> > -	if (device_query->has_query9 &&
> > -		(sensor_query->query9.has_palm_det_sensitivity ||
> > -		sensor_query->query9.has_suppress_on_palm_detect)) {
> > -		ctrl->ctrl27 = devm_kzalloc(&fn->dev,
> > -			sizeof(struct f11_2d_ctrl27), GFP_KERNEL);
> > -		if (!ctrl->ctrl27)
> > -			return -ENOMEM;
> > -	}
> > -
> > -	if (sensor_query->gesture_info.has_multi_finger_scroll) {
> > -		ctrl->ctrl28 = devm_kzalloc(&fn->dev,
> > -			sizeof(struct f11_2d_ctrl28), GFP_KERNEL);
> > -		if (!ctrl->ctrl28)
> > -			return -ENOMEM;
> > -	}
> > -
> > -	if (device_query->has_query11 &&
> > -			sensor_query->features_1.has_z_tuning) {
> > -		ctrl->ctrl29_30 = devm_kzalloc(&fn->dev,
> > -			sizeof(struct f11_2d_ctrl29_30), GFP_KERNEL);
> > -		if (!ctrl->ctrl29_30)
> > -			return -ENOMEM;
> > -	}
> >  
> >  	return 0;
> >  }
> > @@ -1292,139 +840,71 @@ static int f11_write_control_regs(struct rmi_function *fn,
> >  					u16 ctrl_base_addr)
> >  {
> >  	struct rmi_device *rmi_dev = fn->rmi_dev;
> > -	u16 write_address = ctrl_base_addr;
> >  	int error;
> >  
> > -	error = rmi_write_block(rmi_dev, write_address,
> > -				ctrl->ctrl0_9,
> > -				 sizeof(*ctrl->ctrl0_9));
> > +	error = rmi_write_block(rmi_dev, ctrl_base_addr, ctrl->ctrl0_9,
> > +				RMI_F11_CTRL_REG_COUNT);
> >  	if (error < 0)
> >  		return error;
> > -	write_address += sizeof(ctrl->ctrl0_9);
> > -
> > -	if (ctrl->ctrl10) {
> > -		error = rmi_write_block(rmi_dev, write_address,
> > -					ctrl->ctrl10, sizeof(*ctrl->ctrl10));
> > -		if (error < 0)
> > -			return error;
> > -		write_address++;
> > -	}
> > -
> > -	if (ctrl->ctrl11) {
> > -		error = rmi_write_block(rmi_dev, write_address,
> > -					ctrl->ctrl11, sizeof(*ctrl->ctrl11));
> > -		if (error < 0)
> > -			return error;
> > -		write_address++;
> > -	}
> > -
> > -	if (ctrl->ctrl14) {
> > -		error = rmi_write_block(rmi_dev, write_address,
> > -				ctrl->ctrl14, sizeof(ctrl->ctrl14));
> > -		if (error < 0)
> > -			return error;
> > -		write_address += sizeof(*ctrl->ctrl15);
> > -	}
> >  
> > -	if (ctrl->ctrl15) {
> > -		error = rmi_write_block(rmi_dev, write_address,
> > -				ctrl->ctrl15, sizeof(*ctrl->ctrl15));
> > -		if (error < 0)
> > -			return error;
> > -		write_address += sizeof(*ctrl->ctrl15);
> > -	}
> > -
> > -	if (ctrl->ctrl16) {
> > -		error = rmi_write_block(rmi_dev, write_address,
> > -				ctrl->ctrl16, sizeof(*ctrl->ctrl16));
> > -		if (error < 0)
> > -			return error;
> > -		write_address += sizeof(*ctrl->ctrl16);
> > -	}
> > -
> > -	if (ctrl->ctrl17) {
> > -		error = rmi_write_block(rmi_dev, write_address,
> > -				ctrl->ctrl17, sizeof(*ctrl->ctrl17));
> > -		if (error < 0)
> > -			return error;
> > -		write_address += sizeof(*ctrl->ctrl17);
> > -	}
> > -
> > -	if (ctrl->ctrl18_19) {
> > -		error = rmi_write_block(rmi_dev, write_address,
> > -			ctrl->ctrl18_19, sizeof(*ctrl->ctrl18_19));
> > -		if (error < 0)
> > -			return error;
> > -		write_address += sizeof(*ctrl->ctrl18_19);
> > -	}
> > -
> > -	if (ctrl->ctrl20_21) {
> > -		error = rmi_write_block(rmi_dev, write_address,
> > -			ctrl->ctrl20_21, sizeof(*ctrl->ctrl20_21));
> > -		if (error < 0)
> > -			return error;
> > -		write_address += sizeof(*ctrl->ctrl20_21);
> > -	}
> > -
> > -	if (ctrl->ctrl22_26) {
> > -		error = rmi_write_block(rmi_dev, write_address,
> > -			ctrl->ctrl22_26, sizeof(*ctrl->ctrl22_26));
> > -		if (error < 0)
> > -			return error;
> > -		write_address += sizeof(*ctrl->ctrl22_26);
> > -	}
> > -
> > -	if (ctrl->ctrl27) {
> > -		error = rmi_write_block(rmi_dev, write_address,
> > -			ctrl->ctrl27, sizeof(*ctrl->ctrl27));
> > -		if (error < 0)
> > -			return error;
> > -		write_address += sizeof(*ctrl->ctrl27);
> > -	}
> > -
> > -	if (ctrl->ctrl28) {
> > -		error = rmi_write_block(rmi_dev, write_address,
> > -			ctrl->ctrl28, sizeof(*ctrl->ctrl28));
> > -		if (error < 0)
> > -			return error;
> > -		write_address += sizeof(*ctrl->ctrl28);
> > -	}
> > -
> > -	if (ctrl->ctrl29_30) {
> > -		error = rmi_write_block(rmi_dev, write_address,
> > -					ctrl->ctrl29_30,
> > -					sizeof(struct f11_2d_ctrl29_30));
> > -		if (error < 0)
> > -			return error;
> > -		write_address += sizeof(struct f11_2d_ctrl29_30);
> > -	}
> >  
> >  	return 0;
> >  }
> >  
> >  static int rmi_f11_get_query_parameters(struct rmi_device *rmi_dev,
> > -			struct f11_2d_device_query *dev_query,
> > +			struct f11_data *f11,
> >  			struct f11_2d_sensor_queries *sensor_query,
> >  			u16 query_base_addr)
> >  {
> >  	int query_size;
> >  	int rc;
> > +	u8 query_buf[RMI_F11_QUERY_SIZE];
> >  
> > -	rc = rmi_read_block(rmi_dev, query_base_addr,
> > -			    &sensor_query->info, sizeof(sensor_query->info));
> > +	rc = rmi_read_block(rmi_dev, query_base_addr, query_buf,
> > +				RMI_F11_QUERY_SIZE);
> >  	if (rc < 0)
> >  		return rc;
> > -	query_size = sizeof(sensor_query->info);
> >  
> > -	if (sensor_query->info.has_abs) {
> > -		rc = rmi_read(rmi_dev, query_base_addr + query_size,
> > -					&sensor_query->abs_info);
> > +	sensor_query->nr_fingers = query_buf[0] & RMI_F11_NR_FINGERS_MASK;
> > +	sensor_query->has_rel = !!(query_buf[0] & RMI_F11_HAS_REL);
> > +	sensor_query->has_abs = !!(query_buf[0] & RMI_F11_HAS_ABS);
> > +	sensor_query->has_gestures = !!(query_buf[0] & RMI_F11_HAS_GESTURES);
> > +	sensor_query->has_sensitivity_adjust =
> > +		!!(query_buf[0] && RMI_F11_HAS_SENSITIVITY_ADJ);
> > +	sensor_query->configurable = !!(query_buf[0] & RMI_F11_CONFIGURABLE);
> > +
> > +	sensor_query->nr_x_electrodes =
> > +				query_buf[1] & RMI_F11_NR_ELECTRODES_MASK;
> > +	sensor_query->nr_y_electrodes =
> > +				query_buf[2] & RMI_F11_NR_ELECTRODES_MASK;
> > +	sensor_query->max_electrodes =
> > +				query_buf[3] & RMI_F11_NR_ELECTRODES_MASK;
> > +
> > +	query_size = RMI_F11_QUERY_SIZE;
> > +
> > +	if (sensor_query->has_abs) {
> > +		rc = rmi_read(rmi_dev, query_base_addr + query_size, query_buf);
> >  		if (rc < 0)
> >  			return rc;
> > +
> > +		sensor_query->abs_data_size =
> > +			query_buf[0] & RMI_F11_ABS_DATA_SIZE_MASK;
> > +		sensor_query->has_anchored_finger =
> > +			!!(query_buf[0] & RMI_F11_HAS_ANCHORED_FINGER);
> > +		sensor_query->has_adj_hyst =
> > +			!!(query_buf[0] & RMI_F11_HAS_ADJ_HYST);
> > +		sensor_query->has_dribble =
> > +			!!(query_buf[0] & RMI_F11_HAS_DRIBBLE);
> > +		sensor_query->has_bending_correction =
> > +			!!(query_buf[0] & RMI_F11_HAS_BENDING_CORRECTION);
> > +		sensor_query->has_large_object_suppression =
> > +		!!(query_buf[0] && RMI_F11_HAS_LARGE_OBJECT_SUPPRESSION);
> > +		sensor_query->has_jitter_filter =
> > +			!!(query_buf[0] & RMI_F11_HAS_JITTER_FILTER);
> >  		query_size++;
> >  	}
> >  
> > -	if (sensor_query->info.has_rel) {
> > +	if (sensor_query->has_rel) {
> >  		rc = rmi_read(rmi_dev, query_base_addr + query_size,
> >  					&sensor_query->f11_2d_query6);
> >  		if (rc < 0)
> > @@ -1432,67 +912,173 @@ static int rmi_f11_get_query_parameters(struct rmi_device *rmi_dev,
> >  		query_size++;
> >  	}
> >  
> > -	if (sensor_query->info.has_gestures) {
> > +	if (sensor_query->has_gestures) {
> >  		rc = rmi_read_block(rmi_dev, query_base_addr + query_size,
> > -					&sensor_query->gesture_info,
> > -					sizeof(sensor_query->gesture_info));
> > +					query_buf, RMI_F11_QUERY_GESTURE_SIZE);
> >  		if (rc < 0)
> >  			return rc;
> > -		query_size += sizeof(sensor_query->gesture_info);
> > -	}
> >  
> > -	if (dev_query->has_query9) {
> > -		rc = rmi_read_block(rmi_dev, query_base_addr + query_size,
> > -					&sensor_query->query9,
> > -					sizeof(sensor_query->query9));
> > +		sensor_query->has_single_tap =
> > +			!!(query_buf[0] & RMI_F11_HAS_SINGLE_TAP);
> > +		sensor_query->has_tap_n_hold =
> > +			!!(query_buf[0] & RMI_F11_HAS_TAP_AND_HOLD);
> > +		sensor_query->has_double_tap =
> > +			!!(query_buf[0] & RMI_F11_HAS_DOUBLE_TAP);
> > +		sensor_query->has_early_tap =
> > +			!!(query_buf[0] & RMI_F11_HAS_EARLY_TAP);
> > +		sensor_query->has_flick =
> > +			!!(query_buf[0] & RMI_F11_HAS_FLICK);
> > +		sensor_query->has_press =
> > +			!!(query_buf[0] & RMI_F11_HAS_PRESS);
> > +		sensor_query->has_pinch =
> > +			!!(query_buf[0] & RMI_F11_HAS_PINCH);
> > +		sensor_query->has_chiral =
> > +			!!(query_buf[0] & RMI_F11_HAS_CHIRAL);
> > +
> > +		/* query 8 */
> > +		sensor_query->has_palm_det =
> > +			!!(query_buf[1] & RMI_F11_HAS_PALM_DET);
> > +		sensor_query->has_rotate =
> > +			!!(query_buf[1] & RMI_F11_HAS_ROTATE);
> > +		sensor_query->has_touch_shapes =
> > +			!!(query_buf[1] & RMI_F11_HAS_TOUCH_SHAPES);
> > +		sensor_query->has_scroll_zones =
> > +			!!(query_buf[1] & RMI_F11_HAS_SCROLL_ZONES);
> > +		sensor_query->has_individual_scroll_zones =
> > +			!!(query_buf[1] & RMI_F11_HAS_INDIVIDUAL_SCROLL_ZONES);
> > +		sensor_query->has_mf_scroll =
> > +			!!(query_buf[1] & RMI_F11_HAS_MF_SCROLL);
> > +		sensor_query->has_mf_edge_motion =
> > +			!!(query_buf[1] & RMI_F11_HAS_MF_EDGE_MOTION);
> > +		sensor_query->has_mf_scroll_inertia =
> > +			!!(query_buf[1] & RMI_F11_HAS_MF_SCROLL_INERTIA);
> > +
> > +		sensor_query->query7_nonzero = !!(query_buf[0]);
> > +		sensor_query->query8_nonzero = !!(query_buf[1]);
> > +
> > +		query_size += 2;
> > +	}
> > +
> > +	if (f11->has_query9) {
> > +		rc = rmi_read(rmi_dev, query_base_addr + query_size, query_buf);
> >  		if (rc < 0)
> >  			return rc;
> > -		query_size += sizeof(sensor_query->query9);
> > +
> > +		sensor_query->has_pen =
> > +			!!(query_buf[0] & RMI_F11_HAS_PEN);
> > +		sensor_query->has_proximity =
> > +			!!(query_buf[0] & RMI_F11_HAS_PROXIMITY);
> > +		sensor_query->has_palm_det_sensitivity =
> > +			!!(query_buf[0] & RMI_F11_HAS_PALM_DET_SENSITIVITY);
> > +		sensor_query->has_suppress_on_palm_detect =
> > +			!!(query_buf[0] & RMI_F11_HAS_SUPPRESS_ON_PALM_DETECT);
> > +		sensor_query->has_two_pen_thresholds =
> > +			!!(query_buf[0] & RMI_F11_HAS_TWO_PEN_THRESHOLDS);
> > +		sensor_query->has_contact_geometry =
> > +			!!(query_buf[0] & RMI_F11_HAS_CONTACT_GEOMETRY);
> > +		sensor_query->has_pen_hover_discrimination =
> > +			!!(query_buf[0] & RMI_F11_HAS_PEN_HOVER_DISCRIMINATION);
> > +		sensor_query->has_pen_filters =
> > +			!!(query_buf[0] & RMI_F11_HAS_PEN_FILTERS);
> > +
> > +		query_size++;
> >  	}
> >  
> > -	if (sensor_query->gesture_info.has_touch_shapes) {
> > -		rc = rmi_read_block(rmi_dev, query_base_addr + query_size,
> > -					&sensor_query->ts_info,
> > -					sizeof(sensor_query->ts_info));
> > +	if (sensor_query->has_touch_shapes) {
> > +		rc = rmi_read(rmi_dev, query_base_addr + query_size, query_buf);
> >  		if (rc < 0)
> >  			return rc;
> > -		query_size += sizeof(sensor_query->ts_info);
> > +
> > +		sensor_query->nr_touch_shapes = query_buf[0] &
> > +				RMI_F11_NR_TOUCH_SHAPES_MASK;
> > +
> > +		query_size++;
> >  	}
> >  
> > -	if (dev_query->has_query11) {
> > -		rc = rmi_read_block(rmi_dev, query_base_addr + query_size,
> > -					&sensor_query->features_1,
> > -					sizeof(sensor_query->features_1));
> > +	if (f11->has_query11) {
> > +		rc = rmi_read(rmi_dev, query_base_addr + query_size, query_buf);
> >  		if (rc < 0)
> >  			return rc;
> > -		query_size += sizeof(sensor_query->features_1);
> > +
> > +		sensor_query->has_z_tuning =
> > +			!!(query_buf[0] & RMI_F11_HAS_Z_TUNING);
> > +		sensor_query->has_algorithm_selection =
> > +			!!(query_buf[0] & RMI_F11_HAS_ALGORITHM_SELECTION);
> > +		sensor_query->has_w_tuning =
> > +			!!(query_buf[0] & RMI_F11_HAS_W_TUNING);
> > +		sensor_query->has_pitch_info =
> > +			!!(query_buf[0] & RMI_F11_HAS_PITCH_INFO);
> > +		sensor_query->has_finger_size =
> > +			!!(query_buf[0] & RMI_F11_HAS_FINGER_SIZE);
> > +		sensor_query->has_segmentation_aggressiveness =
> > +			!!(query_buf[0] &
> > +				RMI_F11_HAS_SEGMENTATION_AGGRESSIVENESS);
> > +		sensor_query->has_XY_clip =
> > +			!!(query_buf[0] & RMI_F11_HAS_XY_CLIP);
> > +		sensor_query->has_drumming_filter =
> > +			!!(query_buf[0] & RMI_F11_HAS_DRUMMING_FILTER);
> > +
> > +		query_size++;
> >  	}
> >  
> > -	if (dev_query->has_query12) {
> > -		rc = rmi_read_block(rmi_dev, query_base_addr + query_size,
> > -					&sensor_query->features_2,
> > -					sizeof(sensor_query->features_2));
> > +	if (f11->has_query12) {
> > +		rc = rmi_read(rmi_dev, query_base_addr + query_size, query_buf);
> >  		if (rc < 0)
> >  			return rc;
> > -		query_size += sizeof(sensor_query->features_2);
> > +
> > +		sensor_query->has_gapless_finger =
> > +			!!(query_buf[0] & RMI_F11_HAS_GAPLESS_FINGER);
> > +		sensor_query->has_gapless_finger_tuning =
> > +			!!(query_buf[0] & RMI_F11_HAS_GAPLESS_FINGER_TUNING);
> > +		sensor_query->has_8bit_w =
> > +			!!(query_buf[0] & RMI_F11_HAS_8BIT_W);
> > +		sensor_query->has_adjustable_mapping =
> > +			!!(query_buf[0] & RMI_F11_HAS_ADJUSTABLE_MAPPING);
> > +		sensor_query->has_info2 =
> > +			!!(query_buf[0] & RMI_F11_HAS_INFO2);
> > +		sensor_query->has_physical_props =
> > +			!!(query_buf[0] & RMI_F11_HAS_PHYSICAL_PROPS);
> > +		sensor_query->has_finger_limit =
> > +			!!(query_buf[0] & RMI_F11_HAS_FINGER_LIMIT);
> > +		sensor_query->has_linear_coeff_2 =
> > +			!!(query_buf[0] & RMI_F11_HAS_LINEAR_COEFF);
> > +
> > +		query_size++;
> >  	}
> >  
> > -	if (sensor_query->abs_info.has_jitter_filter) {
> > -		rc = rmi_read_block(rmi_dev, query_base_addr + query_size,
> > -					&sensor_query->jitter_filter,
> > -					sizeof(sensor_query->jitter_filter));
> > +	if (sensor_query->has_jitter_filter) {
> > +		rc = rmi_read(rmi_dev, query_base_addr + query_size, query_buf);
> >  		if (rc < 0)
> >  			return rc;
> > -		query_size += sizeof(sensor_query->jitter_filter);
> > +
> > +		sensor_query->jitter_window_size = query_buf[0] &
> > +			RMI_F11_JITTER_WINDOW_MASK;
> > +		sensor_query->jitter_filter_type = (query_buf[0] &
> > +			RMI_F11_JITTER_FILTER_MASK) >>
> > +			RMI_F11_JITTER_FILTER_SHIFT;
> > +
> > +		query_size++;
> >  	}
> >  
> > -	if (dev_query->has_query12 && sensor_query->features_2.has_info2) {
> > -		rc = rmi_read_block(rmi_dev, query_base_addr + query_size,
> > -				    &sensor_query->info_2,
> > -					sizeof(sensor_query->info_2));
> > +	if (f11->has_query12 && sensor_query->has_info2) {
> > +		rc = rmi_read(rmi_dev, query_base_addr + query_size, query_buf);
> >  		if (rc < 0)
> >  			return rc;
> > -		query_size += sizeof(sensor_query->info_2);
> > +
> > +		sensor_query->light_control =
> > +			query_buf[0] & RMI_F11_LIGHT_CONTROL_MASK;
> > +		sensor_query->is_clear =
> > +			!!(query_buf[0] & RMI_F11_IS_CLEAR);
> > +		sensor_query->clickpad_props =
> > +			(query_buf[0] & RMI_F11_CLICKPAD_PROPS_MASK) >>
> > +			RMI_F11_CLICKPAD_PROPS_SHIFT;
> > +		sensor_query->mouse_buttons =
> > +			(query_buf[0] & RMI_F11_MOUSE_BUTTONS_MASK) >>
> > +			RMI_F11_MOUSE_BUTTONS_SHIFT;
> > +		sensor_query->has_advanced_gestures =
> > +			!!(query_buf[0] & RMI_F11_HAS_ADVANCED_GESTURES);
> > +
> > +		query_size++;
> >  	}
> >  
> >  	return query_size;
> > @@ -1506,10 +1092,15 @@ static void f11_set_abs_params(struct rmi_function *fn)
> >  	struct f11_data *f11 = fn->data;
> >  	struct f11_2d_sensor *sensor = &f11->sensor;
> >  	struct input_dev *input = sensor->input;
> > -	u16 device_x_max =
> > -		f11->dev_controls.ctrl0_9->sensor_max_x_pos;
> > -	u16 device_y_max =
> > -		f11->dev_controls.ctrl0_9->sensor_max_y_pos;
> > +	/* These two lines are not doing what we want them to.  So we use
> > +	 * some shifts instead.
> > +	int device_x_max = le16_to_cpu(*(f11->dev_controls.ctrl0_9 + 6));
> > +	int device_y_max = le16_to_cpu(*(f11->dev_controls.ctrl0_9 + 8));
> > +	 */
> > +	u16 device_x_max = f11->dev_controls.ctrl0_9[6] |
> > +			((f11->dev_controls.ctrl0_9[7] & 0x0F) << 8);
> > +	u16 device_y_max = f11->dev_controls.ctrl0_9[8] |
> > +			((f11->dev_controls.ctrl0_9[9] & 0x0F) << 8);
> >  	u16 x_min, x_max, y_min, y_max;
> >  	unsigned int input_flags;
> >  
> > @@ -1517,8 +1108,8 @@ static void f11_set_abs_params(struct rmi_function *fn)
> >  	 * as a touchpad in the platform data
> >  	 */
> >  	if (sensor->sensor_type == rmi_f11_sensor_touchpad ||
> > -			(sensor->sens_query.features_2.has_info2 &&
> > -				!sensor->sens_query.info_2.is_clear))
> > +			(sensor->sens_query.has_info2 &&
> > +				!sensor->sens_query.is_clear))
> >  		input_flags = INPUT_PROP_POINTER;
> >  	else
> >  		input_flags = INPUT_PROP_DIRECT;
> > @@ -1567,8 +1158,7 @@ static void f11_set_abs_params(struct rmi_function *fn)
> >  			y_min, y_max, 0, 0);
> >  	if (!sensor->type_a)
> >  		input_mt_init_slots(input, sensor->nbr_fingers, input_flags);
> > -	if (IS_ENABLED(CONFIG_RMI4_F11_PEN) &&
> > -			sensor->sens_query.query9.has_pen)
> > +	if (IS_ENABLED(CONFIG_RMI4_F11_PEN) && sensor->sens_query.has_pen)
> >  		input_set_abs_params(input, ABS_MT_TOOL_TYPE,
> >  				     0, MT_TOOL_MAX, 0, 0);
> >  	else
> > @@ -1588,6 +1178,7 @@ static int rmi_f11_initialize(struct rmi_function *fn)
> >  	int rc;
> >  	struct rmi_device_platform_data *pdata = to_rmi_platform_data(rmi_dev);
> >  	struct f11_2d_sensor *sensor;
> > +	u8 buf;
> >  
> >  	dev_dbg(&fn->dev, "Initializing F11 values for %s.\n",
> >  		 pdata->sensor_name);
> > @@ -1605,29 +1196,26 @@ static int rmi_f11_initialize(struct rmi_function *fn)
> >  	query_base_addr = fn->fd.query_base_addr;
> >  	control_base_addr = fn->fd.control_base_addr;
> >  
> > -	rc = rmi_read(rmi_dev, query_base_addr, &f11->dev_query);
> > +	rc = rmi_read(rmi_dev, query_base_addr, &buf);
> >  	if (rc < 0)
> >  		return rc;
> >  
> > +	f11->has_query9 = !!(buf & RMI_F11_HAS_QUERY9);
> > +	f11->has_query11 = !!(buf & RMI_F11_HAS_QUERY11);
> > +	f11->has_query12 = !!(buf & RMI_F11_HAS_QUERY12);
> > +	f11->has_query27 = !!(buf & RMI_F11_HAS_QUERY27);
> > +	f11->has_query28 = !!(buf & RMI_F11_HAS_QUERY28);
> > +
> >  	query_offset = (query_base_addr + 1);
> >  	sensor = &f11->sensor;
> >  	sensor->fn = fn;
> >  
> > -	rc = rmi_f11_get_query_parameters(rmi_dev, &f11->dev_query,
> > +	rc = rmi_f11_get_query_parameters(rmi_dev, f11,
> >  			&sensor->sens_query, query_offset);
> >  	if (rc < 0)
> >  		return rc;
> >  	query_offset += rc;
> >  
> > -	rc = f11_allocate_control_regs(fn,
> > -			&f11->dev_query, &sensor->sens_query,
> > -			&f11->dev_controls, control_base_addr);
> > -	if (rc < 0) {
> > -		dev_err(&fn->dev,
> > -			"Failed to allocate F11 control params.\n");
> > -		return rc;
> > -	}
> > -
> >  	rc = f11_read_control_regs(fn, &f11->dev_controls,
> >  			control_base_addr);
> >  	if (rc < 0) {
> > @@ -1670,12 +1258,11 @@ static int rmi_f11_initialize(struct rmi_function *fn)
> >  
> >  	ctrl = &f11->dev_controls;
> >  	if (sensor->axis_align.delta_x_threshold) {
> > -		ctrl->ctrl0_9->delta_x_threshold =
> > +		ctrl->ctrl0_9[RMI_F11_DELTA_X_THRESHOLD] =
> >  			sensor->axis_align.delta_x_threshold;
> > -		rc = rmi_write_block(rmi_dev,
> > -				ctrl->ctrl0_9_address,
> > +		rc = rmi_write_block(rmi_dev, ctrl->ctrl0_9_address,
> >  				ctrl->ctrl0_9,
> > -				sizeof(*ctrl->ctrl0_9));
> > +				RMI_F11_CTRL_REG_COUNT);
> >  		if (rc < 0)
> >  			dev_warn(&fn->dev, "Failed to write to delta_x_threshold. Code: %d.\n",
> >  				rc);
> > @@ -1683,12 +1270,10 @@ static int rmi_f11_initialize(struct rmi_function *fn)
> >  	}
> >  
> >  	if (sensor->axis_align.delta_y_threshold) {
> > -		ctrl->ctrl0_9->delta_y_threshold =
> > +		ctrl->ctrl0_9[RMI_F11_DELTA_Y_THRESHOLD] =
> >  			sensor->axis_align.delta_y_threshold;
> > -		rc = rmi_write_block(rmi_dev,
> > -				ctrl->ctrl0_9_address,
> > -				ctrl->ctrl0_9,
> > -				sizeof(*ctrl->ctrl0_9));
> > +		rc = rmi_write_block(rmi_dev, ctrl->ctrl0_9_address,
> > +				ctrl->ctrl0_9, RMI_F11_CTRL_REG_COUNT);
> >  		if (rc < 0)
> >  			dev_warn(&fn->dev, "Failed to write to delta_y_threshold. Code: %d.\n",
> >  				rc);
> > @@ -1737,7 +1322,7 @@ static int rmi_f11_register_devices(struct rmi_function *fn)
> >  
> >  	f11_set_abs_params(fn);
> >  
> > -	if (sensor->sens_query.info.has_rel) {
> > +	if (sensor->sens_query.has_rel) {
> >  		set_bit(EV_REL, input_dev->evbit);
> >  		set_bit(REL_X, input_dev->relbit);
> >  		set_bit(REL_Y, input_dev->relbit);
> > @@ -1749,7 +1334,7 @@ static int rmi_f11_register_devices(struct rmi_function *fn)
> >  		goto error_unregister;
> >  	}
> >  
> > -	if (sensor->sens_query.info.has_rel) {
> > +	if (sensor->sens_query.has_rel) {
> >  		/*create input device for mouse events  */
> >  		input_dev_mouse = input_allocate_device();
> >  		if (!input_dev_mouse) {
> > @@ -1857,10 +1442,6 @@ static int rmi_f11_resume(struct device *dev)
> >  	struct rmi_function *fn = to_rmi_function(dev);
> >  	struct rmi_device *rmi_dev = fn->rmi_dev;
> >  	struct f11_data *data = fn->data;
> > -	/* Command register always reads as 0, so we can just use a local. */
> > -	struct f11_2d_commands commands = {
> > -		.rezero = true,
> > -	};
> >  	int error;
> >  
> >  	dev_dbg(&fn->dev, "Resuming...\n");
> > @@ -1869,8 +1450,7 @@ static int rmi_f11_resume(struct device *dev)
> >  
> >  	mdelay(data->rezero_wait_ms);
> >  
> > -	error = rmi_write_block(rmi_dev, fn->fd.command_base_addr,
> > -				&commands, sizeof(commands));
> > +	error = rmi_write(rmi_dev, fn->fd.command_base_addr, RMI_F11_REZERO);
> >  	if (error < 0) {
> >  		dev_err(&fn->dev,
> >  			"%s: failed to issue rezero command, error = %d.",
> 
> -- 
> Dmitry
