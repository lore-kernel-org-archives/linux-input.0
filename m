From: javier Martin <javier.martin@vista-silicon.com>
Subject: qt1070: Why IRQF_TRIGGER_NONE?
Date: Wed, 2 May 2012 10:35:25 +0200
Message-ID: <CACKLOr1XE+tJ92jbfOHdDQVVsXhsNASrHgENEbiuR+8aBE11cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:33194 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753491Ab2EBIf0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 May 2012 04:35:26 -0400
Received: by yenl12 with SMTP id l12so391094yen.19
        for <linux-input@vger.kernel.org>; Wed, 02 May 2012 01:35:26 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Wolfram Sang <w.sang@pengutronix.de>, Jean Delvare <khali@linux-fr.org>, Axel Lin <axel.lin@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi,
I was testing qt1070 driver with my Visstrim SM10 board when I found
out IRQs where not triggered properly.

I had to come up with the following patch in order to solve it:

diff --git a/drivers/input/keyboard/qt1070.c b/drivers/input/keyboard/qt1070.c
index 0b7b2f8..e8b6ae3 100644
--- a/drivers/input/keyboard/qt1070.c
+++ b/drivers/input/keyboard/qt1070.c
@@ -201,7 +201,7 @@ static int __devinit qt1070_probe(struct i2c_client *client,
 	msleep(QT1070_RESET_TIME);

 	err = request_threaded_irq(client->irq, NULL, qt1070_interrupt,
-		IRQF_TRIGGER_NONE, client->dev.driver->name, data);
+		IRQF_TRIGGER_FALLING, client->dev.driver->name, data);
 	if (err) {
 		dev_err(&client->dev, "fail to request irq\n");
 		goto err_free_mem;


According to the datasheet (p10)  "The CHANGE line is active low and
signals when there is a change in state in the Detection or
Input status bytes. It is cleared (allowed to float high) when the
host reads the status bytes." As I understand, this means that we have
to monitor falling edges here.

Is there any reason to register the IRQ as IRQF_TRIGGER_NONE? Would
you accept the above patch instead, provided I send it in the required
format?

Regards.
-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
