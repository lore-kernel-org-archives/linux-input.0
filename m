Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793816802;
	b=w1YRy6rk0jgNYHGK/0XA8VAtj9WkMhtj+yxxcV70S+uiWAUU4RsYU7aEPC63V4oP1WqO
	 JnB66KowovrTTQlHZ732ctbwDuJd8RP46prXEcbE6SsCgigHOXLJiOfGaTAcD1A7Z3hpU
	 ET4aHmXQ/MFEz54Ra2Gj5Z5R10WT1cCmW6rS1o6pVoWfKcwafw55asSJ3Kp8+dGDQ6c2A
	 vw/P7ZGTWYUBsWkeNSslNqG9+YH55Wki06z+42iB6JTCRF0P4QjKLKi9j+TAO1AExc6uV
	 R9Tp+jd8PZlPD+Fq3gvRY58d3HFkaxYhwiVaYTcKA21GYsWBqn163qDZOkAy1LcIyUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816802;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=i42+FjVy81Q3i/3Gkwb7uFdD3TiDt3p++vkqYrQPSPo=;
	b=wsLnFlsMQAfMb0+TQXGIp3qPR2ZBOlI61Rp6fb5AKjBoxwAqnEkB2g+Zdv9P8gSgyQkI
	 7pxgF8GqLEL7Aoon7edNG6mVdh/PiKDdryQ/z5d2/rXFW1+wMRS3JQnZZJ/9g7uS7b1Kg
	 P8SZhj14xrEf5bLSvgsMoBB4SdJzXIEysbaa4XIWJsI/9LSAvH38kr7LuMmkWH8WDgOZR
	 uquqKcf7w72PdKg5tAv9o9aJpYx0Ofz44jV7pTq3XWBEYLKX2tUlI/5/r0cym9cglttfQ
	 W1X2XrJG7BednXKconHE181J7mlual5nUWzeH9ZoX4q1FgkENwh/EIn84VuJWfhcNgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DU9CwSWH;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094CC606C446
	for <linux-input@vger.kernel.org>; Wed,  4 Nov 2026 18:26:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 094CC606C446
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DU9CwSWH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793816802; x=1825352802;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=d0J1PPY6ueUxIGFVdbXdo3r5xndEiKfYJFLUnMDADf0=;
  b=DU9CwSWHs1KYP8MDXy9GXIezf1hcahpkeJPBlkfxijsGgnRhAPxuSB9P
   mA0MfN7Phn6/tGSd91BAs3bNehY0CwQF2nPIbf+02W387BZ4vzeyMpiIf
   dJgQ9ZvRm1ll1i3IbrnVwwrTyiW3nMS1nAZErjRHR+wSsCVloi8Kje/Gy
   X+2BgVJTFzg13eHO3NKkdtJ1C9lgmTPcHB7w50hFqvKqeyKFpXsD6bIEW
   XMNHQ82UUxVrVJ9ghZzJ/5rakrWklsZ2CsEUIJuMv7k7VjeDP4EwjSi55
   xzzAbzqBvPWMzY9oNeLbMLKOwtWnjZ6sKFQ/bBIjFOTsiiHlyJQ9GRmMQ
   Q==;
X-CSE-ConnectionGUID: tvKPHeoDTqqADvrUBRLr8w==
X-CSE-MsgGUID: 8paxMOpTQj+eC6H4eUpToQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2612502"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2612502"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 10:26:41 -0800
X-CSE-ConnectionGUID: zN2+c5RKSdWJe/cFTSQv7w==
X-CSE-MsgGUID: NVlKT6xbRIGdcOti26QVqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="7127449"
Received: from spandruv-desk2.jf.intel.com ([10.24.80.14])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 10:26:42 -0800
Message-ID: <29d7aaee9fb91642ca81b6e34e181657837a0ded.camel@linux.intel.com>
Subject: Re: [PATCH v2] iio: hid-sensors: fix fractional part for unit
 exponents -7 and -8
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Date: Wed, 04 Nov 2026 10:26:41 -0800
In-Reply-To: <sashiko-outbox-197712@kernel.org>
References: <20261104165319.1890851-1-srinivas.pandruvada@linux.intel.com>
	 <sashiko-outbox-197712@kernel.org>
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

On Wed, 2026-11-04 at 17:07 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> - [High] iio: hid-sensors: divide by zero in convert_to_vtf_format()
> for exp < -6
> --
>=20
> commit e56afd4fc65e2d177add5e21d5704d17876c53ec
> Author: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>=20
> iio: hid-sensors: fix fractional part for unit exponents -7 and -8
>=20
> This commit fixes split_micro_fraction() so that HID unit exponents
> of -7 and
> -8 divide the remainder by 10^(exp - 6) instead of passing a negative
> exponent
> to int_pow().
>=20
> > diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> > b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> > index 26f8554d18a57..22d33f8c25f14 100644
> > --- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> > +++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> > @@ -98,9 +98,14 @@ static void simple_div(int dividend, int
> > divisor, int *whole, int *micro_frac)
> > =C2=A0static void split_micro_fraction(unsigned int no, int exp, int
> > *val1, int *val2)
> > =C2=A0{
> > =C2=A0	int divisor =3D int_pow(10, exp);
> > +	unsigned int rem;
> > =C2=A0
> > =C2=A0	*val1 =3D no / divisor;
> > -	*val2 =3D no % divisor * int_pow(10, 6 - exp);
> > +	rem =3D no % divisor;
> > +	if (exp > 6)
> > +		*val2 =3D rem / (unsigned int)int_pow(10, exp - 6);
> > +	else
> > +		*val2 =3D rem * int_pow(10, 6 - exp);
> > =C2=A0}
>=20
> [Severity: High]
> As reported by Sashiko on v1 [1], the commit message notes that
> dividing by
> 10^(exp - 6) in split_micro_fraction() matches the reverse conversion
> in
> convert_to_vtf_format(), but does convert_to_vtf_format() also need a
> similar
> fix for unit exponents -7 and -8?
>=20

This patch is a follow up patch [PATCH 11/15] iio: hid-sensors: fix a
division by zero posted by Josef Bacik <josef@toxicpanda.com>, which
did this change..

> In drivers/iio/common/hid-sensors/hid-sensor-attributes.c:
>=20
> static u32 convert_to_vtf_format(int size, int exp, int val1, int
> val2)
> {
> 	...
> 	exp =3D hid_sensor_convert_exponent(exp);
> 	if (exp < 0) {
> 		divisor =3D int_pow(10, 6 + exp);
> 		value =3D abs(val1) * int_pow(10, -exp);
> 		value +=3D abs(val2) / divisor;
> 	}
> 	...
> }
>=20
> When hid_sensor_write_raw_hyst_value() or
> hid_sensor_write_raw_hyst_rel_value() calls convert_to_vtf_format()
> with a
> unit exponent of -7 or -8, 6 + exp is -1 or -2. Because the second
> parameter
> of int_pow() is unsigned, int_pow(10, 6 + exp) overflows to 0 modulo
> 2^64,
> causing abs(val2) / divisor to divide by zero in the kernel.
>=20
> Should convert_to_vtf_format() multiply abs(val2) by int_pow(10, -6 -
> exp)
> when exp < -6 instead of dividing?
>=20
> [1]
> https://lore.kernel.org/r/20261102222309.439895-1-srinivas.pandruvada@lin=
ux.intel.com
