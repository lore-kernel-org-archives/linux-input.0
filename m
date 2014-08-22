From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/1] HID: usbhid: add usb_clear_halt determination for
 next hid_start_in
Date: Fri, 22 Aug 2014 09:56:18 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1408220950340.1291-100000@iolanthe.rowland.org>
References: <CAOVJa8F5HoS48wYn5-yHCeioYNOOGEKwXg6WujCQH0QxA44o=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:35548 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932110AbaHVN4U (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 22 Aug 2014 09:56:20 -0400
In-Reply-To: <CAOVJa8F5HoS48wYn5-yHCeioYNOOGEKwXg6WujCQH0QxA44o=Q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: vichy <vichy.kuo@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, linux-input@vger.kernel.org

On Fri, 22 Aug 2014, vichy wrote:

> hi Jiri:
> 
> 2014-08-22 15:45 GMT+08:00 Jiri Kosina <jkosina@suse.cz>:
> > On Fri, 22 Aug 2014, CheChun Kuo wrote:
> >
> >>       HID IR device will not response to any command send from host when
> >> it is finishing paring and tring to reset itself. During this period of
> >> time, usb_cleaer_halt will be fail and if hid_start_in soon again, we
> >> has the possibility trap in infinite loop.
> >>
> >> Signed-off-by: CheChun Kuo <vichy.kuo@gmail.com>
> >> ---
> >>  drivers/hid/usbhid/hid-core.c |    3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
> >> index 79cf503..256b102 100644
> >> --- a/drivers/hid/usbhid/hid-core.c
> >> +++ b/drivers/hid/usbhid/hid-core.c
> >> @@ -122,7 +122,8 @@ static void hid_reset(struct work_struct *work)
> >>               dev_dbg(&usbhid->intf->dev, "clear halt\n");
> >>               rc = usb_clear_halt(hid_to_usb_dev(hid), usbhid->urbin->pipe);
> >>               clear_bit(HID_CLEAR_HALT, &usbhid->iofl);
> >> -             hid_start_in(hid);
> >> +             if (rc == 0)
> >> +                     hid_start_in(hid);
> >>       }
> >
> > I'd need a more detailed explanation for this patch, as I don't understand
> > neither the text in the changelog nor the patch itself. Namely:
> >
> > - which IR devices are showing this behavior?
> The USB hid device that will transform IR signal to usb command when
> user press "volume up/down", "voice recording", etc.
> 
> > - where does the infinite loop come from? hid_reset() should error out
> >   properly if usb_clear_halt() fails and HID_IN_RUNNING flag is not set
> Below I briefly draw the timing when this issue happen
> 
> i) hid_irq_in get URB status as -EPIPE
> ii) set HID_CLEAR_HALT flag and schedule hid_reset work
> iii) hid_reset call usb_clear_halt and hid_start_in again
> iv) if device still doesn't response host command, it will go to i)
> above and keep looping
> 
> thanks for your help,

I recently posted (but did not submit) a more comprehensive solution to
this and other related problems.  For example, HID devices typically
run at low speed or full speed.  When attached through a hub to an EHCI
controller (very common on modern systems), unplugging the device
causes -EPIPE errors, so the driver calls usb_clear_halt and restarts
the interrupt pipe.  Of course, the same failure occurs again, so 
there's a lengthy flurry of useless error messages.

This patch changes the driver so that after usb_clear_halt fails, it
will try to do a port reset.  And if that fails, the driver will be
unbound from the device.  This avoids infinite loops.

What do you think?

Alan Stern



Index: usb-3.16/drivers/hid/usbhid/hid-core.c
===================================================================
--- usb-3.16.orig/drivers/hid/usbhid/hid-core.c
+++ usb-3.16/drivers/hid/usbhid/hid-core.c
@@ -116,40 +116,24 @@ static void hid_reset(struct work_struct
 	struct usbhid_device *usbhid =
 		container_of(work, struct usbhid_device, reset_work);
 	struct hid_device *hid = usbhid->hid;
-	int rc = 0;
+	int rc;
 
 	if (test_bit(HID_CLEAR_HALT, &usbhid->iofl)) {
 		dev_dbg(&usbhid->intf->dev, "clear halt\n");
 		rc = usb_clear_halt(hid_to_usb_dev(hid), usbhid->urbin->pipe);
 		clear_bit(HID_CLEAR_HALT, &usbhid->iofl);
-		hid_start_in(hid);
-	}
-
-	else if (test_bit(HID_RESET_PENDING, &usbhid->iofl)) {
-		dev_dbg(&usbhid->intf->dev, "resetting device\n");
-		rc = usb_lock_device_for_reset(hid_to_usb_dev(hid), usbhid->intf);
 		if (rc == 0) {
-			rc = usb_reset_device(hid_to_usb_dev(hid));
-			usb_unlock_device(hid_to_usb_dev(hid));
+			hid_start_in(hid);
+		} else {
+			dev_dbg(&usbhid->intf->dev,
+					"clear-halt failed: %d\n", rc);
+			set_bit(HID_RESET_PENDING, &usbhid->iofl);
 		}
-		clear_bit(HID_RESET_PENDING, &usbhid->iofl);
 	}
 
-	switch (rc) {
-	case 0:
-		if (!test_bit(HID_IN_RUNNING, &usbhid->iofl))
-			hid_io_error(hid);
-		break;
-	default:
-		hid_err(hid, "can't reset device, %s-%s/input%d, status %d\n",
-			hid_to_usb_dev(hid)->bus->bus_name,
-			hid_to_usb_dev(hid)->devpath,
-			usbhid->ifnum, rc);
-		/* FALLTHROUGH */
-	case -EHOSTUNREACH:
-	case -ENODEV:
-	case -EINTR:
-		break;
+	if (test_bit(HID_RESET_PENDING, &usbhid->iofl)) {
+		dev_dbg(&usbhid->intf->dev, "resetting device\n");
+		usb_queue_reset_device(usbhid->intf);
 	}
 }
 

