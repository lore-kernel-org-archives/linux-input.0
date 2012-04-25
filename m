From: Ming Lei <ming.lei@canonical.com>
Subject: Re: [PATCH] hid: usbhid: fix possible deadlock in __usbhid_submit_report
Date: Wed, 25 Apr 2012 09:27:19 +0800
Message-ID: <CACVXFVOuSamcBrPT=K9Q3fAXULjz57e-1W9pi9AW1gAKxyCT7g@mail.gmail.com>
References: <CACVXFVNAZHC2uQCwRak6pRgT1VEgRJt5UTuwAtZM6r_Xdg0dHA@mail.gmail.com>
	<201204241622.08411.oneukum@suse.de>
	<CACVXFVM_p=VZ76zX89CppbeXFh-bhTwqzU6FWHzuaJa2bYcBUA@mail.gmail.com>
	<201204242057.29100.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:48717 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757809Ab2DYB1X convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Apr 2012 21:27:23 -0400
In-Reply-To: <201204242057.29100.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, stable@vger.kernel.org

On Wed, Apr 25, 2012 at 2:57 AM, Oliver Neukum <oliver@neukum.org> wrot=
e:

=A0usb_submit_urb()
>>
>> This submit won't happen because HID_OUT_RUNNING is not cleared.
>
> I may be dense, but as far as I can tell a resubmit will happen, exac=
tly if
> HID_OUT_RUNNING is _not_ cleared.

In fact, it should be a double unlink bug, usb_unlink_urb can handle
it correctly
if the lock is held. We also can deal with it easily by checking urb->u=
nlinked,
so how about the below patch?

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-cor=
e.c
index aa1c503..b530463 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -411,10 +411,10 @@ static void hid_irq_out(struct urb *urb)
 {
 	struct hid_device *hid =3D urb->context;
 	struct usbhid_device *usbhid =3D hid->driver_data;
-	unsigned long flags;
+	unsigned long status =3D urb->status;
 	int unplug =3D 0;

-	switch (urb->status) {
+	switch (status) {
 	case 0:			/* success */
 		break;
 	case -ESHUTDOWN:	/* unplug */
@@ -428,8 +428,9 @@ static void hid_irq_out(struct urb *urb)
 		hid_warn(urb->dev, "output irq status %d received\n",
 			 urb->status);
 	}
-
-	spin_lock_irqsave(&usbhid->lock, flags);
+	if (status !=3D -ECONNRESET)
+		spin_lock(&usbhid->unlink_lock);
+	spin_lock(&usbhid->lock);

 	if (unplug)
 		usbhid->outtail =3D usbhid->outhead;
@@ -438,12 +439,16 @@ static void hid_irq_out(struct urb *urb)

 	if (usbhid->outhead !=3D usbhid->outtail && !hid_submit_out(hid)) {
 		/* Successfully submitted next urb in queue */
-		spin_unlock_irqrestore(&usbhid->lock, flags);
+		spin_unlock(&usbhid->lock);
+		if (status !=3D -ECONNRESET)
+			spin_unlock(&usbhid->unlink_lock);
 		return;
 	}

 	clear_bit(HID_OUT_RUNNING, &usbhid->iofl);
-	spin_unlock_irqrestore(&usbhid->lock, flags);
+	spin_unlock(&usbhid->lock);
+	if (status !=3D -ECONNRESET)
+		spin_unlock(&usbhid->unlink_lock);
 	usb_autopm_put_interface_async(usbhid->intf);
 	wake_up(&usbhid->wait);
 }
@@ -458,6 +463,8 @@ static void hid_ctrl(struct urb *urb)
 	struct usbhid_device *usbhid =3D hid->driver_data;
 	int unplug =3D 0, status =3D urb->status;

+	if (status !=3D -ECONNRESET)
+		spin_lock(&usbhid->unlink_lock);
 	spin_lock(&usbhid->lock);

 	switch (status) {
@@ -487,11 +494,15 @@ static void hid_ctrl(struct urb *urb)
 	if (usbhid->ctrlhead !=3D usbhid->ctrltail && !hid_submit_ctrl(hid)) =
{
 		/* Successfully submitted next urb in queue */
 		spin_unlock(&usbhid->lock);
+		if (status !=3D -ECONNRESET)
+			spin_unlock(&usbhid->unlink_lock);
 		return;
 	}

 	clear_bit(HID_CTRL_RUNNING, &usbhid->iofl);
 	spin_unlock(&usbhid->lock);
+	if (status !=3D -ECONNRESET)
+		spin_unlock(&usbhid->unlink_lock);
 	usb_autopm_put_interface_async(usbhid->intf);
 	wake_up(&usbhid->wait);
 }
@@ -546,8 +557,13 @@ static void __usbhid_submit_report(struct
hid_device *hid, struct hid_report *re
 			 * no race because this is called under
 			 * spinlock
 			 */
-			if (time_after(jiffies, usbhid->last_out + HZ * 5))
+
+			if (time_after(jiffies, usbhid->last_out + HZ * 5) &&
+					!usbhid->urbout->unlinked) {
+				spin_unlock(&usbhid->lock);
 				usb_unlink_urb(usbhid->urbout);
+				spin_lock(&usbhid->lock);
+			}
 		}
 		return;
 	}
