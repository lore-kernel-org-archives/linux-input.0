Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B389361652
	for <linux-input@vger.kernel.org>; Sun,  8 Feb 2026 15:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770563992; cv=none; b=n3s9k+NNJp/7yqmbEtbnTytSqBfjOw7dRjb+gjOxjzExSkovE1IpZad6fYf2zF2mD1uSVR6O+Fpe3IrkW8Q4TdPxcTI2im+KptUXJ5ngTT0n9OyWFB3AY9o+pf+XD+HmbwFDNZUF/IElfK6r/vcKTUv6/C1KQ9cjNa8pRD5ARhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770563992; c=relaxed/simple;
	bh=+xzriWSR5iGt8WjlG2DY92+pZ7PIMUvY0YdgOUgFfco=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=QDSoDJ/k57kBZoc36QR5zBPYlGUzZeCQh9fQHMtcDN7kpoyqXfUWZ3XVs4PyXxCfE49eqxdC9xesEZaf+rtvGXBxl2tbHn/64jO+LnJ7zyPdv+i9j5OkvQhsjPi95CC7DpWPoFFd27ITv9vmAW9DecOSOVaOUmYs+skghrA+0pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZdL7NR5g; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdL7NR5g"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-385baa8afaaso32423181fa.2
        for <linux-input@vger.kernel.org>; Sun, 08 Feb 2026 07:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770563991; x=1771168791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W15qM4zjUo3jkGGj+XoI8VU/D/d6+cRvXAz+lQ/6Xi0=;
        b=ZdL7NR5gg9PVmkfWYGcRwVQtSmwqU2/cegi5GlPMGVAPzk/tD+eO5SmTNRE2o+1ZjS
         fuztcZZumVkpPPc2lIEBJ2hG0RxXV6Rcv4vIGiyrTHXAHT8TFGz2KnapNxp0nkbzgJ4a
         iS/HQn5WX8F1NVPsDGUVdQvp2m3SuCA0vvGT0YgWeT8cg86vNVDQjV3HIhQPr7xrD8MD
         poL/MMCuv7aqJaa43cWrw5XTVIFHp2pZFPOXrBROrgQRN0K6Sb7OohnXRAkNZeD3tlyL
         mCoZejj/bejgC3/gQCmd6D/7l3ENOYeKdWjOUuVR0vzJbwZNSYdI7qc8YZCXQVtOrzI9
         jnKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770563991; x=1771168791;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W15qM4zjUo3jkGGj+XoI8VU/D/d6+cRvXAz+lQ/6Xi0=;
        b=O1mnHfbOBLkLZI2tqzaROiFjtiJF6kqaKPILnsYCG/a5bhxBMhWzYAd2rHskEYzKjv
         OIQy6Rqwz4C1KXIlojyCJ2UmMRTMXrElyiQJOM8FQMsOyec4edEO6Hw+szrN83UMvYFe
         nId30Cb8gw+qxK+LqLMuuCeytbIGWUk1JiI/6h588eiK/cOn+I41g3JCm90ekt0laQQ6
         5mWcciJHE2JyUJToO/nFSsvPMqXG79HZE0593eiRzHZH9B3T6tIlaXB6HmttsgfpbLsZ
         4mqZD+5txOUCd+5QjPJ7FicKU/DW4Fsj7vp0RmiW3DGHLtdc6JCjn3HExmTlmpnXc9nf
         9l+A==
X-Forwarded-Encrypted: i=1; AJvYcCWi7kxYR2TdvWhmJl/O3CbjndmOCxzmsNfogCkBXvtxbYz+Mx3suIkc4UhXBbGnyh2LvPVZydy/zb9NKg==@vger.kernel.org
X-Gm-Message-State: AOJu0YypMXYbwh5qi8Rpy2tJrTnYJYRQr6ei/VfFNGrcdWsh+7nlz/gx
	BuDV71QzKepQ5OUmDLHrrfHtgGMGnnKgzwKmNCRDPniLUHdxpbH4Lg35
