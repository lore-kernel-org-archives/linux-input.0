From: Martin Kepplinger <martink@posteo.de>
Subject: [PATCH v2] input: tablet: pegasus_notetaker: USB PM fixes
Date: Tue, 14 Jun 2016 13:20:15 +0200
Message-ID: <1465903215-2351-1-git-send-email-martink@posteo.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout01.posteo.de ([185.67.36.65]:49551 "EHLO mout01.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751886AbcFNLU0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Jun 2016 07:20:26 -0400
Received: from dovecot03.posteo.de (dovecot03.posteo.de [172.16.0.13])
	by mout01.posteo.de (Postfix) with ESMTPS id B9D8720B4A
	for <linux-input@vger.kernel.org>; Tue, 14 Jun 2016 13:20:22 +0200 (CEST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, kernel-testers@vger.kernel.org, linux-usb@vger.kernel.org, Martin Kepplinger <martink@posteo.de>

 * Fix usb_autopm calls to be balanced
 * In reset_resume() we need to set the device mode
 * In suspend() we must cancel the workqueue's work

Signed-off-by: Martin Kepplinger <martink@posteo.de>
---
Thanks Oliver, I think I got it now.

Dmitry, again, do you want to have a new version of the whole driver
instead of this?


 drivers/input/tablet/pegasus_notetaker.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/input/tablet/pegasus_notetaker.c b/drivers/input/tablet/pegasus_notetaker.c
index 83aa583..0c000d8 100644
--- a/drivers/input/tablet/pegasus_notetaker.c
+++ b/drivers/input/tablet/pegasus_notetaker.c
@@ -211,14 +211,9 @@ static int pegasus_open(struct input_dev *dev)
 static void pegasus_close(struct input_dev *dev)
 {
 	struct pegasus *pegasus = input_get_drvdata(dev);
-	int autopm_error;
 
-	autopm_error = usb_autopm_get_interface(pegasus->intf);
 	usb_kill_urb(pegasus->irq);
 	cancel_work_sync(&pegasus->init);
-
-	if (!autopm_error)
-		usb_autopm_put_interface(pegasus->intf);
 }
 
 static int pegasus_probe(struct usb_interface *intf,
@@ -364,6 +359,7 @@ static int pegasus_suspend(struct usb_interface *intf, pm_message_t message)
 
 	mutex_lock(&pegasus->dev->mutex);
 	usb_kill_urb(pegasus->irq);
+	cancel_work_sync(&pegasus->init);
 	mutex_unlock(&pegasus->dev->mutex);
 
 	return 0;
@@ -384,6 +380,11 @@ static int pegasus_resume(struct usb_interface *intf)
 
 static int pegasus_reset_resume(struct usb_interface *intf)
 {
+	struct pegasus *pegasus = usb_get_intfdata(intf);
+
+	if (pegasus->dev->users)
+		pegasus_set_mode(pegasus, PEN_MODE_XY, NOTETAKER_LED_MOUSE);
+
 	return pegasus_resume(intf);
 }
 
-- 
2.1.4

