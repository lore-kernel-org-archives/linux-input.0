From: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: Re: HID: fixup blacklist entry for Asus T91MT
Date: Wed, 8 Sep 2010 16:56:15 +0200
Message-ID: <502D31CD-ABAF-41D3-9FD4-B6D9806891B0@enac.fr>
References: <alpine.LNX.2.00.1009081433080.26813@pobox.suse.cz>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:35944 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755242Ab0IHO4b convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Sep 2010 10:56:31 -0400
In-Reply-To: <alpine.LNX.2.00.1009081433080.26813@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input <linux-input@vger.kernel.org>

Is this the *second* device for which I made the mistake?? Gosh.

St.


Le 8 sept. 10 =E0 14:33, Jiri Kosina a =E9crit :

> The device is handled by hid-mosart driver, and therefore should
> be present in hid_blacklist[], not hid_ignore_list[].
>
> Cc: Stephane Chatty <chatty@lii-enac.fr>
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> ---
>  drivers/hid/hid-core.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 2baf959..3f72924 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1285,6 +1285,7 @@ static const struct hid_device_id =20
> hid_blacklist[] =3D {
>  	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, =20
> USB_DEVICE_ID_APPLE_ALU_WIRELESS_2009_JIS) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, =20
> USB_DEVICE_ID_APPLE_FOUNTAIN_TP_ONLY) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, =20
> USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUS, USB_DEVICE_ID_ASUS_T91MT) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUS, =20
> USB_DEVICE_ID_ASUSTEK_MULTITOUCH_YFO) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_BELKIN, USB_DEVICE_ID_FLIP_KVM) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_BTC, =20
> USB_DEVICE_ID_BTC_EMPREX_REMOTE) },
> @@ -1580,7 +1581,6 @@ static const struct hid_device_id =20
> hid_ignore_list[] =3D {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_AIPTEK, USB_DEVICE_ID_AIPTEK_24) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_AIRCABLE, USB_DEVICE_ID_AIRCABLE1) }=
,
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_ALCOR, =20
> USB_DEVICE_ID_ALCOR_USBRS232) },
> -	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUS, USB_DEVICE_ID_ASUS_T91MT)},
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_LCM)}=
,
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK, =20
> USB_DEVICE_ID_ASUSTEK_LCM2)},
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_AVERMEDIA, =20
> USB_DEVICE_ID_AVER_FM_MR800) },
> --=20
> 1.7.2.1
>

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
