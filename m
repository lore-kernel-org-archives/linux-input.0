Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C923B27FB
	for <linux-input@vger.kernel.org>; Wed, 23 Sep 2026 03:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790134863; cv=none; b=otMBu0i77UI8JYjz+iVP5AFGUrvQKr6rs/NJTlwwULhJkC/fgXr5MYqE6J5wwuI8J1RPWiso1BpNTGhIkeGwp2bdvr64GzegRLG2oMmtsTLIsosHX8stM0PF5oEo3O2MdWQ+t6qTgMZbMui4CePLANt2qsUlUFeu8a0apbK1oBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790134863; c=relaxed/simple;
	bh=Zw1YuiAS0na63NLUFNv8D4pLnD/he3QMQIVjRGhW+mw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IF8qZ+7VI0VBDvALn7BNgzq0Y4ILDopjFulsiQr2Y9hBd/S9oVNUoOkhuyVZqArsGjPf0Re+UDIB2/IXHgHlX1n/QcxQ1Z8CU6ziRza6RbbkO2YJMEyMH1jg7ERt9rYfcX6tblrhZJTA9vYwmpK11E1caLpS2oayfg3HVS1fqAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HdJL0jxR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HdJL0jxR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92D691F000FF;
	Wed, 23 Sep 2026 03:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790134860;
	bh=K4Oi9UnzIUX4y6F48NIPKHeAf7XUo62qmH7d5OCW3EY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HdJL0jxR0i2Jiz3akTDDCT6zFN1ckCnOfrHowNQ6yhKy1N6xt6NwtseTLw7lD4AZ0
	 fajsv/tnmW0PCTP4snkYAB6LVWoLvNdtNaWDWKO2btNbvGXTRT9+HYVgCxgr1/ZQDK
	 xSow3c2zrITCKdx95yaGnsT+sqnCqm7xeBzPWrC4GDMdWpKPqSv+tzKxDgSdDaRfKC
	 qXN87pXv2ZT66XF8Rkvh2GlQQBaW9lPpTvFsYiKd8FhJ/caz3l9MHim9+/q+JQBFFg
	 Otut5R3dZ46xxSYw9DavqEVreUQGGwg2CX2z/ZoBfKSqtT/LC5SUHTg/xXvdaFx76V
	 fEWtxPHAEpmWA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: playstation: Fix DualShock4 dongle hotplug work
 use-after-free
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fan Wu" <fanwu01@zju.edu.cn>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260923032634.417433-1-fanwu01@zju.edu.cn>
References: <20260923032634.417433-1-fanwu01@zju.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 03:41:00 +0000
Message-Id: <20260923034100.92D691F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] hid: redundant synchronization due to false-positive race
--

commit 13619e48822a1be542eef83182d65e856c6ee40b
Author: Fan Wu <fanwu01@zju.edu.cn>

HID: playstation: Fix DualShock4 dongle hotplug work use-after-free
   =20
This commit attempts to fix a use-after-free issue by adding synchronization
state (dongle_hotplug_worker_initialized) and clearing it during error and
teardown paths. It claims this prevents the raw_event handler from scheduli=
ng
work concurrently during probe() and remove().

> HID: playstation: Fix DualShock4 dongle hotplug work use-after-free
>
> dualshock4_remove() cancels ds4->dongle_hotplug_worker while input
> reports can still arrive: hid_hw_close() and hid_hw_stop() only run
> later in ps_remove(), so a dongle connect report in that window makes
> dualshock4_dongle_parse_report() schedule the just-cancelled work
> again. ds4 is devm-managed and freed once ps_remove() returns, so
> dualshock4_dongle_calibration_work() then runs on freed memory.
>
> The dualshock4_create() error path has the same exposure. Reports are
> already flowing when it runs, because ps_probe() starts and opens the
> device before creating it, so the connect branch of the dongle report
> handler can also queue ds4->output_worker through its lightbar update.

Is this race actually possible?

