Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75193289340
	for <linux-input@vger.kernel.org>; Thu, 30 Apr 2026 19:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777576901; cv=none; b=jSHlq2O6azIAHED+/2dBQDL5YpfLuCpauYCcrsK2AknQq5NZpZZ7dcVI1bqMUWlgxOB1DlHlvpv/Z+cLAeQD+tskSbXvzJSoLU6t4YE6krTiyhSwf9eTRFfdG1lyXLc3/2Yt0AENxNFdArX4DLDhysU2o0S0V52inCx8+4em9Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777576901; c=relaxed/simple;
	bh=Id/9QrNMu8Ly9mOLs/23rfazEvvQ4Gj7sfkpsrP5n4E=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Ij5FVjTxW/hCxBWry/wx3RKz1S+Kl60nM04Rd/5sngIJpQ4LcYX0KwekqW/CQWJQqWC7YNG8Suui77qNOjAFoxCQN86lhblrxO/Vgb/HoGezDT7+Wpfxu5qXnKACS8qRJmxjbNSXx5VYuPodpWH3fUgZArQXdklrh2F1cfl1Vq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iwzLRFyv; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwzLRFyv"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35e576110adso993763a91.0
        for <linux-input@vger.kernel.org>; Thu, 30 Apr 2026 12:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777576900; x=1778181700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kTutwlsLC+vJ/RVb3tmIFV1fWy4ibAZn5i0AUmzY/Yo=;
        b=iwzLRFyvwlWJOhg4Utuz/vVuLDxcpLVAkiAu0a+hu7WmAD3QRWGERW/Jb8RRo+zqMu
         QhXuPSGxwj36igGz8zKbiKF598BVMhsyuhDCE1z+OB34136bDNcG+gw+ruchpDfhE+eb
         7K4MSjX4kH5hDc7pKF2at3PA5xLNglQFSuQD9ifmDqZmEmwZ40OVZuZ5QXpCvSTWPjAu
         vL0cutrFLXvOzCIPc77q6jOvxnnATgbi/zPHKFNezVO6wgeYdZExFBue9lIV5EOuf3cN
         AOyoono+pkOVDR+AZgvwmII6MaiyTmOcuna9Gz8ara4VUdP22JGn6ZhSEa2rp1X/HWjD
         dC4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777576900; x=1778181700;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kTutwlsLC+vJ/RVb3tmIFV1fWy4ibAZn5i0AUmzY/Yo=;
        b=FHxTyJWGEL7EUdXnLZ4EpEOql1nerJW/7j7QWIfMkmMSd4qowhrJ2CChjGR6esY1rq
         dAB/vV4sGqGzexAXCGlZKLHB6rK/RhxkIn02TfRTGoJ4w5u0SroAGeioxn+omvSmgpT5
         Dz0dHFvN2UpYGe8CVLoa3IcbgOwVFBxwocgSS/FcV3MFVc4Fq44Can6vC0TsIhkZ0fZi
         ABURODl+BgpiNdKGaSSkqYBfRODbBFnTf5o0jp+ZhGS7zXrBcRu9GQe1+J8+hZOF37sf
         /7xB0hGzFBiDqNSeOApt6gy+ukKl2y9rZWmZW7LmS66f+4RUIW2VoxbodOpuCygmDoEo
         /AHA==
X-Forwarded-Encrypted: i=1; AFNElJ/amSBszGePdk5t5JoPc66wbVTtmO815Qf2188daaOY+zBcbur14FYf1xCVURPDJrF6khDG9wDiigwGFg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzNe/t/aReYcxYzJULysVki6qjPqK+vl5gXcgnQW1uIqKL0RZXC
	EiXaYNexyXWxCQ1e8Aug6OewJ/Il8vwl9A2Cu5+D6bRJABIRFTwSpKOR
