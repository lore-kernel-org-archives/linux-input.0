From: Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH 12/14] iio: adc: at91-sama5d2_adc: support for position and pressure channels
Date: Fri, 22 Dec 2017 17:07:19 +0200
Message-ID: <1513955241-10985-13-git-send-email-eugen.hristev@microchip.com>
References: <1513955241-10985-1-git-send-email-eugen.hristev@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1513955241-10985-1-git-send-email-eugen.hristev@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: nicolas.ferre@microchip.com, ludovic.desroches@microchip.com, alexandre.belloni@free-electrons.com, linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, jic23@kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: Eugen Hristev <eugen.hristev@microchip.com>
List-Id: linux-input@vger.kernel.org

The ADC IP supports position and pressure measurements for a touchpad
connected on channels 0,1,2,3 for a 4-wire touchscreen with pressure
measurement support.
Using the inkern API, a driver can request a trigger and read the
channel values from the ADC.
The implementation provides a trigger named "touch" which can be
connected to a consumer driver.
Once a driver connects and attaches a pollfunc to this trigger, the
configure trigger callback is called, and then the ADC driver will
initialize pad measurement.
First step is to enable touchscreen 4wire support and enable
pen detect IRQ.
Once a pen is detected, a periodic trigger is setup to trigger every
2 ms (e.g.) and sample the resistive touchscreen values. The trigger poll
is called, and the consumer driver is then woke up, and it can read the
respective channels for the values : X, and Y for position and pressure
channel.
Because only one trigger can be active in hardware in the same time,
while touching the pad, the ADC will block any attempt to use the
triggered buffer. Same, conversions using the software trigger are also
impossible (since the periodic trigger is setup).
If some driver wants to attach while the trigger is in use, it will
also fail.
Once the pen is not detected anymore, the trigger is free for use (hardware
or software trigger, with or without DMA).
Channels 0,1,2 and 3 are unavailable if a touchscreen is enabled.

Some parts of this patch are based on initial original work by
Mohamed Jamsheeth Hajanajubudeen and Bandaru Venkateswara Swamy

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 455 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 446 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 9610393..79eb197 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -102,14 +102,26 @@
 #define AT91_SAMA5D2_LCDR	0x20
 /* Interrupt Enable Register */
 #define AT91_SAMA5D2_IER	0x24
+/* Interrupt Enable Register - TS X measurement ready */
+#define AT91_SAMA5D2_IER_XRDY   BIT(20)
+/* Interrupt Enable Register - TS Y measurement ready */
+#define AT91_SAMA5D2_IER_YRDY   BIT(21)
+/* Interrupt Enable Register - TS pressure measurement ready */
+#define AT91_SAMA5D2_IER_PRDY   BIT(22)
 /* Interrupt Enable Register - general overrun error */
 #define AT91_SAMA5D2_IER_GOVRE BIT(25)
+/* Interrupt Enable Register - Pen detect */
+#define AT91_SAMA5D2_IER_PEN    BIT(29)
+/* Interrupt Enable Register - No pen detect */
+#define AT91_SAMA5D2_IER_NOPEN  BIT(30)
 /* Interrupt Disable Register */
 #define AT91_SAMA5D2_IDR	0x28
 /* Interrupt Mask Register */
 #define AT91_SAMA5D2_IMR	0x2c
 /* Interrupt Status Register */
 #define AT91_SAMA5D2_ISR	0x30
+/* Interrupt Status Register - Pen touching sense status */
+#define AT91_SAMA5D2_ISR_PENS   BIT(31)
 /* Last Channel Trigger Mode Register */
 #define AT91_SAMA5D2_LCTMR	0x34
 /* Last Channel Compare Window Register */
@@ -131,8 +143,37 @@
 #define AT91_SAMA5D2_CDR0	0x50
 /* Analog Control Register */
 #define AT91_SAMA5D2_ACR	0x94
+/* Analog Control Register - Pen detect sensitivity mask */
+#define AT91_SAMA5D2_ACR_PENDETSENS_MASK        GENMASK(0, 1)
 /* Touchscreen Mode Register */
 #define AT91_SAMA5D2_TSMR	0xb0
