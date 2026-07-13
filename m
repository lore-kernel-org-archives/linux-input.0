Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949D6385D84
	for <linux-input@vger.kernel.org>; Mon, 13 Jul 2026 22:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783980761; cv=none; b=IsxoamOXdoBsirnhoqQrMt7g0fK+RIQoNJ6f/dan1jokxEQtMBxgsOR9392OfVxCbTZOfh28zI0SuI5ii+h0TTZKCVdicGPw0AZXu7xRULNe6wxKBFbROltJaj7/irMuoB7c46TCgGxW2MXVWNFPopUXMkDQWSD7VBUpnDGw5qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783980761; c=relaxed/simple;
	bh=Cyc/eQUHr3nfr+EkFW0KLU5IJiiuNu4NiAINWsXXx70=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mrvvyOFv+p+GaZcDwMlUT7BNBZkwQ3p6q2asJrZ6HFA8/WuVz6aDPzOzxPYuaEAvnjJqy9dGvCSeB+fybfOlyMQ7shfloV9gHw8ABLEb2ObbnF3yTHReCuL7EBAFHHJmUd/v1Y1BifVbS5OcUefIwinMI2y9QT8U1qqAPLlF4Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mCWbfsu1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mCWbfsu1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 103E61F000E9;
	Mon, 13 Jul 2026 22:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783980760;
	bh=rbpUdOEiH7mzSxN9M0yAwvS9qQpeBevDZXz/sLpdf58=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mCWbfsu1vc6t74iMH3538lq5EGKokJyWbvy4rtU7lKFt/vtqyHi1z66aSL344tH/x
	 17l/scPLMC1noqjWKeZqU+8+BJLRKTsyaoHR2A2Q3C3SI2BA6er9IMGoJhf3AyC9oW
	 frNICWNM0DZVXY7+uI9nlcTtrxh6uaels4bINxIVqJy0Z/Hj9Y1/PObR5l5EvNF4V3
	 kXlkHS7YAKTO8LEaQYWyNw78ou9H0adIEypVIE5D8XPIECG9jOX1dUUTbxdT5yoBBH
	 v1r4f1ryGi8rSrifmgfM2ZsJf4KGBIa7Q3A3pYiv/fC+9/pebQKEAb/DlwDQQI56eb
	 SghjTLDRiDO9w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] HID: uclogic: fix desc_ptr leak in probe error
 path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Doruk Tan Ozturk" <doruk@0sec.ai>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260713215950.24193-2-doruk@0sec.ai>
References: <20260713215950.24193-1-doruk@0sec.ai>
 <20260713215950.24193-2-doruk@0sec.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 22:12:39 +0000
Message-Id: <20260713221240.103E61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-After-Free of `drvdata->pen_input` in `uclogic_inrange_timeout=
()` when `hidinput_connect()` fails during probe.
--

--- Patch [2]: [PATCH v3 2/2] HID: uclogic: fix desc_ptr leak in probe erro=
r path ---
commit b37d55bfcac132529f188bc93436f75e1da9c66f
Author: Doruk Tan Ozturk <doruk@0sec.ai>

HID: uclogic: fix desc_ptr leak in probe error path

This commit fixes a memory leak in the uclogic_probe() error path. It
ensures that drvdata->desc_ptr is explicitly freed when probe fails, since
the normal cleanup in uclogic_remove() is not called in this scenario.

> diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-cor=
e.c
> index d74f98efa8794..ad9914ed0c717 100644
> --- a/drivers/hid/hid-uclogic-core.c
> +++ b/drivers/hid/hid-uclogic-core.c
> @@ -265,8 +265,10 @@ static int uclogic_probe(struct hid_device *hdev,
>  	return 0;
>  failure:

[Severity: High]
This is a pre-existing issue, but is there a use-after-free risk involving
drvdata->pen_input if hidinput_connect() fails during hid_hw_start()?

During probe, uclogic_input_configured() (drivers/hid/hid-uclogic-core.c)
stores a pointer to the input device before registration completes:

		/* Remember the input device so we can simulate events */
		drvdata->pen_input =3D hi->input;

If a subsequent input registration fails in hidinput_connect()
(drivers/hid/hid-input.c), the code unwinds and frees all inputs:

out_unwind:
	/* unwind the ones we already registered */
	hidinput_disconnect(hid);

	return -1;

Because the driver sets .raw_event, hid_connect() ignores this -1 return
value. As a result, hid_hw_start() returns 0, the driver binds successfully,
and this failure block is bypassed.

When a pen report later arrives and arms drvdata->inrange_timer, the timer
callback uclogic_inrange_timeout() dereferences the freed pointer:

	struct input_dev *input =3D drvdata->pen_input;

	if (input =3D=3D NULL)
		return;
	input_report_abs(input, ABS_PRESSURE, 0);

Could this sequence lead to a dangling pointer being dereferenced?

>  	/* Assume "remove" might not be called if "probe" failed */
> -	if (params_initialized)
> +	if (params_initialized) {
> +		kfree(drvdata->desc_ptr);
>  		uclogic_params_cleanup(&drvdata->params);
> +	}
>  	/*
>  	 * If hid_hw_start() started I/O and then failed, raw_event may have
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713215950.2419=
3-1-doruk@0sec.ai?part=3D2
