Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58DA26ED41
	for <linux-input@vger.kernel.org>; Thu,  6 Aug 2026 02:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785984418; cv=none; b=EjURscIuyla1fyHhBlJsVy9Xd7tsjuOHabzQWMuQXwHXfsNKKAtk++40p26zzTQ/TIdp0w5YVhkTe5q1hPkbB5aJjny3DenQ/lav0dBL8ZOwuXoIDygi1kBH75rIX1VPSiXv5gO6oQ9cKTBEd4J8/7G4NxgSWk6nAv+VuywwqIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785984418; c=relaxed/simple;
	bh=foDjANu+5jgYJ+FTubsHaxfhyuS0vnaBdcCeLa+V6lo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pDNKgUxLkMTqbrZ1fxYn22GuYfFeZ19eToYSgpjvdnptk0A5NG52Lhngjz3hEGouPTQ6GjX26yiaDC273yjwewSU08BS+v4/MH+eXylkEDyDRU/QucnFc7N6TSlX/PrkkNl8LHOXIINb3DhlNCPi4Yynjta0hx+C9zJHG0UIeoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CkSpEIpJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CkSpEIpJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 019191F000E9;
	Thu,  6 Aug 2026 02:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785984414;
	bh=bg+Ct++Zo+03cuq6p9WilBCMT/zvSCBFiVhAnJbDPAA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CkSpEIpJs++x7dAURDmKV5gEj9xHmdBzK5A7ZOG571TQ3n7bhWpge/LiIdyMbBOL3
	 /aYyHSc2LbyEs6IYGBYCf+X8RLJNzCcIB1jOA6ZwhlN2xUuqNauSEh/9TTxGPyWDo/
	 1korJP5WZT+p5QfjYJhs3rwR4sPf6rhRslwvM/LrtYNMo1tMTgeFv4sBcVP+c0LAAr
	 f+T1H5JxJSpUoLp2+v3cn+nVrEMQggky4UTRzsmq/dM6CxK9yRN6Yv3eviyj4egBz2
	 +Zfj+n332N8VaKtWNQIfE2oH7xkNF/UKfhOUImUyqjLKpZlPvQA/OcWqthsfYpyT6y
	 Z/yeQSz95A/VA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/6] HID: steam: Clean up locking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260806022653.93939-6-vi@endrift.com>
References: <20260806022653.93939-1-vi@endrift.com>
 <20260806022653.93939-6-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 02:46:53 +0000
Message-Id: <20260806024654.019191F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Guaranteed self-deadlock during device registration and unregistra=
tion due to recursive acquisition of `steam->report_mutex`.
--

--- Patch [5]: [PATCH v2 5/6] HID: steam: Clean up locking ---
commit f00f469b42e54055547cfa7401a79f8895766441
Author: Vicki Pfau <vi@endrift.com>

HID: steam: Clean up locking
   =20
This cleans up several issues with locking behavior, including RCU accesses
not being guarded behind a lock.

> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> index 8c97302c35deb..01801f2a58864 100644
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c
[ ... ]
> @@ -921,9 +920,10 @@ static int steam_input_open(struct input_dev *dev)
>  	 */
>  	if (!(steam->quirks & (STEAM_QUIRK_DECK | STEAM_QUIRK_IBEX))) {
>  		spin_lock_irqsave(&steam->lock, flags);
> -		set_lizard_mode =3D !steam->client_opened && lizard_mode;
> +		client_opened =3D steam->client_opened;
>  		spin_unlock_irqrestore(&steam->lock, flags);
> -		if (set_lizard_mode)
> +		guard(mutex)(&steam->report_mutex);

[Severity: High]
Does this create a self-deadlock during device registration?

When steam_register() is called, it now holds steam->report_mutex. It then
calls steam_input_register(), which registers the input device. If an input
handler (like ledtrig-input-events) is present, the input core will
synchronously open the device, calling steam_input_open().

The call chain would look like:

steam_register()
  mutex_lock(&steam->report_mutex);
  steam_input_register(steam);
    input_register_device()
      ... (input core handler connect)
      input_open_device()
        steam_input_open()
          guard(mutex)(&steam->report_mutex);  <-- deadlocks here

The same sequence applies during steam_unregister() when it calls
steam_input_close() and steam_sensor_close().

> +		if (!client_opened && lizard_mode)
>  			steam_set_lizard_mode(steam, false);
>  	}
> =20
[ ... ]
> @@ -1379,14 +1374,17 @@ static int steam_register(struct steam_device *st=
eam)
>  {
>  	int ret;
> =20
> +	mutex_lock(&steam->report_mutex);
>  	/*
>  	 * This function can be called several times in a row with the
>  	 * wireless adaptor, without steam_unregister() between them, because
[ ... ]
> @@ -1439,9 +1439,11 @@ static void steam_unregister(struct steam_device *=
steam)
>  	hid_info(steam->hdev, "Steam %s '%s' disconnected",
>  			steam->quirks & STEAM_QUIRK_DECK ? "Deck" : "Controller",
>  			steam->serial_no);
> +	mutex_lock(&steam->report_mutex);
>  	steam_battery_unregister(steam);
>  	steam_sensors_unregister(steam);
>  	steam_input_unregister(steam);
> +	mutex_unlock(&steam->report_mutex);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806022653.9393=
9-1-vi@endrift.com?part=3D5
