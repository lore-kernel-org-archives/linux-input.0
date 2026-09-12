Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B006B363C6C
	for <linux-input@vger.kernel.org>; Sat, 12 Sep 2026 02:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789178939; cv=none; b=PDk7HO4+rZPYe4uHioFc2bP9HDm4V0ijgaSI116ylqQ6Pul5Vker1VxdMwY415o2BNVPBHVlZfana5h5BEOhco1hbFMywcppfoutsq0xg//BaDn0BsZ9TI92QRkibDIDm+pN1ZBH0wnoqkFACujdOlQPboS0YaG+A/UK2o0bJEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789178939; c=relaxed/simple;
	bh=G4SkyROM3TDzBUuQuV6Ka6meR+4RLo1gPUCu0+GXs9I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u+GM8nkqptQTPXfuCiN+IUQghDNrXNXebeVjxri+UVHimC7Wy2Tiiafsdh9hsO2j3IxWuR3mn+IOliECzlxwmTsfb8sH0IvWYlDvr/QgQFvWyo6TnDFaQcnj4HxUPW4Hqls2MVE87BoWR4DgQK8uc19RfOeqxWAyCwDxFqNz5QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kp7Adt59; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kp7Adt59"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A153A1F000FF;
	Sat, 12 Sep 2026 02:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789178935;
	bh=tyxCE7aTmlh9ALPgTtUHwNmmZEgaX06kglLsjAl5j1o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Kp7Adt59EnRXf4JB/CSyCzl2oDGYF+i1oH5lgW7AgilsT/YEKTyrejdoWrDPN2gA+
	 ky58fNOXrG6mHiRYXXNv/H2DGPze/C4XvKInUfV8tvtuJpmyfeEaaVepuRm1ISpLua
	 XID16KIKMslc+dnROcUyL4qhJw+f8Zpy/kLbab4ooQNBCj8Vk/qcIaN+iWcUL9i4eI
	 G5MrS2LDN1/sKTvvm+Mo1nRtXLTBGLZR0Cf8cSIYkjVggL0r+ZFyBtgJNQzi7e/s7B
	 fRpngnd3o/7gI5voTzLqw6ux6grQZg9VSE2wLYG8Hctpi42uuNl8869Lmu9wvM2Rd3
	 82Cq7TlJ5DmMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] HID: flydigi: add support for vader 5 pro
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260912015926.230874-2-denis.benato@linux.dev>
References: <20260912015926.230874-1-denis.benato@linux.dev>
 <20260912015926.230874-2-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 02:08:55 +0000
Message-Id: <20260912020855.A153A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Use-after-free of custom workqueue due to devres lifecycle mismatc=
h.
- [High] Invalid pointer dereference of `ERR_PTR` on probe failure.
--

commit 7c54f2d9cfb04d2dfe81eebdf0f885848becc9b4
Author: Denis Benato <denis.benato@linux.dev>

HID: flydigi: add support for vader 5 pro

This commit introduces support for the Flydigi Vader Pro 5 gamepad. It
exposes two evdev nodes with matching unique IDs for the gamepad and motion
sensors so userspace applications can pair them.

> diff --git a/drivers/hid/hid-flydigi.c b/drivers/hid/hid-flydigi.c
> new file mode 100644
> index 0000000000000..148c53564200f
> --- /dev/null
> +++ b/drivers/hid/hid-flydigi.c

[ ... ]

> +	fd->battery_status =3D POWER_SUPPLY_STATUS_UNKNOWN;
> +	fd->battery_capacity =3D 0;
> +
> +	fd->battery =3D devm_power_supply_register(&hdev->dev, &fd->battery_des=
c,
> +						 &psy_cfg);
> +	if (IS_ERR(fd->battery))
> +		return PTR_ERR(fd->battery);

[Severity: High]
Can this result in an invalid pointer dereference on probe failure?

If devm_power_supply_register() fails, fd->battery is directly assigned an
ERR_PTR. The function returns an error, leading to the err_stop cleanup pat=
h.

If an incoming FLYDIGI_CMD_INFO packet from the device is processed during
this cleanup window (before hid_hw_stop() fully disables events), it will
call flydigi_report_battery():

    if (fd->battery)
        power_supply_changed(fd->battery);

Since an ERR_PTR evaluates to true, the error pointer will be passed to
power_supply_changed() and dereferenced. This regression could be triggered
by an untrusted USB device spamming status packets.

[ ... ]

> +static void flydigi_remove(struct hid_device *hdev)
> +{
> +	struct flydigi_device *fd =3D hid_get_drvdata(hdev);
> +
> +	scoped_guard(spinlock_irqsave, &fd->lock) {
> +		fd->removed =3D true;
> +		fd->strong =3D 0;
> +		fd->weak =3D 0;
> +	}
> +
> +	cancel_delayed_work_sync(&fd->acquire_work);
> +	cancel_delayed_work_sync(&fd->rumble_work);
> +	destroy_workqueue(fd->wq);

[Severity: High]
Does this cause a use-after-free of the workqueue due to a devres lifecycle
mismatch?

The custom workqueue fd->wq is explicitly destroyed here in flydigi_remove()
and similarly in the err_stop probe error path. However, the input devices
are allocated with devm_input_allocate_device(), meaning they will be
unregistered by devres after flydigi_remove() completes.

During this window, the input devices are still visible to userspace. If
userspace opens the gamepad or sends force-feedback effects, callbacks like
flydigi_gamepad_open() or flydigi_play_effect() will attempt to queue work
on the destroyed fd->wq, leading to a use-after-free.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912015926.2308=
74-1-denis.benato@linux.dev?part=3D1
