Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA281F942
	for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 04:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785299497; cv=none; b=Bq6qvQidbIPZ3htAnOJMETqUZYoU5RcIs6MFRil4JItyVk6NyZdePzM/aLvLoUyrKNDwIdedtFGPzz1k/kRZYFW64VGSGl4anOM0U7Ql5jBt/KP1t5/CKq6LyH83sSULRfWZGrJA3aWvus22P89lFgKDIvDwn/AGQMQs5qv1R0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785299497; c=relaxed/simple;
	bh=P5sTulE7R+tBbhwrdXaVr581dRuYEoEJg0dMQBoU5AE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OoGtx7HwCQgmTVeuhsx31fM2C2mKOYUgLMw+ghSv7lPypKsp3lUXjLW07KSJO6cOjhjf7uLLggnUdFNITzJFO+5eTR9HoJWMk6ij/LJSDaFcMKalsCQBhK35zsi7PoxGP+9F9LTTH7PV564NfnGGZmzC+LlJfx8UeqzEA3kU9zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLvIJh0k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLvIJh0k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D4A51F000E9;
	Wed, 29 Jul 2026 04:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785299495;
	bh=/5wQCx085KuoRDdtIGKADIqTXNmS8MSiDTiUh2by128=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eLvIJh0kGRAnmSVClvrj8ef+PQ+U9wT2raZfE2ZDm8qa4kD+ySr0sSp/+teZt0YMN
	 FShMVzB8b0IFG41as/cBZS73TrjGSMEX+5+m/TF7V6e0o3mkYhHIR4ILwqSCFABpQP
	 96PMqpJzI8eF3GQDht95zFUDJ5GJ2zIbKKP1DdGagrW/vcNSsA6H0DYePuGa+KKani
	 chcJzFFVZlNodbJbKT/qen4QRE6OfmXcIt0yo1utDSgxX70NgIt27JD7wZ0ERQXpFl
	 etTrDBvqakKAbOdNLeleMLEx5ohyJ41O3yNn9DvP1kvsvEETbchbaBGogr3ZIzOILH
	 8/g+y1XJEB3VA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: magicmouse: do not keep a stale msc->input if no
 input is claimed
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?Sm9zZSBWaWxsYXNlw7FvciBNb250Zm9ydA==?= <pepemontfort@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260729041557.1185819-1-pepemontfort@gmail.com>
References: <20260729041557.1185819-1-pepemontfort@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 04:31:35 +0000
Message-Id: <20260729043135.9D4A51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Deterministic NULL pointer dereference in event handlers after a f=
ailed input registration.
--

--- Patch [1]: [PATCH] HID: magicmouse: do not keep a stale msc->input if n=
o input is claimed ---
commit 6fea999082f28bca408072a6788f3616b0ebbd9f
Author: Jose Villase=C3=B1or Montfort <pepemontfort@gmail.com>

HID: magicmouse: do not keep a stale msc->input if no input is claimed

This patch clears msc->input when the HID core does not claim an input
device. This is intended to ensure existing NULL checks safely handle the
failure path where hidinput_connect() frees the input devices.

Link: https://lore.kernel.org/linux-input/20260728185542.65F091F000E9@smtp.=
kernel.org/

> diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
> index 802a3479e24b9..2f14094a63b1e 100644
> --- a/drivers/hid/hid-magicmouse.c
> +++ b/drivers/hid/hid-magicmouse.c
> @@ -900,6 +900,16 @@ static int magicmouse_probe(struct hid_device *hdev,
>  		return ret;
>  	}
> =20
> +	/*
> +	 * When hidinput_connect() fails it frees every input device it
> +	 * created, but that does not fail hid_hw_start(): the core simply
> +	 * does not claim an input. msc->input, cached in ->input_mapping
> +	 * while the report descriptor was parsed, would then be a dangling
> +	 * pointer that passes every NULL check. Trust the core's claim.
> +	 */
> +	if (!(hdev->claimed & HID_CLAIMED_INPUT))
> +		msc->input =3D NULL;
> +

[Severity: High]
If msc->input is set to NULL here due to a failure, could this cause a NULL
pointer dereference for certain USB devices?

Looking further down in magicmouse_probe(), there is an early return on
success for specific devices that bypasses the failure check:

drivers/hid/hid-magicmouse.c:magicmouse_probe() {
    ...
    if (!(hdev->claimed & HID_CLAIMED_INPUT))
        msc->input =3D NULL;
    ...
    if (is_usb_magicmouse2(id->vendor, id->product) ||
        (is_usb_magictrackpad2(id->vendor, id->product) &&
         hdev->type !=3D HID_TYPE_USBMOUSE))
        return 0;

    if (!msc->input) {
        hid_err(hdev, "magicmouse input not registered\n");
        ...
}

If the probe succeeds by returning 0, the driver remains bound.

When an input report is later received, will magicmouse_raw_event() and
magicmouse_event() unconditionally dereference the NULL msc->input pointer?

For example, looking at magicmouse_raw_event():

drivers/hid/hid-magicmouse.c:magicmouse_raw_event() {
    ...
    struct input_dev *input =3D msc->input;
    ...
    if (input->id.product =3D=3D USB_DEVICE_ID_APPLE_MAGICMOUSE ||
    ...
}

And similarly in magicmouse_event():

drivers/hid/hid-magicmouse.c:magicmouse_event() {
    ...
    struct magicmouse_sc *msc =3D hid_get_drvdata(hdev);
    if ((msc->input->id.product =3D=3D USB_DEVICE_ID_APPLE_MAGICMOUSE2 ||
    ...
}

>  	if (is_usb_magicmouse2(id->vendor, id->product) ||
>  	    is_usb_magictrackpad2(id->vendor, id->product)) {
>  		timer_setup(&msc->battery_timer, magicmouse_battery_timer_tick, 0);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729041557.1185=
819-1-pepemontfort@gmail.com?part=3D1
