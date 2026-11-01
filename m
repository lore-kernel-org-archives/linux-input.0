Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793545466;
	b=dVi2g0+VS6U7Y/btXaCFlmNyCru88tquvQgwHaiBlOX9A1Uuo8tO3p3Jqn7h64Lu3d4q
	 AJkCZn+/MoyZQRuE+tanuxTEhbIoTWnR5vMYGWxHnwkdf2299JwO/NQlTkbjawYGBcilz
	 Dk4wpjkGZuc0s5OP2tD8ONE9ATOVk8gm0UpWk4PyP2rGuyCNltXoiCuH1xMqzjLoP6vIt
	 5rcfH0gd9r5VG49rF8K4NiSLr9ZLfUWC95y9KthMvgNBltzWujp6LG2G+cA0rBMQNJUIC
	 yLOHKgjctDD7La0yWm5XhAKTl9hYzkebkUES1W5Eg8YIxoQpk6SPyg/dxQIJeQcDc9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793545466;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=C34lsMg6LfbPsaTK6Ab7N6eeppX3dOfhDIbDBh1uGFw=;
	b=HFGOCroMVDRsq5BlTNUo0I4rY/lhOnKABB26IlrpY1HiCKLH3a9gGoADtfuVFpZ/4FOn
	 gcEi0UBJCZ77W+zia5xfXPFNxlQjP2YfzrMlfHPell34OCSMlbxOGTNSjZ9I56xYhdL1F
	 vMoFjh6yHAPS0NMCM9NfF5/ruABFgOvb9A8rV3zR755Y7zpTV1qVVV2WXLe9A9WH48F5P
	 Pg9OQo7/prdQ6dtrSr3AOwftlrmpIRGX6EZfJpEhGVvXRbOnJZ2S6+K6eXKE0gxBDTgb4
	 g6PaYU+iKtd4cckfhaNNGXROalmW9GNCf9D1KeaaTIAslVchqwcGeNnRZN7RdypQ4mQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jdbwVlpN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF89D606A324
	for <linux-input@vger.kernel.org>; Sun,  1 Nov 2026 15:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jdbwVlpN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19F661F000C1;
	Sun,  1 Nov 2026 15:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793545465;
	bh=C34lsMg6LfbPsaTK6Ab7N6eeppX3dOfhDIbDBh1uGFw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jdbwVlpNPvn7ehD/6D8wlyAWVmmR145i/PnpdUQRoiIhai7/l2ReM4SVNLjDHMWwq
	 UkmS3XKmycT0XOQxTe4RDT3pF7sk2J53a5wue0QzXMpjuzQb+WY+xf2zm4f2WDJCdr
	 vsCr3atcoP2iXx3Flll+j9W0dSaUgnu7S2Ux163dbM0DUAPdUfLiIBU7ep8NP2GsBc
	 EFOMPFPqh0BOlmRF+kCjO8vG62WcBC7u1crA+5TXGSWj+9lKlxR7drGz8rtgZfg8sP
	 CDdLtW7GSmMR+8Fm94k879Fm0W0/5T65hCJ7662aFAqGL35XCUYOPAl+SK0uFQArrN
	 GQxJc8WAxW0aQ==
Message-ID: <sashiko-outbox-192464@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: add driver for EWEADN G5 mice
Reply-To: sashiko-reviews@lists.linux.dev
To: "Liang Haowen" <nbg2974@gmail.com>, linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com
In-Reply-To: <6ae7529d.10abdf86.7545b.3e9a@mx.google.com>
References: <6ae7529d.10abdf86.7545b.3e9a@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 15:04:24 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] HID: hid-eweadn: returning -ENODEV in eweadn_probe() unbinds sibli=
ng interfaces
- [High] HID: hid-eweadn: unchecked to_usb_interface() cast in eweadn_probe=
()
- [Low] HID: hid-eweadn: hardcoded USB IDs instead of hid-ids.h macros in e=
weadn_devices
--

commit d81d5f8f2cf2bc9851adb951ad34ae0654a99eee
Author: Liang Haowen <nbg2974@gmail.com>

HID: add driver for EWEADN G5 mice

This patch adds a HID driver for EWEADN G5 mice (0xa8a5:2255 and
0xa8a4:2255) that replaces the broken report descriptor on USB interface 0
with a standard mouse report descriptor so hid-core can parse motion and
button events.

