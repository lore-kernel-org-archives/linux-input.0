From: Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: [PATCH 1/2] Input: axp20x-pek: add support for AXP221 PEK
Date: Mon, 17 Jul 2017 11:53:06 +0200
Message-ID: <20170717095307.15986-2-quentin.schulz@free-electrons.com>
References: <20170717095307.15986-1-quentin.schulz@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170717095307.15986-1-quentin.schulz@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, wens@csie.org, lee.jones@linaro.org
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>, hdegoede@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, thomas.petazzoni@free-electrons.com, maxime.ripard@free-electrons.com
List-Id: linux-input@vger.kernel.org

The AXP221 has different values for startup time bits from the AXP20X.

This patch introduces a different platform_device_id to the driver and
adds the necessary code to handle the different platform_device_ids.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 drivers/input/misc/axp20x-pek.c | 62 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 52 insertions(+), 10 deletions(-)

diff --git a/drivers/input/misc/axp20x-pek.c b/drivers/input/misc/axp20x-pek.c
index 38c79ebff033..3efa1de51569 100644
--- a/drivers/input/misc/axp20x-pek.c
+++ b/drivers/input/misc/axp20x-pek.c
@@ -32,6 +32,7 @@
 struct axp20x_pek {
 	struct axp20x_dev *axp20x;
 	struct input_dev *input;
+	struct attribute_group *attribute_group;
 	int irq_dbr;
 	int irq_dbf;
 };
@@ -41,14 +42,21 @@ struct axp20x_time {
 	unsigned int idx;
 };
 
-static const struct axp20x_time startup_time[] = {
+static const struct axp20x_time axp20x_startup_time[] = {
 	{ .time = 128,  .idx = 0 },
 	{ .time = 1000, .idx = 2 },
 	{ .time = 3000, .idx = 1 },
 	{ .time = 2000, .idx = 3 },
 };
 
-static const struct axp20x_time shutdown_time[] = {
+static const struct axp20x_time axp221_startup_time[] = {
+	{ .time = 128,  .idx = 0 },
+	{ .time = 1000, .idx = 1 },
+	{ .time = 2000, .idx = 2 },
+	{ .time = 3000, .idx = 3 },
+};
+
+static const struct axp20x_time axp20x_shutdown_time[] = {
 	{ .time = 4000,  .idx = 0 },
 	{ .time = 6000,  .idx = 1 },
 	{ .time = 8000,  .idx = 2 },
@@ -61,15 +69,20 @@ struct axp20x_pek_ext_attr {
 };
 
 static struct axp20x_pek_ext_attr axp20x_pek_startup_ext_attr = {
-	.p_time	= startup_time,
+	.p_time	= axp20x_startup_time,
 	.mask	= AXP20X_PEK_STARTUP_MASK,
 };
 
 static struct axp20x_pek_ext_attr axp20x_pek_shutdown_ext_attr = {
-	.p_time	= shutdown_time,
+	.p_time	= axp20x_shutdown_time,
 	.mask	= AXP20X_PEK_SHUTDOWN_MASK,
 };
 
+static struct axp20x_pek_ext_attr axp221_pek_startup_ext_attr = {
+	.p_time	= axp221_startup_time,
+	.mask	= AXP20X_PEK_STARTUP_MASK,
+};
+
 static struct axp20x_pek_ext_attr *get_axp_ext_attr(struct device_attribute *attr)
 {
 	return container_of(attr, struct dev_ext_attribute, attr)->var;
@@ -148,6 +161,11 @@ static struct dev_ext_attribute axp20x_dev_attr_startup = {
 	.var	= &axp20x_pek_startup_ext_attr,
 };
 
+static struct dev_ext_attribute axp221_dev_attr_startup = {
+	.attr	= __ATTR(startup, 0644, axp20x_show_ext_attr, axp20x_store_ext_attr),
+	.var	= &axp221_pek_startup_ext_attr,
+};
+
 static struct dev_ext_attribute axp20x_dev_attr_shutdown = {
 	.attr	= __ATTR(shutdown, 0644, axp20x_show_ext_attr, axp20x_store_ext_attr),
 	.var	= &axp20x_pek_shutdown_ext_attr,
@@ -159,10 +177,20 @@ static struct attribute *axp20x_attributes[] = {
 	NULL,
 };
 
+static struct attribute *axp221_attributes[] = {
+	&axp221_dev_attr_startup.attr.attr,
+	&axp20x_dev_attr_shutdown.attr.attr,
+	NULL,
+};
+
 static const struct attribute_group axp20x_attribute_group = {
 	.attrs = axp20x_attributes,
 };
 
+static const struct attribute_group axp221_attribute_group = {
+	.attrs = axp221_attributes,
+};
+
 static irqreturn_t axp20x_pek_irq(int irq, void *pwr)
 {
 	struct input_dev *idev = pwr;
@@ -184,9 +212,10 @@ static irqreturn_t axp20x_pek_irq(int irq, void *pwr)
 
 static void axp20x_remove_sysfs_group(void *_data)
 {
-	struct device *dev = _data;
+	struct platform_device *pdev = _data;
+	struct axp20x_pek *axp_pek = platform_get_drvdata(pdev);
 
-	sysfs_remove_group(&dev->kobj, &axp20x_attribute_group);
+	sysfs_remove_group(&pdev->dev.kobj, axp_pek->attribute_group);
 }
 
 static int axp20x_pek_probe_input_device(struct axp20x_pek *axp20x_pek,
@@ -313,17 +342,19 @@ static int axp20x_pek_probe(struct platform_device *pdev)
 			return error;
 	}
 
-	error = sysfs_create_group(&pdev->dev.kobj, &axp20x_attribute_group);
+	axp20x_pek->attribute_group = (struct attribute_group *)platform_get_device_id(pdev)->driver_data;
+
+	error = sysfs_create_group(&pdev->dev.kobj,
+				   axp20x_pek->attribute_group);
 	if (error) {
 		dev_err(&pdev->dev, "Failed to create sysfs attributes: %d\n",
 			error);
 		return error;
 	}
 
-	error = devm_add_action(&pdev->dev,
-				axp20x_remove_sysfs_group, &pdev->dev);
+	error = devm_add_action(&pdev->dev, axp20x_remove_sysfs_group, pdev);
 	if (error) {
-		axp20x_remove_sysfs_group(&pdev->dev);
+		axp20x_remove_sysfs_group(pdev);
 		dev_err(&pdev->dev, "Failed to add sysfs cleanup action: %d\n",
 			error);
 		return error;
@@ -358,8 +389,19 @@ static const struct dev_pm_ops axp20x_pek_pm_ops = {
 #endif
 };
 
+static const struct platform_device_id axp_pek_id_match[] = {
+	{
+		.name = "axp20x-pek",
+		.driver_data = (kernel_ulong_t)&axp20x_attribute_group,
+	}, {
+		.name = "axp221-pek",
+		.driver_data = (kernel_ulong_t)&axp221_attribute_group,
+	},
+};
+
 static struct platform_driver axp20x_pek_driver = {
 	.probe		= axp20x_pek_probe,
+	.id_table	= axp_pek_id_match,
 	.driver		= {
 		.name		= "axp20x-pek",
 		.pm		= &axp20x_pek_pm_ops,
-- 
2.11.0
