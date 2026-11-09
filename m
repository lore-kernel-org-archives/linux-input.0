Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794185250;
	b=BcNDEV61sytZSDpuXNX9TV6jwhSUTD4J3oARiz3/y0jNMAmHxCpzIcmstrf646BtqgXO
	 gv0lFrLRY0gfxlcuetRjHhSpl1sSemg3NdUkGUVxRrtvmGex0nyFYMu9AylQ8ZtRroYs/
	 daHC5m29E3+eimWRvmYgwCKCo+Mbn1R4Yn8T1qlIkyHyusf5doKsZ4ot6OE4p5tE9G0iW
	 PofYKaAQtr3mXk8ZlUXdt6z7pNc9zBlWG838DNync9pOQkoeFAnYbMoinbG2u2OdaD/O0
	 etMXVqxTn89I57aqE8Gmo+ZfIqcuaUfBeG7IXoB2ucuPjSXWMI9SxQGnQXlJpcfM4xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794185250;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=TN4OnWdI7EsV7/wNiHyf3x6f9m0nwMthB86eoS3unrw=;
	b=iZfwLeg7QluuqOLpp1BQBgx4xAkmiOcRZQ+ztOqVIZiIbCRL7jWtSAdGCjuAmjg9gXDO
	 Bfz1taTccgGRgGTlCuzREtCJrOgQIdHd7nzzmBarRjeJma9j0NWbopb+/iY6kA9/f9jlw
	 vaGhy5S4Kj4KWZXkKYAGYISLC4/xbqaWVhhQhpy98VdRniF8+mapWeC8cstFsU8I71Bvr
	 DZ3nv31cbJszG6qUmPDBDb2hQYTIt5JcawYqzeyWjFPvXW2r4gggVHunb1s3Z31W8/RjU
	 337arQ3e5N0MCg0HmNXzn7gkBi1CaIVN59nSpPDnuCoK9OUbjf0oD6jYWpaEaKxi08g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XCs8VKrK;
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC9A606A320;
	Mon,  9 Nov 2026 00:47:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFC9A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XCs8VKrK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794185249; x=1825721249;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=mTzXtCSlzZ1PsCmCfZrmhVh5AnI/2A8x2G8S6bg4cZs=;
  b=XCs8VKrKgfFVVQwWf32/MlM5a6mlUkeGWo7BJlA/YmiqX4IbQJxnCY8s
   0wHvUozMdL53rKKK9I6M6susupMre5a9H0UzwPyhuCe8070zHEeC59wy+
   caPzYRVbzVxb/dAuGC4JfxTi9w9XVwPLbufEjpbczCMG6VUegssVOLNnY
   JnDlbncdmrCnmDaeyhTg1HQFevBcumYWGC/k2+ovQpOfVJbezRW6anuV+
   XGrthS0DimfUJAc9RIoWq0kOfRL28HNytwyEJwN7M8EFA4YlmhWNqnm3c
   WlXT+QR0ogHuGqmj3Q496hGOz7rt4qsqG5h4X/0HacH0zzZ3BIApvEflc
   w==;
X-CSE-ConnectionGUID: ZD0r5zOAQkSfzPE3apQ5iw==
X-CSE-MsgGUID: z1FzX6nwR8e3p/aFFst1xQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2789273"
X-IronPort-AV: E=Sophos;i="6.27,202,1787036400"; 
   d="scan'208";a="2789273"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2026 16:47:29 -0800
X-CSE-ConnectionGUID: j9o2byqpTNGJFe6A+Auimw==
X-CSE-MsgGUID: Vg/aNMKpTVeBP/vi9y1bmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,202,1787036400"; 
   d="scan'208";a="9519236"
