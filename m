From: Ming Lei <ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Subject: Re: [PATCH] hid: usbhid: fix possible deadlock in __usbhid_submit_report
Date: Fri, 20 Apr 2012 18:17:51 +0800
Message-ID: <CACVXFVP42WL2aVDGSn0BF0NJbg824VsU=Fs30XKEif6siOrQvw@mail.gmail.com>
References: <1334843464-1585-1-git-send-email-ming.lei@canonical.com>
	<201204191811.33994.oneukum@suse.de>
	<CACVXFVPZQNNvGk0cn4XWDTKd_s71V0Yd9nZJ3nkEg1Qh7W+B5g@mail.gmail.com>
	<201204200957.34154.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201204200957.34154.oneukum-l3A5Bk7waGM@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Fri, Apr 20, 2012 at 3:57 PM, Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org> wrote:
>
> You are racing with hid_irq_out(). It calls hid_submit_out()
> under lock. So if hid_irq_out() is running between dropping
> the lock and usb_unlink_urb() you may kill the newly submitted
> urb, not the old urb that has timed out.

Yes, it is the race I missed, :-(

> You must make sure that between the times you check usbhid->last_out
> and calling unlink hid_submit_out() cannot be called.
> You can't just drop the lock (at least on SMP)

Looks it is not easy to avoid the race if the lock is to be dropped.

So how about not acquiring the lock during unlinking as below?

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index aa1c503..b437223 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -429,7 +429,8 @@ static void hid_irq_out(struct urb *urb)
 			 urb->status);
 	}

-	spin_lock_irqsave(&usbhid->lock, flags);
+	if (!test_cpu_bit(HID_PCPU_TIMEOUT, usbhid->cpuiofl))
+		spin_lock_irqsave(&usbhid->lock, flags);

 	if (unplug)
 		usbhid->outtail = usbhid->outhead;
@@ -438,12 +439,14 @@ static void hid_irq_out(struct urb *urb)

 	if (usbhid->outhead != usbhid->outtail && !hid_submit_out(hid)) {
 		/* Successfully submitted next urb in queue */
-		spin_unlock_irqrestore(&usbhid->lock, flags);
+		if (!test_cpu_bit(HID_PCPU_TIMEOUT, usbhid->cpuiofl))
+			spin_unlock_irqrestore(&usbhid->lock, flags);
 		return;
 	}

 	clear_bit(HID_OUT_RUNNING, &usbhid->iofl);
-	spin_unlock_irqrestore(&usbhid->lock, flags);
+	if (!test_cpu_bit(HID_PCPU_TIMEOUT, usbhid->cpuiofl))
+		spin_unlock_irqrestore(&usbhid->lock, flags);
 	usb_autopm_put_interface_async(usbhid->intf);
 	wake_up(&usbhid->wait);
 }
@@ -458,7 +461,8 @@ static void hid_ctrl(struct urb *urb)
 	struct usbhid_device *usbhid = hid->driver_data;
 	int unplug = 0, status = urb->status;

-	spin_lock(&usbhid->lock);
+	if (!test_cpu_bit(HID_PCPU_TIMEOUT, usbhid->cpuiofl))
+		spin_lock(&usbhid->lock);

 	switch (status) {
 	case 0:			/* success */
@@ -486,12 +490,14 @@ static void hid_ctrl(struct urb *urb)

 	if (usbhid->ctrlhead != usbhid->ctrltail && !hid_submit_ctrl(hid)) {
 		/* Successfully submitted next urb in queue */
-		spin_unlock(&usbhid->lock);
+		if (!test_cpu_bit(HID_PCPU_TIMEOUT, usbhid->cpuiofl))
+			spin_unlock(&usbhid->lock);
 		return;
 	}

 	clear_bit(HID_CTRL_RUNNING, &usbhid->iofl);
-	spin_unlock(&usbhid->lock);
+	if (!test_cpu_bit(HID_PCPU_TIMEOUT, usbhid->cpuiofl))
+		spin_unlock(&usbhid->lock);
 	usb_autopm_put_interface_async(usbhid->intf);
 	wake_up(&usbhid->wait);
 }
@@ -546,8 +552,11 @@ static void __usbhid_submit_report(struct
hid_device *hid, struct hid_report *re
 			 * no race because this is called under
 			 * spinlock
 			 */
-			if (time_after(jiffies, usbhid->last_out + HZ * 5))
+			if (time_after(jiffies, usbhid->last_out + HZ * 5)) {
+				set_cpu_bit(HID_PCPU_TIMEOUT, usbhid->cpuiofl);
 				usb_unlink_urb(usbhid->urbout);
+				clear_cpu_bit(HID_PCPU_TIMEOUT, usbhid->cpuiofl);
+			}
 		}
 		return;
 	}
