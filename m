From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH v2 1/2] input: misc: pwm-vibra: Prevent unbalanced regulator
Date: Thu, 24 Jan 2019 21:27:31 +0100
Message-ID: <20190124202732.14723-1-pawel.mikolaj.chmiel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Bakker <xc-racer2@live.ca>, =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
List-Id: linux-input@vger.kernel.org

From: Jonathan Bakker <xc-racer2@live.ca>

pwm_vibrator_stop disables the regulator, but it can be called from
multiple places, even when the regulator is already disabled. Fix this
by using regulator_is_enabled check when starting and stopping device.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
Changes from v1:
  - Rather than using regulator_is_enabled api, use local flag for
    checking if regulator is enabled
---
 drivers/input/misc/pwm-vibra.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/input/misc/pwm-vibra.c b/drivers/input/misc/pwm-vibra.c
index 55da191ae550..9df87431d7d4 100644
--- a/drivers/input/misc/pwm-vibra.c
+++ b/drivers/input/misc/pwm-vibra.c
@@ -34,6 +34,7 @@ struct pwm_vibrator {
 	struct work_struct play_work;
 	u16 level;
 	u32 direction_duty_cycle;
+	bool vcc_on;
 };
 
 static int pwm_vibrator_start(struct pwm_vibrator *vibrator)
@@ -42,10 +43,13 @@ static int pwm_vibrator_start(struct pwm_vibrator *vibrator)
 	struct pwm_state state;
 	int err;
 
-	err = regulator_enable(vibrator->vcc);
-	if (err) {
-		dev_err(pdev, "failed to enable regulator: %d", err);
-		return err;
+	if (!vibrator->vcc_on) {
+		err = regulator_enable(vibrator->vcc);
+		if (err) {
+			dev_err(pdev, "failed to enable regulator: %d", err);
+			return err;
+		}
+		vibrator->vcc_on = true;
 	}
 
 	pwm_get_state(vibrator->pwm, &state);
@@ -76,7 +80,10 @@ static int pwm_vibrator_start(struct pwm_vibrator *vibrator)
 
 static void pwm_vibrator_stop(struct pwm_vibrator *vibrator)
 {
-	regulator_disable(vibrator->vcc);
+	if (vibrator->vcc_on) {
+		regulator_disable(vibrator->vcc);
+		vibrator->vcc_on = false;
+	}
 
 	if (vibrator->pwm_dir)
 		pwm_disable(vibrator->pwm_dir);
-- 
2.17.1
