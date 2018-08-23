From: Derek Basehore <dbasehore@chromium.org>
Subject: [PATCH] Input: elants_i2c - Fix sw reset delays
Date: Thu, 23 Aug 2018 16:10:13 -0700
Message-ID: <20180823231013.254037-1-dbasehore@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org, joe@perches.com, andi@etezian.org, gregkh@linuxfoundation.org, dmitry.torokhov@gmail.com, Derek Basehore <dbasehore@chromium.org>
List-Id: linux-input@vger.kernel.org

We only need to wait 10ms instead of 30ms before starting fastboot or
sending IAP on the touchscreen. Also, instead of delaying everytime
sw_reset is called, this delays 10ms in the function that starts
fastboot. There's also an explicit 20ms delay before sending IAP when
updating the firmware, so no additional delay is needed there. This
change also has the benefit of not delaying when wakeup is enabled
during suspend. This is because sw_reset is called, yet fastboot
isn't.

Change-Id: I9e3019720186ba0023891fafeb4fe3d2510e454b
Signed-off-by: Derek Basehore <dbasehore@chromium.org>
---
 drivers/input/touchscreen/elants_i2c.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/elants_i2c.c b/drivers/input/touchscreen/elants_i2c.c
index d21ca39b0fdb..18ce04ba0173 100644
--- a/drivers/input/touchscreen/elants_i2c.c
+++ b/drivers/input/touchscreen/elants_i2c.c
@@ -284,12 +284,6 @@ static int elants_i2c_sw_reset(struct i2c_client *client)
 		return error;
 	}
 
-	/*
-	 * We should wait at least 10 msec (but no more than 40) before
-	 * sending fastboot or IAP command to the device.
-	 */
-	msleep(30);
-
 	return 0;
 }
 
@@ -500,6 +494,12 @@ static int elants_i2c_fastboot(struct i2c_client *client)
 	const u8 boot_cmd[] = { 0x4D, 0x61, 0x69, 0x6E };
 	int error;
 
+	/*
+	 * We should wait at least 10 msec (but no more than 40) before sending
+	 * fastboot command to the device.
+	 */
+	usleep_range(10 * 1000, 11 * 1000);
+
 	error = elants_i2c_send(client, boot_cmd, sizeof(boot_cmd));
 	if (error) {
 		dev_err(&client->dev, "boot failed: %d\n", error);
@@ -643,6 +643,10 @@ static int elants_i2c_do_update_firmware(struct i2c_client *client,
 			dev_err(&client->dev, "Failed close idle: %d\n", error);
 		msleep(60);
 		elants_i2c_sw_reset(client);
+		/*
+		 * We should wait at least 10 msec (but no more than 40) before
+		 * sending IAP command to the device.
+		 */
 		msleep(20);
 		error = elants_i2c_send(client, enter_iap, sizeof(enter_iap));
 	}
-- 
2.19.0.rc0.228.g281dcd1b4d0-goog
