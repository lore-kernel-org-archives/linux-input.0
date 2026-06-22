Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F127B640;
	Mon, 22 Jun 2026 15:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782141859; cv=none; b=D8vzGnWagNYxRL+mYWDrKhzsBqbNlZI56/hZ1JOFj9oTLMsdR9/Ytjcxr9phduvZzhpGgUx5ICdHFAYxON/spKyNsyfUGlHjl1AlNwiFxKR3CyQ1yZ/E7BSeQLFZ3Ff+OQ0XZiE5PAQNiWnr+lF/tyfVukpkVOg/V0nqTOmLze4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782141859; c=relaxed/simple;
	bh=J9Pl+G5mDuRjkpjaRQc8OuA6gV59Zw5/BTNqkd09/aM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a83372wV72QP7ieiK5NwgG1JNEJM3CriwMiw6Y+pXiA1vzDhpQDShH72UC0FiOkmoudkeD0bbwfTjYoN/8xQZceGubo7lfPH/o90iUO1plpBmbHhlBFq8Z3Ojww3PADvprVKRjXYQTxlZjvQdZOqZQjla5h7VL+LhBAqTFnuMcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QELPiHU9; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QELPiHU9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782141857; x=1813677857;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=J9Pl+G5mDuRjkpjaRQc8OuA6gV59Zw5/BTNqkd09/aM=;
  b=QELPiHU97mDKb6y4EMG79n9I0P4Wu1bt2f0AsxN+fFp1bmU9CxphVVYb
   in6hRVc0aA4Df71bpUzTRtyWgBonGx2csRhCq3mHd5tpmmkCWEL27QI8r
   3tZgUTBm7qWtNYYhFH2c/johzHJ1OqlPI01efCbEadr0slGyc0OpGVjqC
   gZgCi/tLaWfEygigjLX+scQXyvF2AEa6QzFmBMBTk9X8Io8XSvrabPO86
   IEtfQoD0RtclFrTp0gtFTpFjND/O2q3FI6aofMeLWLjYrllnm59ZCGSgF
   Kr0YTZqGdDpcqoNTxJTFkaaghuDP/HK7QPb1BBQWhd+U5+M0fFjZVKuSC
   Q==;
X-CSE-ConnectionGUID: 51NwuOdbT+KTNkSxmX3l1A==
X-CSE-MsgGUID: eBfoSKj7QSi/8dtqmFWCNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="82882416"
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="82882416"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 08:24:17 -0700
X-CSE-ConnectionGUID: 5QCcA3hcQ5K59S9LZLvygQ==
X-CSE-MsgGUID: yFLXLtjeSYCHiFT1haE8dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="244898081"
Received: from spandruv-desk2.jf.intel.com ([10.88.27.176])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 08:24:16 -0700
Message-ID: <767892206bf6a10de4122f5e1faa8481541170ca.camel@linux.intel.com>
Subject: Re: [PATCH v1] iio: temperature: hid-sensor-temperature: switch to
 non-devm iio_device_register()
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>, jikos@kernel.org, 
	jic23@kernel.org
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	hongyan.song@intel.com, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Mon, 22 Jun 2026 08:24:16 -0700
In-Reply-To: <20260622052135.1804135-1-sanjayembedded@gmail.com>
References: <20260622052135.1804135-1-sanjayembedded@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-06-22 at 10:51 +0530, Sanjay Chitroda wrote:
> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
>=20
> Avoid using devm_iio_device_register(), as this driver requires
> explicit
> error handling and teardown ordering.
>=20
> Mixing devm_* APIs with goto-based error unwinding breaks the
> expected
> LIFO resource release model and can introduce race windows during
> device
> removal. In particular, the IIO device may remain visible to
> userspace
> while dependent resources are already being freed, potentially
> leading
> to use-after-free issues.

Please explain this use after free case here.

Thanks,
Srinivas

>=20
> Add explicit iio_device_unregister() call in the teardown path to
> ensure
> deterministic cleanup and follow kernel resource management
> conventions.
>=20
> Fixes: 59d0f2da3569 ("iio: hid: Add temperature sensor support")
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> ---
> =C2=A0drivers/iio/temperature/hid-sensor-temperature.c | 3 ++-
> =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/temperature/hid-sensor-temperature.c
> b/drivers/iio/temperature/hid-sensor-temperature.c
> index 9f628a8e5cfb..34bff7e9f3a3 100644
> --- a/drivers/iio/temperature/hid-sensor-temperature.c
> +++ b/drivers/iio/temperature/hid-sensor-temperature.c
> @@ -244,7 +244,7 @@ static int hid_temperature_probe(struct
> platform_device *pdev)
> =C2=A0	if (ret)
> =C2=A0		goto error_remove_trigger;
> =C2=A0
> -	ret =3D devm_iio_device_register(indio_dev->dev.parent,
> indio_dev);
> +	ret =3D iio_device_register(indio_dev);
> =C2=A0	if (ret)
> =C2=A0		goto error_remove_callback;
> =C2=A0
> @@ -264,6 +264,7 @@ static void hid_temperature_remove(struct
> platform_device *pdev)
> =C2=A0	struct iio_dev *indio_dev =3D platform_get_drvdata(pdev);
> =C2=A0	struct temperature_state *temp_st =3D iio_priv(indio_dev);
> =C2=A0
> +	iio_device_unregister(indio_dev);
> =C2=A0	sensor_hub_remove_callback(hsdev,
> HID_USAGE_SENSOR_TEMPERATURE);
> =C2=A0	hid_sensor_remove_trigger(indio_dev, &temp_st-
> >common_attributes);
> =C2=A0}
