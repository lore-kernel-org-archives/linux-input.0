Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01263612C3
	for <linux-input@vger.kernel.org>; Tue, 10 Feb 2026 11:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770721721; cv=pass; b=OtwftnzDcL/UebJAHeCrBww5FxwRagmbTIxt5WdsQlyhbp3G5dGkTXEO31e+bS/PjIdPJo/CQmu2O0ObYVG3W7JGGrPTFbpYn4V9Ac2hRWmXi8ZxKR0fOvJTDfhdUZur3/tIDkk8Yil9QypPvL+Lzgo8tuY2X+NZ6XEP0WjXYyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770721721; c=relaxed/simple;
	bh=DnsV4kdqPf78qKYVoTe/TUUjv7824SUtaxVS44yRLuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lTwoMqdACZiXirwpghQakYhoYKv9lkd5vVQ2vi6VSjDZ2uaXRISD3uPMVu2A0pycQjvm3SHGGQuV3WLnoxvWH7+24kO/5RO7eU5pMUl628o6nEACcT1GpWelwI/6a3IuUbYpKr3rSH29I6MeOnX5WQY2J21oL6DFbEn3i1YWpvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L0cvQr19; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0cvQr19"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4359108fd24so3480219f8f.2
        for <linux-input@vger.kernel.org>; Tue, 10 Feb 2026 03:08:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770721718; cv=none;
        d=google.com; s=arc-20240605;
        b=JcGLsnHwpogdOXm0TiznSy13NNLpX5Tw3hLiI+OjsgCwUzzzOGblKWT7fwAzp/ua6Z
         fv9vyX3rHriFZ7WxheI3CBpDzc5onRWXoB+3SyOjK1sh9lE7iYqFkpGntS4lr6DNEqzQ
         Iwe0tS5Ytlx9ZaqYwazECF3r0OD5+J1tcKyV3Oh6Gpwd9XLr54WjFB3gTddRV1j2RN+v
         wUBAX2ZLL+Du7HZMGuSikdSIBc/5+paWSLk/9tFs5J7FMZbvYl9Nr9iB0JvThF9mfXlB
         srxj7KNYL2uHEm6rMfepD8b1t90yKvyuS2sHq3mjPCkohFoQ36sKS4SVIMSWxDpIJtzJ
         Y7UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BJ6krYUCPVWLKmyB26g/CoPtPWOTOugrzVrcwkwqGB8=;
        fh=4FmpPkHxRJq8rEM6UFwHocSA+o6qewiNuvdGTLGEFKk=;
        b=NoJ3JF+dgMAkbzpmcsS+c+TZKBt5nvsz9EAxJZQBap0GcbgK6yOSieYP9oMxnfckYc
         HBfnJUyOtRWxmxWNhtpnJ2j03T+a//glqMcsGih64tb2gNx5/JeDk9RL+xBDMD7Lkhg8
         FNlrendxYTd1kptGfgfSYzB943JSllAtkw/TjrAsFPJgGH6rywQXvRD68Ip8CQVnES9k
         ZvmSnRQ/pj9Lg99cz0lSWzI2Qo3+TvsQ/yB6pphEsjnCY2wDm6nmKb6JJU+bztqUf66c
         PSyYB8QZdSg+645Uw8zRisWQBFXMkM4l90+u70otx6Yznh7lXxldZJXaMCCH5b7P0Qnk
         OnSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770721718; x=1771326518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJ6krYUCPVWLKmyB26g/CoPtPWOTOugrzVrcwkwqGB8=;
        b=L0cvQr19hY9VW5mKzGZJ/o1vKWSBpOGi2hfnXJbiDRdYxGOJIk53nIh99jgunNfmLM
         2TJXWWOJov6iYeMExb5WSZDXDrA48y3HSkb3/I8zittTabOsHxzSMHCvwpHt0Tlg79Hf
         uY2kw7+GwlR3z74bZS7CTH0O7Kvw2wybgVi+HDYHEX6ZgT4gCW0Si5wZmw2SekwiI8Lq
         RDEr0YZPCwMUb0fbMoB/YGmP+4mlh/+xIW3jLMucyRSJHZMOB8m9F2EicFRY8ne72tJS
         lD5Yf16xZl+YoagE6d/iRURAAKpODqnDcZ3mjzfGbKK9q1UohEGEzDCsGF/YaUsi/RAC
         pkXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770721718; x=1771326518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BJ6krYUCPVWLKmyB26g/CoPtPWOTOugrzVrcwkwqGB8=;
        b=fpWsSlLoAjdmiWdQPmZniluxVX2rnKu+RXE39IUMJUKVcDvAGazp5WSI64dfgnFuBQ
         qjhqEXyBxwY6XuL1/71oHECQwFKLiCJtdTAFs032WYkjpkhVFqkV4Vt1PkXMaECXCVZj
         Bt5kY3MZ6v+wTuMVKrn0XoF9XBuEaxObElzoBlX1yBxmOx06GqoIecIUZB8ptlb6GbRY
         6EN90A+OfQ/2bBy/T97wWYX2OX/Tt21DLXX0fqvPfVIutW34HHdd8yWmUNJ0iFE7FvYr
         U8ESGFD3PCOE1Zev5/EIMaIWwqy76mujdGM0zwRyvMslBX19glRBD92Z+Cj9ZkVdxMgx
         RRvg==
