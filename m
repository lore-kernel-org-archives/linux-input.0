Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B01357A2E
	for <linux-input@vger.kernel.org>; Mon,  2 Feb 2026 10:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770027283; cv=none; b=haDF6Y3Pxo5ag7VwYxodRV9rmbZh4EqDeiUUJmIwCY9YPiLy5d97aAeG8cRFyYtf08KQVCrByJQaeZ/yxmHjsoXVEEKamyewk6Z7yuIiA7pdgy+AE5Cqq32JfZEm0hoMjHXvtblMdZ26vSnhV+GQzHJB3YSJQOG09w3pOKLeVn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770027283; c=relaxed/simple;
	bh=2auIHPqsiVDrUHz2mfGeHvAJ5QYC0LUiVSGItMyWde8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=iusQWMx8weTQrkHqwJqELKU1s5NCs++/6pyR3k/y4VBI+7cKm8GpyEaDyhUWiaT32YdMGfM2UZeXYpJq10vFgwK8O+YuPtfPQekiHogTjQNQDXrkIIMtG2RpJRXdL5W0iW+NBNr4K0pAvDXTlJsWUmv5KhmHYjHDzJ8lq6UKDTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=V+K9Fu5D; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="V+K9Fu5D"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-432da746749so2417025f8f.0
        for <linux-input@vger.kernel.org>; Mon, 02 Feb 2026 02:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1770027280; x=1770632080; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jr6CwQYi+BmExRh3DhyFfDwqTiLalKND+P2i3zpKjwg=;
        b=V+K9Fu5DtNA+L2iWRTqq32SGjUjrf2gUTe7dEszqRc5zMLtA/ZUbesQXh/pUxwDXT0
         etprW+C+0LPRXiXyzEwFoDNGSHELadGytBozL9+GHtBz9rgZCLBE3YCN/bLCB2N6vsKb
         1QXiVuO9nny1QVLyh9KUTY2LqWvNG43gYaPFHNjwDGN9+Hjq3AypqpEh+Q1+Pg97MfG9
         fy7TYkhODBsAyJvgS8sBXo/2neLXKbVQDgvuclKIm77kErntEfpAO6rPt6lFjHFI8LhU
         ebrCpC58yN2ilv5mqIvgGokIu0IVL0IkV7aBEmcLc77VPv7ba1/K+EMskBxIbDxOnl9m
         rCcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770027280; x=1770632080;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jr6CwQYi+BmExRh3DhyFfDwqTiLalKND+P2i3zpKjwg=;
        b=kYfj6FmDiiwG1MnXo3JwmX/y+/5ZHXdepLEsuJPeAJgcSXd5zLXsS8jmXXhR9Lxre5
         g+sHXH+j4pgintv1KxOiO62C1iXVRy3xFCuhjC2ongbQ+I3nYh12JfAygG0MrX4DGwo8
         NGCn2x2fTghFVoFuI07vhonpzt+EAYuzUNksNIMS6Xj118GWoiHZ9YV4ITwSYdxhqUBd
         utJZLnV4/Yq7p5AyYVrAyNhjOTagLdXEQudyKsIVnh+W223vmGvRYfQMGC7eQlS+yDLT
         3vc6JfEeQtTxpT+gD2VnS3sUV45GA/mTAmjzP0fD4v2eT+OK56kL9DRk/tHxL5GWDgXQ
         HIsw==
X-Forwarded-Encrypted: i=1; AJvYcCXwA32Rq7RxIoTYjHEEWDQQz6pGXLch5xprz55FqSbBQOQTjDm+Vcvm4X1xaeoaEDrNBuGxyY6VG5GmLg==@vger.kernel.org
X-Gm-Message-State: AOJu0YySdWh/a+sQMorKa6yTkBEUK4VwKn0xlX2cJlA4IJG5bY9qxtR3
	LC52PcYHiqBHPeKMgdPgvwT4IVzpro9qjS+MAS1TWJnD00gdSfGBNRfpnUuP1bxZPPc=
