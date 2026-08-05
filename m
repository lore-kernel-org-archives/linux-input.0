Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE6413B293
	for <linux-input@vger.kernel.org>; Wed,  5 Aug 2026 02:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785896166; cv=none; b=X7X7VoyYSBOEh1Yl4tDnlJW5H2w5oDcowpTzbHPU+pyw0d/DNYN/BI1XoOEk5Ajr2neeOnpqrUpSnGNwwrH1blUilxAIAXVrpQrz7O/bk5QoLuGKYHOS76Vmix/WwWpQ/FLjzrCyGUasB/ONYWq7WQqSuHSzxwixbAF8dkrXr04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785896166; c=relaxed/simple;
	bh=jMJ+3zHIg2LO7ZYCQ/JVKX4tiKYuQ6ZcRQlEFluYDH8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eKjTlj7QWElXL35rUllyuDNWKLuBAX0nEtrqiNZZO2paRE5Q2MapxahPt0Do2Scb9N3oQbfpK3BlOrMGPtfk7Ejq8g+h3tNitd39KJK16M2+vh1CgtNGSQZfR9TnJTJFPoXibEjl2h73L+4/abEap3eW4oVJF+abt9OhiyUeciw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHoyH284; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHoyH284"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29EA41F000E9;
	Wed,  5 Aug 2026 02:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785896163;
	bh=MsRSuoDsdYo6Bw9vjHNvgsZF6D5N6KcjLWNFv35IqY4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BHoyH284RHEsgx513wH0si1nDu+Qr9n5TVgssS4lJUK8n4a20y5sttRTpa8xRWq/c
	 TzfkU6dsaI/wl6qLvviJRezy7NfaX7BFCKBR3pKdLAqta5V9lSS/IbWrT4iLaQOKGy
	 Lt7+vIpacjVxhlx1Rd+8II0L7syqkvBK+eXg/iFnuQeNpbOrSbyaq2A4Uahned9pEa
	 JKi9UoiUPrw3hULVzwGPmQk6H11eg8Q1hsgj7/j0jbBbeWoLLrZA1aBq1B9APUw/91
	 1jcgkpXE5Ef6BDdr8JPm9NXWV1sZyZ3vCZwbDoaqO4/+YByLZgArJZSxPqNc/i8uX+
	 Ui1ssjSAAIS8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] HID: steam: Clean up locking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260805015116.3884465-5-vi@endrift.com>
References: <20260805015116.3884465-1-vi@endrift.com>
 <20260805015116.3884465-5-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 02:16:01 +0000
Message-Id: <20260805021603.29EA41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [High] Self-deadlock in `steam_unregister` due to `report_mutex` acquisit=
ion.
- [High] AB-BA lock inversion between `steam_devices_lock` and `steam->repo=
rt_mutex`.
- [Medium] Inverted lizard mode logic in `steam_param_set_lizard_mode` brea=
ks the parameter.
- [Medium] Missing `report_mutex` in `steam_get_conn_status` creates a race=
 condition with concurrent hardware access.

Pre-existing issues:
- [High] Use-after-free caused by cancelling workqueues before stopping the=
 hardware.
- [High] Resource leak and use-after-free of `power_supply` object on probe=
 failure.
--

--- Patch [4]: [PATCH 4/5] HID: steam: Clean up locking ---
commit 4a13ea9d8650f6b804ba3ebe1f98c65bb697f0c4
Author: Vicki Pfau <vi@endrift.com>

HID: steam: Clean up locking

This cleans up several issues with locking behavior, including RCU accesses
not being guarded behind a lock.

> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> index 2d60b79441b69..87af4bee9f5ff 100644
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c

[ ... ]

> @@ -728,7 +727,6 @@ static int steam_get_conn_status(struct steam_device =
*steam)
>  	else
>  		report_id =3D 0;
> =20
> -	guard(mutex)(&steam->report_mutex);
>  	ret =3D steam_send_report_id(steam, cmd, sizeof(cmd), report_id);

[Severity: Medium]
Will this removal create a race condition with concurrent hardware access?
During steam_probe() in hid-steam.c, the hardware is opened and interrupts
are enabled before steam_get_conn_status() is called. If the device
immediately sends a connection event, the interrupt handler schedules
steam_work_connect_cb(), which acquires report_mutex and sends feature
reports. Without the mutex here, can the control transfers from
steam_get_conn_status() interleave with the worker's transfers and
confuse the controller firmware?

