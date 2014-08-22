From: vichy <vichy.kuo@gmail.com>
Subject: Re: [PATCH 1/1] HID: usbhid: add usb_clear_halt determination for
 next hid_start_in
Date: Sat, 23 Aug 2014 01:38:30 +0800
Message-ID: <CAOVJa8HLSQ9cqEHR8srT3QikvJ6i0ZYFqmOZ7MvMpN5aULdk9A@mail.gmail.com>
References: <CAOVJa8F5HoS48wYn5-yHCeioYNOOGEKwXg6WujCQH0QxA44o=Q@mail.gmail.com>
	<Pine.LNX.4.44L0.1408220950340.1291-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:37888 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932503AbaHVRib (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 22 Aug 2014 13:38:31 -0400
In-Reply-To: <Pine.LNX.4.44L0.1408220950340.1291-100000@iolanthe.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Jiri Kosina <jkosina@suse.cz>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, linux-input@vger.kernel.org

hi alan and all:

> I recently posted (but did not submit) a more comprehensive solution to
> this and other related problems.  For example, HID devices typically
> run at low speed or full speed.  When attached through a hub to an EHCI
> controller (very common on modern systems), unplugging the device
> causes -EPIPE errors, so the driver calls usb_clear_halt and restarts
> the interrupt pipe.  Of course, the same failure occurs again, so
> there's a lengthy flurry of useless error messages.
>
> This patch changes the driver so that after usb_clear_halt fails, it
> will try to do a port reset.  And if that fails, the driver will be
> unbound from the device.  This avoids infinite loops.
>
> What do you think?
>
> Alan Stern
>
>
>
> Index: usb-3.16/drivers/hid/usbhid/hid-core.c
> ===================================================================
> --- usb-3.16.orig/drivers/hid/usbhid/hid-core.c
> +++ usb-3.16/drivers/hid/usbhid/hid-core.c
> @@ -116,40 +116,24 @@ static void hid_reset(struct work_struct
>         struct usbhid_device *usbhid =
>                 container_of(work, struct usbhid_device, reset_work);
>         struct hid_device *hid = usbhid->hid;
> -       int rc = 0;
> +       int rc;
>
>         if (test_bit(HID_CLEAR_HALT, &usbhid->iofl)) {
>                 dev_dbg(&usbhid->intf->dev, "clear halt\n");
>                 rc = usb_clear_halt(hid_to_usb_dev(hid), usbhid->urbin->pipe);
>                 clear_bit(HID_CLEAR_HALT, &usbhid->iofl);
> -               hid_start_in(hid);
> -       }
> -
> -       else if (test_bit(HID_RESET_PENDING, &usbhid->iofl)) {
> -               dev_dbg(&usbhid->intf->dev, "resetting device\n");
> -               rc = usb_lock_device_for_reset(hid_to_usb_dev(hid), usbhid->intf);
>                 if (rc == 0) {
> -                       rc = usb_reset_device(hid_to_usb_dev(hid));
> -                       usb_unlock_device(hid_to_usb_dev(hid));
> +                       hid_start_in(hid);
> +               } else {
> +                       dev_dbg(&usbhid->intf->dev,
> +                                       "clear-halt failed: %d\n", rc);
> +                       set_bit(HID_RESET_PENDING, &usbhid->iofl);
>                 }
> -               clear_bit(HID_RESET_PENDING, &usbhid->iofl);
>         }
>
> -       switch (rc) {
> -       case 0:
> -               if (!test_bit(HID_IN_RUNNING, &usbhid->iofl))
> -                       hid_io_error(hid);
> -               break;
> -       default:
> -               hid_err(hid, "can't reset device, %s-%s/input%d, status %d\n",
> -                       hid_to_usb_dev(hid)->bus->bus_name,
> -                       hid_to_usb_dev(hid)->devpath,
> -                       usbhid->ifnum, rc);
> -               /* FALLTHROUGH */
> -       case -EHOSTUNREACH:
> -       case -ENODEV:
> -       case -EINTR:
> -               break;
> +       if (test_bit(HID_RESET_PENDING, &usbhid->iofl)) {
> +               dev_dbg(&usbhid->intf->dev, "resetting device\n");
> +               usb_queue_reset_device(usbhid->intf);
>         }
>  }
from your patch, I have some questions:
a. in Alan's version, if both HID_CLEAR_HALT and HID_RESET_PENDING are
set, hid_reset will both "clear ep halt" and "reset devcie".
But in original one, even HID_CLEAR_HALT and HID_RESET_PENDING are
both set, hid_reset only do one of them.
is there any special reason in original hid_reset to use below flow?
    if (test_bit(HID_CLEAR_HALT, &usbhid->iofl)) {
            xxxxx
    } else if (test_bit(HID_RESET_PENDING, &usbhid->iofl)) {
            xxxxxx
    }

b. in original hid_reset, if "Clear halt ep" or "Rest device" success
or none of those flags raise up, it will call hid_io_error for later
resending the urb. Shall we need to call "hid_io_error(hid);" in the
end if "clear halt" or "reset device" success?

c. why we chose to use usb_queue_reset_device instead of usb_reset_device()?

d. shall we "useusb_lock_device_for_reset(hid_to_usb_dev(hid),
usbhid->intf)" or "spin_lock_irq(&usbhid->lock)" before calling
usb_queue_reset_device?

I append patch for explaining my questions.
Appreciate your kind help,

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 256b102..aa321f9 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -116,18 +116,22 @@ static void hid_reset(struct work_struct *work)
        struct usbhid_device *usbhid =
                container_of(work, struct usbhid_device, reset_work);
        struct hid_device *hid = usbhid->hid;
-       int rc = 0;
+       int rc;

        if (test_bit(HID_CLEAR_HALT, &usbhid->iofl)) {
                dev_dbg(&usbhid->intf->dev, "clear halt\n");
                rc = usb_clear_halt(hid_to_usb_dev(hid), usbhid->urbin->pipe);
                clear_bit(HID_CLEAR_HALT, &usbhid->iofl);
-               if (rc == 0)
+               if (rc == 0) {
                        hid_start_in(hid);
+               } else {
+                       dev_dbg(&usbhid->intf->dev,
+                                       "clear-halt failed: %d\n", rc);
+                       set_bit(HID_RESET_PENDING, &usbhid->iofl);
+               }
        }

-       else if (test_bit(HID_RESET_PENDING, &usbhid->iofl)) {
-               dev_dbg(&usbhid->intf->dev, "resetting device\n");
+       if (test_bit(HID_RESET_PENDING, &usbhid->iofl)) {
                rc = usb_lock_device_for_reset(hid_to_usb_dev(hid),
usbhid->intf);
                if (rc == 0) {
                        rc = usb_reset_device(hid_to_usb_dev(hid));
@@ -136,22 +140,8 @@ static void hid_reset(struct work_struct *work)
                clear_bit(HID_RESET_PENDING, &usbhid->iofl);
        }

-       switch (rc) {
-       case 0:
-               if (!test_bit(HID_IN_RUNNING, &usbhid->iofl))
-                       hid_io_error(hid);
-               break;
-       default:
-               hid_err(hid, "can't reset device, %s-%s/input%d, status %d\n",
-                       hid_to_usb_dev(hid)->bus->bus_name,
-                       hid_to_usb_dev(hid)->devpath,
-                       usbhid->ifnum, rc);
-               /* FALLTHROUGH */
-       case -EHOSTUNREACH:
-       case -ENODEV:
-       case -EINTR:
-               break;
-       }
+       if (!test_bit(HID_IN_RUNNING, &usbhid->iofl) || (rc == 0))
+               hid_io_error(hid);
 }

 /* Main I/O error handler */