X-Forwarded-Encrypted: i=1; AJvYcCVXsTA9afAFkmDK79UxRsfZa6sGbOCzVlJQMKBi3c0yMwBpuC57XDwwOSZ6hHLP3LDQpMe4EAuU43pwdg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx0F4o8/s4uR2PJ0jydxWfE5Lc2NFcPskkHqlhtiuBUmYUCBr8
	W+lLhp8a3RaEo/Ddn1cm3Yvm9zIwnQX7fLmEUp/skWKjwRj7pwgk/U34w85KCdCuYONfMUyIrrB
	EzdSbyUtU+EVMoy8C+HlT1+5F4f1JnLA=
X-Gm-Gg: AZuq6aJxFrg0e2tPT+oSD+FKt0RpTcl9nJm6FSfDOh0LbjaV7O6nt+DUJM7hu6GY0Eh
	BGDSCn3zbq25b+nb/ZU9OorNNauToqz4oj00iVPYhJ3S4GlubZPq7dFcVCyQLeGIFDuiLsV4WWY
	08iEPaP4CtL1r9fx8eL92fWmkxQ3d/VgGRYlNWQGPHtoa99DsOA8tMPvN/otI7pUsobWWJjcbUH
	Enq/bcO5+REfLt6UBD8DrqwW6QrkNW5aTJ4lBHu160vYlODehA0krzUHf5dCruaUpy48Cuvkfit
	G/L3GuCj
X-Received: by 2002:a05:6000:400a:b0:435:729b:c390 with SMTP id
 ffacd0b85a97d-4362968a6c7mr22308855f8f.47.1770721718045; Tue, 10 Feb 2026
 03:08:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209104407.116426-1-clamor95@gmail.com> <20260209104407.116426-2-clamor95@gmail.com>
 <20260210-hidden-swinging-galago-fdcfa3@quoll> <CAPVz0n3Pzvzt+LmOH_peCtpx8DP2-GiRv--6-ppQUaa51AXRFw@mail.gmail.com>
 <e73d6634-7f31-4dcf-87dd-c8192e7e66c1@kernel.org>
