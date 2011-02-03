From: Iiro Valkonen <iiro.valkonen@atmel.com>
Subject: [PATCH 4/5] Try IRQF_TRIGGER_NONE if IRQF_TRIGGER_FALLING returns
 error
Date: Thu, 03 Feb 2011 16:10:56 +0200
Message-ID: <4D4AB770.7090407@atmel.com>
References: <4D3DAE3C.6060806@atmel.com> <20110124170756.GB31066@core.coreip.homeip.net> <4D3EA7DD.6000601@atmel.com> <F619927BD5260540BACE9E197A0F2A699CF0FB@hammb01.corp.atmel.com> <20110203074318.GA5814@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:26296 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932113Ab1BCOKr (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 3 Feb 2011 09:10:47 -0500
In-Reply-To: <20110203074318.GA5814@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Trilok Soni <tsoni@codeaurora.org>, linux-input@vger.kernel.org

I'm not sure about this one, does it make any sense? I have to do it on my test platform; if I request IRQF_TRIGGER_FALLING I get an error. With this patch everything works fine. But maybe it would be better to try to fix the platform instead...

BR,
-- 
Iiro


Input: qt602240_ts - Try IRQF_TRIGGER_NONE if IRQF_TRIGGER_FALLING returns error

From: Iiro Valkonen <iiro.valkonen@atmel.com>

Try IRQF_TRIGGER_NONE if IRQF_TRIGGER_FALLING returns error.

Signed-off-by: Iiro Valkonen <iiro.valkonen@atmel.com>
---
 drivers/input/touchscreen/qt602240_ts.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/input/touchscreen/qt602240_ts.c b/drivers/input/touchscreen/qt602240_ts.c
index a88ec93..208d9f7 100644
--- a/drivers/input/touchscreen/qt602240_ts.c
+++ b/drivers/input/touchscreen/qt602240_ts.c
@@ -1165,6 +1165,15 @@ static int __devinit mxt_probe(struct i2c_client *client,
 
 	error = request_threaded_irq(client->irq, NULL, mxt_interrupt,
 			IRQF_TRIGGER_FALLING, client->dev.driver->name, data);
+
+	if (error) {
+		/* If registering an interrupt with falling edge didn't work,
+		   try any edge. */
+		error = request_threaded_irq(client->irq, NULL, mxt_interrupt,
+					     IRQF_TRIGGER_NONE,
+					     client->dev.driver->name, data);
+	}
+
 	if (error) {
 		dev_err(&client->dev, "Failed to register interrupt\n");
 		goto err_free_object;
-- 
1.7.0.4
