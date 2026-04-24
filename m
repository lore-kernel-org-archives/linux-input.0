Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C295F363086
	for <linux-input@vger.kernel.org>; Fri, 24 Apr 2026 16:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777046484; cv=pass; b=dO1Mwc++bV6ELZbj3RkuwQeM33pEYqvRVn+rzWG0+qff2cEAOkKsZfsOXVgq3a/pC2YKT72h5DQgZpYJTFHdjmqdI9V5PjxDGx0wJa6VOVNkCxNntGQ9xhQrpDCrvpzvP5W+hfeTJDtyjM2gOt8II4d/O0wzmlVUntPai4xpoH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777046484; c=relaxed/simple;
	bh=IhksofQUr74ZsxiIixsYA9xW8rryL44gahMx0PQ5N/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e5/FyA2RGQh3xE+OWxucHHrnhWljabo0DVD7P+93+arIaeyqLdgzPrA2oPNdAWf0yfIjYWAQj2NifB2XmqCloR0ooZ2S1y7Y9aq9PFUIaIrAi5l4djsAYb70v7ktncGECFeZ+x2IMnOBbKvQV7VW8RCfx/aUP3ZpJFy27qcjs+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J+UKFEdH; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+UKFEdH"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-677f7c29af6so4569998a12.2
        for <linux-input@vger.kernel.org>; Fri, 24 Apr 2026 09:01:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777046481; cv=none;
        d=google.com; s=arc-20240605;
        b=lTCXLDh/ZW5Uf0VJlOshcYglYWh4RKYzu+KvwWLUEKFkRg7nIXgdkPzdgYK1Br0gB6
         lzcv8A/hpp801pQCuI4OGWJ6ta1OWdmXNg6FV9LcvXSrx8MtPdkhTw8OFRK+wLX1xFzA
         xNrhT8kTO2yKN60LiZYeCW+2OLlOSdkPYo+j/vwlt6b3BwVm+FTAvYIhOV9ILZWwKFO1
         CwfLUWWw2KlL47tfGiLEw8Q4iCiIYgCWaOqoXv5tmFi4VjtcdcrFcjL2nU/QsC3KSx47
         b1Lv4ZbCd8tKoLV3uAfhf1SO7ed471AC5qlQFdwpaKKVyS7ciFmPG69XnZrM78Kkbtza
         FURQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IhksofQUr74ZsxiIixsYA9xW8rryL44gahMx0PQ5N/Q=;
        fh=h8psd4yqRCBOEjCqGKoiAxBPeV6KVwmZwkOnvHqkIz8=;
        b=MUFkvxN40dYjhKmuuc7YBFxiLUs27EYL6GdHVHKrM2q3wzhp6hYV3qODrAZbsVNCTN
         q6+IpWwox9gVPJYqS7+3POOewpeQqwHmMx6kzuJAmCf5e9KrxLTA2BCj/oqKV+OgS0gf
         a7DCag9hzGYIqTe/rezrhN1b/MF92fMOq2IjKnBuWIDp1p7G8rF2O+rTcP34TGPvEDI/
         LCWIj9wDDIUxQfcb1z7CPPFX/n4r7qEQ52Q6z/xXzdYyHC/QBiZvStTplalAhNKjSdCp
         J4Y4S+MCi4zw8lc+Wmu8UaI1fqh25ba1n2Gsa5L7GE8RaH6QwfpBb3Zx1WVNFg/Ch12H
         5KsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777046481; x=1777651281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IhksofQUr74ZsxiIixsYA9xW8rryL44gahMx0PQ5N/Q=;
        b=J+UKFEdH4Hl+bApboyrnPrZrSb+FjwkbhbHvqHIKWeZFKONM67U46eDgAvc+Ejswap
         +I0lW/NUWlDdIXMG1D+vOusSYhOZW1kqa2JGcyS+3XcGCPZ9cztfLmMy0DejHzzEKMzx
         g6O1E7ZE3NQhl2DE01M+KT5wi3mX/+m72kT7mDPyZ4Lh5eB6OyGujS+ZTUMsnxDkPROZ
         sOYI94IWbzvtmWCexhJt57zr/behzq2bQeSFEqqIlmx6+5nmSoLHueGEzJ3Cu8mOWgN6
         M2uUgy71y0xLGo3VrFOu39n8ExhE6Uea0J5sboEcJgu/6QDbAfR2GGc3bJlECVMtXYFy
         mweA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777046481; x=1777651281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IhksofQUr74ZsxiIixsYA9xW8rryL44gahMx0PQ5N/Q=;
        b=a1ufJexA0hgdqbQoEWgl2ZbH3yQsc9NdFTOtaB/VbRPob01XDvTw9L1h3FKpBgz7kx
         du7KhgvHrUkjlpZFsrBiQEA0xKTrJZh14N8koyVwICD6lyE10i7rSApvQw3jumnQDYIE
         Vcf8hXWxoDyWcP5F46S4EydseRLFoR/3YTKYrG/bPY1VwMPVN3+Gl1HFyfv+5e44g1ol
         xkJW2MBW9vnIDX078ZgIPDl8vVOT13wUjcSOgfj1KO6Feyqp/oUX44lhT9vlFjNoiMsb
         iuXmUVWRV6SkzZILcEde0tWjPqJGTCEzNfmdj5ZuVdzx10HqputO1/LKvq2hAAN0xRfj
         cs0A==
