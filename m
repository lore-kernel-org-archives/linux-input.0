Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7682C3B440F
	for <linux-input@vger.kernel.org>; Wed,  1 Jul 2026 07:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782890263; cv=none; b=jQsbnPmJm1vXOj0obqPOSLp8hfUHRPpCdz5PZen/rwtXq5HcN9IBXVN80DzSN2lkZIlOx5mKNn7M05zaouu+dlpsg+j15mQ81ORPsckmJo8zSZRDOgKIysCpMx3I2gl7QeNP/LKpSUGxQqI34QDdK3SJoOk3D1AF/tj/dAK9EBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782890263; c=relaxed/simple;
	bh=XtSqoQhzegrWL9zide8bx4z6zbrZf/ylFeUNrqXoCf4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n/OJEchmOzrXE3OgQ46ocwfY+HR8s/JOzc8VHLwOjF8le5PvHe4YEyqbgNE2d+D7bu6zqoNK/qf+R34qRIeEJ2RbK1c0tq9/XKYNxwTG03dwYzNNLtCGpB7MLMkWtFkQp0Qh7NldY+G+2qsmo3xZt7LJaisFl3E22kTp51ADQpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GiV/O+lH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GiV/O+lH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FFB91F000E9;
	Wed,  1 Jul 2026 07:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782890258;
	bh=Gli94jAWdnnKY2pTioSTizOR25zm6SyNrR0LU87aSzA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GiV/O+lHmKY0IwxEiQyIbojOKIKH3LQ5qnuZ4veSO6aXVcRrOI+JnbYBES96TEMjO
	 lT7RgESm1/5TrbGtHWptZlGwee6yMxZTM5h/a3L8/EAmll7ODlbsK9m1Fjd8ywL7Ou
	 vTh1Dzl9ObMNOaoewH9l0KL2HlyakACvyJUKSX4vwVpBEWsZ0bO7JhHkjVV7zQJloa
	 /spHCK+pPM9OwrH0BPYWJ/BBgUnkp1zJN1lyE1GL3/9lv2UmKlkQAclTZ2MgnuoY6a
	 mkIPw4AsFHwHWywxo7SkNkCSdCfbUS8zY76ziQ0tumcSQFcBkZgn2YTYqpiwcZ3+So
	 x9h8R6fylWz/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 2/3] HID: nintendo: Add rumble support for Switch 2
 controllers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260701065606.4169999-3-vi@endrift.com>
References: <20260701065606.4169999-1-vi@endrift.com>
 <20260701065606.4169999-3-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 07:17:37 +0000
Message-Id: <20260701071738.2FFB91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Use-After-Free on `ns2->rumble_buffer` during device teardown due =
to devres lifecycle mismatch.
- [Medium] Rumble work scheduling math error adds 2ms instead of subtractin=
g, causing it to run late and risk buffer underruns.
- [Medium] Pro Controller rumble motors receive identical signals, failing =
to control them individually as claimed.
--

commit 0899ea0ef032bf60e7abf4c07b73da1a806a6406
Author: Vicki Pfau <vi@endrift.com>
Date:   Wed Jul 1 06:56:03 2026 +0000

    HID: nintendo: Add rumble support for Switch 2 controllers
   =20
    This adds rumble support for both the "HD Rumble" linear resonant actua=
tor
    type as used in the Joy-Cons and Pro Controller, as well as the eccentr=
ic
    rotating mass type used in the GameCube controller. Note that since the=
re's
    currently no API for exposing full control of LRAs with evdev, it only
    simulates a basic rumble for now.

> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> index 5aacb8e88b704..96463e1586bbd 100644
> --- a/drivers/hid/hid-nintendo.c
> +++ b/drivers/hid/hid-nintendo.c
> @@ -3205,6 +3259,125 @@ static void switch2_kref_put(struct kref *refcoun=
t)
[ ... ]
> +static int switch2_play_effect(struct input_dev *dev, void *data, struct=
 ff_effect *effect)
