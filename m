Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F64B4189A0
	for <linux-input@vger.kernel.org>; Fri,  3 Jul 2026 15:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783092587; cv=none; b=VQe+wVJeCzjgYdkqMnLTqHjmyoC61ct628h14qYCqOdqwYmJ1yZySlGk5AfBlGYITkhwHBeKJDAuklSf/mGkZ109x9R3u8HUHtT67HEUOi+CxvOLePAyyFr23aPds7JW6aJRAMmwSGEKPIJ71tuyqvPPxpxSNzOtL2HpruqHZdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783092587; c=relaxed/simple;
	bh=v/48TgxIU5C4YaGEkVowV7w8OE7prCzXNYDX803/WEA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n0rH8F7romPQfe5UdtbTMaf8OObsCFhhPoxrfr1aLsCx7y/+Kp7Mo5NF762oJTVj91UwYTiB0Er48cvOOLVa6K1AJWu4Z1LSMMPVyaQYnTQTYhlqHz0Rs6O9GCsWNqJjKosb5eYNC33TecNQ4bxLZ5zr2swqqcYdVv3VctBSXGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONNXCATs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONNXCATs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E4681F000E9;
	Fri,  3 Jul 2026 15:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783092585;
	bh=YQzB3vs7+EDwC1ihPcYw37KNoZm1BHWgkFRFZ3yj9mI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ONNXCATsE2MfXE+o6YPULlU1yEXzi042oq21ifKKmoKCuOk+U+Ur1ZDH6VwYWUbhl
	 eqczT+ah2paWSDFRxfP8tybT6kNsGVOo8Vdkxuwg2Gttltomu/3bMLm5zFEtBcv/0V
	 g4lf/EwcmJlfXoiQSwBZCvbnh29RKtDS4bfodFWw+Fyu6ucCvo8obEEHfPS0ddzQeU
	 6X4miAuAWq/cT33Tiy6EP3BGujvX74CVGpDi/sU6fwVVlzgY1b1MMT46J5zphsTUP1
	 srp/WElU/j5XKZPPz6So96cAgsnrwVcFOtSic9WBTzjzUPw501MWgq7n74TyoHg+a+
	 yaYpUpjthommw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] HID: rapoo: fix missing hid_is_usb() check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jann Horn" <jannh@google.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260703-hid-usbcheck-v1-3-e80259ff625d@google.com>
References: <20260703-hid-usbcheck-v1-0-e80259ff625d@google.com>
 <20260703-hid-usbcheck-v1-3-e80259ff625d@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 15:29:45 +0000
Message-Id: <20260703152945.8E4681F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] Missing Kconfig dependency `depends on USB_HID` for `CONFIG_HID_RAP=
OO` causes a linker error.
- [Low] Malformed `Fixes:` tags in the commit message.
--

commit ac5c5d7fc93db76e1ff4b587da9d47600a05ff83
Author: Jann Horn <jannh@google.com>
HID: rapoo: fix missing hid_is_usb() check

This commit fixes a potential splat by verifying a HID device is actually on
a USB bus before casting its parent to a usb_interface.

>     I have verified that it is currently possible to trigger a kernel spl=
at due
>     to this bug in an ASAN build, and that this commit fixes the issue.
>    =20
>     Fixes: 00e005c952f7 ("hid-asus: check ROG Ally MCU version and warn")=
Fixes: b3b1c68fb726 ("HID: rapoo: Add support for side buttons on RAPOO 0x2=
015 mouse")

[Severity: Low]
This isn't a bug, but there are two Fixes tags concatenated on the same lin=
e.

Could this break automated patch parsing tools and stable backporting scrip=
ts
that expect each tag to be on a separate line?

>     Cc: stable@vger.kernel.org
>     Signed-off-by: Jann Horn <jannh@google.com>
>=20
> diff --git a/drivers/hid/hid-rapoo.c b/drivers/hid/hid-rapoo.c
> index 4c81f3086de43..5c9c396fabf77 100644
> --- a/drivers/hid/hid-rapoo.c
> +++ b/drivers/hid/hid-rapoo.c
[ ... ]
> @@ -36,7 +36,7 @@ static int rapoo_probe(struct hid_device *hdev, const s=
truct hid_device_id *id)
>  		return ret;
>  	}
> =20
> -	if (hdev->bus =3D=3D BUS_USB) {
> +	if (hid_is_usb(hdev)) {

[Severity: Low]
Does the introduction of hid_is_usb() in rapoo_probe() require an update to
the CONFIG_HID_RAPOO entry in drivers/hid/Kconfig?

Because hid_is_usb() is defined and exported exclusively by the usbhid modu=
le,
if a user configures the kernel with CONFIG_HID_RAPOO=3Dy and CONFIG_USB_HI=
D=3Dn
(or m), will this cause a build failure during the linking stage due to an
undefined reference?

Should CONFIG_HID_RAPOO now explicitly depend on USB_HID?

>  		struct usb_interface *intf =3D to_usb_interface(hdev->dev.parent);
> =20
>  		if (intf->cur_altsetting->desc.bInterfaceNumber !=3D 1)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703-hid-usbche=
ck-v1-0-e80259ff625d@google.com?part=3D3
