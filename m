From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: stmfts - acknowledge that setting brightness is a
 blocking call
Date: Tue, 5 Feb 2019 14:46:42 -0800
Message-ID: <20190205224642.GA182156@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Andi Shyti <andi@etezian.org>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

We need to turn regulators on and off when switching brightness, and
that may block, therefore we have to set stmfts_brightness_set() as
LED's brightness_set_blocking() method.

Fixes: 78bcac7b2ae1 ("Input: add support for the STMicroelectronics FingerTip touchscreen")
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/stmfts.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/input/touchscreen/stmfts.c b/drivers/input/touchscreen/stmfts.c
index 704e99046916..b6f95f20f924 100644
--- a/drivers/input/touchscreen/stmfts.c
+++ b/drivers/input/touchscreen/stmfts.c
@@ -106,27 +106,29 @@ struct stmfts_data {
 	bool running;
 };
 
-static void stmfts_brightness_set(struct led_classdev *led_cdev,
+static int stmfts_brightness_set(struct led_classdev *led_cdev,
 					enum led_brightness value)
 {
 	struct stmfts_data *sdata = container_of(led_cdev,
 					struct stmfts_data, led_cdev);
 	int err;
 
-	if (value == sdata->led_status || !sdata->ledvdd)
-		return;
-
-	if (!value) {
-		regulator_disable(sdata->ledvdd);
-	} else {
-		err = regulator_enable(sdata->ledvdd);
-		if (err)
-			dev_warn(&sdata->client->dev,
-				 "failed to disable ledvdd regulator: %d\n",
-				 err);
+	if (value != sdata->led_status && sdata->ledvdd) {
+		if (!value) {
+			regulator_disable(sdata->ledvdd);
+		} else {
+			err = regulator_enable(sdata->ledvdd);
+			if (err) {
+				dev_warn(&sdata->client->dev,
+					 "failed to disable ledvdd regulator: %d\n",
+					 err);
+				return err;
+			}
+		}
+		sdata->led_status = value;
 	}
 
-	sdata->led_status = value;
+	return 0;
 }
 
 static enum led_brightness stmfts_brightness_get(struct led_classdev *led_cdev)
@@ -608,7 +610,7 @@ static int stmfts_enable_led(struct stmfts_data *sdata)
 	sdata->led_cdev.name = STMFTS_DEV_NAME;
 	sdata->led_cdev.max_brightness = LED_ON;
 	sdata->led_cdev.brightness = LED_OFF;
-	sdata->led_cdev.brightness_set = stmfts_brightness_set;
+	sdata->led_cdev.brightness_set_blocking = stmfts_brightness_set;
 	sdata->led_cdev.brightness_get = stmfts_brightness_get;
 
 	err = devm_led_classdev_register(&sdata->client->dev, &sdata->led_cdev);
-- 
2.20.1.611.gfbb209baf1-goog


-- 
Dmitry
