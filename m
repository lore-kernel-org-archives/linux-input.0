From: Martin Kepplinger <martink@posteo.de>
Subject: [PATCH 4/4] input: tablet: pegasus_notetaker: Set device mode in reset_resume() if in use
Date: Mon, 18 Jul 2016 16:29:09 +0200
Message-ID: <1468852149-2614-5-git-send-email-martink@posteo.de>
References: <1468852149-2614-1-git-send-email-martink@posteo.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout02.posteo.de ([185.67.36.66]:52835 "EHLO mout02.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752293AbcGRO31 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Jul 2016 10:29:27 -0400
Received: from submission (posteo.de [89.146.220.130])
	by mout02.posteo.de (Postfix) with ESMTPS id 1F7B920F84
	for <linux-input@vger.kernel.org>; Mon, 18 Jul 2016 16:29:21 +0200 (CEST)
In-Reply-To: <1468852149-2614-1-git-send-email-martink@posteo.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Martin Kepplinger <martink@posteo.de>

Signed-off-by: Martin Kepplinger <martink@posteo.de>
---
 drivers/input/tablet/pegasus_notetaker.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/input/tablet/pegasus_notetaker.c b/drivers/input/tablet/pegasus_notetaker.c
index 07436c6..b172247 100644
--- a/drivers/input/tablet/pegasus_notetaker.c
+++ b/drivers/input/tablet/pegasus_notetaker.c
@@ -398,7 +398,19 @@ static int pegasus_resume(struct usb_interface *intf)
 
 static int pegasus_reset_resume(struct usb_interface *intf)
 {
-	return pegasus_resume(intf);
+	struct pegasus *pegasus = usb_get_intfdata(intf);
+	int retval = 0;
+
+	mutex_lock(&pegasus->dev->mutex);
+	if (pegasus->dev->users) {
+		retval = pegasus_set_mode(pegasus, PEN_MODE_XY,
+					  NOTETAKER_LED_MOUSE);
+		if (!retval && usb_submit_urb(pegasus->irq, GFP_NOIO) < 0)
+			retval = -EIO;
+	}
+	mutex_unlock(&pegasus->dev->mutex);
+
+	return retval;
 }
 
 static const struct usb_device_id pegasus_ids[] = {
-- 
2.1.4

