From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 1/4] Input: mms114 - do not clobber interrupt trigger
Date: Wed, 24 Jan 2018 11:38:01 -0800
Message-ID: <20180124193804.155654-2-dmitry.torokhov@gmail.com>
References: <20180124193804.155654-1-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34620 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932304AbeAXTiL (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 24 Jan 2018 14:38:11 -0500
In-Reply-To: <20180124193804.155654-1-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Shields <simon@lineageos.org>, Andi Shyti <andi.shyti@samsung.com>
Cc: Rob Herring <robh@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Rely on the platform (device tree, ACPI, etc) to properly configure
interrupt trigger/polarity instead of hardcoding the falling edge.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/mms114.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
index e5eeb6311f7de..92f2e9da351f1 100644
--- a/drivers/input/touchscreen/mms114.c
+++ b/drivers/input/touchscreen/mms114.c
@@ -497,9 +497,9 @@ static int mms114_probe(struct i2c_client *client,
 		return error;
 	}
 
-	error = devm_request_threaded_irq(&client->dev, client->irq, NULL,
-			mms114_interrupt, IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-			dev_name(&client->dev), data);
+	error = devm_request_threaded_irq(&client->dev, client->irq,
+					  NULL, mms114_interrupt, IRQF_ONESHOT,
+					  dev_name(&client->dev), data);
 	if (error) {
 		dev_err(&client->dev, "Failed to register interrupt\n");
 		return error;
-- 
2.16.0.rc1.238.g530d649a79-goog

