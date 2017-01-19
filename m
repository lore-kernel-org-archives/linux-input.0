From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 13/17] HID: logitech-hidpp: make .probe usbhid capable
Date: Thu, 19 Jan 2017 11:56:04 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1701191155230.25515@cbobk.fhfr.pm>
References: <20170117143547.30488-1-benjamin.tissoires@redhat.com> <20170117143547.30488-14-benjamin.tissoires@redhat.com> <CAN+gG=G30ZROL7R9WRZ7971pmmd46OhLctA-v-zSB+CmFu2SUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:47093 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752065AbdASK4I (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 19 Jan 2017 05:56:08 -0500
In-Reply-To: <CAN+gG=G30ZROL7R9WRZ7971pmmd46OhLctA-v-zSB+CmFu2SUQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Bastien Nocera <hadess@hadess.net>, Peter Hutterer <peter.hutterer@who-t.net>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Olivier Gay <ogay@logitech.com>, Simon Wood <simon@mungewell.org>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, 18 Jan 2017, Benjamin Tissoires wrote:

> > The current custom solution for the G920 is not the best because
> > hid_hw_start() is not called at the end of the .probe().
> > It means that any configuration retrieved after the initial hid_hw_start
> > would not be exposed to user space without races.
> >
> > We can simply force hid_hw_start to just enable the transport layer by
> > not using a connect_mask. This way, we can have a common path between
> > USB, Unifying and Bluetooth devices.
> >
> > Tested with a G502 (plain USB), a T650 and many other unifying devices,
> > and the T651 over Bluetooth.
> >
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > ---
> >  drivers/hid/hid-logitech-hidpp.c | 88 ++++++++++++++++++++++------------------
> >  1 file changed, 48 insertions(+), 40 deletions(-)
> >
> > diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> > index a5d37a4..f5889ff 100644
> > --- a/drivers/hid/hid-logitech-hidpp.c
> > +++ b/drivers/hid/hid-logitech-hidpp.c
> > @@ -2813,6 +2813,17 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
> >         if (!hidpp_validate_device(hdev))
> >                 return hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> >
> > +       /*
> > +        * HID++ needs to read incoming report while in .probe().
> > +        * However, this doesn't work for plain USB devices until the hdev
> > +        * status is set with HID_STAT_ADDED (device fully registered once
> > +        * with HID).
> > +        * So we ask for it to be reprobed later.
> > +        */
> > +       if (id->group != HID_GROUP_LOGITECH_DJ_DEVICE &&
> > +           !(hdev->status & HID_STAT_ADDED))
> 
> Looks like this test breaks the T651 (bluetooth) after all. I seem to
> have better success with:
>     if (id->bus == BUS_USB && !(hdev->status & HID_STAT_ADDED))
> 
> But that also means that the solution will not work if there is only
> one USB interface in the device :/

Benjamin,

do you want at least a subset of this patchset to be queued before you 
figure this out, or should I put the whole thing on hold? (not gone 
through it fully yet).

Thanks,

-- 
Jiri Kosina
SUSE Labs

