From: David Lechner <david@lechnology.com>
Subject: [PATCH v2 1/3] Input: pwm-beeper: suppress error message on probe defer
Date: Wed, 11 Jan 2017 14:01:59 -0600
Message-ID: <1484164921-30587-2-git-send-email-david@lechnology.com>
References: <1484164921-30587-1-git-send-email-david@lechnology.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484164921-30587-1-git-send-email-david@lechnology.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, devicetree@vger.kernel.org
Cc: David Lechner <david@lechnology.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

This suppress printing an error message when pwm_get returns -EPROBE_DEFER.
Otherwise you get a bunch of noise in the kernel log.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/input/misc/pwm-beeper.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
index ce6eec4..30ac227 100644
--- a/drivers/input/misc/pwm-beeper.c
+++ b/drivers/input/misc/pwm-beeper.c
@@ -104,9 +104,10 @@ static int pwm_beeper_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	beeper->pwm = devm_pwm_get(dev, NULL);
-	if (IS_ERR(beeper->pwm)) {
-		error = PTR_ERR(beeper->pwm);
-		dev_err(dev, "Failed to request pwm device: %d\n", error);
+	error = PTR_ERR_OR_ZERO(beeper->pwm);
+	if (error) {
+		if (error != -EPROBE_DEFER)
+			dev_err(dev, "Failed to request pwm device\n");
 		return error;
 	}
 
-- 
2.7.4
