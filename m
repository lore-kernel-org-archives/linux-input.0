From: =?iso-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: Re: [PATCH 3/3] hid-multitouch: Add LG Display Multitouch device.
Date: Mon, 25 Jul 2011 11:18:45 +0200
Message-ID: <9B9DAF0C-EB98-4DC3-9D29-F388CB599E61@enac.fr>
References: <1311545261-34067-1-git-send-email-jeffbrown@android.com> <1311545261-34067-3-git-send-email-jeffbrown@android.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:50040 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751044Ab1GYJYG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jul 2011 05:24:06 -0400
In-Reply-To: <1311545261-34067-3-git-send-email-jeffbrown@android.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jeffbrown@android.com
Cc: USB list <linux-input@vger.kernel.org>, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Benjamin Tissoires <benjamin.tissoires@enac.fr>, Jeff Brown <jeffbrown@google.com>


Le 25 juil. 2011 =E0 00:07, jeffbrown@android.com a =E9crit :

> From: Jeff Brown <jeffbrown@google.com>
>=20
> Signed-off-by: jeffbrown@android.com
> ---
> drivers/hid/hid-ids.h        |    3 +++
> drivers/hid/hid-multitouch.c |    5 +++++
> 2 files changed, 8 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index db63ccf..637e6e9 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -419,6 +419,9 @@
> #define USB_DEVICE_ID_LD_HYBRID		0x2090
> #define USB_DEVICE_ID_LD_HEATCONTROL	0x20A0
>=20
> +#define USB_VENDOR_ID_LG		0x1fd2
> +#define USB_DEVICE_ID_LG_MULTITOUCH	0x0064
> +
> #define USB_VENDOR_ID_LOGITECH		0x046d
> #define USB_DEVICE_ID_LOGITECH_RECEIVER	0xc101
> #define USB_DEVICE_ID_LOGITECH_HARMONY_FIRST  0xc110
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouc=
h.c
> index 4ee21ac..b03a0b0 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -682,6 +682,11 @@ static const struct hid_device_id mt_devices[] =3D=
 {
> 		HID_USB_DEVICE(USB_VENDOR_ID_IRTOUCHSYSTEMS,
> 			USB_DEVICE_ID_IRTOUCH_INFRARED_USB) },
>=20
> +	/* LG Display panels */
> +	{ .driver_data =3D MT_CLS_DEFAULT,
> +		HID_USB_DEVICE(USB_VENDOR_ID_LG,
> +			USB_DEVICE_ID_LG_MULTITOUCH) },
> +
> 	/* Lumio panels */
> 	{ .driver_data =3D MT_CLS_CONFIDENCE_MINUS_ONE,
> 		HID_USB_DEVICE(USB_VENDOR_ID_LUMIO,
> --=20
> 1.7.0.4
>=20

I don't have access to the panel for testing, but I trust that Jeff has=
 tested it :-)

Acked-by: St=E9phane Chatty <chatty@enac.fr>


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