X-Gm-Gg: AeBDiesFp8qNwkD3VwIyIlS7kxLMuIL4i+La6s9qVO+/2dGwKYg8nezm+Ow3OZTH6iV
	PHTnbNYaVMKgl+9ZWCWjH35+ur1JpeH5sTG2H0fXZBgdxmTs8BXIq+hn/BQ1sgAvulMzVsxz3ZN
	eJla/hRNJsnxPS6FmW7U8orfZZ/sroZgwmDJdWXX+85grZOC9m1Tmzzkp5sFt89IxWvP94vPTSu
	SwqmBeOUy/02J9U8AKyvsY8UzMleU79gxFOFuUsvjP8a5Pfi+v27gY0x858dsLs5nFCebaDprYZ
	gRlip8hjfSRCRElZQQTD4k3sKik2L+9plM/r1sqrZFUZ2NBNApXbhiEf4yV3JMXvQXRYZ4/voTK
	aSAT65eZbNkrYnLzyoXYqoahEBq+aDB7AhySyyzjJkW+NOK6aS+SXNytz/eb+AuQBEUyqyfTKVi
	ibk9MLQbzbgzXnHCAhHSuPPff8FHnMxnwICScas+T91oc2
X-Received: by 2002:a17:90b:4c04:b0:35b:d795:cf5d with SMTP id 98e67ed59e1d1-364c461d8ffmr3191808a91.5.1777576899778;
        Thu, 30 Apr 2026 12:21:39 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:53d0:4e4d::e3d:bc05])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364d9e9c03dsm1643018a91.0.2026.04.30.12.21.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 12:21:39 -0700 (PDT)
Date: Fri, 01 May 2026 00:51:24 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: jikos@kernel.org, jic23@kernel.org, srinivas.pandruvada@linux.intel.com,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 sakari.ailus@linux.intel.com, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_4/4=5D_iio=3A_humidity=3A_drop_h?=
 =?US-ASCII?Q?id=5Fsensor=5Fremove=5Ftrigger=28=29_using_devm_API?=
User-Agent: Thunderbird for Android
In-Reply-To: <afJdJIQS1vwOcaGT@ashevche-desk.local>
References: <20260429175918.2541914-1-sanjayembedded@gmail.com> <20260429175918.2541914-5-sanjayembedded@gmail.com> <afJdJIQS1vwOcaGT@ashevche-desk.local>
Message-ID: <12C22ED3-20F9-401C-ACC9-D666393B292A@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 30 April 2026 1:03:56=E2=80=AFam IST, Andy Shevchenko <andriy=2Eshevche=
nko@intel=2Ecom> wrote:
>On Wed, Apr 29, 2026 at 11:29:18PM +0530, Sanjay Chitroda wrote:
>
>> Use devm_hid_sensor_setup_trigger() to automatically release resource
>> during fail, unbind or removal of driver using devres framework=2E
>>=20
>> This simplify the setup, remove goto, avoid manual resource cleanup in
>> teardown path=2E
>
>=2E=2E=2E
>
>> -	ret =3D hid_sensor_setup_trigger(indio_dev, name,
>> -				&humid_st->common_attributes);
>> +	ret =3D devm_hid_sensor_setup_trigger(&indio_dev->dev, indio_dev, nam=
e,
>> +					    &humid_st->common_attributes);
>
>I believe the first parameter is utterly wrong here=2E
>Or other way around, same issue but in the previous patch=2E
>
Thank you Andy for the review comment=2E

It looks in same humidity probe of hid sensor with devm API two device poi=
nter are used &pdev->dev and &indio_dev->dev; ideally all devm should have =
same parent device for devres resource framework and over here preferable a=
nd consistent device should be &pdev->dev;

I would first update existing devm_* API to have consistent device and on =
top of that will use same device in devm conversation=2E

While for gyro change device is consistent as &pdev->dev across all devm A=
PI=2E

Thanks,
Sanjay Chitroda=20


>>  	if (ret)
>>  		return ret;
>
