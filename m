From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: fix botched tree merge that disabled fix-up for
 certain Sony RF receivers
Date: Wed, 1 May 2013 14:59:29 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1305011458440.20139@pobox.suse.cz>
References: <1358221428.9926.1.camel@nexus.lab.ntt.co.jp>  <20130115103638.be566e39f0f5ad7186362dd8@studenti.unina.it>  <50F52986.2080002@lab.ntt.co.jp>  <1358246448.4897.3.camel@nexus.lab.ntt.co.jp>  <alpine.LNX.2.00.1301151702150.7734@pobox.suse.cz>
 <1367367906.4712.4.camel@nexus> <1367367983.4712.5.camel@nexus>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:55101 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755152Ab3EAM7d (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 1 May 2013 08:59:33 -0400
In-Reply-To: <1367367983.4712.5.camel@nexus>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?Fernando_Luis_V=E1zquez_Cao?= <fernando_b1@lab.ntt.co.jp>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Antonio Ospite <ospite@studenti.unina.it>

On Wed, 1 May 2013, Fernando Luis V=C3=A1zquez Cao wrote:

> It looks like the manual merge 0d69a3c731e120b05b7da9fb976830475a3fbc=
01 ("Merge
> branches 'for-3.9/sony' and 'for-3.9/steelseries' into for-linus") ac=
cidentally
> removed Sony RF receiver with USB product id 0x0374 from the "have sp=
ecial
> driver" list, effectively nullifying a464918419f94a0043d2f549d6defb4c=
3f69f68a
> ("HID: add support for Sony RF receiver with USB product id 0x0374").=
 Add the
> device back to the list.
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Fernando Luis Vazquez Cao <fernando@oss.ntt.co.jp>
> ---
>=20
> diff -urNp linux-3.9/drivers/hid/hid-core.c linux-3.9-fix/drivers/hid=
/hid-core.c
> --- linux-3.9/drivers/hid/hid-core.c	2013-04-29 09:36:01.000000000 +0=
900
> +++ linux-3.9-fix/drivers/hid/hid-core.c	2013-04-30 21:53:57.59626969=
2 +0900
> @@ -1702,6 +1702,7 @@ static const struct hid_device_id hid_ha
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_NAVIGATION_=
CONTROLLER) },
>  	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_C=
ONTROLLER) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_VAIO_VGX_MO=
USE) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_VAIO_VGP_MO=
USE) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERI=
ES_SRWS1) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_SUNPLUS, USB_DEVICE_ID_SUNPLUS_WDESK=
TOP) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_THINGM, USB_DEVICE_ID_BLINK1) },

Thanks a lot for noticing. Applied.

--=20
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
