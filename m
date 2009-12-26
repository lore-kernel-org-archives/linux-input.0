From: Lamarque Vieira Souza <lamarque@gmail.com>
Subject: Re: Problem with Acer Bluetooth Optical Rechargeable Mouse
Date: Fri, 25 Dec 2009 22:40:58 -0200
Message-ID: <200912252240.59052.lamarque@gmail.com>
References: <200908062247.29254.lamarque@gmail.com> <alpine.LSU.2.00.0909221733290.10090@wotan.suse.de> <200909221319.45013.lamarque@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:62015 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756162AbZLZAlL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Dec 2009 19:41:11 -0500
Received: by yxe17 with SMTP id 17so8303003yxe.33
        for <linux-input@vger.kernel.org>; Fri, 25 Dec 2009 16:41:10 -0800 (PST)
In-Reply-To: <200909221319.45013.lamarque@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, Andrew Morton <akpm@linux-foundation.org>

	Any news about this patch? It has not entered kernel 2.6.32 (nor even=20
2.6.32.2), is there any reason why?

Em Ter=E7a-feira 22 Setembro 2009, Lamarque Vieira Souza escreveu:
> Em Ter=E7a-feira 22 Setembro 2009, Jiri Kosina escreveu:
> > Hi,
> >
> > could you please resend your patch? It has either been lost somewhe=
re on
> > the way, or in the dark depths of my inbox, so I am not really sure=
 which
> > one you are referring to, sorry.
>=20
> Marks Acer Bluetooth Optical Rechargeable Mouse from Ferrari 4005 not=
ebook
>  to be ignored by hid core. This change makes hid core to use input s=
ession
>  instead of hid session with that mouse. With hid session the mouse c=
ursor
>  moves too laggy, using input session corrects this problem.
>=20
> Signed-off-by: Lamarque V. Souza <lamarque@gmail.com>
>=20
> diff -Nru --show-c-function a/drivers/hid/hid-core.c
>  b/drivers/hid/hid-core.c --- a/drivers/hid/hid-core.c	2009-08-13
>  20:45:11.000000000 -0300
> +++ b/drivers/hid/hid-core.c	2009-08-13 22:25:54.504677594 -0300
> @@ -1636,6 +1636,7 @@ static const struct hid_device_id hid_ig
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP,
>  USB_DEVICE_ID_1_PHIDGETSERVO_20) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_8_8_4_IF_KI=
T) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_YEALINK,
>  USB_DEVICE_ID_YEALINK_P1K_P4K_B2K) },
> +	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_KYE, 0x0058) },
>  	{ }
>  };
>=20


--=20
Lamarque V. Souza
http://www.geographicguide.com/brazil.htm
Linux User #57137 - http://counter.li.org/
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