X-Gm-Gg: AZuq6aL89Go4infOjwdu/VW7hv88Rwz955ng61mrNF2uK84Y0nEGm5rNmkf+kep2Qmf
	RcbuMLnzrn/6ybaKTQl8RYe1Y4kkMV+HPAPpsYp01+I6leYiGDUTmw3taJdt0FpM6vRG1IEDEfX
	dv+d/FVkxXS6tjf1PAs2Ma99w/uq9S79wU++JlzENK4lPB2cgE/DWQ84l88xX0ZEuh1IN1+8iGv
	c2LnB6G6uAs4PWNoplGQD2vwhfqf34vbutM0rRq8d3PrGEUfd6AZ0iXjFzJK3i2hPHJxvOfViwN
	K55sNMSr8SMBajBVbDuODz/x1u6p9yvtwPf7y6AwezVLUM+JxAN4qCDYaw1Ubkx4v9Xym5k0Pt4
	HUyJuz6GnO20NdimynAU+5wFXKP4SYR5VsxfTAW8sQTe3Th7WFBX03UUWdtEDceTiToRuT0SOAP
	GFeB1r1GIYqVACnzuNfS7M2pIpwHh4L+diy3etmq07IQr8fPNCtBGOyJUJ
X-Received: by 2002:a5d:5f51:0:b0:432:5c43:76 with SMTP id ffacd0b85a97d-435f3aafca9mr15610107f8f.39.1770027279835;
        Mon, 02 Feb 2026 02:14:39 -0800 (PST)
Received: from localhost (244.60-200-80.adsl-dyn.isp.belgacom.be. [80.200.60.244])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10edf62sm46960096f8f.13.2026.02.02.02.14.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 02:14:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Feb 2026 11:14:38 +0100
Message-Id: <DG4EAYDXMGQS.2MKAJKDFQCFEG@fairphone.com>
Cc: "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Bjorn
 Andersson" <andersson@kernel.org>, "Konrad Dybcio"
 <konradybcio@kernel.org>, "Luca Weiss" <luca.weiss@fairphone.com>,
 <linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] Input: aw86938 - add driver for Awinic AW86938
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Konrad Dybcio" <konrad.dybcio@oss.qualcomm.com>, "Dmitry Torokhov"
 <dmitry.torokhov@gmail.com>, "Griffin Kroah-Hartman"
 <griffin.kroah@fairphone.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260128-aw86938-driver-v2-0-b51ee086aaf5@fairphone.com>
 <20260128-aw86938-driver-v2-2-b51ee086aaf5@fairphone.com>
 <aX6whqw7XyaKMd9m@google.com>
 <472d7db3-db34-4966-aa17-588e1153ba12@oss.qualcomm.com>
In-Reply-To: <472d7db3-db34-4966-aa17-588e1153ba12@oss.qualcomm.com>

Hi Konrad,

On Mon Feb 2, 2026 at 11:12 AM CET, Konrad Dybcio wrote:
> On 2/1/26 2:49 AM, Dmitry Torokhov wrote:
>> Hi Griffin,
>>=20
>> On Wed, Jan 28, 2026 at 04:51:14PM +0100, Griffin Kroah-Hartman wrote:
>>> @@ -717,9 +746,19 @@ static int aw86927_detect(struct aw86927_data *hap=
tics)
>>> =20
>>>  	chip_id =3D be16_to_cpu(read_buf);
>>> =20
>>> -	if (chip_id !=3D AW86927_CHIPID) {
>>> -		dev_err(haptics->dev, "Unexpected CHIPID value 0x%x\n", chip_id);
>>> -		return -ENODEV;
>>> +	switch (haptics->model) {
>>> +	case AW86927:
>>> +		if (chip_id !=3D AW86927_CHIPID) {
>>> +			dev_err(haptics->dev, "Unexpected CHIPID value 0x%x\n", chip_id);
>>> +			return -ENODEV;
>>> +		}
>>=20
>> If we are able to query chip ID why do we need to have separate
>> compatibles? I would define chip data structure with differences between
>> variants and assign and use it instead of having separate compatible.
>
> dt-bindings guidelines explicitly call for this, a chipid comparison
> then works as a safety net

Are you saying, that

1. we should enforce dt-bindings =3D=3D CHIP_ID (what's currently done)

or

2. we should have both compatibles with no handling based on compatible,
   but only use CHIP_ID at runtime to change behavior

Regards
Luca