+/* Touchscreen Mode Register - No touch mode */
+#define AT91_SAMA5D2_TSMR_TSMODE_NONE           0
+/* Touchscreen Mode Register - 4 wire screen, no pressure measurement */
+#define AT91_SAMA5D2_TSMR_TSMODE_4WIRE_NO_PRESS 1
+/* Touchscreen Mode Register - 4 wire screen, pressure measurement */
+#define AT91_SAMA5D2_TSMR_TSMODE_4WIRE_PRESS    2
+/* Touchscreen Mode Register - 5 wire screen */
+#define AT91_SAMA5D2_TSMR_TSMODE_5WIRE          3
+/* Touchscreen Mode Register - Average samples mask */
+#define AT91_SAMA5D2_TSMR_TSAV_MASK		(3 << 4)
+/* Touchscreen Mode Register - Average samples */
+#define AT91_SAMA5D2_TSMR_TSAV(x)		((x) << 4)
+/* Touchscreen Mode Register - Touch/trigger frequency ratio mask */
+#define AT91_SAMA5D2_TSMR_TSFREQ_MASK		(0xf << 8)
+/* Touchscreen Mode Register - Touch/trigger freqency ratio */
+#define AT91_SAMA5D2_TSMR_TSFREQ(x)		((x) << 8)
+/* Touchscreen Mode Register - Pen Debounce Time mask */
+#define AT91_SAMA5D2_TSMR_PENDBC_MASK		(0xf << 28)
+/* Touchscreen Mode Register - Pen Debounce Time */
+#define AT91_SAMA5D2_TSMR_PENDBC(x)            ((x) << 28)
+/* Touchscreen Mode Register - No DMA for touch measurements */
+#define AT91_SAMA5D2_TSMR_NOTSDMA               BIT(22)
+/* Touchscreen Mode Register - Disable pen detection */
+#define AT91_SAMA5D2_TSMR_PENDET_DIS            (0 << 24)
+/* Touchscreen Mode Register - Enable pen detection */
+#define AT91_SAMA5D2_TSMR_PENDET_ENA            BIT(24)
+
 /* Touchscreen X Position Register */
 #define AT91_SAMA5D2_XPOSR	0xb4
 /* Touchscreen Y Position Register */
@@ -151,7 +192,12 @@
 #define AT91_SAMA5D2_TRGR_TRGMOD_EXT_TRIG_FALL 2
 /* Trigger Mode external trigger any edge */
 #define AT91_SAMA5D2_TRGR_TRGMOD_EXT_TRIG_ANY 3
-
+/* Trigger Mode internal periodic */
+#define AT91_SAMA5D2_TRGR_TRGMOD_PERIODIC 5
+/* Trigger Mode - trigger period mask */
+#define AT91_SAMA5D2_TRGR_TRGPER_MASK		(0xffff << 16)
+/* Trigger Mode - trigger period */
+#define AT91_SAMA5D2_TRGR_TRGPER(x)		((x) << 16)
 /* Correction Select Register */
 #define AT91_SAMA5D2_COSR	0xd0
 /* Correction Value Register */
@@ -169,6 +215,21 @@
 #define AT91_SAMA5D2_SINGLE_CHAN_CNT 12
 #define AT91_SAMA5D2_DIFF_CHAN_CNT 6
 
