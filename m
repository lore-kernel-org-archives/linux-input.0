From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Subject: [rft]basic power management methods for usbtouch
Date: Wed, 25 Nov 2009 22:55:13 +0100
Message-ID: <200911252255.13060.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: daniel.ritz-OI3hZJvNYWs@public.gmane.org, Ondrej Zary <linux-ZCIryABCsrmttCpgsWEBFmD2FQJk+8+b@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi,

this is supposed to implement the basic power management methods
for usbtouchscreen. Please test.

	Regards
		Oliver

--

diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/touchscreen/usbtouchscreen.c
index 68ece58..28e30af 100644
--- a/drivers/input/touchscreen/usbtouchscreen.c
+++ b/drivers/input/touchscreen/usbtouchscreen.c
@@ -946,6 +946,52 @@ static void usbtouch_close(struct input_dev *input)
 	usb_kill_urb(usbtouch->irq);
 }
 
+static int usbtouch_suspend
+(struct usb_interface *intf, pm_message_t message)
+{
+	struct usbtouch_usb *usbtouch = usb_get_intfdata(intf);
+	
+	usb_kill_urb(usbtouch->irq);
+	return 0;
+}
+
+static int usbtouch_resume(struct usb_interface *intf)
+{
+	struct usbtouch_usb *usbtouch = usb_get_intfdata(intf);
+	struct input_dev *input = usbtouch->input;
+	int result = 0;
+	
+	mutex_lock(&input->mutex);
+	if (input->users)
+		result = usb_submit_urb(usbtouch->irq, GFP_NOIO);
+	mutex_unlock(&input->mutex);
+	return result;
+}
+
+static int usbtouch_reset_resume(struct usb_interface *intf)
+{
+	struct usbtouch_usb *usbtouch = usb_get_intfdata(intf);
+	struct input_dev *input = usbtouch->input;
+	int err = 0;
+	
+	/* reinit the device */
+	if (usbtouch->type->init) {
+		err = usbtouch->type->init(usbtouch);
+		if (err) {
+			dbg("%s - type->init() failed, err: %d",
+			    __func__, err);
+			return err;
+		}
+	}
+
+	/* restart IO if needed */
+	mutex_lock(&input->mutex);
+	if (input->users)
+		err = usb_submit_urb(usbtouch->irq, GFP_NOIO);
+	mutex_unlock(&input->mutex);
+	
+	return err;
+}
 
 static void usbtouch_free_buffers(struct usb_device *udev,
 				  struct usbtouch_usb *usbtouch)
@@ -1100,6 +1146,9 @@ static struct usb_driver usbtouch_driver = {
 	.name		= "usbtouchscreen",
 	.probe		= usbtouch_probe,
 	.disconnect	= usbtouch_disconnect,
+	.suspend	= usbtouch_suspend,
+	.resume		= usbtouch_resume,
+	.reset_resume	= usbtouch_reset_resume,
 	.id_table	= usbtouch_devices,
 };
 
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
