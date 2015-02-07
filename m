From: Antonio Ospite <ao2@ao2.it>
Subject: Re: [PATCH] HID: sony: Enable Gasia third-party PS3 controllers
Date: Sat, 7 Feb 2015 17:31:33 +0100
Message-ID: <20150207173133.0eda1917cbb26834f1885aa9@ao2.it>
References: <20150207154859.89a7e4e3.cand@gmx.com>
	<CAN+gG=EOf4di64EpXADRsQJ7_PTeH+9G=2TFN5-5mgMmcrk4qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp205.alice.it ([82.57.200.101]:3377 "EHLO smtp205.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754860AbbBGQbp (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 7 Feb 2015 11:31:45 -0500
In-Reply-To: <CAN+gG=EOf4di64EpXADRsQJ7_PTeH+9G=2TFN5-5mgMmcrk4qw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: Lauri Kasanen <cand@gmx.com>, Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, AndrewD207@aol.com

On Sat, 7 Feb 2015 10:56:49 -0500
Benjamin Tissoires <benjamin.tissoires@gmail.com> wrote:

> Hi Lauri,
> 
> On Sat, Feb 7, 2015 at 8:48 AM, Lauri Kasanen <cand@gmx.com> wrote:
> > Without this, my "Gasia Co.,Ltd PS(R) Gamepad" would not send
> > any events. Now everything works including the leds.
> >
> > Based on work by Andrew Haines and Antonio Ospite.
> >
> > cc: Antonio Ospite <ao2@ao2.it>
> > cc: Andrew Haines <AndrewD207@aol.com>
> > Signed-off-by: Lauri Kasanen <cand@gmx.com>
> > ---
> >  drivers/hid/hid-sony.c | 26 ++++++++++++++++++++++++--
> >  1 file changed, 24 insertions(+), 2 deletions(-)
> >
> > Antonio's original approach was not enough; it enabled the events,
> > but only for a few seconds, then the controller timed out and sent
> > no more. Andrew's did more than was necessary. This is a combination
> > of the two, against Linus' git.
> >
> > diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> > index 31e9d25..de93386 100644
> > --- a/drivers/hid/hid-sony.c
> > +++ b/drivers/hid/hid-sony.c
> > @@ -36,6 +36,7 @@
> >  #include <linux/list.h>
> >  #include <linux/idr.h>
> >  #include <linux/input/mt.h>
> > +#include <linux/usb/input.h>
> 
> Please don't.
> HID should be transport agnostic, so please refrain from directly call usb.
>

I agree with Benjamin here.

> >
> >  #include "hid-ids.h"
> >
> > @@ -1130,8 +1131,12 @@ static void sony_input_configured(struct hid_device *hdev,
> >   */
> >  static int sixaxis_set_operational_usb(struct hid_device *hdev)
> >  {
> > +       struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
> > +       struct usb_device *dev = interface_to_usbdev(intf);
> >         int ret;
> > -       char *buf = kmalloc(18, GFP_KERNEL);
> > +       char *buf = kmalloc(65, GFP_KERNEL);
> 
> 18 or 65 should be retrieved by the description of the device, not hardcoded.
>

However I don't mind about hardcoding these values here.
The device report descriptor does not describe all the feature reports,
it never has and it's not really worth doing that IMHO.

> > +       unsigned char buf2[] = { 0x00 };
> > +       int transfered;
> >
> >         if (!buf)
> >                 return -ENOMEM;
> > @@ -1140,7 +1145,24 @@ static int sixaxis_set_operational_usb(struct hid_device *hdev)
> >                                  HID_REQ_GET_REPORT);
> >
> >         if (ret < 0)
> > -               hid_err(hdev, "can't set operational mode\n");
> > +               hid_err(hdev, "can't set operational mode on the control EP\n");
> > +
> > +       /*
> > +        * Some compatible controllers like the Speedlink Strike FX and
> > +        * Gasia need another query plus an USB interrupt to get operational.
> > +        */
> > +       ret = hid_hw_raw_request(hdev, 0xf5, buf, 64, HID_FEATURE_REPORT,
> > +                                HID_REQ_GET_REPORT);
> 
> 0xf5 should not be hardcoded. You have to retrieve it from the
> description of the device or at least put a special case for your
> specific game controller.
>

I find this acceptable, more so considering that the current code does
exactly the same for feature report 0xf2.

The operations are just ping-of-life tricks, nothing we want to expose.
 
> > +
> > +       if (ret < 0)
> > +               hid_err(hdev, "can't set operational mode on the interrupt EP\n");

The error message is not accurate in this case.
You could use something like "can't set operational mode: step 2" to
differentiate between the errors and call "step 1" the previous one.

> > +
> > +       ret = usb_interrupt_msg(dev, usb_sndintpipe(dev, 0x02),
> > +                               buf2, sizeof(buf2),
> > +                               &transfered, USB_CTRL_SET_TIMEOUT);
> 
> Can't you simply use a hid_hw_output_report request instead of hard
> coding the device specific endpoint?
> And I'd also prefer it to be guarded against your specific controller.
> 

usb_interrupt_msg() is called in usbhid_output_report() indeed, so it
should be possible to use the generic HID interface.

> > +
> > +       if (ret < 0)
> > +               hid_err(hdev, "can't set operational mode on the interrupt EP\n");

And adjust this message accordingly. Call it "step 3" perhaps?

> >
> >         kfree(buf);
> >

Thanks,
   Antonio

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
