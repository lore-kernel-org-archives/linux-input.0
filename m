Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F408336A013
	for <linux-input@vger.kernel.org>; Wed, 11 Feb 2026 10:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770806912; cv=pass; b=sDAwalaVrhuEVK3ITywhu0f/Ef5U37GhjkhWnIErQOLfpO+z8JKWgKXj5HpyMBuoeEMIvkVhC2feVMPnuZmVxuDT5DkZQ7/YoM94bqmYQwa7bDIraW/q9qVVw52U4BgZGAj1ZhWPwAVozK4IMa4egQNP96oC9bi+OxqG7VJqyZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770806912; c=relaxed/simple;
	bh=goC3mIbNohckiF5ZYjrfvjxXcyQ5EbfvCJ7/+85hUuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NV7n2Pxk8vVTtpqBhq0S8VGXNVUPlpiqMTi4ap8QROWfwZSVWV2oF/SfADWgltpGQVU8liCqqy00MrGk+1p3GQG59gbFf2P34CBv1oxbw7f/Zfc7zmUiyHgP7kGtX1+8IsqqUfsn1O1M40NDPCGzZUERu0/RDVffmAugGmjiJ2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRL4uY83; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRL4uY83"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4362197d174so1235387f8f.3
        for <linux-input@vger.kernel.org>; Wed, 11 Feb 2026 02:48:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770806909; cv=none;
        d=google.com; s=arc-20240605;
        b=IBUF7gPFtkaNI2scTieaRLy2OACG31wkT9RrScraq8oyfcZ1kDBi3WgEixK6D5Uh15
         a31KgWmpqqBToIcEIjoYNZqRKV6Q//RhLw1oCiPR1adEWrp1av0L4KEuRGMgzidxfKLL
         nfVOfR1zIGs0btoo9atAe6gRGNg73SbmZGx11GdP7V+YQs2o1Ulq2Yge4oIk0WazwESy
         F98ZBj7lUCd7cRFvXAIZ/MxgsBW5z2lpkt9TBPtOpqsVCUeHYffNsg8qNzJSbtVXMI2y
         XXtM2o9Qi54uFM0Payen36gKTUk+qCd0x3EmrdoQW5qK8fSmZPaoIukRbiIzPJb/F+zz
         CYBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J2gBRwJor0x8FmOh8GyzyKNT5TNM+dtqzKR3kPMSD/A=;
        fh=Q5PI2/rNLhs2pdYUht8VqzNe6LuPhBMqrzTngTI3zfc=;
        b=KPIa+7Z89DaNJt/oQPz4OOcIcDXtLvklVsAEEP62muMs4l4o0H5IJYf8DS2dJaODze
         H7HOtM2Z0/uYa4WMm2iWSeYAZuFxM/WUpAjiXA8ZwLB7OQINTpIifozWzpaEhTOuqo98
         xJTbTPTfJGMjdMIRGodFYyFA3wd9a2gRZ7BjPXL/wPJfsTXbQY4VBnNdvsZDXicDZP+q
         mCJwA4oDcVQ9TtsFjHRfYfAx5AV1yQbmz4Qva1Lhyo5IaWpl1wp5a2SGR32iQmGLwMRO
         3Lk+7byrhcyEm96hchihuBkyDqbP/w4mDMeqyYeJd6poXDh8thCkB2MelJUii7/gLWjX
         9IoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770806909; x=1771411709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J2gBRwJor0x8FmOh8GyzyKNT5TNM+dtqzKR3kPMSD/A=;
        b=KRL4uY83VFKh79eYwywSsflLk7UhcCxSBevCn+ooQ3zf/ZOiVyAwA7LsGqN75vtnD9
         Gp/OaQuqqH2HwbQi28TheijoUEfT5V0YzhJJL8d/yffptZ0AxU2///H7bSEX+fW5EIy+
         7nspB6NMe1SU/uBs4oBctjJqQMHnoOEOEue1qVy5Ow2IhS9mz1FKMlKz4ZOCi+hajr4t
         B9t1FLLZNpM7rsGXKfOb292YixpPnQSEzjmc/zviMEO43BR/qr9iUzn9P687zMn04ik0
         UO+6EYGsTfkfC2TjDCaLk8qVPKIGM+6GayJarcsKBzjrBP7tvAgQsKK6so+/Op5f/WKC
         9WCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770806909; x=1771411709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J2gBRwJor0x8FmOh8GyzyKNT5TNM+dtqzKR3kPMSD/A=;
        b=eXtEW3UvDgZ0kHO7YV1YR9cBse1PJR3uznzKHus3SxOiQTZONcQ8Dc4O10E9ZH4GhC
         xq/3A0VVpl2ozEloEmbMIJF1qndRTQ2+tNLehpYJMl94HZRW+q2Ze+vDLaqOHcVyp7Ql
         neHu59L3/0QDsIgY6+j/skc2ugUjt2X3Gk58JVYLfUXNPIdXmDdeJSwDdZRVDJVtiUk7
         oyrCUkpTRITssseF9IAZCE3gKct4dFhtq1NHQKyG+W8ZQdc0dga8IwrdyYqoem704FK2
         LJVtuSVrHIfJzW2E3ELxUfpEXXeKq/wLgPsw9BfHpxLJEmMw7mYKMYEyKW+qAPK6EZ/O
         Ebkg==
