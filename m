From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] HID: microsoft: Add Surface Pro 4 type cover support
Date: Tue, 06 Dec 2016 15:01:37 +0800
Message-ID: <1481007697.2484.23.camel@intel.com>
References: <1480591033.2670.2.camel@intel.com>
         <20161201125315.GA1280@mail.corp.redhat.com>
         <1480924812.2645.33.camel@intel.com>
         <20161205081807.GI1280@mail.corp.redhat.com>
         <1480927281.2645.67.camel@intel.com>
         <20161205085916.GK1280@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:11900 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751690AbcLFHBD (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 6 Dec 2016 02:01:03 -0500
In-Reply-To: <20161205085916.GK1280@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: jikos@kernel.org, linux-input <linux-input@vger.kernel.org>

On Mon, 2016-12-05 at 09:59 +0100, Benjamin Tissoires wrote:
> On Dec 05 2016 or thereabouts, Zhang Rui wrote:
> > 
> > On Mon, 2016-12-05 at 09:18 +0100, Benjamin Tissoires wrote:
> > > 
> > > Hi,
> > > 
> > > On Dec 05 2016 or thereabouts, Zhang Rui wrote:
> > > > 
> > > > 
> > > > On Thu, 2016-12-01 at 13:53 +0100, Benjamin Tissoires wrote:
> > > > > 
> > > > > 
> > > > > On Dec 01 2016 or thereabouts, Zhang Rui wrote:
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > From edb2fc779c3e9c118686a3c177cfa304e95e0220 Mon Sep 17
> > > > > > 00:00:00
> > > > > > 2001
> > > > > > From: Zhang Rui <rui.zhang@intel.com>
> > > > > > Date: Wed, 30 Nov 2016 20:09:11 +0800
> > > > > > Subject: [PATCH] HID: microsoft: Add Surface Pro 4 type
> > > > > > cover
> > > > > > support
> > > > > > 
> > > > > > Adding support for the Microsoft Surface Pro 4 Type Cover.
> > > > > > 
> > > > > > This patch has been tested on my surface pro 4,
> > > > > > keyboard starts working, while the touchpad does not.
> > > > > > 
> > > > > > I don't know which type of surface pro 4 I have, but the
> > > > > > lsusb
> > > > > > output
> > > > > > shows it's ID is 07e8, and I use
> > > > > > USB_DEVICE_ID_MS_TYPE_COVER_4_1 as
> > > > > > the name, following the patch at
> > > > > > https://bugzilla.kernel.org/show_bug.cgi?id=135561#c0
> > > > > > 
> > > > > > At the same time, this patch also fixes a long
> > > > > > suspend/resume
> > > > > > delay
> > > > > > problem when type cover is attached.
> > > > > Hi,
> > > > > 
> > > > > would you mind testing the for-next branch of the HID tree
> > > > > without
> > > > > your
> > > > > patch?
> > > > > https://git.kernel.org/cgit/linux/kernel/git/jikos/hid.git/lo
> > > > > g/dr
> > > > > iver
> > > > > s/hid?h=for-next
> > > > > 
> > > > yes, I did.
> > > > 
> > > > > 
> > > > > 
> > > > > This branch makes the Surface 3 typeCover working out of the
> > > > > box
> > > > > without
> > > > > the need for specific quirks. I would hope that this way, you
> > > > > don't
> > > > > need
> > > > > the quirks for the Surface Pro 4 as well and forget about
> > > > > these
> > > > > cover
> > > > > :)
> > > > yes, the keyboard works as expected.
> > > > But unfortunately, I experienced a system hang, in like an
> > > > hour,
> > > > with
> > > > both your next tree, and upstream kernel plus my original type
> > > > cover
> > > > patch... At the same time, I also noticed that, when I type
> > > > something,
> > > > occasionally, the character keeps on popping up just like the
> > > > key
> > > > is
> > > > not released.
> > > > Now I switch back to a clean upstream 4.9-rc6 kernel, and use
> > > > it
> > > > for
> > > > half a day, no system hang so far.
> > > I am not so sure I followed  your tests. Could you confirm and
> > > complete that:
> > > - upstream + your patch: keyboard works, 2 finger scroll doesn't
> > > but
> > > it
> > >   hangs after an hour or so, and keys are repeated from time to
> > > time
> > yes.
> > > 
> > > - hid for-next branch: keyboard works, 2 finger scroll too, but
> > > it
> > > hangs
> > >   after an hour or so, and keys are repeated from time to time
> > yes.
> > > 
> > > - vanilla kernel 4.9-rc6: no hangs, but what is the status of the
> > >   keyboard/touchpad?
> > > 
> > No hangs, keyboard does not work at all.
> Ok, thanks for the confirmation.
> 
> > 
> > 
> > > 
> > > I have the impression that when the keyboard is disabled (plain
> > > v4.9-rc6) you don't experience hangs. So if that is the case,
> > > then
> > > maybe
> > > the keyboard is somewhat messing up the system. I don't know if
> > > that
> > > would be counted as a regression :/
> > Right, that's also my concern.
> > would you like to catch something for hid for-next branch? say,
> > when
> > the key repeats, I usually press some other key to stop the storm,
> > would you like me to get some information after that?
> Well, I would believe that we are missing the key release event.
> Given
> the way keys are sent from the keyboard, it seems normal that if you
> press one other key and release it, the kernel will release all of
> them.
> The keys are sent as an array, so if you send a new key event, the
> previous key will be cleared as it won't be part of the events.
> 
> One interesting bit could be to monitor the dmesg during these issues
> and see if any warning happens.
> 
> One other interesting bit could be to check whether disabling runtime
> suspend has an effect on the hangs.
> 
Well, something strange, I switched back to HID for-next kernel
yesterday, and has the system running for over 20 hours, still working
well. no hang, no repeat key. not sure what happened, I will stick with
this kernel, and update if the problem is reproduced.