Received: from spandruv-mobl5.amr.corp.intel.com (HELO [10.124.220.168]) ([10.124.220.168])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2026 16:47:28 -0800
Message-ID: <b83129fac311b72376cb6fcef5448d3b66c3b45b.camel@linux.intel.com>
Subject: Re: [PATCH v2 6/7] HID: sensor: custom: Register enable attribute
 after misc device
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: jikos@kernel.org, bentiss@kernel.org, linux-input@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 simeon@maryasin.name, 	lixu.zhang@intel.com, crofts@kernel.org
Date: Sun, 08 Nov 2026 16:47:27 -0800
In-Reply-To: <20261107201601.7d5aa69f@jic23-hlaptop>
References: <20261104201403.2039921-1-srinivas.pandruvada@linux.intel.com>
		<20261104201403.2039921-7-srinivas.pandruvada@linux.intel.com>
	 <20261107201601.7d5aa69f@jic23-hlaptop>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Sat, 2026-11-07 at 20:16 +0000, Jonathan Cameron wrote:
> On Wed,=C2=A0 4 Nov 2026 12:14:02 -0800
> Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:
>=20
> > Register the enable_sensor sysfs group only after misc-device setup
> > succeeds. This prevents userspace from opening the sensor hub while
> > probe can still fail, which would otherwise leave the hub open
> > reference
> > unbalanced on unwind.
> >=20
> > Fixes: 4a7de0519df5 ("HID: sensor: Custom and Generic sensor
> > support")
> > Reported-by: =D0=A1=D0=B5=D0=BC=D1=91=D0=BD =D0=9C=D0=B0=D1=80=D1=8C=D1=
=8F=D1=81=D0=B8=D0=BD <simeon@maryasin.name>
> > Closes:
> > https://lore.kernel.org/all/CAM2dg7ewfVJSP4rFyhkCB1Rmd1+X56sAg=3DeUdbPt=
hG2xrLqwQQ@mail.gmail.com/
> > Signed-off-by: Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com>
> You probably already saw it, but sashiko had more feedback.
> https://sashiko.dev/#/patchset/20261104201403.2039921-1-srinivas.pandruva=
da%40linux.intel.com
>=20
> I haven't looked closely at it though so might be either wrong
> or material for a future patch.
>=20
> One rather odd looking thing in here though.
>=20
>=20
> > ---
> > =C2=A0drivers/hid/hid-sensor-custom.c | 15 ++++++++-------
> > =C2=A01 file changed, 8 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-
> > sensor-custom.c
> > index 4f824cadd370..990e653995e1 100644
> > --- a/drivers/hid/hid-sensor-custom.c
> > +++ b/drivers/hid/hid-sensor-custom.c
> > @@ -1059,20 +1059,21 @@ static int hid_sensor_custom_probe(struct
> > platform_device *pdev)
> > =C2=A0	if (ret)
> > =C2=A0		goto err_remove_callback;
> > =C2=A0
> > -	ret =3D sysfs_create_group(&sensor_inst->pdev->dev.kobj,
> > -				 &enable_sensor_attr_group);
> > +	ret =3D hid_sensor_custom_dev_if_add(sensor_inst);
> > =C2=A0	if (ret)
> > =C2=A0		goto err_remove_attributes;
> > =C2=A0
> > -	ret =3D hid_sensor_custom_dev_if_add(sensor_inst);
> > +	ret =3D sysfs_create_group(&sensor_inst->pdev->dev.kobj,
> > +				 &enable_sensor_attr_group);
> > =C2=A0	if (ret)
> > -		goto err_remove_group;
> > +		goto err_remove_dev_if;
> > =C2=A0
> > =C2=A0	return 0;
> > =C2=A0
> > -err_remove_group:
> > -	sysfs_remove_group(&sensor_inst->pdev->dev.kobj,
> > -			=C2=A0=C2=A0 &enable_sensor_attr_group);
> > +err_remove_dev_if:
> > +	sensor_hub_remove_callback(hsdev, hsdev->usage);
> > +	hid_sensor_custom_dev_if_remove(sensor_inst);
> > +	goto err_remove_attributes;
>=20
> If my eyes are tricking me, isn't this going to the next line?

I realized that. Will fix this in next update.

Thanks,
Srinivas

>=20
> > =C2=A0err_remove_attributes:
> > =C2=A0	hid_sensor_custom_remove_attributes(sensor_inst);
> > =C2=A0err_remove_callback:
