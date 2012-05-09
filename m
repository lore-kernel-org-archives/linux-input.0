From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH V3 2/2] Input: spear-keyboard: add device tree bindings
Date: Tue, 8 May 2012 22:28:28 -0700
Message-ID: <20120509052828.GD10514@core.coreip.homeip.net>
References: <cover.1333009670.git.viresh.kumar@st.com>
 <eebfde0a1511204cab203fa18efe6264abe00486.1333009670.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:36873 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751718Ab2EIF2f (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 May 2012 01:28:35 -0400
Received: by dady13 with SMTP id y13so3569927dad.19
        for <linux-input@vger.kernel.org>; Tue, 08 May 2012 22:28:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <eebfde0a1511204cab203fa18efe6264abe00486.1333009670.git.viresh.kumar@st.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Viresh Kumar <viresh.kumar@st.com>
Cc: swarren@nvidia.com, spear-devel@list.st.com, viresh.linux@gmail.com, devicetree-discuss@lists.ozlabs.org, olof@lixom.net, linux-input@vger.kernel.org, sr@denx.de

Hi Viresh,

On Thu, Mar 29, 2012 at 02:03:27PM +0530, Viresh Kumar wrote:
>  
> -	matrix_keypad_build_keymap(keymap, ROW_SHIFT,
> -			input_dev->keycode, input_dev->keybit);
> +	if (np) {
> +		error = matrix_keypad_of_build_keymap(input_dev, ROW_SHIFT,
> +				"linux,keymap");
> +		if (error) {
> +			dev_err(&pdev->dev, "OF: failed to build keymap\n");
> +			goto err_put_clk;
> +		}
> +	} else {
> +		matrix_keypad_build_keymap(pdata->keymap, ROW_SHIFT,
> +				input_dev->keycode, input_dev->keybit);
> +	}

Now that I got matrix_keypad_build_keymap() also handle DT case, how
about the patch below?

Thanks.

-- 
Dmitry


Input: spear-keyboard - add device tree bindings

From: Viresh Kumar <viresh.kumar@st.com>

This adds simple DT bindings for spear-keyboard controller.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/keyboard/spear-keyboard.c |   71 ++++++++++++++++++++++++-------
 1 files changed, 56 insertions(+), 15 deletions(-)


diff --git a/drivers/input/keyboard/spear-keyboard.c b/drivers/input/keyboard/spear-keyboard.c
index e83cab2..6f287f7 100644
--- a/drivers/input/keyboard/spear-keyboard.c
+++ b/drivers/input/keyboard/spear-keyboard.c
@@ -19,6 +19,7 @@
 #include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_wakeup.h>
 #include <linux/slab.h>
@@ -63,6 +64,7 @@ struct spear_kbd {
 	unsigned int mode;
 	unsigned short last_key;
 	unsigned short keycodes[NUM_ROWS * NUM_COLS];
+	bool rep;
 };
 
 static irqreturn_t spear_kbd_interrupt(int irq, void *dev_id)
@@ -138,27 +140,49 @@ static void spear_kbd_close(struct input_dev *dev)
 	kbd->last_key = KEY_RESERVED;
 }
 
-static int __devinit spear_kbd_probe(struct platform_device *pdev)
+#ifdef CONFIG_OF
+static int __devinit spear_kbd_parse_dt(struct platform_device *pdev,
+                                        struct spear_kbd *kbd)
 {
-	const struct kbd_platform_data *pdata = pdev->dev.platform_data;
-	const struct matrix_keymap_data *keymap;
-	struct spear_kbd *kbd;
-	struct input_dev *input_dev;
-	struct resource *res;
-	int irq;
+	struct device_node *np = pdev->dev.of_node;
 	int error;
+	u32 val;
 
-	if (!pdata) {
-		dev_err(&pdev->dev, "Invalid platform data\n");
+	if (!np) {
+		dev_err(&pdev->dev, "Missing DT data\n");
 		return -EINVAL;
 	}
 
-	keymap = pdata->keymap;
-	if (!keymap) {
-		dev_err(&pdev->dev, "no keymap defined\n");
-		return -EINVAL;
+	if (of_property_read_bool(np, "autorepeat"))
+		kbd->rep = true;
+
+	error = of_property_read_u32(np, "st,mode", &val);
+	if (error) {
+		dev_err(&pdev->dev, "DT: Invalid or missing mode\n");
+		return error;
 	}
 
+	kbd->mode = val;
+	return 0;
+}
+#else
+static inline int spear_kbd_parse_dt(struct platform_device *pdev,
+				     struct spear_kbd *kbd)
+{
+	return -ENOSYS;
+}
+#endif
+
+static int __devinit spear_kbd_probe(struct platform_device *pdev)
+{
+	struct kbd_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	const struct matrix_keymap_data *keymap = pdata ? pdata->keymap : NULL;
+	struct spear_kbd *kbd;
+	struct input_dev *input_dev;
+	struct resource *res;
+	int irq;
+	int error;
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		dev_err(&pdev->dev, "no keyboard resource defined\n");
@@ -181,7 +205,15 @@ static int __devinit spear_kbd_probe(struct platform_device *pdev)
 
 	kbd->input = input_dev;
 	kbd->irq = irq;
-	kbd->mode = pdata->mode;
+
+	if (!pdata) {
+		error = spear_kbd_parse_dt(pdev, kbd);
+		if (error)
+			goto err_free_mem;
+	} else {
+		kbd->mode = pdata->mode;
+		kbd->rep = pdata->rep;
+	}
 
 	kbd->res = request_mem_region(res->start, resource_size(res),
 				      pdev->name);
@@ -221,7 +253,7 @@ static int __devinit spear_kbd_probe(struct platform_device *pdev)
 		goto err_put_clk;
 	}
 
-	if (pdata->rep)
+	if (kbd->rep)
 		__set_bit(EV_REP, input_dev->evbit);
 	input_set_capability(input_dev, EV_MSC, MSC_SCAN);
 
@@ -318,6 +350,14 @@ static int spear_kbd_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(spear_kbd_pm_ops, spear_kbd_suspend, spear_kbd_resume);
 
+#ifdef CONFIG_OF
+static const struct of_device_id spear_kbd_id_table[] = {
+	{ .compatible = "st,spear300-kbd" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, spear_kbd_id_table);
+#endif
+
 static struct platform_driver spear_kbd_driver = {
 	.probe		= spear_kbd_probe,
 	.remove		= __devexit_p(spear_kbd_remove),
@@ -325,6 +365,7 @@ static struct platform_driver spear_kbd_driver = {
 		.name	= "keyboard",
 		.owner	= THIS_MODULE,
 		.pm	= &spear_kbd_pm_ops,
+		.of_match_table = of_match_ptr(spear_kbd_id_table),
 	},
 };
 module_platform_driver(spear_kbd_driver);
