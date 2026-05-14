Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D5140DFCB
	for <linux-input@vger.kernel.org>; Thu, 14 May 2026 15:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778770856; cv=pass; b=G4F38x4Jwkom2An9YpRkkH93YJRKisrCPGaeaSmpp25YRvOjohj18w97qYX4ljJQqS7Xr5M86EFNG64qkeH2RW6iuBucuC3RVfzwYTbdCRxISdmsBPUdXMx5fsf/MGtMWCrcUSW/oooQTSKerEqnVpSPKCPI3mrWq0w6x752ppE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778770856; c=relaxed/simple;
	bh=93DcpqUrrQy53jqzjaoGf20XgLdTeD3S0fyJqO+62YM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TDx5nByqPJbnjfWzavY5+/JI8GCa0mm1GfK2GAMvWp43FWN7NfLZcBTAeJqvLf31IiAci025c42VR8UBT3KvNoPX4VCfEPkMWjhBFbOvJ0ylJ0pPtt4wzxH3yelMsFI582fLF0g+mElr6DMdK6o+l59EYn2nZfRjRvQmdQNdaEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQ2oUUhU; arc=pass smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQ2oUUhU"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2f03d6cf77bso9154349eec.0
        for <linux-input@vger.kernel.org>; Thu, 14 May 2026 08:00:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778770853; cv=none;
        d=google.com; s=arc-20240605;
        b=UGj4W3WjkwKL/toLTa25rPlV++WrlkqnZ8TMNU0GWxsu13wsLEElC1lr7yBPXurRW/
         WTHYa5cF8V7KBXgWUHWEbVSsXNVR/YbqY467I7O+0dm1QqOjeOGZ9MxAphNbNuC8WTBp
         atFxDD2SyeXsXmGID2pbQNDE1VpOuXRdEZjonKgiVKWJBPSIWm6HPrIWKv7cBXCaMmIp
         AZU138vDgXcFxhZ+DhVoO8cXtvKYUtChJLeN1LMiVZ+M+Deimq8aRmu5XiJnprXkLtGm
         C+c3PdIyQ2BamcPatpj16cnuPcTXS+KoUA+kpjqMxQLhKXNoXkYy7i8v0VcFezJn9gE5
         wXkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gYE8+9FvfLSVbf4nQgrf6hhDRemavqQW+ej9r6AR/Hk=;
        fh=g7bumctVg4vNh2KBEVmWuD57N/c/2hviyhY5GusTmnc=;
        b=hlRlctpf8U/ic5ORno8SWYkyfUjlRANQJu8AePK84va9pZqW7hks7ZHttcWTr02KlR
         C05hhD/6sqt3lfWLyzITtfsyP7Iul65U/ioKW8Blv9zPtBuCkQY5j93MGzvUaRJeNz/2
         REw7yQ70pIG2ITEz6FNJ+D32q0bJslAHQA5q6HI1vSaatMqmz9uWrtnJNR1cm3WR/sDu
         t2ZJ2MtWK4j7Ym33r3ksOc/bTwD+RXbt4zFXcKdfl+y8nI5OKCL/i1X0Om3W65W8IDQL
         LioT2D87RMm34paJaanQHPOJRopAiWGqvSUlre4wh0u0TchoWnzSENeoQmNnp6eRnOww
         C/uQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778770853; x=1779375653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gYE8+9FvfLSVbf4nQgrf6hhDRemavqQW+ej9r6AR/Hk=;
        b=VQ2oUUhUBTmgMzOS2UcnlF6x0o5Ihs3yZURI1TpWUybDGYjIgISZU5lVs45N5qiT9c
         Ka2BNB8vw1Bn5iySjsiNYoiGozmFpnKwyvz7Q00wxnEuWFSMwsVRfZlzeOMwWZaa64hp
         ciQof+sARZuwCNj1TqnDKCcaHXwwZdicDAqPyraLdHOt21+TH5OyTR199Oyc1aoSo/q2
         atDqpElbHz923dLXZsBzpbEeeH6Izatc01M/ObCYo4/sKRE9ZFwbrbdxDfZcali5d+wF
         ZYGigFAxITAcaUcJkZe3Oy+DIfhd/UBZ+p4KNgssbr406nkCMR/MQOWL5+tNbfNUiquD
         cQpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778770853; x=1779375653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gYE8+9FvfLSVbf4nQgrf6hhDRemavqQW+ej9r6AR/Hk=;
        b=GrcrwqXgsj1bd2UtBSFXExdVfqRGnaRwZK/RPdMjrfwp4puV8nA87TOfLKQEGZZCQ7
         apqGm3qDmKgkNrrE8DfgMV7EhhVo36aXBeBSPVjdgZlrcylalVKlEC0jkvXnH4I1zkO4
         tfgI2gfLR1N5o6Mb7AyxQP3j2DF9kAkJEuSZrqqrcwA13hgwTJVeHNTWi/4RHTQK0+KV
         znQubQeWAyuYf0ipnKM9SPMDMt1kX0GMByDX5OwWx4hiOXnFkeXTTdj8VPIe40v/bNGH
         Uc4muzMmkW5+OuduBE+ky3tDe/mfUcuyxHSIGEAWNmgk7G/DSdFF0+Z0JcHUTtW32nuH
         lu5Q==
