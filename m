Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD2931355D
	for <linux-input@vger.kernel.org>; Thu,  2 Jul 2026 03:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782964739; cv=none; b=Cg1SYfLDQMWBcCl+X0tiroDvFnmw68KcfH2oXYX17ZlNtXjdo3MmtqcOJveSKAJu0v+Tl5Jxs4pDjpnV8Whq/MqaXMIPEcF87N5RCKUGWmXp1ZQOU/60a7ggzdgKETJPlNHyfbvSicVIhtd+R5r2+uu1EyI6rLgltj2JOh8TQoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782964739; c=relaxed/simple;
	bh=F3WKj4IdVyTVntDyMG90YfPl/jkwCZyyYN/YCLEvghg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LdRuZ+fGWnA483FwbWBfW81uIXXFHyEm47qrTdwQl1cCRwsBXkwBWJbD2mL4usKwt6mWmlUvf/C9CTm73cYpgq0X7PTLx224lfSAv6Zpw9V8q8tGU6+m4gso9AMimeE1/Kn6cXjC30UzGQlUnDcfBrJ7cPAPlP2htzlOab/2eQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDv4GYC2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDv4GYC2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E00601F000E9;
	Thu,  2 Jul 2026 03:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782964738;
	bh=hJmOU+lkGOMqHihLFBrFsr59WmkOVjTxQ/DPAKAccJw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NDv4GYC2KvJ1jPi4ntX9sqQJ7992MK67xmWkczZmxSQVjJj5+IYKk4s2DzkiiB0tU
	 v/gnoGYpmxqt7AeLXec43kL0TejJeUR0Nphdt8gSomXNZHQL83KhvXAfpRespez4cJ
	 T2cDMFq940m3KbgFAf5T5TTJxkjdZ2Cd71vSYJRYjZQPnX7jHmOeIe7dhvZBEzZ7Ct
	 1trKt8DkzJ1v6SE2B+16IOzSmGCH93HOjQhfNxFWonFHwOo+R9BfsgZ6BZvKwfgCpB
	 gxITQZcWXrf/ceIOA8qb++qYl+z1RBHpfgxmJECUnnwOKlLpgfCYDR9sfHjXwIoN9p
	 s59plIY4+vtww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 2/3] HID: nintendo: Add rumble support for Switch 2
 controllers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260702034106.1498056-3-vi@endrift.com>
References: <20260702034106.1498056-1-vi@endrift.com>
 <20260702034106.1498056-3-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 03:58:57 +0000
Message-Id: <20260702035857.E00601F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The devres-managed delayed work `ns2->rumble_work` is bound to the=
 `input->dev` lifecycle, but resides in `ns2`, leading to a Use-After-Free.
- [High] LEDs registered with `devm_led_classdev_register` on `input->dev` =
outlive the controller context `ns2`, leading to a Use-After-Free when sysf=
s attributes are accessed.
- [Medium] Unconditional cancellation of potentially uninitialized `ns2->ru=
mble_work` in `switch2_remove()` causes lockdep splats and kernel warnings.
--

commit 62e28913646bc7a9de5cfbf6dcd030ac10396625
Author: Vicki Pfau <vi@endrift.com>

    HID: nintendo: Add rumble support for Switch 2 controllers
   =20
    This adds rumble support for both the "HD Rumble" linear resonant actua=
tor
    type as used in the Joy-Cons and Pro Controller, as well as the eccentr=
ic
    rotating mass type used in the GameCube controller. Note that since the=
re's
    currently no API for exposing full control of LRAs with evdev, it only
    simulates a basic rumble for now.

    Signed-off-by: Vicki Pfau <vi@endrift.com>

> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> index f82034decb9ee..71a04c438271f 100644
> --- a/drivers/hid/hid-nintendo.c
> +++ b/drivers/hid/hid-nintendo.c

[ ... ]

> @@ -3332,6 +3502,26 @@ static int switch2_init_input(struct switch2_contr=
oller *ns2)
>  		return -EINVAL;
>  	}
> =20
> +#if IS_ENABLED(CONFIG_NINTENDO_FF)
> +	ns2->rumble_buffer =3D devm_kzalloc(&input->dev, 64, GFP_KERNEL);
> +	if (!ns2->rumble_buffer) {
> +		input_free_device(input);
> +		return -ENOMEM;
> +	}
> +	ret =3D devm_delayed_work_autocancel(&input->dev, &ns2->rumble_work, sw=
itch2_rumble_work);

[Severity: High]
Could this lead to a use-after-free? ns2->rumble_work is tied to the
lifecycle of input->dev, but it resides in ns2. If the physical controller
is unplugged:

switch2_remove()
  kref_put(&ns2->refcount, switch2_kref_put);
    kfree(ns2);

If a userspace process holds the input device open, input->dev remains aliv=
e.
When the file descriptor is finally closed, the devres cleanup for input->d=
ev
will execute and attempt to cancel the delayed work on the already-freed ns2
structure.

[Severity: High]
Are there similar lifecycle issues with the LED registration? If the LED cl=
ass
device is registered using devm_led_classdev_register(&input->dev, led), it
decouples the LED lifecycle from the controller context.

If the controller is unplugged and ns2 is freed, but the input device remai=
ns
open, could a write to the sysfs brightness file trigger a use-after-free?

switch2_player_led_brightness_set()
  struct switch2_controller *ns2 =3D input_get_drvdata(input);
  if (!ns2)
      return -ENODEV;
 =20
  guard(mutex)(&ns2->lock);

Would dereferencing ns2 here cause memory corruption if the context has
already been freed?

> +	if (ret < 0) {
> +		input_free_device(input);
> +		return ret;
> +	}
> +
> +	input_set_capability(input, EV_FF, FF_RUMBLE);
> +	ret =3D input_ff_create_memless(input, NULL, switch2_play_effect);
> +	if (ret) {
> +		input_free_device(input);
> +		return ret;
> +	}
> +#endif

[ ... ]

> @@ -4038,6 +4245,9 @@ static void switch2_remove(struct hid_device *hdev)
>  	ns2->hdev =3D NULL;
>  	ida_free(&nintendo_player_id_allocator, ns2->player_id);
>  	mutex_unlock(&ns2->lock);
> +#if IS_ENABLED(CONFIG_NINTENDO_FF)
> +	cancel_delayed_work_sync(&ns2->rumble_work);

[Severity: Medium]
Will this execute safely if the delayed work was never initialized?

Since ns2 is zero-allocated and ns2->rumble_work is only initialized in
switch2_init_input(), what happens if the device is unplugged or fails
initialization before switch2_init_input() is called?

Would calling cancel_delayed_work_sync() on a zero-initialized work structu=
re
trigger lockdep splats or kernel warnings?

> +#endif
>  	kref_put(&ns2->refcount, switch2_kref_put);
>  	hid_hw_close(hdev);
>  	hid_hw_stop(hdev);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702034106.1498=
056-1-vi@endrift.com?part=3D2
