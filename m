From: "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: usbhid: Add mechanism to blacklist based on device
 release
Date: Mon, 2 Oct 2017 19:36:12 +0200
Message-ID: <20171002173612.GA23135@mail.corp.redhat.com>
References: <1506935094-18139-1-git-send-email-nolsen@jabra.com>
 <CAP_ceTxAiOU6TByzOcCA4+e=+uzULyteyt6Deg-quBKeiWBMjg@mail.gmail.com>
 <VI1PR0701MB29919C8B0B4E2C74A27F4775DA7D0@VI1PR0701MB2991.eurprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37807 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751131AbdJBRgR (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 2 Oct 2017 13:36:17 -0400
Content-Disposition: inline
In-Reply-To: <VI1PR0701MB29919C8B0B4E2C74A27F4775DA7D0@VI1PR0701MB2991.eurprd07.prod.outlook.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Niels Skou Olsen <nolsen@jabra.com>
Cc: Vincent Palatin <vpalatin@chromium.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi,

On Oct 02 2017 or thereabouts, Niels Skou Olsen wrote:
> On Mon, Oct 2, 2017, vpalatin@google.com wrote:
> 
> > Is there really a value in putting it in both lists ? can we put it only in the latter ?
> 
> No, you're right we can just use the latter.
> 
> > > + * against the good_release value. If the bcdDevice value is less
> > > +than
> > > + * good_release the device is ignored.
> > > + */
> > > +static const struct hid_ignore_by_release {
> > > +       __u16 idVendor;
> > > +       __u16 idProduct;
> > > +       __u16 good_release;
> > > +} hid_ignore_by_release[] = {
> > > +       { USB_VENDOR_ID_JABRA, USB_DEVICE_ID_JABRA_SPEAK_410, 0x111 },
> > > +       { USB_VENDOR_ID_JABRA, USB_DEVICE_ID_JABRA_SPEAK_510, 0x214 },
> > > +       { 0, 0 }
> > > +};
> >
> > Maybe we should use here 'struct usb_device_id' as done in other drivers.
> > (and maybe put the flags in  .driver_info) It conveniently  has a .bcdDevice_lo and
> > .bcdDevice_hi fields. Then we can use the more generic usb_match_id() function.
> 
> That's a good idea.

I'd rather not to. Let me explain my concerns.

I have a current-to-be-sent series that basically moves out the
usbhid/quirks handling into a generic HID way. This will allow to have a
generic dynamic quirk handling for all the HID transport layers.
I should be able to submit this tonight.

The issue I see here is that if we start dragging usb.h internals into the
quirks mechanism, we will need to have (again) a handling of quirks in
several places, in HID core and in usbhid. OK, I should have sent my
series earlier, my bad.

However, there is a HID field .version, that usbhid could fill in before
calling hid_add_device(), instead of filling it in usbhid_parse().
This way we could have a generic check on the firmware version instead of
pulling in usb.h.
Note that there might not be any guarantee that the bcd from the HID
descriptor will stay the same than the one from the USB interface, so we
might need to still overwrite it in usbhid_parse(), to keep backward
compatibility.

> 
> I just had a look, and afaics I will need to use struct usb_interface in
> drivers/hid/usbhid/hid-quirks.c. So I will need to pull in include/linux/usb.h.
> Also I will need to  forward declare struct usb_interface in
> include/linux/hid.h for the usbhid_lookup_quirk() prototype. Is it going
> to be OK to do this?

I'd actually rather we do not change the usbhid_lookup_quirk()
prototype. I also think we should not over engineer things and it's OK
to have a special case for these devices.

So what I would recommend:
 - in usbhid_probe(), set the .version field with dev->descriptor.bcdDevice
 - in usbhid_lookup_quirk(), add an other special case for Jabra devices,
   in the same way we already do for NCR devices, and check for the
   .version field here

If we were to have other devices that relies on the bcd to chose whether
or not being compatible with HID core, we can always make it generic
later.

Cheers,
Benjamin

> 
> I will come up with a V2 patch for these suggestions.
> 
> Thanks,
> Niels
> **** GN GROUP NOTICE - AUTOMATICALLY INSERTED**** The information in this e-mail (including attachments, if any) is considered confidential and is intended only for the recipient(s) listed above. Any review, use, disclosure, distribution or copying of this e-mail is prohibited except by or on behalf of the intended recipient. If you have received this email in error, please notify me immediately by reply e-mail, delete this e-mail, and do not disclose its contents to anyone. Any opinions expressed in this e-mail are those of the individual and not necessarily the GN group. Thank you. ******************** DISCLAIMER END ************************
