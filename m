From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 11/11] input: axp20x-pek: convert platform driver to use dev_groups
Date: Thu,  4 Jul 2019 10:46:17 +0200
Message-ID: <20190704084617.3602-12-gregkh@linuxfoundation.org>
References: <20190704084617.3602-1-gregkh@linuxfoundation.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190704084617.3602-1-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Platform drivers now have the option to have the platform core create
and remove any needed sysfs attribute files.  So take advantage of that
and do not register "by hand" a sysfs group of attributes.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/misc/axp20x-pek.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/input/misc/axp20x-pek.c b/drivers/input/misc/axp20x-pek.c
index debeeaeb8812..baff6dcbe392 100644
--- a/drivers/input/misc/axp20x-pek.c
+++ b/drivers/input/misc/axp20x-pek.c
@@ -195,15 +195,12 @@ DEVICE_ATTR(startup, 0644, axp20x_show_attr_startup, axp20x_store_attr_startup);
 DEVICE_ATTR(shutdown, 0644, axp20x_show_attr_shutdown,
 	    axp20x_store_attr_shutdown);
 
-static struct attribute *axp20x_attributes[] = {
+static struct attribute *axp20x_attrs[] = {
 	&dev_attr_startup.attr,
 	&dev_attr_shutdown.attr,
 	NULL,
 };
-
-static const struct attribute_group axp20x_attribute_group = {
-	.attrs = axp20x_attributes,
-};
+ATTRIBUTE_GROUPS(axp20x);
 
 static irqreturn_t axp20x_pek_irq(int irq, void *pwr)
 {
@@ -356,13 +353,6 @@ static int axp20x_pek_probe(struct platform_device *pdev)
 
 	axp20x_pek->info = (struct axp20x_info *)match->driver_data;
 
-	error = devm_device_add_group(&pdev->dev, &axp20x_attribute_group);
-	if (error) {
-		dev_err(&pdev->dev, "Failed to create sysfs attributes: %d\n",
-			error);
-		return error;
-	}
-
 	platform_set_drvdata(pdev, axp20x_pek);
 
 	return 0;
@@ -406,6 +396,7 @@ static const struct platform_device_id axp_pek_id_match[] = {
 MODULE_DEVICE_TABLE(platform, axp_pek_id_match);
 
 static struct platform_driver axp20x_pek_driver = {
+	.dev_groups	= axp20x_groups,
 	.probe		= axp20x_pek_probe,
 	.id_table	= axp_pek_id_match,
 	.driver		= {
-- 
2.22.0
