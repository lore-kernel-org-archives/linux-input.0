Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B535E29DB64
	for <linux-input@vger.kernel.org>; Thu,  6 Aug 2026 02:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785984104; cv=none; b=T62I4ynrK6AEiQkIxuBP6MRt4H6HCEbLWgehsSGjReWnRqa3vmPeGQrITb1thxU3vKrTdNA4oz33nCLXnkJ45Ejpd4zzUa+y1l5ut3nTXco2epbO4LhpKQPiDpY9jBjJCa6uzeLmcEEYeucAdiBlnRKjXc/XiXLLexyXNJ2CNuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785984104; c=relaxed/simple;
	bh=WjhPir2jjUUieq1Bop4ca8At9090dD2ycYoh2AM8SIU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mkEokgqrxzQmlw5Kbzvki42+ZWs/WPw99/YfRGd2hPok9ThgNDa+r8QjeaBiG6WkWcko5/EfeDBntvufNxsTxbs4djIR3qreggdkKCe1YFGNg2UI5Z5UBJNzV0KCdeHuJ92p9+l8OMxoDW/YrpKv299GNt9TycLG4l17jDLkI+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBwp57BU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBwp57BU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4356B1F000E9;
	Thu,  6 Aug 2026 02:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785984103;
	bh=j1uy/vwP2xnA17vMTcaRVjIEUbtOKfXwQOCTWrXq5LI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NBwp57BUpwOMO5tOcTpfBmRBzV12SsH3te+WQ4wjYksvxQ13wnr0Ds88rFA/Nn+KD
	 6kZzX0OF5Y5RlTo9Sqis7awlzmbkress9/oj46VtpW3YlBAfEesh6M6e5tXCjkS9Ne
	 FqgQfFEEaOxhhGPz0+pmklPqYFaH/uG+aSi982scP4TVMZWSH4vQDkr79CDlP2fSZc
	 tHS1SHd/l2QrcIh072cc5t+W1zxOjlbXBRnRuKmKIcM6wx5kOS3dXrwZEtXXXSzI8P
	 xH8wMQDfQaBdjaE586yJWGFOIeZ8Pyz1/l7/E/oA+VOwUUaKVhPRKdBgqbXrGBRgKx
	 N5DsbMrEe4kgw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/6] HID: steam: Unregister battery on partial
 registration error
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260806022653.93939-2-vi@endrift.com>
References: <20260806022653.93939-1-vi@endrift.com>
 <20260806022653.93939-2-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 02:41:42 +0000
Message-Id: <20260806024143.4356B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Medium] Unregistering the battery in the error path prevents it from bei=
ng re-registered on a subsequent retry of steam_register() because `steam->=
serial_no[0]` is not cleared.

Pre-existing issues:
- [High] The local variable `do_add` is conditionally initialized but uncon=
ditionally evaluated if `steam_register()` is called when `steam->serial_no=
[0]` is already set.
- [High] Teardown asymmetry in the `steam_probe` error path allows backgrou=
nd work to register devices against a freed driver struct.
- [High] The unregister functions read RCU-protected pointers without write=
r-side serialization, leading to potential double-frees if executed concurr=
ently.
--

--- Patch [1]: [PATCH v2 1/6] HID: steam: Unregister battery on partial reg=
istration error ---
commit 44ddde383b3d91088838e48fa3234971272a3bbc
Author: Vicki Pfau <vi@endrift.com>

HID: steam: Unregister battery on partial registration error

This commit adds missing code to unregister the battery if later
registration steps fail. This prevents a lingering power_supply object from
being left over.

> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> index 6199f67f3c4cd..967f12c7a599a 100644
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c
[ ... ]
> @@ -1199,6 +1199,7 @@ static int steam_register(struct steam_device *stea=
m)
>  steam_register_sensors_fail:
>  	steam_input_unregister(steam);
>  steam_register_input_fail:
> +	steam_battery_unregister(steam);

[Severity: Medium]
Will this prevent the battery from being re-registered on a subsequent retr=
y?

If steam_register() fails, the error path now unregisters the battery.
However, steam->serial_no[0] remains populated.

On a subsequent retry from steam_work_connect_cb(), the populated serial
number bypasses the initialization block, skipping steam_battery_register().

>  	return ret;
>  }

While reviewing this, I noticed a few pre-existing issues:

drivers/hid/hid-steam.c:steam_register() {
	bool do_add;
	...
	if (!steam->serial_no[0]) {
		...
		do_add =3D true;
	}
	...
	if (do_add) {

[Severity: High]
This is a pre-existing issue, but does this evaluate an uninitialized
variable?

If steam_register() is called when steam->serial_no[0] is already populated,
do_add is left uninitialized but is evaluated later in the function.


drivers/hid/hid-steam.c:steam_probe() {
	...
err_steam_unregister:
	if (steam->connected)
		steam_unregister(steam);
err_hw_close:
	hid_hw_close(hdev);
err_hw_stop:
	hid_hw_stop(hdev);
err_cancel_work:
	cancel_work_sync(&steam->work_connect);
	...
}

[Severity: High]
This is a pre-existing issue, but could this error path lead to a
use-after-free?

If a wireless device schedules work_connect and probe fails,
steam_unregister() is called before cancel_work_sync().

If work_connect hasn't initialized the device yet, steam_unregister()
returns without effect. Then cancel_work_sync() waits for work_connect to
finish, allowing it to register input devices against the steam driver
struct which devres will free after probe returns.


drivers/hid/hid-steam.c:steam_battery_unregister() {
	...
	rcu_read_lock();
	battery =3D rcu_dereference(steam->battery);
	rcu_read_unlock();

	if (!battery)
		return;
	RCU_INIT_POINTER(steam->battery, NULL);
	...
}

[Severity: High]
This is a pre-existing issue, but can this lead to a double-free if executed
concurrently?

The unregister functions read the RCU-protected pointers without writer-side
serialization.

If steam_probe() error path calls steam_unregister() concurrently with
work_connect() calling a failure path in steam_register(), both threads
might read the same non-NULL pointer and concurrently free the same
resources.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806022653.9393=
9-1-vi@endrift.com?part=3D1
