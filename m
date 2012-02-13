From: Nestor Lopez Casado <nlopezcasad@logitech.com>
Subject: Re: [PATCH] HID: use generic driver for Logitech Unifying receivers
 if CONFIG_HID_LOGITECH_DJ=n
Date: Mon, 13 Feb 2012 09:40:49 +0100
Message-ID: <CAE7qMrrubKoOSo+kwG9rpx6ac8U=6PQtHTDEh416NBBJNr8mGA@mail.gmail.com>
References: <20120213080644.6105.54221.stgit@zurg>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:45948 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750993Ab2BMIlV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Feb 2012 03:41:21 -0500
In-Reply-To: <20120213080644.6105.54221.stgit@zurg>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Konstantin Khlebnikov <khlebnikov@openvz.org>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@gmail.com>

Hi Konstantin,

This was the original implementation
http://www.spinics.net/lists/linux-input/msg15225.html
Jiri suggested we removed the conditional compilation and we accepted.

Which are your reasons to add those conditionals back again?

Cheers,

Nestor

On Mon, Feb 13, 2012 at 9:06 AM, Konstantin Khlebnikov
<khlebnikov@openvz.org> wrote:
> Before commit 534a7b8e1 "HID: Add full support for Logitech Unifying =
receivers"
> Logitech Unifying receiver can work as generic device without special=
 driver,
> after that commit these devices does not works without special driver=
=2E
>
> After this patch they will use generic driver if special driver is di=
sabled.
>
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@openvz.org>
> ---
> =A0drivers/hid/hid-core.c | =A0 =A02 ++
> =A01 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index af08ce7..3d7a174 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1462,8 +1462,10 @@ static const struct hid_device_id hid_have_spe=
cial_driver[] =3D {
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID=
_LOGITECH_DFGT_WHEEL) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID=
_LOGITECH_G25_WHEEL) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID=
_LOGITECH_G27_WHEEL) },
> +#if IS_ENABLED(CONFIG_HID_LOGITECH_DJ)
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID=
_LOGITECH_UNIFYING_RECEIVER) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID=
_LOGITECH_UNIFYING_RECEIVER_2) },
> +#endif
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID=
_LOGITECH_WII_WHEEL) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID=
_LOGITECH_RUMBLEPAD2) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID=
_SPACETRAVELLER) },
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
