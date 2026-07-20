Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0E7403EA5
	for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 16:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784566235; cv=none; b=ZiIrnusV3yoSxZB/hDgig1MabDKl6a/GJfVl7h4DW8w9hH5Ioyomiy9X3vqP+4XbuN/O8zaZ88G0sQ0a1zgW/ZmxpaozwygUOkZ8BnKWsRdeFzbJBsR3/auTzq0JmZ9ShVBAdFs7lWR0CySb9hgLmYoKmTgt5dCT4pXdS6Hf/3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784566235; c=relaxed/simple;
	bh=xLj8gVdARFZvL7dMaAwyCyeARyxXEU4B3zwUZPi/zlk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=P/JcIdC8AhL5I6mcrAbT5Uh9I+233C0TPrX32cGKYCmK3yAk04Kkj1mofbl3Ppt6DEmldz06LoXqimdfdmVHCJDG0mSpQ8tbX1s/v5+hTNI8PUZtWFj3tWk2BaSGqEYx2MtutmOIQbyQdTJcxVRgMiF1apZ/vIRdR2laDvvegGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CxgjVmxL; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxgjVmxL"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-384c94c9414so5908183a91.3
        for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 09:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784566234; x=1785171034; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=E9JE/eR+ETc25R/xPipwqaolcgylczRQleB6t8SczIQ=;
        b=CxgjVmxLrj4zWpRiA52rv2BC1lJOLzgDZBogublJPBkKVnWy4wyTYesnTvFQVa0xb0
         uuYiDISHcr8BSjVNF/1g73AFBWwL5Lyq16l7ks+X2bDJXlgzVI+HhtZv3sUq7KGQ/fq/
         jLweqAUIfY5UElnkmBZgYItFD1+sANchyZfopO3Fc/eLqD7ODxvAU/R2rnvscbk4S8RS
         VmjVPBVbTc5dytPkuSGtPt4kgOy68Xiy8wWTIVNgaemaYVId+rmU+JbK28P5zeEncNnm
         42Uy2CiE0mcO7uzhp5ZT74pihjL2N7Fyxs0NllDvtkMd6Hky9bUbPVSS8ws7BM/EPlwJ
         xeyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784566234; x=1785171034;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E9JE/eR+ETc25R/xPipwqaolcgylczRQleB6t8SczIQ=;
        b=K9BCQDo2ruqoKgMBkZBsy9f/7BhytAwgV/n/Gogl/rgPnjnAVB2rm2oht1oHA311b+
         Eori3yrmRasy8oZ7zl4iUkhXx2ikem/WlP5OGtil4+EZJM6Yq3w2FnZr3PEqp7hLKNvP
         DlBhvKvEvLgJ7b/hEy3kVZ4jvfIUsdcsmgn9DAsBPXe0IZX8XfpoQPxU9imoCqd4EdnA
         4209ONJiA9E5U4B6AAHGkRIcms3Z+EXyWSi82cmf+7I1PjjW8b299L0ED+SeC65d4YUr
         MhfEprPTKte/Bklauuu8S+5XyuF0o/71n0Ms83zJKmf0/dV1W/Ub/JQbiGoOh/EbqYgI
         l2nQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr9UUAJa5SpdfdhPDl4oeMuGiS1DldnP85ZGDymIH6u+2WxoWO/IWiMUGObjSHObMHopSIMDdSX7kgsUA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEUhJB+odoJaFUOjI0ECv7uXkHPgOiraQQi+3xoqYM4WKXBB3A
	5pqKphQvtnEuXsaWCy1DOZJU7scxXIubdXk5r6WkFRi4hq3v6MKvLJHG
