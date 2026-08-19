Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C2C395AD2
	for <linux-input@vger.kernel.org>; Wed, 19 Aug 2026 09:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787130775; cv=pass; b=mZMSKAUMCyTE5rj6jMZ+qc1Gt1cfEo4bObabD5VpPOsSPT93Yoav7FqPnZdCdvDGgfAzEYIpwftiTPg+z9u/lcm3UCuc2JDFiik+Lgu/l/wzzQAk9r6Gyl4+X220BJ0DLwVZCeTdJpdD7sYG6eSL3mGoZZeHyjC9v03Qd8C+BcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787130775; c=relaxed/simple;
	bh=DCnsy73dKFmBz5cXqnv5Jnu6rHCJzPmOacFK6Spob4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gIpEthEQ6KmdDdHsp9VH9L7d9aZFQxxluc6Z3x2hPjCPpkPGVNDC2jhTzmFPe8Ms+ZyaHZ1iuVYXTsdzfF/gyPQoeUQD5ywzj0JNav9/pa4AdMwQbNALYljSwPxus7/ueaJaGa0cqi5pKX3v63VmQm0zXa3vcNDwJdp8o6uVyWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LjxOquGL; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjxOquGL"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c2074710751so125940866b.1
        for <linux-input@vger.kernel.org>; Wed, 19 Aug 2026 02:12:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787130770; cv=none;
        d=google.com; s=arc-20260327;
        b=ieEPgtF1r9SUYmfjX5qFXGtLHluRRt9NxaFxMsSUC2pl3l48qK/OlS/mFjBdgR8+sf
         98e8YRSmWvndKXwShmX/DX6YPh3f9VSJsiFEb38DPJ7hhIu4lLx8VLqnVjv846wWxiAD
         QKxGS1LECKt6e4nDG3oAm72YE8A/MUKj9HN6x1NIp3zPhjkSxU16zWgxyiaXmKCI9gpb
         h3yoeKXBkUQGaHCfdOt2GxgkjAZXk8jxAZGpi4Tp5DsHVy4TL2QoPFd1n1ok2PNM9f8W
         LWBLRa6whc28bIILG4Z6VIoRxbJ66Yz2KfCK26sTf8l6VCbPnBdbHYVRZ7pyguFEIA9N
         PeIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xQVqiPHj9gddxJ2oxHXBLJll0uYkJ3jqiGdmF8ls390=;
        fh=5larljsHPJhhgXBvJL6r5PskOT1mknGTX7B21BdUr4s=;
        b=ToNJ1JQA4WEo0SQD/zjiyu8mDZZcZRslJ4rB9Uzxxkzb1C36FmRLRksyJ+faweJr6h
         twoVOPYoY2m45ER1gz5UMKz579jKEoIlg96LDOQd1lCzRaKdQl6LZAGR82pL9vJqrEFM
         NgbctCc7BmOzZUcIfTq2ykdC3v4TYE66ES6pG+OiLphnTAsKr3VakbKRJ5gK24qZqcvV
         lcdfLtuPIruyzHho6yyIfDPyJrST41QsCvyp1rmZu3y4RMK4bjr+vPNWEDJsMIhmk3MT
         XRVTldZNsdQ3XjVZO39yt6e+czgpfzg0WygVd8HJdQGshf6GnmKJ+4/uWCv5I6QezSjx
         64zw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787130770; x=1787735570; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xQVqiPHj9gddxJ2oxHXBLJll0uYkJ3jqiGdmF8ls390=;
        b=LjxOquGL2ecAPBMN0uLeQ1Y6Nyt+22TRBCI6KJrDILezgOzpwOaQZMSHdwmzlTwuzh
         lOTy9neusGIA3v08zPSEpPVhfQaC280TDqyUchmqUNCmR2fxaKMi1fxO83nn6dMqFlsl
         inxU/9NLTvBmhbdAhBSC6b+F7mopvymlSZ/MBsek0WamxWpfFOILritxOOnAFrV/q+Yd
         GQWUDAs2Goe/auLnAeXZjIx2M74bCbylfaZmc++77qxMpUpvYZer5zEQss2eCxa1nhRT
         dhUcQt/BWFIT+YH620RIs1yiLDgFNHDQdc8gJfSuUPbDzPVLbfj0aGdsTkAe/yFa2jXA
         LEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787130770; x=1787735570;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xQVqiPHj9gddxJ2oxHXBLJll0uYkJ3jqiGdmF8ls390=;
        b=AZCHTFIABxCr+ZaI6HJo5FU8LbIPji4QRG9c5QLYZnL0J+RwRFRP4xCy0eM7+uGwXG
         K43wUMmKn17Bd1W7Ia8PAM1scKTfN6yZRyo5LE5BgBerNS18IT83SevQLPg5oqtPfxLY
         7eqa6cUfDYohgelvtXdN4XV+Me13nUB0cfrunZ5UrfOhOiQE1NuHNOynKzLmPQaCzogb
         J1OE4KCv7YVfH2cVIJUZhoSHp+T67L2EyCJsFH1erQc4WLcQAq0I5z8AJEAAndfMITKe
         wZTFue2dplHRBrrr1j6KXyhsSIrApfdsBNpK+pTIhTG97lZvMwL6MpYBRHsBjO6jjAhy
         IaEw==
X-Gm-Message-State: AOJu0Yx8nlCksrGYV4+ljVMatz4phXaPoGeXTMtMg9E3H0tQ5fLJrObb
	uiEke4uA7RBcqFEQ7hf5HEbB301wtf0QAzEPH+/qqFKmh6gTFmW97FgH/WuSNpFWeT53fha30Py
	FGqO7EbzjxpYwWXgYwF4FhZkTfmmjI5M=
