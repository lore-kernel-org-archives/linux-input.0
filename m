From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: [PATCH 21/22] iio/ti_am335x_adc: Allow to specify input line
Date: Wed,  5 Jun 2013 18:24:54 +0200
Message-ID: <1370449495-29981-22-git-send-email-bigeasy@linutronix.de>
References: <1370449495-29981-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1370449495-29981-1-git-send-email-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

The TSC part allows to specify the input lines. The IIO part assumes
that it usues always the last few, that means if IIO has adc-channels
set to 2 it will use channel 6 and 7. However it might make sense to use
only 6.
This patch changes the device property (which was introduced recently
and was never in an official release) in a way that the user can specify
which of the AIN lines should be used. In Addition to this, the name is
now AINx where x is the channel number i.e. for AIN6 we would have 6.
Prior this, it always started counting at 0 which is confusing. In
addition to this, it also checks for correct step number during reading
and does not rely on proper FIFO depth.

Acked-by: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
---
 arch/arm/boot/dts/am335x-evm.dts |    2 +-
 drivers/iio/adc/ti_am335x_adc.c  |   59 +++++++++++++++++++++++++-------------
 drivers/mfd/ti_am335x_tscadc.c   |   20 +++++++++++--
 3 files changed, 58 insertions(+), 23 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 26fea97..0fa4c7f 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -255,6 +255,6 @@
 	};
 
 	adc {
-		ti,adc-channels = <4>;
+		ti,adc-channels = <4 5 6 7>;
 	};
 };
diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index 031f8e5..4bf34f2 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -32,6 +32,8 @@
 struct tiadc_device {
 	struct ti_tscadc_dev *mfd_tscadc;
 	int channels;
+	u8 channel_line[8];
+	u8 channel_step[8];
 	struct iio_map *map;
 };
 
