From: "H Hartley Sweeten" <hartleys@visionengravers.com>
Subject: [PATCH] rotary_encoder: fix relative axis support
Date: Wed, 30 Sep 2009 20:33:26 -0400
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901D42CBE@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from exprod6og104.obsmtp.com ([64.18.1.187]:56434 "HELO
	exprod6og104.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755210AbZJAAka convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Sep 2009 20:40:30 -0400
Content-class: urn:content-classes:message
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Daniel Mack <daniel@caiaq.de>

When the rotart_encoder driver is used to report relative axis
information the "steps" in the platform data could be missing
since it's not relevant.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Daniel Mack <daniel@caiaq.de>

---

diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/rotary_encoder.c
index c806fbf..3b9f588 100644
--- a/drivers/input/misc/rotary_encoder.c
+++ b/drivers/input/misc/rotary_encoder.c
@@ -106,8 +106,8 @@ static int __devinit rotary_encoder_probe(struct platform_device *pdev)
 	struct input_dev *input;
 	int err;
 
-	if (!pdata || !pdata->steps) {
-		dev_err(&pdev->dev, "invalid platform data\n");
+	if (!pdata) {
+		dev_err(&pdev->dev, "missing platform data\n");
 		return -ENOENT;
 	}
  
