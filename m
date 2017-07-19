From: Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: [PATCH v2 1/3] Input: axp20x-pek: use driver_data of platform_device_id instead of extended attributes
Date: Wed, 19 Jul 2017 09:43:35 +0200
Message-ID: <20170719074337.19189-2-quentin.schulz@free-electrons.com>
References: <20170719074337.19189-1-quentin.schulz@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719074337.19189-1-quentin.schulz@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, wens@csie.org, lee.jones@linaro.org
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>, hdegoede@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, thomas.petazzoni@free-electrons.com, maxime.ripard@free-electrons.com
List-Id: linux-input@vger.kernel.org

To prepare an upcoming patch adding support for another PMIC that has
different startup and shutdown time, use driver_data of
platform_device_id instead of a fixed extended device attribute.

By doing so, we also remove a lot of nested structures that aren't
useful.

With this patch, a new PMIC can be easily supported by just filling
correctly its ax20x_info structure and adding a platform_device_id.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 drivers/input/misc/axp20x-pek.c | 131 +++++++++++++++++++++++++++-------------
 1 file changed, 88 insertions(+), 43 deletions(-)

diff --git a/drivers/input/misc/axp20x-pek.c b/drivers/input/misc/axp20x-pek.c
index 38c79ebff033..94c89fbeeeaa 100644
--- a/drivers/input/misc/axp20x-pek.c
+++ b/drivers/input/misc/axp20x-pek.c
@@ -29,9 +29,17 @@
 #define AXP20X_PEK_STARTUP_MASK		(0xc0)
 #define AXP20X_PEK_SHUTDOWN_MASK	(0x03)
 
+struct axp20x_info {
+	const struct axp20x_time *startup_time;
+	unsigned int startup_mask;
+	const struct axp20x_time *shutdown_time;
+	unsigned int shutdown_mask;
+};
+
 struct axp20x_pek {
 	struct axp20x_dev *axp20x;
 	struct input_dev *input;
+	struct axp20x_info *info;
 	int irq_dbr;
 	int irq_dbf;
 };
@@ -55,31 +63,18 @@ static const struct axp20x_time shutdown_time[] = {
 	{ .time = 10000, .idx = 3 },
 };
 
