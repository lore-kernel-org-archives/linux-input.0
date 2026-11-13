Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794606571;
	b=rq1dSyeVozxo8JBjd+xX6bP73jFkgthNX4HZ4ixPHJawPpgFhzfA6zFIaEZELASpzhB8
	 r8Tw3DNl9v/Lt53YDrVmJsmZIYMOU8skMEg+8xy9/AfyXPMzdnirBOFHI/NGsdXhl5EqP
	 if+WIry7qfU0R1aekOH09vuILDA4EgcIksF6IvFEcjYT03Rxb43ZgiEEGpQBqBM1QQp1b
	 UUPH89Dgr49xUVUrCgeN4RBueOQHVXS53BsChzEqjd9lm4kruU5ieJWIPUCJmvUZwnt4G
	 bTqAJ/6C0YopF/sBzHPPCD8yoH7gkkiHBNnMnLVqVsqmkeCoNhtOkGRKE9D4G8VJ4VA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794606571;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IKbwpTRlCv/MD+iibNjWJp5T0mtWPoYebgT9WmpIUkM=;
	b=xcZFTFLLGjEt6S3eJF1ifrHyNxaHYWbUK+YYkW9KoC5y8RyIamVEz9NMpCanjw9eg+6D
	 AOr8SvNYtQJT4b8aNGf3iWXEJKdwd1xjcPYXf8vGPkINIEzgGHiwV9WIzTxt9R5GYvSG7
	 dTXGSceFlPsd/MFbjyn3dHFHTqh/ZnQY9c7aHo/rjo6p2GbMun9anDFIW0Z16qGxf8Z7S
	 FQwwFrq2oiPUr104XdQSnEtVe1TkI/0WzLm1e8ELl2FeTiyFvFN2Vw/cfM8HH1oUK4vyl
	 RrqlsG+9/4/yB2ylnW2WSngaqAAWWsFKx1DPdRzWr4kIY4ynUULqJli3vQGbAPJpMHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UQkd3Pyz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0122060A261B
	for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 21:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UQkd3Pyz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578691F000C4;
	Fri, 13 Nov 2026 21:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794606570;
	bh=IKbwpTRlCv/MD+iibNjWJp5T0mtWPoYebgT9WmpIUkM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UQkd3PyzKELUifvrj06/RHdfBsoYZgUM3rxXmQygxy+/MBNg5pn2YL401lM94Q7bT
	 mS8k3AXWNCAgZQFrBtaREF+x6Kh6Toa5yPYjF9rygB31XKyxXNTylWUsyKWXfUkZtJ
	 /eUvrkof+6riAsObcfXPBRYxBY0v52EWmDihjNJvuEJOSsaLQ/UNgnRPCHPYpXtGuK
	 Bzwh5wmqkY6cY7zAKpUCpVClDqYe29FcXp9aaRVyia+k0hdbXcz6HQJNikFfsSbMgC
	 +ht9or78J8ZSYiRm1EQ3sL4+MqwtfaJA56Ru2fudU4TGvQZ3DMt2byiPpahzkVW5ms
	 JAvf9FMC9mlLg==
Message-ID: <sashiko-outbox-213739@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] HID: ayaneo: Add AYANEO 3 detachable controller
 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWF0w61hcyBNYXJ0w61uZXo=?= <hello@matias.me>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261113212729.15925-1-hello@matias.me>
References: <20261113212729.15925-1-hello@matias.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 21:49:29 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] HID: ayaneo: jiffies underflow in eject_store() causes
  infinite sleep
- [Low] HID: ayaneo: spurious -ENODEV errors on LED unregister during
  USB disconnect
--

commit 6aae1d65587c9f83b7545615c19722d11a6ced70
Author: Mat=C3=ADas Mart=C3=ADnez <hello@matias.me>

HID: ayaneo: Add AYANEO 3 detachable controller driver

This commit adds a HID driver for the AYANEO 3 detachable controller,
supporting module identification, software eject, configuration reset,
rumble intensity selection, and multicolor LED control on the vendor
interface while starting the other interfaces as generic HID devices.

