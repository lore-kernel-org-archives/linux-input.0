Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28AF2DCBE3
	for <linux-input@vger.kernel.org>; Fri,  3 Jul 2026 16:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783094540; cv=none; b=nNfc38iep9U+8mGLmkdkkq3UBYmCrx47KaPjWR+NEhxPGUt/c9N/DLL6MXmOuySGSxMDjvhxYEeKzWRcdg4OqXlcgd5hXMnfEKdkge5md3vKkjP6du1p+E+v+Lf1MGXqubOGcGcecE5HnXvLo/VIrpNxA2TvBcWuYlldkchTiJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783094540; c=relaxed/simple;
	bh=53fG8RWkSbejkdRs/lHUYYfNIcaX6ciivYyVWTIcsyA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MOulSpqMDj+n0enpPwgIq943VKk3vaIgNYR2bYcRojPL/SkVvI06yp3v8gKCjAw5Skp6fEsCyNHyW4TAMrZAuS7p934t3XebtcCY7MyHLH7PCQdPE64BGdvhZJTp97U91Ef/fg+OVZeomghVUmWU9zDbAMysABQAA/Mzk0idxpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TCD6jQNl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TCD6jQNl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17EFE1F000E9;
	Fri,  3 Jul 2026 16:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783094538;
	bh=78DeKYNKFlK3lpGQEy7gOqv1L26gf02NltzsKQo0K94=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TCD6jQNlvWXkQspjf5P1Yashcq3unSyCTR13PQVWx564vCAbCQD0Siy9DqUFNcGth
	 uqTLKC3GzvI4SkCE/L33WaoIKgPA+SSq8lgmz1/f94YlWpUclze+8PCK7+zkJctygg
	 riIScN80k72sIkGK1QxBrwpk4NYzcpGi69AW+IxFYMbLqFRu29U1FwI3MczKwtUNaM
	 7sznmf4p1Yo8Ksyc+sv+hFVQoF/SZqsqdHmuHKv4PR5LLCoZmv+kR5qfp9V1lqOA9z
	 13aIzeiO5X7meDT98Gda0LGzCKrgeFX0ekrhTerKwiAy76aeVNgyJuxz66zyjFdyXj
	 WRBp8GSB2wamQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] HID: rapoo: fix missing hid_is_usb() check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jann Horn" <jannh@google.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260703-hid-usbcheck-v2-3-c5ed7bc94772@google.com>
References: <20260703-hid-usbcheck-v2-0-c5ed7bc94772@google.com>
 <20260703-hid-usbcheck-v2-3-c5ed7bc94772@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 16:02:17 +0000
Message-Id: <20260703160218.17EFE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing hid_hw_stop() cleanup on error paths in rapoo_probe() caus=
es hardware resource leaks and a Use-After-Free.
--

commit ed7992bab1a88e74142aa29aa65b4061257a86cb
Author: Jann Horn <jannh@google.com>

HID: rapoo: fix missing hid_is_usb() check

This commit adds a hid_is_usb() check before calling to_usb_interface() to
handle uhid devices reporting BUS_USB without an actual USB parent. It also
adds a USB_HID dependency for hid_is_usb().

[ ... ]

> diff --git a/drivers/hid/hid-rapoo.c b/drivers/hid/hid-rapoo.c
> index 4c81f3086de43..5c9c396fabf77 100644
> --- a/drivers/hid/hid-rapoo.c
> +++ b/drivers/hid/hid-rapoo.c
> @@ -36,7 +36,7 @@ static int rapoo_probe(struct hid_device *hdev, const s=
truct hid_device_id *id)
>  		return ret;
>  	}
> =20
> -	if (hdev->bus =3D=3D BUS_USB) {
> +	if (hid_is_usb(hdev)) {
>  		struct usb_interface *intf =3D to_usb_interface(hdev->dev.parent);
> =20
>  		if (intf->cur_altsetting->desc.bInterfaceNumber !=3D 1)

[Severity: High]
This is a pre-existing issue, but are we missing hid_hw_stop() calls on the
error paths later in rapoo_probe()?

If devm_input_allocate_device() fails, the code returns -ENOMEM directly:

	input =3D devm_input_allocate_device(&hdev->dev);
	if (!input)
		return -ENOMEM;

Similarly, if input_register_device() fails, it returns the error:

	ret =3D input_register_device(input);
	if (ret)
		return ret;

When returning these errors after hid_hw_start() has succeeded, the HID core
probe fails and sets hdev->driver to NULL, but hid_hw_stop() is never called
to stop the hardware and kill active URBs.

When the device is later unplugged, usbhid_disconnect() frees the usbhid
structure, but skips hid_hw_stop() because hdev->driver is NULL.

Because active USB URBs are not killed, when the USB core later flushes the
endpoints and cancels the URBs, the completion handler hid_irq_in() attempts
to clear state bits in the already-freed usbhid structure, like calling
clear_bit(HID_IN_RUNNING, &usbhid->iofl).

This results in a use-after-free write memory corruption. While this requir=
es
local physical access to the USB port and specific conditions like memory
pressure to induce a probe failure, it guarantees memory corruption when
triggered.

Would it be better to add an error label that calls hid_hw_stop() when the
input device allocation or registration fails?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703-hid-usbche=
ck-v2-0-c5ed7bc94772@google.com?part=3D3
