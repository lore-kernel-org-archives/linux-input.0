Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF0230C157
	for <linux-input@vger.kernel.org>; Wed, 12 Aug 2026 20:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786565595; cv=none; b=NdAVWF/cOLxkduf8TSurM4+uegg9uBzAiZ7bdlnC/JgoC8L98KVwtM4ojB2EhMRhI8agX2tY0MvFnf7CU7wOyMPE3xQgcXRaCTbnbFj3as+8+BTwLLj1fIH1mm4pBvXZQxuOlxHYbW8Kmw3/dB2xIYKmfkKg1ArPHdLiVkwleC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786565595; c=relaxed/simple;
	bh=79MhkQR2oB1UBHHzUCWBLwUkgf+A2zQxY3zkMi2ti+k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V4i7Na46hNvDshiLA7+g+TRzTs3T8AY0zFEoErR9iPe13etpSacuv5EAstBT2C/13ylzjGgz9Q3huYcy/sfqgNDuY+gWsUprBM6rAJrm0D3BCsJkdhGXdYHzAijbiQYuB/J4kM2Gvo9DZtdMsmtFB4ZhdPChhB+X/lxWN60if8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nScC5O35; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nScC5O35"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E1E01F00A3A;
	Wed, 12 Aug 2026 20:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786565592;
	bh=rLIjThABWqZNAzncb7zp9TVBpIsCq6z3F7znF0Wcpy4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nScC5O35ZJ1LT8JwRPAKAnZO89dF+HSDrAk3tenm/f3uDQPH4aM+o7+c+QP4Ts3lB
	 aBSobGyaFeia85jF9Qi29l0jXkrZE6lUMETgRy/PbGKGn5WqBDMcH3Ie9o2sPa/Z6g
	 ZvSLM2tyXbdh1tMhEToqMdnOYaosQ6w/YNU8F7gzgI3/OyOaYzRi13O2/Sv7+jxKye
	 MTxfj9hDOb8yCZpd17BH+3s43AVHoYs0/L4CsR+U5jfCmgaYFcGsPeGZ9hW4T1Ezid
	 HuBp/MyDp1hjOhAcLbDg1wHR32bUTxlbG6DpvdZZBdSaD2Sq6nh4Stjtdz5hqXux3b
	 sQUAngsjmNjAQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] HID: logitech-hidpp: add HID++ 2.0
 reprogrammable button support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Elliot Douglas" <edouglas7358@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260812195842.77724-2-edouglas7358@gmail.com>
References: <20260812195842.77724-1-edouglas7358@gmail.com>
 <20260812195842.77724-2-edouglas7358@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 20:13:12 +0000
Message-Id: <20260812201312.9E1E01F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-after-free of `hidpp->input` when `input_register_device` fail=
s.
- [High] Out-of-bounds read in `hidpp_raw_hidpp_event()` when copying the r=
eport structure.
--

--- Patch [1]: [PATCH v3 1/2] HID: logitech-hidpp: add HID++ 2.0 reprogramm=
able button support ---
commit 8ed227c4b30632c93149b188c8de90eb6920c093
Author: Elliot Douglas <edouglas7358@gmail.com>

HID: logitech-hidpp: add HID++ 2.0 reprogrammable button support

Some Logitech HID++ 2.0 mice can report diverted reprogrammable controls
through HID++ feature 0x1b04, SpecialKeysMseButtons / REPROG_CONTROLS_V4,
instead of the normal HID mouse report.

Link: https://lekensteyn.nl/files/logitech/x1b04_specialkeysmsebuttons.html

> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-=
hidpp.c
> index 70ba1a5e40d8e..f9189e14fb780 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
[ ... ]
> @@ -3601,6 +3606,195 @@ static int hidpp10_extra_mouse_buttons_raw_event(=
struct hidpp_device *hidpp,
>  	return 1;
>  }
> =20
> +/* ---------------------------------------------------------------------=
----- */
> +/* HID++2.0 reprogrammable controls                                     =
      */
> +/* ---------------------------------------------------------------------=
----- */
[ ... ]
> +static int hidpp20_reprog_controls_raw_event(struct hidpp_device *hidpp,
> +					     u8 *data, int size)
> +{
> +	const struct hidpp_reprog_control_mapping *mapping;
> +	struct hidpp_report *report =3D (struct hidpp_report *)data;
> +	u16 controls[4];
> +	bool pressed;
> +	unsigned int i, j;
> +
> +	if (!(hidpp->quirks & HIDPP_QUIRK_HIDPP_REPROG_CONTROLS_BTNS) ||
> +	    !hidpp->input ||
> +	    !hidpp->reprog_controls ||
> +	    hidpp->reprog_controls_feature_index =3D=3D 0xff)
> +		return 0;

[Severity: High]
This isn't a bug introduced by this patch, but could this lead to a
use-after-free of hidpp->input if input registration fails?

Looking at hidpp_connect_event() in drivers/hid/hid-logitech-hidpp.c, if
input_register_device() fails, it frees the input device but leaves the
global hidpp->input pointer dangling:

	ret =3D input_register_device(input);
	if (ret) {
		input_free_device(input);
		return;
	}

Since the device is actively receiving interrupts, incoming reports can tri=
gger
raw event handlers like this newly added hidpp20_reprog_controls_raw_event(=
).
The handler bypasses the !hidpp->input check because the pointer is not NUL=
L,
and subsequently calling input_report_key() with the freed pointer could ca=
use
a use-after-free.

> +
> +	if (size < HIDPP_REPORT_LONG_LENGTH ||
> +	    report->fap.feature_index !=3D hidpp->reprog_controls_feature_index=
 ||
> +	    report->fap.funcindex_clientid !=3D HIDPP_REPROG_CONTROLS_EVENT_DIV=
ERTED)
> +		return 0;
[ ... ]
> @@ -3971,6 +4168,10 @@ static int hidpp_raw_hidpp_event(struct hidpp_devi=
ce *hidpp, u8 *data,
>  			return ret;
>  	}
> =20

[Severity: High]
This is a pre-existing issue, but can the struct assignment at the top of
hidpp_raw_hidpp_event() read out of bounds?

When a matching response is found, hidpp_raw_hidpp_event() performs this
assignment:

	if (hidpp_match_answer(question, report) ||
			hidpp_match_error(question, report)) {
		*answer =3D *report;
		hidpp->answer_available =3D true;
		wake_up(&hidpp->wait);

The struct hidpp_report is 64 bytes in size. However, the report pointer is=
 cast
directly from the incoming data buffer. If a device only supports SHORT
(7 bytes) or LONG (20 bytes) reports, the data buffer will be sized accordi=
ngly.
Does the 64-byte struct copy read out of bounds from the smaller heap buffer
when the incoming report is matched?

> +	ret =3D hidpp20_reprog_controls_raw_event(hidpp, data, size);
> +	if (ret !=3D 0)
> +		return ret;
> +
>  	if (hidpp->quirks & HIDPP_QUIRK_HIDPP_CONSUMER_VENDOR_KEYS) {
>  		ret =3D hidpp10_consumer_keys_raw_event(hidpp, data, size);
>  		if (ret !=3D 0)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812195842.7772=
4-1-edouglas7358@gmail.com?part=3D1
