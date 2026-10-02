Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E3E472543
	for <linux-input@vger.kernel.org>; Fri,  2 Oct 2026 09:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932468; cv=none; b=n/SN7cdlLUgk2Ze4WLgSplM9O7RT2Bdc5F97VGfJ5lzEKOURsnswy/VQbhiYf8/2pKFDc3kjVNG4Q47t+oXTL3ChtiQ3xEQD7TiqFpdRipsJ+i3ek8IX1/4aSm/ESWN1xkqZ3tEVo0ivq4Tq+j+u0BP0rHCpu3nB4iGR2cmFy80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932468; c=relaxed/simple;
	bh=O/DhlFs14+9GDXRKPmbSBxCj7ZBGmcXRl9Cb/OABh9o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O9QAFQLKWdK5AF8HlK5j8oh4JwRiRuTof6s8oKN4BZyBViBmgylbHotKUu5hcWN2IaYfAGHBAefULzWHBepkjJQ65crpjxGFXWY9tKA7u64Mqhi3tTrTdJOd5BVVLzrCw7gOaI24331mqhc9fpp1ks2nMU+Bwj1jHEQ/1it5FKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWX0Phkk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWX0Phkk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 227C61F00893;
	Fri,  2 Oct 2026 09:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932466;
	bh=3/h7wJhbAZesgX7Z2awOr9eED/3Did21tknw0PnH1HA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eWX0Phkkn8OmetPUIN7KKOQyhiCpVq4ycAyf4iuQ7NTXhvJo217vm6Wgu47RaKdXJ
	 ZbpxAyW9EUl8OVYiXTwDEXwT544sBUXXxthGX1mYM1Ins2CSmDda/UlAkE8cwK7v59
	 em6wnSwyAqzg1Uqe0x+r+4FzFcPfiFPunHZbHmtZ9bYltZ1JAJlW39msHZ3VnuQiXW
	 84r52j8w0+PSKgL+eK9gjLOSOvdF7A3VP5PSzoSHnGXTSiUYsFB4LMPoagJduje/1F
	 2FjRgBSgiomaWuEZqMy1oK1FX3rktM/axB0lmnmCmag6uoQU05G1dDOUcruLvpGB+K
	 T6cLG/JzUjnBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 2/4] HID: nintendo: Add rumble support for Switch 2
 controllers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20261002002929.1578115-3-vi@endrift.com>
References: <20261002002929.1578115-1-vi@endrift.com>
 <20261002002929.1578115-3-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:14:25 +0000
Message-Id: <20261002091426.227C61F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] hid: nintendo: Infinite catch-up loop in switch2_rumble_work
- [High] hid: nintendo: AB-BA Deadlock in switch2_init_input error path
--

commit f2f111d17b13153234806561e2b816ddf7f4e353
Author: Vicki Pfau <vi@endrift.com>

HID: nintendo: Add rumble support for Switch 2 controllers

This commit introduces rumble support for Nintendo Switch 2 controllers,
handling both HD Rumble (linear resonant actuators) and eccentric rotating
mass haptics. It manages rumble states using a delayed workqueue to stream
reports.

> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> index 81d0a25d9846b..c185ad4a27c97 100644
> --- a/drivers/hid/hid-nintendo.c
> +++ b/drivers/hid/hid-nintendo.c
[ ... ]
> @@ -3251,6 +3305,128 @@ static void switch2_kref_put(struct kref *refcoun=
t)
[ ... ]
> +static void switch2_rumble_work(struct work_struct *work)
> +{
> +	struct switch2_controller *ns2 =3D container_of(to_delayed_work(work),
> +						      struct switch2_controller, rumble_work);
[ ... ]
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
> +		interval -=3D msecs_to_jiffies(2);
> +		if (ns2->last_rumble_work + interval >=3D current_jiffies)
> +			schedule_delayed_work(&ns2->rumble_work,
> +				ns2->last_rumble_work + interval - current_jiffies);
> +		else
> +			schedule_delayed_work(&ns2->rumble_work, 0);

[Severity: High]
Could this create an unbounded catch-up loop under load or after a suspend?

If switch2_rumble_work is delayed (for example, by lock contention or a
suspend/resume cycle) and falls significantly behind current_jiffies, it
reschedules itself with a 0 delay while only advancing last_rumble_work
by 4ms. If the execution of the work itself takes longer than 4ms,
current_jiffies will grow faster than last_rumble_work can catch up.

Can this lead to a situation where the worker spins constantly, pegging a
CPU core and flooding the controller with stale rumble packets?

> +	} else {
> +		ns2->last_rumble_work =3D 0;
> +	}
> +
> +	mutex_lock(&ns2->lock);
> +	if (!ns2->hdev) {
> +		cancel_delayed_work(&ns2->rumble_work);
> +	} else {
> +		ret =3D hid_hw_output_report(ns2->hdev, ns2->rumble_buffer, 64);
[ ... ]
> @@ -3374,6 +3550,26 @@ static int switch2_init_input(struct switch2_contr=
oller *ns2)
[ ... ]
> +#if IS_ENABLED(CONFIG_NINTENDO_FF)
> +	ns2->rumble_buffer =3D devm_kzalloc(&input->dev, 64, GFP_KERNEL);
> +	if (!ns2->rumble_buffer) {
> +		input_free_device(input);
> +		return -ENOMEM;
> +	}
> +	ret =3D devm_delayed_work_autocancel(&input->dev, &ns2->rumble_work, sw=
itch2_rumble_work);
[ ... ]
> +	ns2->leds =3D devm_kcalloc(&input->dev, JC_NUM_LEDS, sizeof(*ns2->leds)=
, GFP_KERNEL);
> +	if (!ns2->leds) {
> +		hid_err(ns2->hdev, "Failed to allocate LEDs\n");
> +		input_unregister_device(input);
> +		return -ENOMEM;
> +	}

[Severity: High]
Does this error path introduce an AB-BA deadlock with the rumble worker?

switch2_receive_command() acquires ns2->lock before calling
switch2_init_input(). Because the input device is registered before this
allocation, userspace can immediately open the evdev node and issue a rumble
effect, queuing switch2_rumble_work.

If devm_kcalloc() fails, it calls input_unregister_device(input). Since
userspace might have already closed the node, dropping the last reference
triggers synchronous devm cleanup (because the work is registered via
devm_delayed_work_autocancel). This cleanup will invoke
cancel_delayed_work_sync(&ns2->rumble_work) while this thread still holds
ns2->lock.

However, switch2_rumble_work() needs to acquire ns2->lock to complete, as
seen in the earlier snippet. Can this result in a permanent deadlock?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002002929.1578=
115-1-vi@endrift.com?part=3D2
