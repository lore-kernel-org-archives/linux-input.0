From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH v2 2/2] input: misc: pwm-vibra: Stop regulator after disabling pwm, not before
Date: Thu, 24 Jan 2019 21:27:32 +0100
Message-ID: <20190124202732.14723-2-pawel.mikolaj.chmiel@gmail.com>
References: <20190124202732.14723-1-pawel.mikolaj.chmiel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190124202732.14723-1-pawel.mikolaj.chmiel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
List-Id: linux-input@vger.kernel.org

This patch fixes order of disable calls in pwm_vibrator_stop.
Currently when starting device, we first enable vcc regulator and then
setup and enable pwm. When stopping, we should do this in oposite order,
so first disable pwm and then disable regulator.
Previously order was the same as in start.

Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 drivers/input/misc/pwm-vibra.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/misc/pwm-vibra.c b/drivers/input/misc/pwm-vibra.c
index 9df87431d7d4..dbb6d9e1b947 100644
--- a/drivers/input/misc/pwm-vibra.c
+++ b/drivers/input/misc/pwm-vibra.c
@@ -80,14 +80,14 @@ static int pwm_vibrator_start(struct pwm_vibrator *vibrator)
 
 static void pwm_vibrator_stop(struct pwm_vibrator *vibrator)
 {
+	if (vibrator->pwm_dir)
+		pwm_disable(vibrator->pwm_dir);
+	pwm_disable(vibrator->pwm);
+
 	if (vibrator->vcc_on) {
 		regulator_disable(vibrator->vcc);
 		vibrator->vcc_on = false;
 	}
-
-	if (vibrator->pwm_dir)
-		pwm_disable(vibrator->pwm_dir);
-	pwm_disable(vibrator->pwm);
 }
 
 static void pwm_vibrator_play_work(struct work_struct *work)
-- 
2.17.1