+#define AT91_SAMA5D2_TIMESTAMP_CHAN_IDX	(AT91_SAMA5D2_SINGLE_CHAN_CNT + \
+					AT91_SAMA5D2_DIFF_CHAN_CNT + 1)
+
+#define AT91_SAMA5D2_TOUCH_X_CHAN_IDX	(AT91_SAMA5D2_TIMESTAMP_CHAN_IDX + 1)
+#define AT91_SAMA5D2_TOUCH_Y_CHAN_IDX	(AT91_SAMA5D2_TOUCH_X_CHAN_IDX + 1)
+#define AT91_SAMA5D2_TOUCH_P_CHAN_IDX	(AT91_SAMA5D2_TOUCH_Y_CHAN_IDX + 1)
+
+#define TOUCH_SAMPLE_PERIOD_US          2000    /* 2ms */
+#define TOUCH_PEN_DETECT_DEBOUNCE_US    200
+
+#define XYZ_MASK			GENMASK(11, 0)
+
+#define MAX_POS_BITS			12
+
+#define AT91_ADC_TOUCH_TRIG_SHORTNAME	"touch"
 /*
  * Maximum number of bytes to hold conversion from all channels
  * without the timestamp.
@@ -222,6 +283,37 @@
 		.indexed = 1,						\
 	}
 
+#define AT91_SAMA5D2_CHAN_TOUCH(num, name, mod)				\
+	{								\
+		.type = IIO_POSITION,					\
+		.modified = 1,						\
+		.channel = num,						\
+		.channel2 = mod,					\
+		.scan_index = num,					\
+		.scan_type = {						\
+			.sign = 'u',					\
+			.realbits = 12,					\
+			.storagebits = 16,				\
+		},							\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),\
+		.datasheet_name = name,					\
+	}
+#define AT91_SAMA5D2_CHAN_PRESSURE(num, name)				\
+	{								\
+		.type = IIO_PRESSURE,					\
+		.channel = num,						\
+		.scan_index = num,					\
+		.scan_type = {						\
+			.sign = 'u',					\
+			.realbits = 12,					\
+			.storagebits = 16,				\
+		},							\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),\
+		.datasheet_name = name,					\
+	}
+
 #define at91_adc_readl(st, reg)		readl_relaxed(st->base + reg)
 #define at91_adc_writel(st, reg, val)	writel_relaxed(val, st->base + reg)
 
@@ -239,6 +331,20 @@ struct at91_adc_trigger {
 };
 
 /**
+ * at91_adc_touch - at91-sama5d2 touchscreen information struct
+ * @trig:			hold the start timestamp of dma operation
+ * @sample_period_val:		the value for periodic trigger interval
+ * @touching:			is the pen touching the screen or not
+ * @x_pos:			temporary placeholder for pressure computation
+ */
+struct at91_adc_touch {
+	struct iio_trigger		*trig;
+	u16				sample_period_val;
+	bool				touching;
+	u32				x_pos;
+};
+
+/**
  * at91_adc_dma - at91-sama5d2 dma information struct
  * @dma_chan:		the dma channel acquired
  * @rx_buf:		dma coherent allocated area
@@ -267,18 +373,22 @@ struct at91_adc_state {
 	struct regulator		*reg;
 	struct regulator		*vref;
 	int				vref_uv;
+	unsigned int			current_sample_rate;
 	struct iio_trigger		*trig;
 	const struct at91_adc_trigger	*selected_trig;
 	const struct iio_chan_spec	*chan;
 	bool				conversion_done;
 	u32				conversion_value;
+	bool				touch_requested;
 	struct at91_adc_soc_info	soc_info;
 	wait_queue_head_t		wq_data_available;
 	struct at91_adc_dma		dma_st;
+	struct at91_adc_touch		touch_st;
 	u16				buffer[AT91_BUFFER_MAX_HWORDS];
 	/*
 	 * lock to prevent concurrent 'single conversion' requests through
-	 * sysfs.
+	 * sysfs. Also protects when enabling or disabling touchscreen
+	 * producer mode and checking if this mode is enabled or not.
 	 */
 	struct mutex			lock;
 };
@@ -310,6 +420,7 @@ static const struct at91_adc_trigger at91_adc_trigger_list[] = {
 	},
 };
 
