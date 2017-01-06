From: David Lechner <david@lechnology.com>
Subject: [PATCH 1/3] Input: pwm-beeper: suppress error message on probe defer
Date: Thu,  5 Jan 2017 20:43:52 -0600
Message-ID: <1483670635-25060-2-git-send-email-david@lechnology.com>
References: <1483670635-25060-1-git-send-email-david@lechnology.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from vern.gendns.com ([206.190.152.46]:56116 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754260AbdAFCn7 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 5 Jan 2017 21:43:59 -0500
In-Reply-To: <1483670635-25060-1-git-send-email-david@lechnology.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: David Lechner <david@lechnology.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

This suppress printing an error message when pwm_get/pwm_request returns
-EPROBE_DEFER. Otherwise you get a bunch of noise in the kernel log.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/input/misc/pwm-beeper.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
index 5f9655d..e76b710 100644
--- a/drivers/input/misc/pwm-beeper.c
+++ b/drivers/input/misc/pwm-beeper.c
@@ -109,9 +109,10 @@ static int pwm_beeper_probe(struct platform_device *pdev)
 		beeper->pwm = pwm_request(pwm_id, "pwm beeper");
 	}
 
-	if (IS_ERR(beeper->pwm)) {
-		error = PTR_ERR(beeper->pwm);
-		dev_err(&pdev->dev, "Failed to request pwm device: %d\n", error);
+	error = PTR_ERR_OR_ZERO(beeper->pwm);
+	if (error) {
+		if (error != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "Failed to request pwm device\n");
 		goto err_free;
 	}
 
-- 
2.7.4

