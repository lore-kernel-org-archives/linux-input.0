From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH resend 1/4] Input: axp20x-pek - Use our own device for errors
Date: Wed,  8 Mar 2017 09:54:10 +0100
Message-ID: <20170308085413.5185-2-hdegoede@redhat.com>
References: <20170308085413.5185-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50664 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751720AbdCHJA5 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 8 Mar 2017 04:00:57 -0500
In-Reply-To: <20170308085413.5185-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org

Before this commit axp20x-pek was mixing 2 style error reporting calls:
dev_err(&pdev->dev, ...);
dev_err(axp20x->dev, ...);

But the second is our parent device, not our own device, so switch to
using &pdev->dev everywhere.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/misc/axp20x-pek.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/misc/axp20x-pek.c b/drivers/input/misc/axp20x-pek.c
index 1ac898d..a041365 100644
--- a/drivers/input/misc/axp20x-pek.c
+++ b/drivers/input/misc/axp20x-pek.c
@@ -239,7 +239,7 @@ static int axp20x_pek_probe(struct platform_device *pdev)
 					     axp20x_pek_irq, 0,
 					     "axp20x-pek-dbr", idev);
 	if (error < 0) {
-		dev_err(axp20x->dev, "Failed to request dbr IRQ#%d: %d\n",
+		dev_err(&pdev->dev, "Failed to request dbr IRQ#%d: %d\n",
 			axp20x_pek->irq_dbr, error);
 		return error;
 	}
@@ -248,14 +248,14 @@ static int axp20x_pek_probe(struct platform_device *pdev)
 					  axp20x_pek_irq, 0,
 					  "axp20x-pek-dbf", idev);
 	if (error < 0) {
-		dev_err(axp20x->dev, "Failed to request dbf IRQ#%d: %d\n",
+		dev_err(&pdev->dev, "Failed to request dbf IRQ#%d: %d\n",
 			axp20x_pek->irq_dbf, error);
 		return error;
 	}
 
 	error = sysfs_create_group(&pdev->dev.kobj, &axp20x_attribute_group);
 	if (error) {
-		dev_err(axp20x->dev, "Failed to create sysfs attributes: %d\n",
+		dev_err(&pdev->dev, "Failed to create sysfs attributes: %d\n",
 			error);
 		return error;
 	}
@@ -271,7 +271,7 @@ static int axp20x_pek_probe(struct platform_device *pdev)
 
 	error = input_register_device(idev);
 	if (error) {
-		dev_err(axp20x->dev, "Can't register input device: %d\n",
+		dev_err(&pdev->dev, "Can't register input device: %d\n",
 			error);
 		return error;
 	}
-- 
2.9.3

