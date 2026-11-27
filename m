Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795742427;
	b=mjOqjgbVXk/mTifVEPi0f2yBuj6zb4M3Zd4Wd4jVC14ed1o7CKwLHf67QSoqzSDz4gAU
	 GMG7f13qvoRzGedj6K0BKPZmNfBq0OZfZYQyuMOrT3kWNKDIWo/Q2dvwQbTy05EmDnI/V
	 DvanHdS1oRb2kk8zHGjoTnX9YC8k3Py+CKEUD2OyW9Ci6thOcxUXHQ9jsqPD/IfJtPqZQ
	 tnpRs1lu3rrATJe4HkwLE79GkMjWcv2X3eIZ1YIiVpouzFQIYBCl4e9ohxYPj2/8Za1z7
	 Rl6aC0YZTq+ziE/esMIY6Zp8GepM0522a/VGc05xhlVpbc4XVnp/4cQKDXAT2f3e3GA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795742427;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zUOs8f+RIHOAC15KeTPxhEwBVRhNzp3OUEnBu6zFoaQ=;
	b=2dg0gQ2WygQyoFfoLJVXCpIjspFrSPEZ8cXxEtEA+TaeDdkq53dNm5tEFiq8T8c62Hwi
	 2Eq+/cZYipuJCy3ruK9SDOs0Jkg2MV41byvN5KonK//tD64kmeks/eXhJW84Z1Z9QoGrt
	 4FGfIFU6sRByhQuHnqcxl6M9tb5xyNUEmTIDSwPifeSlFZV+h2R/Guz+Rbh/CjQj23VQC
	 z+MXGUS9iRxxQb/2Cr+1BHUBPFNZDiIr3eeF56ISKChtRhSHh9+wVll7S/kPIcMqCqBnp
	 g/eq4lWHFnwCFO+d0nEYNBTBkLVOCLa25O1l5el4l0+VNK+4j8rpy7JTTeQXihiPZoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G5CHPkG5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D67606A31E
	for <linux-input@vger.kernel.org>; Fri, 27 Nov 2026 01:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G5CHPkG5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B0E81F00897;
	Fri, 27 Nov 2026 01:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795742426;
	bh=zUOs8f+RIHOAC15KeTPxhEwBVRhNzp3OUEnBu6zFoaQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G5CHPkG55wwdC3fo90UlSqoElsuBva5XQe/SUe3smx6MBoJqZ6M3/i/6WMPzyfKOT
	 BwUQLedkGy6oJtvkGk+I/Xz78Ps1CUgn0LqPQV/zJ9E3B82mEycINMGvUS4qUdM6sE
	 uHKZfg0q2bEB5jednvAN8/OGpqWrlicGm6zUPHMuV6yELkyBdU4QdlXW3PXuhZ0/DE
	 FS4BBhRuXcrmetE/mWDllpL4oS7eBC3bY4AXTsEpisDAszQ/ghOGqxFk1dg0nSpc79
	 RroXK/+jQz7yLwvhpkuGdxbdtaHkM8rstlRZAzTOKJK5JRIKNlovgI11TKjE8BTs+E
	 uUWpt9O0lgkew==
Message-ID: <sashiko-outbox-236394@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] HID: lenovo-legion: Add keyboard backlight
 driver for Legion Gen 10
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ciro Pedrini" <ciro.pedrini@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261127-legion-lighting-rfc-v3-2-15c55d9f15b7@gmail.com>
References: <20261127-legion-lighting-rfc-v3-0-15c55d9f15b7@gmail.com>
 <20261127-legion-lighting-rfc-v3-2-15c55d9f15b7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 01:20:25 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] HID: lenovo-legion: race on kbd->level in
  legion_brightness_set() and get()
--

commit 1968b7a56dc85b8ec700640dbc936c464e699f4b
Author: Ciro Pedrini <ciro.pedrini@gmail.com>

HID: lenovo-legion: Add keyboard backlight driver for Legion Gen 10

This commit adds a HID driver exposing the keyboard backlight brightness of
Lenovo Legion Gen 10 laptops as an LED class device with hardware brightness
change notifications.

> diff --git a/drivers/hid/hid-lenovo-legion.c b/drivers/hid/hid-lenovo-leg=
ion.c
> new file mode 100644
> index 0000000000000..cfd42c52500f1
> --- /dev/null
> +++ b/drivers/hid/hid-lenovo-legion.c
> @@ -0,0 +1,293 @@

[ ... ]

> +static int legion_brightness_set(struct led_classdev *led,
> +				 enum led_brightness value)
> +{
> +	struct legion_kbd *kbd =3D container_of(led, struct legion_kbd, led);
> +	u8 old =3D READ_ONCE(kbd->level);
> +	int ret;
> +
> +	if (value > led->max_brightness)
> +		return -EINVAL;
> +
> +	/* Before sending: the report of this set may come before we return. */
> +	WRITE_ONCE(kbd->level, value);
> +	ret =3D legion_simple_command(kbd, LEGION_OP_SET_BRIGHTNESS, value, NUL=
L);
> +	if (ret)
> +		WRITE_ONCE(kbd->level, old);
> +
> +	return ret;
> +}
> +
> +static enum led_brightness legion_brightness_get(struct led_classdev *le=
d)
> +{
> +	struct legion_kbd *kbd =3D container_of(led, struct legion_kbd, led);
> +	u8 value;
> +	int ret;
> +
> +	ret =3D legion_simple_command(kbd, LEGION_OP_GET_BRIGHTNESS, 0, &value);
> +	if (ret) {
> +		hid_dbg(kbd->hdev, "reading the brightness failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (value > led->max_brightness) {
> +		hid_dbg(kbd->hdev, "brightness out of range: %u\n", value);
> +		return -EIO;
> +	}
> +
> +	WRITE_ONCE(kbd->level, value);
> +	return value;
> +}

[Severity: Medium]
Can concurrent legion_brightness_set() and legion_brightness_get() calls ra=
ce
on kbd->level?

In drivers/leds/led-class.c, brightness_store() releases led_cdev->led_acce=
ss
after queuing set_brightness_work, so set_brightness_delayed() invokes
legion_brightness_set() without holding led_access while brightness_show()
can run legion_brightness_get() concurrently.  Because kbd->level is updated
outside kbd->lock in both functions, a get can overwrite the new level with
the old hardware value before the set command is sent:

CPU0 (set_brightness_work)        CPU1 (brightness_show)
legion_brightness_set(led, new)
  WRITE_ONCE(kbd->level, new)
  legion_simple_command(...)
    kzalloc_flex(...)
                                  legion_brightness_get(led)
                                    legion_simple_command(...)
                                      lock(&kbd->lock)
                                      /* reads old level */
                                      unlock(&kbd->lock)
                                    WRITE_ONCE(kbd->level, old)
    lock(&kbd->lock)
    /* sends SET_BRIGHTNESS(new) */
    unlock(&kbd->lock)
                                  legion_raw_event()
                                    /* ev->level (new) !=3D kbd->level (old=
) */
                                    led_classdev_notify_brightness_hw_chang=
ed()
                                      <-- spurious hw_changed event

Similarly, if legion_brightness_set() or legion_raw_event() updates
kbd->level after legion_brightness_get() drops kbd->lock, the trailing
WRITE_ONCE(kbd->level, value) in legion_brightness_get() clobbers the newer
level with a stale value, which can also cause a subsequent hotkey event to
that stale level to be ignored.

Updating kbd->level under kbd->lock would avoid the race between set and
get.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127-legion-lig=
hting-rfc-v3-0-15c55d9f15b7@gmail.com?part=3D2
