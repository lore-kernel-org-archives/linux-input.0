From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 2/5] Input: joystick/maplecontrol - drop unnecessary call to input_set_drvdata
Date: Sun, 22 Jan 2017 16:48:21 -0800
Message-ID: <1485132505-14562-3-git-send-email-linux@roeck-us.net>
References: <1485132505-14562-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1485132505-14562-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-input@vger.kernel.org

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
 drivers/input/joystick/maplecontrol.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/joystick/maplecontrol.c b/drivers/input/joystick/maplecontrol.c
index 8aa6e4c497da..ff54e195d42c 100644
--- a/drivers/input/joystick/maplecontrol.c
+++ b/drivers/input/joystick/maplecontrol.c
@@ -139,7 +139,6 @@ static int probe_maple_controller(struct device *dev)
 	idev->dev.parent = &mdev->dev;
 	idev->name = mdev->product_name;
 	idev->id.bustype = BUS_HOST;
-	input_set_drvdata(idev, pad);
 
 	error = input_register_device(idev);
 	if (error)
-- 
2.7.4