@@ -594,8 +610,12 @@ static void __usbhid_submit_report(struct
hid_device *hid, struct hid_report *re
 		 * no race because this is called under
 		 * spinlock
 		 */
-		if (time_after(jiffies, usbhid->last_ctrl + HZ * 5))
+		if (time_after(jiffies, usbhid->last_ctrl + HZ * 5) &&
+				!usbhid->urbctrl->unlinked) {
+			spin_unlock(&usbhid->lock);
 			usb_unlink_urb(usbhid->urbctrl);
+			spin_lock(&usbhid->lock);
+		}
 	}
 }

@@ -604,9 +624,11 @@ void usbhid_submit_report(struct hid_device *hid,
struct hid_report *report, uns
 	struct usbhid_device *usbhid =3D hid->driver_data;
 	unsigned long flags;

-	spin_lock_irqsave(&usbhid->lock, flags);
+	spin_lock_irqsave(&usbhid->unlink_lock, flags);
+	spin_lock(&usbhid->lock);
 	__usbhid_submit_report(hid, report, dir);
-	spin_unlock_irqrestore(&usbhid->lock, flags);
+	spin_unlock(&usbhid->lock);
+	spin_unlock_irqrestore(&usbhid->unlink_lock, flags);
 }
 EXPORT_SYMBOL_GPL(usbhid_submit_report);

@@ -625,13 +647,15 @@ static void hid_led(struct work_struct *work)
 		return;
 	}

-	spin_lock_irqsave(&usbhid->lock, flags);
+	spin_lock_irqsave(&usbhid->unlink_lock, flags);
+	spin_lock(&usbhid->lock);
 	if (!test_bit(HID_DISCONNECTED, &usbhid->iofl)) {
 		usbhid->ledcount =3D hidinput_count_leds(hid);
 		hid_dbg(usbhid->hid, "New ledcount =3D %u\n", usbhid->ledcount);
 		__usbhid_submit_report(hid, field->report, USB_DIR_OUT);
 	}
-	spin_unlock_irqrestore(&usbhid->lock, flags);
+	spin_unlock(&usbhid->lock);
+	spin_unlock_irqrestore(&usbhid->unlink_lock, flags);
 }

 static int usb_hidinput_input_event(struct input_dev *dev, unsigned
int type, unsigned int code, int value)
@@ -1299,6 +1323,7 @@ static int usbhid_probe(struct usb_interface
*intf, const struct usb_device_id *
 	INIT_WORK(&usbhid->reset_work, hid_reset);
 	setup_timer(&usbhid->io_retry, hid_retry_timeout, (unsigned long) hid=
);
 	spin_lock_init(&usbhid->lock);
+	spin_lock_init(&usbhid->unlink_lock);

 	INIT_WORK(&usbhid->led_work, hid_led);

diff --git a/drivers/hid/usbhid/usbhid.h b/drivers/hid/usbhid/usbhid.h
index 1883d7b..69af387 100644
--- a/drivers/hid/usbhid/usbhid.h
+++ b/drivers/hid/usbhid/usbhid.h
@@ -90,6 +90,7 @@ struct usbhid_device {
 	unsigned long last_out;							/* record of last output for timeouts *=
/

 	spinlock_t lock;						/* fifo spinlock */
+	spinlock_t unlink_lock;						/* unlink spinlock */
 	unsigned long iofl;                                             /*
I/O flags (CTRL_RUNNING, OUT_RUNNING) */
 	struct timer_list io_retry;                                     /*
Retry timer */
 	unsigned long stop_retry;                                       /*
Time to give up, in jiffies */



Thanks,
--
Ming Lei
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
