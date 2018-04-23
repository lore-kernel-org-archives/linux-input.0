From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv2] Input: atmel_mxt_ts - fix reset-gpio for level based irqs
Date: Mon, 23 Apr 2018 13:58:44 +0200
Message-ID: <20180423115844.26281-1-sebastian.reichel@collabora.co.uk>
References: <20180420172408.26164-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180420172408.26164-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Dyer <nick@shmanahar.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ezequiel Garcia <ezequiel@collabora.com>, kernel@collabora.com, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-input@vger.kernel.org

The current reset-gpio support triggers an interrupt storm on platforms
using the maxtouch with level based interrupt. The Motorola Droid 4,
which I used for some of the tests is not affected, since it uses a edge
based interrupt.

This change avoids the interrupt storm by enabling the device while its
interrupt is disabled. Afterwards we wait 100ms. This is important for
two reasons: The device is unresponsive for some time (~22ms for
mxt224E) and the CHG (interrupt) line is not working properly for 100ms.
We don't need to wait for any following interrupts, since the following
mxt_initialize() checks for bootloader mode anyways.

This fixes a boot issue on GE PPD (watchdog kills device due to
interrupt storm) and does not cause regression on Motorola Droid 4.

Fixes: f657b00df22e ("Input: atmel_mxt_ts - add support for reset line")
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
Changes since PATCHv2:
 * fix patch description
 * use same timeout value for soft and gpio-reset
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 5d9699fe1b55..f97fbb0af020 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -194,6 +194,8 @@ enum t100_type {
 
 /* Delay times */
 #define MXT_BACKUP_TIME		50	/* msec */
+#define MXT_RESET_GPIO_TIME	20	/* msec */
+#define MXT_RESET_INVALID_CHG	100	/* msec */
 #define MXT_RESET_TIME		200	/* msec */
 #define MXT_RESET_TIMEOUT	3000	/* msec */
 #define MXT_CRC_TIMEOUT		1000	/* msec */
@@ -1206,7 +1208,7 @@ static int mxt_soft_reset(struct mxt_data *data)
 		return ret;
 
 	/* Ignore CHG line for 100ms after reset */
-	msleep(100);
+	msleep(MXT_RESET_INVALID_CHG);
 
 	mxt_acquire_irq(data);
 
@@ -3167,20 +3169,14 @@ static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		return error;
 	}
 
+	disable_irq(client->irq);
+
 	if (data->reset_gpio) {
-		data->in_bootloader = true;
-		msleep(MXT_RESET_TIME);
-		reinit_completion(&data->bl_completion);
+		msleep(MXT_RESET_GPIO_TIME);
 		gpiod_set_value(data->reset_gpio, 1);
-		error = mxt_wait_for_completion(data, &data->bl_completion,
-						MXT_RESET_TIMEOUT);
-		if (error)
-			return error;
-		data->in_bootloader = false;
+		msleep(MXT_RESET_INVALID_CHG);
 	}
 
-	disable_irq(client->irq);
-
 	error = mxt_initialize(data);
 	if (error)
 		return error;
-- 
2.17.0