X-Gm-Gg: AZuq6aKkCrBULTLhZSLoUtyjpH9aOqTD9eriajixE81rvpOhPWnc8VOh3ib+k649txB
	urE9znCsi72PzD/aTXocUh76b4Fcwvwva36w6GSh/EfxVmr1abI0ySJJc8Bi0xh4e++qgOy/v4E
	7d92iAgH5S3J6Frs/f72qyIdSwB+3Nv/1U+B2Vj582SgvtxOynwffYSWeUqaZVamdxCq3zfbViS
	0/6VXXML8PdnWm7CaGt10lt4MSntiEfhGFZqNYGuZvGh3WBQVBX36UTleqDpu0sMl/6QsgCiHfw
	cAfQvAi2zzWTHWPPVxwj0YJaxQYwXvYIPRwTW/lNDyuvlmLjHxtAgeMCD3lVVNrW/fjwK8uuMPg
	EgAWq2EDq5JtFrpSX1Kvo20dIMO88G5Bb3FSdNWTdH3PTEMHCWNacFe7TLk2obDFpZL5XpG8xWj
	yv/1SB5sg3U+zjIiBYKxRb
X-Received: by 2002:a05:6512:2508:b0:59e:4f97:ad59 with SMTP id 2adb3069b0e04-59e4f97af15mr263855e87.10.1770563990386;
        Sun, 08 Feb 2026 07:19:50 -0800 (PST)
Received: from ehlo.thunderbird.net ([178.137.246.208])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e44cf6e8fsm1963107e87.9.2026.02.08.07.19.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Feb 2026 07:19:49 -0800 (PST)
Date: Sun, 08 Feb 2026 17:19:49 +0200
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?ISO-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>,
 Pavel Machek <pavel@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Dixit Parmar <dixitparmar19@gmail.com>,
 Tony Lindgren <tony@atomide.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, linux-leds@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_10/11=5D_mfd=3A_motorola-c?=
 =?US-ASCII?Q?pcap=3A_diverge_configuration_per-board?=
User-Agent: K-9 Mail for Android
In-Reply-To: <aYiHnUW93AB0ARJH@smile.fi.intel.com>
References: <20260206172845.145407-1-clamor95@gmail.com> <20260206172845.145407-11-clamor95@gmail.com> <aYiHnUW93AB0ARJH@smile.fi.intel.com>
Message-ID: <D8B3E97F-3405-4EBD-882D-677F530E4EDB@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



8 =D0=BB=D1=8E=D1=82=D0=BE=D0=B3=D0=BE 2026=E2=80=AF=D1=80=2E 14:54:53 GMT=
+02:00, Andy Shevchenko <andriy=2Eshevchenko@intel=2Ecom> =D0=BF=D0=B8=D1=
=88=D0=B5:
>On Fri, Feb 06, 2026 at 07:28:44PM +0200, Svyatoslav Ryhel wrote:
>> MFD have rigid subdevice structure which does not allow flexible dynami=
c
>> subdevice linking=2E Address this by diverging CPCAP subdevice composit=
ion
>> to take into account board specific configuration=2E
>>=20
>> Create a common default subdevice composition, rename existing subdevic=
e
>> composition into cpcap_mapphone_mfd_devices since it targets mainly
>> Mapphone board=2E
>
>=2E=2E=2E
>
>> -static const struct of_device_id cpcap_of_match[] =3D {
>> -	{ =2Ecompatible =3D "motorola,cpcap", },
>> -	{ =2Ecompatible =3D "st,6556002", },
>> -	{},
>> -};
>> -MODULE_DEVICE_TABLE(of, cpcap_of_match);
>> -
>>  static const struct spi_device_id cpcap_spi_ids[] =3D {
>>  	{ =2Ename =3D "cpcap", },
>>  	{ =2Ename =3D "6556002", },
>> +	{ =2Ename =3D "mapphone-cpcap", },
>>  	{},
>>  };
>
>This  also needs to be converted to use driver data=2E
>

I can do that, but is it needed? This id table, if I understand correctly,=
 is here solely to silence warnings about missing spi id table=2E Driver it=
self does not use it in any way and will never use since all available devi=
ces that use this driver rely solely on the device tree, all possible futur=
e devices will be relying on device tree too due to obvious reasons=2E

And please, may you contain all your reviewing in one iteration=2E Then bo=
th of us will spend less time working on the patch=2E Thank you!

>>  MODULE_DEVICE_TABLE(spi, cpcap_spi_ids);
>
