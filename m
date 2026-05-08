Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E68A39B4AD
	for <linux-input@vger.kernel.org>; Fri,  8 May 2026 22:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778280691; cv=none; b=mLBTOOL4X9StCbBOaee22pus9OLtkJqOkv9kvx3arlYvdLNfKXi0uod/Wl50kQPhBtDavCnVMim5k8GnuusmvdLq4Y3/CwhUCwiHgBAuZun6kIc4puav10032PS7sOeTXCoaWQqMg95BZiY8Gr9nJfAxH3hUZeHAvne1GDBCSdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778280691; c=relaxed/simple;
	bh=2b7IY82Z/w97b6UWnCq/2GH9FAy/Qf6SiY+NvTDz9Pw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ripv42/NSTw3X0it9MZv8vU9JwnK96ebLGfTBwZXSFuJJoFamRk8vS2ZLrqsjRqeZiwSGUfQFpk4QY4ShP88aK/QF+1IhtBsYTEqRZAEUK40lCOktDrei7Y0yeeJgz/82jsyn5XFU4DYA+jyNoqSCxmZS3WMtZUjsavjjMJ5lJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7cKfZAm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7cKfZAm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D33C2BCB0;
	Fri,  8 May 2026 22:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778280690;
	bh=2b7IY82Z/w97b6UWnCq/2GH9FAy/Qf6SiY+NvTDz9Pw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=S7cKfZAmyNllNf3XfiQD61J4eqJc3foKl9r5NOZpbl1QIVoX+oxk4lxM9WqLDrC4n
	 K8LORuqbjK+VfWKJgGULi0ZMCXx6hnAvIFxCnrm4mnWa5KPet5XpcrW6wkJcKGcly5
	 PSAwle5LiceIV9cUS+Ylp6FtwAgt8U/imiwyPoUCnHt2GR+hOCIJJsDAgiguS7pOCf
	 Dfr3No3MVef+tbOgujBGsQWItFolh4s+diRl4WDV8SLSozGh+XrZx3y5rbNUIIc+2N
	 7QiVxiUc+KreA48cs4mlkQvhzKHouVR0yTzuqxEIv0kDg1RqOj2s42O9/5me/sRQvc
	 HLi9pdHTggvxA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND 2] HID: Add force feedback support for Speedlink
 Cougar Vibration Flightstick
Reply-To: sashiko@lists.linux.dev
To: "Harald Judt" <h.judt@gmx.at>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <b3bfa73b-0547-45f9-b6ae-f28815e6c632@gmx.at>
References: <b3bfa73b-0547-45f9-b6ae-f28815e6c632@gmx.at>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 22:51:30 +0000
Message-Id: <20260508225130.C6D33C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Race condition in force feedback initialization leading to a NULL =
pointer dereference.
- [High] Ignoring the return value of `gembird_joy_init()` causes a NULL po=
inter dereference when user-space interacts with the event device after an =
initialization failure.
- [High] Non-monotonic magnitude scaling logic severely breaks force feedba=
ck functionality.
- [Medium] Memory leak of the `gembird_joy_device` state structure upon dev=
ice disconnect.
--

commit f9141496ab06cd22000d2487bbb234d7e91931b5
Author: Harald Judt <h.judt@gmx.at>

HID: Add force feedback support for Gembird based joystick

This commit adds force feedback (rumble) support for the SpeedLink Cougar
Vibration Flightstick (SL-6630) joystick, which uses a Gembird controller.

> diff --git a/drivers/hid/hid-gembird-joy.c b/drivers/hid/hid-gembird-joy.c
> new file mode 100644
> index 0000000000000..5a5afa02f8407
> --- /dev/null
> +++ b/drivers/hid/hid-gembird-joy.c

[ ... ]

