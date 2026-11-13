Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794612969;
	b=rXlJHq4a0buW7CovwGiB6Xv6aRpKCNzL3WSAIxz9sWSQNeB1NsgnL9vwXUPLqDHXvGi1
	 UbBqLTp7psaIGkpQqKaCBeI/T1GvOG9P+a9owDXB20Ugb/BVdtFSHlcMFxoeKM3pS0QuD
	 gGvChICr3eCiThjciORwE/HyOXNzqCqA503CAEJb336R+WCBVXVscCYhK+gSj5vE/rbW9
	 7refDJRm46mpOaPa4FDzvNZ/88BDdHyZCouo9vSwOd6ucrqB9ZKcQPUnPvPK3C5tW06Zp
	 UGU2sX9j8KDNvJ5LYG4S0ubipzgZte/YflZN3CgHoG+m8ZUelcncl7l92Nyscr8lRhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794612969;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8TAA8M+v27fD6vuURvWur7o5HWPhqGXViKJfRRwWN64=;
	b=IaK+SQuz+e4HwfVn114Tt5lRdxIst6pZ316eX1l74ObdIOGNlM8h/5Ahayv8TqERqOQg
	 rlj79RNbrfY2uGTzSX/8sXHrI8biUxnXfoqf6Yp/XCBMqs4h9JEpp7ciRM3gcMyL4bzPN
	 n7pnnXS5q6CMs2Ga6Vd/wcrtJWneD1kz8hLL0pUgrFCJE2kggsjsGfwCh6ZkwMcAZ/fsE
	 TCygvAiStDMp2YtbtvUGEyej/bEMRo84spa2/O/rTlD1zFPqlXpoRJlwqTfBNws5rjvzx
	 YcYEB90oWwURpJ4NK4fQT2g5I+gngVp8S2DqPPTwEN9Df080PfT6E2iruCUnV82iuQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o1+j4ygT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD6B606A89B
	for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 23:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o1+j4ygT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FAA31F000C4;
	Fri, 13 Nov 2026 23:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794612969;
	bh=8TAA8M+v27fD6vuURvWur7o5HWPhqGXViKJfRRwWN64=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=o1+j4ygTBHNUDrEo6oiAKDsuOSarWDSeJv9D05hEHp00k5l/igBZCPKfsIwMQSgtP
	 iAJWl4NtuPq3GeXV+u1ivlsh85NIWcSgwuwLIhBgNmJN7aQT2ykOXEz3MoSa1Kta/V
	 DzyHcu9Mj7aCrA7VkxSD5pcC7yhX/tVyfmUb+GoM8hjPNHNMh4Ia/+FFLmYtwj1FRz
	 /klsUlXpS4No8V60W4RK+F/22IoftfbcbdVJKTgK/jbclWX9m6fYepWGP3F7JYmiYv
	 myc3a4Cc8Sh6FO/d9A3/F6WBnXWW+V1evD99UXbmISKAIE3ivPK8DQKjE+vaLWtjpq
	 c0e/OfSCuYncA==
Message-ID: <sashiko-outbox-213870@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6] HID: ayaneo: Add AYANEO 3 detachable controller
 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWF0w61hcyBNYXJ0w61uZXo=?= <hello@matias.me>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261113232228.17553-1-hello@matias.me>
References: <20261113232228.17553-1-hello@matias.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 23:36:08 +0000
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
- [Low] HID: ayaneo: spurious -ENODEV errors and traffic on LED
  unregister
--

commit 503e8577930caa05e37b8ae2f759096d42ca369b
Author: Mat=C3=ADas Mart=C3=ADnez <hello@matias.me>

HID: ayaneo: Add AYANEO 3 detachable controller driver

This commit adds a HID driver for the AYANEO 3 detachable controller,
supporting module identification, software eject, rumble intensity,
configuration reset, and multicolor LED control on its vendor interface.

> diff --git a/drivers/hid/hid-ayaneo.c b/drivers/hid/hid-ayaneo.c
> new file mode 100644
> index 0000000000000..abb754a2a0534
> --- /dev/null
> +++ b/drivers/hid/hid-ayaneo.c

[ ... ]

> +static int ayaneo_led_set(struct led_classdev *cdev, enum led_brightness=
 value)
> +{
> +	struct led_classdev_mc *mc =3D lcdev_to_mccdev(cdev);
> +	struct ayaneo *aya =3D container_of(mc, struct ayaneo, mcled);
> +	int ret, i;
> +
> +	ACQUIRE(mutex_intr, lock)(&aya->lock);
> +	ret =3D ACQUIRE_ERR(mutex_intr, &lock);
> +	if (ret)
> +		return ret;
> +
> +	led_mc_calc_color_components(mc, value);
> +	aya->brightness =3D min(value, U8_MAX);
> +	for (i =3D 0; i < ARRAY_SIZE(aya->subleds); i++)
> +		aya->rgb[i] =3D min(aya->subleds[i].brightness, U8_MAX);
> +
> +	ret =3D ayaneo_send_config(aya, 0);
> +	if (ret)
> +		hid_err(aya->hdev, "failed to update RGB config: %d\n", ret);
> +	return ret;
> +}

[ ... ]

> +static int ayaneo_register_led(struct ayaneo *aya)
> +{
> +	struct led_classdev *cdev =3D &aya->mcled.led_cdev;
> +	int ret, i;

[ ... ]

> +	cdev->color =3D LED_COLOR_ID_RGB;
> +	cdev->brightness =3D 0;
> +	cdev->max_brightness =3D U8_MAX;
> +	cdev->brightness_set_blocking =3D ayaneo_led_set;

[Severity: Low]
Does unregistering the LED on controller power-off or unbind log spurious
-ENODEV errors and send unwanted config traffic?

When the controller is powered off (including after an eject handshake) or
disconnected, usb_disconnect() marks the device detached before
ayaneo_remove() runs.  led_classdev_multicolor_unregister() then issues an
LED_OFF write via set_brightness_work, which fails with -ENODEV in
ayaneo_send().  Because cdev->flags does not set LED_HW_PLUGGABLE and
ayaneo_led_set() logs all errors unconditionally, both ayaneo_led_set() and
the LED core log -ENODEV errors on every disconnect.

In addition, when the driver is unbound while aya->configured is false, that
same LED_OFF write during unregister still sends a 65-byte config report to
the device, even though the driver otherwise avoids sending traffic unless
userspace has configured it.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113232228.1755=
3-1-hello@matias.me?part=3D1