+/* channel order is not subject to change. inkern consumers rely on this */
 static const struct iio_chan_spec at91_adc_channels[] = {
 	AT91_SAMA5D2_CHAN_SINGLE(0, 0x50),
 	AT91_SAMA5D2_CHAN_SINGLE(1, 0x54),
@@ -329,10 +440,103 @@ static const struct iio_chan_spec at91_adc_channels[] = {
 	AT91_SAMA5D2_CHAN_DIFF(6, 7, 0x68),
 	AT91_SAMA5D2_CHAN_DIFF(8, 9, 0x70),
 	AT91_SAMA5D2_CHAN_DIFF(10, 11, 0x78),
-	IIO_CHAN_SOFT_TIMESTAMP(AT91_SAMA5D2_SINGLE_CHAN_CNT
-				+ AT91_SAMA5D2_DIFF_CHAN_CNT + 1),
+	IIO_CHAN_SOFT_TIMESTAMP(AT91_SAMA5D2_TIMESTAMP_CHAN_IDX),
+	AT91_SAMA5D2_CHAN_TOUCH(AT91_SAMA5D2_TOUCH_X_CHAN_IDX, "x", IIO_MOD_X),
+	AT91_SAMA5D2_CHAN_TOUCH(AT91_SAMA5D2_TOUCH_Y_CHAN_IDX, "y", IIO_MOD_Y),
+	AT91_SAMA5D2_CHAN_PRESSURE(AT91_SAMA5D2_TOUCH_P_CHAN_IDX, "pressure"),
 };
 
+static int at91_adc_configure_touch(struct at91_adc_state *st, bool state)
+{
+	u32 clk_khz = st->current_sample_rate / 1000;
+	int i = 0;
+	u16 pendbc;
+	u32 tsmr, acr;
+
+	if (!state) {
+		/* disabling touch IRQs and setting mode to no touch enabled */
+		at91_adc_writel(st, AT91_SAMA5D2_IDR,
+				AT91_SAMA5D2_IER_PEN | AT91_SAMA5D2_IER_NOPEN);
+		at91_adc_writel(st, AT91_SAMA5D2_TSMR, 0);
+		return 0;
+	}
+	/*
+	 * debounce time is in microseconds, we need it in milliseconds to
+	 * multiply with kilohertz, so, divide by 1000, but after the multiply.
+	 * round up to make sure pendbc is at least 1
+	 */
+	pendbc = round_up(TOUCH_PEN_DETECT_DEBOUNCE_US * clk_khz / 1000, 1);
+
+	/* get the required exponent */
+	while (pendbc >> i++)
+		;
+
+	pendbc = i;
+
+	tsmr = AT91_SAMA5D2_TSMR_TSMODE_4WIRE_PRESS;
+
+	tsmr |= AT91_SAMA5D2_TSMR_TSAV(1) & AT91_SAMA5D2_TSMR_TSAV_MASK;
+	tsmr |= AT91_SAMA5D2_TSMR_PENDBC(pendbc) &
+		AT91_SAMA5D2_TSMR_PENDBC_MASK;
+	tsmr |= AT91_SAMA5D2_TSMR_NOTSDMA;
+	tsmr |= AT91_SAMA5D2_TSMR_PENDET_ENA;
+	tsmr |= AT91_SAMA5D2_TSMR_TSFREQ(1) & AT91_SAMA5D2_TSMR_TSFREQ_MASK;
+
+	at91_adc_writel(st, AT91_SAMA5D2_TSMR, tsmr);
+
+	acr =  at91_adc_readl(st, AT91_SAMA5D2_ACR);
+	acr &= ~AT91_SAMA5D2_ACR_PENDETSENS_MASK;
+	acr |= 0x02 & AT91_SAMA5D2_ACR_PENDETSENS_MASK;
+	at91_adc_writel(st, AT91_SAMA5D2_ACR, acr);
+
+	/* Sample Period Time = (TRGPER + 1) / ADCClock */
+	st->touch_st.sample_period_val = round_up((TOUCH_SAMPLE_PERIOD_US *
+					 clk_khz / 1000) - 1, 1);
+	/* enable pen detect IRQ */
+	at91_adc_writel(st, AT91_SAMA5D2_IER, AT91_SAMA5D2_IER_PEN);
+
+	return 0;
+}
+
+static int at91_adc_touch_trigger_validate_device(struct iio_trigger *trig,
+						  struct iio_dev *indio_dev)
+{
+	/* the touch trigger cannot be used with a buffer */
+	return -EBUSY;
+}
+
+static int at91_adc_configure_touch_trigger(struct iio_trigger *trig,
+					    bool state)
+{
+	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
+	struct at91_adc_state *st = iio_priv(indio_dev);
+	int ret = 0;
+
+	/*
+	 * If we configure this with the IRQ enabled, the pen detected IRQ
+	 * might fire before we finish setting all up, and the IRQ handler
+	 * might misbehave. Better to reenable the IRQ after we are done
+	 */
+	disable_irq_nosync(st->irq);
+
+	mutex_lock(&st->lock);
+	if (state) {
+		ret = iio_buffer_enabled(indio_dev);
+		if (ret) {
+			dev_dbg(&indio_dev->dev, "trigger is currently in use\n");
+			ret = -EBUSY;
+			goto configure_touch_unlock_exit;
+		}
+	}
+	at91_adc_configure_touch(st, state);
+	st->touch_requested = state;
+
+configure_touch_unlock_exit:
+	enable_irq(st->irq);
+	mutex_unlock(&st->lock);
+	return ret;
+}
+
 static int at91_adc_configure_trigger(struct iio_trigger *trig, bool state)
 {
 	struct iio_dev *indio = iio_trigger_get_drvdata(trig);
@@ -390,12 +594,27 @@ static int at91_adc_reenable_trigger(struct iio_trigger *trig)
 	return 0;
 }
 
+static int at91_adc_reenable_touch_trigger(struct iio_trigger *trig)
+{
+	struct iio_dev *indio = iio_trigger_get_drvdata(trig);
+	struct at91_adc_state *st = iio_priv(indio);
+
+	enable_irq(st->irq);
+
+	return 0;
+}
 static const struct iio_trigger_ops at91_adc_trigger_ops = {
 	.set_trigger_state = &at91_adc_configure_trigger,
 	.try_reenable = &at91_adc_reenable_trigger,
 	.validate_device = iio_trigger_validate_own_device,
 };
 
+static const struct iio_trigger_ops at91_adc_touch_trigger_ops = {
+	.set_trigger_state = &at91_adc_configure_touch_trigger,
+	.try_reenable = &at91_adc_reenable_touch_trigger,
+	.validate_device = &at91_adc_touch_trigger_validate_device,
+};
+
 static int at91_adc_dma_size_done(struct at91_adc_state *st)
 {
 	struct dma_tx_state state;
@@ -490,6 +709,23 @@ static int at91_adc_dma_start(struct iio_dev *indio_dev)
 	return 0;
 }
 
+static int at91_adc_buffer_preenable(struct iio_dev *indio_dev)
+{
+	struct at91_adc_state *st = iio_priv(indio_dev);
+	int ret;
+
+	/* have to make sure nobody is requesting the trigger right now */
+	mutex_lock(&st->lock);
+	ret = st->touch_requested;
+	mutex_unlock(&st->lock);
+
+	/*
+	 * if the trigger is used by the touchscreen,
+	 * we must return an error
+	 */
+	return ret ? -EBUSY : 0;
+}
+
 static int at91_adc_buffer_postenable(struct iio_dev *indio_dev)
 {
 	int ret;
@@ -538,6 +774,7 @@ static int at91_adc_buffer_predisable(struct iio_dev *indio_dev)
 }
 
 static const struct iio_buffer_setup_ops at91_buffer_setup_ops = {
+	.preenable = &at91_adc_buffer_preenable,
 	.postenable = &at91_adc_buffer_postenable,
 	.predisable = &at91_adc_buffer_predisable,
 };
@@ -555,7 +792,11 @@ static struct iio_trigger *at91_adc_allocate_trigger(struct iio_dev *indio,
 
 	trig->dev.parent = indio->dev.parent;
 	iio_trigger_set_drvdata(trig, indio);
-	trig->ops = &at91_adc_trigger_ops;
+
+	if (strcmp(trigger_name, AT91_ADC_TOUCH_TRIG_SHORTNAME))
+		trig->ops = &at91_adc_trigger_ops;
+	else
+		trig->ops = &at91_adc_touch_trigger_ops;
 
 	ret = devm_iio_trigger_register(&indio->dev, trig);
 	if (ret)
@@ -571,7 +812,16 @@ static int at91_adc_trigger_init(struct iio_dev *indio)
 	st->trig = at91_adc_allocate_trigger(indio, st->selected_trig->name);
 	if (IS_ERR(st->trig)) {
 		dev_err(&indio->dev,
-			"could not allocate trigger\n");
+			"could not allocate trigger %s\n",
+			 st->selected_trig->name);
+		return PTR_ERR(st->trig);
+	}
+
+	st->touch_st.trig = at91_adc_allocate_trigger(indio,
+						AT91_ADC_TOUCH_TRIG_SHORTNAME);
+	if (IS_ERR(st->trig)) {
+		dev_err(&indio->dev, "could not allocate trigger"
+			AT91_ADC_TOUCH_TRIG_SHORTNAME "\n");
 		return PTR_ERR(st->trig);
 	}
 
@@ -703,6 +953,8 @@ static void at91_adc_setup_samp_freq(struct at91_adc_state *st, unsigned freq)
 
 	dev_dbg(&indio_dev->dev, "freq: %u, startup: %u, prescal: %u\n",
 		freq, startup, prescal);
+
+	st->current_sample_rate = freq;
 }
 
 static unsigned at91_adc_get_sample_freq(struct at91_adc_state *st)
