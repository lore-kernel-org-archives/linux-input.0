From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v2 5/7] Input: pwm-beeper - suppress error message on probe defer
Date: Thu, 19 Jan 2017 14:40:55 -0800
Message-ID: <20170119224057.9995-5-dmitry.torokhov@gmail.com>
References: <20170119224057.9995-1-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170119224057.9995-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: David Lechner <david@lechnology.com>, Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org, Frieder Schrempf <frieder.schrempf@exceet.de>
List-Id: linux-input@vger.kernel.org

From: David Lechner <david@lechnology.com>

This suppress printing an error message when pwm_get returns -EPROBE_DEFER.
Otherwise you get a bunch of noise in the kernel log.

Signed-off-by: David Lechner <david@lechnology.com>
Patchwork-Id: 9499915
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/pwm-beeper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
index 04c8ad3827d9..9964c46468d3 100644
--- a/drivers/input/misc/pwm-beeper.c
+++ b/drivers/input/misc/pwm-beeper.c
@@ -108,7 +108,8 @@ static int pwm_beeper_probe(struct platform_device *pdev)
 	beeper->pwm = devm_pwm_get(dev, NULL);
 	if (IS_ERR(beeper->pwm)) {
 		error = PTR_ERR(beeper->pwm);
-		dev_err(dev, "Failed to request pwm device: %d\n", error);
+		if (error != -EPROBE_DEFER)
+			dev_err(dev, "Failed to request pwm device\n");
 		return error;
 	}
 
-- 
2.11.0.483.g087da7b7c-goog
