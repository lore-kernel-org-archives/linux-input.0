Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4234188CC9
	for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 04:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784088022; cv=none; b=no0O52gF7olADmXJ2sJvF9XVRmYIoIpBFEyUxXnTsS3V9A2255FGR9+ve28fB5KS4eCLbxAVpbGV8/Stf37sSWAOsXQ9LMlJXNheplKfP7Ic9f/8BvTgVOnz0Z7Wqd9xWdEvkQF/WZoqLqzWhSoTwtoKkkEexP+taJhyXXSW1mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784088022; c=relaxed/simple;
	bh=O0/eSRtNVwpixFhXQh/5UfSPdZftreC25z2MRyl66rI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V74aVHWuQNBcwCVF7f9FHkId1RmM2P5koXTg5G2NaiNDfNoC6IDpHY3U/DYbDy/gHF+vEUDdiLcnY1QwrzPNrpDokXuxQhe88uFP419iXMdM6barSQ04F20+ZCY4vRVQl84aZqnFaOfTBIOmYcwfrMJQcTyrksL6Y7N2LctJiPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JzAE5yYt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JzAE5yYt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17DD51F000E9;
	Wed, 15 Jul 2026 04:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784088021;
	bh=mXROU51DEOo8YP++1P5QOaHa2Ejy7zE9sd1Ky9KiOJg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JzAE5yYtLs6W2VCJScZKw0/gGFZOMsxq6u/4ikVYIlBhAEKpdtyPXEnxRYC2Yxe8G
	 hqhGzURfFM2m3FGLfWdxc8Rp5l0K9tb5k5jQPH7uIRbZhUFe6kMWN/l3IX+SmSJ96o
	 eXtTzntiyW7gOvwpAZMefD4Oe00wNk+AnXjzwOxs7lc7s184YK2rirMQerUebUoXCj
	 nRxJkpSoiupgGY3orHtfe6zr3U79pcB2zc7vOFHEXoFv03Pqu8xmfLVpE7jevCQV+P
	 HpEQ85fZHfbbA6UixF4hk3nFUV8ceYLEVYlrPNDoxInb9qxeSlerL2uT11uZk25cQZ
	 dvnds9VaghLSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 2/3] HID: nintendo: Add rumble support for Switch 2
 controllers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260715033409.3599913-3-vi@endrift.com>
References: <20260715033409.3599913-1-vi@endrift.com>
 <20260715033409.3599913-3-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 04:00:20 +0000
Message-Id: <20260715040021.17DD51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Use-After-Free during devm cleanup of delayed work because `ns2` i=
s freed before `input->dev`.
- [High] Use-After-Free in `switch2_play_effect()` when the FF-memless time=
r fires concurrently with or after device removal.
- [High] Use-After-Free in LED sysfs callbacks because `devm_led_classdev_r=
egister` is bound to the `input->dev` lifecycle.
- [Medium] Re-initialization of `rumble_lock` in `switch2_probe()` causes l=
ockdep splats and metadata corruption upon driver rebind.
--

--- Patch [2]: [PATCH v12 2/3] HID: nintendo: Add rumble support for Switch=
 2 controllers ---
commit 2b2da5db7899af041358cec4f201f43322db88a4
Author: Vicki Pfau <vi@endrift.com>

HID: nintendo: Add rumble support for Switch 2 controllers
   =20
This adds rumble support for both the "HD Rumble" linear resonant actuator
type as used in the Joy-Cons and Pro Controller, as well as the eccentric
rotating mass type used in the GameCube controller. Note that since there's
currently no API for exposing full control of LRAs with evdev, it only
simulates a basic rumble for now.

> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> index 78c9ad3c16104..76eb4861ab230 100644
> --- a/drivers/hid/hid-nintendo.c
> +++ b/drivers/hid/hid-nintendo.c

[ ... ]

> @@ -3209,6 +3260,128 @@ static void switch2_kref_put(struct kref *refcoun=
t)
>  	kfree(ns2);
>  }
> =20
> +#if IS_ENABLED(CONFIG_NINTENDO_FF)
> +static void switch2_encode_rumble(struct switch2_hd_rumble *rumble, uint=
8_t buffer[5])
> +{
> +	buffer[0] =3D rumble->hi_freq;
> +	buffer[1] =3D (rumble->hi_freq >> 8) | (rumble->hi_amp << 2);
> +	buffer[2] =3D (rumble->hi_amp >> 6) | (rumble->lo_freq << 4);
> +	buffer[3] =3D (rumble->lo_freq >> 4) | (rumble->lo_amp << 6);
> +	buffer[4] =3D rumble->lo_amp >> 2;
> +}
> +
> +static int switch2_play_effect(struct input_dev *dev, void *data, struct=
 ff_effect *effect)
> +{
> +	struct switch2_controller *ns2 =3D input_get_drvdata(dev);
> +	unsigned long flags;
> +
> +	if (effect->type !=3D FF_RUMBLE)
> +		return 0;
> +
> +	if (!ns2)
> +		return -ENODEV;
> +
> +	spin_lock_irqsave(&ns2->rumble_lock, flags);

[Severity: High]
Can switch2_play_effect() access ns2 after it has been freed?

The ff-memless timer is only destroyed when input->dev is freed. If an acti=
ve
rumble effect arms this timer and the device is unplugged while the timer is
active, switch2_remove() will free ns2 if a file descriptor remains open.

The timer could then fire, calling switch2_play_effect(), which fetches the
stale ns2 pointer via input_get_drvdata() and attempts to acquire
ns2->rumble_lock.

[ ... ]

> @@ -3332,6 +3505,26 @@ static int switch2_init_input(struct switch2_contr=
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
Can this lead to a use-after-free during device removal?

Since evdev keeps input->dev alive until the file descriptor is closed,
tying the delayed work to input->dev means the cancellation action will be
deferred.

However, switch2_remove() drops the final kref on ns2 and frees it
immediately on unplug. When the file descriptor is eventually closed,
input->dev is destroyed, and the devm action
cancel_delayed_work_sync(&ns2->rumble_work) will execute on the already-fre=
ed
ns2 struct.

[Severity: High]
Does a similar use-after-free exist in the LED registration?

In switch2_init_input(), the LED device is registered using:
devm_led_classdev_register(&input->dev, led);

Because this is tied to the input->dev lifecycle rather than the HID device,
if the device is unbound, switch2_remove() frees ns2. But if input->dev is
kept alive by an open file descriptor, the LED sysfs attributes remain
registered.

A subsequent read/write to the brightness attribute triggers
switch2_player_led_brightness_set(), which fetches the freed ns2 and
attempts to acquire ns2->lock.

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

> @@ -3996,6 +4202,10 @@ static int switch2_probe(struct hid_device *hdev, =
const struct hid_device_id *id
>  	else
>  		ns2->player_id =3D ret;
> =20
> +#if IS_ENABLED(CONFIG_NINTENDO_FF)
> +	spin_lock_init(&ns2->rumble_lock);
> +#endif

[Severity: Medium]
Will this corrupt the lock state on driver rebind?

The ns2 structure is shared with a USB config interface (via the
switch2_controllers list) and can outlive the HID device binding.

If the HID driver is unbound and then rebound, switch2_probe() retrieves
the existing ns2 and calls spin_lock_init(&ns2->rumble_lock) on the already
active lock, which can cause lockdep splats and metadata corruption.

> +
>  	ret =3D hid_hw_start(hdev, HID_CONNECT_HIDRAW);
>  	if (ret) {
>  		hid_err(hdev, "hw_start failed %d\n", ret);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715033409.3599=
913-1-vi@endrift.com?part=3D2
