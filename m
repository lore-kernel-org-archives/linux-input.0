From: Yi Yang <yi.y.yang@intel.com>
Subject: Re: [patch]aggessive autosuspend for HID devices (resent due to
	corruption)
Date: Tue, 28 Oct 2008 18:20:55 +0800
Message-ID: <1225189255.17415.4.camel@yangyi-dev>
References: <200810271042.37365.oliver@neukum.org>
Reply-To: yi.y.yang@intel.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:58866 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751233AbYJ1CU4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Oct 2008 22:20:56 -0400
In-Reply-To: <200810271042.37365.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Jiri Kosina <jikos@jikos.cz>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Mon, 2008-10-27 at 02:42 -0700, Oliver Neukum wrote:
> Hi,
> 
> this is the mergeable version as far as I am concerned. The problems
> I had last week were caused by another issue in the USB stack fixed
> in rc2.
> 
> This uses the USB busy mechanism for aggessive autosuspend of USB
> HID devices. It autosuspends all opened devices supporting remote wakeup
> after a timeout unless
> 
> - output is being done to the device
> - a key is being held down (remote wakeup isn't triggered upon key release)
> - LED(s) are lit
> - hiddev is opened
> 
> As in the current driver closed devices will be autosuspended even if they
> don't support remote wakeup.
> 
> The patch is quite large because output to devices is done in hard interrupt
> context meaning a lot a queuing and locking had to be touched. The LED stuff
> has been solved by means of a simple counter. Additions to the generic HID code
> could be avoided.
> 
> The patch is against 2.6.28-rc2diff
You can use scripts/checkpatch.pl to check if your patch follows coding
style, use tab instead of 8 white spaces.

> 
> Regards
>         Oliver
> 
> Signed-off-by: Oliver Neukum <oneukum@suse.de>
> 
> ---
> 
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1674,6 +1674,22 @@ static DECLARE_WORK(hid_compat_work, hid_compat_load);
>  static struct workqueue_struct *hid_compat_wq;
>  #endif
> 
> +int hid_check_keys_pressed(struct hid_device *hid)
> +{
> +       struct hid_input *hidinput;
> +       int i;
> +
> +       list_for_each_entry(hidinput, &hid->inputs, list) {
> +               for (i = 0; i < BITS_TO_LONGS(KEY_MAX); i++)
> +                       if (hidinput->input->key[i])
> +                               return 1;
> +       }
> +
> +       return 0;
> +}
> +
> +EXPORT_SYMBOL_GPL(hid_check_keys_pressed);
> +
>  static int __init hid_init(void)
>  {
>         int ret;
> --- a/drivers/hid/usbhid/hid-core.c
> +++ b/drivers/hid/usbhid/hid-core.c
> @@ -5,6 +5,7 @@
>   *  Copyright (c) 2000-2005 Vojtech Pavlik <vojtech@suse.cz>
>   *  Copyright (c) 2005 Michael Haboustak <mike-@cinci.rr.com> for Concept2, Inc
>   *  Copyright (c) 2006-2007 Jiri Kosina
> + *  Copyright (c) 2007-2008 Oliver Neukum
>   */
> 
>  /*
> @@ -26,6 +27,7 @@
>  #include <asm/byteorder.h>
>  #include <linux/input.h>
>  #include <linux/wait.h>
> +#include <linux/workqueue.h>
> 
>  #include <linux/usb.h>
> 
> @@ -52,6 +54,10 @@ static unsigned int hid_mousepoll_interval;
>  module_param_named(mousepoll, hid_mousepoll_interval, uint, 0644);
>  MODULE_PARM_DESC(mousepoll, "Polling interval of mice");
> 
> +static unsigned int ignoreled;
> +module_param_named(ignoreled, ignoreled, uint, 0644);
> +MODULE_PARM_DESC(ignoreled, "Autosuspend with active leds");
> +
>  /* Quirks specified at module load time */
>  static char *quirks_param[MAX_USBHID_BOOT_QUIRKS] = { [ 0 ... (MAX_USBHID_BOOT_QUIRKS - 1) ] = NULL };
>  module_param_array_named(quirks, quirks_param, charp, NULL, 0444);
> @@ -62,8 +68,12 @@ MODULE_PARM_DESC(quirks, "Add/modify USB HID quirks by specifying "
>  /*
>   * Input submission and I/O error handler.
>   */
> +static DEFINE_MUTEX(hid_open_mut);
> +static struct workqueue_struct *resumption_waker;
> 
>  static void hid_io_error(struct hid_device *hid);
> +static int hid_submit_out(struct hid_device *hid);
> +static int hid_submit_ctrl(struct hid_device *hid);
> 
>  /* Start up the input URB */
>  static int hid_start_in(struct hid_device *hid)
> @@ -72,15 +82,16 @@ static int hid_start_in(struct hid_device *hid)
>         int rc = 0;
>         struct usbhid_device *usbhid = hid->driver_data;
> 
> -       spin_lock_irqsave(&usbhid->inlock, flags);
> -       if (hid->open > 0 && !test_bit(HID_SUSPENDED, &usbhid->iofl) &&
> +       spin_lock_irqsave(&usbhid->lock, flags);
> +       if (hid->open > 0 &&
>                         !test_bit(HID_DISCONNECTED, &usbhid->iofl) &&
> +                       !test_bit(HID_REPORTED_IDLE, &usbhid->iofl) &&
>                         !test_and_set_bit(HID_IN_RUNNING, &usbhid->iofl)) {
>                 rc = usb_submit_urb(usbhid->urbin, GFP_ATOMIC);
>                 if (rc != 0)
>                         clear_bit(HID_IN_RUNNING, &usbhid->iofl);
>         }
> -       spin_unlock_irqrestore(&usbhid->inlock, flags);
> +       spin_unlock_irqrestore(&usbhid->lock, flags);
>         return rc;
>  }
> 
> @@ -145,7 +156,7 @@ static void hid_io_error(struct hid_device *hid)
>         unsigned long flags;
>         struct usbhid_device *usbhid = hid->driver_data;
> 
> -       spin_lock_irqsave(&usbhid->inlock, flags);
> +       spin_lock_irqsave(&usbhid->lock, flags);
> 
>         /* Stop when disconnected */
>         if (test_bit(HID_DISCONNECTED, &usbhid->iofl))
> @@ -175,7 +186,51 @@ static void hid_io_error(struct hid_device *hid)
>         mod_timer(&usbhid->io_retry,
>                         jiffies + msecs_to_jiffies(usbhid->retry_delay));
>  done:
> -       spin_unlock_irqrestore(&usbhid->inlock, flags);
> +       spin_unlock_irqrestore(&usbhid->lock, flags);
> +}
> +
> +static void usbhid_mark_busy(struct usbhid_device *usbhid)
> +{
> +       struct usb_interface *intf = usbhid->intf;
> +
> +       usb_mark_last_busy(interface_to_usbdev(intf));
> +}
> +
> +static int usbhid_restart_out_queue(struct usbhid_device *usbhid)
> +{
> +       struct hid_device *hid = usb_get_intfdata(usbhid->intf);
> +       int kicked;
> +
> +       if (!hid)
> +               return 0;
> +
> +       if ((kicked = (usbhid->outhead != usbhid->outtail))) {
> +               dbg("Kicking head %d tail %d", usbhid->outhead, usbhid->outtail);
> +               if (hid_submit_out(hid)) {
> +                       clear_bit(HID_OUT_RUNNING, &usbhid->iofl);
> +                       wake_up(&usbhid->wait);
> +               }
> +       }
> +       return kicked;
> +}
> +
> +static int usbhid_restart_ctrl_queue(struct usbhid_device *usbhid)
> +{
> +       struct hid_device *hid = usb_get_intfdata(usbhid->intf);
> +       int kicked;
> +
> +       WARN_ON(hid == NULL);
> +       if (!hid)
> +               return 0;
> +
> +       if ((kicked = (usbhid->ctrlhead != usbhid->ctrltail))) {
> +               dbg("Kicking head %d tail %d", usbhid->ctrlhead, usbhid->ctrltail);
> +               if (hid_submit_ctrl(hid)) {
> +                       clear_bit(HID_CTRL_RUNNING, &usbhid->iofl);
> +                       wake_up(&usbhid->wait);
> +               }
> +       }
> +       return kicked;
>  }
> 
>  /*
> @@ -190,12 +245,19 @@ static void hid_irq_in(struct urb *urb)
> 
>         switch (urb->status) {
>         case 0:                 /* success */
> +               usbhid_mark_busy(usbhid);
>                 usbhid->retry_delay = 0;
>                 hid_input_report(urb->context, HID_INPUT_REPORT,
>                                  urb->transfer_buffer,
>                                  urb->actual_length, 1);
> +               /* autosuspend refused while keys are pressed*/
> +               if (hid_check_keys_pressed(hid))
> +                       set_bit(HID_KEYS_PRESSED, &usbhid->iofl);
> +               else
> +                       clear_bit(HID_KEYS_PRESSED, &usbhid->iofl);
>                 break;
>         case -EPIPE:            /* stall */
> +               usbhid_mark_busy(usbhid);
>                 clear_bit(HID_IN_RUNNING, &usbhid->iofl);
>                 set_bit(HID_CLEAR_HALT, &usbhid->iofl);
>                 schedule_work(&usbhid->reset_work);
> @@ -209,6 +271,7 @@ static void hid_irq_in(struct urb *urb)
>         case -EPROTO:           /* protocol error or unplug */
>         case -ETIME:            /* protocol error or unplug */
>         case -ETIMEDOUT:        /* Should never happen, but... */
> +               usbhid_mark_busy(usbhid);
>                 clear_bit(HID_IN_RUNNING, &usbhid->iofl);
>                 hid_io_error(hid);
>                 return;
> @@ -239,16 +302,25 @@ static int hid_submit_out(struct hid_device *hid)
>         report = usbhid->out[usbhid->outtail].report;
>         raw_report = usbhid->out[usbhid->outtail].raw_report;
> 
> -       usbhid->urbout->transfer_buffer_length = ((report->size - 1) >> 3) + 1 + (report->id > 0);
> -       usbhid->urbout->dev = hid_to_usb_dev(hid);
> -       memcpy(usbhid->outbuf, raw_report, usbhid->urbout->transfer_buffer_length);
> -       kfree(raw_report);
> +       if (!test_bit(HID_REPORTED_IDLE, &usbhid->iofl)) {
> +               usbhid->urbout->transfer_buffer_length = ((report->size - 1) >> 3) + 1 + (report->id > 0);
> +               usbhid->urbout->dev = hid_to_usb_dev(hid);
> +               memcpy(usbhid->outbuf, raw_report, usbhid->urbout->transfer_buffer_length);
> +               kfree(raw_report);
> 
> -       dbg_hid("submitting out urb\n");
> +               dbg_hid("submitting out urb\n");
> 
> -       if (usb_submit_urb(usbhid->urbout, GFP_ATOMIC)) {
> -               err_hid("usb_submit_urb(out) failed");
> -               return -1;
> +               if (usb_submit_urb(usbhid->urbout, GFP_ATOMIC)) {
> +                       err_hid("usb_submit_urb(out) failed");
> +                       return -1;
> +               }
> +       } else {
> +               /*
> +                * queue work to wake up the device.
> +                * as the work queue is freezeable, this is safe
> +                * with respect to STD and STR
> +                */
> +               queue_work(resumption_waker, &usbhid->restart_work);
>         }
> 
>         return 0;
> @@ -266,41 +338,50 @@ static int hid_submit_ctrl(struct hid_device *hid)
>         raw_report = usbhid->ctrl[usbhid->ctrltail].raw_report;
>         dir = usbhid->ctrl[usbhid->ctrltail].dir;
> 
> -       len = ((report->size - 1) >> 3) + 1 + (report->id > 0);
> -       if (dir == USB_DIR_OUT) {
> -               usbhid->urbctrl->pipe = usb_sndctrlpipe(hid_to_usb_dev(hid), 0);
> -               usbhid->urbctrl->transfer_buffer_length = len;
> -               memcpy(usbhid->ctrlbuf, raw_report, len);
> -               kfree(raw_report);
> -       } else {
> -               int maxpacket, padlen;
> -
> -               usbhid->urbctrl->pipe = usb_rcvctrlpipe(hid_to_usb_dev(hid), 0);
> -               maxpacket = usb_maxpacket(hid_to_usb_dev(hid), usbhid->urbctrl->pipe, 0);
> -               if (maxpacket > 0) {
> -                       padlen = DIV_ROUND_UP(len, maxpacket);
> -                       padlen *= maxpacket;
> -                       if (padlen > usbhid->bufsize)
> -                               padlen = usbhid->bufsize;
> -               } else
> -                       padlen = 0;
> -               usbhid->urbctrl->transfer_buffer_length = padlen;
> -       }
> -       usbhid->urbctrl->dev = hid_to_usb_dev(hid);
> +       if (!test_bit(HID_REPORTED_IDLE, &usbhid->iofl)) {
> +               len = ((report->size - 1) >> 3) + 1 + (report->id > 0);
> +               if (dir == USB_DIR_OUT) {
> +                       usbhid->urbctrl->pipe = usb_sndctrlpipe(hid_to_usb_dev(hid), 0);
> +                       usbhid->urbctrl->transfer_buffer_length = len;
> +                       memcpy(usbhid->ctrlbuf, raw_report, len);
> +                       kfree(raw_report);
> +               } else {
> +                       int maxpacket, padlen;
> +
> +                       usbhid->urbctrl->pipe = usb_rcvctrlpipe(hid_to_usb_dev(hid), 0);
> +                       maxpacket = usb_maxpacket(hid_to_usb_dev(hid), usbhid->urbctrl->pipe, 0);
> +                       if (maxpacket > 0) {
> +                               padlen = DIV_ROUND_UP(len, maxpacket);
> +                               padlen *= maxpacket;
> +                               if (padlen > usbhid->bufsize)
> +                                       padlen = usbhid->bufsize;
> +                       } else
> +                               padlen = 0;
> +                       usbhid->urbctrl->transfer_buffer_length = padlen;
> +               }
> +               usbhid->urbctrl->dev = hid_to_usb_dev(hid);
> 
> -       usbhid->cr->bRequestType = USB_TYPE_CLASS | USB_RECIP_INTERFACE | dir;
> -       usbhid->cr->bRequest = (dir == USB_DIR_OUT) ? HID_REQ_SET_REPORT : HID_REQ_GET_REPORT;
> -       usbhid->cr->wValue = cpu_to_le16(((report->type + 1) << 8) | report->id);
> -       usbhid->cr->wIndex = cpu_to_le16(usbhid->ifnum);
> -       usbhid->cr->wLength = cpu_to_le16(len);
> +               usbhid->cr->bRequestType = USB_TYPE_CLASS | USB_RECIP_INTERFACE | dir;
> +               usbhid->cr->bRequest = (dir == USB_DIR_OUT) ? HID_REQ_SET_REPORT : HID_REQ_GET_REPORT;
> +               usbhid->cr->wValue = cpu_to_le16(((report->type + 1) << 8) | report->id);
> +               usbhid->cr->wIndex = cpu_to_le16(usbhid->ifnum);
> +               usbhid->cr->wLength = cpu_to_le16(len);
> 
> -       dbg_hid("submitting ctrl urb: %s wValue=0x%04x wIndex=0x%04x wLength=%u\n",
> -               usbhid->cr->bRequest == HID_REQ_SET_REPORT ? "Set_Report" : "Get_Report",
> -               usbhid->cr->wValue, usbhid->cr->wIndex, usbhid->cr->wLength);
> +               dbg_hid("submitting ctrl urb: %s wValue=0x%04x wIndex=0x%04x wLength=%u\n",
> +                       usbhid->cr->bRequest == HID_REQ_SET_REPORT ? "Set_Report" : "Get_Report",
> +                       usbhid->cr->wValue, usbhid->cr->wIndex, usbhid->cr->wLength);
> 
> -       if (usb_submit_urb(usbhid->urbctrl, GFP_ATOMIC)) {
> -               err_hid("usb_submit_urb(ctrl) failed");
> -               return -1;
> +               if (usb_submit_urb(usbhid->urbctrl, GFP_ATOMIC)) {
> +                       err_hid("usb_submit_urb(ctrl) failed");
> +                       return -1;
> +               }
> +       } else {
> +               /*
> +                * queue work to wake up the device.
> +                * as the work queue is freezeable, this is safe
> +                * with respect to STD and STR
> +                */
> +               queue_work(resumption_waker, &usbhid->restart_work);
>         }
> 
>         return 0;
> @@ -332,7 +413,7 @@ static void hid_irq_out(struct urb *urb)
>                                 "received\n", urb->status);
>         }
> 
> -       spin_lock_irqsave(&usbhid->outlock, flags);
> +       spin_lock_irqsave(&usbhid->lock, flags);
> 
>         if (unplug)
>                 usbhid->outtail = usbhid->outhead;
> @@ -344,12 +425,12 @@ static void hid_irq_out(struct urb *urb)
>                         clear_bit(HID_OUT_RUNNING, &usbhid->iofl);
>                         wake_up(&usbhid->wait);
>                 }
> -               spin_unlock_irqrestore(&usbhid->outlock, flags);
> +               spin_unlock_irqrestore(&usbhid->lock, flags);
>                 return;
>         }
> 
>         clear_bit(HID_OUT_RUNNING, &usbhid->iofl);
> -       spin_unlock_irqrestore(&usbhid->outlock, flags);
> +       spin_unlock_irqrestore(&usbhid->lock, flags);
>         wake_up(&usbhid->wait);
>  }
> 
> @@ -361,12 +442,11 @@ static void hid_ctrl(struct urb *urb)
>  {
>         struct hid_device *hid = urb->context;
>         struct usbhid_device *usbhid = hid->driver_data;
> -       unsigned long flags;
> -       int unplug = 0;
> +       int unplug = 0, status = urb->status;
> 
> -       spin_lock_irqsave(&usbhid->ctrllock, flags);
> +       spin_lock(&usbhid->lock);
> 
> -       switch (urb->status) {
> +       switch (status) {
>         case 0:                 /* success */
>                 if (usbhid->ctrl[usbhid->ctrltail].dir == USB_DIR_IN)
>                         hid_input_report(urb->context,
> @@ -383,7 +463,7 @@ static void hid_ctrl(struct urb *urb)
>                 break;
>         default:                /* error */
>                 dev_warn(&urb->dev->dev, "ctrl urb status %d "
> -                               "received\n", urb->status);
> +                               "received\n", status);
>         }
> 
>         if (unplug)
> @@ -396,19 +476,18 @@ static void hid_ctrl(struct urb *urb)
>                         clear_bit(HID_CTRL_RUNNING, &usbhid->iofl);
>                         wake_up(&usbhid->wait);
>                 }
> -               spin_unlock_irqrestore(&usbhid->ctrllock, flags);
> +               spin_unlock(&usbhid->lock);
>                 return;
>         }
> 
>         clear_bit(HID_CTRL_RUNNING, &usbhid->iofl);
> -       spin_unlock_irqrestore(&usbhid->ctrllock, flags);
> +       spin_unlock(&usbhid->lock);
>         wake_up(&usbhid->wait);
>  }
> 
> -void usbhid_submit_report(struct hid_device *hid, struct hid_report *report, unsigned char dir)
> +void __usbhid_submit_report(struct hid_device *hid, struct hid_report *report, unsigned char dir)
>  {
>         int head;
> -       unsigned long flags;
>         struct usbhid_device *usbhid = hid->driver_data;
>         int len = ((report->size - 1) >> 3) + 1 + (report->id > 0);
> 
> @@ -416,18 +495,13 @@ void usbhid_submit_report(struct hid_device *hid, struct hid_report *report, uns
>                 return;
> 
>         if (usbhid->urbout && dir == USB_DIR_OUT && report->type == HID_OUTPUT_REPORT) {
> -
> -               spin_lock_irqsave(&usbhid->outlock, flags);
> -
>                 if ((head = (usbhid->outhead + 1) & (HID_OUTPUT_FIFO_SIZE - 1)) == usbhid->outtail) {
> -                       spin_unlock_irqrestore(&usbhid->outlock, flags);
>                         dev_warn(&hid->dev, "output queue full\n");
>                         return;
>                 }
> 
>                 usbhid->out[usbhid->outhead].raw_report = kmalloc(len, GFP_ATOMIC);
>                 if (!usbhid->out[usbhid->outhead].raw_report) {
> -                       spin_unlock_irqrestore(&usbhid->outlock, flags);
>                         dev_warn(&hid->dev, "output queueing failed\n");
>                         return;
>                 }
> @@ -438,15 +512,10 @@ void usbhid_submit_report(struct hid_device *hid, struct hid_report *report, uns
>                 if (!test_and_set_bit(HID_OUT_RUNNING, &usbhid->iofl))
>                         if (hid_submit_out(hid))
>                                 clear_bit(HID_OUT_RUNNING, &usbhid->iofl);
> -
> -               spin_unlock_irqrestore(&usbhid->outlock, flags);
>                 return;
>         }
> 
> -       spin_lock_irqsave(&usbhid->ctrllock, flags);
> -
>         if ((head = (usbhid->ctrlhead + 1) & (HID_CONTROL_FIFO_SIZE - 1)) == usbhid->ctrltail) {
> -               spin_unlock_irqrestore(&usbhid->ctrllock, flags);
>                 dev_warn(&hid->dev, "control queue full\n");
>                 return;
>         }
> @@ -454,7 +523,6 @@ void usbhid_submit_report(struct hid_device *hid, struct hid_report *report, uns
>         if (dir == USB_DIR_OUT) {
>                 usbhid->ctrl[usbhid->ctrlhead].raw_report = kmalloc(len, GFP_ATOMIC);
>                 if (!usbhid->ctrl[usbhid->ctrlhead].raw_report) {
> -                       spin_unlock_irqrestore(&usbhid->ctrllock, flags);
>                         dev_warn(&hid->dev, "control queueing failed\n");
>                         return;
>                 }
> @@ -467,15 +535,25 @@ void usbhid_submit_report(struct hid_device *hid, struct hid_report *report, uns
>         if (!test_and_set_bit(HID_CTRL_RUNNING, &usbhid->iofl))
>                 if (hid_submit_ctrl(hid))
>                         clear_bit(HID_CTRL_RUNNING, &usbhid->iofl);
> +}
> 
> -       spin_unlock_irqrestore(&usbhid->ctrllock, flags);
> +void usbhid_submit_report(struct hid_device *hid, struct hid_report *report, unsigned char dir)
> +{
> +       struct usbhid_device *usbhid = hid->driver_data;
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&usbhid->lock, flags);
> +       __usbhid_submit_report(hid, report, dir);
> +       spin_unlock_irqrestore(&usbhid->lock, flags);
>  }
>  EXPORT_SYMBOL_GPL(usbhid_submit_report);
> 
>  static int usb_hidinput_input_event(struct input_dev *dev, unsigned int type, unsigned int code, int value)
>  {
>         struct hid_device *hid = input_get_drvdata(dev);
> +       struct usbhid_device *usbhid = hid->driver_data;
>         struct hid_field *field;
> +       unsigned long flags;
>         int offset;
> 
>         if (type == EV_FF)
> @@ -490,6 +568,15 @@ static int usb_hidinput_input_event(struct input_dev *dev, unsigned int type, un
>         }
> 
>         hid_set_field(field, offset, value);
> +       if (value) {
> +               spin_lock_irqsave(&usbhid->lock, flags);
> +               usbhid->ledcount++;
> +               spin_unlock_irqrestore(&usbhid->lock, flags);
> +       } else {
> +               spin_lock_irqsave(&usbhid->lock, flags);
> +               usbhid->ledcount--;
> +               spin_unlock_irqrestore(&usbhid->lock, flags);
> +       }
>         usbhid_submit_report(hid, field->report, USB_DIR_OUT);
> 
>         return 0;
> @@ -538,15 +625,22 @@ int usbhid_open(struct hid_device *hid)
>         struct usbhid_device *usbhid = hid->driver_data;
>         int res;
> 
> +       mutex_lock(&hid_open_mut);
>         if (!hid->open++) {
>                 res = usb_autopm_get_interface(usbhid->intf);
> +               /* the device must be awake to reliable request remote wakeup */
>                 if (res < 0) {
>                         hid->open--;
> +                       mutex_unlock(&hid_open_mut);
>                         return -EIO;
>                 }
> +               usbhid->intf->needs_remote_wakeup = 1;
> +               if (hid_start_in(hid))
> +                       hid_io_error(hid);
> +
> +               usb_autopm_put_interface(usbhid->intf);
>         }
> -       if (hid_start_in(hid))
> -               hid_io_error(hid);
> +       mutex_unlock(&hid_open_mut);
>         return 0;
>  }
> 
> @@ -554,10 +648,22 @@ void usbhid_close(struct hid_device *hid)
>  {
>         struct usbhid_device *usbhid = hid->driver_data;
> 
> +       mutex_lock(&hid_open_mut);
> +
> +       /* protecting hid->open to make sure we don't restart
> +        * data acquistion due to a resumption we no longer
> +        * care about
> +        */
> +       spin_lock_irq(&usbhid->lock);
>         if (!--hid->open) {
> +               spin_unlock_irq(&usbhid->lock);
>                 usb_kill_urb(usbhid->urbin);
> -               usb_autopm_put_interface(usbhid->intf);
> +               flush_scheduled_work();
> +               usbhid->intf->needs_remote_wakeup = 0;
> +       } else {
> +               spin_unlock_irq(&usbhid->lock);
>         }
> +       mutex_unlock(&hid_open_mut);
>  }
> 
>  /*
> @@ -686,6 +792,25 @@ static int usbhid_output_raw_report(struct hid_device *hid, __u8 *buf, size_t co
>         return ret;
>  }
> 
> +static void usbhid_restart_queues(struct usbhid_device *usbhid)
> +{
> +       if (usbhid->urbout)
> +               usbhid_restart_out_queue(usbhid);
> +       usbhid_restart_ctrl_queue(usbhid);
> +}
> +
> +static void __usbhid_restart_queues(struct work_struct *work)
> +{
> +       struct usbhid_device *usbhid =
> +               container_of(work, struct usbhid_device, restart_work);
> +       int r;
> +
> +       r = usb_autopm_get_interface(usbhid->intf);
> +       if (r < 0)
> +               return;
> +       usb_autopm_put_interface(usbhid->intf);
> +}
> +
>  static void hid_free_buffers(struct usb_device *dev, struct hid_device *hid)
>  {
>         struct usbhid_device *usbhid = hid->driver_data;
> @@ -864,11 +989,11 @@ static int usbhid_start(struct hid_device *hid)
> 
>         init_waitqueue_head(&usbhid->wait);
>         INIT_WORK(&usbhid->reset_work, hid_reset);
> +       INIT_WORK(&usbhid->restart_work, __usbhid_restart_queues);
>         setup_timer(&usbhid->io_retry, hid_retry_timeout, (unsigned long) hid);
> 
> -       spin_lock_init(&usbhid->inlock);
> -       spin_lock_init(&usbhid->outlock);
> -       spin_lock_init(&usbhid->ctrllock);
> +       spin_lock_init(&usbhid->lock);
> +       spin_lock_init(&usbhid->lock);
> 
>         usbhid->intf = intf;
>         usbhid->ifnum = interface->desc.bInterfaceNumber;
> @@ -907,14 +1032,15 @@ static void usbhid_stop(struct hid_device *hid)
>         if (WARN_ON(!usbhid))
>                 return;
> 
> -       spin_lock_irq(&usbhid->inlock); /* Sync with error handler */
> +       spin_lock_irq(&usbhid->lock);   /* Sync with error handler */
>         set_bit(HID_DISCONNECTED, &usbhid->iofl);
> -       spin_unlock_irq(&usbhid->inlock);
> +       spin_unlock_irq(&usbhid->lock);
>         usb_kill_urb(usbhid->urbin);
>         usb_kill_urb(usbhid->urbout);
>         usb_kill_urb(usbhid->urbctrl);
> 
>         del_timer_sync(&usbhid->io_retry);
> +       cancel_work_sync(&usbhid->restart_work);
>         cancel_work_sync(&usbhid->reset_work);
> 
>         if (hid->claimed & HID_CLAIMED_INPUT)
> @@ -1020,16 +1146,67 @@ static void hid_disconnect(struct usb_interface *intf)
>         hid_destroy_device(hid);
>  }
> 
> +static void hid_cease_io(struct usbhid_device *usbhid)
> +{
> +       del_timer(&usbhid->io_retry);
> +       usb_kill_urb(usbhid->urbin);
> +       usb_kill_urb(usbhid->urbctrl);
> +       usb_kill_urb(usbhid->urbout);
> +       flush_scheduled_work();
> +}
> +
>  static int hid_suspend(struct usb_interface *intf, pm_message_t message)
>  {
> -       struct hid_device *hid = usb_get_intfdata (intf);
> +       struct hid_device *hid = usb_get_intfdata(intf);
>         struct usbhid_device *usbhid = hid->driver_data;
> +       struct usb_device *udev = interface_to_usbdev(intf);
> +       int status;
> 
> -       spin_lock_irq(&usbhid->inlock); /* Sync with error handler */
> -       set_bit(HID_SUSPENDED, &usbhid->iofl);
> -       spin_unlock_irq(&usbhid->inlock);
> -       del_timer(&usbhid->io_retry);
> -       usb_kill_urb(usbhid->urbin);
> +       if (udev->auto_pm) {
> +               spin_lock_irq(&usbhid->lock);   /* Sync with error handler */
> +               if (!test_bit(HID_RESET_PENDING, &usbhid->iofl)
> +                   && !test_bit(HID_CLEAR_HALT, &usbhid->iofl)
> +                   && !test_bit(HID_OUT_RUNNING, &usbhid->iofl)
> +                   && !test_bit(HID_CTRL_RUNNING, &usbhid->iofl)
> +                   && !test_bit(HID_KEYS_PRESSED, &usbhid->iofl)
> +                   && (!usbhid->ledcount || ignoreled))
> +               {
> +                       set_bit(HID_REPORTED_IDLE, &usbhid->iofl);
> +                       spin_unlock_irq(&usbhid->lock);
> +               } else {
> +                       usbhid_mark_busy(usbhid);
> +                       spin_unlock_irq(&usbhid->lock);
> +                       return -EBUSY;
> +               }
> +
> +       } else {
> +               spin_lock_irq(&usbhid->lock);
> +               set_bit(HID_REPORTED_IDLE, &usbhid->iofl);
> +               spin_unlock_irq(&usbhid->lock);
> +               if (usbhid_wait_io(hid) < 0)
> +                       return -EIO;
> +       }
> +
> +       if (!ignoreled && udev->auto_pm) {
> +               spin_lock_irq(&usbhid->lock);
> +               if (test_bit(HID_LED_ON, &usbhid->iofl)) {
> +                       spin_unlock_irq(&usbhid->lock);
> +                       usbhid_mark_busy(usbhid);
> +                       return -EBUSY;
> +               }
> +               spin_unlock_irq(&usbhid->lock);
> +       }
> +
> +       hid_cease_io(usbhid);
> +
> +       if (udev->auto_pm && test_bit(HID_KEYS_PRESSED, &usbhid->iofl)) {
> +               /* lost race against keypresses */
> +               status = hid_start_in(hid);
> +               if (status < 0)
> +                       hid_io_error(hid);
> +               usbhid_mark_busy(usbhid);
> +               return -EBUSY;
> +       }
>         dev_dbg(&intf->dev, "suspend\n");
>         return 0;
>  }
> @@ -1040,18 +1217,30 @@ static int hid_resume(struct usb_interface *intf)
>         struct usbhid_device *usbhid = hid->driver_data;
>         int status;
> 
> -       clear_bit(HID_SUSPENDED, &usbhid->iofl);
> +       clear_bit(HID_REPORTED_IDLE, &usbhid->iofl);
> +       usbhid_mark_busy(usbhid);
> +
>         usbhid->retry_delay = 0;
>         status = hid_start_in(hid);
> +       if (status < 0)
> +               hid_io_error(hid);
> +       usbhid_restart_queues(usbhid);
> +
>         dev_dbg(&intf->dev, "resume status %d\n", status);
> -       return status;
> +       return 0;
>  }
> 
>  /* Treat USB reset pretty much the same as suspend/resume */
>  static int hid_pre_reset(struct usb_interface *intf)
>  {
> -       /* FIXME: What if the interface is already suspended? */
> -       hid_suspend(intf, PMSG_ON);
> +       struct hid_device *hid = usb_get_intfdata(intf);
> +       struct usbhid_device *usbhid = hid->driver_data;
> +
> +       spin_lock_irq(&usbhid->lock);
> +       set_bit(HID_RESET_PENDING, &usbhid->iofl);
> +       spin_unlock_irq(&usbhid->lock);
> +       hid_cease_io(usbhid);
> +
>         return 0;
>  }
> 
> @@ -1059,11 +1248,35 @@ static int hid_pre_reset(struct usb_interface *intf)
>  static int hid_post_reset(struct usb_interface *intf)
>  {
>         struct usb_device *dev = interface_to_usbdev (intf);
> -
> +       struct hid_device *hid = usb_get_intfdata(intf);
> +       struct usbhid_device *usbhid = hid->driver_data;
> +       int status;
> +
> +       spin_lock_irq(&usbhid->lock);
> +       clear_bit(HID_RESET_PENDING, &usbhid->iofl);
> +       spin_unlock_irq(&usbhid->lock);
>         hid_set_idle(dev, intf->cur_altsetting->desc.bInterfaceNumber, 0, 0);
>         /* FIXME: Any more reinitialization needed? */
> +       status = hid_start_in(hid);
> +       if (status < 0)
> +               hid_io_error(hid);
> +       usbhid_restart_queues(usbhid);
> 
> -       return hid_resume(intf);
> +       return 0;
> +}
> +
> +int usbhid_get_power(struct hid_device *hid)
> +{
> +       struct usbhid_device *usbhid = hid->driver_data;
> +
> +       return usb_autopm_get_interface(usbhid->intf);
> +}
> +
> +void usbhid_put_power(struct hid_device *hid)
> +{
> +       struct usbhid_device *usbhid = hid->driver_data;
> +
> +       usb_autopm_put_interface(usbhid->intf);
>  }
> 
>  static struct usb_device_id hid_usb_ids [] = {
> @@ -1099,7 +1312,11 @@ static struct hid_driver hid_usb_driver = {
> 
>  static int __init hid_init(void)
>  {
> -       int retval;
> +       int retval = -ENOMEM;
> +
> +       resumption_waker = create_freezeable_workqueue("usbhid_resumer");
> +       if (!resumption_waker)
> +               goto no_queue;
>         retval = hid_register_driver(&hid_usb_driver);
>         if (retval)
>                 goto hid_register_fail;
> @@ -1123,6 +1340,8 @@ hiddev_init_fail:
>  usbhid_quirks_init_fail:
>         hid_unregister_driver(&hid_usb_driver);
>  hid_register_fail:
> +       destroy_workqueue(resumption_waker);
> +no_queue:
>         return retval;
>  }
> 
> @@ -1132,6 +1351,7 @@ static void __exit hid_exit(void)
>         hiddev_exit();
>         usbhid_quirks_exit();
>         hid_unregister_driver(&hid_usb_driver);
> +       destroy_workqueue(resumption_waker);
>  }
> 
>  module_init(hid_init);
> --- a/drivers/hid/usbhid/hiddev.c
> +++ b/drivers/hid/usbhid/hiddev.c
> @@ -249,10 +249,12 @@ static int hiddev_release(struct inode * inode, struct file * file)
>         spin_unlock_irqrestore(&list->hiddev->list_lock, flags);
> 
>         if (!--list->hiddev->open) {
> -               if (list->hiddev->exist)
> +               if (list->hiddev->exist) {
>                         usbhid_close(list->hiddev->hid);
> -               else
> +                       usbhid_put_power(list->hiddev->hid);
> +               } else {
>                         kfree(list->hiddev);
> +               }
>         }
> 
>         kfree(list);
> @@ -267,6 +269,7 @@ static int hiddev_open(struct inode *inode, struct file *file)
>  {
>         struct hiddev_list *list;
>         unsigned long flags;
> +       int res;
> 
>         int i = iminor(inode) - HIDDEV_MINOR_BASE;
> 
> @@ -285,8 +288,13 @@ static int hiddev_open(struct inode *inode, struct file *file)
>         file->private_data = list;
> 
>         if (!list->hiddev->open++)
> -               if (list->hiddev->exist)
> -                       usbhid_open(hiddev_table[i]->hid);
> +               if (list->hiddev->exist) {
> +                       struct hid_device *hid = hiddev_table[i]->hid;
> +                       res = usbhid_get_power(hid);
> +                       if (res < 0)
> +                               return -EIO;
> +                       usbhid_open(hid);
> +               }
> 
>         return 0;
>  }
> --- a/drivers/hid/usbhid/usbhid.h
> +++ b/drivers/hid/usbhid/usbhid.h
> @@ -37,7 +37,10 @@ int usbhid_wait_io(struct hid_device* hid);
>  void usbhid_close(struct hid_device *hid);
>  int usbhid_open(struct hid_device *hid);
>  void usbhid_init_reports(struct hid_device *hid);
> -void usbhid_submit_report(struct hid_device *hid, struct hid_report *report, unsigned char dir);
> +void usbhid_submit_report
> +(struct hid_device *hid, struct hid_report *report, unsigned char dir);
> +int usbhid_get_power(struct hid_device *hid);
> +void usbhid_put_power(struct hid_device *hid);
> 
>  /*
>   * USB-specific HID struct, to be pointed to
> @@ -55,7 +58,6 @@ struct usbhid_device {
>         struct urb *urbin;                                              /* Input URB */
>         char *inbuf;                                                    /* Input buffer */
>         dma_addr_t inbuf_dma;                                           /* Input buffer dma */
> -       spinlock_t inlock;                                              /* Input fifo spinlock */
> 
>         struct urb *urbctrl;                                            /* Control URB */
>         struct usb_ctrlrequest *cr;                                     /* Control request struct */
> @@ -64,21 +66,22 @@ struct usbhid_device {
>         unsigned char ctrlhead, ctrltail;                               /* Control fifo head & tail */
>         char *ctrlbuf;                                                  /* Control buffer */
>         dma_addr_t ctrlbuf_dma;                                         /* Control buffer dma */
> -       spinlock_t ctrllock;                                            /* Control fifo spinlock */
> 
>         struct urb *urbout;                                             /* Output URB */
>         struct hid_output_fifo out[HID_CONTROL_FIFO_SIZE];              /* Output pipe fifo */
>         unsigned char outhead, outtail;                                 /* Output pipe fifo head & tail */
>         char *outbuf;                                                   /* Output buffer */
>         dma_addr_t outbuf_dma;                                          /* Output buffer dma */
> -       spinlock_t outlock;                                             /* Output fifo spinlock */
> 
> +       spinlock_t lock;                                                /* fifo spinlock */
>         unsigned long iofl;                                             /* I/O flags (CTRL_RUNNING, OUT_RUNNING) */
>         struct timer_list io_retry;                                     /* Retry timer */
>         unsigned long stop_retry;                                       /* Time to give up, in jiffies */
>         unsigned int retry_delay;                                       /* Delay length in ms */
>         struct work_struct reset_work;                                  /* Task context for resets */
> +       struct work_struct restart_work;                                /* waking up for output to be done in a task */
>         wait_queue_head_t wait;                                         /* For sleeping */
> +       int ledcount;                                                   /* counting the number of active leds */
>  };
> 
>  #define        hid_to_usb_dev(hid_dev) \
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -410,6 +410,9 @@ struct hid_output_fifo {
>  #define HID_SUSPENDED          5
>  #define HID_CLEAR_HALT         6
>  #define HID_DISCONNECTED       7
> +#define HID_REPORTED_IDLE      8
> +#define HID_KEYS_PRESSED       9
> +#define HID_LED_ON             10
> 
>  struct hid_input {
>         struct list_head list;
> @@ -638,6 +641,7 @@ int hidinput_find_field(struct hid_device *hid, unsigned int type, unsigned int
>  void hid_output_report(struct hid_report *report, __u8 *data);
>  struct hid_device *hid_allocate_device(void);
>  int hid_parse_report(struct hid_device *hid, __u8 *start, unsigned size);
> +int hid_check_keys_pressed(struct hid_device *hid);
>  int hid_connect(struct hid_device *hid, unsigned int connect_mask);
> 
>  /**
> 
> 