@@ -594,8 +603,11 @@ static void __usbhid_submit_report(struct
hid_device *hid, struct hid_report *re
 		 * no race because this is called under
 		 * spinlock
 		 */
-		if (time_after(jiffies, usbhid->last_ctrl + HZ * 5))
-			usb_unlink_urb(usbhid->urbctrl);
+		if (time_after(jiffies, usbhid->last_ctrl + HZ * 5)) {
+				set_cpu_bit(HID_PCPU_TIMEOUT, usbhid->cpuiofl);
+				usb_unlink_urb(usbhid->urbctrl);
+				clear_cpu_bit(HID_PCPU_TIMEOUT, usbhid->cpuiofl);
+		}
 	}
 }

@@ -1294,6 +1306,12 @@ static int usbhid_probe(struct usb_interface
*intf, const struct usb_device_id *
 	usbhid->hid = hid;
 	usbhid->intf = intf;
 	usbhid->ifnum = interface->desc.bInterfaceNumber;
+	usbhid->cpuiofl = alloc_percpu(unsigned long);
+	if (!usbhid->cpuiofl) {
+		ret = -ENOMEM;
+		goto err_free;
+	}
+

 	init_waitqueue_head(&usbhid->wait);
 	INIT_WORK(&usbhid->reset_work, hid_reset);
@@ -1306,10 +1324,12 @@ static int usbhid_probe(struct usb_interface
*intf, const struct usb_device_id *
 	if (ret) {
 		if (ret != -ENODEV)
 			hid_err(intf, "can't add hid device: %d\n", ret);
-		goto err_free;
+		goto err_add_dev;
 	}

 	return 0;
+err_add_dev:
+	free_percpu(usbhid->cpuiofl);
 err_free:
 	kfree(usbhid);
 err:
@@ -1327,6 +1347,7 @@ static void usbhid_disconnect(struct usb_interface *intf)

 	usbhid = hid->driver_data;
 	hid_destroy_device(hid);
+	free_percpu(usbhid->cpuiofl);
 	kfree(usbhid);
 }

diff --git a/drivers/hid/usbhid/usbhid.h b/drivers/hid/usbhid/usbhid.h
index 1883d7b..8fd240e 100644
--- a/drivers/hid/usbhid/usbhid.h
+++ b/drivers/hid/usbhid/usbhid.h
@@ -57,6 +57,9 @@ struct usb_interface *usbhid_find_interface(int minor);
 #define HID_KEYS_PRESSED	10
 #define HID_NO_BANDWIDTH	11

+/*per cpu iofl flags */
+#define HID_PCPU_TIMEOUT	1
+
 /*
  * USB-specific HID struct, to be pointed to
  * from struct hid_device->driver_data
@@ -91,6 +94,7 @@ struct usbhid_device {

 	spinlock_t lock;						/* fifo spinlock */
 	unsigned long iofl;                                             /*
I/O flags (CTRL_RUNNING, OUT_RUNNING) */
+	unsigned long __percpu *cpuiofl;                                /*
per cpu I/O flags (PCPU_TIMEOUT) */
 	struct timer_list io_retry;                                     /*
Retry timer */
 	unsigned long stop_retry;                                       /*
Time to give up, in jiffies */
 	unsigned int retry_delay;                                       /*
Delay length in ms */
@@ -104,5 +108,23 @@ struct usbhid_device {
 #define	hid_to_usb_dev(hid_dev) \
 	container_of(hid_dev->dev.parent->parent, struct usb_device, dev)

+static inline void set_cpu_bit(int nr, unsigned long __percpu *addr)
+{
+	unsigned long *fl = __this_cpu_ptr(addr);
+	set_bit(nr, fl);
+}
+
+static inline void clear_cpu_bit(int nr, unsigned long __percpu *addr)
+{
+	unsigned long *fl = __this_cpu_ptr(addr);
+	clear_bit(nr, fl);
+}
+
+static inline int test_cpu_bit(int nr, unsigned long __percpu *addr)
+{
+	unsigned long *fl = __this_cpu_ptr(addr);
+	return test_bit(nr, fl);
+}
+
 #endif


thanks,
--
Ming Lei
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