@@ -718,23 +970,77 @@ static unsigned at91_adc_get_sample_freq(struct at91_adc_state *st)
 	return f_adc;
 }
 
+static irqreturn_t at91_adc_pen_detect_interrupt(struct at91_adc_state *st)
+{
+	at91_adc_writel(st, AT91_SAMA5D2_IDR, AT91_SAMA5D2_IER_PEN);
+	at91_adc_writel(st, AT91_SAMA5D2_IER, AT91_SAMA5D2_IER_NOPEN |
+			AT91_SAMA5D2_IER_XRDY | AT91_SAMA5D2_IER_YRDY |
+			AT91_SAMA5D2_IER_PRDY);
+	at91_adc_writel(st, AT91_SAMA5D2_TRGR,
+			AT91_SAMA5D2_TRGR_TRGMOD_PERIODIC |
+			AT91_SAMA5D2_TRGR_TRGPER(st->touch_st.sample_period_val));
+	st->touch_st.touching = true;
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t at91_adc_no_pen_detect_interrupt(struct at91_adc_state *st)
+{
+	at91_adc_writel(st, AT91_SAMA5D2_TRGR, 0);
+	at91_adc_writel(st, AT91_SAMA5D2_IDR, AT91_SAMA5D2_IER_NOPEN |
+			AT91_SAMA5D2_IER_XRDY | AT91_SAMA5D2_IER_YRDY |
+			AT91_SAMA5D2_IER_PRDY);
+	st->touch_st.touching = false;
+
+	disable_irq_nosync(st->irq);
+	iio_trigger_poll(st->touch_st.trig);
+
+	at91_adc_writel(st, AT91_SAMA5D2_IER, AT91_SAMA5D2_IER_PEN);
+
+	return IRQ_HANDLED;
+}
+
 static irqreturn_t at91_adc_interrupt(int irq, void *private)
 {
 	struct iio_dev *indio = private;
 	struct at91_adc_state *st = iio_priv(indio);
 	u32 status = at91_adc_readl(st, AT91_SAMA5D2_ISR);
 	u32 imr = at91_adc_readl(st, AT91_SAMA5D2_IMR);
+	u32 rdy_mask = AT91_SAMA5D2_IER_XRDY | AT91_SAMA5D2_IER_YRDY |
+			AT91_SAMA5D2_IER_PRDY;
 
 	if (!(status & imr))
 		return IRQ_NONE;
 
-	if (iio_buffer_enabled(indio) && !st->dma_st.dma_chan) {
+	if (st->touch_requested && (status & AT91_SAMA5D2_IER_PEN)) {
+		/* pen detected IRQ */
+		return at91_adc_pen_detect_interrupt(st);
+	} else if (st->touch_requested && (status & AT91_SAMA5D2_IER_NOPEN)) {
+		/* nopen detected IRQ */
+		return at91_adc_no_pen_detect_interrupt(st);
+	} else if (st->touch_requested && (status & AT91_SAMA5D2_ISR_PENS) &&
+		   ((status & rdy_mask) == rdy_mask)) {
+		/* periodic trigger IRQ - during pen sense */
+		disable_irq_nosync(irq);
+		iio_trigger_poll(st->touch_st.trig);
+	} else if ((st->touch_requested && (status & AT91_SAMA5D2_ISR_PENS))) {
+		/*
+		 * touching, but the measurements are not ready yet.
+		 * read and ignore.
+		 */
+		status = at91_adc_readl(st, AT91_SAMA5D2_XPOSR);
+		status = at91_adc_readl(st, AT91_SAMA5D2_YPOSR);
+		status = at91_adc_readl(st, AT91_SAMA5D2_PRESSR);
+	} else if (iio_buffer_enabled(indio) && !st->dma_st.dma_chan) {
+		/* buffered trigger without DMA */
 		disable_irq_nosync(irq);
 		iio_trigger_poll(indio->trig);
 	} else if (iio_buffer_enabled(indio) && st->dma_st.dma_chan) {
+		/* buffered trigger with DMA - should not happen */
 		disable_irq_nosync(irq);
 		WARN(true, "Unexpected irq occurred\n");
 	} else if (!iio_buffer_enabled(indio)) {
+		/* software requested conversion */
 		st->conversion_value = at91_adc_readl(st, st->chan->address);
 		st->conversion_done = true;
 		wake_up_interruptible(&st->wq_data_available);
@@ -742,6 +1048,96 @@ static irqreturn_t at91_adc_interrupt(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
+static u32 at91_adc_touch_x_pos(struct at91_adc_state *st)
+{
+	u32 xscale, val;
+	u32 x, xpos;
+
+	/* x position = (x / xscale) * max, max = 2^MAX_POS_BITS - 1 */
+	val = at91_adc_readl(st, AT91_SAMA5D2_XPOSR);
+	if (!val)
+		dev_dbg(&iio_priv_to_dev(st)->dev, "x_pos is 0\n");
+
+	xpos = val & XYZ_MASK;
+	x = (xpos << MAX_POS_BITS) - xpos;
+	xscale = (val >> 16) & XYZ_MASK;
+	if (xscale == 0) {
+		dev_err(&iio_priv_to_dev(st)->dev, "xscale is 0\n");
+		return 0;
+	}
+	x /= xscale;
+	st->touch_st.x_pos = x;
+
+	return x;
+}
+
+static u32 at91_adc_touch_y_pos(struct at91_adc_state *st)
+{
+	u32 yscale, val;
+	u32 y, ypos;
+
+	/* y position = (y / yscale) * max, max = 2^MAX_POS_BITS - 1 */
+	val = at91_adc_readl(st, AT91_SAMA5D2_YPOSR);
+	ypos = val & XYZ_MASK;
+	y = (ypos << MAX_POS_BITS) - ypos;
+	yscale = (val >> 16) & XYZ_MASK;
+
+	if (yscale == 0)
+		return 0;
+
+	y /= yscale;
+
+	return y;
+}
+
+static u32 at91_adc_touch_pressure(struct at91_adc_state *st)
+{
+	u32 val, z1, z2;
+	u32 pres;
+	u32 rxp = 1;
+	u32 factor = 1000;
+
+	/* calculate the pressure */
+	val = at91_adc_readl(st, AT91_SAMA5D2_PRESSR);
+	z1 = val & XYZ_MASK;
+	z2 = (val >> 16) & XYZ_MASK;
+
+	if (z1 != 0)
+		pres = rxp * (st->touch_st.x_pos * factor / 1024) *
+			(z2 * factor / z1 - factor) /
+			factor;
+	else
+		pres = 0xFFFFFFFF;       /* no pen contact */
+
+	return pres;
+}
+
+static int at91_adc_read_position(struct at91_adc_state *st, int chan, int *val)
+{
+	if (!st->touch_st.touching)
+		return -ENODATA;
+	if (chan == AT91_SAMA5D2_TOUCH_X_CHAN_IDX)
+		*val = at91_adc_touch_x_pos(st);
+	else if (chan == AT91_SAMA5D2_TOUCH_Y_CHAN_IDX)
+		*val = at91_adc_touch_y_pos(st);
+	else
+		return -ENODATA;
+
+	return IIO_VAL_INT;
+}
+
+static int at91_adc_read_pressure(struct at91_adc_state *st, int chan, int *val)
+{
+	if (!st->touch_st.touching)
+		return -ENODATA;
+	if (chan == AT91_SAMA5D2_TOUCH_P_CHAN_IDX)
+		*val = at91_adc_touch_pressure(st);
+	else
+		return -ENODATA;
+
+	return IIO_VAL_INT;
+}
+
 static int at91_adc_read_raw(struct iio_dev *indio_dev,
 			     struct iio_chan_spec const *chan,
 			     int *val, int *val2, long mask)
@@ -752,11 +1148,38 @@ static int at91_adc_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
+		mutex_lock(&st->lock);
+
+		if (chan->type == IIO_POSITION) {
+			ret = at91_adc_read_position(st, chan->channel, val);
+			mutex_unlock(&st->lock);
+			return ret;
+		}
+		if (chan->type == IIO_PRESSURE) {
+			ret = at91_adc_read_pressure(st, chan->channel, val);
+			mutex_unlock(&st->lock);
+			return ret;
+		}
+		/* if we using touch, channels 0, 1, 2, 3 are unavailable */
+		if (st->touch_requested && chan->channel <= 3) {
+			mutex_unlock(&st->lock);
+			return -EBUSY;
+		}
+		/*
+		 * if we have the periodic trigger set up, we can't use
+		 * software trigger either.
+		 */
+		if (st->touch_st.touching) {
+			mutex_unlock(&st->lock);
+			return -ENODATA;
+		}
+
 		/* we cannot use software trigger if hw trigger enabled */
 		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
+		if (ret) {
+			mutex_unlock(&st->lock);
 			return ret;
-		mutex_lock(&st->lock);
+		}
 
 		st->chan = chan;
 
@@ -785,6 +1208,11 @@ static int at91_adc_read_raw(struct iio_dev *indio_dev,
 
 		at91_adc_writel(st, AT91_SAMA5D2_IDR, BIT(chan->channel));
 		at91_adc_writel(st, AT91_SAMA5D2_CHDR, BIT(chan->channel));
+		/*
+		 * It is possible that after this conversion, we reuse these
+		 * channels for the touchscreen. So, reset the COR now.
+		 */
+		at91_adc_writel(st, AT91_SAMA5D2_COR, 0);
 
 		/* Needed to ACK the DRDY interruption */
 		at91_adc_readl(st, AT91_SAMA5D2_LCDR);
@@ -1180,6 +1608,10 @@ static int at91_adc_remove(struct platform_device *pdev)
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct at91_adc_state *st = iio_priv(indio_dev);
 
+	mutex_lock(&st->lock);
+	devm_iio_trigger_unregister(&indio_dev->dev, st->touch_st.trig);
+	mutex_unlock(&st->lock);
+
 	if (st->selected_trig->hw_trig)
 		devm_iio_trigger_unregister(&indio_dev->dev, st->trig);
 
@@ -1245,6 +1677,11 @@ static __maybe_unused int at91_adc_resume(struct device *dev)
 	if (iio_buffer_enabled(indio_dev))
 		at91_adc_configure_trigger(st->trig, true);
 
+	mutex_lock(&st->lock);
+	if (st->touch_requested)
+		at91_adc_configure_touch_trigger(st->touch_st.trig, true);
+	mutex_unlock(&st->lock);
+
 	return 0;
 
 vref_disable_resume:
-- 
2.7.4
