Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104D730AADB
	for <linux-input@vger.kernel.org>; Sun,  8 Feb 2026 14:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770561696; cv=none; b=OpHwsHNea/jtqGaDfW2VLSpVr76Gy3gePAOWvwYXPlp/9ZQlqgPaCtol4AtjyNng+lftzrXVFksuvFlAm92Pyhv0PvIvAECPj3xckZFSIsy5aDi4YOkwAWqEQlzIUdNeyQ6YiKdHXxkIv5M9HXRWxOHp7SNFrMtZAjEK1dTHVZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770561696; c=relaxed/simple;
	bh=CZs6W4qtgovICtv3aQ4MI/35xymWjYMW9FmKLgGvuPQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=B0gO7KjU8dp1uBwBo/S9NsFLCo9w7sIeou7bjdRjsTpeCNsfDCaCH8VrMFc06TkjEcOjnYdN9XW8FVIE3H1oYlcIAcjXt52juVuoY9I8gOlbRSDnLqD5pyufXt0dzv0PkDZ2wigIoVdzHXh8jXs//4SG3Bkdd0mkX9i5hGnzEjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iuSFG1Rp; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuSFG1Rp"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-59de8155501so4017767e87.3
        for <linux-input@vger.kernel.org>; Sun, 08 Feb 2026 06:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770561694; x=1771166494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rYIWPdf9Ppa+RCJ5xZ0bnUhEJapRTVibnTDn3MDdLKE=;
        b=iuSFG1Rp7qDdoQS1exGm06yTiEKE8Ut9Sby3ZZLF/zCWH4LkssqaC3tX0QAvid2tDZ
         VnSHPoGkzaL+5sn2ZUpiaMdEjLhk53Nm2u2SyT1u1KyMVFz8swBc8zQz7RVPbK/fOJ56
         pEQOvQFR+dfhtTOTfHVmo2apfkd8UMJD7IajkDhVKME/rByfKkbfB9mle0n8li2B+E6P
         DPi7HGy3NVWGdWqFeGnjQkxhq2ZhzNR3xPl0lifC556ugcm0En8cd7ia7TAXTqjv9Pf7
         xnk/ay0/30ZjEGbiUoa+ejygg92xWM6xypLs/rRzgWt9C/856NQMTxWCoYnEPNpZLJWM
         c1Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770561694; x=1771166494;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rYIWPdf9Ppa+RCJ5xZ0bnUhEJapRTVibnTDn3MDdLKE=;
        b=oLr7Ev64ur7xgK7mHA/lrCrrMqyCWxn2fpkYudPT2wfIABuDZYoNzMIe+nYE28fD2C
         tvohifrL/z5TcryWFxBlwss4uvhgpQOyNFO0ArzctNIoYPwY1cv377E4y7x2RL5ZLpJ+
         kH0Ll4IMY78PeRsv0kgmz4Yc9HRRB8Uvc6gcSBO9iJzNHisuy2gWt3eHxMBhOwwp6wCW
         rlwfUZyB8UZ1VjZQrascZj7XoSnNzFYMCXB/rMUVafsxctmWtA7kCaXEWL3gHLD65683
         gVDPMqplrdm6ZLNN4n8kJzzMdIOr3jExxdEwrkNiHV4S/1/I+i/CGt4reDmHoteam8yc
         OGOA==
X-Forwarded-Encrypted: i=1; AJvYcCV7V2TBJf7Vn/YLQbsNJI9ld7CIfXQDlz11wwaNO5gU2jM/o5Qstjj97i7O4wlaW1omwjufBGmY7mJ9BQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwUnbbBSshyowGtnIn66fvdsV7snw2pvEfxwgSouar3ykA95Zpx
	8dldaw+t9hbHVjnSfnrF8aYZBa9jYlzlmISRnroRikd7CN4J0B3rHpv0
X-Gm-Gg: AZuq6aLsWCYQCwUddAFIqXtw3PQUE8Ilu8FP0MBPPlN4NzOEcrvD1WTRczNT47yfKM6
	9LcrxS5vEE3tohTSuAld9xgOjw3QxZML2c1OKXedTgp6fdR4P2LLsjeWD9gZiKlRGljYc19aWGM
	VLPELIRcS7UTbqQRBUzqqe7MgC2yEPhgrb4PtT3LtuadXTn2AKin8adYXauXNeHfL/dhy7vYHyR
	u1HOpOLgv+IxdhhkQuOmmIiNOttFFvOv4F/Di369wYTXYBga06iQuAtZUXEYdozVbMO3XBgdXGF
	C4YEljjaujNmNPu8/bnvtYkpBUzg1h7WfkMa+BTk3jeObe+HQwB1m1zZ+z/remOiZoBsqWvKbQl
	ssEU7qb86r+PkW5GV1W5QzGhcXYsxD6M87Gj0GJXdLU2ws6GW0ly0T0O3MTbA7JyrUJtd5zWaGz
	nZohHksEt8itqc/zn7dNkE5ZlbGoDL7A8=
X-Received: by 2002:a05:6512:1302:b0:59e:39af:a70f with SMTP id 2adb3069b0e04-59e45156d7emr2557460e87.35.1770561693903;
        Sun, 08 Feb 2026 06:41:33 -0800 (PST)
Received: from ehlo.thunderbird.net ([178.137.246.208])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e44cfd475sm1948495e87.29.2026.02.08.06.41.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Feb 2026 06:41:33 -0800 (PST)
Date: Sun, 08 Feb 2026 16:41:32 +0200
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
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_11/11=5D_mfd=3A_motorola-cpca?=
 =?US-ASCII?Q?p=3A_add_support_for_Mot_CPCAP_composition?=
User-Agent: K-9 Mail for Android
In-Reply-To: <aYiH8iwetvRfWxGI@smile.fi.intel.com>
References: <20260206172845.145407-1-clamor95@gmail.com> <20260206172845.145407-12-clamor95@gmail.com> <aYiH8iwetvRfWxGI@smile.fi.intel.com>
Message-ID: <39B7F089-5B4A-47F7-B2EA-A526B290FA77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



8 =D0=BB=D1=8E=D1=82=D0=BE=D0=B3=D0=BE 2026=E2=80=AF=D1=80=2E 14:56:18 GMT=
+02:00, Andy Shevchenko <andriy=2Eshevchenko@intel=2Ecom> =D0=BF=D0=B8=D1=
=88=D0=B5:
>On Fri, Feb 06, 2026 at 07:28:45PM +0200, Svyatoslav Ryhel wrote:
>> Add a MFD subdevice composition used in Tegra20 based Mot board
>> (Motorola Atrix 4G and Droid X2)=2E
>
>=2E=2E=2E
>
>>  	{ =2Ename =3D "cpcap", },
>>  	{ =2Ename =3D "6556002", },
>>  	{ =2Ename =3D "mapphone-cpcap", },
>> +	{ =2Ename =3D "mot-cpcap", },
>
>Drop inner trailing comma=2E
>

That would be a stray change, wouldn't it?

>>  	{},
>
>Drop a comma at the terminator=2E
>

That would be a stray change as well, wouldn't it?

>>  };
>>  MODULE_DEVICE_TABLE(spi, cpcap_spi_ids);
>
>This can be done in the patch that adds driver data=2E
>

Then lets move there=2E
