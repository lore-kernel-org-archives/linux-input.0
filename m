Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B7C2DC792
	for <linux-input@vger.kernel.org>; Thu,  4 Jun 2026 05:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780550065; cv=none; b=ULupw+/SYFrlnuRdwytH24g5jBk9MfgNps81aKQUjWBaKGXczDOkB7VvXvLFQGlgx3lAwr25IUMDQMdU8mS6y3PZQ5Y09eyspQipodbaJwY9uHYAScqj9xFxEdTANXLGmUyXU7aYX3N5wEjkvtLRaMblfUxnH6dBsVa9fFuiPFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780550065; c=relaxed/simple;
	bh=6SkDHHPgobO7TsXAofo5zJj6ZM01X4Pd1BufyTEMe8U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=baMOSl1CnTCUvO7E0TC0jIzH00CJn14W3OLWQTPRYqI3vzP9DWyVjsa0QzFcBg1Tm5UTHz7k/50MlVLtKMWdWVG9/7QErfF8tYU2vvTS+rzLTuspm8GqXfTgVeU/LhhJwwJbBRG9Bqc68tDpmZQGWcbLDNe3mwSol4yESpi4QXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mt0035dm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mt0035dm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C521F00893;
	Thu,  4 Jun 2026 05:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780550063;
	bh=orS1Sg9hZ+S6wAyZkIix7tA0MdJ8QwAj9X+0zAtoDZk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mt0035dmsaUvxU11Zr2Eg4xbQox2Xq4bmCF/Cl+g65zL0WCMB11vs4rGJY2ueWvHy
	 Ub+H7jYaodmOwKFnrapikk6f3kAUxNP0fLOKLwINbX9xpqCDtCHliy6+Tq4yC2HqgT
	 +1uUBAvSfxMVGqeIqlaiBlE2wbOFR1h/LjnUYs1K6XET50YxMBwnfRylH/TzrkTnax
	 va7II1zD3heE+4Ig7tfuOxMBiJNC/QaFQXm1097X/jysJIr7cIGw2tnu03i9aHeHvk
	 5j1whv8CQskh/jOgSvyibz3tSsf+6r7pIXUIxky9ije5aqewUkqB1MDfu76qu4D9l6
	 K4cBS1K+DGsXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] HID: wacom: stop hardware after post-start probe
 failures
Reply-To: sashiko-reviews@lists.linux.dev
To: "Myeonghun Pak" <mhun512@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260604045710.25512-1-mhun512@gmail.com>
References: <20260604045710.25512-1-mhun512@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 05:14:23 +0000
Message-Id: <20260604051423.B0C521F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Failing to cancel scheduled delayed works and timers on the probe =
error path leads to a Use-After-Free when the `wacom` structure is freed.
- [High] Nullifying input pointers in `wacom_register_inputs` before stoppi=
ng the hardware leaves a race window where incoming interrupts can cause a =
NULL pointer dereference.
- [High] Hardware interrupts can arrive before `wacom->remote` is allocated=
, causing a NULL pointer dereference in the IRQ handlers.
--

commit 517a367ac93aa0d6c6470c3a21cdb477449345e3
Author: Myeonghun Pak <mhun512@gmail.com>
Subject: HID: wacom: stop hardware after post-start probe failures

This patch routes post-hid_hw_start() failures in wacom_parse_and_register()
through hid_hw_stop() before releasing driver resources. This ensures that =
the
HID hardware is properly stopped before the wacom resources are freed.

> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 2220168bf1164..252771dcfd8f8 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -2462,16 +2462,16 @@ static int wacom_parse_and_register(struct wacom =
*wacom, bool wireless)
> =20
>  	error =3D wacom_register_inputs(wacom);
>  	if (error)
> -		goto fail;
> +		goto fail_hw_stop;

[Severity: High]
This is a pre-existing issue, but does this leave a small race window where
an interrupt could cause a NULL pointer dereference?

If wacom_register_inputs() fails, its error path sets the input pointers to
NULL:

    fail:
        wacom_wac->pad_input =3D NULL;
        wacom_wac->touch_input =3D NULL;
        wacom_wac->pen_input =3D NULL;
        return error;

The code then jumps to fail_hw_stop. Since hid_hw_start() has already been
called, the hardware is active. Could an interrupt arrive before hid_hw_sto=
p()
completes, triggering an IRQ handler like wacom_intuos_irq() which
dereferences wacom->pen_input without checking for NULL?

> =20
>  	if (wacom->wacom_wac.features.device_type & WACOM_DEVICETYPE_PAD) {
>  		error =3D wacom_initialize_leds(wacom);
>  		if (error)
> -			goto fail;
> +			goto fail_hw_stop;
> =20
>  		error =3D wacom_initialize_remotes(wacom);
>  		if (error)
> -			goto fail;
> +			goto fail_hw_stop;

[Severity: High]
This is a pre-existing issue, but I have a question about how this handles
interrupts arriving before initialization is complete.

Since hid_hw_start() is called prior to wacom_initialize_remotes():

    error =3D hid_hw_start(hdev, connect_mask);
    ...
    error =3D wacom_initialize_remotes(wacom);

Could an early hardware event or a malicious USB report arrive and trigger
wacom_remote_irq() or wacom_remote_status_irq()? Those handlers appear to
dereference wacom->remote to acquire a spinlock:

    spin_lock_irqsave(&remote->remote_lock, flags);

If the interrupt arrives before wacom_initialize_remotes() has allocated
wacom->remote, would this lead to a NULL pointer dereference?

[ ... ]

> @@ -2501,7 +2501,7 @@ static int wacom_parse_and_register(struct wacom *w=
acom, bool wireless)
> =20
>  	return 0;
> =20
> -fail_quirks:
> +fail_hw_stop:
>  	hid_hw_stop(hdev);
>  fail:
>  	wacom_release_resources(wacom);

[Severity: High]
This isn't a bug introduced by this patch, but it seems there might be a
pre-existing issue with pending works on the error path.

If wacom_query_tablet_data() is called earlier:

    wacom_query_tablet_data(struct wacom *wacom)
    {
        schedule_delayed_work(&wacom->init_work, msecs_to_jiffies(1000));
    }

And then a subsequent step like hid_hw_open() fails, we jump to fail_hw_stop
which stops the hardware and releases resources:

    fail_hw_stop:
        hid_hw_stop(hdev);
    fail:
        wacom_release_resources(wacom);
        return error;

Since the error is returned to wacom_probe() which can cause the devres core
to free the wacom structure, could the uncancelled wacom->init_work (or oth=
er
works/timers scheduled by interrupts) execute later and dereference the fre=
ed
wacom memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604045710.2551=
2-1-mhun512@gmail.com?part=3D1