X-Forwarded-Encrypted: i=1; AFNElJ+DbUfy36FRaix2HL/y2WnE9cF/gmrcg3i2PH3azbEtHIyKz1ydjq5oajv/rY38YlPwCQM0eQmJmRtHcg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwBJ+dfRO8/LFA+AP/DXhhPd32Bfz3cQ3vo/8gT7VB5MhIyznF/
	QgR4a/5w2pX29nqi8ZqShbteM+b3+V4CGLpVl7+kLkKSYApdJz/YgrjsTLt9uVp91H4TByE1+/I
	OCo3IJHh+CyD16M3sdGg6rJ5EZ42eNew=
X-Gm-Gg: Acq92OEVEjN4GRnScFbwl58qU+nqMG1V6zXwZ12Ac5Le4Pp1Tos26lW9d/Gz9CxoBgT
	RdIjVzb1POWqNG2WWuUJuu5H8lM3az+2aycqQxHFFrKH1pluQ18Q6PjGNATGp1SxCjAA3OJ/t21
	opHsG663+j/1BqwHdd7xE7j9EYbsL4qjjCZO5JLpPYDQmXEvVTeMy+DHfRTRJrS+y3VtyDmbLsc
	J+2DeDws/29YA4uvjV4eRjg2zi2ReFX0So45o7+TmrLGSlXteWKEbuF2/7je/+oKHH1P12uD7Ug
	1nf0hwHm
X-Received: by 2002:a05:7300:6c28:b0:2b7:38cf:c2fd with SMTP id
 5a478bee46e88-30119f59550mr4891365eec.26.1778770852303; Thu, 14 May 2026
 08:00:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512102445.55372-1-clamor95@gmail.com> <20260512102445.55372-2-clamor95@gmail.com>
 <20260514145541.GB472306-robh@kernel.org>
In-Reply-To: <20260514145541.GB472306-robh@kernel.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 14 May 2026 18:00:41 +0300
X-Gm-Features: AVHnY4Kxlgcuop2UxuHVvEYceHjbSEBsXZDcmFkiB8-pvvFXvr2T37E9jTAUG7c
Message-ID: <CAPVz0n2JVUh+5aLwDRNpuT4HMznz0XrDZ-aB6Xvm+1UibPjrBg@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: input: Document Imagis ISA1200 haptic
 motor driver
To: Rob Herring <robh@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>, linux-input@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 14 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 17:5=
5 Rob Herring <robh@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Tue, May 12, 2026 at 01:24:44PM +0300, Svyatoslav Ryhel wrote:
> > Document the Imagis ISA1200 haptic motor driver, used primarily in mobi=
le
> > handheld devices and capable of supporting up to two motors.
> >
> > The exact datasheet for the ISA1200 is not available; all data was mode=
led
> > based on available downstream kernel sources for various devices and
> > fragments of information scattered across the internet.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  .../bindings/input/imagis,isa1200.yaml        | 140 ++++++++++++++++++
> >  1 file changed, 140 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/input/imagis,isa1=
200.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/input/imagis,isa1200.yam=
l b/Documentation/devicetree/bindings/input/imagis,isa1200.yaml
> > new file mode 100644
> > index 000000000000..bbe6f99d39c1
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/input/imagis,isa1200.yaml
> > @@ -0,0 +1,140 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/input/imagis,isa1200.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Imagis ISA1200 haptic motor driver
> > +
> > +maintainers:
> > +  - Svyatoslav Ryhel <clamor95@gmail.com>
> > +  - Linus Walleij <linusw@kernel.org>
> > +
> > +description:
> > +  The ISA1200 is a high-performance enhanced haptic motor driver desig=
ned
> > +  for mobile hand-held devices. It supports various voltages for both =
ERM
> > +  (Eccentric Rotating Mass) and LRA (Linear Resonant Actuator) type
> > +  actuators. Thanks to an embedded LDO, battery power can be used dire=
ctly
> > +  in handheld applications.
> > +
> > +properties:
> > +  compatible:
> > +    const: imagis,isa1200
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  control-gpios:
> > +    description:
> > +      One or two GPIOs flagged as active high linked to HEN and LEN pi=
ns
>
>        minItems: 1
>

In theory there may be no GPIOs and both pins can be hooked to power.
This is unlikely scenario but since it is possible I did not set
minItems and did not make control-gpios a required property.

> With that,
>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
>
> > +    maxItems: 2
