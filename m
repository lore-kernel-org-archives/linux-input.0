Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7A94BEE3C
	for <linux-input@vger.kernel.org>; Sat, 12 Sep 2026 03:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789184037; cv=none; b=U/8n3DJ1uuAcNB8AtDwt907opzE+frdDv2lxT/wLSHV7ZFV4tl42saJ6l3gsRa4eNDo9MyerSY6kJ64U3GtPoSkzMs8yA4kc8Uh+KJEm4XUY6ZjKIjQU4crkg+5HMVGse33m9ooW+qyutf5ajQnz81vuB8Xx6IPnAuoFBht6Aug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789184037; c=relaxed/simple;
	bh=5p8l/GCKd/QcsRv2stBMuj7C9nmfEx/EHpHaDhPsQx8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RfILTEXCRZ2EZu0oSR5hzgHg4C22HMZABp0gFKUHFoPZWmY2X9PQBvtG1Ji0Paw2+A1P+em2AX3bJei48Dsjw4nBahUSuZS+NZ12rrgsqaxALirO1K//Bd7ialx1MdsbgSQbXpcgRdtVYJ2lx9AI+Are81jkQvcKSXcMndnjb5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZxA1cbVB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZxA1cbVB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B0D71F000FF;
	Sat, 12 Sep 2026 03:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789184035;
	bh=A1AR7M1qYzJawhYZPKhfL12/7V+gEjBhRVeDPt8n/L0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZxA1cbVBzODcrNuBBfG9v/a9Ew9RSaUvQMx41yoegL2lIxoSvWEVR75xZ2qjfGp6d
	 1z3rczVpCk6YNDkcfZ5Et6F2TfYPcuMTXPFdTe7MihEBS5cZ+C49v33aR6tdP4SUt3
	 g2Sn6kvO4sVkucD7i4XsVt/aCzLTu95W4hiuhtbPFOTJ88O6Pgkf9pcAKNTMHuFOiq
	 H8n7KOVdskVAOhybnhxAPnQ32IVXQa1kVhZyr1cRiHa46ObBujoTPBmGA3zVREdwuQ
	 THMWbR9PTOKDmp2iiTJafltEI0XyeyjV3Z/uwo34Zwqaq+6a2hgpztiGUVoJVcoAiL
	 tgxMUPX3D+x8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 12/12] Input: xbox_gip - Add wheel support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260912030426.2997003-13-vi@endrift.com>
References: <20260912030426.2997003-1-vi@endrift.com>
 <20260912030426.2997003-13-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 03:33:54 +0000
Message-Id: <20260912033355.7B0D71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Medium] Late length checks in input report handlers leave events unsynch=
ronized on truncated packets.
- [Medium] Incorrect modulo arithmetic for relative dial causes erratic rev=
erse jumps.
- [Medium] Static configuration of `max_angle` with 0 precision causes inte=
ger underflow, bypassing validation.

Pre-existing issues:
- [High] AB-BA deadlock between LED sysfs operations and device unregistrat=
ion.
--

commit 533e8fbcd84078cc304b29f07232970fb0a6e7d7
Author: Vicki Pfau <vi@endrift.com>

    Input: xbox_gip - Add wheel support
   =20
This adds preliminary support for racing wheel support in xbox_gip,
exposing them mapped to the newly added axes.

