Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22C03B810F;
	Tue, 12 May 2026 12:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778590070; cv=none; b=oYmgZNIgf37qEUXYfSwxf+v0RLBNc9I8E1UUrpURW/b15PLvPsacafvHs3I8VNzjAJV68U+04oWMWh0S9sYx2131UNTyTuMLI/uatXAiXuLdihN/4mwSkRql/Gk8BgUNcwN+fPnXTdqU7suUl1l4MU4ndgEn12PCXDIHgmr9tZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778590070; c=relaxed/simple;
	bh=Ifa4FhEr9hyLSDpaK4Svtu4qRAR/KKgfl9vZSlAFxK8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dH+8ZEI0cDaVsXntZnh+EO3Ubie89pyR1kh/Onkxwh0hpHZ7F7vgn8xVTyX8/ovNextipQR3BRFAikjAOoe8iNsmubBVwokfChsFaGwJbIzwRUgtPodJNuL5mbVJ4nqUKzTBAZYBvv/OCzSvJOIvb6ZkPT+8TzfUHr5aV98X2x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SIix/3cP; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SIix/3cP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778590067; x=1810126067;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Ifa4FhEr9hyLSDpaK4Svtu4qRAR/KKgfl9vZSlAFxK8=;
  b=SIix/3cP8ueZ6qpbna6eOJMJr+ULEau0+lnxmCrDmmMhe7DQIkHur5Xq
   1770k2a2FyvVE886Can8Vc5Shu/xJ8s2BkQe8x3WVtidtRTMO19ewYSI4
   3OA9rd1kHdSiYHn+GYBge4d2o9EQkiiB1JEdK9CyhJdY0h+kQH+Bl4nfz
   KrEG/OUQVxOTZuD1YKjafVBcybmcoMLqop4bB3UBsluOIzz0UPD27rPnw
   kgTHkTdqszVuZ0AFg3RhFjaIDu7pdu68nhygkmH04Hf4f3LYklHz1j5C5
   UQgSoYXLj+B3g055tDc3Mjr0KhNG1MhXg3N5wOIUCCGR87Yd3feXFta38
   w==;
X-CSE-ConnectionGUID: T1EbEGxUQBSd1CUsx4TEvw==
X-CSE-MsgGUID: tcBqtPwYRyqhfseITWNaDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="90194175"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="90194175"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 05:47:44 -0700
X-CSE-ConnectionGUID: m4tYYA6GRAmItFt2yuYYcQ==
X-CSE-MsgGUID: dYyJVgOrQaqeK0wFH2Wu+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="236775583"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.111.218]) ([10.125.111.218])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 05:47:44 -0700
Message-ID: <cff35f30206aba501cb70af4b10006b45a2a50c7.camel@linux.intel.com>
Subject: Re: [PATCH v3 3/9] iio: hid-sensors: introduce device managed API
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>, jikos@kernel.org, 
	jic23@kernel.org, "Zhang, Lixu" <lixu.zhang@intel.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	sakari.ailus@linux.intel.com, linux-input@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 12 May 2026 05:47:42 -0700
In-Reply-To: <20260509101040.791404-4-sanjayembedded@gmail.com>
References: <20260509101040.791404-1-sanjayembedded@gmail.com>
	 <20260509101040.791404-4-sanjayembedded@gmail.com>
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
> hid_sensor_setup_trigger() is common API used for the HID IIO
> drivers,
> prepare devm API devm_hid_sensor_setup_trigger() to acquire resource
> during setup and release using device managed framework during
> drivers
> fail, unbind or remove path.
>=20
> Register action with devm_add_action_or_reset() to release resource
> with
> devres framework.
>=20
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Looks good but we have to test by unbinding ISH PCI device.

Thanks,
Srinivas

> ---
> Changes in v3:
> - Remove cast and update function based on review comment from Andy
> - v2 link ->
> https://lore.kernel.org/all/20260429175918.2541914-3-sanjayembedded@gmail=
.com/
> ---
> =C2=A0.../common/hid-sensors/hid-sensor-trigger.c=C2=A0=C2=A0=C2=A0 | 18
> ++++++++++++++++++
> =C2=A0.../common/hid-sensors/hid-sensor-trigger.h=C2=A0=C2=A0=C2=A0 |=C2=
=A0 2 ++
> =C2=A02 files changed, 20 insertions(+)
>=20
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> index 98fadc61a68a..fb6a4587ae03 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> @@ -301,6 +301,24 @@ int hid_sensor_setup_trigger(struct iio_dev
> *indio_dev, const char *name,
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_NS(hid_sensor_setup_trigger, "IIO_HID");
> =C2=A0
> +static void hid_sensor_remove_trigger_action(void *attrb)
> +{
> +	hid_sensor_remove_trigger(attrb);
> +}
> +
> +int devm_hid_sensor_setup_trigger(struct device *dev, struct iio_dev
> *indio_dev,
> +				=C2=A0 const char *name, struct
> hid_sensor_common *attrb)
> +{
> +	int ret;
> +
> +	ret =3D hid_sensor_setup_trigger(indio_dev, name, attrb);
> +	if (ret)
> +		return ret;
> +
> +	return devm_add_action_or_reset(dev,
> hid_sensor_remove_trigger_action, attrb);
> +}
> +EXPORT_SYMBOL_NS(devm_hid_sensor_setup_trigger, "IIO_HID");
> +
> =C2=A0static int __maybe_unused hid_sensor_suspend(struct device *dev)
> =C2=A0{
> =C2=A0	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.h
> b/drivers/iio/common/hid-sensors/hid-sensor-trigger.h
> index afec46ecbe71..6fd7c39a240d 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.h
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.h
> @@ -17,6 +17,8 @@ extern const struct dev_pm_ops hid_sensor_pm_ops;
> =C2=A0int hid_sensor_setup_trigger(struct iio_dev *indio_dev, const char
> *name,
> =C2=A0				struct hid_sensor_common *attrb);
> =C2=A0void hid_sensor_remove_trigger(struct hid_sensor_common *attrb);
> +int devm_hid_sensor_setup_trigger(struct device *dev, struct iio_dev
> *indio_dev,
> +				=C2=A0 const char *name, struct
> hid_sensor_common *attrb);
> =C2=A0int hid_sensor_power_state(struct hid_sensor_common *st, bool
> state);
> =C2=A0
> =C2=A0#endif
