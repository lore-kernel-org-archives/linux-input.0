From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: pwm-beeper - remove unneeded PWM_BEEPER_PM_OPS define
Date: Wed, 25 Feb 2015 17:32:41 -0800
Message-ID: <20150226013241.GA37737@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, Jingoo Han <jg1.han@samsung.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The device->pm pointer is always present so there is no need to do tricks with
conditionally defining the pointer.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/pwm-beeper.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
index a28ee70..a562071 100644
--- a/drivers/input/misc/pwm-beeper.c
+++ b/drivers/input/misc/pwm-beeper.c
@@ -169,12 +169,6 @@ static int __maybe_unused pwm_beeper_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(pwm_beeper_pm_ops,
 			 pwm_beeper_suspend, pwm_beeper_resume);
 
-#ifdef CONFIG_PM_SLEEP
-#define PWM_BEEPER_PM_OPS (&pwm_beeper_pm_ops)
-#else
-#define PWM_BEEPER_PM_OPS NULL
-#endif
-
 #ifdef CONFIG_OF
 static const struct of_device_id pwm_beeper_match[] = {
 	{ .compatible = "pwm-beeper", },
@@ -187,7 +181,7 @@ static struct platform_driver pwm_beeper_driver = {
 	.remove = pwm_beeper_remove,
 	.driver = {
 		.name	= "pwm-beeper",
-		.pm	= PWM_BEEPER_PM_OPS,
+		.pm	= &pwm_beeper_pm_ops,
 		.of_match_table = of_match_ptr(pwm_beeper_match),
 	},
 };
-- 
2.2.0.rc0.207.ga3a616c


-- 
Dmitry