> diff --git a/drivers/hid/hid-eweadn.c b/drivers/hid/hid-eweadn.c
> new file mode 100644
> index 0000000000000..6aacfc5dbe8ac
> --- /dev/null
> +++ b/drivers/hid/hid-eweadn.c
> @@ -0,0 +1,120 @@

[ ... ]

> +static const __u8 *eweadn_report_fixup(struct hid_device *hdev, __u8 *rd=
esc,
> +				       unsigned int *rsize)
> +{
> +	hid_info(hdev, "fixing up EWEADN G5 mouse report descriptor\n");
> +	*rsize =3D sizeof(eweadn_rdesc);
> +	return eweadn_rdesc;
> +}
> +
> +static int eweadn_probe(struct hid_device *hdev,
> +			const struct hid_device_id *id)
> +{
> +	struct usb_interface *intf;
> +	int ret;
> +
> +	intf =3D to_usb_interface(hdev->dev.parent);

[Severity: High]
Can to_usb_interface(hdev->dev.parent) be called here without first
checking hid_is_usb(hdev)?

Although eweadn_devices uses HID_USB_DEVICE(), that only matches
hdev->bus =3D=3D BUS_USB, hdev->vendor, and hdev->product (or a device can =
be
bound via sysfs). A virtual HID device created via /dev/uhid in
uhid_dev_create2() (drivers/hid/uhid.c) can specify bus =3D BUS_USB and
matching vendor/product IDs while setting hdev->dev.parent to
uhid_misc.this_device rather than a struct usb_interface.

Without a hid_is_usb(hdev) check, container_of_const() on hdev->dev.parent
and dereferencing intf->cur_altsetting->desc.bInterfaceNumber will read out
of bounds and dereference an invalid pointer.

> +	if (intf->cur_altsetting->desc.bInterfaceNumber !=3D 0)
> +		return -ENODEV;	/* keyboard and config stay on hid-generic */

[Severity: High]
Does returning -ENODEV in eweadn_probe() actually allow interfaces 1 and 2
to stay on hid-generic, or does it leave them completely unbound?

Each USB interface of the composite device creates a separate struct
hid_device with identical bus, vendor, and product IDs, so
hid_match_device(hdev, &eweadn_driver) matches eweadn_devices for all three
interfaces.

In drivers/hid/hid-generic.c, hid_generic_match() checks whether any other
registered HID driver's id_table matches the device:

drivers/hid/hid-generic.c:hid_generic_match() {
	...
	if (bus_for_each_drv(&hid_bus_type, NULL, hdev, __check_hid_generic))
		return false;
	return true;
}

where __check_hid_generic() returns 1 whenever hid_match_device(hdev, hdrv)
is non-NULL, regardless of whether hdrv->probe() later returns -ENODEV. In
addition, when eweadn_driver is registered, __hid_register_driver() calls
__hid_bus_reprobe_drivers(), which sees !hid_generic_match() and calls
device_reprobe(), detaching hid-generic from interfaces 1 and 2. Because
eweadn_probe() then returns -ENODEV for bInterfaceNumber !=3D 0, interfaces=
 1
and 2 are left with no bound driver at all.

Instead of rejecting non-zero interfaces in a custom .probe callback,
should the bInterfaceNumber =3D=3D 0 check (guarded by hid_is_usb(hdev)) be
done inside eweadn_report_fixup() so non-zero interfaces keep their
original report descriptor while binding normally?

> +
> +	ret =3D hid_parse(hdev);
> +	if (ret) {
> +		hid_err(hdev, "parse failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret =3D hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> +	if (ret) {
> +		hid_err(hdev, "hw start failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct hid_device_id eweadn_devices[] =3D {
> +	{ HID_USB_DEVICE(0xa8a5, 0x2255) },		/* original receiver */
> +	{ HID_USB_DEVICE(0xa8a4, 0x2255) },		/* replacement unit, wired mouse */
> +	{ }
> +};

[Severity: Low]
This isn't a bug, but drivers/hid/hid-ids.h already defines:

#define USB_VENDOR_ID_YJXCHIP		0xa8a5
#define USB_DEVICE_ID_YJXCHIP_MOUSE	0x2255

Should hid-eweadn.c include "hid-ids.h" and use those macros (adding a
corresponding macro for 0xa8a4) instead of raw hex constants, and mark
eweadn_rdesc[] as const?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/6ae7529d.10abdf86.7=
545b.3e9a@mx.google.com?part=3D1
