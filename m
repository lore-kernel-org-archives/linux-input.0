Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B234C2EC0A4
	for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 03:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792120020; cv=none; b=IBi5OchnNczqZL2sdDj74V+8RHYc0dr90rC8Fg9MX+JCnmEtiwO4k15ec7Y0CaE4GKiTRd+m5rPaYWp1MFy9UlXOQDtVhnuRamHieU0IEjaW2j8U+w5YlQ+MIouK64NcyhYgeaBiYvf5ZPuJEYHKFip4V/UXkTXjddInk+kircc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792120020; c=relaxed/simple;
	bh=KRD1fnLQd2IRicfksaGXkpfsMOJXsRQp+JOIMvpBWVM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=XR62wiu32tcnS/UZtEZgcnLUgTlMy7ApNcglT1nEF+rwJ8AQTp5mit9tMrVjbXFKpxiXyNdp1l6qZZuuA3/nOz7yfh9I+zA+cis12nkvMC15xoTRtd6WB8xNCcqcB7XHb8oFEtk69+XQZMsEvh5Xc2rColzY5pT7BLVdtYliCfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fiJgLEOQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fiJgLEOQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24AC11F000C4;
	Fri, 16 Oct 2026 03:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792120019;
	bh=hgkreOSQWVH4Fg4x+I7uyHJ7qaI9FqJVAxWq/ubD8oc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fiJgLEOQFWxb5j1GHOFiEzCP6LDuS27tVdK53gT+OzIC6Qb0MRZoIxx/dSzfjFpc7
	 zPlJ8vS6X1ykP6JbcBm+kdRMn/JgL6wdMJfDyXdJw6R5S9+bJIYRM3ARyp7VMoQby4
	 fdyWGN5NkJh9mPCmTeNGIF9O3to+VoTCfBxvMSKyfCDlbEzCanYlooOshbWaB7T6Vm
	 Pp2XQG2y+KhzVSK+iWqIpb5JERAqG291/0M2uIsyWN9Y6v8GJ+bF7H+ydvEsMMN4Mi
	 FYLaA/oh2acLOYt6kgbWAKSXtImzBPc3TnOC2dTBhghKArIrsCIeVdK9NmErmeVDJk
	 jo+n1E7ImIefw==
Message-ID: <sashiko-outbox-173648@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: santroller: add driver for Santroller controllers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanjay Govind" <sanjay.govind9@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261016025403.779635-1-sanjay.govind9@gmail.com>
References: <20261016025403.779635-1-sanjay.govind9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 03:06:58 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] sysfs: subtype attribute is never created because drvdata is eva=
luated before probe
- [Medium] hid: santroller: TOCTOU race in santroller_player_led_set()
- [Low] cleanup: mixing goto-based error handling and scope-based guard in =
santroller_probe
--

commit b57c720141928f4d7ed22cb8e37042ae56074ec7
Author: Sanjay Govind <sanjay.govind9@gmail.com>

HID: santroller: add driver for Santroller controllers

This commit adds a new driver for game controllers and instruments running
the open source Santroller firmware. It supports inputs, rumble, various
device LEDs, and exposes the specific controller subtype to userspace via
a sysfs attribute.

> diff --git a/drivers/hid/hid-santroller.c b/drivers/hid/hid-santroller.c
> new file mode 100644
> index 0000000000000..00adeb741a886
> --- /dev/null
> +++ b/drivers/hid/hid-santroller.c

[ ... ]

> +static void santroller_player_led_set(struct led_classdev *led,
> +				      enum led_brightness value)
> +{
> +	struct hid_device *hdev =3D to_hid_device(led->dev->parent);
> +	struct santroller *sc =3D hid_get_drvdata(hdev);
> +	u8 player =3D SANTROLLER_PLAYER_LED_OFF;
> +	int i;
> +
> +	for (i =3D 0; i < SANTROLLER_NUM_PLAYER_LEDS; i++) {
> +		if (sc->player_leds[i].brightness) {
> +			player =3D i;
> +			break;
> +		}
> +	}
> +
> +	guard(spinlock_irqsave)(&sc->lock);
> +
> +	sc->player =3D player;

[Severity: Medium]
Is there a potential regression here? If multiple player LEDs' brightnesses
are updated concurrently via sysfs, their respective callbacks could run in
parallel.

Since the brightness array is read outside sc->lock, one thread might read a
stale array, get preempted, and then overwrite the hardware state with an
outdated player index after the other thread has updated the state. Moving
the array read inside the lock would prevent this.

[ ... ]

> +/* Interfaces left to the generic HID handling have no subtype */
> +static umode_t santroller_attr_is_visible(struct kobject *kobj,
> +					  struct attribute *attr, int n)
> +{
> +	struct device *dev =3D kobj_to_dev(kobj);
> +
> +	return hid_get_drvdata(to_hid_device(dev)) ? attr->mode : 0;
> +}

[Severity: Medium]
Could this visibility check cause a regression where the attribute is never
created?

In the driver core, dev_groups assigned to the driver structure are
evaluated by device_add_groups() before the driver's probe() function is
executed. Because hid_set_drvdata() is only called later inside
santroller_probe(), drvdata is strictly NULL when this visibility check
is performed. This causes it to return 0 and skip attribute creation.

[ ... ]

> +static int santroller_probe(struct hid_device *hdev,
> +			    const struct hid_device_id *id)
> +{

[ ... ]

> +	hid_device_io_stop(hdev);
> +
> +	scoped_guard(spinlock_irqsave, &sc->lock)
> +		sc->output_enabled =3D true;
> +
> +	ret =3D hid_connect(hdev, HID_CONNECT_DEFAULT);
> +	if (ret) {
> +		hid_err(hdev, "failed to connect HID device: %d\n", ret);
> +		goto err_stop_output;
> +	}

[Severity: Low]
Does this mix goto-based error handling with scope-based cleanup?

The kernel's cleanup subsystem guidelines explicitly state that a function
must either convert all resources to scope-based cleanup or use goto
exclusively. Mixing goto labels alongside scoped_guard can cause a
regression by creating confusing ownership semantics.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016025403.7796=
35-1-sanjay.govind9@gmail.com?part=3D1