> diff --git a/drivers/hid/hid-ayaneo.c b/drivers/hid/hid-ayaneo.c
> new file mode 100644
> index 0000000000000..a6c2dee793902
> --- /dev/null
> +++ b/drivers/hid/hid-ayaneo.c

[ ... ]

> +static ssize_t eject_store(struct device *dev, struct device_attribute *=
attr,
> +			   const char *buf, size_t count)
> +{

[ ... ]

> +		/*
> +		 * The firmware wants a minimum time between the eject
> +		 * command and the power cut that follows this write.
> +		 */
> +		if (!ret && time_before(jiffies, deadline)) {
> +			if (msleep_interruptible(jiffies_to_msecs(deadline -
> +								  jiffies)))
> +				ret =3D -EINTR;
> +		}
> +	}
> +	return ret ? ret : count;
> +}

[Severity: Medium]
Can deadline - jiffies underflow if jiffies advances past deadline between
the two volatile reads of jiffies?

Because the polling loop completes right around the 3000 ms deadline, a
timer tick or preemption between time_before(jiffies, deadline) and
deadline - jiffies can wrap the subtraction to a value near ULONG_MAX.
jiffies_to_msecs() then returns an unsigned int with the sign bit set,
which __msecs_to_jiffies() converts to MAX_JIFFY_OFFSET, hanging the caller
in msleep_interruptible() with aya->lock held until interrupted by a
signal.  Snapshotting jiffies into a local variable once before
time_before() avoids the underflow.

[ ... ]

> +static int ayaneo_led_set(struct led_classdev *cdev, enum led_brightness=
 value)
> +{
> +	struct led_classdev_mc *mc =3D lcdev_to_mccdev(cdev);
> +	struct ayaneo *aya =3D container_of(mc, struct ayaneo, mcled);
> +	int ret =3D 0, i;
> +
> +	scoped_cond_guard(mutex_intr, return -EINTR, &aya->lock) {
> +		led_mc_calc_color_components(mc, value);
> +		aya->brightness =3D min_t(unsigned int, value, 255);
> +		for (i =3D 0; i < 3; i++)
> +			aya->rgb[i] =3D min_t(unsigned int,
> +					    aya->subleds[i].brightness, 255);
> +
> +		ret =3D ayaneo_send_config(aya, 0);
> +		if (ret)
> +			hid_err(aya->hdev,
> +				"failed to update RGB config: %d\n", ret);
> +	}
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
> +	cdev->max_brightness =3D 255;
> +	cdev->brightness_set_blocking =3D ayaneo_led_set;
> +
> +	/*
> +	 * Not devm: the LED must be unregistered before hid_hw_stop(), or a
> +	 * racing brightness write could reach a torn-down transport.
> +	 */
> +	ret =3D led_classdev_multicolor_register(&aya->hdev->dev, &aya->mcled);

[Severity: Low]
Does unregistering the LED during USB disconnect or controller power-off
always log two spurious -ENODEV errors?

When the controller is unplugged or powered off via ayaneo-ec's
controller_power attribute, usb_disconnect() marks the USB device
USB_STATE_NOTATTACHED before ayaneo_remove() runs.
led_classdev_multicolor_unregister() then issues an LED_OFF write through
ayaneo_led_set(), where usb_submit_urb() fails with -ENODEV.  Because
ayaneo_led_set() logs hid_err() unconditionally and cdev->flags does not
include LED_HW_PLUGGABLE, both ayaneo_led_set() and
set_brightness_delayed_set_brightness() log an error on every disconnect:

drivers/leds/led-core.c:set_brightness_delayed_set_brightness() {
	...
	/* LED HW might have been unplugged, therefore don't warn */
	if (ret =3D=3D -ENODEV && led_cdev->flags & LED_UNREGISTERING &&
	    led_cdev->flags & LED_HW_PLUGGABLE)
		return;

	if (ret < 0)
		dev_err(led_cdev->dev,
			"Setting an LED's brightness failed (%d)\n", ret);
}

In addition, when aya->configured is false and value is 0 (such as on
driver unbind or if sysfs_create_group() fails in ayaneo_probe()), the
LED_OFF write on unregister still sends a config command to the controller
despite the driver's policy of sending no traffic unless userspace asks.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113212729.1592=
5-1-hello@matias.me?part=3D1