[ ... ]

> @@ -1728,7 +1728,9 @@ static int steam_probe(struct hid_device *hdev,
>  			steam->connected =3D true;
>  	}
>  	if (steam->connected) {
> +		mutex_lock(&steam->report_mutex);
>  		ret =3D steam_register(steam);
> +		mutex_unlock(&steam->report_mutex);
>  		if (ret) {
>  			hid_err(hdev,
>  				"%s:steam_register failed with error %d\n",
>  				__func__, ret);
>  			goto err_hw_close;

[Severity: High]
This isn't a bug introduced by this patch, but does steam_probe() leak
the power_supply object if steam_register() fails? If steam_input_register()
or steam_sensors_register() fails inside steam_register(), it jumps to an
error label and returns an error without unregistering the battery created
via steam_battery_register(). The error propagates here, skipping
steam_unregister() and jumping to err_hw_close. Doesn't this leave the
power_supply device registered while devm frees the steam_device, leading to
a use-after-free when userspace interacts with the stale power_supply?

[ ... ]

> @@ -1787,19 +1789,17 @@ static void steam_remove(struct hid_device *hdev)
>  	if (steam->quirks & STEAM_QUIRK_WIRELESS) {
>  		hid_info(hdev, "Steam wireless receiver disconnected");
>  	}
> +	guard(mutex)(&steam->report_mutex);
>  	steam_unregister(steam);
>  	hid_hw_stop(hdev);
>  }

[Severity: High]
Can holding report_mutex across steam_unregister() cause a self-deadlock?
When a device is removed, steam_remove() acquires report_mutex here and cal=
ls
steam_unregister(). steam_unregister() calls cancel_work_sync() on
rumble_work, and steam_input_unregister(). If the rumble work is running in
steam_haptic_rumble_cb(), it will attempt to acquire the same report_mutex
and block forever. Additionally, unregistering the input device triggers
the steam_input_close() callback, which also attempts to acquire this
non-recursive report_mutex.

[Severity: High]
This is a pre-existing issue, but is there a use-after-free window here
in steam_remove() due to the order of teardown? cancel_work_sync() for
work_connect is called just before the quoted code, but hid_hw_stop() is
called at the end. If an interrupt arrives between the cancellation and
hid_hw_stop(), steam_raw_event() can process it and re-queue the work.
When steam_remove() returns, devm frees the steam_device, but the queued
work could later execute steam_work_connect_cb() on the freed memory.

[ ... ]

> @@ -2631,6 +2624,8 @@ static int steam_param_set_lizard_mode(const char *=
val,
>  {
>  	struct steam_device *steam;
>  	int ret;
> +	bool client_opened;
> +	unsigned long flags;
> =20
>  	ret =3D param_set_bool(val, kp);
>  	if (ret)
> @@ -2638,8 +2633,13 @@ static int steam_param_set_lizard_mode(const char =
*val,
> =20
>  	mutex_lock(&steam_devices_lock);
>  	list_for_each_entry(steam, &steam_devices, list) {
> -		if (!steam->client_opened)
> +		spin_lock_irqsave(&steam->lock, flags);
> +		client_opened =3D steam->client_opened;
> +		spin_unlock_irqrestore(&steam->lock, flags);
> +		if (client_opened) {
> +			guard(mutex)(&steam->report_mutex);
>  			steam_set_lizard_mode(steam, lizard_mode);
> +		}
>  	}
>  	mutex_unlock(&steam_devices_lock);
>  	return 0;

[Severity: High]
Does acquiring report_mutex while holding steam_devices_lock introduce an
lock inversion? Here in steam_param_set_lizard_mode(),
steam_devices_lock is acquired first, followed by report_mutex. However,
concurrently in steam_probe() or steam_work_connect_cb(), report_mutex is
acquired first, and then steam_register() is called, which attempts to
acquire steam_devices_lock to add the device to the list. Could this lead
to an indefinite deadlock?

[Severity: Medium]
Was the condition intentionally changed from !steam->client_opened to
if (client_opened)? It seems like this applies the lizard mode settings
to devices actively controlled by the Steam client, and ignores devices that
actually need the fallback mappings.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805015116.3884=
465-1-vi@endrift.com?part=3D4