X-Forwarded-Encrypted: i=1; AFNElJ/8pYJrxQSg5WWhfxiEPhSqVJdxYRtN/FtMRBoHiwOaA/1Qu52nGN1cyAvJzNkPqzn9+7zxGWbqU5E44w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyqvW9NwP/E67n70WTn3bBzuSfzvYJUFJK/et9BbXgh1vd6UqVi
	1waJYOcxKQUm2qvUdJGsR6K3j8R/EXpf0w9VKxWhv4mWPffgx2W5YtO6G9wFw7u+iGKr5/9yfjU
	yqkYZk0+Q17vf1y7cblwekaiGJmuFje4=
X-Gm-Gg: AeBDieuJ9ASM36XQcaRMJhgSjr1V4LGZw+6Dg2cIaTPvWtmfSe/a1QNlWXtpu+C7Yot
	smH4gwG1oyywAZkt8vTnTlTR2v7VNJ16BH+We7WWlzv32ocCzp5YKKpuV7SwUDRrVcosfGeZc/+
	kG8lZ8xIfOrEmXwka5DFItvfWAhREa0Lx1Ss6T7nhgQqgE441EghUyg3Z1Rb3F2nulA/FijbpRA
	e4N+A78PZWw/W0IJ8FbvG/EOsktLkj0un868bk5fAs1kzXfAPEmxJmQPDZMij0Wpd1q0criqMan
	OaMW11OpAD4YhAXPan/GMvnCYEuINw==
X-Received: by 2002:a17:907:d38c:b0:b9c:3d56:e4ec with SMTP id
 a640c23a62f3a-ba41a91de15mr1571230666b.24.1777046480779; Fri, 24 Apr 2026
 09:01:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424071305.89503-1-clamor95@gmail.com> <20260424071305.89503-3-clamor95@gmail.com>
 <aeuMn2w3kSUl-wxF@google.com>
In-Reply-To: <aeuMn2w3kSUl-wxF@google.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 24 Apr 2026 19:01:08 +0300
X-Gm-Features: AQROBzA4BNjbA3iaTiG29FMhO3DarZS80TQsSo5ZGABEE-PRS6jsddYwfXqqpLA
Message-ID: <CAPVz0n1POe_YuA+RyvLLUdO2D526hb_YQUXJb72Y1h6mW8M6kQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] Input: isa1200 - new driver for Imagis ISA1200
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>, linux-input@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D1=82, 24 =D0=BA=D0=B2=D1=96=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 18:3=
1 Dmitry Torokhov <dmitry.torokhov@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Fri, Apr 24, 2026 at 10:13:05AM +0300, Svyatoslav Ryhel wrote:
> > From: Linus Walleij <linusw@kernel.org>
> >
> > The ISA1200 is a haptic feedback unit from Imagis Technology using two
> > motors for haptic feedback in mobile phones. Used in many mobile device=
s
> > c. 2012 including Samsung Galxy S Advance GT-I9070 (Janice), Samsung Be=
am
> > GT-I8350 (Gavini), LG Optimus 4X P880 and LG Optimus Vu P895.
> >
> > The exact datasheet for the ISA1200 is not available; all data was mode=
led
> > based on available downstream kernel sources for various devices and
> > fragments of information scattered across the internet.
> >
> > Signed-off-by: Linus Walleij <linusw@kernel.org>
> > Co-developed-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
>
> There are a bunch of valid sashiko comments, please address them:
>
> https://sashiko.dev/#/patchset/20260424071305.89503-1-clamor95%40gmail.co=
m
>
> Thanks.
>

Acknowledged, thank you.

> --
> Dmitry
