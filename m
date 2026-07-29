Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CA531F9B4
	for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 02:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785290962; cv=none; b=uhAqtKE2YD+2bAo9MOymCjDmdzNby8yqTj1OfTnJGo613dWHjvpxPzpvAPMFd494/ujV2lNrNxt+wfyQMl01Bzrn3VfXFGQFY7DkuiLUzI9ByfOTI/J/TQMRCifIOsD7sbXMCOWYvCh73sg+LDrdySAjboKYjIQ0ON+JSCt9qwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785290962; c=relaxed/simple;
	bh=QjF/ftpPcsz9PRer78zmEXDolMZYWv+BRr5M0e1P6+8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JMFJZ5T+H/aXWCqnM7EuWnuPv/sQxctNUwc7kalY69pSSO5crSwDG0yDf0rTybMth2HBnY8RIhUy0PGG5w+rC3fVSaWwSHGMms4d6ZHCldiM04UGikKOpQZBjxqxJo4uLAi0pM+XI0WCDrpbQZC5v8bGNtxbGEsPy/ftNAe43HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XrWjimYT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XrWjimYT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D28A51F000E9;
	Wed, 29 Jul 2026 02:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785290961;
	bh=KhVTItaPHA8hIn86Lv6164WlhEt6VGq82fHweAsnYLQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XrWjimYTqA35FXBGZJi8kv+bRScwSm8O6rLR1TsIMXUtmm6qTbwHoXyoNAVsm4z4K
	 0V4AzJKgYJFlJ9abs6lXavftP9BoVy/7qfeIBEIyYbkSCCcSNNxKcaH4T8oFZov0tS
	 0LewUMtU/+rUqMlHYmfLXIlrHOCtU1ylWajHv7bZNRY5TDuYq7pCy/Yk2Dpi/qFC4W
	 LdOrwtxwAVlOuMNXQbZLmJWwPGoTYDKXTn0MdTR2oUITMiethyytfT8m6rBLPQ4Nkq
	 ZwlBv8YxUCp14aIWibUIxfyWBzYCkJ3qmsw1WatoUJAu54dkLCGCqlIDLyaNPrUx/1
	 U7xB0Jcv4mavA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/11] HID: steam: Add support for sensor events on
 the Steam Controller (2015)
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260729015243.1170573-6-vi@endrift.com>
References: <20260729015243.1170573-1-vi@endrift.com>
 <20260729015243.1170573-6-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 02:09:20 +0000
Message-Id: <20260729020920.D28A51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] Enabling lizard mode via gamepad closure implicitly disables the=
 IMU, breaking active sensor listeners.

Pre-existing issues:
- [High] If `steam_register()` fails for a wired controller in `steam_probe=
()`, the `steam` device is freed while remaining linked in the global `stea=
m_devices` list.
- [High] Concurrent execution of workqueues causes double unregistration of=
 the input and sensors devices due to a TOCTOU race condition.
--

--- Patch [5]: [PATCH v4 05/11] HID: steam: Add support for sensor events o=
n the Steam Controller (2015) ---
commit bb1476f66b80150be67610fe42e5546b316d06ef
Author: Vicki Pfau <vi@endrift.com>

HID: steam: Add support for sensor events on the Steam Controller (2015)

Sensor support was added for the Steam Deck previously, but Steam
Controller sensor events were never added. This adds that missing support,
bringing Steam Controller support much closer to feature parity with things
like SDL and Steam itself.

> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> index 8bad79205b570..cabecd250072e 100644
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c

[ ... ]

> @@ -625,6 +689,42 @@ static void steam_input_close(struct input_dev *dev)
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
Does closing the gamepad evdev node implicitly disable the IMU, breaking
active sensor listeners?

When the gamepad evdev node is closed, the driver automatically re-enables
"lizard mode" by calling steam_set_lizard_mode(steam, true) in
steam_input_close(). This function sends the ID_LOAD_DEFAULT_SETTINGS
command to the controller, which performs a hardware state reset.

This reset wipes out the SETTING_IMU_MODE configuration previously requested
by steam_sensor_open() here. Since the driver does not track or coordinate
the IMU state across these logically independent evdev nodes, closing the
gamepad node while the sensor node is still open will cause the controller
to silently stop sending motion data.

> +
> +	return 0;
> +}
> +
> +static void steam_sensor_close(struct input_dev *dev)
> +{

[ ... ]

> @@ -917,9 +1029,6 @@ static void steam_sensors_unregister(struct steam_de=
vice *steam)
>  {
>  	struct input_dev *sensors;
> =20
> -	if (!(steam->quirks & STEAM_QUIRK_DECK))
> -		return;
> -
>  	rcu_read_lock();
>  	sensors =3D rcu_dereference(steam->sensors);
>  	rcu_read_unlock();

[Severity: High]
This isn't a bug introduced by this patch, but can concurrent execution of
workqueues cause a double unregistration of the input and sensors devices
due to a TOCTOU race condition?

The workqueues work_connect and unregister_work cache the device state under
a spinlock, drop the lock, and then act on the cached state. Both can run
concurrently on different CPUs and call steam_sensors_unregister() or
steam_input_unregister() simultaneously.

In both unregister functions, the pointers (steam->sensors and steam->input)
are read under rcu_read_lock(), but the lock is dropped immediately before
checking if the pointer is NULL. Because there is no atomic swap or mutex
protecting the RCU_INIT_POINTER assignment, both threads can read the same
non-NULL pointer, wait for RCU, and call input_unregister_device() on the
same device, causing a double-free and list corruption in the input core.

> @@ -967,6 +1076,12 @@ static int steam_register(struct steam_device *stea=
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

[Severity: High]
This is a pre-existing issue, but if steam_register() fails for a wired
controller in steam_probe(), is the steam device freed while remaining
linked in the global steam_devices list?

In steam_register(), the steam object is added to the global steam_devices
list under a lock. If registration subsequently fails (e.g., due to an
out-of-memory error in steam_input_register()), steam_register() returns an
error code without removing the object from the list.

For a wired controller, steam_probe() catches this error and jumps to
err_hw_close, bypassing err_steam_unregister and the steam_unregister()
function that would normally remove it from the list. When steam_probe()
returns the error, devres frees the steam object.

Any subsequent iteration over steam_devices (e.g., changing lizard mode via
sysfs) will dereference the freed memory, causing a use-after-free and
potential kernel panic.

>  		hid_info(steam->hdev, "Steam Controller '%s' connected",
>  				steam->serial_no);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729015243.1170=
573-1-vi@endrift.com?part=3D5
