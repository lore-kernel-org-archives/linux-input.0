From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 3/5] Input: mouse - drop unnecessary calls to input_set_drvdata
Date: Sun, 22 Jan 2017 16:48:22 -0800
Message-ID: <1485132505-14562-4-git-send-email-linux@roeck-us.net>
References: <1485132505-14562-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:54145 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750704AbdAWAtD (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 22 Jan 2017 19:49:03 -0500
In-Reply-To: <1485132505-14562-1-git-send-email-linux@roeck-us.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>

Since there is no call to dev_get_drvdata() or input_get_drvdata(),
the call to input_set_drvdata() is unnecessary and can be dropped.

The conversion was done automatically using the following coccinelle
script.

@used@
@@

(
input_get_drvdata(...)
|
dev_get_drvdata(...)
)

@depends on !used@
@@

- input_set_drvdata(...);

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/input/mouse/cypress_ps2.c | 2 --
 drivers/input/mouse/maplemouse.c  | 1 -
 2 files changed, 3 deletions(-)

diff --git a/drivers/input/mouse/cypress_ps2.c b/drivers/input/mouse/cypress_ps2.c
index faa3a980d4f5..21bad3e75fee 100644
--- a/drivers/input/mouse/cypress_ps2.c
+++ b/drivers/input/mouse/cypress_ps2.c
@@ -414,8 +414,6 @@ static int cypress_set_input_params(struct input_dev *input,
 	__set_bit(BTN_RIGHT, input->keybit);
 	__set_bit(BTN_MIDDLE, input->keybit);
 
-	input_set_drvdata(input, cytp);
-
 	return 0;
 }
 
diff --git a/drivers/input/mouse/maplemouse.c b/drivers/input/mouse/maplemouse.c
index 0a60717b91c6..25f0ecb90126 100644
--- a/drivers/input/mouse/maplemouse.c
+++ b/drivers/input/mouse/maplemouse.c
@@ -87,7 +87,6 @@ static int probe_maple_mouse(struct device *dev)
 	mse->dev = input_dev;
 	mse->mdev = mdev;
 
-	input_set_drvdata(input_dev, mse);
 	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REL);
 	input_dev->keybit[BIT_WORD(BTN_MOUSE)] = BIT_MASK(BTN_LEFT) |
 		BIT_MASK(BTN_RIGHT) | BIT_MASK(BTN_MIDDLE);
-- 
2.7.4

