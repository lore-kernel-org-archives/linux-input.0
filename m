Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833272F290A
	for <linux-input@vger.kernel.org>; Thu, 14 May 2026 00:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778720034; cv=none; b=PZ3SseYJtL75otAsC+tUMGMUgxI875TNxfO31AICpe7ZL5z/K9/le6bD5qjXUiCNnARHaTsnREm1hOwUBB3KrABe18aW5obnR2nVyMf/U6QxXyE7PsShT+vYRf491I0lCbD4pStpMJ3EqLX7gZyb3JDq9uDDeY+A5En4k75vIWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778720034; c=relaxed/simple;
	bh=5t1xo9jfmUWmLqhHhk6+Gt7WMNMRSWC+FAbxUxcT+QM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pWRUp8uJUj7JpxxQlqyCV07dwMS7qdN7KgsBM3gFN2I7cIT3bMY1qjr5HR4Ax9AcsDnkdSAweJqELrqjxtaKjivKRM16FgCcsWgI8VFVVUfjpFvg2L62EQB6mY9TOc3HO1LrHY+pwYvGoyT61UpJRDqPcQ2StQOX0kLlmjnwkJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2B6JF6Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2B6JF6Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF8D8C19425;
	Thu, 14 May 2026 00:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778720034;
	bh=5t1xo9jfmUWmLqhHhk6+Gt7WMNMRSWC+FAbxUxcT+QM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=S2B6JF6YZkLV+HNiJqVq6zqNZ7KvI/eog7r9K7BD4C3sjptKmJq+RWYSQ/f/vWRLv
	 8plLNUMvMBMojlUgBbXSW5AFuOxmMZABzxICrol8yJ7bn4r6HKxhxgVD08JZezVzop
	 vn9F1N/dG4V70BEjjTc+kCHqbvjfx+yMKyX+XirdJLNRbUkJt9HtpSE26mk0Z4Qaye
	 2fHhVDZfVSYe29zsomg0yzj+l39vsgxPfogqkdXaZBWWwmYCgHjK8w+BnOAmrBZ8Xj
	 BN7MDiHnDEtQieL3rDJxO+ybN9x7fBGsqCntdq+trciP6wM1he3Twham5WTVCwtmcU
	 m24/wNQSzHYGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/3] HID: nintendo: Add rumble support for Switch 2
 controllers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260512200051.2534081-3-vi@endrift.com>
References: <20260512200051.2534081-3-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 00:53:53 +0000
Message-Id: <20260514005353.EF8D8C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Mixing jiffies and milliseconds in delayed work scheduling logic c=
auses an integer underflow, permanently stalling the haptic rumble.
- [High] A guaranteed NULL pointer dereference occurs in the error logging =
path of switch2_rumble_work, as well as a TOCTOU race condition.
- [Medium] `ns2->ctlr_type` is checked before it is dynamically initialized=
, causing union corruption for GameCube controllers.
- [Low] Implicit type promotion in the max() macro causes a compiler warnin=
g.
- [Low] Kconfig documentation claims individual motor control for the Pro C=
ontroller, but the implementation identicalizes the rumble data for both mo=
tors.
--

commit d72f0f8e0dadde2cacc27050b92088c2e5cbea0e
Author: Vicki Pfau <vi@endrift.com>
Subject: HID: nintendo: Add rumble support for Switch 2 controllers

This commit introduces rumble support for Switch 2 controllers, handling bo=
th HD
Rumble linear resonant actuators and eccentric rotating mass haptics. It ad=
ds
state machines for rumble scheduling and output reporting via hdev.

> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 26ef589f652c6..a7fe74d982475 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -850,10 +850,10 @@ config NINTENDO_FF
>  	depends on HID_NINTENDO
>  	select INPUT_FF_MEMLESS
>  	help
> -	Say Y here if you have a Nintendo Switch controller and want to enable
> -	force feedback support for it. This works for both joy-cons, the pro
> -	controller, and the NSO N64 controller. For the pro controller, both
> -	rumble motors can be controlled individually.
> +	Say Y here if you have a Nintendo Switch or Switch 2 controller and want
> +	to enable force feedback support for it. This works for Joy-Cons, the P=
ro
> +	Controllers, and the NSO N64 and GameCube controller. For the Pro
> +	Controller, both rumble motors can be controlled individually.

This isn't a bug, but is the help text accurate regarding individual motor
control? The implementation in switch2_rumble_work() appears to encode the
exact same rumble configuration to both the left and right motor offsets,
which would make both motors vibrate identically.

> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> index 2193afcdefabc..9801799a90758 100644
> --- a/drivers/hid/hid-nintendo.c
> +++ b/drivers/hid/hid-nintendo.c

[ ... ]