@@ -58,7 +60,7 @@ static u32 get_adc_step_mask(struct tiadc_device *adc_dev)
 static void tiadc_step_config(struct tiadc_device *adc_dev)
 {
 	unsigned int stepconfig;
-	int i, channels = 0, steps;
+	int i, steps;
 	u32 step_en;
 
 	/*
@@ -72,16 +74,18 @@ static void tiadc_step_config(struct tiadc_device *adc_dev)
 	 */
 
 	steps = TOTAL_STEPS - adc_dev->channels;
-	channels = TOTAL_CHANNELS - adc_dev->channels;
-
 	stepconfig = STEPCONFIG_AVG_16 | STEPCONFIG_FIFO1;
 
-	for (i = steps; i < TOTAL_STEPS; i++) {
-		tiadc_writel(adc_dev, REG_STEPCONFIG(i),
-				stepconfig | STEPCONFIG_INP(channels));
-		tiadc_writel(adc_dev, REG_STEPDELAY(i),
+	for (i = 0; i < adc_dev->channels; i++) {
+		int chan;
+
+		chan = adc_dev->channel_line[i];
+		tiadc_writel(adc_dev, REG_STEPCONFIG(steps),
+				stepconfig | STEPCONFIG_INP(chan));
+		tiadc_writel(adc_dev, REG_STEPDELAY(steps),
 				STEPCONFIG_OPENDLY);
-		channels++;
+		adc_dev->channel_step[i] = steps;
+		steps++;
 	}
 	step_en = get_adc_step_mask(adc_dev);
 	am335x_tsc_se_set(adc_dev->mfd_tscadc, step_en);
@@ -116,9 +120,9 @@ static int tiadc_channel_init(struct iio_dev *indio_dev, int channels)
 
 		chan->type = IIO_VOLTAGE;
 		chan->indexed = 1;
-		chan->channel = i;
+		chan->channel = adc_dev->channel_line[i];
 		chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
-		chan->datasheet_name = chan_name_ain[i];
+		chan->datasheet_name = chan_name_ain[chan->channel];
 		chan->scan_type.sign = 'u';
 		chan->scan_type.realbits = 12;
 		chan->scan_type.storagebits = 32;
@@ -165,7 +169,8 @@ static int tiadc_read_raw(struct iio_dev *indio_dev,
 {
 	struct tiadc_device *adc_dev = iio_priv(indio_dev);
 	int i;
-	unsigned int fifo1count, readx1;
+	unsigned int fifo1count, read;
+	u32 step = UINT_MAX;
 
 	/*
 	 * When the sub-system is first enabled,
@@ -178,11 +183,20 @@ static int tiadc_read_raw(struct iio_dev *indio_dev,
 	 * Hence we need to flush out this data.
 	 */
 
+	for (i = 0; i < ARRAY_SIZE(adc_dev->channel_step); i++) {
+		if (chan->channel == adc_dev->channel_line[i]) {
+			step = adc_dev->channel_step[i];
+			break;
+		}
+	}
+	if (WARN_ON_ONCE(step == UINT_MAX))
+		return -EINVAL;
+
 	fifo1count = tiadc_readl(adc_dev, REG_FIFO1CNT);
 	for (i = 0; i < fifo1count; i++) {
-		readx1 = tiadc_readl(adc_dev, REG_FIFO1);
-		if (i == chan->channel)
-			*val = readx1 & 0xfff;
+		read = tiadc_readl(adc_dev, REG_FIFO1);
+		if (read >> 16 == step)
+			*val = read & 0xfff;
 	}
 	am335x_tsc_se_update(adc_dev->mfd_tscadc);
 
@@ -199,8 +213,11 @@ static int tiadc_probe(struct platform_device *pdev)
 	struct tiadc_device	*adc_dev;
 	struct ti_tscadc_dev	*tscadc_dev = ti_tscadc_dev_get(pdev);
 	struct device_node	*node = tscadc_dev->dev->of_node;
+	struct property		*prop;
+	const __be32		*cur;
 	int			err;
-	u32			val32;
+	u32			val;
+	int channels		= 0;
 
 	if (!node) {
 		dev_err(&pdev->dev, "Could not find valid DT data.\n");
@@ -222,11 +239,13 @@ static int tiadc_probe(struct platform_device *pdev)
 		err = -EINVAL;
 		goto err_free_device;
 	}
-	err = of_property_read_u32(node,
-			"ti,adc-channels", &val32);
-	if (err < 0)
-		goto err_free_device;
-	adc_dev->channels = val32;
+
+	of_property_for_each_u32(node, "ti,adc-channels", prop, cur, val) {
+
+		adc_dev->channel_line[channels] = val;
+		channels++;
+	}
+	adc_dev->channels = channels;
 
 	indio_dev->dev.parent = &pdev->dev;
 	indio_dev->name = dev_name(&pdev->dev);
diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index 8bdab8d..acdb7b9 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -80,9 +80,13 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	struct clk		*clk;
 	struct device_node	*node = pdev->dev.of_node;
 	struct mfd_cell		*cell;
+	struct property         *prop;
+	const __be32            *cur;
+	u32			val;
 	int			err, ctrl;
 	int			clk_value, clock_rate;
 	int			tsc_wires = 0, adc_channels = 0, total_channels;
+	int			readouts = 0;
 
 	if (!pdev->dev.of_node) {
 		dev_err(&pdev->dev, "Could not find valid DT data.\n");
@@ -91,10 +95,17 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 
 	node = of_get_child_by_name(pdev->dev.of_node, "tsc");
 	of_property_read_u32(node, "ti,wires", &tsc_wires);
+	of_property_read_u32(node, "ti,coordiante-readouts", &readouts);
 
 	node = of_get_child_by_name(pdev->dev.of_node, "adc");
-	of_property_read_u32(node, "ti,adc-channels", &adc_channels);
-
+	of_property_for_each_u32(node, "ti,adc-channels", prop, cur, val) {
+		adc_channels++;
+		if (val > 7) {
+			dev_err(&pdev->dev, " PIN numbers are 0..7 (not %d)\n",
+					val);
+			return -EINVAL;
+		}
+	}
 	total_channels = tsc_wires + adc_channels;
 	if (total_channels > 8) {
 		dev_err(&pdev->dev, "Number of i/p channels more than 8\n");
@@ -105,6 +116,11 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	if (readouts * 2 + 2 + adc_channels > 16) {
+		dev_err(&pdev->dev, "Too many step configurations requested\n");
+		return -EINVAL;
+	}
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		dev_err(&pdev->dev, "no memory resource defined.\n");
-- 
1.7.10.4
