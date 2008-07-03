From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Subject: [rft]powermate runtime pm
Date: Thu, 3 Jul 2008 17:53:16 +0200
Message-ID: <200807031753.16960.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, will-ffEBwZeNOFERmelmmXo44Q@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi,

this should add runtime power management to the powermate driver.
In order to do so the driver had to be changed to provide open & close
methods. Please test.

	Regards
		Oliver

---

--- linux-2.6.26-greg/drivers/input/misc/powermate.alt.c	2008-07-02 22:06:03.000000000 +0200
+++ linux-2.6.26-greg/drivers/input/misc/powermate.c	2008-07-03 17:48:05.000000000 +0200
@@ -67,6 +67,7 @@ struct powermate_device {
 	dma_addr_t configcr_dma;
 	struct usb_device *udev;
 	struct input_dev *input;
+	struct usb_interface *intf;
 	spinlock_t lock;
 	int static_brightness;
 	int pulse_speed;
@@ -74,6 +75,7 @@ struct powermate_device {
 	int pulse_asleep;
 	int pulse_awake;
 	int requires_update; // physical settings which are out of sync
+	int open:1;
 	char phys[64];
 };
 
@@ -82,6 +84,8 @@ static char pm_name_soundknob[] = "Griff
 
 static void powermate_config_complete(struct urb *urb);
 
+static DEFINE_MUTEX(pm_open_mutex);
+
 /* Callback for data arriving from the PowerMate over the USB interrupt pipe */
 static void powermate_irq(struct urb *urb)
 {
@@ -193,10 +197,18 @@ static void powermate_sync_state(struct
 static void powermate_config_complete(struct urb *urb)
 {
 	struct powermate_device *pm = urb->context;
+	int status = urb->status;
 	unsigned long flags;
 
-	if (urb->status)
-		printk(KERN_ERR "powermate: config urb returned %d\n", urb->status);
+	if (status) {
+		switch (status) {
+		case -ENOENT:
+		case -ESHUTDOWN:
+			return;
+		default:
+			printk(KERN_ERR "powermate: config urb returned %d\n", status);
+		}
+	}
 
 	spin_lock_irqsave(&pm->lock, flags);
 	powermate_sync_state(pm);
@@ -297,6 +309,77 @@ static void powermate_free_buffers(struc
 			pm->configcr, pm->configcr_dma);
 }
 
+static int input_open(struct input_dev *dev)
+{
+	struct powermate_device *pm = input_get_drvdata(dev);
+	int error;
+
+	error = usb_autopm_get_interface(pm->intf);
+	if (error < 0)
+		goto fail1;
+
+	mutex_lock(&pm_open_mutex);
+	/* register our interrupt URB with the USB system */
+	if (usb_submit_urb(pm->irq, GFP_KERNEL)) {
+		error = -EIO;
+		usb_autopm_put_interface(pm->intf);
+		goto fail2;
+	} else {
+		pm->open = 1;
+	}
+
+	/* force an update of everything */
+	pm->requires_update = UPDATE_PULSE_ASLEEP |
+				UPDATE_PULSE_AWAKE |
+				UPDATE_PULSE_MODE |
+				UPDATE_STATIC_BRIGHTNESS;
+	/* set default pulse parameters */
+	powermate_pulse_led(pm, 0x80, 255, 0, 1, 0);
+fail2:
+	mutex_unlock(&pm_open_mutex);
+fail1:
+	return error;
+}
+
+static void input_close(struct input_dev *dev)
+{
+	struct powermate_device *pm = input_get_drvdata(dev);
+
+	mutex_lock(&pm_open_mutex);
+	pm->open = 0;
+	mutex_unlock(&pm_open_mutex);
+	usb_kill_urb(pm->irq);
+	usb_kill_urb(pm->config);
+	usb_autopm_put_interface(pm->intf);
+}
+
+static int powermate_suspend(struct usb_interface *intf, pm_message_t message)
+{
+	struct powermate_device *pm = usb_get_intfdata (intf);
+
+	usb_kill_urb(pm->irq);
+	usb_kill_urb(pm->config);
+
+	return 0;
+}
+
+static int powermate_resume(struct usb_interface *intf)
+{
+	struct powermate_device *pm = usb_get_intfdata (intf);
+	int error = 0;
+
+	mutex_lock(&pm_open_mutex);
+	if (pm->open) {
+		error = usb_submit_urb(pm->irq, GFP_NOIO);
+		if (error < 0)
+			goto fail;
+		error = usb_submit_urb(pm->config, GFP_NOIO);
+	}
+fail:
+	mutex_unlock(&pm_open_mutex);
+	return error;
+}
+
 /* Called whenever a USB device matching one in our supported devices table is connected */
 static int powermate_probe(struct usb_interface *intf, const struct usb_device_id *id)
 {
@@ -358,6 +441,9 @@ static int powermate_probe(struct usb_in
 	input_dev->phys = pm->phys;
 	usb_to_input_id(udev, &input_dev->id);
 	input_dev->dev.parent = &intf->dev;
+	input_dev->open = input_open;
+	input_dev->close = input_close;
+	pm->intf = intf;
 
 	input_set_drvdata(input_dev, pm);
 
@@ -385,25 +471,13 @@ static int powermate_probe(struct usb_in
 	pm->irq->transfer_dma = pm->data_dma;
 	pm->irq->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
 
-	/* register our interrupt URB with the USB system */
-	if (usb_submit_urb(pm->irq, GFP_KERNEL)) {
-		error = -EIO;
-		goto fail4;
-	}
-
 	error = input_register_device(pm->input);
 	if (error)
-		goto fail5;
-
-
-	/* force an update of everything */
-	pm->requires_update = UPDATE_PULSE_ASLEEP | UPDATE_PULSE_AWAKE | UPDATE_PULSE_MODE | UPDATE_STATIC_BRIGHTNESS;
-	powermate_pulse_led(pm, 0x80, 255, 0, 1, 0); // set default pulse parameters
+		goto fail4;
 
 	usb_set_intfdata(intf, pm);
 	return 0;
 
- fail5:	usb_kill_urb(pm->irq);
  fail4:	usb_free_urb(pm->config);
  fail3:	usb_free_urb(pm->irq);
  fail2:	powermate_free_buffers(udev, pm);
@@ -418,16 +492,13 @@ static void powermate_disconnect(struct
 	struct powermate_device *pm = usb_get_intfdata (intf);
 
 	usb_set_intfdata(intf, NULL);
-	if (pm) {
-		pm->requires_update = 0;
-		usb_kill_urb(pm->irq);
-		input_unregister_device(pm->input);
-		usb_free_urb(pm->irq);
-		usb_free_urb(pm->config);
-		powermate_free_buffers(interface_to_usbdev(intf), pm);
 
-		kfree(pm);
-	}
+	pm->requires_update = 0;
+	input_unregister_device(pm->input);
+	usb_free_urb(pm->irq);
+	usb_free_urb(pm->config);
+	powermate_free_buffers(interface_to_usbdev(intf), pm);
+	kfree(pm);
 }
 
 static struct usb_device_id powermate_devices [] = {
@@ -443,7 +514,10 @@ static struct usb_driver powermate_drive
         .name =         "powermate",
         .probe =        powermate_probe,
         .disconnect =   powermate_disconnect,
+	.suspend =	powermate_suspend,
+	.resume =	powermate_resume,
         .id_table =     powermate_devices,
+	.supports_autosuspend = 1,
 };
 
 static int __init powermate_init(void)
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
