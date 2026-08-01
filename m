Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2465630BB8D
	for <linux-input@vger.kernel.org>; Sat,  1 Aug 2026 08:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785571411; cv=none; b=D5+7LiIvfp+Tb7/RGr3Gz0akKlPrCV61zf61epzKT1UQTRItM2ZCWH3NspoPeHUfLhWhoIC4P9nKgMfCb1WT51RgQyWNgZqfJf8iCwTNAlp1P870oU1QBulmhD8jxXrVN7gVsmfHk4xLipA34nMfe8NPK2A40gEDN7BvK3dcRIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785571411; c=relaxed/simple;
	bh=9X4Lb7YEBk0c8zQC6PreHw2Ns9TJFfPBCq9MF2XDBas=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YTpDFHYm5snITAItu1G27pprCHslt2vaXsLBQnVyNHBoW8ajNF+mlNilRY4dwgBZ4OtczMUql9J2cqBHYMKTeX0Z6uBEv8/NUrnvhmHo1C6Cpx+3ODPVLxopElMnnMdBPS/HnZdWEoAFMaSeIghG7h5NaTEygH3tLP27XzUBAgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xz+6N/pu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xz+6N/pu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1AB11F00AC4;
	Sat,  1 Aug 2026 08:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785571409;
	bh=6XeBRIr9/240dB54xvWleEZiDsYo5D4kBuYkbQ0G+zA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xz+6N/pu8UH+rLgWPBHn8PtCPNiFkmz8wnMhpn0CZZophBezNGBUhrM1jKny52eFJ
	 QYccVS8ET6RLBQjAjz80BgSqaifQbZ3+Oc4QBKDjkjlpG6eUBYcDdXqHpvDLkprKUa
	 Hj6QAwMc4NIJWsuLBaFiJAKKLfSDTcINsPgaUHSqh3wHAZobOnwdTqITNMV7M3jMok
	 QGI9SyNtR8zISYMl28UfUeMxwZcO7ruhzCS9Wxp1EzFd9OpmA3nlg1GwpDE/4/upKH
	 grtEdLnimBtACvgIygXC77XrZin2h0VsYGlOSdvghQVxz3s3aTsLirVGpm/Bpou2fs
	 guj/GSFR8IiEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] Input: xpad - query MS OS descriptor for
 BTP-KP20D
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Ma" <mapengyu@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260801075623.2769601-1-mapengyu@gmail.com>
References: <20260801075623.2769601-1-mapengyu@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 08:03:29 +0000
Message-Id: <20260801080329.B1AB11F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] The variable `error` holds positive values on success, violating su=
bsystem naming conventions.
- [Low] Missed opportunity to use modern cleanup primitives for the descrip=
tor buffer.
--

--- Patch [1]: [PATCH v2 1/2] Input: xpad - query MS OS descriptor for BTP-=
KP20D ---
commit eab43c4126d684c849995489e35829f7af7fb51c
Author: Aaron Ma <mapengyu@gmail.com>

Input: xpad - query MS OS descriptor for BTP-KP20D

This commit adds a quirk to query the MS OS descriptor for the Beitong
BTP-KP20D dongle during probe. This allows the device to stay in Xbox 360
mode.

> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index feb8f368f834e..1616047e65f5e 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
[ ... ]
> @@ -786,6 +788,24 @@ static int xpad_start_input(struct usb_xpad *xpad);
>  static void xpadone_ack_mode_report(struct usb_xpad *xpad, u8 seq_num);
>  static void xpad360w_poweroff_controller(struct usb_xpad *xpad);
> =20
> +static void xpad_query_ms_os_descriptor(struct usb_device *udev)
> +{
> +	u8 *descriptor;
> +	int error;

[Severity: Low]
This isn't a bug, but does the error variable receive a positive value here?
The input subsystem maintainer prefers that variables named error or err
should only hold negative error codes or 0 for success. Since
usb_get_descriptor() returns the number of bytes transferred on success,
perhaps a different variable name would be better?

> +
> +	descriptor =3D kmalloc(18, GFP_KERNEL);

[Severity: Low]
This isn't a bug, but could this use the __free(kfree) primitive for
the allocation to automate cleanup and remove the explicit kfree(descriptor)
below, as encouraged by the maintainer preferences for new code?

> +	if (!descriptor)
> +		return;
> +
> +	error =3D usb_get_descriptor(udev, USB_DT_STRING, 0xee,
> +				   descriptor, 18);
> +	if (error !=3D 18)
> +		dev_warn(&udev->dev,
> +			 "unable to query MS OS descriptor: %d\n", error);
> +
> +	kfree(descriptor);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801075623.2769=
601-1-mapengyu@gmail.com?part=3D1
