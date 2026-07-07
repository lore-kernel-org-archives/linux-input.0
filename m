Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A7F4C81
	for <linux-input@vger.kernel.org>; Tue,  7 Jul 2026 23:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783467973; cv=none; b=EGBWY9vka1x14FmSYbRsYq85NGmWU5UtTod0iG9J+KJTkqgtD383WUy8f9dSgAseUj1ieoZR7/YjnijnUAT2NQ4aikRZI2vnK69Izfvn4bxMZBVExQhbWNHT8BqkB8ikKaS3Mh867e/6j/bEAUMcvdT8e/EC3uWSGAaJMsFJfrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783467973; c=relaxed/simple;
	bh=K/k6oBB67YtWwi++3EvW5uWgQgMhpzI4NSGBswe/0kY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VXo9DunAYQubuaocfbcycZcUIzDp/w7/BQ8EThnoXZCF4smb77YHSsKgnQciLkfXpnav1y5YPem9goi9jdNgNA+JWTaLrE4kalet30w/QUiTxhu5STCiin+5++e8PRqwRg1mG04BPHvz3Tfqfz46QHkk1FarxZg7/eB9fY83dqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3ePy8w7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3ePy8w7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 583B31F000E9;
	Tue,  7 Jul 2026 23:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783467971;
	bh=u4qmrMy4VqxexYhH43gHGgJ9qwwc8b0FDoo8lzVFFCQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N3ePy8w7Kq3IM6EwpHxTDFCSv4IVfsmNNjjmQEfOJe4bAKXlqW175cNWCBNG86kCL
	 A9591maAPLpjtd42W9+IfDzQv1IgRpWEuK4hkKDJWR5A6KFBO1gnaFTchAuYFNpFGI
	 7ywgUrM4XOKVvR0JEbLhoKD52aQkxO0xOJH38v0wvUz3mumAY3lHQkw/pZX/CGg6yM
	 5srJmhx5GKJgHkK2GrnGDD4TJ3ihpUshmVy4Kzp/5Jz9RqCftSRK7pJKN8diYVei+q
	 lKfDjNjMwa+Q1gBLfwnBVhP/WmUaokxbi4A2GfagMEJ5gh4af0jwhvk9rZFco1aHB3
	 6Clxbo4PPM5UQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/10] HID: steam: Coalesce rumble packets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260707233241.2644971-6-vi@endrift.com>
References: <20260707233241.2644971-1-vi@endrift.com>
 <20260707233241.2644971-6-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 23:46:10 +0000
Message-Id: <20260707234611.583B31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The rate-limiting logic inadvertently creates a continuous polling=
 loop that actively induces the haptic discontinuities it was intended to f=
ix.
--

--- Patch [5]: [PATCH v2 05/10] HID: steam: Coalesce rumble packets ---
commit 57ea23e2a38271a41e31886938cdef03c430a55f
Author: Vicki Pfau <vi@endrift.com>

HID: steam: Coalesce rumble packets

This commit adds rate limiting to Steam Deck haptic rumble packets to
avoid resetting the haptic pattern too frequently when userspace sends
many rapid updates. It introduces a delayed work queue to throttle updates
to 20Hz.

> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> index 6029c055a6cf3..5537488139011 100644
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c
[ ... ]
> @@ -603,10 +604,24 @@ static void steam_haptic_rumble_cb(struct work_stru=
ct *work)
>  {
>  	struct steam_device *steam =3D container_of(work, struct steam_device,
>  							rumble_work);
> +
>  	steam_haptic_rumble(steam, 0, steam->rumble_left,
>  		steam->rumble_right, 2, 0);
>  }
> =20
> +static void steam_coalesce_rumble_cb(struct work_struct *work)
> +{
> +	struct steam_device *steam =3D container_of(to_delayed_work(work),
> +							struct steam_device,
> +							coalesce_rumble_work);
> +
> +	steam_haptic_rumble(steam, 0, steam->rumble_left,
> +		steam->rumble_right, 2, 0);
> +
> +	if (steam->rumble_left || steam->rumble_right)
> +		schedule_delayed_work(&steam->coalesce_rumble_work, HZ / 20);
> +}

[Severity: High]
Does this logic inadvertently create a continuous loop that actively induces
the haptic discontinuities it was intended to fix?

Since the callback unconditionally reschedules itself every 50ms as long as
the stored rumble values are non-zero, it will continuously transmit identi=
cal
rumble packets to the device at 20Hz, even when userspace has stopped
updating the effect.

Because the commit message mentions the Steam Deck resets its haptic pattern
on every packet, won't this perpetual loop guarantee the pattern resets eve=
ry
50ms and unnecessarily spam the USB bus?

> +
>  #ifdef CONFIG_STEAM_FF
>  static int steam_play_effect(struct input_dev *dev, void *data,
>  				struct ff_effect *effect)
> @@ -616,6 +631,14 @@ static int steam_play_effect(struct input_dev *dev, =
void *data,
>  	steam->rumble_left =3D effect->u.rumble.strong_magnitude;
>  	steam->rumble_right =3D effect->u.rumble.weak_magnitude;
> =20
> +	/*
> +	 * The interface gets somewhat overloaded when too many rumble
> +	 * packets are sent in a row, so Steam throttles it to 20 Hz
> +	 */
> +	if (delayed_work_pending(&steam->coalesce_rumble_work))
> +		return 0;

[Severity: High]
Could this condition unnecessarily stall valid userspace updates?

Because the loop in steam_coalesce_rumble_cb() keeps the delayed work pendi=
ng
continuously while the effect is active, valid userspace updates may be
stalled by up to 50ms instead of executing immediately when the system is
otherwise idle.

> +
> +	schedule_delayed_work(&steam->coalesce_rumble_work, HZ / 20);
>  	return schedule_work(&steam->rumble_work);
>  }
>  #endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707233241.2644=
971-1-vi@endrift.com?part=3D5
