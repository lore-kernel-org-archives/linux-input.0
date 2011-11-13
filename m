From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH] HID: hid-multitouch - add another eGalax id
Date: Sun, 13 Nov 2011 22:59:41 +0100
Message-ID: <CAN+gG=GHjbZ12zYz6OTWAhE0TtRp2tBYGFjFkRc4_=6OjKGgOA@mail.gmail.com>
References: <1321042868-13836-1-git-send-email-chris@cnpbagwell.com>
	<CAN+gG=GUvGMYrJPbjOYy=EzhZ5FOv3_hvPDW_tpUXK03bsA-gw@mail.gmail.com>
	<alpine.LNX.2.00.1111132130150.15187@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:38408 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184Ab1KMV7m convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 13 Nov 2011 16:59:42 -0500
Received: by wwi18 with SMTP id 18so4105212wwi.1
        for <linux-input@vger.kernel.org>; Sun, 13 Nov 2011 13:59:41 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1111132130150.15187@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: chris@cnpbagwell.com, linux-input@vger.kernel.org

On Sun, Nov 13, 2011 at 21:31, Jiri Kosina <jkosina@suse.cz> wrote:
> On Sat, 12 Nov 2011, Benjamin Tissoires wrote:
>
>> > From: Chris Bagwell <chris@cnpbagwell.com>
>> >
>> > This allows ASUS Eee Slate touchscreens to work.
>> >
>> > Signed-off-by: Chris Bagwell <chris@cnpbagwell.com>
>> > ---
>> >
>> > I do not have one of these to test the patch but I helped a user
>> > debug why his new touchscreen was being treated as a touchpad.
>> > He reported success after adding this ID.
>> >
>>
>> The patch looks good.
>> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
>
> Applied, thanks.
>
>> > I'm sending this since I'm unsure status of patch to auto-assign
>> > multitouch devices to hid-multitouch. That would probably have
>> > solved issue as well.
>>
>> Well, as of today, the auto-detection is partly included in 3.2-rc1:
>> the generic hid layer will release the device (ie, it's not needed
>> anymore to patch hid-core.c while adding a multitouch device to its
>> list), but hid-multitouch is not capable of handling it after the
>> release of the generic part.
>> BTW, egalax devices need a special handling, and we may have to add
>> them one by one.
>>
>> Alternatively, we could use:
>> =A0+ =A0 =A0 =A0 { =A0.driver_data =3D MT_CLS_EGALAX,
>> =A0+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_DWAV, =
HID_ANY_ID) },
>> but that's hoping that DWAV won't do any other things than multitouc=
h panels.
>> Jiri, have you an idea on this?
>
> Currently we have something like 7 entries, which doesn't sound that =
bad.
> If the number of device IDs starts to grow rapidly, we should start
> thinking about this, but I think we are not there yet.
>
> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