> +{
[ ... ]
> +	if (ns2->ctlr_type =3D=3D NS2_CTLR_TYPE_GC) {
> +		ns2->rumble.sd.amplitude =3D max(effect->u.rumble.strong_magnitude,
> +			(uint16_t) (effect->u.rumble.weak_magnitude >> 1));
> +	} else {
> +		ns2->rumble.hd.hi_freq =3D RUMBLE_HI_FREQ;
> +		ns2->rumble.hd.lo_freq =3D RUMBLE_LO_FREQ;
> +		ns2->rumble.hd.hi_amp =3D effect->u.rumble.weak_magnitude * RUMBLE_MAX=
 >> 16;
> +		ns2->rumble.hd.lo_amp =3D effect->u.rumble.strong_magnitude * RUMBLE_M=
AX >> 16;
> +	}
> +	spin_unlock_irqrestore(&ns2->rumble_lock, flags);
> +
> +	schedule_delayed_work(&ns2->rumble_work, 0);
> +
> +	return 0;
> +}
> +
> +static void switch2_rumble_work(struct work_struct *work)
> +{
[ ... ]
> +	} else {
> +		ns2->rumble_buffer[0] =3D 1;
> +		switch2_encode_rumble(&ns2->rumble.hd, &ns2->rumble_buffer[0x2]);
> +		active =3D ns2->rumble.hd.hi_amp || ns2->rumble.hd.lo_amp;
> +		if (ns2->ctlr_type =3D=3D NS2_CTLR_TYPE_PRO) {
> +			/*
> +			 * The Pro Controller contains separate LRAs on each
> +			 * side that can be controlled individually.
> +			 */
> +			ns2->rumble_buffer[0] =3D 2;
> +			ns2->rumble_buffer[0x11] =3D 0x50 | ns2->rumble_seq;
> +			switch2_encode_rumble(&ns2->rumble.hd, &ns2->rumble_buffer[0x12]);
> +		}
> +	}

[Severity: Medium]
Does this code accurately provide independent control of the two rumble mot=
ors?

The commit message and the comment above mention that the Pro Controller's =
left
and right rumble motors can be controlled individually.

However, in switch2_play_effect(), the strong and weak magnitudes are mixed
into a single switch2_hd_rumble structure (ns2->rumble.hd).=20

Then in switch2_rumble_work(), this exact same structure is encoded into bo=
th
the left (offset 0x2) and right (offset 0x12) rumble buffers.=20

Since both physical motors receive the exact same mixed signal (both high a=
nd=20
low frequencies simultaneously), doesn't this result in identical rumble on=
=20
both sides rather than individual control?

> +	ns2->rumble_seq =3D (ns2->rumble_seq + 1) & 0xF;
> +	spin_unlock_irqrestore(&ns2->rumble_lock, flags);
> +
> +	if (active) {
> +		unsigned long interval =3D msecs_to_jiffies(4);
> +		uint64_t current_jiffies =3D get_jiffies_64();
> +
> +		if (!ns2->last_rumble_work)
> +			ns2->last_rumble_work =3D current_jiffies;
> +		else
> +			ns2->last_rumble_work +=3D interval;
> +
> +		/* Reschedule a little early to make sure the buffer never underruns */
> +		interval +=3D msecs_to_jiffies(2);
> +		if (ns2->last_rumble_work + interval >=3D current_jiffies)
> +			schedule_delayed_work(&ns2->rumble_work,
> +				ns2->last_rumble_work + interval - current_jiffies);

[Severity: Medium]
Does this schedule the work early or late?

The comment mentions rescheduling slightly early to prevent buffer underrun=
s.

Since interval starts at 4ms, adding 2ms to it with
interval +=3D msecs_to_jiffies(2) makes the new interval 6ms.=20

When scheduling for ns2->last_rumble_work + interval, this appears to target
a time 6ms after the last theoretical tick instead of the intended earlier
target (which would be 2ms after, or interval - 2ms).

Could this delay cause the work to run later than intended and lead to the=
=20
buffer underruns the comment warns about?

[ ... ]
> @@ -3346,6 +3522,20 @@ static int switch2_init_input(struct switch2_contr=
oller *ns2)
[ ... ]
> +#if IS_ENABLED(CONFIG_NINTENDO_FF)
> +	ns2->rumble_buffer =3D devm_kzalloc(&input->dev, 64, GFP_KERNEL);
> +	if (!ns2->rumble_buffer) {
> +		input_free_device(input);
> +		return -ENOMEM;
> +	}

[Severity: High]
Can this lead to a use-after-free during device removal?

The rumble_buffer is allocated with devm_kzalloc() tied to the input device=
,=20
so it gets freed when the input device is unregistered and its final refere=
nce
is dropped.

However, looking at the teardown sequence, if the input device is unregiste=
red
(for example via switch2_controller_put() calling input_unregister_device())
before the delayed work is completely synced and canceled, the worker could=
 run
and access the freed rumble_buffer.

Would it be safer to allocate this buffer without devm, or ensure the delay=
ed
work is fully canceled prior to unregistering the input device?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701065606.4169=
999-1-vi@endrift.com?part=3D2
