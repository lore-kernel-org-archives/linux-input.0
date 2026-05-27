Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0453BFAD4
	for <linux-input@vger.kernel.org>; Wed, 27 May 2026 16:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779900696; cv=none; b=nfyIuA4ozBgS4qlWStqGUNqMvyhi/Gckg9zWvIxh3YqYNKz0u7TSNb5ueX23/CguEZ9mKLb8v5mG/cYUWgRL+GBWq91m6pW2aqG8/+iUTyhWE9FC4hcSNpSs7gTmMIxb9Ekmmbkaod2QIwzUdsVTX6yi/jcUzlgugd6JvFSoggY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779900696; c=relaxed/simple;
	bh=Wr7LoKWnn7ykZVKcfsvoxqAJJ766tGY8U6/vNY7HAmQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jszMPd1l2ekFvTxJicHG+OiBtBHAYn7dMEzny4ztnS4wAnIz5jFWXe0rQ+CRO0ZPTQvrBpMFrZ687RKBB/nX4nxzVT8XEAclGCWpdFBZQtWQMdhsczSGAbR/FcjrCW4QLfvn8oihknzqgT203GNONmfJ2bti71HqF7ry+vh5XGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ehWBGfZ5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ehWBGfZ5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F21F71F000E9;
	Wed, 27 May 2026 16:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779900695;
	bh=nZFkDvw5nC990ME0o+4P1q+x2lcPkOR8mihqQs17AD8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ehWBGfZ5MrNUFkHv9GOKE7qX/SvFdkFfKSmVXHCV/srWEAaDz1TCPOlFcaJeVgIfu
	 CVYP61KZFMu9nUHqxhamIKixiboPRGubafKetPjiOx/ikC+gepFKHpVG6COJ8nHtdD
	 8HLvROnl9RIbSSvQr39sNFrW0jmu8GGCAPwEQ2jgp4/Jtiv1ROhbCgBZf1naLWHFnj
	 M1oQpTCJhD1eBSnV5Y5VQ5z1oHvAsFQ6/hPlH+zbegdbdjZiiothFdc0EKV59syqAc
	 otgTaVHLtpSDBoqS+rJvW7JA6upaN3PRF/llSMyrjaHxHJfQHouMUeekr7fm3dtbiq
	 STtIZFL9Xo9sA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] HID: nintendo: add support for HORI Wireless Switch
 Pad
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hector Zelaya" <hector@hectorzelaya.dev>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260527-hori-support-v2-1-195c2f832112@hectorzelaya.dev>
References: <20260527-hori-support-v2-1-195c2f832112@hectorzelaya.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 16:51:34 +0000
Message-Id: <20260527165134.F21F71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Incompatible SPI flash data is parsed as IMU calibration for licen=
sed controllers, leading to invalid sensor scaling and broken IMU output.
- [Medium] The controller implicitly and falsely advertises force-feedback =
(rumble) capabilities to user-space, despite physically lacking a vibration=
 motor.
- [Low] Bypassing stick calibration triggers a misleading error warning on =
every connection.

Pre-existing issues:
- [High] The IMU report parser reads out of bounds if a truncated `JC_INPUT=
_IMU_DATA` report is received.
--

commit 376e2cc446988e8ea86a066e021e9f1adc2e0081
Author: Hector Zelaya <hector@hectorzelaya.dev>
Subject: HID: nintendo: add support for HORI Wireless Switch Pad

This commit adds support for the HORI Wireless Switch Pad (vendor 0x0f0d,
product 0x00f6). It configures quirks for the third-party controller, such =
as
handling incompatible SPI flash calibration data, swapped X/Y buttons, and =
the
lack of hardware vibration.

> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> index 29008c2cc5304..2d37ddeffdb6e 100644
> --- a/drivers/hid/hid-nintendo.c
> +++ b/drivers/hid/hid-nintendo.c
[ ... ]
> @@ -695,7 +715,8 @@ static inline bool joycon_type_is_right_joycon(struct=
 joycon_ctlr *ctlr)
> =20
>  static inline bool joycon_type_is_procon(struct joycon_ctlr *ctlr)
>  {
> -	return ctlr->ctlr_type =3D=3D JOYCON_CTLR_TYPE_PRO;
> +	return ctlr->ctlr_type =3D=3D JOYCON_CTLR_TYPE_PRO ||
> +	       ctlr->ctlr_type =3D=3D JOYCON_CTLR_TYPE_LIC_PRO;
>  }

[Severity: Medium]
Since the commit message states there is "no vibration motor in hardware",
does returning true here incorrectly advertise force-feedback capabilities =
to
userspace?

Because joycon_type_is_procon() returns true, joycon_has_rumble() will also
return true. This causes joycon_input_create() to call joycon_config_rumble=
(),
which registers an FF_RUMBLE capability with the input subsystem, creating a
phantom rumble device.

