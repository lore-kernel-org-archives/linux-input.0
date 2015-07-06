From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: arizona-haptic - convert to use managed input devices
Date: Mon, 6 Jul 2015 10:38:41 -0700
Message-ID: <20150706173841.GA31110@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Using managed input device (via devm_input_allocate_device) simplifies
error handling and driver removal paths and also silences CID# 712569.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/arizona-haptics.c | 52 ++++++++++++------------------------
 1 file changed, 17 insertions(+), 35 deletions(-)

diff --git a/drivers/input/misc/arizona-haptics.c b/drivers/input/misc/arizona-haptics.c
index 4dbbed7..54ebef2 100644
--- a/drivers/input/misc/arizona-haptics.c
+++ b/drivers/input/misc/arizona-haptics.c
@@ -152,7 +152,7 @@ static int arizona_haptics_probe(struct platform_device *pdev)
 {
 	struct arizona *arizona = dev_get_drvdata(pdev->dev.parent);
 	struct arizona_haptics *haptics;
-	int ret;
+	int error;
 
 	haptics = devm_kzalloc(&pdev->dev, sizeof(*haptics), GFP_KERNEL);
 	if (!haptics)
@@ -160,18 +160,18 @@ static int arizona_haptics_probe(struct platform_device *pdev)
 
 	haptics->arizona = arizona;
 
-	ret = regmap_update_bits(arizona->regmap, ARIZONA_HAPTICS_CONTROL_1,
-				 ARIZONA_HAP_ACT, arizona->pdata.hap_act);
-	if (ret != 0) {
+	error = regmap_update_bits(arizona->regmap, ARIZONA_HAPTICS_CONTROL_1,
+				   ARIZONA_HAP_ACT, arizona->pdata.hap_act);
+	if (error) {
 		dev_err(arizona->dev, "Failed to set haptics actuator: %d\n",
-			ret);
-		return ret;
+			error);
+		return error;
 	}
 
 	INIT_WORK(&haptics->work, arizona_haptics_work);
 
-	haptics->input_dev = input_allocate_device();
-	if (haptics->input_dev == NULL) {
+	haptics->input_dev = devm_input_allocate_device(&pdev->dev);
+	if (!haptics->input_dev) {
 		dev_err(arizona->dev, "Failed to allocate input device\n");
 		return -ENOMEM;
 	}
@@ -183,46 +183,28 @@ static int arizona_haptics_probe(struct platform_device *pdev)
 	haptics->input_dev->close = arizona_haptics_close;
 	__set_bit(FF_RUMBLE, haptics->input_dev->ffbit);
 
-	ret = input_ff_create_memless(haptics->input_dev, NULL,
-				      arizona_haptics_play);
-	if (ret < 0) {
+	error = input_ff_create_memless(haptics->input_dev, NULL,
+					arizona_haptics_play);
+	if (error) {
 		dev_err(arizona->dev, "input_ff_create_memless() failed: %d\n",
-			ret);
-		goto err_ialloc;
+			error);
+		return error;
 	}
 
-	ret = input_register_device(haptics->input_dev);
-	if (ret < 0) {
+	error = input_register_device(haptics->input_dev);
+	if (error) {
 		dev_err(arizona->dev, "couldn't register input device: %d\n",
-			ret);
-		goto err_iff;
+			error);
+		return error;
 	}
 
 	platform_set_drvdata(pdev, haptics);
 
 	return 0;
-
-err_iff:
-	if (haptics->input_dev)
-		input_ff_destroy(haptics->input_dev);
-err_ialloc:
-	input_free_device(haptics->input_dev);
-
-	return ret;
-}
-
-static int arizona_haptics_remove(struct platform_device *pdev)
-{
-	struct arizona_haptics *haptics = platform_get_drvdata(pdev);
-
-	input_unregister_device(haptics->input_dev);
-
-	return 0;
 }
 
 static struct platform_driver arizona_haptics_driver = {
 	.probe		= arizona_haptics_probe,
-	.remove		= arizona_haptics_remove,
 	.driver		= {
 		.name	= "arizona-haptics",
 	},
-- 
2.4.3.573.g4eafbef


-- 
Dmitry