-struct axp20x_pek_ext_attr {
-	const struct axp20x_time *p_time;
-	unsigned int mask;
-};
-
-static struct axp20x_pek_ext_attr axp20x_pek_startup_ext_attr = {
-	.p_time	= startup_time,
-	.mask	= AXP20X_PEK_STARTUP_MASK,
-};
-
-static struct axp20x_pek_ext_attr axp20x_pek_shutdown_ext_attr = {
-	.p_time	= shutdown_time,
-	.mask	= AXP20X_PEK_SHUTDOWN_MASK,
+static const struct axp20x_info axp20x_info = {
+	.startup_time = startup_time,
+	.startup_mask = AXP20X_PEK_STARTUP_MASK,
+	.shutdown_time = shutdown_time,
+	.shutdown_mask = AXP20X_PEK_SHUTDOWN_MASK,
 };
 
-static struct axp20x_pek_ext_attr *get_axp_ext_attr(struct device_attribute *attr)
-{
-	return container_of(attr, struct dev_ext_attribute, attr)->var;
-}
-
 static ssize_t axp20x_show_ext_attr(struct device *dev,
-				    struct device_attribute *attr, char *buf)
+				    const struct axp20x_time *time,
+				    unsigned int mask, char *buf)
 {
 	struct axp20x_pek *axp20x_pek = dev_get_drvdata(dev);
-	struct axp20x_pek_ext_attr *axp20x_ea = get_axp_ext_attr(attr);
 	unsigned int val;
 	int ret, i;
 
@@ -87,22 +82,42 @@ static ssize_t axp20x_show_ext_attr(struct device *dev,
 	if (ret != 0)
 		return ret;
 
-	val &= axp20x_ea->mask;
-	val >>= ffs(axp20x_ea->mask) - 1;
+	val &= mask;
+	val >>= ffs(mask) - 1;
 
 	for (i = 0; i < 4; i++)
-		if (val == axp20x_ea->p_time[i].idx)
-			val = axp20x_ea->p_time[i].time;
+		if (val == time[i].idx)
+			val = time[i].time;
 
 	return sprintf(buf, "%u\n", val);
 }
 
+static ssize_t axp20x_show_ext_attr_startup(struct device *dev,
+					    struct device_attribute *attr,
+					    char *buf)
+{
+	struct axp20x_pek *axp20x_pek = dev_get_drvdata(dev);
+
+	return axp20x_show_ext_attr(dev, axp20x_pek->info->startup_time,
+				    axp20x_pek->info->startup_mask, buf);
+}
+
+static ssize_t axp20x_show_ext_attr_shutdown(struct device *dev,
+					     struct device_attribute *attr,
+					     char *buf)
+{
+	struct axp20x_pek *axp20x_pek = dev_get_drvdata(dev);
+
+	return axp20x_show_ext_attr(dev, axp20x_pek->info->shutdown_time,
+				    axp20x_pek->info->shutdown_mask, buf);
+}
+
 static ssize_t axp20x_store_ext_attr(struct device *dev,
-				     struct device_attribute *attr,
-				     const char *buf, size_t count)
+				     const struct axp20x_time *time,
+				     unsigned int mask, const char *buf,
+				     size_t count)
 {
 	struct axp20x_pek *axp20x_pek = dev_get_drvdata(dev);
-	struct axp20x_pek_ext_attr *axp20x_ea = get_axp_ext_attr(attr);
 	char val_str[20];
 	size_t len;
 	int ret, i;
@@ -123,39 +138,53 @@ static ssize_t axp20x_store_ext_attr(struct device *dev,
 	for (i = 3; i >= 0; i--) {
 		unsigned int err;
 
-		err = abs(axp20x_ea->p_time[i].time - val);
+		err = abs(time[i].time - val);
 		if (err < best_err) {
 			best_err = err;
-			idx = axp20x_ea->p_time[i].idx;
+			idx = time[i].idx;
 		}
 
 		if (!err)
 			break;
 	}
 
-	idx <<= ffs(axp20x_ea->mask) - 1;
-	ret = regmap_update_bits(axp20x_pek->axp20x->regmap,
-				 AXP20X_PEK_KEY,
-				 axp20x_ea->mask, idx);
+	idx <<= ffs(mask) - 1;
+	ret = regmap_update_bits(axp20x_pek->axp20x->regmap, AXP20X_PEK_KEY,
+				 mask, idx);
 	if (ret != 0)
 		return -EINVAL;
 
 	return count;
 }
 
-static struct dev_ext_attribute axp20x_dev_attr_startup = {
-	.attr	= __ATTR(startup, 0644, axp20x_show_ext_attr, axp20x_store_ext_attr),
-	.var	= &axp20x_pek_startup_ext_attr,
-};
+static ssize_t axp20x_store_ext_attr_startup(struct device *dev,
+					     struct device_attribute *attr,
+					     const char *buf, size_t count)
+{
+	struct axp20x_pek *axp20x_pek = dev_get_drvdata(dev);
 
-static struct dev_ext_attribute axp20x_dev_attr_shutdown = {
-	.attr	= __ATTR(shutdown, 0644, axp20x_show_ext_attr, axp20x_store_ext_attr),
-	.var	= &axp20x_pek_shutdown_ext_attr,
-};
+	return axp20x_store_ext_attr(dev, axp20x_pek->info->startup_time,
+				     axp20x_pek->info->startup_mask, buf,
+				     count);
+}
+
+static ssize_t axp20x_store_ext_attr_shutdown(struct device *dev,
+					      struct device_attribute *attr,
+					      const char *buf, size_t count)
+{
+	struct axp20x_pek *axp20x_pek = dev_get_drvdata(dev);
+
+	return axp20x_store_ext_attr(dev, axp20x_pek->info->shutdown_time,
+				     axp20x_pek->info->shutdown_mask, buf,
+				     count);
+}
+
+DEVICE_ATTR(startup, 0644, axp20x_show_ext_attr_startup, axp20x_store_ext_attr_startup);
+DEVICE_ATTR(shutdown, 0644, axp20x_show_ext_attr_shutdown, axp20x_store_ext_attr_shutdown);
 
 static struct attribute *axp20x_attributes[] = {
-	&axp20x_dev_attr_startup.attr.attr,
-	&axp20x_dev_attr_shutdown.attr.attr,
+	&dev_attr_startup.attr,
+	&dev_attr_shutdown.attr,
 	NULL,
 };
 
@@ -298,8 +327,14 @@ static bool axp20x_pek_should_register_input(struct axp20x_pek *axp20x_pek,
 static int axp20x_pek_probe(struct platform_device *pdev)
 {
 	struct axp20x_pek *axp20x_pek;
+	const struct platform_device_id *match = platform_get_device_id(pdev);
 	int error;
 
+	if (!match) {
+		dev_err(&pdev->dev, "Failed to get platform_device_id\n");
+		return -EINVAL;
+	}
+
 	axp20x_pek = devm_kzalloc(&pdev->dev, sizeof(struct axp20x_pek),
 				  GFP_KERNEL);
 	if (!axp20x_pek)
@@ -313,6 +348,8 @@ static int axp20x_pek_probe(struct platform_device *pdev)
 			return error;
 	}
 
+	axp20x_pek->info = (struct axp20x_info *)match->driver_data;
+
 	error = sysfs_create_group(&pdev->dev.kobj, &axp20x_attribute_group);
 	if (error) {
 		dev_err(&pdev->dev, "Failed to create sysfs attributes: %d\n",
@@ -358,8 +395,16 @@ static const struct dev_pm_ops axp20x_pek_pm_ops = {
 #endif
 };
 
+static const struct platform_device_id axp_pek_id_match[] = {
+	{
+		.name = "axp20x-pek",
+		.driver_data = (kernel_ulong_t)&axp20x_info,
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
