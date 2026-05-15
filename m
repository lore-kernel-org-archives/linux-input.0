Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858343FF1D0;
	Fri, 15 May 2026 16:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778863813; cv=none; b=Y6heUxmct2mpbSUo64aOZaBS0LN8q+cgyN7yOwOhbvNqDQhNZrwTS9GcwYsC9FCTb84nHcTPLf/z86Gz4Tuto8eSnLjAZFraim8wp5pdhBvd79BAzoeCXtJaaP85+S8bnHghudya+lKSK2v/wy2uX+zKOzOzUbdHTIrueWaQkiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778863813; c=relaxed/simple;
	bh=re59vnZFhdoEQXf2m3B84AsYDcXz1J9WxGmvXj/cRw0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i2jliII8xynnwWTfVOFMAPKuI5K+05WsgF2h1nYSkLkZUgj7JwDN4FFGpa+DnPBmEQtYqkMnMj/sGLVWOL9M2NzO53vh0OUt/UHHV1+hJwn9zvgw2BtDcMg1D8ho2z5e4R5Cglmm857caUiPxH09duVp9GskDzeQNYvpB+FF+yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CH59jszX; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CH59jszX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778863813; x=1810399813;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=re59vnZFhdoEQXf2m3B84AsYDcXz1J9WxGmvXj/cRw0=;
  b=CH59jszXN6XUzNYUeOpEV6LDcAdnNXez1h5dCkpx3VtiHeiU75VTsiKH
   P5vFqEE/CuULL0qoX8kTL/maNG8gs9BJwlbP8gEytZnjw+ZZJ961yQ3cH
   7dRP1bSHLiraIjAsVhOnjBMQfb7sAzWXJrwO2s25L3QY5t7IkTbO+/Jo6
   03rE94izKxvnOolG0JB1vYmXzyrCo6bHBE8LwcnWkUHVVbXm0BsRq5H67
   LFYl7QqmFt/YMH3ylPh1QI4ThwOU9JUGGdQSvBUIorrNoLWwc96CjqdKw
   eXJOGTToCFplxy11UASFzVVRpg0vN5+DvOHhXrSuW5MC4I4ODMLEdl4DY
   g==;
X-CSE-ConnectionGUID: RS5FzknFRwCvqLkKZlsGJQ==
X-CSE-MsgGUID: juXP1DL8TBevZ0GUqtjNRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11787"; a="83680217"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="83680217"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 09:50:12 -0700
X-CSE-ConnectionGUID: O3iQa+PgSaKDTRm5gwXPhA==
X-CSE-MsgGUID: OmfrDsnySiqab1NEF8JRJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="243714389"
Received: from spandruv-desk2.jf.intel.com ([10.88.27.176])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 09:50:12 -0700
Message-ID: <89a2e6775e3c922a4848a4b4730aab8d32097454.camel@linux.intel.com>
Subject: Re: [PATCH v3 0/6] iio: hid-sensor: standardize scan_type
 initialization
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: =?ISO-8859-1?Q?Nat=E1lia?= Salvino =?ISO-8859-1?Q?Andr=E9?=
	 <natalia.andre@ime.usp.br>, andy@kernel.org, dlechner@baylibre.com, 
	jic23@kernel.org, jikos@kernel.org, nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, linux-input@vger.kernel.org
Date: Fri, 15 May 2026 09:50:11 -0700
In-Reply-To: <20260512012302.20883-1-natalia.andre@ime.usp.br>
References: <20260512012302.20883-1-natalia.andre@ime.usp.br>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-05-11 at 22:16 -0300, Nat=C3=A1lia Salvino Andr=C3=A9 wrote:
> This series refactors the HID sensor drivers to standardize the
> initialization of the iio_chan_spec scan_type structure.
> Direct initialization using compound literals was used.
>=20
> This change improves code readability and ensures that all fields
> of the scan_type structure are properly zero-initialized.
> Additionally, for the hid-sensor-accel-3d driver, the channel
> initialization loop was refactored to iterate directly over the
> scan indices, eliminating redundant logic.
>=20
From manual check the change looks good, with some minor comment.

Thanks,
Srinivas


> Nat=C3=A1lia Salvino Andr=C3=A9 (6):
> =C2=A0 iio: accel: HID: hid-sensor-accel-3d: Refactor channel
> initialization
> =C2=A0 iio: gyro: HID: hid-sensor-gyro-3d: Refactor channel initializatio=
n
> =C2=A0 iio: light: HID: hid-sensor-als: Refactor channel initialization
> =C2=A0 iio: light: HID: hid-sensor-prox: Refactor channel initialization
> =C2=A0 iio: magnetometer: HID: hid-sensor-magn-3d: Refactor channel
> =C2=A0=C2=A0=C2=A0 initialization
> =C2=A0 iio: pressure: HID: hid-sensor-press: Refactor channel
> initialization
>=20
> =C2=A0drivers/iio/accel/hid-sensor-accel-3d.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 27 +++++++----------
> --
> =C2=A0drivers/iio/gyro/hid-sensor-gyro-3d.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 24 +++++++----------
> =C2=A0drivers/iio/light/hid-sensor-als.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 18 +++++--------
> =C2=A0drivers/iio/light/hid-sensor-prox.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 19 +++++--------
> =C2=A0drivers/iio/magnetometer/hid-sensor-magn-3d.c | 20 +++++---------
> =C2=A0drivers/iio/pressure/hid-sensor-press.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 19 +++++--------
> =C2=A06 files changed, 42 insertions(+), 85 deletions(-)
