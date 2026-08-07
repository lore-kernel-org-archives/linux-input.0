Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1FD3EC83F
	for <linux-input@vger.kernel.org>; Fri,  7 Aug 2026 23:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786146827; cv=none; b=Hx8hufR3R4Fxvz1RSPfYgyWimigbFT1Y4VujigJS2G245EPlDD5CdOufds6OIzEZ+NQP0QZIbpknhmJ4chK3wyCBthTuLTu2E8mhIAmsHKcCQnQEFk3if3CWOiV6bq46M7Rt72kAwGbVOLFgkDO2eeU1/qrMGKk/5prQuZ72cIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786146827; c=relaxed/simple;
	bh=+rAh20Ep2Iur2JTwsBqCKGbgLW5lbGTs48vp7/floGg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bWEm54lXILKFeorvN4MswuUj/XMVelB/nfh3+Sjq6eb3TnHOzff0t+nLn2Vib7bxapHFF5Oqj1WJEhCbqQ+7KU0tCI6ETYEFU0HIr14/rtp2S+OPueafP18jJj40RCQA325GolZf5kMU+Z+P1ROdYHfHr6wAbRZgdEMI7lbBEN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGsu5DUN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGsu5DUN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1AEA1F000E9;
	Fri,  7 Aug 2026 23:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786146825;
	bh=VOf5EV44mHYkpgSjyd+++208GWxycRx+NLx9JgiaPTg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aGsu5DUNnaljYV6q/EmdH5M5PCooiU1aJK1j0aAslvBx9NnKqlppzKo33FWmnl5Ay
	 CIhgSbu2d+rybqjn27iRlkAmC9Ns9PNGnRM4PKG4YIw92yZp0NPUYPuJ7+EgiecFgP
	 HeNFJyU5/P/n5C5tpreK/zj3O+6D7C3cl0VEhQr46J8LRRL0umZXoahdS8ykT5+aiR
	 o+1fwWgbeFlUboVyVhEuP+I0R1pVvPsW+yCqFTvHE0lCrblOBEg735WZ7HHUsDHSO1
	 SmQLa/dKRB/LUhnaenwclgulhoPqdshqMOSQkwu6Pc3iITZcqx4dP67UxZvT4Vrhpm
	 73Zz6x8BWm8gw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/6] HID: steam: Clean up locking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260807232339.2799205-6-vi@endrift.com>
References: <20260807232339.2799205-1-vi@endrift.com>
 <20260807232339.2799205-6-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 23:53:45 +0000
Message-Id: <20260807235345.A1AEA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Missing `report_mutex` acquisition in `steam_register` causes conc=
urrent HID report sequence corruption.

Pre-existing issues:
- [High] Use-After-Free of `steam->client_hdev` in `steam_raw_event` due to=
 incorrect teardown sequence.
--

--- Patch [5]: [PATCH v4 5/6] HID: steam: Clean up locking ---
commit b7298af16f52c40e58c726cf4668c6523e3cddaf
Author: Vicki Pfau <vi@endrift.com>
Date:   Fri Aug 7 23:23:36 2026 +0000

    HID: steam: Clean up locking
   =20
    This cleans up several issues with locking behavior, including RCU acce=
sses
    not being guarded behind a lock.

> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> index d95296b28f92b..95e252665351c 100644
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c

[ ... ]

> @@ -633,7 +634,6 @@ static int steam_exchange_report(struct steam_device =
*steam, u8 *cmd, int csize,
>  	unsigned int retries =3D 5;
>  	int ret;
> =20
> -	guard(mutex)(&steam->report_mutex);
>  	do {
>  		ret =3D steam_send_report(steam, cmd, csize);
>  		if (ret < 0)

[ ... ]

> @@ -1380,13 +1376,16 @@ static int steam_register(struct steam_device *st=
eam)
>  {
>  	int ret;
> =20
> +	mutex_lock(&steam->registration_mutex);
>  	/*
>  	 * This function can be called several times in a row with the
>  	 * wireless adaptor, without steam_unregister() between them, because
>  	 * another client send a get_connection_status command, for example.
>  	 */
> -	if (steam->registered)
> +	if (steam->registered) {
> +		mutex_unlock(&steam->registration_mutex);
>  		return 0;
> +	}
> =20
>  	/*
>  	 * Unlikely, but getting the serial could fail, and it is not so

[Severity: High]
Does this leave the HID report sequence unprotected during device registrat=
ion?

Because the patch removes the report_mutex from steam_exchange_report() and
steam_set_lizard_mode(), their callers are now expected to hold it. However,
steam_register() doesn't acquire report_mutex before it continues execution
and calls steam_get_serial() (which calls steam_exchange_report()) and
steam_set_lizard_mode().

For example, a wireless connection immediately after USB enumeration trigge=
rs
steam_raw_event() -> steam_do_connect_event(), which queues
steam_work_connect_cb to call steam_register(). At the same time, the
original steam_probe() thread continues and calls steam_get_conn_status().=
=20

Since steam_register() lacks the report_mutex, its HID transmissions could=
=20
interleave with the internally-locked steam_get_conn_status() operations.
Can this lead to corrupted replies or matching a reply to the wrong request?

[ ... ]

> @@ -2470,6 +2466,7 @@ static int steam_raw_event(struct hid_device *hdev,
>  	if (!steam)
>  		return 0;
> =20
> +	guard(spinlock_irqsave)(&steam->lock);
>  	if (steam->client_opened)
>  		hid_input_report(steam->client_hdev, report->type, data, size, 0);
> =20

[Severity: High]
This is a pre-existing issue, but could this lead to a use-after-free of
steam->client_hdev if an event arrives during teardown?

In steam_remove(), hid_destroy_device(steam->client_hdev) is called to
destroy the child HID device, but hid_hw_stop(hdev) is not called until the
very end of the function. This means hardware interrupts can still deliver
raw events.=20

If steam_raw_event() triggers after the child device is destroyed, but
before steam->client_opened is explicitly cleared under the lock in
steam_remove(), it will dereference the freed steam->client_hdev pointer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807232339.2799=
205-1-vi@endrift.com?part=3D5
