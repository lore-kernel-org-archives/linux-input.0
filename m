From: Sebastian Reichel <sre@debian.org>
Subject: [PATCHv3 2/3] Input: twl4030-pwrbutton: use dev_err for errors
Date: Wed, 23 Oct 2013 18:47:14 +0200
Message-ID: <1382546835-20212-3-git-send-email-sre@debian.org>
References: <1382546835-20212-1-git-send-email-sre@debian.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1382546835-20212-1-git-send-email-sre@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@ring0.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Sebastian Reichel <sre@debian.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Sachin Kamat <sachin.kamat@linaro.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Use dev_err() to output errors instead of dev_dbg().

Signed-off-by: Sebastian Reichel <sre@debian.org>
---
 drivers/input/misc/twl4030-pwrbutton.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/misc/twl4030-pwrbutton.c b/drivers/input/misc/twl4030-pwrbutton.c
index a3a0fe3..3efbb13 100644
--- a/drivers/input/misc/twl4030-pwrbutton.c
+++ b/drivers/input/misc/twl4030-pwrbutton.c
@@ -60,7 +60,7 @@ static int twl4030_pwrbutton_probe(struct platform_device *pdev)
 
 	pwr = input_allocate_device();
 	if (!pwr) {
-		dev_dbg(&pdev->dev, "Can't allocate power button\n");
+		dev_err(&pdev->dev, "Can't allocate power button\n");
 		return -ENOMEM;
 	}
 
@@ -74,13 +74,13 @@ static int twl4030_pwrbutton_probe(struct platform_device *pdev)
 			IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
 			"twl4030_pwrbutton", pwr);
 	if (err < 0) {
-		dev_dbg(&pdev->dev, "Can't get IRQ for pwrbutton: %d\n", err);
+		dev_err(&pdev->dev, "Can't get IRQ for pwrbutton: %d\n", err);
 		goto free_input_dev;
 	}
 
 	err = input_register_device(pwr);
 	if (err) {
-		dev_dbg(&pdev->dev, "Can't register power button: %d\n", err);
+		dev_err(&pdev->dev, "Can't register power button: %d\n", err);
 		goto free_irq;
 	}
 
-- 
1.8.4.rc3
