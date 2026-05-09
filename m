Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2756F2F8EB0
	for <linux-input@vger.kernel.org>; Sat,  9 May 2026 10:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778323326; cv=none; b=LptDRBohFSzKqW3ojFHPToZCRjDu8Q+v26/vcTc45OvEjiw952m0qL3A5UZtTFBh6q0uSbWGfGOKVWB4bqtfjdJfh/7zVN5rIJDeWn0wJLXEbT9XN421bJrlMF3RsM8gT29DXWL5hgWJ+GVXOMUNggGmks463hN36gFu51Ts8SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778323326; c=relaxed/simple;
	bh=uGq97I5yLbhVgUspJJy0tRliJ3fSrYaEROeknBIeV6Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=trPcn7qF0whoQaJ0fgsxmpAXVysEvye5JbUJID+Ci7RZUyf5QXJDbFSJXjXVj2nNHz/FeiuFOg6XcwMD3n3/48oV68fvRv1Yd+pK2XJ4ZipqN6e/iIInV/VgQTxjoMGOthCdWPhVU83SJuY8ymNGpDHP72KF5vrLC2At5Q9LW3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bsZi/7+2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bsZi/7+2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51481C2BCB2;
	Sat,  9 May 2026 10:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778323325;
	bh=uGq97I5yLbhVgUspJJy0tRliJ3fSrYaEROeknBIeV6Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=bsZi/7+2UHEPFayFZsKN/CxACL76gxh943YVajZwZO0clOPAZ7cTpctG/u+KT6N+A
	 ZCGTOYiGrwNUHFoETGhyA78lKUw0tcqKEQB2JZETt1pVOuaEcMIshe/dlFLQqHp/yy
	 n/nwXvUrVKzO1p46iRIAd17ZBGwU052XZaRYr66CTGVI2Tro4fCLu+jw+vvXU/9xmC
	 vpf3wufbRtlHMqxC1thblb0NzHNQtmmdLuPV7+exN4LClH7MDYbp/0AQAH37LttEA3
	 HGepQdbVlIvN2Nz/TkIq+Q4C2+3uc758TOEqwdZ4rDWBekVV1ykJp4eVhPSwMsRKWj
	 UNucbSRxParBA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/9] iio: hid-sensors: drop redundant iio_dev
 argument
Reply-To: sashiko@lists.linux.dev
To: "Sanjay Chitroda" <sanjayembeddedse@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260509101040.791404-2-sanjayembedded@gmail.com>
References: <20260509101040.791404-2-sanjayembedded@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 09 May 2026 10:42:04 +0000
Message-Id: <20260509104205.51481C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] This problem wasn't introduced by this patch, but the removal sequ=
ence across HID IIO drivers cancels asynchronous suspend requests, leaving =
the hardware powered on, which violates PM subsystem guidelines.
- [High] This problem wasn't introduced by this patch, but in `hid-sensor-t=
emperature.c`, the trigger is manually unregistered and freed in the `remov=
e` callback while the IIO device is still active and registered, creating a=
 use-after-free vulnerability.
--

commit 774f02b73d8b538afc5af51312b8682afec55f98
Author: Sanjay Chitroda <sanjayembeddedse@gmail.com>

iio: hid-sensors: drop redundant iio_dev argument

This commit removes the unused iio_dev argument from
hid_sensor_remove_trigger() across all HID IIO drivers, adapting the
function prototype to simplify the API for a future devm-based conversion.

> diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/=
hid-sensor-accel-3d.c
> index 2ff591b3458f7..a63dae90dadc5 100644
> --- a/drivers/iio/accel/hid-sensor-accel-3d.c
> +++ b/drivers/iio/accel/hid-sensor-accel-3d.c
[ ... ]
> @@ -429,7 +429,7 @@ static void hid_accel_3d_remove(struct platform_devic=
e *pdev)
> =20
>  	sensor_hub_remove_callback(hsdev, hsdev->usage);
>  	iio_device_unregister(indio_dev);
> -	hid_sensor_remove_trigger(indio_dev, &accel_state->common_attributes);
> +	hid_sensor_remove_trigger(&accel_state->common_attributes);
>  }

This problem wasn't introduced by this patch, but could this removal sequen=
ce
leave the hardware powered on?

Looking at the removal path across these drivers, iio_device_unregister()
disables the IIO buffers, which eventually calls hid_sensor_power_state()
and queues an asynchronous suspend via pm_runtime_put_autosuspend().

Immediately afterward, hid_sensor_remove_trigger() calls
pm_runtime_disable(). Does calling pm_runtime_disable() immediately after an
async put cancel the pending suspend work, leaving the physical device acti=
ve
while marking it suspended in the PM core?

[ ... ]
> diff --git a/drivers/iio/temperature/hid-sensor-temperature.c b/drivers/i=
io/temperature/hid-sensor-temperature.c
> index 9f628a8e5cfbe..60d4fcc8043b6 100644
> --- a/drivers/iio/temperature/hid-sensor-temperature.c
> +++ b/drivers/iio/temperature/hid-sensor-temperature.c
[ ... ]
> @@ -265,7 +265,7 @@ static void hid_temperature_remove(struct platform_de=
vice *pdev)
>  	struct temperature_state *temp_st =3D iio_priv(indio_dev);
> =20
>  	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_TEMPERATURE);
> -	hid_sensor_remove_trigger(indio_dev, &temp_st->common_attributes);
> +	hid_sensor_remove_trigger(&temp_st->common_attributes);
>  }

This problem also wasn't introduced by this patch, but is there a
use-after-free risk in this specific driver's removal sequence?

The temperature driver uses devm_iio_device_register() to register the IIO
device, which means the device unregistration is deferred until the devres
cleanup phase after hid_temperature_remove() returns.

However, hid_sensor_remove_trigger() is called manually here and it calls
iio_trigger_free(). Since the IIO device remains fully registered and expos=
ed
to user-space until devres runs, could concurrent sysfs access or buffer
operations dereference the freed trigger pointer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260509101040.7914=
04-1-sanjayembedded@gmail.com?part=3D1