In-Reply-To: <e73d6634-7f31-4dcf-87dd-c8192e7e66c1@kernel.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 10 Feb 2026 13:08:26 +0200
X-Gm-Features: AZwV_Qhhw-p8mspFJSHcPKgZtzcZfKKnKUimZu9snSZVDGxYLnU4WrmfgQmZu2E
Message-ID: <CAPVz0n1o9vpCfbgFhLOKC4mj30js-P-0ptMsZxHTFPjFDB=Y9Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] dt-bindings: misc: document ASUS Transformers EC DockRAM
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sebastian Reichel <sre@kernel.org>, =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	Ion Agorria <ion@agorria.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 10 =D0=BB=D1=8E=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 12:50 Krzy=
sztof Kozlowski <krzk@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On 10/02/2026 10:42, Svyatoslav Ryhel wrote:
> > =D0=B2=D1=82, 10 =D0=BB=D1=8E=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 11:25 =
Krzysztof Kozlowski <krzk@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >>
> >> On Mon, Feb 09, 2026 at 12:43:59PM +0200, Svyatoslav Ryhel wrote:
> >>> Documenting an I2C device used in conjunction with the EC on ASUS
> >>> Transformers. The main function of DockRAM (the name used by downstre=
am
> >>> ASUS sources) is to provide power-related functions, such as battery =
and
> >>> charger communication. The device is exposed as an individual entity
> >>> because multiple embedded controllers can utilize the same DockRAM
> >>> instance.
> >>>
> >>> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> >>> ---
> >>>  .../bindings/misc/asus,dockram.yaml           | 40 +++++++++++++++++=
++
> >>>  1 file changed, 40 insertions(+)
> >>>  create mode 100644 Documentation/devicetree/bindings/misc/asus,dockr=
am.yaml
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/misc/asus,dockram.yaml=
 b/Documentation/devicetree/bindings/misc/asus,dockram.yaml
> >>> new file mode 100644
> >>> index 000000000000..0cfde619ba01
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/misc/asus,dockram.yaml
> >>
> >> Not a misc device. Find appropriate place, e.g. for EC or docking or
> >> laptop devices or power-related.
> >>
> >
> > Why not misc? be more specific pls where you want it to be.
>
> Because there is no such device as "misc". Otherwise explain me what
> sort of device is "misc".
>
> I already wrote where I want it to be placed. You keep bouncing
> questions pointlessly, even when given exact request.
>

Among your list only EC exists. There are no docking or laptop devices
or power-related. Hence asking.

>
> >
> >>> @@ -0,0 +1,40 @@
> >>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> >>> +%YAML 1.2
> >>> +---
> >>> +$id: http://devicetree.org/schemas/misc/asus,dockram.yaml#
> >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>> +
> >>> +title: Asus Transformer EC DockRAM
> >>> +
> >>> +maintainers:
> >>> +  - Svyatoslav Ryhel <clamor95@gmail.com>
> >>> +
> >>> +description:
> >>> +  Dedicated i2c device used to provide power related functions of th=
e
> >>> +  embedded controller used in ASUS Transformer device family.
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    const: asus,dockram
> >>
> >> Way too generic compatible. You are not documenting here all ASUS
> >> laptops/devices dockram. For example this implies dockram is also on
> >> ASUS Vivobook... or on any other asus device.
> >>
> >
> > Asus were not so generous to provide more specific data, they call
> > this device dockram in their sources.
>
>
>
> >
> >>> +
> >>> +  reg:
> >>> +    maxItems: 1
> >>> +
> >>> +required:
> >>> +  - compatible
> >>> +  - reg
> >>> +
> >>
> >> Device looks weirdly empty. Probably you have it only to instantiate I=
2C
> >> handle, so what you really wanted is i2c-parent. This is not a real
> >> device.
> >>
> >
> > WDYM? it is a real physical i2c device located on a i2c bus and probed
> > by i2c driver just fine. Maybe you will deny RTC being a real device
>
> Driver does not matter here.
>

It seems that you see a "forbidden" word and tear it out of context.

> > like it was done for example for max77663 which now causes a massive
> > issues since it can occupy different i2c addresses?
>
> Then describe what is the device here. So far it looks exactly like
> "ec-dock" for which you already have a binding.
>

Wrong, it has nothing to do with "ec-dock" specifically. It is has a
pretty discrete description. It used to provide power related
functions of the embedded controller used in ASUS Transformer device
family. To access to battery stats, charger status, leds control. Can
be used by multiple controllers at once (like on TF701T or TF600T)

> Best regards,
> Krzysztof
