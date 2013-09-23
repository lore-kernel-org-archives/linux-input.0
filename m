From: Juergen Beisert <jbe@pengutronix.de>
Subject: [PATCH 6/9] Staging/iio/adc/touchscreen/MXS: add interrupt driven touch detection
Date: Mon, 23 Sep 2013 16:36:35 +0200
Message-ID: <1379946998-23041-7-git-send-email-jbe@pengutronix.de>
References: <1379946998-23041-1-git-send-email-jbe@pengutronix.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48989 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753153Ab3IWOhm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Sep 2013 10:37:42 -0400
In-Reply-To: <1379946998-23041-1-git-send-email-jbe@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-iio@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org, marex@denx.de, fabio.estevam@freescale.com, jic23@cam.ac.uk, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

For battery driven systems it is a very bad idea to collect the touchscreen
data within a kernel busy loop.

This change uses the features of the hardware to delay and accumulate samples in
hardware to avoid a high interrupt and CPU load.

Note: this is only tested on an i.MX23 SoC yet.

Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
CC: linux-arm-kernel@lists.infradead.org
CC: linux-input@vger.kernel.org
CC: devel@driverdev.osuosl.org
CC: Marek Vasut <marex@denx.de>
CC: Fabio Estevam <fabio.estevam@freescale.com>
CC: Jonathan Cameron <jic23@cam.ac.uk>
CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: linux-input@vger.kernel.org
---
 drivers/staging/iio/adc/mxs-lradc.c | 530 ++++++++++++++++++++++++++++++++----
 1 file changed, 476 insertions(+), 54 deletions(-)

diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
index a92e810..76a900d 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -130,6 +130,17 @@ enum mxs_lradc_ts {
 	MXS_LRADC_TOUCHSCREEN_5WIRE,
 };
 
