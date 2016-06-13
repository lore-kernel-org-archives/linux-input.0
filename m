From: Martin Kepplinger <martink-1KBjaw7Xf1+zQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH] input: tablet: pegasus_notetaker: USB PM fixes
Date: Mon, 13 Jun 2016 15:31:53 +0200
Message-ID: <1465824713-3156-1-git-send-email-martink@posteo.de>
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Martin Kepplinger <martink-1KBjaw7Xf1+zQB+pC5nmwQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

In close() we only need usb_autopm_put_interface(), in reset_resume()
we need to set the device mode, and in suspend(), we must cancel
the workqueue's work.

Signed-off-by: Martin Kepplinger <martink-1KBjaw7Xf1+zQB+pC5nmwQ@public.gmane.org>
---
Thanks Oliver for these changes. For me, everything works as before.

Dmitry, do you want a new version of the whole thing instead of this
fix?

thanks
                          martin

 drivers/input/tablet/pegasus_notetaker.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/input/tablet/pegasus_notetaker.c b/drivers/input/tablet/pegasus_notetaker.c
index 83aa583..0c339e7 100644
--- a/drivers/input/tablet/pegasus_notetaker.c
+++ b/drivers/input/tablet/pegasus_notetaker.c
@@ -211,14 +211,11 @@ static int pegasus_open(struct input_dev *dev)
 static void pegasus_close(struct input_dev *dev)
 {
 	struct pegasus *pegasus = input_get_drvdata(dev);
-	int autopm_error;
 
-	autopm_error = usb_autopm_get_interface(pegasus->intf);
 	usb_kill_urb(pegasus->irq);
 	cancel_work_sync(&pegasus->init);
 
-	if (!autopm_error)
-		usb_autopm_put_interface(pegasus->intf);
+	usb_autopm_put_interface(pegasus->intf);
 }
 
 static int pegasus_probe(struct usb_interface *intf,
@@ -364,6 +361,7 @@ static int pegasus_suspend(struct usb_interface *intf, pm_message_t message)
 
 	mutex_lock(&pegasus->dev->mutex);
 	usb_kill_urb(pegasus->irq);
+	cancel_work_sync(&pegasus->init);
 	mutex_unlock(&pegasus->dev->mutex);
 
 	return 0;
@@ -384,6 +382,11 @@ static int pegasus_resume(struct usb_interface *intf)
 
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
