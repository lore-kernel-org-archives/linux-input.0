From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: hid-multitouch - add another eGalax id
Date: Sun, 13 Nov 2011 21:31:07 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1111132130150.15187@pobox.suse.cz>
References: <1321042868-13836-1-git-send-email-chris@cnpbagwell.com> <CAN+gG=GUvGMYrJPbjOYy=EzhZ5FOv3_hvPDW_tpUXK03bsA-gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:37733 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752351Ab1KMUbI (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 13 Nov 2011 15:31:08 -0500
In-Reply-To: <CAN+gG=GUvGMYrJPbjOYy=EzhZ5FOv3_hvPDW_tpUXK03bsA-gw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: chris@cnpbagwell.com, linux-input@vger.kernel.org

On Sat, 12 Nov 2011, Benjamin Tissoires wrote:

> > From: Chris Bagwell <chris@cnpbagwell.com>
> >
> > This allows ASUS Eee Slate touchscreens to work.
> >
> > Signed-off-by: Chris Bagwell <chris@cnpbagwell.com>
> > ---
> >
> > I do not have one of these to test the patch but I helped a user
> > debug why his new touchscreen was being treated as a touchpad.
> > He reported success after adding this ID.
> >
>=20
> The patch looks good.
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>

Applied, thanks.

> > I'm sending this since I'm unsure status of patch to auto-assign
> > multitouch devices to hid-multitouch. That would probably have
> > solved issue as well.
>=20
> Well, as of today, the auto-detection is partly included in 3.2-rc1:
> the generic hid layer will release the device (ie, it's not needed
> anymore to patch hid-core.c while adding a multitouch device to its
> list), but hid-multitouch is not capable of handling it after the
> release of the generic part.
> BTW, egalax devices need a special handling, and we may have to add
> them one by one.
>=20
> Alternatively, we could use:
>  + =A0 =A0 =A0 { =A0.driver_data =3D MT_CLS_EGALAX,
>  + =A0 =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_DWAV, HID=
_ANY_ID) },
> but that's hoping that DWAV won't do any other things than multitouch=
 panels.
> Jiri, have you an idea on this?

Currently we have something like 7 entries, which doesn't sound that ba=
d.=20
If the number of device IDs starts to grow rapidly, we should start=20
thinking about this, but I think we are not there yet.

Thanks,

--=20
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
