From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] input: tablet: pegasus_notetaker: USB PM fixes
Date: Thu, 23 Jun 2016 10:18:35 -0700
Message-ID: <20160623171835.GE32561@dtor-ws>
References: <1465903215-2351-1-git-send-email-martink@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1465903215-2351-1-git-send-email-martink-1KBjaw7Xf1+zQB+pC5nmwQ@public.gmane.org>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Kepplinger <martink-1KBjaw7Xf1+zQB+pC5nmwQ@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Martin,

On Tue, Jun 14, 2016 at 01:20:15PM +0200, Martin Kepplinger wrote:
>  static int pegasus_reset_resume(struct usb_interface *intf)
>  {
> +	struct pegasus *pegasus = usb_get_intfdata(intf);
> +
> +	if (pegasus->dev->users)
> +		pegasus_set_mode(pegasus, PEN_MODE_XY, NOTETAKER_LED_MOUSE);
> +
>  	return pegasus_resume(intf);

Hmm, we need to take input mutex when using pegasus->dev->users, how
about the version below instead?

Thanks.

-- 
Dmitry

Input: pegasus_notetake - USB PM fixes

From: Martin Kepplinger <martink-1KBjaw7Xf1+zQB+pC5nmwQ@public.gmane.org>

* Fix usb_autopm calls to be balanced
 * In reset_resume() we need to set the device mode
 * In suspend() we must cancel the workqueue's work

Signed-off-by: Martin Kepplinger <martink-1KBjaw7Xf1+zQB+pC5nmwQ@public.gmane.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/input/tablet/pegasus_notetaker.c |   46 ++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 15 deletions(-)

diff --git a/drivers/input/tablet/pegasus_notetaker.c b/drivers/input/tablet/pegasus_notetaker.c
index 805afe3..d20ea06 100644
--- a/drivers/input/tablet/pegasus_notetaker.c
+++ b/drivers/input/tablet/pegasus_notetaker.c
@@ -80,7 +80,7 @@ struct pegasus {
 	struct work_struct init;
 };
 
-static void pegasus_control_msg(struct pegasus *pegasus, u8 *data, int len)
+static int pegasus_control_msg(struct pegasus *pegasus, u8 *data, int len)
 {
 	const int sizeof_buf = len + 2;
 	int result;
@@ -88,7 +88,7 @@ static void pegasus_control_msg(struct pegasus *pegasus, u8 *data, int len)
 
 	cmd_buf = kmalloc(sizeof_buf, GFP_KERNEL);
 	if (!cmd_buf)
-		return;
+		return -ENOMEM;
 
 	cmd_buf[0] = NOTETAKER_REPORT_ID;
 	cmd_buf[1] = len;
@@ -101,17 +101,23 @@ static void pegasus_control_msg(struct pegasus *pegasus, u8 *data, int len)
 				 0, 0, cmd_buf, sizeof_buf,
 				 USB_CTRL_SET_TIMEOUT);
 
-	if (result != sizeof_buf)
-		dev_err(&pegasus->usbdev->dev, "control msg error\n");
+	if (result != sizeof_buf) {
+		if (result >= 0)
+			result = -EIO;
+		dev_err(&pegasus->usbdev->dev, "control msg error: %d\n",
+			result);
+	}
 
 	kfree(cmd_buf);
+
+	return result;
 }
 
-static void pegasus_set_mode(struct pegasus *pegasus, u8 mode, u8 led)
+static int pegasus_set_mode(struct pegasus *pegasus, u8 mode, u8 led)
 {
 	u8 cmd[] = { NOTETAKER_SET_CMD, NOTETAKER_SET_MODE, led, mode };
 
-	pegasus_control_msg(pegasus, cmd, sizeof(cmd));
+	return pegasus_control_msg(pegasus, cmd, sizeof(cmd));
 }
 
 static void pegasus_parse_packet(struct pegasus *pegasus)
@@ -205,27 +211,24 @@ static int pegasus_open(struct input_dev *dev)
 		return retval;
 
 	pegasus->irq->dev = pegasus->usbdev;
-	if (usb_submit_urb(pegasus->irq, GFP_KERNEL))
+	if (usb_submit_urb(pegasus->irq, GFP_KERNEL)) {
 		retval = -EIO;
+		goto out;
+	}
 
-	pegasus_set_mode(pegasus, PEN_MODE_XY, NOTETAKER_LED_MOUSE);
+	retval = pegasus_set_mode(pegasus, PEN_MODE_XY, NOTETAKER_LED_MOUSE);
 
+out:
 	usb_autopm_put_interface(pegasus->intf);
-
 	return retval;
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
 }
 
 static int pegasus_probe(struct usb_interface *intf,
@@ -373,6 +376,7 @@ static int pegasus_suspend(struct usb_interface *intf, pm_message_t message)
 
 	mutex_lock(&pegasus->dev->mutex);
 	usb_kill_urb(pegasus->irq);
+	cancel_work_sync(&pegasus->init);
 	mutex_unlock(&pegasus->dev->mutex);
 
 	return 0;
@@ -393,7 +397,19 @@ static int pegasus_resume(struct usb_interface *intf)
 
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
