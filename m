From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 24/35 linux-next] Input: constify of_device_id array
Date: Mon, 16 Mar 2015 20:54:34 +0100
Message-ID: <1426535685-25996-3-git-send-email-fabf@skynet.be>
References: <1426533469-25458-1-git-send-email-fabf@skynet.be>
 <1426535685-25996-1-git-send-email-fabf@skynet.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426535685-25996-1-git-send-email-fabf@skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Fabian Frederick <fabf@skynet.be>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

of_device_id is always used as const.
(See driver.of_match_table and open firmware functions)

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/input/misc/palmas-pwrbutton.c   | 2 +-
 drivers/input/misc/regulator-haptic.c   | 2 +-
 drivers/input/misc/tps65218-pwrbutton.c | 2 +-
 drivers/input/touchscreen/ar1021_i2c.c  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/misc/palmas-pwrbutton.c b/drivers/input/misc/palmas-pwrbutton.c
index 1f9b5ee..1e1baed 100644
--- a/drivers/input/misc/palmas-pwrbutton.c
+++ b/drivers/input/misc/palmas-pwrbutton.c
@@ -304,7 +304,7 @@ static SIMPLE_DEV_PM_OPS(palmas_pwron_pm,
 			 palmas_pwron_suspend, palmas_pwron_resume);
 
 #ifdef CONFIG_OF
-static struct of_device_id of_palmas_pwr_match[] = {
+static const struct of_device_id of_palmas_pwr_match[] = {
 	{ .compatible = "ti,palmas-pwrbutton" },
 	{ },
 };
diff --git a/drivers/input/misc/regulator-haptic.c b/drivers/input/misc/regulator-haptic.c
index 132eb91..6bf3f10 100644
--- a/drivers/input/misc/regulator-haptic.c
+++ b/drivers/input/misc/regulator-haptic.c
@@ -245,7 +245,7 @@ static int __maybe_unused regulator_haptic_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(regulator_haptic_pm_ops,
 		regulator_haptic_suspend, regulator_haptic_resume);
 
-static struct of_device_id regulator_haptic_dt_match[] = {
+static const struct of_device_id regulator_haptic_dt_match[] = {
 	{ .compatible = "regulator-haptic" },
 	{ /* sentinel */ },
 };
diff --git a/drivers/input/misc/tps65218-pwrbutton.c b/drivers/input/misc/tps65218-pwrbutton.c
index 54508dec..a39b626 100644
--- a/drivers/input/misc/tps65218-pwrbutton.c
+++ b/drivers/input/misc/tps65218-pwrbutton.c
@@ -106,7 +106,7 @@ static int tps65218_pwron_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id of_tps65218_pwr_match[] = {
+static const struct of_device_id of_tps65218_pwr_match[] = {
 	{ .compatible = "ti,tps65218-pwrbutton" },
 	{ },
 };
diff --git a/drivers/input/touchscreen/ar1021_i2c.c b/drivers/input/touchscreen/ar1021_i2c.c
index ba30578..f0b954d 100644
--- a/drivers/input/touchscreen/ar1021_i2c.c
+++ b/drivers/input/touchscreen/ar1021_i2c.c
@@ -157,7 +157,7 @@ static const struct i2c_device_id ar1021_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, ar1021_i2c_id);
 
-static struct of_device_id ar1021_i2c_of_match[] = {
+static const struct of_device_id ar1021_i2c_of_match[] = {
 	{ .compatible = "microchip,ar1021-i2c", },
 	{ }
 };
-- 
2.1.0
