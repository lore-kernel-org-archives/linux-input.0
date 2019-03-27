From: megous via linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Subject: [PATCH RESEND v4 1/4] input: sun4i-a10-lradc-keys: Add
 support for A83T
Date: Wed, 27 Mar 2019 03:33:36 +0100
Message-ID: <20190327023339.25975-2-megous@megous.com>
References: <20190327023339.25975-1-megous@megous.com>
Reply-To: megous-5qf/QAjKc83QT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBDXLF6FR5INBBDGC5PSAKGQEF3SIB2I-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20190327023339.25975-1-megous-5qf/QAjKc83QT0dZR+AlfA@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, mark.rutland-5wv7dgnIgG8@public.gmane.org
Cc: Ziping Chen <techping.chan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-input@vger.kernel.org

From: Ziping Chen <techping.chan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Allwinner A83T SoC has a low res adc like the one in Allwinner A10 SoC,
however, the A10 SoC's vref of lradc internally is divided by 2/3 and
the A83T SoC's vref of lradc internally is divided by 3/4, thus add
a hardware variant for it to be compatible with various devices.

Signed-off-by: Ziping Chen <techping.chan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/input/keyboard/sun4i-lradc-keys.c | 38 ++++++++++++++++++++---
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/sun4i-lradc-keys.c b/drivers/input/keyboard/sun4i-lradc-keys.c
index 57272df34cd5..df3eec72a9b2 100644
--- a/drivers/input/keyboard/sun4i-lradc-keys.c
+++ b/drivers/input/keyboard/sun4i-lradc-keys.c
@@ -46,6 +46,7 @@
 #define CONTINUE_TIME_SEL(x)	((x) << 16) /* 4 bits */
 #define KEY_MODE_SEL(x)		((x) << 12) /* 2 bits */
 #define LEVELA_B_CNT(x)		((x) << 8)  /* 4 bits */
+#define HOLD_KEY_EN(x)		((x) << 7)
 #define HOLD_EN(x)		((x) << 6)
 #define LEVELB_VOL(x)		((x) << 4)  /* 2 bits */
 #define SAMPLE_RATE(x)		((x) << 2)  /* 2 bits */
@@ -63,6 +64,25 @@
 #define	CHAN0_KEYDOWN_IRQ	BIT(1)
 #define CHAN0_DATA_IRQ		BIT(0)
 
+/* struct lradc_variant - Describe sun4i-a10-lradc-keys hardware variant
+ * @divisor_numerator:		The numerator of lradc Vref internally divisor
+ * @divisor_denominator:	The denominator of lradc Vref internally divisor
+ */
+struct lradc_variant {
+	u8 divisor_numerator;
+	u8 divisor_denominator;
+};
+
+static const struct lradc_variant lradc_variant_a10 = {
+	.divisor_numerator = 2,
+	.divisor_denominator = 3
+};
+
+static const struct lradc_variant r_lradc_variant_a83t = {
+	.divisor_numerator = 3,
+	.divisor_denominator = 4
+};
+
 struct sun4i_lradc_keymap {
 	u32 voltage;
 	u32 keycode;
@@ -74,6 +94,7 @@ struct sun4i_lradc_data {
 	void __iomem *base;
 	struct regulator *vref_supply;
 	struct sun4i_lradc_keymap *chan0_map;
+	const struct lradc_variant *variant;
 	u32 chan0_map_count;
 	u32 chan0_keycode;
 	u32 vref;
@@ -128,9 +149,9 @@ static int sun4i_lradc_open(struct input_dev *dev)
 	if (error)
 		return error;
 
-	/* lradc Vref internally is divided by 2/3 */
-	lradc->vref = regulator_get_voltage(lradc->vref_supply) * 2 / 3;
-
+	lradc->vref = regulator_get_voltage(lradc->vref_supply) *
+		      lradc->variant->divisor_numerator /
+		      lradc->variant->divisor_denominator;
 	/*
 	 * Set sample time to 4 ms / 250 Hz. Wait 2 * 4 ms for key to
 	 * stabilize on press, wait (1 + 1) * 4 ms for key release
@@ -222,6 +243,12 @@ static int sun4i_lradc_probe(struct platform_device *pdev)
 	if (error)
 		return error;
 
+	lradc->variant = of_device_get_match_data(&pdev->dev);
+	if (!lradc->variant) {
+		dev_err(&pdev->dev, "Missing sun4i-a10-lradc-keys variant\n");
+		return -EINVAL;
+	}
+
 	lradc->vref_supply = devm_regulator_get(dev, "vref");
 	if (IS_ERR(lradc->vref_supply))
 		return PTR_ERR(lradc->vref_supply);
@@ -265,7 +292,10 @@ static int sun4i_lradc_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id sun4i_lradc_of_match[] = {
-	{ .compatible = "allwinner,sun4i-a10-lradc-keys", },
+	{ .compatible = "allwinner,sun4i-a10-lradc-keys",
+		.data = &lradc_variant_a10 },
+	{ .compatible = "allwinner,sun8i-a83t-r-lradc",
+		.data = &r_lradc_variant_a83t },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sun4i_lradc_of_match);
-- 
2.21.0
