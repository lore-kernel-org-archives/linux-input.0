From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4/5] Input: misc/dm355evm_keys - drop unnecessary call to input_set_drvdata
Date: Sun, 22 Jan 2017 16:48:23 -0800
Message-ID: <1485132505-14562-5-git-send-email-linux@roeck-us.net>
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
 drivers/input/misc/dm355evm_keys.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/input/misc/dm355evm_keys.c b/drivers/input/misc/dm355evm_keys.c
index b6b7bd4e5462..82e272ebc0ed 100644
--- a/drivers/input/misc/dm355evm_keys.c
+++ b/drivers/input/misc/dm355evm_keys.c
@@ -195,8 +195,6 @@ static int dm355evm_keys_probe(struct platform_device *pdev)
 		goto fail1;
 	keys->irq = status;
 
-	input_set_drvdata(input, keys);
-
 	input->name = "DM355 EVM Controls";
 	input->phys = "dm355evm/input0";
 	input->dev.parent = &pdev->dev;
-- 
2.7.4