X-Forwarded-Encrypted: i=1; AJvYcCU5lKu2kWPaETOarLAxhI7SnMlNrQXHxqeMMNOP9hthmcieQc6pnEtWHlbNaMlmRD63ykICPS5hlJPlrA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxaYQV3jDlzNAz1t0weO/p3eAe1N7WuLq4D1dLwqnT7LwMGvx4W
	K9O059H/+XbwDDF+zKAzg8QnHtQ9OhAxVvGHEpfNNBfLvPIWHsID3Lo4xUxWSBChVdmOjnAbovz
	jMfWgzgmx0FhtLzdkLnjKMbUXPz8MbVg=
X-Gm-Gg: AZuq6aLnBwSfb/3+WYKPG4AOMFty2JEiX2Q+YZYLElOEOJzy8vG3jBfx4siUyeuCraA
	dXLO5mIsvA/LYDT6aDdqN93C2M4+97YySJp+LBw/TmwOOy5Y5e/vZnSEogsBATa0vRUIum2Y7ud
	AvSjDECaCKHeAiEWX3S0pOCbUGzDSME2QyYEBSGlKjdB0iaXr1k5j1qx2EhnVRCWbRztYPpeZrb
	PTx6TuTds/m9emSB1M0K9y6w8vI0IyeAQ219sV7qAVyi7Fs+OLhUgMAlx3s5x+WA0apVsKpZ4r3
	aTrdVehc
X-Received: by 2002:a05:6000:3107:b0:435:9770:9eb8 with SMTP id
 ffacd0b85a97d-4362923fc0emr28798812f8f.25.1770806909126; Wed, 11 Feb 2026
 02:48:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209104407.116426-1-clamor95@gmail.com> <20260209104407.116426-4-clamor95@gmail.com>
 <20260210-sexy-grumpy-sambar-44edd2@quoll> <CAPVz0n3fizf=r58Fr4YQ6pnjHq5p-7yFz95obss6w6x0bfgnDg@mail.gmail.com>
 <d1973810-d3f5-4ed7-ba0f-6bf93c1c7f3d@kernel.org> <CAPVz0n1foyy9g7MAurSAyLCUHTzrPPu0ceqy9YpcDA9uzgjGng@mail.gmail.com>
 <cb91898e-10f1-4d64-bace-41bbed08179b@kernel.org> <CAPVz0n0O_uSAPYFtg8s+Ni0buyGJys6d0jEMob6SNWx-aeKUEw@mail.gmail.com>
 <dc7acd1e-91e8-492c-8665-cb680c6164fd@kernel.org> <CAPVz0n0u_0ZukcKXt0QpiyCMhWsg2VE-dE19wDCbRQvBvVOf+A@mail.gmail.com>
 <ec3b39d6-51ec-429d-b083-e5af2b4a9c65@kernel.org> <9dcc308d-f87d-4706-90ae-df3669aea224@kernel.org>
In-Reply-To: <9dcc308d-f87d-4706-90ae-df3669aea224@kernel.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 11 Feb 2026 12:48:16 +0200
X-Gm-Features: AZwV_QiRfznTx26RtaNIi_FievzuOy5_SC6hUakUwNSsN_ybyyiwQRTPmonDjZ8
Message-ID: <CAPVz0n0ULXAWnK0cJcuK-k9jO9JdqHutZ84bsgSDwGJUshgS+Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] dt-bindings: mfd: document ASUS Transformer EC
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

=D0=B2=D1=82, 10 =D0=BB=D1=8E=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 14:48 Krzy=
sztof Kozlowski <krzk@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On 10/02/2026 12:54, Krzysztof Kozlowski wrote:
> > On 10/02/2026 12:40, Svyatoslav Ryhel wrote:
> >>>>
> >>>> So you propose introduce a compatible for every single ec used in
> >>>> transformers instead of simply disable unpopulated functions? And ho=
w
> >>>> then battery and charger can reach monitored cell if they have no
> >>>> dedicated node?
> >>>
> >>> Just like for other bindings for nodes without resources, fold into
> >>> parent. This is already explained in writing bindings, so you could h=
ave
> >>> just read that. I will pass with answering more questions till you re=
ad
> >>> that doc.
> >>>
> >>
> >> Unfolding asus,ec-pad and asus,ec-dock will result in this list:
> >>
> >> asus,tf101-dock-ec
> >> asus,tf101g-dock-ec
> >> asus,sl101-pad-ec
> >> asus,tf201-pad-ec
> >> asus,tf201-dock-ec
> >> asus,tf300t-pad-ec
> >> asus,tf300t-dock-ec
> >> asus,tf300tg-pad-ec
> >> asus,tf300tg-dock-ec
> >> asus,tf300tl-pad-ec
> >> asus,tf300tl-dock-ec
> >> asus,tf600t-pad-ec
> >> asus,tf700t-pad-ec
> >> asus,tf700t-dock-ec
> >> asus,tf701t-pad-ec
> >> asus,p1801-t-pad-ec
> >>
> >> with minor variations in populated cells. Is this acceptible?
> >
> >
> > Yes, this looks correct.
>
> Update: with fallback-expressed compatibility when same interface and/or
> superset of features.
>

I am removing separate DockRAM and merging it into this schema hence,
it should look like this

  reg:
    description:
      The ASUS Transformer EC has a main I2C address and an associated
      DockRAM device, which provides power-related functions for the
      embedded controller. Both addresses are required for operation.
    minItems: 2

  reg-names:
    items:
      - const: ec
      - const: dockram

How should I organize amount of regs? Would this example be acceptable
with minItems: 2 since EC requires both to work or should I set is as
items list or minItems: 2 maxItems: 2? Thank you.

> Best regards,
> Krzysztof