X-Gm-Gg: AR+sD12xdsTsEu9FtSdKouI1/oZ4tatALmR/3OLiadTffLoDaeHjCO+anmh5qq8Ne2i
	eMc+PPOTHqFWUX2YNjnYUeaqCpTI72iqQtJGCfp8rbyyuxusYV5H/V6pIOUJix8p8FCYT0Cc6CK
	sqxgCG4G0GUhgUkhoZRhwCVr4ZHW5QM3UEVLdBESruFYqv6O3x8V7Vuz/QWHJ1+yZAD6WGPTOzb
	TpwiXEnEqz3mOOA0/EqgajjtC9A7lkqKMxE/bm9NE7PexRnDLzig9sSUo8S0g5q/DIRMcY08qXM
	1i0KKxtkiC5VoOvZKdaneb9aVINnr45aC7HYzyzchGkVZVzjGW/gDsd/MePe+RxUbgz47cqDnxi
	pd6Y=
X-Received: by 2002:a17:907:c789:b0:c16:1227:e3d8 with SMTP id
 a640c23a62f3a-c242e22e276mr205170066b.13.1787130769901; Wed, 19 Aug 2026
 02:12:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721095654.429346-1-clamor95@gmail.com>
In-Reply-To: <20260721095654.429346-1-clamor95@gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 19 Aug 2026 12:12:36 +0300
X-Gm-Features: AcwNN1XqMUC5z69S8iGApPi6yHWon1mnJ-iyXKEJkZHOCPSd2FYry1N5od1LFfc
Message-ID: <CAPVz0n3u0D=0swsO4n6LROFurO=as1w-ZRwaje08BN9dY=JhXQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] mfd: cpcap: convert documentation to schema and
 add Mot board support
To: Lee Jones <lee@kernel.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
	Conor Dooley <conor+dt@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Svyatoslav Ryhel <clamor95@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 21 =D0=BB=D0=B8=D0=BF. 2026=E2=80=AF=D1=80. =D0=BE 12:57 Svya=
toslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> The initial goal was only to add support for the CPCAP used in the Mot
> Tegra20 board; however, since the documentation was already partially
> converted, I decided to complete the conversion to schema too.
>
> The CPCAP regulator, leds, rtc, pwrbutton and core files were converted
> from TXT to YAML while preserving the original structure. Mot board
> compatibility was added to the regulator and core schema. Since these
> were one-line patches, they were not separated into dedicated commits;
> however, the commit message notes this for both cases.
>
> Finally, the CPCAP MFD was slightly refactored to improve support for
> multiple subcell compositions.
>
> ---
> Changes in v2:
> - fixed code style
> - rtc conversion was picked, so patch dropped
> - added audio ports description into mfd schema
> - splitted schema conversion and compatible addition
> - minor style improvements and typo fixes
>
> Changes in v3:
> - added regulator node names list into pattern
> - filled spi_device_id with driver data
> - ADC patches were picked, so changes dropped
>
> Changes in v4:
> - dropped regulator patches (applied)
>
> Changes in v5:
> - switched to MFD_CELL_* macros
> - switched to use determinator of model
> - switched to spi_get_device_match_data
>
> Changes in v6:
> - removed address-cells and size-cells from main node
> - changed macros formatting and OF matches
> - factored out common devices and made device addition staged
> - dropped cpcap->variant check for 0
> - EINVAL > ENODEV in variant checking switch
>
> Changes in v7:
> - adjusted spi_device_id entries (name/driver_data)
> ---
>
> Svyatoslav Ryhel (6):
>   dt-bindings: leds: leds-cpcap: convert to DT schema
>   dt-bindings: input: cpcap-pwrbutton: convert to DT schema
>   dt-bindings: mfd: motorola-cpcap: convert to DT schema
>   dt-bindings: mfd: motorola-cpcap: document Mapphone and Mot CPCAP
>   mfd: motorola-cpcap: diverge configuration per-board
>   mfd: motorola-cpcap: add support for Mot CPCAP composition
>
>  .../bindings/input/cpcap-pwrbutton.txt        |  20 -
>  .../input/motorola,cpcap-pwrbutton.yaml       |  32 ++
>  .../devicetree/bindings/leds/leds-cpcap.txt   |  29 --
>  .../bindings/leds/motorola,cpcap-leds.yaml    |  42 ++
>  .../bindings/mfd/motorola,cpcap.yaml          | 408 ++++++++++++++++++
>  .../bindings/mfd/motorola-cpcap.txt           |  78 ----
>  drivers/mfd/motorola-cpcap.c                  | 143 +++---
>  include/linux/mfd/motorola-cpcap.h            |   7 +
>  8 files changed, 571 insertions(+), 188 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/input/cpcap-pwrbutt=
on.txt
>  create mode 100644 Documentation/devicetree/bindings/input/motorola,cpca=
p-pwrbutton.yaml
>  delete mode 100644 Documentation/devicetree/bindings/leds/leds-cpcap.txt
>  create mode 100644 Documentation/devicetree/bindings/leds/motorola,cpcap=
-leds.yaml
>  create mode 100644 Documentation/devicetree/bindings/mfd/motorola,cpcap.=
yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/motorola-cpcap.=
txt
>
> --
> 2.53.0
>

Hello Lee! May you please pick this patch set? I have included changes
asked by Rob and Uwe. Thank you!
