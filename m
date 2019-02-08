From: Sven Van Asbroeck <thesven73@gmail.com>
Subject: [RFC PATCH 2/2] Input: lm8323: remove recursive mutex lock/unlock
Date: Fri,  8 Feb 2019 14:34:34 -0500
Message-ID: <20190208193434.5629-2-TheSven73@gmail.com>
References: <20190208193434.5629-1-TheSven73@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190208193434.5629-1-TheSven73@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Recursive mutex lock/unlock is not permitted. Remove.

Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---
 drivers/input/keyboard/lm8323.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/input/keyboard/lm8323.c b/drivers/input/keyboard/lm8323.c
index ea4ed1750eb5..4363c60f7845 100644
--- a/drivers/input/keyboard/lm8323.c
+++ b/drivers/input/keyboard/lm8323.c
@@ -359,11 +359,9 @@ static int lm8323_configure(struct lm8323_chip *lm)
 
 static void pwm_done(struct lm8323_pwm *pwm)
 {
-	mutex_lock(&pwm->lock);
 	pwm->running = false;
 	if (pwm->desired_brightness != pwm->brightness)
 		led_set_brightness(&pwm->cdev, pwm->desired_brightness);
-	mutex_unlock(&pwm->lock);
 }
 
 /*
-- 
2.17.1
