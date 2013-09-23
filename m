From: Juergen Beisert <jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH 8/9] Staging/iio/adc/touchscreen/MXS: provide devicetree adaption
Date: Mon, 23 Sep 2013 16:36:37 +0200
Message-ID: <1379946998-23041-9-git-send-email-jbe@pengutronix.de>
References: <1379946998-23041-1-git-send-email-jbe@pengutronix.de>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1379946998-23041-1-git-send-email-jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, marex-ynQEQJNshbs@public.gmane.org, fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org, jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

This is an RFC for the new touchscreen properties.

Signed-off-by: Juergen Beisert <jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
CC: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
CC: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
CC: devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org
CC: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
CC: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
CC: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
CC: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
---
 .../bindings/staging/iio/adc/mxs-lradc.txt         | 36 ++++++++++++--
 arch/arm/boot/dts/imx28-evk.dts                    |  4 ++
 drivers/staging/iio/adc/mxs-lradc.c                | 57 ++++++++++++++--------
 3 files changed, 71 insertions(+), 26 deletions(-)

diff --git a/Documentation/devicetree/bindings/staging/iio/adc/mxs-lradc.txt b/Documentation/devicetree/bindings/staging/iio/adc/mxs-lradc.txt
index 4688205..ee05dc3 100644
--- a/Documentation/devicetree/bindings/staging/iio/adc/mxs-lradc.txt
+++ b/Documentation/devicetree/bindings/staging/iio/adc/mxs-lradc.txt
@@ -1,7 +1,8 @@
 * Freescale i.MX28 LRADC device driver
 
 Required properties:
-- compatible: Should be "fsl,imx28-lradc"
+- compatible: Should be "fsl,imx23-lradc" for i.MX23 SoC and "fsl,imx28-lradc"
+              for i.MX28 SoC
 - reg: Address and length of the register set for the device
 - interrupts: Should contain the LRADC interrupts
 
@@ -9,13 +10,38 @@ Optional properties:
 - fsl,lradc-touchscreen-wires: Number of wires used to connect the touchscreen
                                to LRADC. Valid value is either 4 or 5. If this
                                property is not present, then the touchscreen is
-                               disabled.
+                               disabled. 5 wires is valid for i.MX28 SoC only.
+- fsl,ave-ctrl: number of samples per direction to calculate an average value.
+                Allowed value is 1 ... 31, default is 4
+- fsl,ave-delay: delay between consecutive samples. Allowed value is
+                 1 ... 2047. It is used if 'fsl,ave-ctrl' > 1, counts at
+                 2 kHz and its default is 2 (= 1 ms)
+- fsl,settling: delay between plate switch to next sample. Allowed value is
+                1 ... 2047. It counts at 2 kHz and its default is
+                10 (= 5 ms)
 
-Examples:
+Example for i.MX23 SoC:
+
+	lradc@80050000 {
+		compatible = "fsl,imx23-lradc";
+		reg = <0x80050000 0x2000>;
+		interrupts = <36 37 38 39 40 41 42 43 44>;
+		status = "okay";
+		fsl,lradc-touchscreen-wires = <4>;
+		fsl,ave-ctrl = <4>;
+		fsl,ave-delay = <2>;
+		fsl,settling = <10>;
+	};
+
+Example for i.MX28 SoC:
 
 	lradc@80050000 {
 		compatible = "fsl,imx28-lradc";
 		reg = <0x80050000 0x2000>;
-		interrupts = <10 14 15 16 17 18 19
-				20 21 22 23 24 25>;
+		interrupts = <10 14 15 16 17 18 19 20 21 22 23 24 25>;
+		status = "okay";
+		fsl,lradc-touchscreen-wires = <5>;
+		fsl,ave-ctrl = <4>;
+		fsl,ave-delay = <2>;
+		fsl,settling = <10>;
 	};
diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index 15715d9..aa33393 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -183,6 +183,10 @@
 
 			lradc@80050000 {
 				status = "okay";
+				fsl,lradc-touchscreen-wires = <4>;
+				fsl,ave-ctrl = <4>;
+				fsl,ave-delay = <2>;
+				fsl,settling = <10>;
 			};
 
 			i2c0: i2c@80058000 {
diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
index aa1f337..dbc0af6 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -1230,10 +1230,45 @@ MODULE_DEVICE_TABLE(of, mxs_lradc_dt_ids);
 static int mxs_lradc_probe_touchscreen(struct mxs_lradc *lradc,
 						struct device_node *lradc_node)
 {
-	/* TODO retrieve from device tree */
+	int ret;
+	u32 ts_wires = 0, adapt;
+
+	ret = of_property_read_u32(lradc_node, "fsl,lradc-touchscreen-wires",
+				&ts_wires);
+	if (ret)
+		return -ENODEV; /* touchscreen feature disabled */
+
+	switch (ts_wires) {
+	case 4:
+		lradc->use_touchscreen = MXS_LRADC_TOUCHSCREEN_4WIRE;
+		break;
+	case 5:
+		if (lradc->soc == IMX28_LRADC) {
+			lradc->use_touchscreen = MXS_LRADC_TOUCHSCREEN_5WIRE;
+			break;
+		}
+		/* fall through an error message for i.MX23 */
+	default:
+		dev_err(lradc->dev,
+			"Unsupported number of touchscreen wires (%d)\n",
+			ts_wires);
+		return -EINVAL;
+	}
+
 	lradc->over_sample_cnt = 4;
+	ret = of_property_read_u32(lradc_node, "fsl,ave-ctrl", &adapt);
+	if (ret == 0)
+		lradc->over_sample_cnt = adapt;
+
 	lradc->over_sample_delay = 2;
+	ret = of_property_read_u32(lradc_node, "fsl,ave-delay", &adapt);
+	if (ret == 0)
+		lradc->over_sample_delay = adapt;
+
 	lradc->settling_delay = 10;
+	ret = of_property_read_u32(lradc_node, "fsl,settling", &adapt);
+	if (ret == 0)
+		lradc->settling_delay = adapt;
 
 	return 0;
 }
@@ -1249,7 +1284,6 @@ static int mxs_lradc_probe(struct platform_device *pdev)
 	struct mxs_lradc *lradc;
 	struct iio_dev *iio;
 	struct resource *iores;
-	uint32_t ts_wires = 0;
 	int ret = 0, touch_ret;
 	int i;
 
@@ -1275,25 +1309,6 @@ static int mxs_lradc_probe(struct platform_device *pdev)
 
 	touch_ret = mxs_lradc_probe_touchscreen(lradc, node);
 
-	/* Check if touchscreen is enabled in DT. */
-	ret = of_property_read_u32(node, "fsl,lradc-touchscreen-wires",
-				&ts_wires);
-	if (ret)
-		dev_info(dev, "Touchscreen not enabled.\n");
-	else if (ts_wires == 4)
-		lradc->use_touchscreen = MXS_LRADC_TOUCHSCREEN_4WIRE;
-	else if (ts_wires == 5)
-		lradc->use_touchscreen = MXS_LRADC_TOUCHSCREEN_5WIRE;
-	else
-		dev_warn(dev, "Unsupported number of touchscreen wires (%d)\n",
-				ts_wires);
-
-	if ((lradc->soc == IMX23_LRADC) && (ts_wires == 5)) {
-		dev_warn(dev, "No support for 5 wire touches on i.MX23\n");
-		dev_warn(dev, "Falling back to 4 wire\n");
-		ts_wires = 4;
-	}
-
 	/* Grab all IRQ sources */
 	for (i = 0; i < of_cfg->irq_count; i++) {
 		lradc->irq[i] = platform_get_irq(pdev, i);
-- 
1.8.4.rc3
