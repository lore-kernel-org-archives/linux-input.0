From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH resend 2/4] Input: axp20x_pek - Add axp20x_pek_probe_input_device helper
Date: Wed,  8 Mar 2017 09:54:11 +0100
Message-ID: <20170308085413.5185-3-hdegoede@redhat.com>
References: <20170308085413.5185-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49546 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751412AbdCHJUV (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 8 Mar 2017 04:20:21 -0500
In-Reply-To: <20170308085413.5185-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org

Move all input device related initialization into a new
axp20x_pek_probe_input_device helper function.

This introduces one functional change, the input device is now
registered before the sysfs attr get registered. This is not a problem
as the sysfs attr are to configure some long press settings (forced
poweroff) in the hardware and do not interact with the input_device.

This is a preparation patch for not always registering the input dev.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/misc/axp20x-pek.c | 47 +++++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/drivers/input/misc/axp20x-pek.c b/drivers/input/misc/axp20x-pek.c
index a041365..b7258ec 100644
--- a/drivers/input/misc/axp20x-pek.c
+++ b/drivers/input/misc/axp20x-pek.c
@@ -188,21 +188,13 @@ static void axp20x_remove_sysfs_group(void *_data)
 	sysfs_remove_group(&dev->kobj, &axp20x_attribute_group);
 }
 
-static int axp20x_pek_probe(struct platform_device *pdev)
+static int axp20x_pek_probe_input_device(struct axp20x_pek *axp20x_pek,
+					 struct platform_device *pdev)
 {
-	struct axp20x_pek *axp20x_pek;
-	struct axp20x_dev *axp20x;
+	struct axp20x_dev *axp20x = axp20x_pek->axp20x;
 	struct input_dev *idev;
 	int error;
 
-	axp20x_pek = devm_kzalloc(&pdev->dev, sizeof(struct axp20x_pek),
-				  GFP_KERNEL);
-	if (!axp20x_pek)
-		return -ENOMEM;
-
-	axp20x_pek->axp20x = dev_get_drvdata(pdev->dev.parent);
-	axp20x = axp20x_pek->axp20x;
-
 	axp20x_pek->irq_dbr = platform_get_irq_byname(pdev, "PEK_DBR");
 	if (axp20x_pek->irq_dbr < 0) {
 		dev_err(&pdev->dev, "No IRQ for PEK_DBR, error=%d\n",
@@ -253,6 +245,32 @@ static int axp20x_pek_probe(struct platform_device *pdev)
 		return error;
 	}
 
+	error = input_register_device(idev);
+	if (error) {
+		dev_err(&pdev->dev, "Can't register input device: %d\n",
+			error);
+		return error;
+	}
+
+	return 0;
+}
+
+static int axp20x_pek_probe(struct platform_device *pdev)
+{
+	struct axp20x_pek *axp20x_pek;
+	int error;
+
+	axp20x_pek = devm_kzalloc(&pdev->dev, sizeof(struct axp20x_pek),
+				  GFP_KERNEL);
+	if (!axp20x_pek)
+		return -ENOMEM;
+
+	axp20x_pek->axp20x = dev_get_drvdata(pdev->dev.parent);
+
+	error = axp20x_pek_probe_input_device(axp20x_pek, pdev);
+	if (error)
+		return error;
+
 	error = sysfs_create_group(&pdev->dev.kobj, &axp20x_attribute_group);
 	if (error) {
 		dev_err(&pdev->dev, "Failed to create sysfs attributes: %d\n",
@@ -269,13 +287,6 @@ static int axp20x_pek_probe(struct platform_device *pdev)
 		return error;
 	}
 
-	error = input_register_device(idev);
-	if (error) {
-		dev_err(&pdev->dev, "Can't register input device: %d\n",
-			error);
-		return error;
-	}
-
 	platform_set_drvdata(pdev, axp20x_pek);
 
 	return 0;
-- 
2.9.3

