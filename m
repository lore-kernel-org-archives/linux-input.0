From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: full usbhid autosuspend
Date: Fri, 4 Apr 2008 16:24:30 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0804041437430.32130@jikos.suse.cz>
References: <200804011603.05998.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200804011603.05998.oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, 1 Apr 2008, Oliver Neukum wrote:

> this is a full implementation of autosuspend for USB HID devices. 
> Contrary to the current implementation it tries to safe power even for 
> open devices, like keyboards and mice. Please test.

Hi Oliver,

there is some deadlock in IRQ path, could you please look at it? I have 
triggered it on my test system trivially by just attaching one PS2 and one 
USB keyboard to the system, fiddling a bit with leds on PS2 keyboard and 
then tried to perform remote-wakeup on the suspended USB keyboard. 
Unfortunately I won't probably have time to debug this today.

Other than that, some trivial comments below.

BUG: spinlock cpu recursion on CPU#0, ksoftirqd/0/4
 lock: ffff81001d8796a0, .magic: dead4ead, .owner: swapper/0, .owner_cpu: 
0
Pid: 4, comm: ksoftirqd/0 Not tainted 
2.6.25-rc7-default-00002-g9e50656-dirty #24

Call Trace:
 [<ffffffff802fd0ca>] spin_bug+0xa2/0xaa
 [<ffffffff802fd25d>] _raw_spin_lock+0x5d/0x125
 [<ffffffff80426bdb>] _spin_lock_irqsave+0x34/0x3c
 [<ffffffff8038e601>] input_event+0x3b/0x77
 [<ffffffff880fc838>] :hid:hidinput_hid_event+0x2da/0x30a
 [<ffffffff880f880e>] :hid:hid_process_event+0x44/0x78
 [<ffffffff880f8a99>] :hid:hid_input_field+0x257/0x268
 [<ffffffff880f8c94>] :hid:hid_input_report+0x1ea/0x223
 [<ffffffff8810e309>] :usbhid:hid_irq_in+0xb9/0x1e4
 [<ffffffff80370693>] usb_hcd_giveback_urb+0x84/0xb7
 [<ffffffff80386f0c>] uhci_giveback_urb+0x10a/0x19e
 [<ffffffff8038763f>] uhci_scan_schedule+0x58a/0x83f
 [<ffffffff80389586>] uhci_irq+0x128/0x144
 [<ffffffff803709be>] usb_hcd_irq+0x2b/0x5b
 [<ffffffff8025e2bf>] handle_IRQ_event+0x20/0x55
 [<ffffffff8025f673>] handle_fasteoi_irq+0x9d/0xdd
 [<ffffffff8020ecb2>] do_IRQ+0x6d/0xd7
 [<ffffffff8020c556>] ret_from_intr+0x0/0xf
 [<ffffffff80231e6f>] ? __do_softirq+0x65/0xf1
 [<ffffffff80231e67>] ? __do_softirq+0x5d/0xf1
 [<ffffffff80231aa9>] ? ksoftirqd+0x0/0xa5
 [<ffffffff8020d25c>] ? call_softirq+0x1c/0x28
 [<ffffffff8020ebca>] ? do_softirq+0x39/0x8a
 [<ffffffff80231aec>] ? ksoftirqd+0x43/0xa5
 [<ffffffff8023fe10>] ? kthread+0x49/0x79
 [<ffffffff8020cee8>] ? child_rip+0xa/0x12
 [<ffffffff8020c5ff>] ? restore_args+0x0/0x30
 [<ffffffff8023fc7b>] ? kthreadd+0x17b/0x1a0
 [<ffffffff8023fdc7>] ? kthread+0x0/0x79
 [<ffffffff8020cede>] ? child_rip+0x0/0x12

> --- linux-2.6.25-rc7-vanilla/drivers/hid/hid-core.c	2008-03-31 15:20:58.000000000 +0200
> +++ linux-2.6.25-rc7-work/drivers/hid/hid-core.c	2008-04-01 11:48:52.000000000 +0200
> @@ -1001,6 +1001,24 @@ int hid_input_report(struct hid_device *
>  }
>  EXPORT_SYMBOL_GPL(hid_input_report);
> +#define NBITS(x) ((((x)-1)/BITS_PER_LONG)+1)

Why is this needed (and it is definitely not nice to have it in the middle 
of the file). We already have the same macro in input.h, and we include it 
from this source anyway, don't we?

> --- linux-2.6.25-rc7-vanilla/drivers/hid/usbhid/hid-core.c	2008-04-01 15:52:10.000000000 +0200
> +++ linux-2.6.25-rc7-work/drivers/hid/usbhid/hid-core.c	2008-04-01 11:21:07.000000000 +0200
> @@ -5,6 +5,7 @@
>   *  Copyright (c) 2000-2005 Vojtech Pavlik <vojtech-AlSwsSmVLrQ@public.gmane.org>
>   *  Copyright (c) 2005 Michael Haboustak <mike--vDbLwGUA7lNWk0Htik3J/w@public.gmane.org> for Concept2, Inc
>   *  Copyright (c) 2006-2007 Jiri Kosina
> + *  Copyright (c) 2007 Oliver Neukum

It's 2008 these days already :)

> +			/* autosuspend refused while keys are pressed*/
> +			if (hid_check_keys_pressed(hid))
> +				set_bit(HID_KEYS_PRESSED, &usbhid->iofl);
> +			else
> +				clear_bit(HID_KEYS_PRESSED, &usbhid->iofl);

Maybe we will have to make this more general one day? I think it makes 
more sense to disable autosuspend whenever any event having EV_REP set is 
happening. But as this currently equals to keys, that should be probably 
OK for now.

> +	spin_lock_irqsave(&usbhid->outputlock, flags);
> +	/* suspension will switch off LEDs, so count them */
> +	if (value) {
> +		/* increase pm counter */
> +       } else {

Some code missing here?

> +	if (udev->auto_pm && test_bit(HID_KEYS_PRESSED, &usbhid->iofl)) {
> +		/* lost race against keypresses */
> +printk(KERN_ERR"lost race against keypresses.\n");

I guess this printk() should go away, right? I don't think anyone is 
interested to know whether this happened, right?

> @@ -70,14 +73,14 @@ struct usbhid_device {
>  	unsigned char outhead, outtail;                                 /* Output pipe fifo head & tail */
>  	char *outbuf;                                                   /* Output buffer */
>  	dma_addr_t outbuf_dma;                                          /* Output buffer dma */
> -	spinlock_t outlock;                                             /* Output fifo spinlock */
> +	spinlock_t outputlock;						/* Output fifo spinlock */

Shouldn't ctrllock be removed as well?

Also, I think that a little bit more verbose changelog would be helpful 
(i.e. short description what is changed and how), as the patch is not 
completely trivial.

Thanks,

-- 
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