thanks,
rui
> Cheers,
> Benjamin
> 
> > 
> > 
> > I can switch back to hid for-next to confirm the symptom if needed.
> > > 
> > > 
> > > Unless the keyboard is already working with a plain v4.9-rc6 but
> > > just
> > > doesn't after suspend/resume...
> > > 
> > No, keyboard does not work with upstream kernel.
> > 
> > thanks,
> > rui
> > > 
> > > Cheers,
> > > Benjamin
> > > 
> > > > 
> > > > 
> > > > 
> > > > thanks,
> > > > rui
> > > > > 
> > > > > 
> > > > > 
> > > > > Cheers,
> > > > > Benjamin
> > > > > 
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=13556
> > > > > > 1
> > > > > > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=18618
> > > > > > 1
> > > > > > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > > > > > ---
> > > > > >  drivers/hid/hid-core.c          | 2 ++
> > > > > >  drivers/hid/hid-ids.h           | 1 +
> > > > > >  drivers/hid/hid-microsoft.c     | 2 ++
> > > > > >  drivers/hid/usbhid/hid-quirks.c | 1 +
> > > > > >  4 files changed, 6 insertions(+)
> > > > > > 
> > > > > > diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-
> > > > > > core.c
> > > > > > index 2b89c70..3c4085d 100644
> > > > > > --- a/drivers/hid/hid-core.c
> > > > > > +++ b/drivers/hid/hid-core.c
> > > > > > @@ -728,6 +728,7 @@ static void hid_scan_collection(struct
> > > > > > hid_parser *parser, unsigned type)
> > > > > >  	     hid->product ==
> > > > > > USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_2
> > > > > > > 
> > > > > > > 
> > > > > > > > 
> > > > > > > > 
> > > > > > > > 
> > > > > >  	     hid->product ==
> > > > > > USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_JP
> > > > > > > 
> > > > > > > 
> > > > > > > > 
> > > > > > > > 
> > > > > > > > 
> > > > > >  	     hid->product ==
> > > > > > USB_DEVICE_ID_MS_TYPE_COVER_PRO_4_JP
> > > > > > > 
> > > > > > > 
> > > > > > > > 
> > > > > > > > 
> > > > > > > > 
> > > > > > +	     hid->product ==
> > > > > > USB_DEVICE_ID_MS_TYPE_COVER_PRO_4_1
> > > > > > > 
> > > > > > > 
> > > > > > > > 
> > > > > > > > 
> > > > > > > > 
> > > > > >  	     hid->product == USB_DEVICE_ID_MS_TYPE_COVER_3
> > > > > > ||
> > > > > >  	     hid->product == USB_DEVICE_ID_MS_POWER_COVER)
> > > > > > &&
> > > > > >  	    hid->group == HID_GROUP_MULTITOUCH)
> > > > > > @@ -1984,6 +1985,7 @@ static const struct hid_device_id
> > > > > > hid_have_special_driver[] = {
> > > > > >  	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
> > > > > > USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_2) },
> > > > > >  	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
> > > > > > USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_JP) },
> > > > > >  	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
> > > > > > USB_DEVICE_ID_MS_TYPE_COVER_PRO_4_JP) },
> > > > > > +	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
> > > > > > USB_DEVICE_ID_MS_TYPE_COVER_PRO_4_1) },
> > > > > >  	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
> > > > > > USB_DEVICE_ID_MS_TYPE_COVER_3) },
> > > > > >  	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
> > > > > > USB_DEVICE_ID_MS_DIGITAL_MEDIA_7K) },
> > > > > >  	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
> > > > > > USB_DEVICE_ID_MS_DIGITAL_MEDIA_600) },
> > > > > > diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> > > > > > index 575aa65..fe19866 100644
> > > > > > --- a/drivers/hid/hid-ids.h
> > > > > > +++ b/drivers/hid/hid-ids.h
> > > > > > @@ -719,6 +719,7 @@
> > > > > >  #define USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_2  0x07e2
> > > > > >  #define USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_JP 0x07dd
> > > > > >  #define USB_DEVICE_ID_MS_TYPE_COVER_PRO_4_JP 0x07e9
> > > > > > +#define USB_DEVICE_ID_MS_TYPE_COVER_PRO_4_1 0x07e8
> > > > > >  #define USB_DEVICE_ID_MS_TYPE_COVER_3    0x07de
> > > > > >  #define USB_DEVICE_ID_MS_POWER_COVER     0x07da
> > > > > >  
> > > > > > diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-
> > > > > > microsoft.c
> > > > > > index c6cd392..df06e6c 100644
> > > > > > --- a/drivers/hid/hid-microsoft.c
> > > > > > +++ b/drivers/hid/hid-microsoft.c
> > > > > > @@ -282,6 +282,8 @@ static const struct hid_device_id
> > > > > > ms_devices[]
> > > > > > = {
> > > > > >  		.driver_data = MS_HIDINPUT },
> > > > > >  	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
> > > > > > USB_DEVICE_ID_MS_TYPE_COVER_PRO_4_JP),
> > > > > >  		.driver_data = MS_HIDINPUT },
> > > > > > +	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
> > > > > > USB_DEVICE_ID_MS_TYPE_COVER_PRO_4_1),
> > > > > > +		.driver_data = MS_HIDINPUT },
> > > > > >  	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
> > > > > > USB_DEVICE_ID_MS_TYPE_COVER_3),
> > > > > >  		.driver_data = MS_HIDINPUT },
> > > > > >  	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
> > > > > > USB_DEVICE_ID_MS_POWER_COVER),
> > > > > > diff --git a/drivers/hid/usbhid/hid-quirks.c
> > > > > > b/drivers/hid/usbhid/hid-quirks.c
> > > > > > index e6cfd32..48d0ce8 100644
> > > > > > --- a/drivers/hid/usbhid/hid-quirks.c
> > > > > > +++ b/drivers/hid/usbhid/hid-quirks.c
> > > > > > @@ -102,6 +102,7 @@ static const struct hid_blacklist {
> > > > > >  	{ USB_VENDOR_ID_MICROSOFT,
> > > > > > USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_2,
> > > > > > HID_QUIRK_NO_INIT_REPORTS
> > > > > > },
> > > > > >  	{ USB_VENDOR_ID_MICROSOFT,
> > > > > > USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_JP,
> > > > > > HID_QUIRK_NO_INIT_REPORTS
> > > > > > },
> > > > > >  	{ USB_VENDOR_ID_MICROSOFT,
> > > > > > USB_DEVICE_ID_MS_TYPE_COVER_PRO_4_JP,
> > > > > > HID_QUIRK_NO_INIT_REPORTS
> > > > > > },
> > > > > > +	{ USB_VENDOR_ID_MICROSOFT,
> > > > > > USB_DEVICE_ID_MS_TYPE_COVER_PRO_4_1,
> > > > > > HID_QUIRK_NO_INIT_REPORTS
> > > > > > },
> > > > > >  	{ USB_VENDOR_ID_MICROSOFT,
> > > > > > USB_DEVICE_ID_MS_TYPE_COVER_3,
> > > > > > HID_QUIRK_NO_INIT_REPORTS },
> > > > > >  	{ USB_VENDOR_ID_MICROSOFT,
> > > > > > USB_DEVICE_ID_MS_POWER_COVER,
> > > > > > HID_QUIRK_NO_INIT_REPORTS },
> > > > > >  	{ USB_VENDOR_ID_MSI,
> > > > > > USB_DEVICE_ID_MSI_GT683R_LED_PANEL,
> > > > > > HID_QUIRK_NO_INIT_REPORTS },
> > > > > > -- 
> > > > > > 2.7.4
> > > > > > 
