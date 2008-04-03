From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Subject: Re: suspend
Date: Thu, 3 Apr 2008 12:31:18 +0200
Message-ID: <200804031231.19193.oliver@neukum.org>
References: <dd18b0c30804012331oc548416k113e492d7dc9c189@mail.gmail.com> <200804031029.26635.oliver@neukum.org> <e79639220804030153q46fa82c7jb79bedbe88b30df7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <e79639220804030153q46fa82c7jb79bedbe88b30df7-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stefan Schweizer <genstef-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Am Donnerstag, 3. April 2008 10:53:53 schrieb Stefan Schweizer:
> >  On second thought, this should be fixed by usb persist if the appletouch
> >  driver supported reset_resume. Would you be willing to test a kernel patch
> >  that implements reset_resume in the appletouch driver?
> 
> Sure, I would love to have this fixed :-)

Then, here's the patch. Testing this is not trivial. Please
compile your kernel with CONFIG_USB_SUSPEND and CONFIG_USB_PERSIST.
To use the feature you need to switch it on as described in
Documentation/usb/persist.txt

	Regards
		Oliver

----

--- linux-2.6.25-rc7-vanilla/drivers/input/mouse/appletouch.c	2008-03-31 15:16:40.000000000 +0200
+++ linux-2.6.25-rc7-work/drivers/input/mouse/appletouch.c	2008-04-03 12:17:01.000000000 +0200
@@ -32,6 +32,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/usb/input.h>
 
 /* Apple has powerbooks which have the keyboard with different Product IDs */
@@ -158,6 +159,7 @@ struct atp {
 	int			datalen;	/* size of an USB urb transfer */
 	int			idlecount;      /* number of empty packets */
 	struct work_struct      work;
+	struct mutex		lock;
 };
 
 #define dbg_dump(msg, tab) \
@@ -562,10 +564,14 @@ static int atp_open(struct input_dev *in
 {
 	struct atp *dev = input_get_drvdata(input);
 
-	if (usb_submit_urb(dev->urb, GFP_ATOMIC))
+	mutex_lock(&dev->lock);
+	if (usb_submit_urb(dev->urb, GFP_KERNEL)) {
+		mutex_unlock(&dev->lock);
 		return -EIO;
+	}
 
 	dev->open = 1;
+	mutex_unlock(&dev->lock);
 	return 0;
 }
 
@@ -573,9 +579,25 @@ static void atp_close(struct input_dev *
 {
 	struct atp *dev = input_get_drvdata(input);
 
+	mutex_lock(&dev->lock);
 	usb_kill_urb(dev->urb);
 	cancel_work_sync(&dev->work);
 	dev->open = 0;
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
@@ -612,6 +634,7 @@ static int atp_probe(struct usb_interfac
 		goto err_free_devs;
 	}
 
+	mutex_init(&dev->lock);
 	dev->udev = udev;
 	dev->input = input_dev;
 	dev->overflowwarn = 0;
@@ -622,13 +645,8 @@ static int atp_probe(struct usb_interfac
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
@@ -747,18 +765,63 @@ static int atp_resume(struct usb_interfa
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
 };
 
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
