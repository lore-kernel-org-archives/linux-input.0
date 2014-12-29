From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v8 3/6] input: misc: Add driver for AXP20x
 Power Enable Key
Date: Mon, 29 Dec 2014 15:16:53 -0800
Message-ID: <20141229231653.GH9565@dtor-ws>
References: <1419303194-3075-1-git-send-email-wens@csie.org>
 <1419303194-3075-4-git-send-email-wens@csie.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDP6N55ZUYDRB2WBQ6SQKGQEDGGTTTQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1419303194-3075-4-git-send-email-wens-jdAy2FN1RRM@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, Dec 23, 2014 at 10:53:11AM +0800, Chen-Yu Tsai wrote:
> From: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
> 
> This patch add support for the Power Enable Key found on MFD AXP202 and
> AXP209. Besides the basic support for the button, the driver adds two
> entries in sysfs to configure the time delay for power on/off.
> 
> Signed-off-by: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
> Acked-by: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> [wens-jdAy2FN1RRM@public.gmane.org: make axp20x_pek_remove() static; remove driver owner field]
> Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>

Hmm, it looks like MFD parts are in mainline, so I can actually pick
this up myself. OK.

By the way, does driver works for you with the patch below?

Thanks.

-- 
Dmitry

Input: axp20x-pek - switch over to using attribute group

From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Instead of registering device attributes individually let's use attribute
groups and also devm_* infrastructure to ease cleanup.

Refresh of synaptics-forcepad-pnp.patch
---
 drivers/input/misc/axp20x-pek.c |   64 ++++++++++++++++++++++-----------------
 1 file changed, 36 insertions(+), 28 deletions(-)

diff --git a/drivers/input/misc/axp20x-pek.c b/drivers/input/misc/axp20x-pek.c
index 8dbd097..f1c8447 100644
--- a/drivers/input/misc/axp20x-pek.c
+++ b/drivers/input/misc/axp20x-pek.c
@@ -138,17 +138,28 @@ static ssize_t axp20x_store_ext_attr(struct device *dev,
 				 axp20x_ea->mask, idx);
 	if (ret != 0)
 		return -EINVAL;
+
 	return count;
 }
 
 static struct dev_ext_attribute axp20x_dev_attr_startup = {
 	.attr	= __ATTR(startup, 0644, axp20x_show_ext_attr, axp20x_store_ext_attr),
-	.var	= &axp20x_pek_startup_ext_attr
+	.var	= &axp20x_pek_startup_ext_attr,
 };
 
 static struct dev_ext_attribute axp20x_dev_attr_shutdown = {
 	.attr	= __ATTR(shutdown, 0644, axp20x_show_ext_attr, axp20x_store_ext_attr),
-	.var	= &axp20x_pek_shutdown_ext_attr
+	.var	= &axp20x_pek_shutdown_ext_attr,
+};
+
+static struct attribute *axp20x_attributes[] = {
+	&axp20x_dev_attr_startup.attr.attr,
+	&axp20x_dev_attr_shutdown.attr.attr,
+	NULL,
+};
+
+static const struct attribute_group axp20x_attribute_group = {
+	.attrs = axp20x_attributes,
 };
 
 static irqreturn_t axp20x_pek_irq(int irq, void *pwr)
@@ -166,6 +177,13 @@ static irqreturn_t axp20x_pek_irq(int irq, void *pwr)
 	return IRQ_HANDLED;
 }
 
+static void axp20x_remove_sysfs_group(void *_data)
+{
+	struct device *dev = _data;
+
+	sysfs_remove_group(&dev->kobj, &axp20x_attribute_group);
+}
+
 static int axp20x_pek_probe(struct platform_device *pdev)
 {
 	struct axp20x_pek *axp20x_pek;
@@ -214,12 +232,11 @@ static int axp20x_pek_probe(struct platform_device *pdev)
 	input_set_drvdata(idev, axp20x_pek);
 
 	error = devm_request_any_context_irq(&pdev->dev, axp20x_pek->irq_dbr,
-					  axp20x_pek_irq, 0,
-					  "axp20x-pek-dbr", idev);
+					     axp20x_pek_irq, 0,
+					     "axp20x-pek-dbr", idev);
 	if (error < 0) {
 		dev_err(axp20x->dev, "Failed to request dbr IRQ#%d: %d\n",
 			axp20x_pek->irq_dbr, error);
-
 		return error;
 	}
 
@@ -232,45 +249,36 @@ static int axp20x_pek_probe(struct platform_device *pdev)
 		return error;
 	}
 
-	error = device_create_file(&pdev->dev, &axp20x_dev_attr_startup.attr);
-	if (error)
+	error = sysfs_create_group(&pdev->dev.kobj, &axp20x_attribute_group);
+	if (error) {
+		dev_err(axp20x->dev, "Failed to create sysfs attributes: %d\n",
+			error);
 		return error;
+	}
 
-	error = device_create_file(&pdev->dev, &axp20x_dev_attr_shutdown.attr);
-	if (error)
-		goto clear_startup_attr;
+	error = devm_add_action(&pdev->dev,
+				axp20x_remove_sysfs_group, &pdev->dev);
+	if (error) {
+		axp20x_remove_sysfs_group(&pdev->dev);
+		dev_err(&pdev->dev, "Failed to add sysfs cleanup action: %d\n",
+			error);
+		return error;
+	}
 
 	error = input_register_device(idev);
 	if (error) {
 		dev_err(axp20x->dev, "Can't register input device: %d\n",
 			error);
-		goto clear_attr;
+		return error;
 	}
 
 	platform_set_drvdata(pdev, axp20x_pek);
 
 	return 0;
-
-clear_attr:
-	device_remove_file(&pdev->dev, &axp20x_dev_attr_shutdown.attr);
-
-clear_startup_attr:
-	device_remove_file(&pdev->dev, &axp20x_dev_attr_startup.attr);
-
-	return error;
-}
-
-static int axp20x_pek_remove(struct platform_device *pdev)
-{
-	device_remove_file(&pdev->dev, &axp20x_dev_attr_shutdown.attr);
-	device_remove_file(&pdev->dev, &axp20x_dev_attr_startup.attr);
-
-	return 0;
 }
 
 static struct platform_driver axp20x_pek_driver = {
 	.probe		= axp20x_pek_probe,
-	.remove		= axp20x_pek_remove,
 	.driver		= {
 		.name		= "axp20x-pek",
 	},
