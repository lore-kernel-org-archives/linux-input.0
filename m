From: Johan Hovold <johan@kernel.org>
Subject: Re: USB reset xhci_hcd for ELAN touchscreen
Date: Mon, 14 Jul 2014 20:25:26 +0200
Message-ID: <20140714182526.GA12963@localhost>
References: <874n047rre.fsf@nemi.mork.no>
 <Pine.LNX.4.44L0.1406011203140.16904-100000@netrider.rowland.org>
 <20140601174321.GA29188@kroah.com>
 <20140707092442.GF29098@localhost>
 <20140708053430.GA840@kroah.com>
 <20140709130733.GA10078@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:36018 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602AbaGNS0P (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Jul 2014 14:26:15 -0400
Content-Disposition: inline
In-Reply-To: <20140709130733.GA10078@localhost>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Johan Hovold <johan@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>, Sarah Sharp <sarah.a.sharp@linux.intel.com>, Drew Von Spreecken <drewvs@gmail.com>, linux-usb@vger.kernel.org, Mathias Nyman <mathias.nyman@intel.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

[ +CC: Jiri and linux-input ]

On Wed, Jul 09, 2014 at 03:07:33PM +0200, Johan Hovold wrote:
> On Mon, Jul 07, 2014 at 10:34:30PM -0700, Greg Kroah-Hartman wrote:
> > On Mon, Jul 07, 2014 at 11:24:42AM +0200, Johan Hovold wrote:
> 
> > > I ended up getting the same laptop so now I'm facing the same problem
> > > with repeated disconnects (especially during resume, which is really
> > > annoying as it adds about a minute to resume time), even with a
> > > hard-coded check-high speed "quirk" and the multitouch driver loaded.
> > > 
> > > Did you manage to fix the disconnect issue? Are you seeing something
> > > similar at resume?
> > 
> > No, it all seems to work for me.  Here's my horrible "hack" I'm running
> > with on 3.16-rc.
> > 
> > I have seen some issues at times when the touchscreen stops working on
> > resume, but it just seems "dead".  An unload/load of the xhci-hcd module
> > always fixes that :)
> 
> Ok. I'm effectively using the same hack as you, but I'm seeing these
> repeated disconnects during resume for about a minute still. Everything
> compiled in, so no modules (or fancy hibernate scripts) though. 
> 
> > I'll work on making this a "real" patch this week, when I dig out from
> > my pending patch queue...
> 
> Ok, I'll wait for that, and will try to find time to debug this later.

The timeout I experienced during resume was due to the wifi firmware not
being compiled in, but during that minute the touchscreen device kept
disconnecting every other second.

I get one such disconnect before X is started during normal boot as
well. It appears that something has to open the input device at least
once or the device will keep disconnecting itself (e.g. not booting into
X also triggers the repeated disconnects).

A simple

	cat /dev/input/by-path/pci-0000:00:14.0-usb-0:7:1.0-event

is enough to stop the device from disconnecting. But unless the device
is kept open (and the interrupt-in urb submitted) any input event (i.e.
touching the screen) causes the device to start disconnecting
repeatedly again.

Adding something like the below (on top of the check-highspeed quirk)
fixes the repeated disconnect when the device is not open. (It cannot
prevent the disconnects during a lengthy resume though as reset_resume
will not have run yet.)

Is there any better way to fix this?

Thanks,
Johan


>From 8101c0dfd42a232f1d2872de4f412d8d61d5646f Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Mon, 14 Jul 2014 18:43:31 +0200
Subject: [PATCH] HID: usbhid: add HID_QUIRK_IN

Add quirk to submit the interrupt-in urb already at start() rather than
at open().

This is needed for devices that disconnects from the bus unless the
interrupt endpoint has been polled at least once or when not responding
to input events.
---
 drivers/hid/usbhid/hid-core.c | 26 +++++++++++++++++++++++---
 include/linux/hid.h           |  1 +
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 7b88f4c..4b5d986 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -82,7 +82,7 @@ static int hid_start_in(struct hid_device *hid)
 	struct usbhid_device *usbhid = hid->driver_data;
 
 	spin_lock_irqsave(&usbhid->lock, flags);
-	if (hid->open > 0 &&
+	if ((hid->open > 0 || hid->quirks & HID_QUIRK_IN) &&
 			!test_bit(HID_DISCONNECTED, &usbhid->iofl) &&
 			!test_bit(HID_SUSPENDED, &usbhid->iofl) &&
 			!test_and_set_bit(HID_IN_RUNNING, &usbhid->iofl)) {
@@ -292,6 +292,8 @@ static void hid_irq_in(struct urb *urb)
 	case 0:			/* success */
 		usbhid_mark_busy(usbhid);
 		usbhid->retry_delay = 0;
+		if ((hid->quirks & HID_QUIRK_IN) && !hid->open)
+			break;
 		hid_input_report(urb->context, HID_INPUT_REPORT,
 				 urb->transfer_buffer,
 				 urb->actual_length, 1);
@@ -734,8 +736,10 @@ void usbhid_close(struct hid_device *hid)
 	if (!--hid->open) {
 		spin_unlock_irq(&usbhid->lock);
 		hid_cancel_delayed_stuff(usbhid);
-		usb_kill_urb(usbhid->urbin);
-		usbhid->intf->needs_remote_wakeup = 0;
+		if (!(hid->quirks & HID_QUIRK_IN)) {
+			usb_kill_urb(usbhid->urbin);
+			usbhid->intf->needs_remote_wakeup = 0;
+		}
 	} else {
 		spin_unlock_irq(&usbhid->lock);
 	}
@@ -1133,6 +1137,20 @@ static int usbhid_start(struct hid_device *hid)
 
 	set_bit(HID_STARTED, &usbhid->iofl);
 
+	hid->quirks |= HID_QUIRK_IN;	/* FIXME */
+	if (hid->quirks & HID_QUIRK_IN) {
+		ret = usb_autopm_get_interface(usbhid->intf);
+		if (ret)
+			goto fail;
+		usbhid->intf->needs_remote_wakeup = 1;
+		ret = hid_start_in(hid);
+		if (ret) {
+			dev_err(&hid->dev,
+				"failed to start in urb: %d\n", ret);
+		}
+		usb_autopm_put_interface(usbhid->intf);
+	}
+
 	/* Some keyboards don't work until their LEDs have been set.
 	 * Since BIOSes do set the LEDs, it must be safe for any device
 	 * that supports the keyboard boot protocol.
@@ -1165,6 +1183,8 @@ static void usbhid_stop(struct hid_device *hid)
 	if (WARN_ON(!usbhid))
 		return;
 
+	usbhid->intf->needs_remote_wakeup = 0;
+
 	clear_bit(HID_STARTED, &usbhid->iofl);
 	spin_lock_irq(&usbhid->lock);	/* Sync with error and led handlers */
 	set_bit(HID_DISCONNECTED, &usbhid->iofl);
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 77632cf..13f81ae 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -286,6 +286,7 @@ struct hid_item {
 #define HID_QUIRK_HIDINPUT_FORCE		0x00000080
 #define HID_QUIRK_NO_EMPTY_INPUT		0x00000100
 #define HID_QUIRK_NO_INIT_INPUT_REPORTS		0x00000200
+#define HID_QUIRK_IN				0x00000400
 #define HID_QUIRK_SKIP_OUTPUT_REPORTS		0x00010000
 #define HID_QUIRK_SKIP_OUTPUT_REPORT_ID		0x00020000
 #define HID_QUIRK_NO_OUTPUT_REPORTS_ON_INTR_EP	0x00040000
-- 
1.8.5.5

