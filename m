Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0903838B7D8
	for <linux-input@vger.kernel.org>; Sun,  5 Jul 2026 18:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783275463; cv=none; b=FlmVogpyV9LC1JkwoJfydViuDjkL/AisYHI59wJJfhwy19Z/yuMop8nmF+sRTmi3KvX/UE4XUrcCUWHzRoYjvd7TE1A9UqHFSVg+ed0b+cOy43Q0sf/PhpK3GYdrAilW6cjrp5yNAiOOZMfclNXnPhojDor6pNtAkQoM71j83QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783275463; c=relaxed/simple;
	bh=dhI2NSSkHQdnuRHh+TevsjJW+xFqrlGDV2/7Z5uiHks=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=SxXkEotB9+85DO5JTr9nfMIMtABirZ3K8gkqE88BvHnbENlya4sCfFPhoMz8CPS/BXAtYsSGEUScEmt6YEdkVHSAJ8KW/qAZxl3kDTYE5AiZAcNQXZf2g8InGKPBIHclCf4UDZKP5qcx75S9shIEI8yHQqjTNiO5kngMXoSX0Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mc+oq6rW; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mc+oq6rW"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so912894a91.3
        for <linux-input@vger.kernel.org>; Sun, 05 Jul 2026 11:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783275461; x=1783880261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HPuWUz6K1vjqfLd89Qgt+4X64jH/WQepHZOhzBXpFBs=;
        b=Mc+oq6rWGUenBzFtmvEUJ+cxwDxZAPvves1/eocNtmNJscDuk6o+nMPF1eH0MGyFrP
         RXkGYbcK7Sc7L4CG0Eu6X93ORKKDklom+QRE4tn2WikivT5U9YDZHMBYxhRUHuPXiTwU
         FdYYaWZ+MKa0z0k+E4WUef9HKZb4TCu/908sXgnr615cW/7DFjFuTZtr271IfgmKcxA5
         lMqEIw1UsE1KWG8cQXYjIIhvVDNa45Ly90bk+A51VlkYJvKNIpQDyywNDpX27zVgR59q
         NTof52fYfmVD+1JZaDWX62fEjFLZyQZ8q51gw06AksHKVJDhWQvkAKfJoU3UUnl8elgC
         He5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783275461; x=1783880261;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HPuWUz6K1vjqfLd89Qgt+4X64jH/WQepHZOhzBXpFBs=;
        b=H59avi5h/sIJVBOd/qkjwg/dVgM/sXNq2t89bhxoDPnIhiqyLUd6FiPmxoOv8Qp5oB
         bqdLNThm6EwOO+kCaTDJbXeUpBTyeAo8GTKOFdky5w75Icd87hO4c8jTlnuuG/iZHSBd
         DrDgh2JSkpzYfdk3PDX8DqnECyp+t+U2NtKElUhe05tkoGldxhwi0VPoTzQfjXgbggyB
         KmJU9jfFqtM20x01B7crkC5TPgAzqbb0k9xWE0Fy7rL19NNIZRfRU4yo5voIPfGp4RUm
         dBku+zHZOspbJBY3RiB6I35UXIM/tFlBC6d3ChKafSKx6YrdHYmr9Nn77/i2F583GcMY
         bYrw==
X-Forwarded-Encrypted: i=1; AHgh+Rr8MhDUvb0ff4ZBmeC/vVauiOlsbKDH6L5Uz1cE099kixq70T2YywVfnodMmmNAO5FFxgSWWK8RVrJUiQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwsxF+gYXvDIs0OKOk1KFGUS1L9gIYXViC0UUoK/JmGn1DA5N6Y
	WhButqa/NuIXZCBRj/Qr2GmR2bKEKIr9F+g2zuLx6NqS0t7yNq2vth/B
X-Gm-Gg: AfdE7cnW+vn+ls945vloXNtnz/67JPI4IfNijzZg/+AwHS+KDtTiWfg1y9QqdEy1GFX
	BYu5KMf5Bk+K2/x5GL+lIhgCf8aeziNmEuMqTeW06E1ubIYINMkPdOUPjG21y26IFip0JadOaan
	aGf65fHWQy9jJapRgLKbZkCqNGT6xnfwACu7qrI0UKWAr8R3hMRHIz/cTg1kjtl+QV2Y9+ycxCV
	Y9us7sA998evHmFf9hQZPAIzBPG20POdOMgnJ/deSDPcXIr66yV+Xbw/UDUgxiirqBnVOswenzH
	rtp2pF+hQifFpcXSH0nlPZfOEfLURxAnz2+tm1mF7GjHP07Vmy8bba46iL4sOqEnEUdRUE+dBKT
	t+M5Jvb3ZzGC/IDOUN0+t4RSzJg/ls4qhdVXFeyPhY47ZWqZ6KCnhoWPEMHaImx5Yo0KMKhD/+n
	K86m24EalTVRocW95rveKyZlWwC1Nr+ghcQ/d7
X-Received: by 2002:a17:90b:268f:b0:381:1c96:829b with SMTP id 98e67ed59e1d1-382803bb30emr7701477a91.3.1783275461234;
        Sun, 05 Jul 2026 11:17:41 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:1f3f:c3f5:258d:4c0a:f0e6:bd1a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f116065c5sm41239387eec.11.2026.07.05.11.17.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2026 11:17:40 -0700 (PDT)
Date: Sun, 05 Jul 2026 23:47:36 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
 Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org>
CC: David Lechner <dlechner@baylibre.com>,
 =?ISO-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, Maxwell Doose <m32285159@gmail.com>
