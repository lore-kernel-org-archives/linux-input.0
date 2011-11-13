From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH] HID: hid-multitouch - add another eGalax id
Date: Mon, 14 Nov 2011 00:15:30 +0100
Message-ID: <201111140015.30787.marek.vasut@gmail.com>
References: <1321042868-13836-1-git-send-email-chris@cnpbagwell.com> <CAN+gG=GUvGMYrJPbjOYy=EzhZ5FOv3_hvPDW_tpUXK03bsA-gw@mail.gmail.com> <alpine.LNX.2.00.1111132130150.15187@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36271 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752809Ab1KMXPe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 13 Nov 2011 18:15:34 -0500
Received: by fagn18 with SMTP id n18so2661733fag.19
        for <linux-input@vger.kernel.org>; Sun, 13 Nov 2011 15:15:33 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1111132130150.15187@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, chris@cnpbagwell.com, linux-input@vger.kernel.org

> On Sat, 12 Nov 2011, Benjamin Tissoires wrote:
> > > From: Chris Bagwell <chris@cnpbagwell.com>
> > > 
> > > This allows ASUS Eee Slate touchscreens to work.
> > > 
> > > Signed-off-by: Chris Bagwell <chris@cnpbagwell.com>
> > > ---
> > > 
> > > I do not have one of these to test the patch but I helped a user
> > > debug why his new touchscreen was being treated as a touchpad.
> > > He reported success after adding this ID.
> > 
> > The patch looks good.
> > Reviewed-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
> 
> Applied, thanks.
> 
> > > I'm sending this since I'm unsure status of patch to auto-assign
> > > multitouch devices to hid-multitouch. That would probably have
> > > solved issue as well.
> > 
> > Well, as of today, the auto-detection is partly included in 3.2-rc1:
> > the generic hid layer will release the device (ie, it's not needed
> > anymore to patch hid-core.c while adding a multitouch device to its
> > list), but hid-multitouch is not capable of handling it after the
> > release of the generic part.
> > BTW, egalax devices need a special handling, and we may have to add
> > them one by one.
> > 
> > Alternatively, we could use:
> >  +       {  .driver_data = MT_CLS_EGALAX,
> >  +               HID_USB_DEVICE(USB_VENDOR_ID_DWAV, HID_ANY_ID) },
> > 
> > but that's hoping that DWAV won't do any other things than multitouch
> > panels. Jiri, have you an idea on this?
> 
> Currently we have something like 7 entries, which doesn't sound that bad.
> If the number of device IDs starts to grow rapidly, we should start
> thinking about this, but I think we are not there yet.

Well there's another one in Acer W500. But that one handles 5 simulaneous MT 
events. I submitted a patch already, but it was held because ... I dunno why 
anymore.

M