Looking at the HID core, __hid_input_report() uses down_trylock() on
hdev->driver_input_lock and drops incoming reports when the lock is held.

During initialization, hid_device_probe() acquires this exact lock before
calling the driver's probe function (ps_probe()). The driver never calls
hid_device_io_start(), meaning this lock is held for the entire duration
of ps_probe(), including all of dualshock4_create().

Similarly, during teardown, hid_device_remove() acquires this lock before
calling the driver's remove function (ps_remove()), meaning it is held
for the entire duration of dualshock4_remove().

Since dualshock4_dongle_parse_report() is called from the raw_event
handler, which is fed by __hid_input_report(), it cannot execute concurrent=
ly
with either dualshock4_create() or dualshock4_remove().

> diff --git a/drivers/hid/hid-playstation.c b/drivers/hid/hid-playstation.c
> index f9dc9378cf777..1b7a18fbeeb4b 100644
> --- a/drivers/hid/hid-playstation.c
> +++ b/drivers/hid/hid-playstation.c
[ ... ]
> @@ -2618,10 +2619,12 @@ static int dualshock4_dongle_parse_report(struct =
ps_device *ps_dev, struct hid_r
> =20
>  			dualshock4_set_default_lightbar_colors(ds4);
> =20
> -			scoped_guard(spinlock_irqsave, &ps_dev->lock)
> +			scoped_guard(spinlock_irqsave, &ps_dev->lock) {
>  				ds4->dongle_state =3D DONGLE_CALIBRATING;
> =20
> -			schedule_work(&ds4->dongle_hotplug_worker);
> +				if (ds4->dongle_hotplug_worker_initialized)
> +					schedule_work(&ds4->dongle_hotplug_worker);
> +			}

[Severity: Medium]
Does this flag check actually do anything in dualshock4_dongle_parse_report=
(),
given that this function cannot run concurrently with the teardown sequence?

>  			/* Don't process the report since we don't have
>  			 * calibration data, but let hidraw have it anyway.
[ ... ]
> @@ -2677,8 +2680,12 @@ static void dualshock4_remove(struct ps_device *ps=
_dev)
> =20
>  	cancel_work_sync(&ds4->output_worker);
> =20
> -	if (ps_dev->hdev->product =3D=3D USB_DEVICE_ID_SONY_PS4_CONTROLLER_DONG=
LE)
> +	if (ps_dev->hdev->product =3D=3D USB_DEVICE_ID_SONY_PS4_CONTROLLER_DONG=
LE) {
> +		scoped_guard(spinlock_irqsave, &ds4->base.lock)
> +			ds4->dongle_hotplug_worker_initialized =3D false;
> +
>  		cancel_work_sync(&ds4->dongle_hotplug_worker);
> +	}
>  }

[Severity: Medium]
Does clearing this flag in dualshock4_remove() prevent a race, or is the
incoming report path already physically blocked by hdev->driver_input_lock?

[ ... ]
> @@ -2858,6 +2868,18 @@ static struct ps_device *dualshock4_create(struct =
hid_device *hdev)
> =20
>  err:
>  	ps_devices_list_remove(ps_dev);
> +err_cancel:
> +	scoped_guard(spinlock_irqsave, &ps_dev->lock)
> +		ds4->output_worker_initialized =3D false;
> +
> +	cancel_work_sync(&ds4->output_worker);
> +
> +	if (ds4->dongle_hotplug_worker_initialized) {
> +		scoped_guard(spinlock_irqsave, &ps_dev->lock)
> +			ds4->dongle_hotplug_worker_initialized =3D false;
> +
> +		cancel_work_sync(&ds4->dongle_hotplug_worker);
> +	}
>  	return ERR_PTR(ret);
>  }

[Severity: Medium]
Since hdev->driver_input_lock is held throughout dualshock4_create(), are
these flag checks and locks on the error path protecting against a race that
is impossible to hit?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923032634.4174=
33-1-fanwu01@zju.edu.cn?part=3D1
