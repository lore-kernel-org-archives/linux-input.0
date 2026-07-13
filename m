Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2F923C4FA
	for <linux-input@vger.kernel.org>; Mon, 13 Jul 2026 22:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783981040; cv=none; b=nz1/7xvzkUlVjOvTca76kyUgw9xK+uRVSoypWTYXbXwByARD2L/NEBXq0+AlXvfkGFZAdSwBlJMzOs6BCLXukyugoJtFzT697SFUFRuaMc1ps4XySNDuydhN90jzcHIGBm7BYttKYLrw+fse3dzaM2ED9mrRGpoDunvt8eSSYcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783981040; c=relaxed/simple;
	bh=cQ2tb6TSOiw9qLU6dSDlQ+GmdH0ePq+RDEjmrjbh/tc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t6o1uVha3dvcU4mpdupT1NRhLIx9hbug6V97ClErkDxf0Vqiixmusbso7PtXio0SbgY2VTg/l1oTKNf0ZNFbqxoKOXHQpYArNIXSpB1KSv4+WO8frhsCFs2ZxJFktjNpCgXPxkG1TEqQp3A79xbxBPYcoN9uYzR9CccwU1tT6RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPsKeetN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPsKeetN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B23C91F000E9;
	Mon, 13 Jul 2026 22:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783981038;
	bh=yXIVVWHXHe7S1dj08XxVFxewQa1RzCgUheUnVMDBJt0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bPsKeetN6Lv/aMp9ymtd+V4jGrNgM6/kpeXFUyshp1fSiYuGi+r1+8sq5OvnCp2HB
	 Ak2tFTiNmq4s3epNvl0tNlaGHRNeo85CbgZtm4UMtscWKBWOuGaPirpbhHV9SWxq3S
	 w4tVA/lqyveG0SQt+Pfr5lg2C23zLNIdPCwzMgzXOGS2O5EFWILoSoCVsSGhfKTtxI
	 KYB2EIM+w33Dy7hbtD4zhR/9XauRD1U4tli0WH5qSjtu8Ire8i+MMqhjAwdt6BZrcE
	 rWtLmVyjqc5mRg+YhMkFX1km+Ap+P/yYw99pGadxrfplYWKWKJpR5G9Pt4tGglen9q
	 rP1WCSQ6N6Q/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] HID: uclogic: fix UAF on inrange_timer at
 teardown and probe error
Reply-To: sashiko-reviews@lists.linux.dev
To: "Doruk Tan Ozturk" <doruk@0sec.ai>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260713215950.24193-1-doruk@0sec.ai>
References: <20260713215950.24193-1-doruk@0sec.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 22:17:18 +0000
Message-Id: <20260713221718.B23C91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-After-Free on `drvdata->pen_input` during input registration f=
ailure.
- [Medium] Memory leak of `drvdata->desc_ptr` on probe error path.
--

--- Patch [1]: [PATCH v3 1/2] HID: uclogic: fix UAF on inrange_timer at tea=
rdown and probe error ---
commit 2397dc01e99d0cc8ef59607ebbc881c2a6cb3354
Author: Doruk Tan Ozturk <doruk@0sec.ai>

HID: uclogic: fix UAF on inrange_timer at teardown and probe error
   =20
uclogic_probe() arms a per-device timer whose callback
uclogic_inrange_timeout() dereferences drvdata->pen_input, and
uclogic_raw_event_pen() re-arms it with a 100 ms timeout on every
in-range pen report.

[ ... ]

> diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-cor=
e.c
> index b73f09d26688a..d74f98efa8794 100644
> --- a/drivers/hid/hid-uclogic-core.c
> +++ b/drivers/hid/hid-uclogic-core.c
> @@ -267,6 +267,13 @@ static int uclogic_probe(struct hid_device *hdev,
>  	/* Assume "remove" might not be called if "probe" failed */
>  	if (params_initialized)
>  		uclogic_params_cleanup(&drvdata->params);

[Severity: Medium]
This is a pre-existing issue, but does this error path leak the dynamically
allocated replacement report descriptor buffer?

In uclogic_probe(), uclogic_params_get_desc() allocates a concatenated repo=
rt
descriptor and assigns it to drvdata->desc_ptr. If subsequent operations su=
ch
as hid_parse() or hid_hw_start() fail, the code jumps to the failure path.

The cleanup logic calls uclogic_params_cleanup(&drvdata->params), which fre=
es
params->desc_ptr, but it does not free drvdata->desc_ptr.

(Note: The commit message claims a 2/2 patch fixes this, but that patch is
absent from the provided repository state at the end of the series).

> +	/*
> +	 * If hid_hw_start() started I/O and then failed, raw_event may have
> +	 * armed the timer; shut it down so it cannot fire on the devm-freed
> +	 * drvdata after probe returns.
> +	 */
> +	if (drvdata)
> +		timer_shutdown_sync(&drvdata->inrange_timer);

[Severity: High]
This is a pre-existing issue, but can this lead to a Use-After-Free on
drvdata->pen_input if input registration fails?

During uclogic_probe(), hid_hw_start() calls hid_connect() which attempts to
register input devices via hidinput_connect(). As part of this process,
uclogic_input_configured() assigns the allocated input_dev to
drvdata->pen_input:

drivers/hid/hid-uclogic-core.c:uclogic_input_configured() {
    ...
    if (hi->report->id =3D=3D params->pen.id) {
        /* Remember the input device so we can simulate events */
        drvdata->pen_input =3D hi->input;
    }
    ...
}

If input_register_device() fails, the code unwinds and frees the input_dev
structure via hidinput_disconnect(), but drvdata->pen_input is never cleared
and remains dangling.

Because the uclogic_driver defines a raw_event callback, hid_connect() still
returns success (0) even if no listeners successfully claimed the device.
Consequently, hid_hw_start() and the driver probe succeed.

If the USB device subsequently sends an in-range pen report,
uclogic_raw_event_pen() rearms inrange_timer. When the timer expires,
uclogic_inrange_timeout() unconditionally dereferences the dangling
drvdata->pen_input pointer:

drivers/hid/hid-uclogic-core.c:uclogic_inrange_timeout() {
    ...
    struct input_dev *input =3D drvdata->pen_input;

    if (input =3D=3D NULL)
        return;
    input_report_abs(input, ABS_PRESSURE, 0);
    ...
}

>  	return rc;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713215950.2419=
3-1-doruk@0sec.ai?part=3D1