[ ... ]
> @@ -1710,7 +1731,10 @@ static void joycon_parse_report(struct joycon_ctlr=
 *ctlr,
>  		joycon_report_left_stick(ctlr, rep);
>  		joycon_report_right_stick(ctlr, rep);
>  		joycon_report_dpad(ctlr, rep);
> -		joycon_report_buttons(ctlr, rep, procon_button_mappings);
> +		if (ctlr->ctlr_type =3D=3D JOYCON_CTLR_TYPE_LIC_PRO)
> +			joycon_report_buttons(ctlr, rep, lic_procon_button_mappings);
> +		else
> +			joycon_report_buttons(ctlr, rep, procon_button_mappings);
>  	} else if (joycon_type_is_any_nescon(ctlr)) {

[Severity: High]
This is a pre-existing issue, but can parsing the IMU data from this
controller lead to an out-of-bounds read if a truncated report is received?

In joycon_ctlr_read_handler(), the length check only verifies size >=3D 12
before calling joycon_parse_report(). If the report ID is JC_INPUT_IMU_DATA,
joycon_parse_report() delegates to joycon_parse_imu_report().

The IMU parsing logic assumes 36 bytes of IMU data starting at offset 13.
Processing a truncated IMU report over Bluetooth could lead to an
out-of-bounds read from the socket buffer.

[ ... ]
> @@ -2503,13 +2530,30 @@ static int joycon_init(struct hid_device *hdev)
> =20
>  	if (joycon_has_joysticks(ctlr)) {
>  		/* get controller calibration data, and parse it */
> -		ret =3D joycon_request_calibration(ctlr);
> -		if (ret) {
> +		if (ctlr->ctlr_type =3D=3D JOYCON_CTLR_TYPE_LIC_PRO) {
>  			/*
> -			 * We can function with default calibration, but it may be
> -			 * inaccurate. Provide a warning, and continue on.
> +			 * Licensed controllers may have incompatible SPI flash
> +			 * layouts. Use default calibration values.
>  			 */
> -			hid_warn(hdev, "Analog stick positions may be inaccurate\n");
> +			hid_info(hdev, "using default cal for licensed controller\n");
> +			joycon_use_default_calibration(hdev,
> +						       &ctlr->left_stick_cal_x,
> +						       &ctlr->left_stick_cal_y,
> +						       "left", 0);

[Severity: Low]
Does this trigger a misleading warning on every connection?

joycon_use_default_calibration() unconditionally prints "Failed to read ...
stick cal, using defaults; e=3D%d" using hid_warn(). Calling it directly wi=
th
ret=3D0 will print a confusing failure message even though no read was actu=
ally
attempted.

> +			joycon_use_default_calibration(hdev,
> +						       &ctlr->right_stick_cal_x,
> +						       &ctlr->right_stick_cal_y,
> +						       "right", 0);
> +		} else {
> +			ret =3D joycon_request_calibration(ctlr);
> +			if (ret) {
> +				/*
> +				 * We can function with default calibration, but
> +				 * it may be inaccurate. Provide a warning, and
> +				 * continue on.
> +				 */
> +				hid_warn(hdev, "Analog stick positions may be inaccurate\n");
> +			}
>  		}
>  	}
> =20
> @@ -2527,8 +2571,13 @@ static int joycon_init(struct hid_device *hdev)

[Severity: High]
Should we also bypass joycon_request_imu_calibration() for licensed
controllers?

The patch acknowledges the SPI flash layout is incompatible and bypasses
analog stick calibration. However, joycon_has_imu() will return true for
LIC_PRO, meaning joycon_request_imu_calibration() is still called right
before this hunk.

If the SPI read succeeds but returns unexpected data or zeroes from the
incompatible flash, the IMU calibration scales and offsets could be populat=
ed
with garbage. If the read scales are parsed as 0, the computed divisors are
adjusted to 1, and the resulting IMU values in joycon_parse_imu_report() wi=
ll
always evaluate to 0, breaking IMU functionality.

>  		/* Enable the IMU */
>  		ret =3D joycon_enable_imu(ctlr);
>  		if (ret) {
> -			hid_err(hdev, "Failed to enable the IMU; ret=3D%d\n", ret);
> -			goto out_unlock;
> +			if (ctlr->ctlr_type =3D=3D JOYCON_CTLR_TYPE_LIC_PRO) {
> +				hid_dbg(hdev, "IMU enable failed for licensed controller, continuing=
\n");
> +				ret =3D 0;
> +			} else {
> +				hid_err(hdev, "Failed to enable the IMU; ret=3D%d\n", ret);
> +				goto out_unlock;
> +			}
>  		}
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527-hori-suppo=
rt-v2-1-195c2f832112@hectorzelaya.dev?part=3D1
