From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH 1/4] Input: max77693: Remove a read-only pwm_divisor field
Date: Wed, 29 Jul 2015 15:31:27 +0900
Message-ID: <1438151490-13751-2-git-send-email-k.kozlowski@samsung.com>
References: <1438151490-13751-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1438151490-13751-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Jaewon Kim <jaewon02.kim@samsung.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: linux-input@vger.kernel.org

Storing a predefined PWM divisor in state container structure is
meaningless. The field, after initialization, is only read so this only
obfuscates the code. Remove the field and use directly enum value.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/input/misc/max77693-haptic.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/misc/max77693-haptic.c b/drivers/input/misc/max77693-haptic.c
index 4524499ea72f..8dc43c1ebf0e 100644
--- a/drivers/input/misc/max77693-haptic.c
+++ b/drivers/input/misc/max77693-haptic.c
@@ -60,7 +60,6 @@ struct max77693_haptic {
 	unsigned int pwm_duty;
 	enum max77693_haptic_motor_type type;
 	enum max77693_haptic_pulse_mode mode;
-	enum max77693_haptic_pwm_divisor pwm_divisor;
 
 	struct work_struct work;
 };
@@ -88,7 +87,7 @@ static int max77693_haptic_configure(struct max77693_haptic *haptic,
 	value = ((haptic->type << MAX77693_CONFIG2_MODE) |
 		(enable << MAX77693_CONFIG2_MEN) |
 		(haptic->mode << MAX77693_CONFIG2_HTYP) |
-		(haptic->pwm_divisor));
+		MAX77693_HAPTIC_PWM_DIVISOR_128);
 
 	error = regmap_write(haptic->regmap_haptic,
 			     MAX77693_HAPTIC_REG_CONFIG2, value);
@@ -259,7 +258,6 @@ static int max77693_haptic_probe(struct platform_device *pdev)
 	haptic->dev = &pdev->dev;
 	haptic->type = MAX77693_HAPTIC_LRA;
 	haptic->mode = MAX77693_HAPTIC_EXTERNAL_MODE;
-	haptic->pwm_divisor = MAX77693_HAPTIC_PWM_DIVISOR_128;
 	haptic->suspend_state = false;
 
 	INIT_WORK(&haptic->work, max77693_haptic_play_work);
-- 
1.9.1
