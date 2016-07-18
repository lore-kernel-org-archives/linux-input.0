From: Martin Kepplinger <martink@posteo.de>
Subject: [PATCH 2/4] input: tablet: pegasus_notetaker: Fix usb_autopm calls to be balanced
Date: Mon, 18 Jul 2016 16:29:07 +0200
Message-ID: <1468852149-2614-3-git-send-email-martink@posteo.de>
References: <1468852149-2614-1-git-send-email-martink@posteo.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1468852149-2614-1-git-send-email-martink@posteo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Martin Kepplinger <martink@posteo.de>
List-Id: linux-input@vger.kernel.org

Signed-off-by: Martin Kepplinger <martink@posteo.de>
---
 drivers/input/tablet/pegasus_notetaker.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/input/tablet/pegasus_notetaker.c b/drivers/input/tablet/pegasus_notetaker.c
index 27cb352..fdbc5e8 100644
--- a/drivers/input/tablet/pegasus_notetaker.c
+++ b/drivers/input/tablet/pegasus_notetaker.c
@@ -208,27 +208,30 @@ static int pegasus_open(struct input_dev *dev)
 		return retval;
 
 	pegasus->irq->dev = pegasus->usbdev;
-	if (usb_submit_urb(pegasus->irq, GFP_KERNEL))
+	if (usb_submit_urb(pegasus->irq, GFP_KERNEL)) {
 		retval = -EIO;
+		goto out;
+	}
 
 	retval = pegasus_set_mode(pegasus, PEN_MODE_XY, NOTETAKER_LED_MOUSE);
 
-	usb_autopm_put_interface(pegasus->intf);
+out:
 
-	return retval;
+	if (retval < 0) {
+		usb_autopm_put_interface(pegasus->intf);
+		return retval;
+	} else {
+		return 0;
+	}
 }
 
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
+	usb_autopm_put_interface(pegasus->intf);
 }
 
 static int pegasus_probe(struct usb_interface *intf,
-- 
2.1.4
