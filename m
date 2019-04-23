From: Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH next 10/25] input: misc: Use dev_get_drvdata()
Date: Tue, 23 Apr 2019 15:50:05 +0800
Message-ID: <20190423075020.173734-11-wangkefeng.wang@huawei.com>
References: <20190423075020.173734-1-wangkefeng.wang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190423075020.173734-1-wangkefeng.wang@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Using dev_get_drvdata directly.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/input/misc/max77693-haptic.c  |  6 ++----
 drivers/input/misc/max8925_onkey.c    | 10 ++++------
 drivers/input/misc/max8997_haptic.c   |  3 +--
 drivers/input/misc/msm-vibrator.c     |  6 ++----
 drivers/input/misc/palmas-pwrbutton.c |  6 ++----
 drivers/input/misc/regulator-haptic.c |  6 ++----
 drivers/input/misc/stpmic1_onkey.c    |  6 ++----
 drivers/input/misc/twl4030-vibra.c    |  3 +--
 drivers/input/misc/twl6040-vibra.c    |  3 +--
 9 files changed, 17 insertions(+), 32 deletions(-)

diff --git a/drivers/input/misc/max77693-haptic.c b/drivers/input/misc/max77693-haptic.c
index 46b0f48fbf49..8968fd48e95c 100644
--- a/drivers/input/misc/max77693-haptic.c
+++ b/drivers/input/misc/max77693-haptic.c
@@ -381,8 +381,7 @@ static int max77693_haptic_probe(struct platform_device *pdev)
 
 static int __maybe_unused max77693_haptic_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct max77693_haptic *haptic = platform_get_drvdata(pdev);
+	struct max77693_haptic *haptic = dev_get_drvdata(dev);
 
 	if (haptic->enabled) {
 		max77693_haptic_disable(haptic);
@@ -394,8 +393,7 @@ static int __maybe_unused max77693_haptic_suspend(struct device *dev)
 
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
index 99bc762881d5..5ffb0ac68d50 100644
--- a/drivers/input/misc/max8997_haptic.c
+++ b/drivers/input/misc/max8997_haptic.c
@@ -388,8 +388,7 @@ static int max8997_haptic_remove(struct platform_device *pdev)
 
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
index a1db1e5040dc..0b78a87f3192 100644
--- a/drivers/input/misc/regulator-haptic.c
+++ b/drivers/input/misc/regulator-haptic.c
@@ -206,8 +206,7 @@ static int regulator_haptic_probe(struct platform_device *pdev)
 
 static int __maybe_unused regulator_haptic_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct regulator_haptic *haptic = platform_get_drvdata(pdev);
+	struct regulator_haptic *haptic = dev_get_drvdata(dev);
 	int error;
 
 	error = mutex_lock_interruptible(&haptic->mutex);
@@ -225,8 +224,7 @@ static int __maybe_unused regulator_haptic_suspend(struct device *dev)
 
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
index c37aea9ac272..7b9104c058ca 100644
--- a/drivers/input/misc/twl4030-vibra.c
+++ b/drivers/input/misc/twl4030-vibra.c
@@ -159,8 +159,7 @@ static void twl4030_vibra_close(struct input_dev *input)
 /*** Module ***/
 static int __maybe_unused twl4030_vibra_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct vibra_info *info = platform_get_drvdata(pdev);
+	struct vibra_info *info = dev_get_drvdata(dev);
 
 	if (info->enabled)
 		vibra_disable(info);
diff --git a/drivers/input/misc/twl6040-vibra.c b/drivers/input/misc/twl6040-vibra.c
index 15e0d352c4cc..c8539a4a98c6 100644
--- a/drivers/input/misc/twl6040-vibra.c
+++ b/drivers/input/misc/twl6040-vibra.c
@@ -226,8 +226,7 @@ static void twl6040_vibra_close(struct input_dev *input)
 
 static int __maybe_unused twl6040_vibra_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct vibra_info *info = platform_get_drvdata(pdev);
+	struct vibra_info *info = dev_get_drvdata(dev);
 
 	cancel_work_sync(&info->play_work);
 
-- 
2.20.1
