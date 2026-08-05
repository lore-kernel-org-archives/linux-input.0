Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BC639B49D
	for <linux-input@vger.kernel.org>; Wed,  5 Aug 2026 02:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785895743; cv=none; b=ATqRBhVkPtr09x/DATl9zLOCYOH7l6suMRHwBoWappWZGQagRQG2G+p6521JxAxNS+Fxdaib79g7g/5IOkBmsKLmGEG7PEB1alA5vfW21W7KdU+biwhUJKZBsaLa0hYx0L1wTJo9+/P58Nx/iUnIF8DBExhG56K9O5RDQeO3Yfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785895743; c=relaxed/simple;
	bh=GtW37uLKRDLTbybD/RcdIF9Xa1tCsxqwNpwgiMoHwz0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=erZAtzl0APKq9yR0wh6gxTxOZrMtUtxeUjl+Fdo6UWEUVaoM399w1s1JsVAcBOMlJDptJRlkuKL5d5MCrodXNuipEFqj0xMCW6BoXrMgbMWUONmCo4amicCaMTq58cIHX+ndSFp8pJdShDj2xCO6mIT34D7o0MyuZO5cMK4BGyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YSXqaE1X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YSXqaE1X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 721DE1F000E9;
	Wed,  5 Aug 2026 02:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785895741;
	bh=Ifob/ItYokAVsAj1GzOSoaVmB4UhMeMtBkqwt8XpQRQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YSXqaE1XWEhbOmsVD7HX3yO2iBMvrRxDk98P8HlGE+06FcUwAGWdCoAYMejF8YkfG
	 YuZ2rfSrB1d9Nxxd1IRtLFxpqTKrTAiFIVqNTBGZ1xgJ6DoNcHCXCm+D+tE0g0IkUt
	 kpD7rmiQfybZ+nFSwlG4bDu5IFGirPaotP7s2O/mcV5Xvcxwxat9UB4xV1lElaTZFG
	 Zn1tXch/MVVQULWHfp7Xi/TbrT2m5/9bcWxPGJSUM6y0O/03Cix9tc4EYsZzuR+LIr
	 IugEYfqOWOwcoVfJnEp1qvTtRA/qsIShp/A/YDzBg8Xb4XX//YUD6yXhfxje+TfgXz
	 CQ6aiCt+CRsNw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] HID: steam: Zero out inputs when disabling gamepad
 mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260805015116.3884465-6-vi@endrift.com>
References: <20260805015116.3884465-1-vi@endrift.com>
 <20260805015116.3884465-6-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 02:09:01 +0000
Message-Id: <20260805020901.721DE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] AB-BA deadlock between `report_mutex` and workqueues during device=
 unregistration.

Pre-existing issues:
- [High] Concurrent unregistration in `steam_probe` error path leads to a d=
ouble free of input devices.
--

--- Patch [5]: [PATCH 5/5] HID: steam: Zero out inputs when disabling gamep=
ad mode ---
commit 7a64f604e0a34949b1434a03544f0ca71ef9305f
Author: Vicki Pfau <vi@endrift.com>

HID: steam: Zero out inputs when disabling gamepad mode

When gamepad mode is disabled the gamepad input devices will stop receiving
updates. However, in the case where there are buttons still pressed this
will appear as an indefinitely-held button. Instead we should zero out the
inputs to make it look like things are all released.

> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> index 87af4bee9f5ff..93a6f4e17fb75 100644
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c
> @@ -1490,11 +1490,76 @@ static void steam_mode_switch_cb(struct work_stru=
ct *work)
> =20
>  	guard(mutex)(&steam->report_mutex);

[Severity: High]
Is there a risk of an AB-BA deadlock here during device unregistration?

If steam_remove() is called and acquires steam->report_mutex, it then calls
steam_unregister(). If steam_unregister() then calls
cancel_delayed_work_sync(&steam->mode_switch) while the mutex is held:

steam_remove()
  guard(mutex)(&steam->report_mutex);
  steam_unregister(steam);
    cancel_delayed_work_sync(&steam->mode_switch);

This workqueue callback would block here attempting to acquire the same
steam->report_mutex, while steam_remove() blocks waiting for this work
to finish. Since the wait condition is permanent, this could hang the USB/H=
ID
hotplug subsystem.

[ ... ]

[Severity: High]
This is a pre-existing issue, but could the error path in steam_probe() race
with disconnect events and cause a double-free of the input devices?

If steam_probe() fails in hid_add_device(), it jumps to err_steam_unregister
and calls steam_unregister() if steam->connected is true (checked locklessl=
y):

steam_probe():
err_steam_unregister:
	if (steam->connected)
		steam_unregister(steam);

Because hid_device_io_start() was already called, a concurrent disconnect
event can queue steam_work_connect_cb(). If that worker runs, sees
connected =3D=3D false, and also calls steam_unregister(steam), both thread=
s can
concurrently enter steam_input_unregister() since the error path does not
hold report_mutex.

Both threads would then read steam->input, find it valid, set it to NULL
locklessly, and call input_unregister_device() on the same pointer:

steam_input_unregister():
	input =3D rcu_dereference(steam->input);
	...
	RCU_INIT_POINTER(steam->input, NULL);
	...
	input_unregister_device(input);

Can this lead to a double-free of the input_dev structure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805015116.3884=
465-1-vi@endrift.com?part=3D5
