Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC83D3624D4;
	Wed, 17 Jun 2026 07:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781680718; cv=none; b=urfozanv8BDzdTtVjd07DMfIAr6qDEHlsA0XytYmrij7zDD35fC4y17UG+A10hWel/LUxfJNcOTnzQFTICQBzA29nAcLco/AHWYkFFuvWj+0TMoPtuakONtG+ZYMj4RPwHXJ1nJHJstttxUuB92FIjBYpI2pIB8Zae92CHsF19Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781680718; c=relaxed/simple;
	bh=i0IoNqa50ql8ZMFV1yrts2avdiIk+b8IdsXlvAq38P0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ohaPiua/qJQbodEFbxwhSSQa/kbWTwL59GjmAhD2BEUQLCJHtm6gWY/t+p0f/iwaYBBJfLKlrc0aowqSy+Qqof6DECLFQGDFXEsItwKeqafdMVx1eoZRBdWCgV3J2umkHT03PnxgGqjUtxPtGnbafU1eDSdf7TWWB7zzMJH+70E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k25bb8I7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k25bb8I7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE751F000E9;
	Wed, 17 Jun 2026 07:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781680717;
	bh=PCUJ8TvYxnZt3VGWlj5X1tmebfyir5JpZtVJpxf6nDg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k25bb8I7c6hTLrY1kIzGxirmsyqVcOe2oSoDTFUEtSxPWPrlFp7OBpwdteAfGOkWd
	 ynpzyw/WzekWiL52nxvMxrRPI2zH/Q/deHjsl1ioDMm55xtvAKcuFuFvBWG4U+DZC0
	 qag6NVE55TaktRtg68IGxRVmD/QHH5h/l18vh1DbO1DZCbYhrrItsgD6HuvUBrWDaX
	 UBK+Vw3TFHwGiJ923h0bExsag8AhuSIsnLvx2zajRGzO+UBNpAhlQ7xBQF3stXZelc
	 LBAdEf2l1DCKjt2uyX4MfIReEb82tpLxmxXm1J9Ms0/02OPPwjCsfjb8SzU2ywV1Yt
	 /eYgzznlP1Uag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/2] Input: isa1200 - new driver for Imagis ISA1200
Reply-To: sashiko-reviews@lists.linux.dev
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260617070528.35006-3-clamor95@gmail.com>
References: <20260617070528.35006-1-clamor95@gmail.com>
 <20260617070528.35006-3-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 07:18:36 +0000
Message-Id: <20260617071837.3DE751F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] The `ff-memless` timer and input device can outlive the devres=
-managed driver state upon device unbind, leading to a Use-After-Free (UAF).
- [High] The worker `isa1200_play_work` silently drops force feedback event=
s if it fails to acquire `input->mutex`, potentially leaving the vibrator s=
tuck.
- [Medium] Concurrent access to `isa->level` across different locking conte=
xts causes a data race that can schedule work after the device is closed.
--

commit 2ea8a9b82f2921004386e7307e4e382941aa5611
Author: Linus Walleij <linusw@kernel.org>

Input: isa1200 - new driver for Imagis ISA1200

The ISA1200 is a haptic feedback unit from Imagis Technology using two
motors for haptic feedback in mobile phones. Used in many mobile devices
c. 2012 including Samsung Galxy S Advance GT-I9070 (Janice), Samsung Beam
GT-I8350 (Gavini), LG Optimus 4X P880 and LG Optimus Vu P895.

> diff --git a/drivers/input/misc/isa1200.c b/drivers/input/misc/isa1200.c
> new file mode 100644
> index 0000000000000..f8c4da4a0e088
> --- /dev/null
> +++ b/drivers/input/misc/isa1200.c

[ ... ]

> +static void isa1200_play_work(struct work_struct *work)
> +{
> +	struct isa1200 *isa =3D container_of(work, struct isa1200, play_work);
> +	struct input_dev *input =3D isa->input;
> +
> +	scoped_guard(mutex_try, &input->mutex) {

[Severity: High]
Can this cause force feedback events to be silently dropped?

The worker uses scoped_guard(mutex_try, &input->mutex) to acquire the lock.
However, input->mutex is frequently held by the input core for normal
operations like input_open_device, input_close_device, and ioctls
(e.g., EVIOCGABS).

If this worker runs concurrently with any of these operations, the mutex_try
will fail and the worker will exit without updating the hardware. Because
isa->level was already updated locklessly in isa1200_vibrator_play_effect(),
future identical effect updates will be skipped, which could leave the
vibrator stuck in its current state.

> +		if (!isa->suspended) {
> +			if (isa->level)
> +				isa1200_start(isa);
> +			else
> +				isa1200_stop(isa);
> +		}
> +	}
> +}

[ ... ]

> +static void isa1200_vibrator_close(struct input_dev *input)
> +{
> +	struct isa1200 *isa =3D input_get_drvdata(input);
> +
> +	cancel_work_sync(&isa->play_work);
> +	isa1200_stop(isa);
> +	isa->level =3D 0;

[Severity: Medium]
Does this concurrent modification of isa->level create a data race that
can restart the vibrator after the device is closed?

The state variable isa->level is updated in isa1200_vibrator_play_effect()
under the input core's event_lock (timer context). Concurrently, it is reset
to 0 here in isa1200_vibrator_close() under input->mutex, without acquiring
event_lock.

Because the ff-memless timer is not explicitly stopped during close, the
timer can fire concurrently with or immediately after close. If it fires
after cancel_work_sync(&isa->play_work) completes, it can overwrite
isa->level to a non-zero value and re-schedule isa->play_work. This could
re-enable the motor indefinitely.

> +}

[ ... ]

> +static int isa1200_probe(struct i2c_client *client)
> +{
> +	struct isa1200 *isa;
> +	struct device *dev =3D &client->dev;
> +	int err;
> +
> +	isa =3D devm_kzalloc(dev, sizeof(*isa), GFP_KERNEL);

[Severity: Critical]
Is there a use-after-free risk here during device unbind?

The private isa structure is allocated with devm_kzalloc(), meaning it is
freed immediately when the device unbinds. However, the input device itself
is managed by devm_input_allocate_device(), which keeps the memory alive
as long as userspace holds an open file descriptor.

Because the ff-memless timer (ml_effect_timer) is tied to the input_dev
lifecycle, the timer can continue to fire even after unbind if an effect
was playing. When it fires, isa1200_vibrator_play_effect() retrieves the
freed isa structure via input_get_drvdata() and accesses corrupted memory
to schedule the workqueue.

Additionally, there doesn't appear to be a devm action added to explicitly
cancel isa->play_work on unbind.

> +	if (!isa)
> +		return -ENOMEM;
> +
> +	isa->input =3D devm_input_allocate_device(dev);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617070528.3500=
6-1-clamor95@gmail.com?part=3D2