Subject: Re: [PATCH v2 3/6] iio: hid-sensors: Use implicit NULL pointer checks
User-Agent: Thunderbird for Android
In-Reply-To: <20260702182205.388efe24@jic23-huawei>
References: <20260702-15-jun-hid-iio-alignment-v2-0-b87f01f5efbc@gmail.com> <20260702-15-jun-hid-iio-alignment-v2-3-b87f01f5efbc@gmail.com> <20260702182205.388efe24@jic23-huawei>
Message-ID: <BF19024B-D73A-4185-A963-516D0574E416@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 2 July 2026 10:52:05=E2=80=AFpm IST, Jonathan Cameron <jic23@kernel=2Eo=
rg> wrote:
>On Thu, 02 Jul 2026 21:48:00 +0530
>Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse=2Egmail=2Ecom@kern=
el=2Eorg> wrote:
>
>> From: Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom>
>>=20
>> Replace explicit NULL pointer comparisons with implicit checks across
>> HID sensor IIO drivers to follow the preferred kernel coding style=2E
>Is there anything in the kernel wide style guides about this?
>
>I do prefer this style in IIO but perhaps we should document it
>as local IIO style rather than implying general guidance (unless
>there is some!)
>
Hi Jonathan,

I took reference of existing IIO commit message and followed the same=2E

There is no kernel coding guideline for NULL pointer=2E If you think it wo=
uld be useful, I would be happy to work on documenting the preferred conven=
tions under "Documentation/driver-api/iio/", for example as a new "coding-s=
tyle=2Erst" or similar document=2E

Thanks, Sanjay

>>=20
>> Convert 'if (indio_dev =3D=3D NULL)' -> 'if (!indio_dev)'=2E
>>=20
>> No functional change=2E
>>=20
>> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail=2Ecom>
>> Reviewed-by: Maxwell Doose <m32285159@gmail=2Ecom>
>> ---
>>  drivers/iio/accel/hid-sensor-accel-3d=2Ec       | 2 +-
>>  drivers/iio/magnetometer/hid-sensor-magn-3d=2Ec | 2 +-
>>  drivers/iio/orientation/hid-sensor-incl-3d=2Ec  | 2 +-
>>  drivers/iio/orientation/hid-sensor-rotation=2Ec | 2 +-
>>  4 files changed, 4 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/drivers/iio/accel/hid-sensor-accel-3d=2Ec b/drivers/iio/ac=
cel/hid-sensor-accel-3d=2Ec
>> index 9197f3424c0c=2E=2E225f8dd65ab1 100644
>> --- a/drivers/iio/accel/hid-sensor-accel-3d=2Ec
>> +++ b/drivers/iio/accel/hid-sensor-accel-3d=2Ec
>> @@ -325,7 +325,7 @@ static int hid_accel_3d_probe(struct platform_devic=
e *pdev)
>> =20
>>  	indio_dev =3D devm_iio_device_alloc(&pdev->dev,
>>  					  sizeof(struct accel_3d_state));
>> -	if (indio_dev =3D=3D NULL)
>> +	if (!indio_dev)
>>  		return -ENOMEM;
>> =20
>>  	platform_set_drvdata(pdev, indio_dev);
>> diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d=2Ec b/drivers/=
iio/magnetometer/hid-sensor-magn-3d=2Ec
>> index ad10fa20fae0=2E=2E738bad65d74d 100644
>> --- a/drivers/iio/magnetometer/hid-sensor-magn-3d=2Ec
>> +++ b/drivers/iio/magnetometer/hid-sensor-magn-3d=2Ec
>> @@ -463,7 +463,7 @@ static int hid_magn_3d_probe(struct platform_device=
 *pdev)
>> =20
>>  	indio_dev =3D devm_iio_device_alloc(&pdev->dev,
>>  					  sizeof(struct magn_3d_state));
>> -	if (indio_dev =3D=3D NULL)
>> +	if (!indio_dev)
>>  		return -ENOMEM;
>> =20
>>  	platform_set_drvdata(pdev, indio_dev);
>> diff --git a/drivers/iio/orientation/hid-sensor-incl-3d=2Ec b/drivers/i=
io/orientation/hid-sensor-incl-3d=2Ec
>> index 870c8929491e=2E=2Ec8efb0dab8b6 100644
>> --- a/drivers/iio/orientation/hid-sensor-incl-3d=2Ec
>> +++ b/drivers/iio/orientation/hid-sensor-incl-3d=2Ec
>> @@ -302,7 +302,7 @@ static int hid_incl_3d_probe(struct platform_device=
 *pdev)
>> =20
>>  	indio_dev =3D devm_iio_device_alloc(&pdev->dev,
>>  					  sizeof(struct incl_3d_state));
>> -	if (indio_dev =3D=3D NULL)
>> +	if (!indio_dev)
>>  		return -ENOMEM;
>> =20
>>  	platform_set_drvdata(pdev, indio_dev);
>> diff --git a/drivers/iio/orientation/hid-sensor-rotation=2Ec b/drivers/=
iio/orientation/hid-sensor-rotation=2Ec
>> index 2dad0453fc67=2E=2E6db253c1635d 100644
>> --- a/drivers/iio/orientation/hid-sensor-rotation=2Ec
>> +++ b/drivers/iio/orientation/hid-sensor-rotation=2Ec
>> @@ -274,7 +274,7 @@ static int hid_dev_rot_probe(struct platform_device=
 *pdev)
>> =20
>>  	indio_dev =3D devm_iio_device_alloc(&pdev->dev,
>>  					  sizeof(struct dev_rot_state));
>> -	if (indio_dev =3D=3D NULL)
>> +	if (!indio_dev)
>>  		return -ENOMEM;
>> =20
>>  	platform_set_drvdata(pdev, indio_dev);
>>=20
>
