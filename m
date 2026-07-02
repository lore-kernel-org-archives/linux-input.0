Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA323C553B
	for <linux-input@vger.kernel.org>; Thu,  2 Jul 2026 22:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783031664; cv=none; b=qKPLXTtyOet61U/mx5Q55pMCxj+wUeOyp5VqX3ySI1K7vNAu7Pb0/X8JYG7nl+UXHpx9fXSwDWcctnv6WCQGT+2PdxcDW79zRBK/kMwk2jBOGD6PYL1ZbavS6hhF5G6ERZZRrW6IlPHR8hJR82KmIAvdUTCZyWe2URSpboGkTIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783031664; c=relaxed/simple;
	bh=DCcp/rNyX0kMJ9uaimPFyW8fzwegG7eO1rb9Bto6O3k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bDliWXGEq+eecB0l9qhn7zRnvr/KUCldWOdn+zMygq17byPa8P1NykacuAbFuAvxwZlF2a8FYGuXmGiisNHBn6XLuuI3AZWZTaX8jtBBxs7+yCImlpW0k+fdUda2mbNL3KSbDA6UWF4euDpPzsKkGA2xftOWd90YiFyI2dexzYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2qqe6fb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2qqe6fb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE621F000E9;
	Thu,  2 Jul 2026 22:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783031658;
	bh=NSjget7Dw8F9UrT5QA5TorOd5GbTkAFIcDY8BAR1N7A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f2qqe6fbfuGOVGDhYwQYY2XMtPoM4LDcvaehddkx0fdpxKXO4nt0Td2fVTkLbP6qX
	 cv6Cy+LDxj43jLgNIPERhWIKh5C9Ke5smry6Q4DQsR+cYzfBlmgN7pvEfxKc7ViKn2
	 hNHcTCTdqYDAx6WJmkGXtBAtqsxxcBV3knJEKFwXSq7sKp+h7m9ShDdp4IAQzFokr8
	 xm8f0euKpKUvIb/lF/EBkAZWs0mXpFZqZb6EzswH5mV+VZ1g7ATAaZykkWGj4hSGA+
	 1XpUTJ+JnV0bwdaP292crou4IYr31hLXwz9/rf3fJtbhRxasrT2zfV7u/JPaOHFAGH
	 Cz/mDb7C+eR/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/10] HID: steam: Coalesce rumble packets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260702222145.1863104-5-vi@endrift.com>
References: <20260702222145.1863104-1-vi@endrift.com>
 <20260702222145.1863104-5-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 22:34:17 +0000
Message-Id: <20260702223417.8DE621F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Self-deadlock in workqueue callbacks due to double locking of `ste=
am->report_mutex`.
--

commit d77d97e537a9b42840329852b61faf365ef03366
Author: Vicki Pfau <vi@endrift.com>

HID: steam: Coalesce rumble packets

This commit introduces a delayed workqueue to rate-limit and coalesce rumble
packets to 20Hz on Steam Deck devices. It also modifies the existing rumble
work callback to add a mutex guard.

> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> index 34653ad383ac0..01b64194ec97b 100644
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c

[ ... ]

> @@ -603,10 +604,26 @@ static void steam_haptic_rumble_cb(struct work_stru=
ct *work)
>  {
>  	struct steam_device *steam =3D container_of(work, struct steam_device,
>  							rumble_work);
> +
> +	guard(mutex)(&steam->report_mutex);
>  	steam_haptic_rumble(steam, 0, steam->rumble_left,
>  		steam->rumble_right, 2, 0);

[Severity: High]
Will this cause a self-deadlock when playing force-feedback rumble effects?

This callback acquires report_mutex using guard(), but then immediately cal=
ls
steam_haptic_rumble(), which acquires the same mutex again:

steam_haptic_rumble() {
        ...
        mutex_lock(&steam->report_mutex);
        ret =3D steam_send_report(steam, report, sizeof(report));
        mutex_unlock(&steam->report_mutex);
        return ret;
}

Since Linux mutexes are not recursive, won't this hang the worker thread
and block any subsequent operations needing the report_mutex?

>  }
> =20
> +static void steam_coalesce_rumble_cb(struct work_struct *work)
> +{
> +	struct steam_device *steam =3D container_of(to_delayed_work(work),
> +							struct steam_device,
> +							coalesce_rumble_work);
> +
> +	guard(mutex)(&steam->report_mutex);
> +	steam_haptic_rumble(steam, 0, steam->rumble_left,
> +		steam->rumble_right, 2, 0);

[Severity: High]
Does this new callback have the same self-deadlock issue as described above,
since it also calls steam_haptic_rumble() while holding report_mutex?

> +
> +	if (steam->rumble_left || steam->rumble_right)
> +		schedule_delayed_work(&steam->coalesce_rumble_work, HZ / 20);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702222145.1863=
104-1-vi@endrift.com?part=3D5
