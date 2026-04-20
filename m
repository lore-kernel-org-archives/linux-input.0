Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B644336EDE;
	Mon, 20 Apr 2026 15:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700021; cv=none; b=a/0xlD07mJjcKqBLAnSDEHHco3oqNbYPwL92AcHjt7CXZLQ4YxyB1nM1elVQU77Fd8gIgWPMTd2DoE5ZvXhrykoL4tDm3b6VIV06p+8alaMi6Al7FDP38Fi8eWW0TQTEnePFDT9EUAa17mmMT6Nb1bgRVIUpz9BKzrEE1fqzUkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700021; c=relaxed/simple;
	bh=bCFGoy6GJb8PIwthC7OdYJyBAq60nRhPe+qaDATSwFk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xcomyt7+m+hco4+G1iHAgSxfGLyck+VIOYICd1n+VBE/QJbUxQXkZl7K1/E7TFll2a+kwq4R/BdtXGLKIR1VjA6YuPm42mQdFSy2TJ/vfxUNBu2fA3oWFxk7an66RyDmiR7jHrNJYVXNK7bBNyAdImkRS+q+hfQIKg7lKSm85Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iYeVChk1; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iYeVChk1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776700019; x=1808236019;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=bCFGoy6GJb8PIwthC7OdYJyBAq60nRhPe+qaDATSwFk=;
  b=iYeVChk1ULvWY+U+jOpWCSnMBS4x9qVLtyGWHn2w+q2sNU5qjkmNGE9B
   40ANgzm6ubkp4XntwVPH0wqnLFafwl6U0TuH8aqyQF6r7y9evlG+yJ4MW
   FOgjc+D+6s6Hbp7ZkTL30jxyCt0Q6Dy6FqhMGjY2Cno37g02VtXuvj0A9
   SAUdhobfoxOSVqaElJbQ5OWd0fz5Q245qKj96WuyP63Upnec6SUBv71JZ
   /7Sdu/JbMX0Yy1iqu/lRdRd36LSHC7FAz2XKQnzRwVjSzDNM9P4W0jb+6
   UeB1KwvHuW9zG67e53iX2YS4kXdQ+u6XcxczR1PLXc48PiMhkwqEeOtXn
   Q==;
X-CSE-ConnectionGUID: 1dDIfRRTSgKfXu57tcUYlA==
X-CSE-MsgGUID: 367OuAzeSfiD3P4S8g4GQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="89085936"
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="89085936"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 08:46:58 -0700
X-CSE-ConnectionGUID: 996/crf4QAGiUxz+TEAEdw==
X-CSE-MsgGUID: Y6nNX2DKSHicbfhY1jwAeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="233516197"
Received: from spandruv-desk2.jf.intel.com ([10.88.27.176])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 08:46:58 -0700
Message-ID: <4e84f9cc258676ed038e1f932137f10f34064aca.camel@linux.intel.com>
Subject: Re: [PATCH v2] iio: magnetometer: hid-sensor-magn-3d: prefer
 'unsigned int'
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>, jikos@kernel.org, 
	jic23@kernel.org
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 20 Apr 2026 08:46:57 -0700
In-Reply-To: <20260419180523.37396-1-joshua.crofts1@gmail.com>
References: <20260419180523.37396-1-joshua.crofts1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-04-19 at 20:05 +0200, Joshua Crofts wrote:
> Use 'u32' instead of bare 'unsigned' to resolve checkpatch.pl
> warnings
> and correct type use as defined in the hid_sensor_hub_callbacks
> struct.
>=20
> No functional change.
>=20
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>

Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
> v2:
> =C2=A0- changed 'unsigned int' to 'u32' per struct definition
>=20
> =C2=A0drivers/iio/magnetometer/hid-sensor-magn-3d.c | 6 +++---
> =C2=A01 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> index c673f9323e..b01dd53eb1 100644
> --- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> +++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> @@ -280,7 +280,7 @@ static const struct iio_info magn_3d_info =3D {
> =C2=A0
> =C2=A0/* Callback handler to send event after all samples are received an=
d
> captured */
> =C2=A0static int magn_3d_proc_event(struct hid_sensor_hub_device *hsdev,
> -				unsigned usage_id,
> +				u32 usage_id,
> =C2=A0				void *priv)
> =C2=A0{
> =C2=A0	struct iio_dev *indio_dev =3D platform_get_drvdata(priv);
> @@ -302,7 +302,7 @@ static int magn_3d_proc_event(struct
> hid_sensor_hub_device *hsdev,
> =C2=A0
> =C2=A0/* Capture samples in local storage */
> =C2=A0static int magn_3d_capture_sample(struct hid_sensor_hub_device
> *hsdev,
> -				unsigned usage_id,
> +				u32 usage_id,
> =C2=A0				size_t raw_len, char *raw_data,
> =C2=A0				void *priv)
> =C2=A0{
> @@ -350,7 +350,7 @@ static int magn_3d_parse_report(struct
> platform_device *pdev,
> =C2=A0				struct hid_sensor_hub_device *hsdev,
> =C2=A0				struct iio_chan_spec **channels,
> =C2=A0				int *chan_count,
> -				unsigned usage_id,
> +				u32 usage_id,
> =C2=A0				struct magn_3d_state *st)
> =C2=A0{
> =C2=A0	int i;