X-Gm-Gg: AR+sD133Y5X1xNrNcehp4rNen0vTIzPuPjeb49gMraxSa+6kkJHm1ANmxWWghkyHIyc
	SeflGstMUK4qlUhSfSa8cH4Rzk7wDPPwdOziKaYfYJ++DpTZadCfAU13HEaeFyy+HboetKt0Njr
	FyNhLVx9/u6HwjuKsQDiMu3BLeCBV1k41IXt2gIGnub7L+/W3x2dmWWmVZT4JOHAsa9zDQ15U1a
	FhdURY+kmyBSndVg0y21A6QKMPtgxVIxUMUPdvTV/IcdpzXlqgZv9RnKmVMZEfDL0I4JGkoInEw
	9WJA36RWb2L7jgbLRPgpUFlrD+TuvWsAbRkJIufATurUj+XjKqEwSLr+I0C4Xt5+4OrXWidlBUg
	2A+QNQsJEWDg64X0EX3M6lPq4RYLzk2S671NuUAtXXTSUrev6WNTA1CrHDCbXTF+ehX6QqFUxIm
	mmXTVvnZuhR/W6Ml+FF5kAOro/Pw==
X-Received: by 2002:a17:90a:d44e:b0:38d:ddc2:7ccb with SMTP id 98e67ed59e1d1-38e4b3d0fdamr14849441a91.1.1784566233232;
        Mon, 20 Jul 2026 09:50:33 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:1f3f:a2a5:2929:50ea:668d:9415])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce2a129f3sm30207025c88.7.2026.07.20.09.50.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 09:50:32 -0700 (PDT)
Date: Mon, 20 Jul 2026 22:20:28 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 David Lechner <dlechner@baylibre.com>,
 =?ISO-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_02/10=5D_iio=3A_gyro=3A_hid-sen?=
 =?US-ASCII?Q?sor-gyro-3d=3A_use_local_struct_device?=
User-Agent: Thunderbird for Android
In-Reply-To: <al4MeTgAWWkJsb1T@ashevche-desk.local>
References: <20260720-hid-iio-local-struct-device-v1-0-74496fee6327@gmail.com> <20260720-hid-iio-local-struct-device-v1-2-74496fee6327@gmail.com> <al4MeTgAWWkJsb1T@ashevche-desk.local>
Message-ID: <1E009860-0A0F-4F8D-8017-CE5739F22144@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 20 July 2026 5:24:33=E2=80=AFpm IST, Andy Shevchenko <andriy=2Eshevchen=
ko@intel=2Ecom> wrote:
>On Mon, Jul 20, 2026 at 03:10:14PM +0530, Sanjay Chitroda via B4 Relay wr=
ote:
>
>> Introduce a local struct device pointer derived from &pdev->dev=2E
>> This avoids repeated &pdev->dev usage and improves readability=2E
>
>=2E=2E=2E
>
>>  	if (ret) {
>> -		dev_err(&pdev->dev, "failed to setup common attributes\n");
>> +		dev_err(dev, "failed to setup common attributes\n");
>>  		return ret;
>
>Nope, First one (to eliminate a lot of churn) should be to convert this a=
nd
>similar to use
>
>		return dev_err_probe(=2E=2E=2E);
>

Hi Andy,

Thank you for your input=2E

I'm planning to have a incremental series: first introduce a local "dev" p=
ointer, then convert the resource management to "devm_*", and finally repla=
ce the remaining error reporting with "dev_err_probe()"=2E

This keeps each series focused and avoids introducing intermediate pattern=
s such as:

   ret =3D dev_err_probe(dev, ret, =2E=2E=2E);
   goto error;

Once the cleanup paths are removed, those sites naturally become:

   return dev_err_probe(dev, ret, =2E=2E=2E);

Does this approach sound reasonable?

>>  	}
>> =20
>> -	indio_dev->channels =3D devm_kmemdup(&pdev->dev, gyro_3d_channels,
>> +	indio_dev->channels =3D devm_kmemdup(dev, gyro_3d_channels,
>>  					   sizeof(gyro_3d_channels), GFP_KERNEL);
>>  	if (!indio_dev->channels) {
>> -		dev_err(&pdev->dev, "failed to duplicate channels\n");
>> +		dev_err(dev, "failed to duplicate channels\n");
>
>And this kind of messages are dead code and must be just removed complete=
ly=2E
>
>>  		return -ENOMEM;
>>  	}
>
>=2E=2E=2E
>
>Please, revisit the whole series=2E

Yep, understood=2E

I'll revisit series, drop dead code and send v2=2E

Thanks, Sanjay
>
