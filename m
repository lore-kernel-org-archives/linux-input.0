From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v3] HID: wacom: Improve generic name generation
Date: Thu, 29 Jun 2017 18:07:39 +0200
Message-ID: <20170629160739.GH26073@mail.corp.redhat.com>
References: <20170628211921.5638-1-killertofu@gmail.com>
 <20170629141021.GG26073@mail.corp.redhat.com>
 <CANRwn3SndCWUdRyP54r7turG7u7-FiiTeR=czyCsE4h+fZh_8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58730 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751669AbdF2QHq (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 29 Jun 2017 12:07:46 -0400
Content-Disposition: inline
In-Reply-To: <CANRwn3SndCWUdRyP54r7turG7u7-FiiTeR=czyCsE4h+fZh_8g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

On Jun 29 2017 or thereabouts, Jason Gerecke wrote:
> On June 29, 2017 7:10:21 AM PDT, Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> >Hi Jason,
> >
> >On Jun 28 2017 or thereabouts, Jason Gerecke wrote:
> >> The 'wacom_update_name' function is responsible for producing names
> >for
> >> the input device nodes based on the hardware device name. Commit
> >f2209d4
> >> added the ability to strip off prefixes like "Wacom Co.,Ltd." where
> >the
> >> prefix was immediately (and redundantly) followed by "Wacom". The
> >> 2nd-generation Intuos Pro 2 has such a prefix, but with a small error
> >> (the period and comma are swapped) that prevents the existing code
> >from
> >> matching it. We're loath to extend the number of cases out endlessly
> >and
> >> so instead try to be smarter about name generation.
> >>
> >> We observe that the cause of the redundant prefixes is HID combining
> >the
> >> manufacturer and product strings of USB devices together. By using
> >the
> >> original product name (with "Wacom" prefixed, if it does not already
> >> exist in the string) we can bypass the gyrations to find and remove
> >> redundant prefixes. Other devices either don't have a manufacturer
> >string
> >> that needs to be removed (Bluetooth, uhid) or should have their name
> >> generated from scratch (I2C).
> >>
> >
> >Sorry for nitpicking, but I have a couple of comments:
> >
> 
> Might as well get the patch right :)
> 
> >> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
> >> ---
> >> Changes from v2:
> >>  * Use export/extern to directly gain access to the usb_hid_driver
> >struct
> >>    for comparison to ll_driver (rather than scanning through the list
> >of
> >>    USB devices for a matching parent).
> >>
> >>  drivers/hid/usbhid/hid-core.c |  1 +
> >>  drivers/hid/wacom_sys.c       | 60
> >+++++++++++++++++++++----------------------
> >>  2 files changed, 30 insertions(+), 31 deletions(-)
> >>
> >> diff --git a/drivers/hid/usbhid/hid-core.c
> >b/drivers/hid/usbhid/hid-core.c
> >> index 83772fa7d92a..4a7a306995a9 100644
> >> --- a/drivers/hid/usbhid/hid-core.c
> >> +++ b/drivers/hid/usbhid/hid-core.c
> >> @@ -1269,6 +1269,7 @@ static struct hid_ll_driver usb_hid_driver = {
> >>   .output_report = usbhid_output_report,
> >>   .idle = usbhid_idle,
> >>  };
> >> +EXPORT_SYMBOL_GPL(usb_hid_driver);
> >
> >I would rather see this in a separate commit (in case we need to revert
> >this one, we shouldn't revert the export).
> >
> 
> Ack. Left it here momentarily to keep mail noise down while the review
> process chugs along :)
> 
> >>
> >>  static int usbhid_probe(struct usb_interface *intf, const struct
> >usb_device_id *id)
> >>  {
> >> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> >> index 0022c0dac88a..94d493c724c8 100644
> >> --- a/drivers/hid/wacom_sys.c
> >> +++ b/drivers/hid/wacom_sys.c
> >> @@ -22,6 +22,8 @@
> >>  #define DEV_ATTR_WO_PERM (S_IWUSR | S_IWGRP)
> >>  #define DEV_ATTR_RO_PERM (S_IRUSR | S_IRGRP)
> >>
> >> +extern struct hid_ll_driver usb_hid_driver;
> >
> >Ouch. I'd rather see that one in drivers/hid/usbhid/usbhid.h
> >
> >I would like also to have the following in usbhid.h, that you can reuse
> >later in the patch:
> >static inline bool hid_is_using_usbhid(struct hid_device *hdev)
> >{
> > return hdev->ll_driver == &usb_hid_driver;
> >}
> >
> 
> As I mentioned earlier, our input-wacom driver can't access usbhid.h.

Oops, sorry, I forgot this detail.

> I don't imagine a patch to make usbhid.h public would be accepted, and

Nah... :)

> I am strongly against requiring our users to have a copy of their
> distro's full kernel source tree (not just development headers) merely
> to compile our driver. Certainly we could create our own definition of
> `hid_is_using_usbhid` within input-wacom which only uses
> otherwise-public functions, but it'd be a hack that we'd have to
> maintain indefinitely. I'm looking to create a patch which can work
> both upstream and downstream (hence my earlier awkward
> `wacom_is_real_usb` function that used only public functions).

But why don't you just add a usbhid/usbhid.h file downstream containing
just the export and this inlined function?

You can just sync this extra header when changes are coming.

> 
> Would it be reasonable to define `hid_is_using_usbhid` within hid.h
> instead? I'm guessing the answer is "no" since the function is
> transport-specific, but knowing what specific ll_driver is in use /is/
> something useful to any HID driver...

That's a tough question. Depending on how I look, both arguments are
valid. Still, I have a slight preference for having a
hid_is_using_usbhid() function in usbhid.h instead of plain hid.h.

OTOH, I would think having a more generic approach would be fine:
bool inline bool hid_is_using_driver(struct hid_device *hdev,
		struct hid_ll_driver *driver)
{
	return dev->ll_driver == driver;
}

And we can start adding the various extern definitions of the
ll_drivers in hid.h too...

How does that sound? Jiri?

Cheers,
Benjamin
