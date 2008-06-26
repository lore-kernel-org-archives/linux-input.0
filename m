From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Subject: [rft]power management for usbtouch
Date: Thu, 26 Jun 2008 15:57:17 +0200
Message-ID: <200806261557.19095.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ville =?iso-8859-1?q?Syrj=E4l=E4?= <syrjala-ORSVBvAovxo@public.gmane.org>
Cc: daniel.ritz-OI3hZJvNYWs@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi,

this is power management for usbtouch. Could somebody test it?

	Regards
		Oliver

---

--- linux-2.6.26-sierra/drivers/input/touchscreen/usbtouchscreen.c.alt2	2008-06-26 15:23:38.000000000 +0200
+++ linux-2.6.26-sierra/drivers/input/touchscreen/usbtouchscreen.c	2008-06-26 15:48:44.000000000 +0200
@@ -89,13 +89,17 @@ struct usbtouch_usb {
 	int buf_len;
 	struct urb *irq;
 	struct usb_device *udev;
+	struct usb_interface *intf;
 	struct input_dev *input;
 	struct usbtouch_device_info *type;
+	struct mutex lock;
 	char name[128];
 	char phys[64];
 
 	int x, y;
 	int touch, press;
+
+	char open:1;
 };
 
 
@@ -820,13 +824,23 @@ exit:
 static int usbtouch_open(struct input_dev *input)
 {
 	struct usbtouch_usb *usbtouch = input_get_drvdata(input);
+	int rv;
 
+	rv = usb_autopm_get_interface(usbtouch->intf);
+	if (rv < 0)
+		goto bail;
+	mutex_lock(&usbtouch->lock);
 	usbtouch->irq->dev = usbtouch->udev;
 
-	if (usb_submit_urb(usbtouch->irq, GFP_KERNEL))
-		return -EIO;
-
-	return 0;
+	if (usb_submit_urb(usbtouch->irq, GFP_KERNEL)) {
+		rv = -EIO;
+		usb_autopm_put_interface(usbtouch->intf);
+	} else {
+		usbtouch->open = 1;
+	}
+	mutex_unlock(&usbtouch->lock);
+bail:
+	return rv;
 }
 
 static void usbtouch_close(struct input_dev *input)
@@ -834,6 +848,10 @@ static void usbtouch_close(struct input_
 	struct usbtouch_usb *usbtouch = input_get_drvdata(input);
 
 	usb_kill_urb(usbtouch->irq);
+	mutex_lock(&usbtouch->lock);
+	usbtouch->open = 0;
+	mutex_unlock(&usbtouch->lock);
+	usb_autopm_put_interface(usbtouch->intf);
 }
 
 
@@ -889,6 +907,8 @@ static int usbtouch_probe(struct usb_int
 
 	usbtouch->udev = udev;
 	usbtouch->input = input_dev;
+	mutex_init(&usbtouch->lock);
+	usbtouch->intf = intf;
 
 	if (udev->manufacturer)
 		strlcpy(usbtouch->name, udev->manufacturer, sizeof(usbtouch->name));
@@ -973,20 +993,76 @@ static void usbtouch_disconnect(struct u
 
 	dbg("%s - usbtouch is initialized, cleaning up", __FUNCTION__);
 	usb_set_intfdata(intf, NULL);
-	input_unregister_device(usbtouch->input);
 	usb_kill_urb(usbtouch->irq);
+	input_unregister_device(usbtouch->input);
 	usb_free_urb(usbtouch->irq);
 	usbtouch_free_buffers(interface_to_usbdev(intf), usbtouch);
 	kfree(usbtouch);
 }
 
+static int usbtouch_suspend(struct usb_interface *intf, pm_message_t message)
+{
+	struct usbtouch_usb *usbtouch = usb_get_intfdata(intf);
+
+	dbg("%s - called", __FUNCTION__);
+
+	mutex_lock(&usbtouch->lock);
+	usb_kill_urb(usbtouch->irq);
+	mutex_unlock(&usbtouch->lock);
+	return 0;
+}
+
+static int usbtouch_resume(struct usb_interface *intf)
+{
+	struct usbtouch_usb *usbtouch = usb_get_intfdata(intf);
+	int rv = 0;
+
+	dbg("%s - called", __FUNCTION__);
+
+	mutex_lock(&usbtouch->lock);
+	if (usbtouch->open)
+		rv = usb_submit_urb(usbtouch->irq, GFP_NOIO);
+	mutex_unlock(&usbtouch->lock);
+	return rv;
+}
+
+static int usbtouch_pre_reset(struct usb_interface *intf)
+{
+	struct usbtouch_usb *usbtouch = usb_get_intfdata(intf);
+
+	dbg("%s - called", __FUNCTION__);
+
+	mutex_lock(&usbtouch->lock);
+	usb_kill_urb(usbtouch->irq);
+	return 0;
+}
+
+static int usbtouch_post_reset(struct usb_interface *intf)
+{
+	struct usbtouch_usb *usbtouch = usb_get_intfdata(intf);
+	int rv = 0;
+
+	dbg("%s - called", __FUNCTION__);
+
+	if (usbtouch->open)
+		rv = usb_submit_urb(usbtouch->irq, GFP_NOIO);
+	mutex_unlock(&usbtouch->lock);
+	return rv;
+}
+
 MODULE_DEVICE_TABLE(usb, usbtouch_devices);
 
 static struct usb_driver usbtouch_driver = {
 	.name		= "usbtouchscreen",
 	.probe		= usbtouch_probe,
 	.disconnect	= usbtouch_disconnect,
+	.suspend	= usbtouch_suspend,
+	.resume		= usbtouch_resume,
+	.reset_resume	= usbtouch_resume,
+	.pre_reset	= usbtouch_pre_reset,
+	.post_reset	= usbtouch_post_reset,
 	.id_table	= usbtouch_devices,
+	.supports_autosuspend = 1,
 };
 
 static int __init usbtouch_init(void)
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