+/*
+ * Touchscreen handling
+ */
+enum lradc_ts_plate {
+	LRADC_TOUCH = 0,
+	LRADC_SAMPLE_X,
+	LRADC_SAMPLE_Y,
+	LRADC_SAMPLE_PRESSURE,
+	LRADC_SAMPLE_VALID,
+};
+
 struct mxs_lradc {
 	struct device		*dev;
 	void __iomem		*base;
@@ -172,13 +183,25 @@ struct mxs_lradc {
 #define CHAN_MASK_TOUCHSCREEN_4WIRE	(0xf << 2)
 #define CHAN_MASK_TOUCHSCREEN_5WIRE	(0x1f << 2)
 	enum mxs_lradc_ts	use_touchscreen;
-	bool			stop_touchscreen;
 	bool			use_touchbutton;
 
 	struct input_dev	*ts_input;
 	struct work_struct	ts_work;
 
 	enum mxs_lradc_id	soc;
+	enum lradc_ts_plate	cur_plate; /* statemachine */
+	bool			ts_valid;
+	unsigned		ts_x_pos;
+	unsigned		ts_y_pos;
+	unsigned		ts_pressure;
+
+	/* handle touchscreen's physical behaviour */
+	/* samples per coordinate */
+	unsigned		over_sample_cnt;
+	/* time clocks between samples */
+	unsigned		over_sample_delay;
+	/* time in clocks to wait after the plates where switched */
+	unsigned		settling_delay;
 };
 
 #define	LRADC_CTRL0				0x00
@@ -230,19 +253,33 @@ struct mxs_lradc {
 #define	LRADC_CH_ACCUMULATE			(1 << 29)
 #define	LRADC_CH_NUM_SAMPLES_MASK		(0x1f << 24)
 #define	LRADC_CH_NUM_SAMPLES_OFFSET		24
+#define	LRADC_CH_NUM_SAMPLES(x) \
+				((x) << LRADC_CH_NUM_SAMPLES_OFFSET)
 #define	LRADC_CH_VALUE_MASK			0x3ffff
 #define	LRADC_CH_VALUE_OFFSET			0
 
 #define	LRADC_DELAY(n)				(0xd0 + (0x10 * (n)))
 #define	LRADC_DELAY_TRIGGER_LRADCS_MASK		(0xff << 24)
 #define	LRADC_DELAY_TRIGGER_LRADCS_OFFSET	24
+#define	LRADC_DELAY_TRIGGER(x) \
+				(((x) << LRADC_DELAY_TRIGGER_LRADCS_OFFSET) & \
+				LRADC_DELAY_TRIGGER_LRADCS_MASK)
 #define	LRADC_DELAY_KICK			(1 << 20)
 #define	LRADC_DELAY_TRIGGER_DELAYS_MASK		(0xf << 16)
 #define	LRADC_DELAY_TRIGGER_DELAYS_OFFSET	16
+#define	LRADC_DELAY_TRIGGER_DELAYS(x) \
+				(((x) << LRADC_DELAY_TRIGGER_DELAYS_OFFSET) & \
+				LRADC_DELAY_TRIGGER_DELAYS_MASK)
 #define	LRADC_DELAY_LOOP_COUNT_MASK		(0x1f << 11)
 #define	LRADC_DELAY_LOOP_COUNT_OFFSET		11
+#define	LRADC_DELAY_LOOP(x) \
+				(((x) << LRADC_DELAY_LOOP_COUNT_OFFSET) & \
+				LRADC_DELAY_LOOP_COUNT_MASK)
 #define	LRADC_DELAY_DELAY_MASK			0x7ff
 #define	LRADC_DELAY_DELAY_OFFSET		0
+#define	LRADC_DELAY_DELAY(x) \
+				(((x) << LRADC_DELAY_DELAY_OFFSET) & \
+				LRADC_DELAY_DELAY_MASK)
 
 #define	LRADC_CTRL4				0x140
 #define	LRADC_CTRL4_LRADCSELECT_MASK(n)		(0xf << ((n) * 4))
@@ -322,6 +359,404 @@ static u32 mxs_lradc_drive_pressure(struct mxs_lradc *lradc)
 		return LRADC_CTRL0_MX28_YPPSW | LRADC_CTRL0_MX28_XNNSW;
 }
 
+static bool mxs_lradc_check_touch_event(struct mxs_lradc *lradc)
+{
+	return !!(readl(lradc->base + LRADC_STATUS) &
+					LRADC_STATUS_TOUCH_DETECT_RAW);
+}
+
+static void mxs_lradc_setup_ts_channel(struct mxs_lradc *lradc, unsigned ch)
+{
+	/*
+	 * prepare for oversampling conversion
+	 *
+	 * from the datasheet:
+	 * "The ACCUMULATE bit in the appropriate channel register
+	 * HW_LRADC_CHn must be set to 1 if NUM_SAMPLES is greater then 0;
+	 * otherwise, the IRQs will not fire."
+	 */
+	mxs_lradc_reg_wrt(lradc, LRADC_CH_ACCUMULATE |
+			LRADC_CH_NUM_SAMPLES(lradc->over_sample_cnt - 1),
+			LRADC_CH(ch));
+
+	/* from the datasheet:
+	 * "Software must clear this register in preparation for a
+	 * multi-cycle accumulation.
+	 */
+	mxs_lradc_reg_clear(lradc, LRADC_CH_VALUE_MASK, LRADC_CH(ch));
+
+	/* prepare the delay/loop unit according to the oversampling count */
+	mxs_lradc_reg_wrt(lradc, LRADC_DELAY_TRIGGER(1 << ch) |
+		LRADC_DELAY_TRIGGER_DELAYS(0) |
+		LRADC_DELAY_LOOP(lradc->over_sample_cnt - 1) |
+		LRADC_DELAY_DELAY(lradc->over_sample_delay - 1),
+			LRADC_DELAY(3));
+
+	mxs_lradc_reg_clear(lradc, LRADC_CTRL1_LRADC_IRQ(2) |
+			LRADC_CTRL1_LRADC_IRQ(3) | LRADC_CTRL1_LRADC_IRQ(4) |
+			LRADC_CTRL1_LRADC_IRQ(5), LRADC_CTRL1);
+
+	/* wake us again, when the complete conversion is done */
+	mxs_lradc_reg_set(lradc, LRADC_CTRL1_LRADC_IRQ_EN(ch), LRADC_CTRL1);
+	/*
+	 * after changing the touchscreen plates setting
+	 * the signals need some initial time to settle. Start the
+	 * SoC's delay unit and start the conversion later
+	 * and automatically.
+	 */
+	mxs_lradc_reg_wrt(lradc, LRADC_DELAY_TRIGGER(0) | /* don't trigger ADC */
+		LRADC_DELAY_TRIGGER_DELAYS(1 << 3) | /* trigger DELAY unit#3 */
+		LRADC_DELAY_KICK |
+		LRADC_DELAY_DELAY(lradc->settling_delay),
+			LRADC_DELAY(2));
+}
+
+/*
+ * Pressure detection is special:
+ * We want to do both required measurements for the pressure detection in
+ * one turn. Use the hardware features to chain both conversions and let the
+ * hardware report one interrupt if both conversions are done
+ */
+static void mxs_lradc_setup_ts_pressure(struct mxs_lradc *lradc, unsigned ch1,
+							unsigned ch2)
+{
+	u32 reg;
+
+	/*
+	 * prepare for oversampling conversion
+	 *
+	 * from the datasheet:
+	 * "The ACCUMULATE bit in the appropriate channel register
+	 * HW_LRADC_CHn must be set to 1 if NUM_SAMPLES is greater then 0;
+	 * otherwise, the IRQs will not fire."
+	 */
+	reg = LRADC_CH_ACCUMULATE |
+		LRADC_CH_NUM_SAMPLES(lradc->over_sample_cnt - 1);
+	mxs_lradc_reg_wrt(lradc, reg, LRADC_CH(ch1));
+	mxs_lradc_reg_wrt(lradc, reg, LRADC_CH(ch2));
+
+	/* from the datasheet:
+	 * "Software must clear this register in preparation for a
+	 * multi-cycle accumulation.
+	 */
+	mxs_lradc_reg_clear(lradc, LRADC_CH_VALUE_MASK, LRADC_CH(ch1));
+	mxs_lradc_reg_clear(lradc, LRADC_CH_VALUE_MASK, LRADC_CH(ch2));
+
+	/* prepare the delay/loop unit according to the oversampling count */
+	mxs_lradc_reg_wrt(lradc, LRADC_DELAY_TRIGGER(1 << ch1) |
+		LRADC_DELAY_TRIGGER(1 << ch2) | /* start both channels */
+		LRADC_DELAY_TRIGGER_DELAYS(0) |
+		LRADC_DELAY_LOOP(lradc->over_sample_cnt - 1) |
+		LRADC_DELAY_DELAY(lradc->over_sample_delay - 1),
+					LRADC_DELAY(3));
+
+	mxs_lradc_reg_clear(lradc, LRADC_CTRL1_LRADC_IRQ(2) |
+			LRADC_CTRL1_LRADC_IRQ(3) | LRADC_CTRL1_LRADC_IRQ(4) |
+			LRADC_CTRL1_LRADC_IRQ(5), LRADC_CTRL1);
+
+	/* wake us again, when the conversions are done */
+	mxs_lradc_reg_set(lradc, LRADC_CTRL1_LRADC_IRQ_EN(ch2), LRADC_CTRL1);
+	/*
+	 * after changing the touchscreen plates setting
+	 * the signals need some initial time to settle. Start the
+	 * SoC's delay unit and start the conversion later
+	 * and automatically.
+	 */
+	mxs_lradc_reg_wrt(lradc, LRADC_DELAY_TRIGGER(0) | /* don't trigger ADC */
+		LRADC_DELAY_TRIGGER_DELAYS(1 << 3) | /* trigger DELAY unit#3 */
+		LRADC_DELAY_KICK |
+		LRADC_DELAY_DELAY(lradc->settling_delay), LRADC_DELAY(2));
+}
+
+static unsigned mxs_lradc_read_raw_channel(struct mxs_lradc *lradc,
+							unsigned channel)
+{
+	u32 reg;
+	unsigned num_samples, val;
+
+	reg = readl(lradc->base + LRADC_CH(channel));
+	if (reg & LRADC_CH_ACCUMULATE)
+		num_samples = lradc->over_sample_cnt;
+	else
+		num_samples = 1;
+
+	val = (reg & LRADC_CH_VALUE_MASK) >> LRADC_CH_VALUE_OFFSET;
+	return val / num_samples;
+}
+
+static unsigned mxs_lradc_read_ts_pressure(struct mxs_lradc *lradc,
+						unsigned ch1, unsigned ch2)
+{
+	u32 reg, mask;
+	unsigned pressure, m1, m2;
+
+	mask = LRADC_CTRL1_LRADC_IRQ(ch1) | LRADC_CTRL1_LRADC_IRQ(ch2);
+	reg = readl(lradc->base + LRADC_CTRL1) & mask;
+
+	while (reg != mask) {
+		reg = readl(lradc->base + LRADC_CTRL1) & mask;
+		dev_dbg(lradc->dev, "One channel is still busy: %X\n", reg);
+	}
+
+	m1 = mxs_lradc_read_raw_channel(lradc, ch1);
+	m2 = mxs_lradc_read_raw_channel(lradc, ch2);
+
+	if (m2 == 0) {
+		dev_warn(lradc->dev, "Cannot calculate pressure\n");
+		return 1 << (LRADC_RESOLUTION - 1);
+	}
+
+	/* simply scale the value from 0 ... max ADC resolution */
+	pressure = m1;
+	pressure *= (1 << LRADC_RESOLUTION);
+	pressure /= m2;
+
+	dev_dbg(lradc->dev, "Pressure = %u\n", pressure);
+	return pressure;
+}
+
+#define TS_CH_XP 2
+#define TS_CH_YP 3
+#define TS_CH_XM 4
+#define TS_CH_YM 5
+
+static int mxs_lradc_read_ts_channel(struct mxs_lradc *lradc)
+{
+	u32 reg;
+	int val;
+
+	reg = readl(lradc->base + LRADC_CTRL1);
+
+	/* only channels 3 to 5 are of interest here */
+	if (reg & LRADC_CTRL1_LRADC_IRQ(TS_CH_YP)) {
+		mxs_lradc_reg_clear(lradc, LRADC_CTRL1_LRADC_IRQ_EN(TS_CH_YP) |
+			LRADC_CTRL1_LRADC_IRQ(TS_CH_YP), LRADC_CTRL1);
+		val = mxs_lradc_read_raw_channel(lradc, TS_CH_YP);
+	} else if (reg & LRADC_CTRL1_LRADC_IRQ(TS_CH_XM)) {
+		mxs_lradc_reg_clear(lradc, LRADC_CTRL1_LRADC_IRQ_EN(TS_CH_XM) |
+			LRADC_CTRL1_LRADC_IRQ(TS_CH_XM), LRADC_CTRL1);
+		val = mxs_lradc_read_raw_channel(lradc, TS_CH_XM);
+	} else if (reg & LRADC_CTRL1_LRADC_IRQ(TS_CH_YM)) {
+		mxs_lradc_reg_clear(lradc, LRADC_CTRL1_LRADC_IRQ_EN(TS_CH_YM) |
+			LRADC_CTRL1_LRADC_IRQ(TS_CH_YM), LRADC_CTRL1);
+		val = mxs_lradc_read_raw_channel(lradc, TS_CH_YM);
+	} else {
+		return -EIO;
+	}
+
+	mxs_lradc_reg_wrt(lradc, 0, LRADC_DELAY(2));
+	mxs_lradc_reg_wrt(lradc, 0, LRADC_DELAY(3));
+
+	return val;
+}
+
+/*
+ * YP(open)--+-------------+
+ *           |             |--+
+ *           |             |  |
+ *    YM(-)--+-------------+  |
+ *             +--------------+
+ *             |              |
+ *         XP(weak+)        XM(open)
+ *
+ * "weak+" means 200k Ohm VDDIO
+ * (-) means GND
+ */
+static void mxs_lradc_setup_touch_detection(struct mxs_lradc *lradc)
+{
+	/*
+	 * In order to detect a touch event the 'touch detect enable' bit
+	 * enables:
+	 *  - a weak pullup to the X+ connector
+	 *  - a strong ground at the Y- connector
+	 */
+	mxs_lradc_reg_clear(lradc, mxs_lradc_plate_mask(lradc), LRADC_CTRL0);
+	mxs_lradc_reg_set(lradc, mxs_lradc_touch_detect_bit(lradc),
+				LRADC_CTRL0);
+}
+
+/*
+ * YP(meas)--+-------------+
+ *           |             |--+
+ *           |             |  |
+ * YM(open)--+-------------+  |
+ *             +--------------+
+ *             |              |
+ *           XP(+)          XM(-)
+ *
+ * (+) means here 1.85 V
+ * (-) means here GND
+ */
+static void mxs_lradc_prepare_x_pos(struct mxs_lradc *lradc)
+{
+	mxs_lradc_reg_clear(lradc, mxs_lradc_plate_mask(lradc), LRADC_CTRL0);
+	mxs_lradc_reg_set(lradc, mxs_lradc_drive_x_plate(lradc), LRADC_CTRL0);
+
+	lradc->cur_plate = LRADC_SAMPLE_X;
+	mxs_lradc_setup_ts_channel(lradc, TS_CH_YP);
+}
+
+/*
+ *   YP(+)--+-------------+
+ *          |             |--+
+ *          |             |  |
+ *   YM(-)--+-------------+  |
+ *            +--------------+
+ *            |              |
+ *         XP(open)        XM(meas)
+ *
+ * (+) means here 1.85 V
+ * (-) means here GND
+ */
+static void mxs_lradc_prepare_y_pos(struct mxs_lradc *lradc)
+{
+	mxs_lradc_reg_clear(lradc, mxs_lradc_plate_mask(lradc), LRADC_CTRL0);
+	mxs_lradc_reg_set(lradc, mxs_lradc_drive_y_plate(lradc), LRADC_CTRL0);
+
+	lradc->cur_plate = LRADC_SAMPLE_Y;
+	mxs_lradc_setup_ts_channel(lradc, TS_CH_XM);
+}
+
+/*
+ *    YP(+)--+-------------+
+ *           |             |--+
+ *           |             |  |
+ * YM(meas)--+-------------+  |
+ *             +--------------+
+ *             |              |
+ *          XP(meas)        XM(-)
+ *
+ * (+) means here 1.85 V
+ * (-) means here GND
+ */
+static void mxs_lradc_prepare_pressure(struct mxs_lradc *lradc)
+{
+	mxs_lradc_reg_clear(lradc, mxs_lradc_plate_mask(lradc), LRADC_CTRL0);
+	mxs_lradc_reg_set(lradc, mxs_lradc_drive_pressure(lradc), LRADC_CTRL0);
+
+	lradc->cur_plate = LRADC_SAMPLE_PRESSURE;
+	mxs_lradc_setup_ts_pressure(lradc, TS_CH_XP, TS_CH_YM);
+}
+
+static void mxs_lradc_enable_touch_detection(struct mxs_lradc *lradc)
+{
+	mxs_lradc_setup_touch_detection(lradc);
+
+	lradc->cur_plate = LRADC_TOUCH;
+	mxs_lradc_reg_clear(lradc, LRADC_CTRL1_TOUCH_DETECT_IRQ |
+				LRADC_CTRL1_TOUCH_DETECT_IRQ_EN, LRADC_CTRL1);
+	mxs_lradc_reg_set(lradc, LRADC_CTRL1_TOUCH_DETECT_IRQ_EN, LRADC_CTRL1);
+}
+
+static void mxs_lradc_report_ts_event(struct mxs_lradc *lradc)
+{
+	input_report_abs(lradc->ts_input, ABS_X, lradc->ts_x_pos);
+	input_report_abs(lradc->ts_input, ABS_Y, lradc->ts_y_pos);
+	input_report_abs(lradc->ts_input, ABS_PRESSURE, lradc->ts_pressure);
+	input_report_key(lradc->ts_input, BTN_TOUCH, 1);
+	input_sync(lradc->ts_input);
+}
+
+static void mxs_lradc_complete_touch_event(struct mxs_lradc *lradc)
+{
+	mxs_lradc_setup_touch_detection(lradc);
+	lradc->cur_plate = LRADC_SAMPLE_VALID;
+	/*
+	 * start a dummy conversion to burn time to settle the signals
+	 * note: we are not interested in the conversion's value
+	 */
+	mxs_lradc_reg_wrt(lradc, 0, LRADC_CH(5));
+	mxs_lradc_reg_clear(lradc, LRADC_CTRL1_LRADC_IRQ(5), LRADC_CTRL1);
+	mxs_lradc_reg_set(lradc, LRADC_CTRL1_LRADC_IRQ_EN(5), LRADC_CTRL1);
+	mxs_lradc_reg_wrt(lradc, LRADC_DELAY_TRIGGER(1 << 5) |
+		LRADC_DELAY_KICK | LRADC_DELAY_DELAY(10), /* waste 5 ms */
+			LRADC_DELAY(2));
+}
+
+/*
+ * in order to avoid false measurements, report only samples where
+ * the surface is still touched after the position measurement
+ */
+static void mxs_lradc_finish_touch_event(struct mxs_lradc *lradc, bool valid)
+{
+	/* if it is still touched, report the sample */
+	if (valid && mxs_lradc_check_touch_event(lradc)) {
+		lradc->ts_valid = true;
+		mxs_lradc_report_ts_event(lradc);
+	}
+
+	/* if it is even still touched, continue with the next measurement */
+	if (mxs_lradc_check_touch_event(lradc)) {
+		mxs_lradc_prepare_y_pos(lradc);
+		return;
+	}
+
+	if (lradc->ts_valid) {
+		/* signal the release */
+		lradc->ts_valid = false;
+		input_report_key(lradc->ts_input, BTN_TOUCH, 0);
+		input_sync(lradc->ts_input);
+	}
+
+	/* if it is released, wait for the next touch via IRQ */
+	mxs_lradc_reg_clear(lradc, LRADC_CTRL1_TOUCH_DETECT_IRQ, LRADC_CTRL1);
+	mxs_lradc_reg_set(lradc, LRADC_CTRL1_TOUCH_DETECT_IRQ_EN, LRADC_CTRL1);
+}
+
+/* touchscreen's state machine */
+static void mxs_lradc_handle_touch(struct mxs_lradc *lradc)
+{
+	int val;
+
+	switch (lradc->cur_plate) {
+	case LRADC_TOUCH:
+		/*
+		 * start with the Y-pos, because it uses nearly the same plate
+		 * settings like the touch detection
+		 */
+		if (mxs_lradc_check_touch_event(lradc)) {
+			mxs_lradc_reg_clear(lradc,
+					LRADC_CTRL1_TOUCH_DETECT_IRQ_EN,
+					LRADC_CTRL1);
+			mxs_lradc_prepare_y_pos(lradc);
+		}
+		mxs_lradc_reg_clear(lradc, LRADC_CTRL1_TOUCH_DETECT_IRQ,
+					LRADC_CTRL1);
+		return;
+
+	case LRADC_SAMPLE_Y:
+		val = mxs_lradc_read_ts_channel(lradc);
+		if (val < 0) {
+			mxs_lradc_enable_touch_detection(lradc); /* re-start */
+			return;
+		}
+		lradc->ts_y_pos = val;
+		mxs_lradc_prepare_x_pos(lradc);
+		return;
+
+	case LRADC_SAMPLE_X:
+		val = mxs_lradc_read_ts_channel(lradc);
+		if (val < 0) {
+			mxs_lradc_enable_touch_detection(lradc); /* re-start */
+			return;
+		}
+		lradc->ts_x_pos = val;
+		mxs_lradc_prepare_pressure(lradc);
+		return;
+
+	case LRADC_SAMPLE_PRESSURE:
+		lradc->ts_pressure =
+			mxs_lradc_read_ts_pressure(lradc, TS_CH_XP, TS_CH_YM);
+		mxs_lradc_complete_touch_event(lradc);
+		return;
+
+	case LRADC_SAMPLE_VALID:
+		val = mxs_lradc_read_ts_channel(lradc); /* ignore the value */
+		mxs_lradc_finish_touch_event(lradc, 1);
+		break;
+	}
+}
+
 /*
  * Raw I/O operations
  */
@@ -395,15 +830,6 @@ static const struct iio_info mxs_lradc_iio_info = {
 	.read_raw		= mxs_lradc_read_raw,
 };
 
-/*
- * Touchscreen handling
- */
-enum lradc_ts_plate {
-	LRADC_SAMPLE_X,
-	LRADC_SAMPLE_Y,
-	LRADC_SAMPLE_PRESSURE,
-};
-
 static int mxs_lradc_ts_touched(struct mxs_lradc *lradc)
 {
 	uint32_t reg;
@@ -561,10 +987,6 @@ static void mxs_lradc_ts_work(struct work_struct *ts_work)
 	input_report_key(lradc->ts_input, BTN_TOUCH, 0);
 	input_sync(lradc->ts_input);
 
-	/* Do not restart the TS IRQ if the driver is shutting down. */
-	if (lradc->stop_touchscreen)
-		return;
-
 	/* Restart the touchscreen interrupts. */
 	mxs_lradc_reg_clear(lradc, LRADC_CTRL1_TOUCH_DETECT_IRQ, LRADC_CTRL1);
 	mxs_lradc_reg_set(lradc, LRADC_CTRL1_TOUCH_DETECT_IRQ_EN, LRADC_CTRL1);
@@ -574,36 +996,29 @@ static int mxs_lradc_ts_open(struct input_dev *dev)
 {
 	struct mxs_lradc *lradc = input_get_drvdata(dev);
 
-	/* The touchscreen is starting. */
-	lradc->stop_touchscreen = false;
-
 	/* Enable the touch-detect circuitry. */
-	mxs_lradc_reg_set(lradc, mxs_lradc_touch_detect_bit(lradc),
-						LRADC_CTRL0);
-
-	/* Enable the touch-detect IRQ. */
-	mxs_lradc_reg_set(lradc, LRADC_CTRL1_TOUCH_DETECT_IRQ_EN, LRADC_CTRL1);
+	mxs_lradc_enable_touch_detection(lradc);
 
 	return 0;
 }
 
-static void mxs_lradc_ts_close(struct input_dev *dev)
+static void mxs_lradc_disable_ts(struct mxs_lradc *lradc)
 {
-	struct mxs_lradc *lradc = input_get_drvdata(dev);
-
-	/* Indicate the touchscreen is stopping. */
-	lradc->stop_touchscreen = true;
-	mb();
+	/* stop all interrupts from firing */
+	mxs_lradc_reg_clear(lradc, LRADC_CTRL1_TOUCH_DETECT_IRQ_EN |
+		LRADC_CTRL1_LRADC_IRQ_EN(2) | LRADC_CTRL1_LRADC_IRQ_EN(3) |
+		LRADC_CTRL1_LRADC_IRQ_EN(4) | LRADC_CTRL1_LRADC_IRQ_EN(5),
+		LRADC_CTRL1);
 
-	/* Wait until touchscreen thread finishes any possible remnants. */
-	cancel_work_sync(&lradc->ts_work);
+	/* Power-down touchscreen touch-detect circuitry. */
+	mxs_lradc_reg_clear(lradc, mxs_lradc_plate_mask(lradc), LRADC_CTRL0);
+}
 
-	/* Disable touchscreen touch-detect IRQ. */
-	mxs_lradc_reg_clear(lradc, LRADC_CTRL1_TOUCH_DETECT_IRQ_EN,
-						LRADC_CTRL1);
+static void mxs_lradc_ts_close(struct input_dev *dev)
+{
+	struct mxs_lradc *lradc = input_get_drvdata(dev);
 
-	/* Power-down touchscreen touch-detect circuitry. */
-	mxs_lradc_reg_clear(lradc, mxs_lradc_touch_detect_bit(lradc), LRADC_CTRL0);
+	mxs_lradc_disable_ts(lradc);
 }
 
 static int mxs_lradc_ts_register(struct mxs_lradc *lradc)
@@ -649,8 +1064,7 @@ static void mxs_lradc_ts_unregister(struct mxs_lradc *lradc)
 	if (!lradc->use_touchscreen)
 		return;
 
-	cancel_work_sync(&lradc->ts_work);
-
+	mxs_lradc_disable_ts(lradc);
 	input_unregister_device(lradc->ts_input);
 }
 
@@ -663,22 +1077,17 @@ static irqreturn_t mxs_lradc_handle_irq(int irq, void *data)
 	struct mxs_lradc *lradc = iio_priv(iio);
 	unsigned long reg = readl(lradc->base + LRADC_CTRL1);
 	const uint32_t ts_irq_mask =
-		LRADC_CTRL1_TOUCH_DETECT_IRQ_EN |
-		LRADC_CTRL1_TOUCH_DETECT_IRQ;
+		LRADC_CTRL1_TOUCH_DETECT_IRQ |
+		LRADC_CTRL1_LRADC_IRQ(2) |
+		LRADC_CTRL1_LRADC_IRQ(3) |
+		LRADC_CTRL1_LRADC_IRQ(4) |
+		LRADC_CTRL1_LRADC_IRQ(5);
 
 	if (!(reg & mxs_lradc_irq_mask(lradc)))
 		return IRQ_NONE;
 
-	/*
-	 * Touchscreen IRQ handling code has priority and therefore
-	 * is placed here. In case touchscreen IRQ arrives, disable
-	 * it ASAP
-	 */
-	if (reg & LRADC_CTRL1_TOUCH_DETECT_IRQ) {
-		mxs_lradc_reg_clear(lradc, ts_irq_mask, LRADC_CTRL1);
-		if (!lradc->stop_touchscreen)
-			schedule_work(&lradc->ts_work);
-	}
+	if (lradc->use_touchscreen && (reg & ts_irq_mask))
+		mxs_lradc_handle_touch(lradc);
 
 	if (iio_buffer_enabled(iio))
 		iio_trigger_poll(iio->trig, iio_get_time_ns());
@@ -981,6 +1390,17 @@ static const struct of_device_id mxs_lradc_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, mxs_lradc_dt_ids);
 
