From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: ims-pcu - switch to using brightness_set_blocking()
Date: Wed, 6 Feb 2019 10:08:56 -0800
Message-ID: <20190206180856.GA199121@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Chris Healy <cphealy@gmail.com>
List-Id: linux-input@vger.kernel.org

Now that LEDs core allows "blocking" flavor of "set brightness" method we
can use it and get rid of private work item.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/ims-pcu.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index 3d51175c4d72..74cf3b612f05 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -39,8 +39,6 @@ struct ims_pcu_gamepad {
 
 struct ims_pcu_backlight {
 	struct led_classdev cdev;
-	struct work_struct work;
-	enum led_brightness desired_brightness;
 	char name[32];
 };
 
@@ -949,14 +947,14 @@ static void ims_pcu_process_async_firmware(const struct firmware *fw,
 
 #define IMS_PCU_MAX_BRIGHTNESS		31998
 
-static void ims_pcu_backlight_work(struct work_struct *work)
+static int ims_pcu_backlight_set_brightness(struct led_classdev *cdev,
+					    enum led_brightness value)
 {
 	struct ims_pcu_backlight *backlight =
-			container_of(work, struct ims_pcu_backlight, work);
+			container_of(cdev, struct ims_pcu_backlight, cdev);
 	struct ims_pcu *pcu =
 			container_of(backlight, struct ims_pcu, backlight);
-	int desired_brightness = backlight->desired_brightness;
-	__le16 br_val = cpu_to_le16(desired_brightness);
+	__le16 br_val = cpu_to_le16(value);
 	int error;
 
 	mutex_lock(&pcu->cmd_mutex);
@@ -966,19 +964,11 @@ static void ims_pcu_backlight_work(struct work_struct *work)
 	if (error && error != -ENODEV)
 		dev_warn(pcu->dev,
 			 "Failed to set desired brightness %u, error: %d\n",
-			 desired_brightness, error);
+			 value, error);
 
 	mutex_unlock(&pcu->cmd_mutex);
-}
 
-static void ims_pcu_backlight_set_brightness(struct led_classdev *cdev,
-					     enum led_brightness value)
-{
-	struct ims_pcu_backlight *backlight =
-			container_of(cdev, struct ims_pcu_backlight, cdev);
-
-	backlight->desired_brightness = value;
-	schedule_work(&backlight->work);
+	return error;
 }
 
 static enum led_brightness
@@ -1015,14 +1005,14 @@ static int ims_pcu_setup_backlight(struct ims_pcu *pcu)
 	struct ims_pcu_backlight *backlight = &pcu->backlight;
 	int error;
 
-	INIT_WORK(&backlight->work, ims_pcu_backlight_work);
 	snprintf(backlight->name, sizeof(backlight->name),
 		 "pcu%d::kbd_backlight", pcu->device_no);
 
 	backlight->cdev.name = backlight->name;
 	backlight->cdev.max_brightness = IMS_PCU_MAX_BRIGHTNESS;
 	backlight->cdev.brightness_get = ims_pcu_backlight_get_brightness;
-	backlight->cdev.brightness_set = ims_pcu_backlight_set_brightness;
+	backlight->cdev.brightness_set_blocking =
+					 ims_pcu_backlight_set_brightness;
 
 	error = led_classdev_register(pcu->dev, &backlight->cdev);
 	if (error) {
@@ -1040,7 +1030,6 @@ static void ims_pcu_destroy_backlight(struct ims_pcu *pcu)
 	struct ims_pcu_backlight *backlight = &pcu->backlight;
 
 	led_classdev_unregister(&backlight->cdev);
-	cancel_work_sync(&backlight->work);
 }
 
 
-- 
2.20.1.611.gfbb209baf1-goog


-- 
Dmitry
