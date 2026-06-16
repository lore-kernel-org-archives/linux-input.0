Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25708351C14
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 11:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781608970; cv=none; b=OWAUib3JZTezACORxVDQGAiU5iTczL14WgsFPQ807YM3Yaj61Eyo8fCqbb/n1Afri4c8qWZvKXVSzUiXuSL0eEPTu2DQWUtv+h5bfPT4aASQtT8ModuoZ8qqhu4MTt29911uF5DFhNBC/aril92wbZjKrOJoCoAWwvLEQm3nJCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781608970; c=relaxed/simple;
	bh=oe5nMZdF4HAIjK/pOtxf3ef6FQnSuli23cMZiYeqtZc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jLqH3vIuNOvHXlpAhceCvNtrPR+kOCvbg5pdV13zhuLVK+0CxwqF0+BdO+alBZdcuFPdoYjcyqRnXwPUwGr1yuZ1heRY9+eJGfymQoQJ/LhdgP9K0NXd5XM7Vdx59RGMt7fdqkaY/rygDhMHdDopu9+z4HhQYUa8EB9De4Z/vFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YSzCPF74; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YSzCPF74"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8E671F000E9;
	Tue, 16 Jun 2026 11:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781608968;
	bh=fuq9pZi+7HXnjudqFXcxT4OIycOeL00rwppoV2Giyyk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YSzCPF747dAgAHQUW5VDeEbC/NTvh9RWXCuUheWDeBrBUG1O4nRBf6ngqeEzJw/Pr
	 c5+VEQ3AgjoNMqqLdSw0vbq8ICQgH9ivRDAXnjngusJj7clgK474SiCj+PI1zwugN5
	 lo/0w0L2wWXlPRBCZD+QRuB1T+cD1Gv+5WwcrXwYSKfjZ+PUL+qYTHFSac7YLcTI8a
	 fUfECfWyRqVaLthFh5PdiWBRxL94nopMbwIWnIl95ff6KUPep7HM/rJAak8OHcs+o6
	 jyMq+usd6zc4v+egVi10wBDDRSbbydxninGHkz7uXGutnZgP4QsSSpuDkiwlLFJxoX
	 zN9EO0At01LHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/11] iio: humidity: hid-sensor-humidity: align
 parenthesis for readability
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanjay Chitroda" <sanjayembeddedse@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260616-15-jun-hid-iio-alignment-v1-2-0cd544286575@gmail.com>
References: <20260616-15-jun-hid-iio-alignment-v1-2-0cd544286575@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 11:22:48 +0000
Message-Id: <20260616112248.A8E671F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Global state corruption due to shared static `humidity_callbacks` =
struct
- [High] Out-of-bounds read and unaligned memory access in `humidity_captur=
e_sample()`
- [High] Possible list corruption and use-after-free during device removal
--

commit 340e0cdb97cad589244be8376c8b1f7f79ff105f
Author: Sanjay Chitroda <sanjayembeddedse@gmail.com>

iio: humidity: hid-sensor-humidity: align parenthesis for readability

Adjust alignment of parentheses to improve readability and
maintain consistency with kernel coding style

> diff --git a/drivers/iio/humidity/hid-sensor-humidity.c b/drivers/iio/hum=
idity/hid-sensor-humidity.c
> index be2338d5f4070..6fed019f4099f 100644
> --- a/drivers/iio/humidity/hid-sensor-humidity.c
> +++ b/drivers/iio/humidity/hid-sensor-humidity.c
[ ... ]
> @@ -141,8 +141,8 @@ static int humidity_proc_event(struct hid_sensor_hub_=
device *hsdev,
> =20
>  /* Capture samples in local storage */
>  static int humidity_capture_sample(struct hid_sensor_hub_device *hsdev,
> -				unsigned int usage_id, size_t raw_len,
> -				char *raw_data, void *pdev)
> +				   unsigned int usage_id, size_t raw_len,
> +				   char *raw_data, void *pdev)

[Severity: High]
This is a pre-existing issue, but is there a potential out-of-bounds read
and unaligned memory access here?

The HID sensor hub core invokes humidity_capture_sample() with raw_data
pointing to a field within a raw byte report buffer, and raw_len specifying
its exact byte size:

drivers/iio/humidity/hid-sensor-humidity.c:humidity_capture_sample() {
    ...
	case HID_USAGE_SENSOR_ATMOSPHERIC_HUMIDITY:
		humid_st->scan.humidity_data =3D *(s32 *)raw_data;

		return 0;
    ...
}

The driver unconditionally casts raw_data to a 32-bit integer pointer and
performs a 4-byte read. If raw_len is less than 4 (e.g., 1 or 2 bytes) and
the field resides at the end of the report buffer, does this result in an
out-of-bounds memory read?

Additionally, since HID reports are byte-packed, raw_data is not guaranteed
to be 32-bit aligned. Could an unaligned 32-bit read trigger a kernel panic
on architectures that strictly enforce alignment (e.g., ARMv5, SPARC)?

>  {
>  	struct iio_dev *indio_dev =3D platform_get_drvdata(pdev);
>  	struct hid_humidity_state *humid_st =3D iio_priv(indio_dev);
[ ... ]
> @@ -234,7 +234,7 @@ static int hid_humidity_probe(struct platform_device =
*pdev)
>  	atomic_set(&humid_st->common_attributes.data_ready, 0);
> =20
>  	ret =3D hid_sensor_setup_trigger(indio_dev, name,
> -				&humid_st->common_attributes);
> +				       &humid_st->common_attributes);
>  	if (ret)
>  		return ret;
> =20
> @@ -242,7 +242,7 @@ static int hid_humidity_probe(struct platform_device =
*pdev)
> =20
>  	humidity_callbacks.pdev =3D pdev;
>  	ret =3D sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_HUMIDITY,
> -					&humidity_callbacks);

[Severity: High]
This isn't a bug introduced by this patch, but could this cause global state
corruption?

The humidity_callbacks struct is defined statically at the file scope. Here,
during hid_humidity_probe(), its pdev field is overwritten with the
instance-specific pdev.

The HID core (sensor_hub_register_callback()) stores the pointer to this
shared struct rather than copying its contents. If multiple humidity sensors
are probed, the global pdev will be overwritten by the last probed instance.

When sensor_hub_raw_event() processes an event, does it access callback->pd=
ev
and erroneously route events from all connected sensors to the IIO device of
the last probed sensor, potentially causing data corruption or a
Use-After-Free if that device is later unbound?

> +					   &humidity_callbacks);
>  	if (ret)
>  		goto error_remove_trigger;
> =20

[Severity: High]
This is a pre-existing issue, but is there a possible list corruption and
use-after-free during device removal?

In hid_humidity_remove(), iio_device_unregister() is called before
sensor_hub_remove_callback(). This allows the HID sensor hub to continue
dispatching hardware events via the active callback while the IIO device is
being concurrently torn down.

When an event arrives, humidity_proc_event() checks the data_ready atomic
variable. Since this is an unlocked Time-Of-Check to Time-Of-Use race,
could data_ready be read as non-zero right before iio_device_unregister()
disables the trigger and clears it?

humidity_proc_event() then calls iio_push_to_buffers_with_timestamp(),
which iterates over the IIO buffer_list without taking locks.

Concurrently, iio_device_unregister() calls iio_disable_all_buffers()
which calls list_del_init() on the buffers. Does traversing a list
concurrently while elements are being removed and reinitialized cause
infinite loops or Use-After-Free crashes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616-15-jun-hid=
-iio-alignment-v1-0-0cd544286575@gmail.com?part=3D2
