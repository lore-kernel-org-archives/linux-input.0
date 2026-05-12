Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C863812EA;
	Tue, 12 May 2026 12:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778589476; cv=none; b=g/q122zkJsO5xR4RZOqD94fqn9x1nwJ4ioQ8mLkRp5fqGiCX5vKEM2jsQTnLGb4x0DcpFXGn3gEfQd2LW/LAFyF8761NKFWa98VckJyqtLf820MX/SR58l3cjQKraRd7lmdP+4otvZ1zQRt1NmtfzJ5dwMxxFoAx7ItlG3ZbuWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778589476; c=relaxed/simple;
	bh=q37WxxtMql3eKH2+td509ILDk1rqmsmez7vsidO+psU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kBwF0HyKbWfCWzG+lJuWZjPJUlS2ROlJn4hYV/aVaRIdb/CO7rwP3dZLE8L3CpFkfdPzrd+WNIO3QhI+gi1ty+36y8WVNJOSBn7k7uJsoj9/mhgZHZR3ANXNPGBXj5g32UU8B7wnIWK/aSMOETkyt9Cz8b5m4nUBPLWxvSnYYso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e1xQTLHR; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e1xQTLHR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778589469; x=1810125469;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=q37WxxtMql3eKH2+td509ILDk1rqmsmez7vsidO+psU=;
  b=e1xQTLHRDSWHyAbaanzCwgoeHWfAL1n2eNhTE8L4juj7bHwV1CTHIz38
   YaXSn0/m7vTtR7kksWDPYjxh/XPAXcDMsRsjM4NVSP5hXnywcUsd9NsSD
   muhD+NEhn5XagbAaWcI37lFoKLXifFJmKi7wP/jD0EFk94bGNG3zcqOYD
   ixJEn5Kn1Xpc5/Q9eGOBGpEq4vWcnNPxKzrnFraGEkDKqSc7LB1Fn6LhV
   AMRw9LW4++0v9ThBe842HUtQc+bumO7Gx9ybWkI4bizZ1Ttm2TwnVLyxP
   s6vXpRQr8U9UQSBGhPj0ac0pcd5XTZhGcr6H5KO0pErkA2dsi2F1fYDow
   A==;
X-CSE-ConnectionGUID: 4TtNJF2xTq23rbfKyV+7og==
X-CSE-MsgGUID: R2n++yYRSDqKHs+xnKxNKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="78525631"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="78525631"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 05:37:45 -0700
X-CSE-ConnectionGUID: Fff0bQwnQ+mgsNKMglbMAw==
X-CSE-MsgGUID: Rxs1p1lkQ7OZVehu60bLAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="235094425"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.111.218]) ([10.125.111.218])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 05:37:44 -0700
Message-ID: <5ab0342dd9d1cffd9eb544a478a01c5a19da4237.camel@linux.intel.com>
Subject: Re: [PATCH v3 1/9] iio: hid-sensors: drop redundant iio_dev argument
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>, jikos@kernel.org, 
	jic23@kernel.org
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	sakari.ailus@linux.intel.com, linux-input@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 12 May 2026 05:37:42 -0700
In-Reply-To: <20260509101040.791404-2-sanjayembedded@gmail.com>
References: <20260509101040.791404-1-sanjayembedded@gmail.com>
	 <20260509101040.791404-2-sanjayembedded@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-05-09 at 15:40 +0530, Sanjay Chitroda wrote:
> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
>=20
> hid_sensor_remove_trigger() uses struct hid_sensor_common to release
> resources acquired during trigger setup.
>=20
> Earlier implementations required struct iio_dev to clean up buffers,
> but with the current code this argument is no longer used and is
> redundant.
>=20
> Adapt to hid_sensor_remove_trigger() API change across all HID IIO
> drivers to match updated prototype.
>=20
> Removing it simplifies the API and is a preparatory step toward
> converting the trigger handling to a devm-based API.
>=20
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
> =C2=A0drivers/iio/accel/hid-sensor-accel-3d.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++--
> =C2=A0drivers/iio/common/hid-sensors/hid-sensor-trigger.c=C2=A0 | 3 +--
> =C2=A0drivers/iio/common/hid-sensors/hid-sensor-trigger.h=C2=A0 | 3 +--
> =C2=A0drivers/iio/gyro/hid-sensor-gyro-3d.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++--
> =C2=A0drivers/iio/humidity/hid-sensor-humidity.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++--
> =C2=A0drivers/iio/light/hid-sensor-als.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 4 ++--
> =C2=A0drivers/iio/light/hid-sensor-prox.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
4 ++--
> =C2=A0drivers/iio/magnetometer/hid-sensor-magn-3d.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 4 ++--
> =C2=A0drivers/iio/orientation/hid-sensor-incl-3d.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++--
> =C2=A0drivers/iio/orientation/hid-sensor-rotation.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 4 ++--
> =C2=A0drivers/iio/position/hid-sensor-custom-intel-hinge.c | 4 ++--
> =C2=A0drivers/iio/pressure/hid-sensor-press.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++--
> =C2=A0drivers/iio/temperature/hid-sensor-temperature.c=C2=A0=C2=A0=C2=A0=
=C2=A0 | 4 ++--
> =C2=A013 files changed, 24 insertions(+), 26 deletions(-)
>=20
> diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c
> b/drivers/iio/accel/hid-sensor-accel-3d.c
> index 2ff591b3458f..a63dae90dadc 100644
> --- a/drivers/iio/accel/hid-sensor-accel-3d.c
> +++ b/drivers/iio/accel/hid-sensor-accel-3d.c
> @@ -416,7 +416,7 @@ static int hid_accel_3d_probe(struct
> platform_device *pdev)
> =C2=A0error_iio_unreg:
> =C2=A0	iio_device_unregister(indio_dev);
> =C2=A0error_remove_trigger:
> -	hid_sensor_remove_trigger(indio_dev, &accel_state-
> >common_attributes);
> +	hid_sensor_remove_trigger(&accel_state->common_attributes);
> =C2=A0	return ret;
> =C2=A0}
> =C2=A0
> @@ -429,7 +429,7 @@ static void hid_accel_3d_remove(struct
> platform_device *pdev)
> =C2=A0
> =C2=A0	sensor_hub_remove_callback(hsdev, hsdev->usage);
> =C2=A0	iio_device_unregister(indio_dev);
> -	hid_sensor_remove_trigger(indio_dev, &accel_state-
> >common_attributes);
> +	hid_sensor_remove_trigger(&accel_state->common_attributes);
> =C2=A0}
> =C2=A0
> =C2=A0static const struct platform_device_id hid_accel_3d_ids[] =3D {
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> index 417c4ab8c1b2..28d050b45c74 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> @@ -218,8 +218,7 @@ static const struct iio_buffer_setup_ops
> hid_sensor_buffer_ops =3D {
> =C2=A0	.predisable =3D buffer_predisable,
> =C2=A0};
> =C2=A0
> -void hid_sensor_remove_trigger(struct iio_dev *indio_dev,
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct hid_sensor_common *attrb)
> +void hid_sensor_remove_trigger(struct hid_sensor_common *attrb)
> =C2=A0{
> =C2=A0	if (atomic_read(&attrb->runtime_pm_enable))
> =C2=A0		pm_runtime_disable(&attrb->pdev->dev);
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.h
> b/drivers/iio/common/hid-sensors/hid-sensor-trigger.h
> index f94fca4f1edf..afec46ecbe71 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.h
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.h
> @@ -16,8 +16,7 @@ extern const struct dev_pm_ops hid_sensor_pm_ops;
> =C2=A0
> =C2=A0int hid_sensor_setup_trigger(struct iio_dev *indio_dev, const char
> *name,
> =C2=A0				struct hid_sensor_common *attrb);
> -void hid_sensor_remove_trigger(struct iio_dev *indio_dev,
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct hid_sensor_common *attrb)=
;
> +void hid_sensor_remove_trigger(struct hid_sensor_common *attrb);
> =C2=A0int hid_sensor_power_state(struct hid_sensor_common *st, bool
> state);
> =C2=A0
> =C2=A0#endif
> diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c
> b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> index c340cc899a7c..fe663b19e902 100644
> --- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
> +++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> @@ -354,7 +354,7 @@ static int hid_gyro_3d_probe(struct
> platform_device *pdev)
> =C2=A0error_iio_unreg:
> =C2=A0	iio_device_unregister(indio_dev);
> =C2=A0error_remove_trigger:
> -	hid_sensor_remove_trigger(indio_dev, &gyro_state-
> >common_attributes);
> +	hid_sensor_remove_trigger(&gyro_state->common_attributes);
> =C2=A0	return ret;
> =C2=A0}
> =C2=A0
> @@ -367,7 +367,7 @@ static void hid_gyro_3d_remove(struct
> platform_device *pdev)
> =C2=A0
> =C2=A0	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_GYRO_3D);
> =C2=A0	iio_device_unregister(indio_dev);
> -	hid_sensor_remove_trigger(indio_dev, &gyro_state-
> >common_attributes);
> +	hid_sensor_remove_trigger(&gyro_state->common_attributes);
> =C2=A0}
> =C2=A0
> =C2=A0static const struct platform_device_id hid_gyro_3d_ids[] =3D {
> diff --git a/drivers/iio/humidity/hid-sensor-humidity.c
> b/drivers/iio/humidity/hid-sensor-humidity.c
> index be2338d5f407..e580a2af9562 100644
> --- a/drivers/iio/humidity/hid-sensor-humidity.c
> +++ b/drivers/iio/humidity/hid-sensor-humidity.c
> @@ -255,7 +255,7 @@ static int hid_humidity_probe(struct
> platform_device *pdev)
> =C2=A0error_remove_callback:
> =C2=A0	sensor_hub_remove_callback(hsdev,
> HID_USAGE_SENSOR_HUMIDITY);
> =C2=A0error_remove_trigger:
> -	hid_sensor_remove_trigger(indio_dev, &humid_st-
> >common_attributes);
> +	hid_sensor_remove_trigger(&humid_st->common_attributes);
> =C2=A0	return ret;
> =C2=A0}
> =C2=A0
> @@ -268,7 +268,7 @@ static void hid_humidity_remove(struct
> platform_device *pdev)
> =C2=A0
> =C2=A0	iio_device_unregister(indio_dev);
> =C2=A0	sensor_hub_remove_callback(hsdev,
> HID_USAGE_SENSOR_HUMIDITY);
> -	hid_sensor_remove_trigger(indio_dev, &humid_st-
> >common_attributes);
> +	hid_sensor_remove_trigger(&humid_st->common_attributes);
> =C2=A0}
> =C2=A0
> =C2=A0static const struct platform_device_id hid_humidity_ids[] =3D {
> diff --git a/drivers/iio/light/hid-sensor-als.c
> b/drivers/iio/light/hid-sensor-als.c
> index 384572844162..9b57cdced18a 100644
> --- a/drivers/iio/light/hid-sensor-als.c
> +++ b/drivers/iio/light/hid-sensor-als.c
> @@ -432,7 +432,7 @@ static int hid_als_probe(struct platform_device
> *pdev)
> =C2=A0error_iio_unreg:
> =C2=A0	iio_device_unregister(indio_dev);
> =C2=A0error_remove_trigger:
> -	hid_sensor_remove_trigger(indio_dev, &als_state-
> >common_attributes);
> +	hid_sensor_remove_trigger(&als_state->common_attributes);
> =C2=A0	return ret;
> =C2=A0}
> =C2=A0
> @@ -445,7 +445,7 @@ static void hid_als_remove(struct platform_device
> *pdev)
> =C2=A0
> =C2=A0	sensor_hub_remove_callback(hsdev, hsdev->usage);
> =C2=A0	iio_device_unregister(indio_dev);
> -	hid_sensor_remove_trigger(indio_dev, &als_state-
> >common_attributes);
> +	hid_sensor_remove_trigger(&als_state->common_attributes);
> =C2=A0}
> =C2=A0
> =C2=A0static const struct platform_device_id hid_als_ids[] =3D {
> diff --git a/drivers/iio/light/hid-sensor-prox.c
> b/drivers/iio/light/hid-sensor-prox.c
> index efa904a70d0e..473c45626487 100644
> --- a/drivers/iio/light/hid-sensor-prox.c
> +++ b/drivers/iio/light/hid-sensor-prox.c
> @@ -340,7 +340,7 @@ static int hid_prox_probe(struct platform_device
> *pdev)
> =C2=A0error_iio_unreg:
> =C2=A0	iio_device_unregister(indio_dev);
> =C2=A0error_remove_trigger:
> -	hid_sensor_remove_trigger(indio_dev, &prox_state-
> >common_attributes);
> +	hid_sensor_remove_trigger(&prox_state->common_attributes);
> =C2=A0	return ret;
> =C2=A0}
> =C2=A0
> @@ -353,7 +353,7 @@ static void hid_prox_remove(struct
> platform_device *pdev)
> =C2=A0
> =C2=A0	sensor_hub_remove_callback(hsdev, hsdev->usage);
> =C2=A0	iio_device_unregister(indio_dev);
> -	hid_sensor_remove_trigger(indio_dev, &prox_state-
> >common_attributes);
> +	hid_sensor_remove_trigger(&prox_state->common_attributes);
> =C2=A0}
> =C2=A0
> =C2=A0static const struct platform_device_id hid_prox_ids[] =3D {
> diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> index b01dd53eb100..8be3dfe4dd58 100644
> --- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> +++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> @@ -542,7 +542,7 @@ static int hid_magn_3d_probe(struct
> platform_device *pdev)
> =C2=A0error_iio_unreg:
> =C2=A0	iio_device_unregister(indio_dev);
> =C2=A0error_remove_trigger:
> -	hid_sensor_remove_trigger(indio_dev, &magn_state-
> >magn_flux_attributes);
> +	hid_sensor_remove_trigger(&magn_state-
> >magn_flux_attributes);
> =C2=A0	return ret;
> =C2=A0}
> =C2=A0
> @@ -555,7 +555,7 @@ static void hid_magn_3d_remove(struct
> platform_device *pdev)
> =C2=A0
> =C2=A0	sensor_hub_remove_callback(hsdev,
> HID_USAGE_SENSOR_COMPASS_3D);
> =C2=A0	iio_device_unregister(indio_dev);
> -	hid_sensor_remove_trigger(indio_dev, &magn_state-
> >magn_flux_attributes);
> +	hid_sensor_remove_trigger(&magn_state-
> >magn_flux_attributes);
> =C2=A0}
> =C2=A0
> =C2=A0static const struct platform_device_id hid_magn_3d_ids[] =3D {
> diff --git a/drivers/iio/orientation/hid-sensor-incl-3d.c
> b/drivers/iio/orientation/hid-sensor-incl-3d.c
> index 4e23a598a3fb..56fd9c53dfc2 100644
> --- a/drivers/iio/orientation/hid-sensor-incl-3d.c
> +++ b/drivers/iio/orientation/hid-sensor-incl-3d.c
> @@ -378,7 +378,7 @@ static int hid_incl_3d_probe(struct
> platform_device *pdev)
> =C2=A0error_iio_unreg:
> =C2=A0	iio_device_unregister(indio_dev);
> =C2=A0error_remove_trigger:
> -	hid_sensor_remove_trigger(indio_dev, &incl_state-
> >common_attributes);
> +	hid_sensor_remove_trigger(&incl_state->common_attributes);
> =C2=A0	return ret;
> =C2=A0}
> =C2=A0
> @@ -391,7 +391,7 @@ static void hid_incl_3d_remove(struct
> platform_device *pdev)
> =C2=A0
> =C2=A0	sensor_hub_remove_callback(hsdev,
> HID_USAGE_SENSOR_INCLINOMETER_3D);
> =C2=A0	iio_device_unregister(indio_dev);
> -	hid_sensor_remove_trigger(indio_dev, &incl_state-
> >common_attributes);
> +	hid_sensor_remove_trigger(&incl_state->common_attributes);
> =C2=A0}
> =C2=A0
> =C2=A0static const struct platform_device_id hid_incl_3d_ids[] =3D {
> diff --git a/drivers/iio/orientation/hid-sensor-rotation.c
> b/drivers/iio/orientation/hid-sensor-rotation.c
> index 4a11e4555099..56fdb3412fe3 100644
> --- a/drivers/iio/orientation/hid-sensor-rotation.c
> +++ b/drivers/iio/orientation/hid-sensor-rotation.c
> @@ -353,7 +353,7 @@ static int hid_dev_rot_probe(struct
> platform_device *pdev)
> =C2=A0error_iio_unreg:
> =C2=A0	iio_device_unregister(indio_dev);
> =C2=A0error_remove_trigger:
> -	hid_sensor_remove_trigger(indio_dev, &rot_state-
> >common_attributes);
> +	hid_sensor_remove_trigger(&rot_state->common_attributes);
> =C2=A0	return ret;
> =C2=A0}
> =C2=A0
> @@ -366,7 +366,7 @@ static void hid_dev_rot_remove(struct
> platform_device *pdev)
> =C2=A0
> =C2=A0	sensor_hub_remove_callback(hsdev, hsdev->usage);
> =C2=A0	iio_device_unregister(indio_dev);
> -	hid_sensor_remove_trigger(indio_dev, &rot_state-
> >common_attributes);
> +	hid_sensor_remove_trigger(&rot_state->common_attributes);
> =C2=A0}
> =C2=A0
> =C2=A0static const struct platform_device_id hid_dev_rot_ids[] =3D {
> diff --git a/drivers/iio/position/hid-sensor-custom-intel-hinge.c
> b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
> index a26d391661fd..5288b63f4e21 100644
> --- a/drivers/iio/position/hid-sensor-custom-intel-hinge.c
> +++ b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
> @@ -337,7 +337,7 @@ static int hid_hinge_probe(struct platform_device
> *pdev)
> =C2=A0error_remove_callback:
> =C2=A0	sensor_hub_remove_callback(hsdev, hsdev->usage);
> =C2=A0error_remove_trigger:
> -	hid_sensor_remove_trigger(indio_dev, &st-
> >common_attributes);
> +	hid_sensor_remove_trigger(&st->common_attributes);
> =C2=A0	return ret;
> =C2=A0}
> =C2=A0
> @@ -350,7 +350,7 @@ static void hid_hinge_remove(struct
> platform_device *pdev)
> =C2=A0
> =C2=A0	iio_device_unregister(indio_dev);
> =C2=A0	sensor_hub_remove_callback(hsdev, hsdev->usage);
> -	hid_sensor_remove_trigger(indio_dev, &st-
> >common_attributes);
> +	hid_sensor_remove_trigger(&st->common_attributes);
> =C2=A0}
> =C2=A0
> =C2=A0static const struct platform_device_id hid_hinge_ids[] =3D {
> diff --git a/drivers/iio/pressure/hid-sensor-press.c
> b/drivers/iio/pressure/hid-sensor-press.c
> index 5f1d6abda3e4..2bf5d055e175 100644
> --- a/drivers/iio/pressure/hid-sensor-press.c
> +++ b/drivers/iio/pressure/hid-sensor-press.c
> @@ -319,7 +319,7 @@ static int hid_press_probe(struct platform_device
> *pdev)
> =C2=A0error_iio_unreg:
> =C2=A0	iio_device_unregister(indio_dev);
> =C2=A0error_remove_trigger:
> -	hid_sensor_remove_trigger(indio_dev, &press_state-
> >common_attributes);
> +	hid_sensor_remove_trigger(&press_state->common_attributes);
> =C2=A0	return ret;
> =C2=A0}
> =C2=A0
> @@ -332,7 +332,7 @@ static void hid_press_remove(struct
> platform_device *pdev)
> =C2=A0
> =C2=A0	sensor_hub_remove_callback(hsdev,
> HID_USAGE_SENSOR_PRESSURE);
> =C2=A0	iio_device_unregister(indio_dev);
> -	hid_sensor_remove_trigger(indio_dev, &press_state-
> >common_attributes);
> +	hid_sensor_remove_trigger(&press_state->common_attributes);
> =C2=A0}
> =C2=A0
> =C2=A0static const struct platform_device_id hid_press_ids[] =3D {
> diff --git a/drivers/iio/temperature/hid-sensor-temperature.c
> b/drivers/iio/temperature/hid-sensor-temperature.c
> index 9f628a8e5cfb..60d4fcc8043b 100644
> --- a/drivers/iio/temperature/hid-sensor-temperature.c
> +++ b/drivers/iio/temperature/hid-sensor-temperature.c
> @@ -253,7 +253,7 @@ static int hid_temperature_probe(struct
> platform_device *pdev)
> =C2=A0error_remove_callback:
> =C2=A0	sensor_hub_remove_callback(hsdev,
> HID_USAGE_SENSOR_TEMPERATURE);
> =C2=A0error_remove_trigger:
> -	hid_sensor_remove_trigger(indio_dev, &temp_st-
> >common_attributes);
> +	hid_sensor_remove_trigger(&temp_st->common_attributes);
> =C2=A0	return ret;
> =C2=A0}
> =C2=A0
> @@ -265,7 +265,7 @@ static void hid_temperature_remove(struct
> platform_device *pdev)
> =C2=A0	struct temperature_state *temp_st =3D iio_priv(indio_dev);
> =C2=A0
> =C2=A0	sensor_hub_remove_callback(hsdev,
> HID_USAGE_SENSOR_TEMPERATURE);
> -	hid_sensor_remove_trigger(indio_dev, &temp_st-
> >common_attributes);
> +	hid_sensor_remove_trigger(&temp_st->common_attributes);
> =C2=A0}
> =C2=A0
> =C2=A0static const struct platform_device_id hid_temperature_ids[] =3D {
