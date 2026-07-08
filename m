Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D29714A60F;
	Wed,  8 Jul 2026 23:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783553144; cv=none; b=Phtl64v9e1RnuqdtSgOuax+zly1ZgTl9IRjR8dK43V/pjSyByE3MoQs5P86+5ZD7K3OTZCXrEEGs1gw3XIUUY7hbKlaesBltJGh+p2vfYRued6ABZPpbZClWihILciQrgvHmyCFUwTHI1QOXDiD4EzAQKgWJaegLpcsZqtqiKCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783553144; c=relaxed/simple;
	bh=GD4XzaO0EtPsctQZhaFZiQT0iaQUe3sQpV2krMpa+70=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ts5B+r+mkC1jv2CJ5As7escpCF+ANCau0vt6tIeQhD90PI6DuEy5eMgrvNEdhdk56lLnLdG+slw26uW2Zl8HaOG44+wR+TlGO0Ad0q1Wc4IfNY8MrTTbsuqyvKKS8rS1gM+qPPAJ+a26qW+KYwwp+h9TaFfgL8dXG/T63GylmsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PV0F+fXu; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PV0F+fXu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783553143; x=1815089143;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=GD4XzaO0EtPsctQZhaFZiQT0iaQUe3sQpV2krMpa+70=;
  b=PV0F+fXuMo6jOqUzxjKJG1fX0cb2/t1wuM7Pqo1kDJ7nEsjIL84BO8zo
   q+OoutCU9xsBtPgJ7Uv1vYrPIPToub104iZAfklEpyhgWyzE+l4m7uC7H
   Sn0KES0dpC0/rZmdRPzP4yoPTQdjIgPJwMPTn0DmLA/uP/jfpQ9y57rmv
   oY02jbzX45EJ9TDkb2rImEL9qEZ6SxzHyVvGmDYIL0uDaHWpp9NbzAr63
   WxFND22OKJVo34U4apwi3bdwFNbTrWdiFHJmTfMfgrrldBqq1DBDa4j69
   vtif0rirvDhhutsSq5bzTZn0Jxe3ivWa9kIi42niYp4EXaolTS/wtg7KP
   A==;
X-CSE-ConnectionGUID: 3w56OtmHR9ePbO0g0iK7Gg==
X-CSE-MsgGUID: xoNmEpHbTzuExboIwnCJug==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84422038"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84422038"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 16:25:42 -0700
X-CSE-ConnectionGUID: QH+lu+feSG6rrt9v2JXGeg==
X-CSE-MsgGUID: bvxscGJHQx+IIE3bGELbXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="252672142"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.111.110]) ([10.125.111.110])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 16:25:41 -0700
Message-ID: <086180fe0da41a5e8ce1b130483996a366f588ea.camel@linux.intel.com>
Subject: Re: [PATCH v2] iio: temperature: hid-sensor-temperature: switch to
 non-devm iio_device_register()
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>, jikos@kernel.org, 
	jic23@kernel.org
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	hongyan.song@intel.com, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Wed, 08 Jul 2026 16:25:41 -0700
In-Reply-To: <20260625121611.2003780-1-sanjayembedded@gmail.com>
References: <20260625121611.2003780-1-sanjayembedded@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-06-25 at 17:46 +0530, Sanjay Chitroda wrote:
> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
>=20
> Avoid using devm_iio_device_register(), as this driver requires
> explicit
> error handling and teardown ordering.
>=20
> With devm_iio_device_register(), IIO device remains registered until
> the
> devres cleanup phase. However, driver's remove() callback removes the
> sensor hub callback and trigger support. This can create a race
> window
> where IIO device is still visible and read_raw() requests are issued.
> These requests might call sensor_hub_input_attr_get_raw_value(),
> which
> waits up to 5 seconds for a response from the sensor hub callback
> that
> has already been removed.
>=20
> Add an explicit iio_device_unregister() call in the teardown path to
> ensure deterministic cleanup, so that userspace can no longer access
> the
> device once backend resources begin to be dismantled.
>=20
> Fixes: 59d0f2da3569 ("iio: hid: Add temperature sensor support")
> Cc: stable@vger.kernel.org
> Reviewed-by: Maxwell Doose <m32285159@gmail.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
>=20

Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
> Changes in v2:
> - Added review tags of Maxwell and Andy along with stable Cc
> - Based on input from Srinivas and investigation use-after-free
> =C2=A0 explanation was not sufficiently justified so updated the commit
> =C2=A0 message with appropriate information and kept Fixes tag
> - Link to v1:
> https://lore.kernel.org/all/20260622052135.1804135-1-sanjayembedded@gmail=
.com
> ---
> =C2=A0drivers/iio/temperature/hid-sensor-temperature.c | 3 ++-
> =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/temperature/hid-sensor-temperature.c
> b/drivers/iio/temperature/hid-sensor-temperature.c
> index a8d3a15f9c53..ab6ec8f659b8 100644
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
