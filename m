Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBF737DADF;
	Tue, 12 May 2026 12:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778589580; cv=none; b=uljSq/bYuiAQakiLTKgSb2oQrZqNkDYjtzUWY0eXe3cVRGnYnJHjqXdIHm/nevxEoeLB54DKexkuQmhrAuhilxWlsM4izgZHbNgU+LgaWJtx9cCVxa8R8ERIkThGV4S0dPAoQZxSY5A7hXC8/TESxeao1kWWlGLbP5jtASAF0jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778589580; c=relaxed/simple;
	bh=04sY2tHchrSKRsoEFOHsFW9xROhO5HAH3Nb5i3wcoA0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=etVVCcODP72iwdhnVHHk9W3k1zZPYUNTqEbX5SLuaFstYxdtwwxCLLiGiWoK39DT0TgFdOf2yxRPVAgE0FvjVevh7SE5/7D6AaAy6NLgR8WGXU4gbANFi4JiL16xgjfkOSW82EYH3Pg8XV4WCFwJmdzfLNoRcQZ2TSxumgE0xAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TktNMgEy; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TktNMgEy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778589577; x=1810125577;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=04sY2tHchrSKRsoEFOHsFW9xROhO5HAH3Nb5i3wcoA0=;
  b=TktNMgEyoCqzom1lzLkZHrRLQaBgLWBHzFr5QgkZYql3JZuMPmAxHQe9
   GZSEarzQvekGDz4AFmJHZwxCVc2fgGVEcJOWpl0014RwWRfWqi+Hk8gjU
   osE12dMBq0h3oJF7pHrRg1XcD1Ta29I0emzKDOc4M8r7Kj3VJZ8QlW7L6
   vQAiPW/BHoSQ6OXluUmHXow4nsWppXdLBnJynSCteA+mYC6I1nyZTKiXO
   wqKn9CQ3TkI+1AQ/2PWGJt6qp8YL3CTA5mRkJ6UbYvEI/mbYSNChvJIuf
   ZGhhToZ7NJDji1u/KXeJQ4b4i8cIfy1zrDnuOdCHmvkbUwDPq19PmH2HZ
   A==;
X-CSE-ConnectionGUID: COyR8dcDQsajwJCFbv6YDg==
X-CSE-MsgGUID: S51z4Xn0T9qCG30k+SxoPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="96920436"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="96920436"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 05:39:31 -0700
X-CSE-ConnectionGUID: 8zWfj0BdSLuiOhq9dEemhg==
X-CSE-MsgGUID: 3FmTHLdVSZ+e7830PI/v4g==
X-ExtLoop1: 1
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.111.218]) ([10.125.111.218])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 05:39:29 -0700
Message-ID: <5e1c5ec3b02bedef5e94f7482f83034389d1ee9b.camel@linux.intel.com>
Subject: Re: [PATCH v3 2/9] iio: hid-sensors: cleanup codestyle warning
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>, jikos@kernel.org, 
	jic23@kernel.org
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	sakari.ailus@linux.intel.com, linux-input@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 12 May 2026 05:39:27 -0700
In-Reply-To: <20260509101040.791404-3-sanjayembedded@gmail.com>
References: <20260509101040.791404-1-sanjayembedded@gmail.com>
	 <20260509101040.791404-3-sanjayembedded@gmail.com>
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
> Reported by checkpatch:
> FILE: drivers/iio/common/hid-sensors/hid-sensor-trigger.c
>=20
> WARNING: Missing a blank line after declarations
>=20
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
> =C2=A0drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 3 +++
> =C2=A01 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> index 28d050b45c74..98fadc61a68a 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> @@ -313,7 +313,9 @@ static int __maybe_unused
> hid_sensor_resume(struct device *dev)
> =C2=A0{
> =C2=A0	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> =C2=A0	struct hid_sensor_common *attrb =3D
> iio_device_get_drvdata(indio_dev);
> +
> =C2=A0	schedule_work(&attrb->work);
> +
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> @@ -321,6 +323,7 @@ static int __maybe_unused
> hid_sensor_runtime_resume(struct device *dev)
> =C2=A0{
> =C2=A0	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> =C2=A0	struct hid_sensor_common *attrb =3D
> iio_device_get_drvdata(indio_dev);
> +
> =C2=A0	return _hid_sensor_power_state(attrb, true);
> =C2=A0}
> =C2=A0
