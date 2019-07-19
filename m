From: Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] Input: misc - Use dev_get_drvdata
Date: Fri, 19 Jul 2019 19:11:16 +0800
Message-ID: <20190719111115.21310-1-hslester96@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
List-Id: linux-input@vger.kernel.org

dev_get_drvdata is a simpler implementation comparing
to to_platform_device + platform_get_drvdata.
This makes the code simpler.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/input/misc/gpio-vibra.c       |  6 ++----
 drivers/input/misc/max77693-haptic.c  |  6 ++----
 drivers/input/misc/max8925_onkey.c    | 10 ++++------
 drivers/input/misc/max8997_haptic.c   |  3 +--
 drivers/input/misc/msm-vibrator.c     |  6 ++----
 drivers/input/misc/palmas-pwrbutton.c |  6 ++----
 drivers/input/misc/regulator-haptic.c |  6 ++----
 drivers/input/misc/stpmic1_onkey.c    |  6 ++----
 drivers/input/misc/twl4030-vibra.c    |  3 +--
 drivers/input/misc/twl6040-vibra.c    |  3 +--
 10 files changed, 19 insertions(+), 36 deletions(-)

diff --git a/drivers/input/misc/gpio-vibra.c b/drivers/input/misc/gpio-vibra.c
index f79f75595dd7..ad30cb5b1523 100644
--- a/drivers/input/misc/gpio-vibra.c
+++ b/drivers/input/misc/gpio-vibra.c
@@ -159,8 +159,7 @@ static int gpio_vibrator_probe(struct platform_device *pdev)
 
 static int __maybe_unused gpio_vibrator_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct gpio_vibrator *vibrator = platform_get_drvdata(pdev);
+	struct gpio_vibrator *vibrator = dev_get_drvdata(dev);
 
 	cancel_work_sync(&vibrator->play_work);
 	if (vibrator->running)
@@ -171,8 +170,7 @@ static int __maybe_unused gpio_vibrator_suspend(struct device *dev)
 
 static int __maybe_unused gpio_vibrator_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct gpio_vibrator *vibrator = platform_get_drvdata(pdev);
+	struct gpio_vibrator *vibrator = dev_get_drvdata(dev);
 
 	if (vibrator->running)
 		gpio_vibrator_start(vibrator);
diff --git a/drivers/input/misc/max77693-haptic.c b/drivers/input/misc/max77693-haptic.c
index 0d09ffeafeea..86e1c72efda1 100644
--- a/drivers/input/misc/max77693-haptic.c
+++ b/drivers/input/misc/max77693-haptic.c
@@ -377,8 +377,7 @@ static int max77693_haptic_probe(struct platform_device *pdev)
 
 static int __maybe_unused max77693_haptic_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct max77693_haptic *haptic = platform_get_drvdata(pdev);