> @@ -3103,6 +3155,107 @@ static inline bool switch2_ctlr_is_joycon(enum sw=
itch2_ctlr_type type)
>  	return type =3D=3D NS2_CTLR_TYPE_JCL || type =3D=3D NS2_CTLR_TYPE_JCR;
>  }
> =20
> +#if IS_ENABLED(CONFIG_NINTENDO_FF)
> +static void switch2_encode_rumble(struct switch2_hd_rumble *rumble, uint=
8_t buffer[5])
> +{
> +	buffer[0] =3D rumble->hi_freq;
> +	buffer[1] =3D (rumble->hi_freq >> 8) | (rumble->hi_amp << 2);
> +	buffer[2] =3D (rumble->hi_amp >> 6) | (rumble->lo_freq << 4);
> +	buffer[3] =3D (rumble->lo_freq >> 4) | (rumble->lo_amp << 6);
> +	buffer[4] =3D rumble->lo_amp >> 2;
> +}
> +
> +static int switch2_play_effect(struct input_dev *dev, void *data, struct=
 ff_effect *effect)
> +{
> +	struct switch2_controller *ns2 =3D input_get_drvdata(dev);
> +
> +	if (effect->type !=3D FF_RUMBLE)
> +		return 0;
> +
> +	guard(spinlock_irqsave)(&ns2->rumble_lock);
> +	if (ns2->ctlr_type =3D=3D NS2_CTLR_TYPE_GC) {
> +		ns2->rumble.sd.amplitude =3D max(effect->u.rumble.strong_magnitude,
> +			effect->u.rumble.weak_magnitude >> 1);

Will this max calculation trigger a compiler warning? The strict type check=
ing
in the max macro might fail because effect->u.rumble.weak_magnitude >> 1
promotes to an int, while strong_magnitude is a u16.

> +	} else {
> +		ns2->rumble.hd.hi_amp =3D effect->u.rumble.weak_magnitude * RUMBLE_MAX=
 >> 16;
> +		ns2->rumble.hd.lo_amp =3D effect->u.rumble.strong_magnitude * RUMBLE_M=
AX >> 16;
> +	}
> +
> +	if (ns2->hdev)
> +		schedule_delayed_work(&ns2->rumble_work, 0);
> +
> +	return 0;
> +}
> +
> +static void switch2_rumble_work(struct work_struct *work)
> +{
> +	struct switch2_controller *ns2 =3D container_of(to_delayed_work(work),
> +						      struct switch2_controller, rumble_work);
> +	unsigned long current_ms =3D jiffies_to_msecs(get_jiffies_64());
> +	unsigned long flags;
> +	bool active;
> +	int ret;

[ ... ]

> +	if (active) {
> +		unsigned long interval =3D msecs_to_jiffies(4);
> +
> +		if (!ns2->last_rumble_work)
> +			ns2->last_rumble_work =3D current_ms;
> +		else
> +			ns2->last_rumble_work +=3D interval;
> +		schedule_delayed_work(&ns2->rumble_work,
> +			ns2->last_rumble_work + interval - current_ms);

Does this code underflow the scheduled delay?

The current_ms variable is retrieved in milliseconds using jiffies_to_msecs=
(),
but interval is calculated in jiffies using msecs_to_jiffies(). Since
ns2->last_rumble_work is initialized to milliseconds but incremented by
jiffies, subtracting current_ms could yield a negative value.

On systems where HZ is not 1000, could this underflow the delay parameter a=
nd
schedule the next work millions of jiffies in the future?

> +	} else {
> +		ns2->last_rumble_work =3D 0;
> +	}
> +	spin_unlock_irqrestore(&ns2->rumble_lock, flags);
> +
> +	if (!ns2->hdev) {
> +		cancel_delayed_work(&ns2->rumble_work);
> +		ret =3D -ENODEV;
> +	} else {
> +		ret =3D hid_hw_output_report(ns2->hdev, ns2->rumble_buffer, 64);
> +	}
> +
> +	if (ret < 0)
> +		hid_dbg(ns2->hdev, "Failed to send output report ret=3D%d\n", ret);

If ns2->hdev is NULL, we set ret =3D -ENODEV and then reach this hid_dbg ca=
ll.
Could this result in a NULL pointer dereference, as the hid_dbg macro passes
ns2->hdev to dev_dbg()?

Also, since ns2->hdev is accessed locklessly and without READ_ONCE(), is th=
ere
a time-of-check to time-of-use race where the compiler might reload the poi=
nter
between the check and hid_hw_output_report()?

[ ... ]

> @@ -3881,6 +4048,14 @@ static int switch2_probe(struct hid_device *hdev, =
const struct hid_device_id *id
> =20
>  	switch2_leds_create(ns2);
> =20
> +#if IS_ENABLED(CONFIG_NINTENDO_FF)
> +	if (ns2->ctlr_type !=3D NS2_CTLR_TYPE_GC) {
> +		ns2->rumble.hd.hi_freq =3D RUMBLE_HI_FREQ;
> +		ns2->rumble.hd.lo_freq =3D RUMBLE_LO_FREQ;
> +	}

Are we checking ns2->ctlr_type before it is dynamically initialized?

During probe, ns2->ctlr_type appears to be 0 since the struct is freshly
allocated and the type is discovered later during the init state machine.
This would cause the high and low frequencies to always be written.

Since hd and sd share a union, could this corrupt the sd.error and
sd.amplitude fields for actual GameCube controllers?

> +	spin_lock_init(&ns2->rumble_lock);
> +	INIT_DELAYED_WORK(&ns2->rumble_work, switch2_rumble_work);
> +#endif
>  	hid_set_drvdata(hdev, ns2);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512200051.2534=
081-1-vi@endrift.com?part=3D2
