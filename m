Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C5339D3DB;
	Fri, 22 May 2026 16:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779468718; cv=none; b=DhXr7pSIu48uY9Scf/IQ/arMiHMuljkGFdFEWMM4TSAqa/kdWVxiikLe+kBlEPPxhRPVkgTfi6etWPEkMXu8YV98T39D7I2rvyeswyS0A1zQQnKDXL5Y36on11JHh+YZnWnQHFgzor5tazdYzm187mO6yzIXoV2PxD4k4yhsl30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779468718; c=relaxed/simple;
	bh=rrN2UHU6sukW9A0E2XevrQ4xo+GgE44TQdkR8W0di4A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gBeG6FyLt/kkT+SW80B+gJxLermkq8GHm9xMcq2u/MoQM0s7a66HMUMY7ALqHm7b+fHsPs/+JUe4jDZ21mOhoHmRa1iN/sRk3a+o1SUTed1Qfoc/wk0If4Rwy75DON+7f+rkk8j1MEvQJGR6pV1EAfNuWKW/ewhMYNB4sPRKUg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OyiDPMi8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OyiDPMi8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6226A1F000E9;
	Fri, 22 May 2026 16:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779468715;
	bh=jg9R/ay5s9y4zVRrIR0bo6yD4CO+1XyodWSgNdNcHPw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OyiDPMi8Pxa7LuD4ECeyEsGMtxCsFfWCuzndpKLtqWf1f4SaYbe/duJnxK3+CrWW1
	 GIpglUlPcVxVlfdnlSMMqqoUKJReACO9DvDNSLLFoIZ3UssXNpwH4heC9MOhDyTsAR
	 LbYMVpRPt1ThoPWj92pNrBljUH3brtmrMDgeNqm894RxEBHjw7ntjKF2tQyywKUUKP
	 JW7O1Dxh1L3V1F0OZnQzXCpdxs2VuUse3qKFYm/iYOAGkI1S0Z0VDzQJpmJAIsmC/o
	 PJAXhW/PihktKGlg+a0mOan9ffgWvNKtaitDp3Pxj5PPYZZTZu4WGjQKAZs8oj9RKh
	 8apMYTdvISYcg==
Date: Fri, 22 May 2026 17:51:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?TmF0w6FsaWE=?= Salvino =?UTF-8?B?QW5kcsOp?=
 <natalia.andre@ime.usp.br>
Cc: andy@kernel.org, dlechner@baylibre.com, jikos@kernel.org,
 nuno.sa@analog.com, srinivas.pandruvada@linux.intel.com,
 linux-iio@vger.kernel.org, linux-input@vger.kernel.org, "Zhang, Lixu"
 <lixu.zhang@intel.com>
Subject: Re: [PATCH v4 0/6] iio: hid-sensor: standardize scan_type
 initialization
Message-ID: <20260522175147.78e0e7bc@jic23-huawei>
In-Reply-To: <20260519234752.23911-1-natalia.andre@ime.usp.br>
References: <20260519234752.23911-1-natalia.andre@ime.usp.br>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 19 May 2026 20:40:42 -0300
Nat=C3=A1lia Salvino Andr=C3=A9 <natalia.andre@ime.usp.br> wrote:

> This series refactors the HID sensor drivers to standardize the
> initialization of the iio_chan_spec scan_type structure using compound
> literals.
>=20
> This change improves code readability and ensures that all fields of
> the scan_type structure are properly zero-initialized, allowing the
> removal of local helper functions.
>=20
> Additionally, the channel initialization loops for hid-sensor-accel-3d
> and hid-sensor-gyro-3d were cleaned up to iterate directly over the
> scan indices, eliminating redundant index-offset logic.

+CC Lixu=20

Please make sure to add to your +CC anyone who has been involve in earlier
versions of the series.

I'm going to queue this now to get some build coverage. Still fine
to add tags though or indeed drop it if any problems.

Applied to the testing branch of iio.git

thanks,

Jonathan

>=20
> ---
>=20
> Changes in v4:
>=20
> - Fixed a bug in the sensor_hub_input_get_attribute_info()
> call where passing the raw loop index 'ch' broke the HID report
> field lookup in hid-sensor-accel-3d. Restored the proper HID
> usage ID offset calculation using HID_USAGE_SENSOR_ACCEL_X_AXIS + ch
> - Cleaned up the channel initialization loop to iterate
> directly over the scan indices in hid-sensor-gyro-3d for consistency
>=20
> Changes in v3:
>=20
> - Dropped the global helper function implementation from
> hid-sensor-attributes.c following maintainer feedback.
> - Shifted to local refactoring inside the drivers using compound
> literals and the  macros BYTES_TO_BITS() and BITS_PER_TYPE()
> - Refactored the channel initialization loop in hid-sensor-accel-3d to
> iterate directly over the scan enums instead of using 0-based
> index offsets
> - v3 link: https://lore.kernel.org/linux-iio/89a2e6775e3c922a4848a4b4730a=
ab8d32097454.camel@linux.intel.com/T/#t
>=20
> Changes in v2:
>=20
> - Modified the helper function to use the BITS_PER_BYTE macro instead of
> magic numbers for bit calculations
> - Updated the scan_type structure field assignment from '.sign'
> to '.format' based on recent subsystem renaming feedback
>=20
> Nat=C3=A1lia Salvino Andr=C3=A9 (6):
>   iio: accel: HID: hid-sensor-accel-3d: Refactor channel initialization
>   iio: gyro: HID: hid-sensor-gyro-3d: Refactor channel initialization
>   iio: light: HID: hid-sensor-als: Refactor channel initialization
>   iio: light: HID: hid-sensor-prox: Refactor channel initialization
>   iio: magnetometer: HID: hid-sensor-magn-3d: Refactor channel
>     initialization
>   iio: pressure: HID: hid-sensor-press: Refactor channel initialization
>=20
>  drivers/iio/accel/hid-sensor-accel-3d.c       | 27 +++++++------------
>  drivers/iio/gyro/hid-sensor-gyro-3d.c         | 27 +++++++------------
>  drivers/iio/light/hid-sensor-als.c            | 18 +++++--------
>  drivers/iio/light/hid-sensor-prox.c           | 19 +++++--------
>  drivers/iio/magnetometer/hid-sensor-magn-3d.c | 20 +++++---------
>  drivers/iio/pressure/hid-sensor-press.c       | 19 +++++--------
>  6 files changed, 42 insertions(+), 88 deletions(-)
>=20