+	struct max77693_haptic *haptic = dev_get_drvdata(dev);
 
 	if (haptic->enabled) {
 		max77693_haptic_disable(haptic);
@@ -390,8 +389,7 @@ static int __maybe_unused max77693_haptic_suspend(struct device *dev)
 
 static int __maybe_unused max77693_haptic_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct max77693_haptic *haptic = platform_get_drvdata(pdev);
+	struct max77693_haptic *haptic = dev_get_drvdata(dev);
 
 	if (haptic->suspend_state) {
 		max77693_haptic_enable(haptic);
diff --git a/drivers/input/misc/max8925_onkey.c b/drivers/input/misc/max8925_onkey.c
index 7c49b8d23894..af0ba592a0b3 100644
--- a/drivers/input/misc/max8925_onkey.c
+++ b/drivers/input/misc/max8925_onkey.c
@@ -135,9 +135,8 @@ static int max8925_onkey_probe(struct platform_device *pdev)
 
 static int __maybe_unused max8925_onkey_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct max8925_onkey_info *info = platform_get_drvdata(pdev);
-	struct max8925_chip *chip = dev_get_drvdata(pdev->dev.parent);
+	struct max8925_onkey_info *info = dev_get_drvdata(dev);
+	struct max8925_chip *chip = dev_get_drvdata(dev->parent);
 
 	if (device_may_wakeup(dev)) {
 		chip->wakeup_flag |= 1 << info->irq[0];
@@ -149,9 +148,8 @@ static int __maybe_unused max8925_onkey_suspend(struct device *dev)
 
 static int __maybe_unused max8925_onkey_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct max8925_onkey_info *info = platform_get_drvdata(pdev);
-	struct max8925_chip *chip = dev_get_drvdata(pdev->dev.parent);
+	struct max8925_onkey_info *info = dev_get_drvdata(dev);
+	struct max8925_chip *chip = dev_get_drvdata(dev->parent);
 
 	if (device_may_wakeup(dev)) {
 		chip->wakeup_flag &= ~(1 << info->irq[0]);
diff --git a/drivers/input/misc/max8997_haptic.c b/drivers/input/misc/max8997_haptic.c
index 20ff087b8a44..e841b8e4b1d4 100644
--- a/drivers/input/misc/max8997_haptic.c
+++ b/drivers/input/misc/max8997_haptic.c
@@ -374,8 +374,7 @@ static int max8997_haptic_remove(struct platform_device *pdev)
 
 static int __maybe_unused max8997_haptic_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct max8997_haptic *chip = platform_get_drvdata(pdev);
+	struct max8997_haptic *chip = dev_get_drvdata(dev);
 
 	max8997_haptic_disable(chip);
 
diff --git a/drivers/input/misc/msm-vibrator.c b/drivers/input/misc/msm-vibrator.c
index b60f1aaee705..a28974bfb64e 100644
--- a/drivers/input/misc/msm-vibrator.c
+++ b/drivers/input/misc/msm-vibrator.c
@@ -234,8 +234,7 @@ static int msm_vibrator_probe(struct platform_device *pdev)
 
 static int __maybe_unused msm_vibrator_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct msm_vibrator *vibrator = platform_get_drvdata(pdev);
+	struct msm_vibrator *vibrator = dev_get_drvdata(dev);
 
 	cancel_work_sync(&vibrator->worker);
 
@@ -247,8 +246,7 @@ static int __maybe_unused msm_vibrator_suspend(struct device *dev)
 
 static int __maybe_unused msm_vibrator_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct msm_vibrator *vibrator = platform_get_drvdata(pdev);
+	struct msm_vibrator *vibrator = dev_get_drvdata(dev);
 
 	if (vibrator->enabled)
 		msm_vibrator_start(vibrator);
diff --git a/drivers/input/misc/palmas-pwrbutton.c b/drivers/input/misc/palmas-pwrbutton.c
index 1e1baed63929..27617868b292 100644
--- a/drivers/input/misc/palmas-pwrbutton.c
+++ b/drivers/input/misc/palmas-pwrbutton.c
@@ -270,8 +270,7 @@ static int palmas_pwron_remove(struct platform_device *pdev)
  */
 static int __maybe_unused palmas_pwron_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct palmas_pwron *pwron = platform_get_drvdata(pdev);
+	struct palmas_pwron *pwron = dev_get_drvdata(dev);
 
 	cancel_delayed_work_sync(&pwron->input_work);
 
@@ -291,8 +290,7 @@ static int __maybe_unused palmas_pwron_suspend(struct device *dev)
  */
 static int __maybe_unused palmas_pwron_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct palmas_pwron *pwron = platform_get_drvdata(pdev);
+	struct palmas_pwron *pwron = dev_get_drvdata(dev);
 
 	if (device_may_wakeup(dev))
 		disable_irq_wake(pwron->irq);
diff --git a/drivers/input/misc/regulator-haptic.c b/drivers/input/misc/regulator-haptic.c
index a661e77545c5..9734374964f2 100644
--- a/drivers/input/misc/regulator-haptic.c
+++ b/drivers/input/misc/regulator-haptic.c
@@ -203,8 +203,7 @@ static int regulator_haptic_probe(struct platform_device *pdev)
 
 static int __maybe_unused regulator_haptic_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct regulator_haptic *haptic = platform_get_drvdata(pdev);
+	struct regulator_haptic *haptic = dev_get_drvdata(dev);
 	int error;
 
 	error = mutex_lock_interruptible(&haptic->mutex);
@@ -222,8 +221,7 @@ static int __maybe_unused regulator_haptic_suspend(struct device *dev)
 
 static int __maybe_unused regulator_haptic_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct regulator_haptic *haptic = platform_get_drvdata(pdev);
+	struct regulator_haptic *haptic = dev_get_drvdata(dev);
 	unsigned int magnitude;
 
 	mutex_lock(&haptic->mutex);
diff --git a/drivers/input/misc/stpmic1_onkey.c b/drivers/input/misc/stpmic1_onkey.c
index 7b49c9997df7..ff4761540539 100644
--- a/drivers/input/misc/stpmic1_onkey.c
+++ b/drivers/input/misc/stpmic1_onkey.c
@@ -150,8 +150,7 @@ static int stpmic1_onkey_probe(struct platform_device *pdev)
 
 static int __maybe_unused stpmic1_onkey_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct stpmic1_onkey *onkey = platform_get_drvdata(pdev);
+	struct stpmic1_onkey *onkey = dev_get_drvdata(dev);
 
 	if (device_may_wakeup(dev)) {
 		enable_irq_wake(onkey->irq_falling);
@@ -162,8 +161,7 @@ static int __maybe_unused stpmic1_onkey_suspend(struct device *dev)
 
 static int __maybe_unused stpmic1_onkey_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct stpmic1_onkey *onkey = platform_get_drvdata(pdev);
+	struct stpmic1_onkey *onkey = dev_get_drvdata(dev);
 
 	if (device_may_wakeup(dev)) {
 		disable_irq_wake(onkey->irq_falling);
diff --git a/drivers/input/misc/twl4030-vibra.c b/drivers/input/misc/twl4030-vibra.c
index e0ff616fb857..f7ef67997863 100644
--- a/drivers/input/misc/twl4030-vibra.c
+++ b/drivers/input/misc/twl4030-vibra.c
@@ -145,8 +145,7 @@ static void twl4030_vibra_close(struct input_dev *input)
 /*** Module ***/
 static int __maybe_unused twl4030_vibra_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct vibra_info *info = platform_get_drvdata(pdev);
+	struct vibra_info *info = dev_get_drvdata(dev);
 
 	if (info->enabled)
 		vibra_disable(info);
diff --git a/drivers/input/misc/twl6040-vibra.c b/drivers/input/misc/twl6040-vibra.c
index 93235a007d07..900be3420967 100644
--- a/drivers/input/misc/twl6040-vibra.c
+++ b/drivers/input/misc/twl6040-vibra.c
@@ -212,8 +212,7 @@ static void twl6040_vibra_close(struct input_dev *input)
 
 static int __maybe_unused twl6040_vibra_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct vibra_info *info = platform_get_drvdata(pdev);
+	struct vibra_info *info = dev_get_drvdata(dev);
 
 	cancel_work_sync(&info->play_work);
 
-- 
2.20.1
