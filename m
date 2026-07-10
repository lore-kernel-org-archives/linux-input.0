Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF94918DB1F
	for <linux-input@vger.kernel.org>; Fri, 10 Jul 2026 02:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783649960; cv=none; b=CmSvPeI+brO4T/GMJYrRhLj+M0FtyVUz5SHSaCSVT+gR7ZPyG70+THfUAjVKUPmnaZ20O/u+qYperEyNfWGNr5bIaeT9p7+sguzoZaGc4xpKE0OCyKTo3H0Yqoxcel9essERo9K5pnpy+vx1hDMF6c3/fBCRw2bPM1T2k4uF24I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783649960; c=relaxed/simple;
	bh=v/Ad0V4kzIa/5WR3TnIG9oWOwWXGrmx+SJfTkJ7tXMA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VdSodRhZp2Gw3CVTBpm/IrKOuVZ6xP+DhMI3QPEUkVzcSBm6qDvSCh61VFYUQtllRrFkvIcApGJW/OIwGHb9CF1rJERe1iu1RRdUx7XWOM4EcSUvdGplXKFEIUFZ/hWrAslhRCrj5z47JtrJkMdPZgIxmDiFWqwkWpI9dY7WRK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cgETI5eG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cgETI5eG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 992491F00A3A;
	Fri, 10 Jul 2026 02:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783649958;
	bh=i3HsOQ5cVxLufHpWyXI8SbBvW7FWtzTLo2SBkO2tCqA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cgETI5eGge3FCcyOOtcQHqXj3o1A2QRy3wV8yffYgyrteMQf/3+j4hZ0J8j6Foe9Y
	 U2Zciqlvcndr8vcipyyzVAJZe6p4B1pSVXrhVJM364JoHOhuOlvqxiHgrxoAJUJX4m
	 3gWbsmUgYM90pOUKAmkRDPrx/lEvUtJvbLeV0jqDOx6BD7K0todDKBEreAfugv9ehR
	 40eZW/BwNXrLgsWqgWTSqJAbIPNd3laMLzgH+KSGy7fqq8vUZUmKqxmODwS9ZryELt
	 M5lQF99mA+nqKFRvIhWSPnUXZHADtw+4ukaNhf/RCdnk94HfvZu4E7STDFirQ8ULQW
	 oI6TPT1a9EwLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/10] HID: steam: Add support for sensor events on
 the Steam Controller (2015)
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260710020048.2337655-5-vi@endrift.com>
References: <20260710020048.2337655-1-vi@endrift.com>
 <20260710020048.2337655-5-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 02:19:18 +0000
Message-Id: <20260710021918.992491F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [Medium] The newly added `sensors` IMU configuration is silently destroye=
d when userspace closes the concurrent `input` evdev node or briefly toggle=
s the hidraw client.
- [Medium] The IMU gyroscope Y-axis mapping for the Steam Controller has an=
 inverted sign, breaking the right-handed coordinate system.

Pre-existing issues:
- [High] Use-After-Free when `steam_register()` fails during `steam_probe()=
`.
- [High] Concurrent execution of connection and unregistration work queues =
causes double-registration and permanent memory leaks of input devices.
- [High] Information Leak: `steam_send_report()` sends uninitialized kernel=
 heap memory to the USB device.
- [High] HID I/O requests are issued after the hardware transport is torn d=
own, violating hardware lifecycle rules.
--

--- Patch [4]: [PATCH v3 04/10] HID: steam: Add support for sensor events o=
n the Steam Controller (2015) ---
commit 00dc87454b13954b455cab385838fde427082fff
Author: Vicki Pfau <vi@endrift.com>

HID: steam: Add support for sensor events on the Steam Controller (2015)

Sensor support was added for the Steam Deck previously, but Steam
Controller sensor events were never added. This adds that missing support,
bringing Steam Controller support much closer to feature parity with things
like SDL and Steam itself.

> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> index add9f4f27fff9..6029c055a6cf3 100644
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c
[ ... ]
> @@ -468,6 +500,38 @@ static int steam_get_serial(struct steam_device *ste=
am)
>  	return ret;
>  }
> =20
> +static int steam_get_attributes(struct steam_device *steam)
> +{
> +	int ret =3D 0;
> +	u8 cmd[] =3D {ID_GET_ATTRIBUTES_VALUES, 0};
> +	u8 reply[64] =3D {};
> +	u8 size;
> +	int i;
> +	struct steam_controller_attribute *attr;
> +
> +	guard(mutex)(&steam->report_mutex);
> +	ret =3D steam_send_report(steam, cmd, sizeof(cmd));

[Severity: High]
This is a pre-existing issue, but does steam_send_report() send uninitializ=
ed
kernel heap memory to the USB device?

Looking at steam_send_report(), it allocates a buffer using
hid_alloc_report_buf(), which internally calls kmalloc() instead of
kzalloc(). It then copies the payload and sends max(size, 64) + 1 bytes via
hid_hw_raw_request().

When steam_get_attributes() calls this with a 2-byte payload, does this
result in up to 63 bytes of uninitialized kernel memory being transmitted to
the USB device?

> +	if (ret < 0)
> +		return ret;
[ ... ]
> @@ -626,6 +690,42 @@ static void steam_input_close(struct input_dev *dev)
>  	}
>  }
> =20
> +static int steam_sensor_open(struct input_dev *dev)
> +{
> +	struct steam_device *steam =3D input_get_drvdata(dev);
> +	unsigned long flags;
> +	bool client_opened;
> +
> +	spin_lock_irqsave(&steam->lock, flags);
> +	client_opened =3D steam->client_opened;
> +	spin_unlock_irqrestore(&steam->lock, flags);
> +	if (client_opened)
> +		return 0;
> +
> +	guard(mutex)(&steam->report_mutex);
> +	steam_write_settings(steam, SETTING_IMU_MODE,
> +			SETTING_IMU_MODE_SEND_RAW_ACCEL | SETTING_IMU_MODE_SEND_RAW_GYRO,
> +			0);

[Severity: Medium]
Is the newly added sensors IMU configuration silently destroyed when usersp=
ace
closes the concurrent input evdev node?

If userspace has both the sensors node and the input node open, and then
closes the input node, steam_input_close() executes and evaluates
!steam->client_opened && lizard_mode. This calls
steam_set_lizard_mode(steam, true), which sends ID_LOAD_DEFAULT_SETTINGS.

Since ID_LOAD_DEFAULT_SETTINGS entirely resets the controller's hardware
configuration and turns off the IMU, does the sensors node remain open while
the physical IMU silently stops reporting data? Could this same state clobb=
ering
occur if the raw HID client is quickly opened and closed?

> +
> +	return 0;
> +}
> +
> +static void steam_sensor_close(struct input_dev *dev)
> +{
> +	struct steam_device *steam =3D input_get_drvdata(dev);
> +	unsigned long flags;
> +	bool client_opened;
> +
> +	spin_lock_irqsave(&steam->lock, flags);
> +	client_opened =3D steam->client_opened;
> +	spin_unlock_irqrestore(&steam->lock, flags);
> +	if (client_opened)
> +		return;
> +
> +	guard(mutex)(&steam->report_mutex);
> +	steam_write_settings(steam, SETTING_IMU_MODE, 0, 0);

[Severity: High]
This is a pre-existing issue, but does calling steam_write_settings() here
violate hardware lifecycle rules during device removal?

In steam_remove(), the driver calls hid_hw_close(hdev) and
hid_hw_stop(hdev), which tears down the USB transport layer. Following this,
steam_unregister() invokes steam_sensors_unregister(), which calls
input_unregister_device().

If a userspace application holds the evdev node open, this triggers the
steam_sensor_close() callback. Since steam_write_settings() issues I/O
requests to a stopped HID device, can this access torn-down transport struc=
tures
and cause use-after-free conditions or kernel panics during device unplug?

> +}
[ ... ]
> @@ -839,9 +939,6 @@ static int steam_sensors_register(struct steam_device=
 *steam)