> diff --git a/drivers/input/joystick/gip/gip-core.c b/drivers/input/joysti=
ck/gip/gip-core.c
> index 720b9a075ed3a..42e191f0aef24 100644
> --- a/drivers/input/joystick/gip/gip-core.c
> +++ b/drivers/input/joystick/gip/gip-core.c
[ ... ]
> @@ -334,6 +334,8 @@ static const struct gip_driver *base_drivers[] =3D {
>  	&gip_driver_gamepad,
>  	&gip_driver_arcade_stick,
>  	&gip_driver_pdp_jaguar,
> +	&gip_driver_trueforce_wheel,
> +	&gip_driver_wheel,

[Severity: High]
This is a pre-existing issue, but does adding these devices expose them to
the AB-BA deadlock between LED sysfs operations and device unregistration?

During device disconnect, gip_reset_attachment() acquires attachment->lock =
and
calls gip_free_devices(), which manually calls input_unregister_device(). If
there are no open evdev handles, this synchronously tears down the device a=
nd
its devres resources, invoking led_classdev_unregister(). This function blo=
cks
in kernfs_drain waiting for active sysfs operations to complete. Concurrent=
ly,
a sysfs write to the LED brightness holds the kernfs active reference and c=
alls
gip_guide_led_set(), which blocks trying to acquire attachment->lock.

> diff --git a/drivers/input/joystick/gip/gip-wheel.c b/drivers/input/joyst=
ick/gip/gip-wheel.c
> new file mode 100644
> index 0000000000000..bd281b295eac1
> --- /dev/null
> +++ b/drivers/input/joystick/gip/gip-wheel.c
[ ... ]
> +static int gip_handle_wheel_report(struct gip_attachment *attachment,
> +	struct input_dev *input, const uint8_t *bytes, int num_bytes)
> +{
> +	uint8_t connections;
> +	struct gip_wheel_info *info =3D attachment->driver_data;
> +	int rc =3D gip_driver_navigation.handle_input_report(attachment, input,=
 bytes, num_bytes);
> +
> +	if (rc < 0)
> +		return rc;
> +
> +	if (!info)
> +		return -ENODEV;
> +
> +	if (num_bytes < 17)
> +		return -EINVAL;

[Severity: Medium]
Will this length check leave partial events unsynchronized if the packet is
truncated?

If num_bytes is less than 17, this returns -EINVAL after
gip_driver_navigation.handle_input_report() has already reported events via
input_report_key(). The outer function will then skip input_sync(), leaving=
 the
reported events stuck in the input core's buffers until the next sync.

[ ... ]
> +static int gip_handle_wheel_ll_static_configuration(struct gip_attachmen=
t *attachment,
> +	const struct gip_header *header, const uint8_t *bytes, int num_bytes)
> +{
> +	struct gip_wheel_info *info =3D attachment->driver_data;
> +
> +	if (!info)
> +		return -ENODEV;
> +
> +	if (num_bytes < 11)
> +		return -EINVAL;
> +
> +	info->max_angle =3D BIT(min(bytes[0], 16)) / 2 - 1;

[Severity: Medium]
Could this formula cause an integer underflow if bytes[0] is 0?

If a 0-bit precision configuration is received, BIT(0) is 1, and 1 / 2 - 1
evaluates to -1, which underflows the uint16_t info->max_angle to 65535. Th=
is
could bypass validation checks and assign corrupted bounds to ABS_WHEEL.

[ ... ]
> +static int gip_handle_trueforce_wheel_report(struct gip_attachment *atta=
chment,
> +	struct input_dev *input, const uint8_t *bytes, int num_bytes)
> +{
> +	int rc =3D gip_driver_wheel.handle_input_report(attachment, input, byte=
s, num_bytes);
> +	struct gip_trueforce_wheel_state *state =3D attachment->driver_data;
> +	int dial;
> +
> +	if (rc < 0)
> +		return rc;
> +
> +	if (num_bytes < 18)
> +		return -EINVAL;

[Severity: Medium]
Will this length check leave partial events unsynchronized if the packet is
truncated?

Similar to the check in gip_handle_wheel_report(), this returns -EINVAL aft=
er
the base wheel handler has already injected state changes, causing the core=
 loop
to abort before calling input_sync().

[ ... ]
> +	/* Dial states only change one at a time, so we can easily check for wr=
aparound */
> +	if (dial =3D=3D 0 && state->dial =3D=3D 7)
> +		input_report_rel(input, REL_DIAL, -1);
> +	else if (dial =3D=3D 7 && state->dial =3D=3D 0)
> +		input_report_rel(input, REL_DIAL, 1);
> +	else if (state->dial >=3D 0)
> +		input_report_rel(input, REL_DIAL,
> +			state->dial - dial);

[Severity: Medium]
Could this cause erratic relative dial jumps if the dial skips a step?

If the dial moves rapidly across the 0-7 boundary and skips a step (e.g., f=
rom
previous state 6 to current dial 0), the hardcoded wraparound checks fail. =
It
then falls back to state->dial - dial (6 - 0 =3D 6), reporting +6 instead o=
f the
actual shortest distance of -2.

Should standard modulo arithmetic be used here instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912030426.2997=
003-1-vi@endrift.com?part=3D12