+static int mxs_lradc_probe_touchscreen(struct mxs_lradc *lradc,
+						struct device_node *lradc_node)
+{
+	/* TODO retrieve from device tree */
+	lradc->over_sample_cnt = 4;
+	lradc->over_sample_delay = 2;
+	lradc->settling_delay = 10;
+
+	return 0;
+}
+
 static int mxs_lradc_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *of_id =
@@ -993,7 +1413,7 @@ static int mxs_lradc_probe(struct platform_device *pdev)
 	struct iio_dev *iio;
 	struct resource *iores;
 	uint32_t ts_wires = 0;
-	int ret = 0;
+	int ret = 0, touch_ret;
 	int i;
 
 	/* Allocate the IIO device. */
@@ -1016,7 +1436,7 @@ static int mxs_lradc_probe(struct platform_device *pdev)
 	lradc->clk = devm_clk_get(&pdev->dev, NULL);
 	clk_prepare_enable(lradc->clk);
 
-	INIT_WORK(&lradc->ts_work, mxs_lradc_ts_work);
+	touch_ret = mxs_lradc_probe_touchscreen(lradc, node);
 
 	/* Check if touchscreen is enabled in DT. */
 	ret = of_property_read_u32(node, "fsl,lradc-touchscreen-wires",
@@ -1079,9 +1499,11 @@ static int mxs_lradc_probe(struct platform_device *pdev)
 		goto err_dev;
 
 	/* Register the touchscreen input device. */
-	ret = mxs_lradc_ts_register(lradc);
-	if (ret)
-		goto err_dev;
+	if (touch_ret == 0) {
+		ret = mxs_lradc_ts_register(lradc);
+		if (ret)
+			goto err_dev;
+	}
 
 	/* Register IIO device. */
 	ret = iio_device_register(iio);
-- 
1.8.4.rc3

