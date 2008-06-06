From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Subject: fix appletouch regression bugzilla.kernel.org#10825
Date: Fri, 6 Jun 2008 12:13:17 +0200
Message-ID: <200806061213.18066.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi,

this touchpad needs, probably due to a change in timing of suspension,
a quirk in 2.6.25 and later. To use this quirk the driver needs to implement
reset_resume(). I had written a patch that does that and implements USB
autosuspend. The reporter tested it and found it to work.
If you want me to I can't isolate the implementation of reset_resume() from
the rest but I can't test it.

	Regards
		Oliver

Signed-off-by: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>

---

--- linux-2.6.26-rc5/drivers/usb/core/quirks.c	2008-06-05 13:45:57.000000000 +0200
+++ linux-2.6.26-rc5-btusb/drivers/usb/core/quirks.c	2008-06-06 08:12:10.000000000 +0200
@@ -47,6 +47,9 @@ static const struct usb_device_id usb_qu
 	/* Edirol SD-20 */
 	{ USB_DEVICE(0x0582, 0x0027), .driver_info = USB_QUIRK_RESET_RESUME },
 
+	/* appletouch */
+	{ USB_DEVICE(0x05ac, 0x021a), .driver_info = USB_QUIRK_RESET_RESUME },
+
 	/* Avision AV600U */
 	{ USB_DEVICE(0x0638, 0x0a13), .driver_info =
 	  USB_QUIRK_STRING_FETCH_255 },
--- linux-2.6.26-rc5/drivers/input/mouse/appletouch.c	2008-06-05 13:42:19.000000000 +0200
+++ linux-2.6.26-rc5-btusb/drivers/input/mouse/appletouch.c	2008-06-06 08:10:28.000000000 +0200
@@ -32,6 +32,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/usb/input.h>
 
 /* Apple has powerbooks which have the keyboard with different Product IDs */
