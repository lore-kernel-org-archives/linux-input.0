From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 1/3] Input: axp20x-pek - Use our own device for errors
Date: Mon,  9 Jan 2017 18:56:42 +0100
Message-ID: <20170109175644.12767-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41206 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1422779AbdAIR4r (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 9 Jan 2017 12:56:47 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, Gregor Riepl <onitake@gmail.com>, linux-input@vger.kernel.org

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

