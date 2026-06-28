Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F45034CDD
	for <linux-input@vger.kernel.org>; Sun, 28 Jun 2026 02:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782612371; cv=none; b=j3HWD8O+2vEW6YXcTwnDlpNWPQuIXAsT82UstzMAgDFNPGTFFMkuL/4bcVCGZuFisW6FR2UwVjJJT9jKDtrhOp3m9n5Shy1rbp4AV1FMDcy6QbxnTrH2SyiKQSqikpfANpg7ULtRPzmAdlVMmsgKADdYkHyXIqCZU7wlubrrvUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782612371; c=relaxed/simple;
	bh=TJ5xAZp0yOqJYrz3SAQ22z81CQXSTQ5s2vGD7XIcaZQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DdM1+hSxljEUbNpnvOlE4/S1mhh6/J8HM3a6vG1BYrf35KzRPQQnlk4p5hDSrgsGQPYZ8wJ3qjgr3LamzSRblEgyerl9HhiPnV671n1pGctnvOli8kHK1XcxCBdXPjO3JTkcYcxblJds4JhU1PHB+/zLno4zYFEnUCA3T2dqQTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BaeW8Rsz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BaeW8Rsz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAFA51F000E9;
	Sun, 28 Jun 2026 02:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782612370;
	bh=nBgVI8d84KUH0JSgGVGlbeQQMT+glFK9Pfd4WRObv28=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BaeW8Rszuxmjq4bSyVqIrmuAJDlsj2pNckSMWHSN+RzQIgn2ECxyEf2/wOJK4Bd6s
	 Bb88ANjEQsZ0RrWtKCcWnBdWpE1OpOG9JUqKfWbyTULQzqISeid+THXFQNTc06cXVB
	 dSKnGNxfvbIP/WuPgQKVVsYU2Pe5oWDTlNdKIjeThHjA14Ct484p8BOF81ieMu8bGP
	 EDv5APPz6mSPdb255ecbRuyLHREVwui/kRbjz02vWOmN6yt/nwbIhjExews2k+f8tm
	 tOPjeAzKMAEJHMwm1if6VTnQlpSdJ9oEJMVP1oz5HTfJ76H3ii98uyeuk8nP33VRm9
	 bMhZOSpyWhxAw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] platform/x86: ideapad-laptop: add CapsLock/NumLock
 LED via EC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rodnei Cilto" <rodnei.cilto@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260628-ideapad-kbd-leds-v1-2-50b421d94927@gmail.com>
References: <20260628-ideapad-kbd-leds-v1-0-50b421d94927@gmail.com>
 <20260628-ideapad-kbd-leds-v1-2-50b421d94927@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 28 Jun 2026 02:06:09 +0000
Message-Id: <20260628020609.EAFA51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Sleeping in atomic context due to improper LED brightness callback=
 assignment.
- [Medium] Unsynchronized read-modify-write on the shared EC keyboard LED r=
egister.
- [Medium] Missing default triggers for CapsLock and NumLock LEDs.
--

commit 3bd8490b486c6791548a82ecc890f8f432c92886
Author: Rodnei Cilto <rodnei.cilto@gmail.com>

platform/x86: ideapad-laptop: add CapsLock/NumLock LED via EC

This commit adds support for physical CapsLock and NumLock LEDs on specific
Lenovo IdeaPad laptops (83RR/83SR). It maps the EC's offset 0xA1 bits 5 and
4 to CAPL and NUML and exposes them as led_classdev entries.

> diff --git a/drivers/platform/x86/lenovo/ideapad-laptop.c b/drivers/platf=
orm/x86/lenovo/ideapad-laptop.c
> --- a/drivers/platform/x86/lenovo/ideapad-laptop.c
> +++ b/drivers/platform/x86/lenovo/ideapad-laptop.c

[ ... ]

> +static int ideapad_kbd_led_ec_set(u8 bit, bool on)
> +{
> +	u8 val;
> +	int err;
> +
> +	err =3D ec_read(IDEAPAD_EC_KBD_LED_OFFSET, &val);
> +	if (err)
> +		return err;
> +	if (on)
> +		val |=3D bit;
> +	else
> +		val &=3D ~bit;
> +	err =3D ec_write(IDEAPAD_EC_KBD_LED_OFFSET, val);

[Severity: Medium]
Is this read-modify-write sequence safe against concurrent updates?

Since CapsLock and NumLock are exposed as separate led_classdev devices, the
LED subsystem protects their state with independent locks. If both LEDs are
toggled simultaneously, could two threads concurrently enter
ideapad_kbd_led_ec_set(), read the same initial value, and write it back,
causing one modification to overwrite and lose the other?

> +	if (err)
> +		return err;
> +	acpi_evaluate_object(NULL, IDEAPAD_ACPI_EC0_QDF_PATH, NULL, NULL);
> +	return 0;
> +}

[ ... ]

> +static int ideapad_kbd_leds_init(struct ideapad_private *priv)
> +{
> +	int err;
> +
> +	if (WARN_ON(priv->kbd_leds.initialized))
> +		return -EEXIST;
> +
> +	priv->kbd_leds.capslock.name           =3D "input::capslock";
> +	priv->kbd_leds.capslock.max_brightness =3D 1;
> +	priv->kbd_leds.capslock.brightness_set =3D ideapad_capslock_led_set;

[Severity: Medium]
Will this LED automatically synchronize with the system's actual keyboard l=
ock
state? Without setting .default_trigger =3D "kbd-capslock", the LED subsyst=
em
might not automatically link the keyboard input state to this LED, requiring
manual sysfs configuration.

[Severity: High]
Does this risk a scheduling while atomic panic? The LED subsystem often cal=
ls
the non-blocking brightness_set callback from atomic contexts, like softirq
for keyboard input triggers.

Since ideapad_capslock_led_set() calls ideapad_kbd_led_ec_set(), which uses
ec_read() and ec_write() that acquire mutexes and sleep, should this use
brightness_set_blocking instead to safely defer execution to a workqueue?

> +	priv->kbd_leds.capslock.brightness_get =3D ideapad_capslock_led_get;
> +	priv->kbd_leds.capslock.flags          =3D LED_RETAIN_AT_SHUTDOWN;
> +
> +	err =3D led_classdev_register(&priv->platform_device->dev,
> +				    &priv->kbd_leds.capslock);
> +	if (err)
> +		return err;
> +
> +	priv->kbd_leds.numlock.name            =3D "input::numlock";
> +	priv->kbd_leds.numlock.max_brightness  =3D 1;
> +	priv->kbd_leds.numlock.brightness_set  =3D ideapad_numlock_led_set;

[Severity: Medium]
Similarly, should this have .default_trigger =3D "kbd-numlock" set to ensure
the NumLock LED automatically tracks the physical keyboard state?

[Severity: High]
As with the CapsLock LED, does this need to use brightness_set_blocking to
avoid sleeping in atomic context when the trigger updates the LED?

> +	priv->kbd_leds.numlock.brightness_get  =3D ideapad_numlock_led_get;
> +	priv->kbd_leds.numlock.flags           =3D LED_RETAIN_AT_SHUTDOWN;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260628-ideapad-kb=
d-leds-v1-0-50b421d94927@gmail.com?part=3D2