>  	struct input_dev *sensors;
>  	int ret;
> =20
> -	if (!(steam->quirks & STEAM_QUIRK_DECK))
> -		return 0;
> -
>  	rcu_read_lock();
>  	sensors =3D rcu_dereference(steam->sensors);
>  	rcu_read_unlock();
>  	if (sensors) {
>  		dbg_hid("%s: already connected\n", __func__);
>  		return 0;
>  	}
> =20
>  	sensors =3D input_allocate_device();

[Severity: High]
This is a pre-existing issue, but can concurrent execution of the connectio=
n and
unregistration work queues cause double-registration and permanent memory l=
eaks?

steam_work_connect_cb() and steam_work_unregister_cb() run on different
workqueues. If they execute concurrently, they can both read steam->sensors
as NULL here because the check only holds rcu_read_lock() and provides no
mutual exclusion.

Could both threads allocate a new device, call input_register_device(), and
publish their pointer via rcu_assign_pointer(), leaving the first device
permanently orphaned and leaked?

>  	if (!sensors)
[ ... ]
> @@ -968,6 +1077,12 @@ static int steam_register(struct steam_device *stea=
m)
>  			strscpy(steam->serial_no, "XXXXXXXXXX",
>  					sizeof(steam->serial_no));
> =20
> +		ret =3D steam_get_attributes(steam);
> +		if (ret < 0)
> +			hid_err(steam->hdev,
> +				"%s:steam_get_attributes failed with error %d\n",
> +				__func__, ret);
> +
>  		hid_info(steam->hdev, "Steam Controller '%s' connected",
>  				steam->serial_no);

[Severity: High]
This is a pre-existing issue, but does a failure in steam_register() lead to
a Use-After-Free during steam_probe()?

Early in steam_register(), the steam object is added to the global
steam_devices list. If steam_register() fails, it returns the error code
without removing steam from the list.

Back in steam_probe(), the error is caught, and the code jumps to
goto err_hw_close;, bypassing the err_steam_unregister: label.
steam_probe() exits with an error, and the driver core automatically frees
the steam object allocated with devm_kzalloc().

Does the freed object remain in the global steam_devices list, where any
subsequent read or write to the lizard_mode sysfs parameter would dereferen=
ce
the freed pointer?

> =20
[ ... ]
> @@ -1491,6 +1610,16 @@ static const struct steam_axis_mapping steam_contr=
oller_axis_mappings[] =3D {
>  	{ /* sentinel */ },
>  };
> =20
> +static const struct steam_axis_mapping steam_controller_imu_mappings[] =
=3D {
> +	{ ABS_X,   1, 28 },
> +	{ ABS_Z,  -1, 30 },
> +	{ ABS_Y,   1, 32 },
> +	{ ABS_RX,  1, 34 },
> +	{ ABS_RZ,  1, 36 },

[Severity: Medium]
Does the ABS_RZ mapping have an inverted sign here, breaking the right-hand=
ed
coordinate system?

The Accel Y-axis is mapped to ABS_Z with a sign of -1, which matches the
Steam Deck mapping, indicating the physical IMU orientation is identical. O=
n the
Steam Deck, the Gyro Y-axis is mapped to ABS_RZ with a sign of -1 to
maintain the correct coordinate system.

Since the Steam Controller mapping uses 1 for Gyro Y (ABS_RZ) instead of
-1, will this report mathematically inverted yaw rotation to applications?

> +	{ ABS_RY,  1, 38 },
> +	{ /* sentinel */ },
> +};
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710020048.2337=
655-1-vi@endrift.com?part=3D4
