Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3A03BD225
	for <linux-input@vger.kernel.org>; Tue,  4 Aug 2026 05:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785823009; cv=none; b=Iv0vsO0pK9kBJxghiDUhSR6pnbQX3kSiCilj3LU16ObI3kThiHcx65QupIkqOYqc0oiyLemmwhHK9s1Zq60wqnjNmtucAvIR9V0FUL4G7ooX06v5H3RJ5e+safO0YP6lcsD89hmUX3cqtxRjXje68zbW6dgl2WnXMUgfcq9GHdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785823009; c=relaxed/simple;
	bh=pu1t0j2xVb1em4Wgx35AIz0pvUzzAv/XDYiTR15md5A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N8LuhvIaeKHnsiaOYrKFPB+XULOd2Zly3ToUgd2i1sckRJTPsmCVnvBFFORHfOu7VPgLyYczEMgUreFKiy14OW6pppkogfwYphd3MFcoX6UVjXp4q2zm3auT7w5QyjcT+Ic+JihqfcaYkT0c3VxXaxaSn1SZnXWAA+H3+4ykxyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWGv95d+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWGv95d+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE821F000E9;
	Tue,  4 Aug 2026 05:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785823008;
	bh=Pw/aqo1hCf5qiZ68iPqnLsRGIkZW9/aK6iQZGgVvEu8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TWGv95d+zBR1yiRIL8OLDLMxwPowvK+BX2Gn29OACtm2WbJtTy0ho2M0cPB0Z3wNe
	 Hg7Vce9eoYiMB3w74xumFKi+JP+2RaIYlIyqhQd7U578gCW98pQP82uEQoZYAzrseA
	 DAzR9MSGcCndJbsl57y3e5gca0it98Rs8kTxiCfwWz1iwXO5Vq1uQqK9u7zab0u0+I
	 h3u0MCV8puVxklSF+PKoMpTgyWUMk1tgzgkGaHK8Z/TELTE3K7vbqpBS5jSCgbb4Mb
	 IbvERDU9XKa+fSNPoZimOdj5mfmzDHlUSRX4OinPCY3NYLfXlU7Weyne0ub+I0ceIK
	 Cp7Mns6S0u2Hw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] Input: xpad - add support for Beitong KP series
 controllers
Reply-To: sashiko-reviews@lists.linux.dev
To: vegetablecat@foxmail.com
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <tencent_72D4D10513DFB685733F4F75EDA62F6EE107@qq.com>
References: <tencent_72D4D10513DFB685733F4F75EDA62F6EE107@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 05:56:47 +0000
Message-Id: <20260804055648.0FE821F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Contradictory Vendor ID for the KP40D controller between the Xpad =
driver table and HID quirks.
- [Medium] Unconditional `-EREMOTEIO` errors and spurious warnings due to `=
usb_control_msg_recv()` exact-size enforcement.
--

--- Patch [1]: [PATCH v4] Input: xpad - add support for Beitong KP series c=
ontrollers ---
commit 70428191ed674d48449b3a34df01ce588dc47bd5
Author: vegetablecat@foxmail.com <vegetablecat@foxmail.com>

Input: xpad - add support for Beitong KP series controllers
   =20
This patch adds support for the Beitong KP series controllers (both wired
and wireless modes) to the xpad driver. It introduces a Microsoft OS 1.0
descriptor sequence to lock the controllers into XInput mode during probe
and adds a keepalive HID quirk for the KP40D receiver.

Link: https://lore.kernel.org/linux-input/20260102030154.197749-2-liushuyu@=
aosc.io/

> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index b70f719b3b075..8baa9efd2f724 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -273,6 +273,8 @@
>  #define USB_VENDOR_ID_BETOP_2185PC	0x11c0
>  #define USB_VENDOR_ID_BETOP_2185V2PC	0x8380
>  #define USB_VENDOR_ID_BETOP_2185V2BFM	0x20bc
> +#define USB_VENDOR_ID_BETOP_20DD		0x20dd
> +#define USB_DEVICE_ID_BETOP_KP40D	0x515c

[Severity: High]
Is the Vendor ID for the KP40D correct here?=20

In the xpad driver modifications below, the KP40D dongle (PID 0x515c) is
registered using the Vendor ID 0x20bc:

    { 0x20bc, 0x515c, "BETOP BTP-KP40D Xinput Dongle", ... }

If the device actually uses VID 0x20bc, applying the HID quirk to VID 0x20dd
in hid-quirks.c will prevent the HID_QUIRK_ALWAYS_POLL quirk from matching
the device. Which VID is the correct one for the KP40D?

[ ... ]

> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index 2da0b7f1722aa..ec511dc2e0806 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c

[ ... ]

> @@ -2150,6 +2159,41 @@ static int xpad_probe(struct usb_interface *intf, =
const struct usb_device_id *id
>  	xpad->irq_in->transfer_flags |=3D URB_NO_TRANSFER_DMA_MAP;
> =20
>  	usb_set_intfdata(intf, xpad);
> +	if (xpad->read_ms_os_desc) {
> +		/*
> +		 * Microsoft OS 1.0 sequence: first read the OS string
> +		 * descriptor at index 0xEE, then the Extended Compat ID
> +		 * descriptor. Some devices (e.g. 20bc:5158/5159) lock into
> +		 * XInput mode on the string descriptor read alone; others
> +		 * (e.g. 20bc:5126/515b) require the Extended Compat ID read.
> +		 * Send both to cover the whole family; each may fail on
> +		 * devices that do not implement it, which is harmless.
> +		 */
> +		error =3D usb_control_msg_recv(udev, 0,
> +					     USB_REQ_GET_DESCRIPTOR,
> +					     USB_DIR_IN,
> +					     (USB_DT_STRING << 8) | 0xee,
> +					     0x0000,
> +					     ms_os_desc,
> +					     sizeof(ms_os_desc), 25,
> +					     GFP_KERNEL);

[Severity: Medium]
Will this unconditionally fail and print spurious warnings in dmesg?=20

The usb_control_msg_recv() helper expects the USB device to return exactly
the number of bytes requested, otherwise it considers it a short read and
returns -EREMOTEIO.=20

Since the Microsoft OS string descriptor is typically 18 bytes and the feat=
ure
descriptor is usually 40 bytes, won't passing sizeof(ms_os_desc) (128 bytes)
for both requests cause them to always fail and trigger the dev_warn() paths
below?

> +		if (error)
> +			dev_warn(&intf->dev,
> +				 "unable to read Microsoft OS string descriptor: %d\n",
> +				 error);
> +
> +		error =3D usb_control_msg_recv(udev, 0, 0xee,
> +					     USB_TYPE_VENDOR | USB_DIR_IN |
> +						USB_RECIP_DEVICE,
> +					     0x0000, 0x0004,
> +					     ms_os_desc,
> +					     sizeof(ms_os_desc), 25,
> +					     GFP_KERNEL);
> +		if (error)
> +			dev_warn(&intf->dev,
> +				 "unable to read Microsoft feature descriptor: %d\n",
> +				 error);
> +	}
> =20
>  	/* Packet type detection */
>  	if (le16_to_cpu(udev->descriptor.idVendor) =3D=3D 0x045e) { /* Microsof=
t controllers */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_72D4D10513D=
FB685733F4F75EDA62F6EE107@qq.com?part=3D1