@@ -148,6 +149,7 @@ MODULE_DEVICE_TABLE (usb, atp_table);
 struct atp {
 	char			phys[64];
 	struct usb_device *	udev;		/* usb device */
+	struct usb_interface *	intf;		/* usb interface */
 	struct urb *		urb;		/* usb request block */
 	signed char *		data;		/* transferred data */
 	struct input_dev *	input;		/* input dev */
@@ -166,6 +168,7 @@ struct atp {
 	int			datalen;	/* size of an USB urb transfer */
 	int			idlecount;      /* number of empty packets */
 	struct work_struct      work;
+	struct mutex		lock;
 };
 
 #define dbg_dump(msg, tab) \
@@ -356,6 +359,11 @@ static inline void atp_report_fingers(st
 	input_report_key(input, BTN_TOOL_TRIPLETAP, fingers > 2);
 }
 
+static void atp_mark_busy(struct atp *dev)
+{
+	usb_mark_last_busy(dev->udev);
+}
+
 static void atp_complete(struct urb* urb)
 {
 	int x, y, x_z, y_z, x_f, y_f;
@@ -395,6 +403,9 @@ static void atp_complete(struct urb* urb
 		goto exit;
 	}
 
+	/* mark busy for autosuspend purposes */
+	atp_mark_busy(dev);
+
 	/* reorder the sensors values */
 	if (atp_is_geyser_3(dev)) {
 		memset(dev->xy_cur, 0, sizeof(dev->xy_cur));
@@ -572,21 +583,52 @@ exit:
 static int atp_open(struct input_dev *input)
 {
 	struct atp *dev = input_get_drvdata(input);
+	int rv;
 
-	if (usb_submit_urb(dev->urb, GFP_ATOMIC))
-		return -EIO;
+	mutex_lock(&dev->lock);
+
+	rv = usb_autopm_get_interface(dev->intf);
+	if ( rv < 0)
+		goto err_out;
+
+	rv = usb_submit_urb(dev->urb, GFP_KERNEL);
+	if (rv < 0)
+		goto err_put;
 
 	dev->open = 1;
-	return 0;
+	dev->intf->needs_remote_wakeup = 1;
+
+err_put:
+	usb_autopm_put_interface(dev->intf);
+err_out:
+	mutex_unlock(&dev->lock);
+	return rv;
 }
 
 static void atp_close(struct input_dev *input)
 {
 	struct atp *dev = input_get_drvdata(input);
 
+	mutex_lock(&dev->lock);
 	usb_kill_urb(dev->urb);
 	cancel_work_sync(&dev->work);
 	dev->open = 0;
+	dev->intf->needs_remote_wakeup = 0;
+	mutex_unlock(&dev->lock);
+}
+
+static int handle_geyser(struct atp *dev)
+{
+	struct usb_device *udev = dev->udev;
+
+	if (!atp_is_fountain(dev)) {
+		/* switch to raw sensor mode */
+		if (atp_geyser_init(udev))
+			return -EIO;
+
+		printk(KERN_INFO "appletouch: Geyser mode initialized.\n");
+	}
+	return 0;
 }
 
 static int atp_probe(struct usb_interface *iface, const struct usb_device_id *id)
@@ -623,7 +665,9 @@ static int atp_probe(struct usb_interfac
 		goto err_free_devs;
 	}
 
+	mutex_init(&dev->lock);
 	dev->udev = udev;
+	dev->intf = iface;
 	dev->input = input_dev;
 	dev->overflowwarn = 0;
 	if (atp_is_geyser_3(dev))
@@ -633,13 +677,8 @@ static int atp_probe(struct usb_interfac
 	else
 		dev->datalen = 81;
 
-	if (!atp_is_fountain(dev)) {
-		/* switch to raw sensor mode */
-		if (atp_geyser_init(udev))
-			goto err_free_devs;
-
-		printk(KERN_INFO "appletouch: Geyser mode initialized.\n");
-	}
+	if (handle_geyser(dev) < 0)
+		goto err_free_devs;
 
 	dev->urb = usb_alloc_urb(0, GFP_KERNEL);
 	if (!dev->urb)
@@ -758,19 +797,65 @@ static int atp_resume(struct usb_interfa
 {
 	struct atp *dev = usb_get_intfdata(iface);
 
-	if (dev->open && usb_submit_urb(dev->urb, GFP_ATOMIC))
+	if (dev->open && usb_submit_urb(dev->urb, GFP_NOIO))
 		return -EIO;
 
 	return 0;
 }
 
+static int recover_dev(struct atp *dev)
+{
+	int rv;
+
+	rv = handle_geyser(dev);
+	if (rv < 0)
+		return rv;
+
+	if (dev->open && usb_submit_urb(dev->urb, GFP_NOIO))
+		return -EIO;
+
+	return 0;	
+}
+
+static int atp_pre_reset(struct usb_interface *iface)
+{
+	struct atp *dev = usb_get_intfdata(iface);
+
+	mutex_lock(&dev->lock);
+	if (dev->open)
+		usb_kill_urb(dev->urb);
+
+	return 0;
+}
+
+static int atp_post_reset(struct usb_interface *iface)
+{
+	struct atp *dev = usb_get_intfdata(iface);
+	int rv;
+
+	rv = recover_dev(dev);
+	mutex_unlock(&dev->lock);
+	return rv;
+}
+
+static int atp_reset_resume(struct usb_interface *iface)
+{
+	struct atp *dev = usb_get_intfdata(iface);
+
+	return recover_dev(dev);
+}
+
 static struct usb_driver atp_driver = {
 	.name		= "appletouch",
 	.probe		= atp_probe,
 	.disconnect	= atp_disconnect,
 	.suspend	= atp_suspend,
 	.resume		= atp_resume,
+	.reset_resume	= atp_reset_resume,
+	.pre_reset	= atp_pre_reset,
+	.post_reset	= atp_post_reset,
 	.id_table	= atp_table,
+	.supports_autosuspend = 1,
 };
 
 static int __init atp_init(void)
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