> +static int hid_gembird_joy_play(struct input_dev *dev, void *data,
> +				struct ff_effect *effect)
> +{
> +	struct hid_device *hid =3D input_get_drvdata(dev);
> +	struct gembird_joy_device *joy =3D data;
> +	int strong, weak;
> +
> +	strong =3D effect->u.rumble.strong_magnitude;
> +	weak =3D effect->u.rumble.weak_magnitude;

[ ... ]

> +	strong =3D (strong / 0xff) * 0x1f / 0xff;
> +	weak =3D (weak / 0xff) * 0x1f / 0xff;
> +
> +	/* ... and to support the notions of strong vs weak rumble effects,
> +	 * increase the magnitude for the strong rumble effect if it is below t=
he
> +	 * half of the maximum value, as the strong motor has the same strength=
 as
> +	 * the weak one. Likewise, decrease the magnitude for the weak effect.
> +	 */
> +	if (strong < 0x10 && !weak)         /* fftest effect 4 strong rumble */
> +		strong *=3D 2;
> +	else if (!strong && weak >=3D 0x10)   /* fftest effect 5 weak rumble */
> +		weak /=3D 2;

Will this cause issues with non-monotonic force feedback behavior and
unintended truncation?

Since the math uses integer division, any input value below 255 for strong
or weak will evaluate to zero during the first division by 0xff.

Additionally, could the conditional scaling cause abrupt changes in rumble
strength? For instance, if a game requests a strong magnitude that scales
down to 15, it gets doubled to 30 because of the strong < 0x10 check.
However, a slightly stronger requested magnitude that scales to 16 will
remain 16, meaning an increase in requested strength results in a drop in
physical rumble.

[ ... ]

> +static int gembird_joy_init(struct hid_device *hid)
> +{

[ ... ]

> +		joy =3D kzalloc(sizeof(struct gembird_joy_device), GFP_KERNEL);
> +		if (!joy)
> +			return -ENOMEM;

Does this memory leak when the device is disconnected or the driver is
unbound? The allocation doesn't use devm_kzalloc, and there isn't a
remove callback to free it. The input_ff_create_memless teardown
handles its own structures but not the user-provided private data.

> +
> +		dev =3D hidinput->input;
> +
> +		set_bit(FF_RUMBLE, dev->ffbit);
> +
> +		error =3D input_ff_create_memless(dev, joy, hid_gembird_joy_play);
> +		if (error) {
> +			kfree(joy);
> +			return error;
> +		}
> +
> +		joy->report =3D report;

Is there a window here where an ioctl could trigger a NULL pointer
dereference?

The device was already started earlier in gembird_joy_probe via
hid_hw_start, so userspace can issue an EVIOCSFF ioctl as soon as
input_ff_create_memless succeeds. If the ioctl triggers
hid_gembird_joy_play before joy->report is assigned on the next line,
the callback will try to access joy->report->field and dereference NULL.

[ ... ]

> +static int gembird_joy_probe(struct hid_device *hdev, const struct hid_d=
evice_id *id)
> +{
> +	int ret;
> +
> +	ret =3D hid_parse(hdev);
> +	if (ret) {
> +		hid_err(hdev, "parse failed\n");
> +		return ret;
> +	}
> +
> +	ret =3D hid_hw_start(hdev, HID_CONNECT_DEFAULT & ~HID_CONNECT_FF);
> +	if (ret) {
> +		hid_err(hdev, "hw start failed\n");
> +		return ret;
> +	}
> +
> +	gembird_joy_init(hdev);
> +
> +	return 0;
> +}

What happens if gembird_joy_init fails?

If input_ff_create_memless returns an error, gembird_joy_init
propagates it, but the return value is ignored here and probe succeeds.

Because set_bit(FF_RUMBLE, dev->ffbit) was already called, the device
remains registered and advertises rumble support. If userspace then issues
an EVIOCSFF ioctl, the kernel will allow it, which could lead to a panic
when it tries to dereference the missing force feedback structures.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/b3bfa73b-0547-45f9-=
b6ae-f28815e6c632@gmx.at?part=3D1
