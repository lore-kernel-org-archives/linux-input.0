Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E63241C8C
	for <linux-input@vger.kernel.org>; Mon, 22 Jun 2026 05:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782106980; cv=none; b=C/uEq3s58z6JbLD9e51He6RPHuXpwV+Ob6RIhLpKcYCNxDvFFUg6nVw4yWQ6xT+xdQEnI49/jHvAG5eDSoS+y2zxGZTrowjIoz6TiaY4ZOoSKIJW1+fLtXpYSgXyigJVV3XwmkwWCfN0n++8EUxUuKh6ta7dPX+4i+uxz9QsClg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782106980; c=relaxed/simple;
	bh=EexrPsR+n3sjsRFYaqw8V7w4kQrqYFGWmUwv46KtFIs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JOshtN7P3Xj7TaHcQFJeOBT4VEy/UP5xNZbNLR4x9LR8mZZE0+ZywRUcXvnhgScCZMro+FOqiQb61bi8435Xkyq0s2ztDWjfP8Jp4piAQ7+ZgXzuKd66uuGjEwGTTjRT2k+z/sxihNgZ49anxTepo5R1M8qtf3N5NNkM5XadH4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZoJS8mL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZoJS8mL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6CCF1F000E9;
	Mon, 22 Jun 2026 05:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782106978;
	bh=XeOvJV0AwcaRKxKFqp2nsqxxpCi5WT/6MJ4WDHGkCYI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CZoJS8mLPIoZm16AxYraxgiMHifYi/t66KQHnM8YTFxJhuB4Ujj7CetynmP0/ffr1
	 FD2ApFUCL//WPI2ReMWx5pUJ27aJGZI0zA1rhiYI6fWCOOXSipN4BOaWQK//fWo7qN
	 zq2GXfH2I9L31SIEtfvFphhoN2fGPYHZfPYJS38r8tlNbmbiDkEGmVCpoo2N1vg8vD
	 uD9FmAAMT4tGyLGXrCsQZyb0XpqqhRW+5pf7mKshvQxS0b0m/g/8yUAeE0I0xLCKHE
	 Zx9F7UnJJP6psHJn43WR2fhy8GtoW7u2gtlYHG6Qwdlcco/9Wans9yqaq8dVIWk9jQ
	 s0QaJIMeROshA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/8] iio: orientation: hid-sensor-rotation: Avoid
 race between callback setup and device exposure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanjay Chitroda" <sanjayembeddedse@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260622-5-june-hid-iio-race-fixes-v2-1-1cfabcd1881e@gmail.com>
References: <20260622-5-june-hid-iio-race-fixes-v2-0-1cfabcd1881e@gmail.com>
 <20260622-5-june-hid-iio-race-fixes-v2-1-1cfabcd1881e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 05:42:58 +0000
Message-Id: <20260622054258.A6CCF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Reordering `iio_device_unregister()` before `sensor_hub_remove_cal=
lback()` creates a TOCTOU race condition that can lead to IIO buffer list c=
orruption and infinite loops.

Pre-existing issues:
- [High] Concurrent execution of sensor hub callbacks can cause use-after-f=
ree on probe failure or device removal due to lack of synchronization.
- [High] Malicious or malformed HID devices can trigger an out-of-bounds re=
ad of kernel memory due to a lack of bounds checking on the raw data buffer.
--

commit 3524bf526c21d398ff01cdcd77d3cff858988d72
Author: Sanjay Chitroda <sanjayembeddedse@gmail.com>

iio: orientation: hid-sensor-rotation: Avoid race between callback setup an=
d device exposure

This patch reorders the probe and remove paths in the hid-sensor-rotation
driver to ensure sensor hub callbacks are registered before the IIO device
is exposed, and removed after the device is unregistered. This aims to
prevent userspace from accessing the device before callbacks are ready.

> diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/=
orientation/hid-sensor-rotation.c
> --- a/drivers/iio/orientation/hid-sensor-rotation.c
> +++ b/drivers/iio/orientation/hid-sensor-rotation.c

[ ... ]

