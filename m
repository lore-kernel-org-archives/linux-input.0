From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH] HID: hid-multitouch - add another eGalax id
Date: Sat, 12 Nov 2011 16:01:12 +0100
Message-ID: <CAN+gG=GUvGMYrJPbjOYy=EzhZ5FOv3_hvPDW_tpUXK03bsA-gw@mail.gmail.com>
References: <1321042868-13836-1-git-send-email-chris@cnpbagwell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:64825 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753994Ab1KLPBO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 12 Nov 2011 10:01:14 -0500
Received: by wyh15 with SMTP id 15so4669730wyh.19
        for <linux-input@vger.kernel.org>; Sat, 12 Nov 2011 07:01:12 -0800 (PST)
In-Reply-To: <1321042868-13836-1-git-send-email-chris@cnpbagwell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: chris@cnpbagwell.com
Cc: linux-input@vger.kernel.org, jkosina@suse.cz

Hi Chris,

On Fri, Nov 11, 2011 at 21:21,  <chris@cnpbagwell.com> wrote:
> From: Chris Bagwell <chris@cnpbagwell.com>
>
> This allows ASUS Eee Slate touchscreens to work.
>
> Signed-off-by: Chris Bagwell <chris@cnpbagwell.com>
> ---
>
> I do not have one of these to test the patch but I helped a user
> debug why his new touchscreen was being treated as a touchpad.
> He reported success after adding this ID.
>

The patch looks good.
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>

> I'm sending this since I'm unsure status of patch to auto-assign
> multitouch devices to hid-multitouch. That would probably have
> solved issue as well.

Well, as of today, the auto-detection is partly included in 3.2-rc1:
the generic hid layer will release the device (ie, it's not needed
anymore to patch hid-core.c while adding a multitouch device to its
list), but hid-multitouch is not capable of handling it after the
release of the generic part.
BTW, egalax devices need a special handling, and we may have to add
them one by one.

Alternatively, we could use:
 + =A0 =A0 =A0 { =A0.driver_data =3D MT_CLS_EGALAX,
 + =A0 =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_DWAV, HID_A=
NY_ID) },
but that's hoping that DWAV won't do any other things than multitouch p=
anels.
Jiri, have you an idea on this?

Cheers,
Benjamin
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
