From: Oliver Neukum <oliver@neukum.org>
Subject: autosuspend for appletouch driver
Date: Fri, 21 Sep 2007 10:47:54 +0200
Message-ID: <200709211047.54982.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Richard Guenther <rguenther@suse.de>, linux-usb-devel@lists.sourceforge.net, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Hi,

here's the first version of a patch to do autosuspend for the appletouch
driver. It is against 2.6.23-rc6. It compiles. More I can't guarantee.

	Regards
		Oliver

-----
--- a/drivers/input/mouse/appletouch.c	2007-09-20 14:14:46.000000000 +0200
+++ b/drivers/input/mouse/appletouch.c	2007-09-21 10:39:21.000000000 +0200
@@ -140,6 +140,7 @@ MODULE_DEVICE_TABLE (usb, atp_table);
 struct atp {
 	char			phys[64];
 	struct usb_device *	udev;		/* usb device */
+	struct usb_interface	intf;		/* usb interface */
 	struct urb *		urb;		/* usb request block */
 	signed char *		data;		/* transferred data */
 	int			open;		/* non-zero if opened */
@@ -324,6 +325,11 @@ static inline void atp_report_fingers(st
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
@@ -362,6 +368,9 @@ static void atp_complete(struct urb* urb
 		goto exit;
 	}
 
+	/* mark busy for autosuspend purposes */
+	atp_mark_busy(dev);
+
 	/* reorder the sensors values */
 	if (atp_is_geyser_3(dev)) {
 		memset(dev->xy_cur, 0, sizeof(dev->xy_cur));
@@ -528,12 +537,20 @@ exit:
 static int atp_open(struct input_dev *input)
 {
 	struct atp *dev = input_get_drvdata(input);
+	int rv = 0;
 
-	if (usb_submit_urb(dev->urb, GFP_ATOMIC))
+	if (usb_autopm_get_interface(dev->intf) < 0)
 		return -EIO;
+	dev->intf->needs_remote_wakeup = 1;
+	if (usb_submit_urb(dev->urb, GFP_KERNEL)) {
+		rv = -EIO;
+		dev->intf->needs_remote_wakeup = 0;
+		goto err;
 
 	dev->open = 1;
-	return 0;
+err:
+	usb_autopm_put_interface(dev->intf);
+	return rv;
 }
 
 static void atp_close(struct input_dev *input)
@@ -543,6 +560,7 @@ static void atp_close(struct input_dev *
 	usb_kill_urb(dev->urb);
 	cancel_work_sync(&dev->work);
 	dev->open = 0;
+	dev->intf->needs_remote_wakeup = 0;
 }
 
 static int atp_probe(struct usb_interface *iface, const struct usb_device_id *id)
@@ -580,6 +598,7 @@ static int atp_probe(struct usb_interfac
 	}
 
 	dev->udev = udev;
+	dev->intf = iface;
 	dev->input = input_dev;
 	dev->overflowwarn = 0;
 	if (atp_is_geyser_3(dev))
@@ -714,7 +733,7 @@ static int atp_resume(struct usb_interfa
 {
 	struct atp *dev = usb_get_intfdata(iface);
 
-	if (dev->open && usb_submit_urb(dev->urb, GFP_ATOMIC))
+	if (dev->open && usb_submit_urb(dev->urb, GFP_NOIO))
 		return -EIO;
 
 	return 0;
@@ -727,6 +746,7 @@ static struct usb_driver atp_driver = {
 	.suspend	= atp_suspend,
 	.resume		= atp_resume,
 	.id_table	= atp_table,
+	.supports_autosuspend = 1,
 };
 
 static int __init atp_init(void)