> @@ -345,13 +339,19 @@ static int hid_dev_rot_probe(struct platform_device=
 *pdev)
>  	rot_state->callbacks.send_event =3D dev_rot_proc_event;
>  	rot_state->callbacks.capture_sample =3D dev_rot_capture_sample;

[Severity: High]
This isn't a bug introduced by this patch, but does dev_rot_capture_sample()
lack bounds checking on the raw data buffer?

If a maliciously crafted HID descriptor specifies a small size (e.g., 4 byt=
es)
for the quaternion field, the HID core will allocate a buffer matching that
small size.

In dev_rot_capture_sample(), if the size doesn't match the expected 16 byte=
s,
it falls back to a blind copy:

        } else {
                memcpy(&rot_state->scan.sampled_vals, raw_data,
                       sizeof(rot_state->scan.sampled_vals));
        }

Since sizeof(rot_state->scan.sampled_vals) is 16 bytes, this reads past the
end of a smaller raw_data buffer and copies adjacent kernel heap memory into
the IIO buffer. Userspace can then read this IIO buffer, resulting in an
information leak.

>  	rot_state->callbacks.pdev =3D pdev;
>  	ret =3D sensor_hub_register_callback(hsdev, hsdev->usage,
>  					&rot_state->callbacks);
>  	if (ret) {
>  		dev_err(&pdev->dev, "callback reg failed\n");
> -		goto error_iio_unreg;
> +		goto error_remove_trigger;
> +	}
> +
> +	ret =3D iio_device_register(indio_dev);
> +	if (ret) {
>  		dev_err(&pdev->dev, "device register failed\n");
> -		goto error_remove_trigger;
> -	}
> =20
>  	return 0;
> =20
> -error_iio_unreg:
> -	iio_device_unregister(indio_dev);
> +error_remove_callback:
> +	sensor_hub_remove_callback(hsdev, hsdev->usage);

[Severity: High]
This is a pre-existing issue, but does removing the callback here leave a
window for a use-after-free?

sensor_hub_raw_event() looks up a callback and executes it under pdata->loc=
k.
However, sensor_hub_remove_callback() removes the callback from
pdata->dyn_callback_list without waiting for any currently executing
callbacks in sensor_hub_raw_event() to complete.

If a callback is executing concurrently on another CPU when probe fails or
the device is removed, the driver will exit and devres will free the
indio_dev and rot_state memory structures. The still-executing callback
will then continue reading and writing to the freed rot_state fields.

>  error_remove_trigger:
>  	hid_sensor_remove_trigger(indio_dev, &rot_state->common_attributes);
>  	return ret;
> @@ -364,8 +364,8 @@ static void hid_dev_rot_remove(struct platform_device=
 *pdev)
>  	struct iio_dev *indio_dev =3D platform_get_drvdata(pdev);
>  	struct dev_rot_state *rot_state =3D iio_priv(indio_dev);
> =20
> -	sensor_hub_remove_callback(hsdev, hsdev->usage);
>  	iio_device_unregister(indio_dev);
> +	sensor_hub_remove_callback(hsdev, hsdev->usage);

[Severity: High]
Does reordering iio_device_unregister() before sensor_hub_remove_callback()
create a race condition that can lead to an infinite loop?

iio_device_unregister() disables all buffers, which calls list_del_init() on
the buffer list under the IIO core info_exist_lock. If the sensor hub
callback has not been removed yet, a hardware interrupt can still trigger
the callback, which calls dev_rot_proc_event() and subsequently
iio_push_to_buffers().
       =20
iio_push_to_buffers() iterates over the buffer list locklessly using
list_for_each_entry(). If list_del_init() executes concurrently with this
lockless iteration, the 'next' pointer of the removed list element points
to itself. This causes the lockless iterator to enter an infinite loop and
hang the kernel.

Should the data producer (the callback) be stopped before destroying the
data consumer (unregistering the IIO device)?

>  	hid_sensor_remove_trigger(indio_dev, &rot_state->common_attributes);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622-5-june-hid=
-iio-race-fixes-v2-0-1cfabcd1881e@gmail.com?part=3D1
