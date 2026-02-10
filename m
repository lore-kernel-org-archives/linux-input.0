Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3103624BA
	for <linux-input@vger.kernel.org>; Tue, 10 Feb 2026 11:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770722108; cv=pass; b=LQpeAyqUxx49GPBOgHKO6HgqDBIYhwCNNjjPbCNO5976pwx1eO5KQimRZDhhbWokHGMUofoJm1J0t/lNaw1DbXdgf5Tn0eKKBFKAzDcLUml72RN0KnnOza17eEipNEfx2qAG3ZU4YBkW++y/5YpuZcjqtKBbR7MKl4YDwFfzgYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770722108; c=relaxed/simple;
	bh=9RwOH4R4QH3gaTZuNlGDQPuuOYTY4NM/rcBF3DQRpJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=duXWRSdjyO62KyIbcdLIJ+bEVc11kI6Bzp8J6BXmtQGJurCFWnW1ISckoo0ZDbiDxL9LcGXvncqWp+0S9tsrGMMgCWTGci92acrfkBYy+ntCDEhsawUSOvDiLAhrW4pN9DUr/QcWZgy/RzG9MqpBhqIlVlJ9RBfxE/lUMcnjdfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e65AQGhn; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e65AQGhn"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4358fb60802so3671297f8f.1
        for <linux-input@vger.kernel.org>; Tue, 10 Feb 2026 03:15:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770722106; cv=none;
        d=google.com; s=arc-20240605;
        b=fDofCZ/BEXXSbau0zWtF778UvA1Ul/TXpJhcIvjMZbMhH0KKh8uoVsFsezi2AWNNzM
         Hi5EK8tJNpNBDMZGJDol9aZ8sfEBlJuSr8gPaWcZX6p7nwrmPpS9NOhofH6fVRvI9eEV
         O3g4VBFz7G3O9i2ADXzWi4ll8KmPqThJqjdbFxDM2B5wpjKHCa9rkZxvva0aHgyNvUbC
         dUPSt7tqWy86U8bN0bRBCSmlG7sVGkp0mDghgGaH0FnGwvPUXjk7xlv9RTp/0y5eMeDr
         DgASvO+IH9XZ7aKIL1F+sMgpxw3qmvNbQ2v9h7RLmNIYG6J+HdgewAWGukssnl+/m7Ce
         3mhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZSAYORMyK0PsRntDbPFNKD2d4UOZsLZplo2+nFOE3f0=;
        fh=qYcYQ9dRRsaiJQqxpNM7aq4M9ciJPrroSFZLt8Sx4ZI=;
        b=VusXwUMcQ1bZOOMaTj0TGpwE1I6tjbNzWga69u3buboOFaM29d9bx6YAtHXveCkXtk
         msNHn13jCkoIjyecvkwNQlITDlVNXjS+zRpmlACiDhu2yy2r252yQoMr4hMJwEvGI8fN
         aGYw71iTyau3UlmINrA/vhqAgBfLB18izLPIcofodnQmKMnnW4b41/WgVkHNzC6zvJZF
         nEzxmxNodwz5pUwMYMA46izuyaz6GK8CGfd1+P+u1gp+rgvDyryYZtYpqhoraox+ABII
         TE31XqDVXgYHxXGcVuVw2SaKONzufnGUySpbqm1uXAjGzsT1Z6ItKEGsFaOmjIEKT+DP
         j3Qw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770722106; x=1771326906; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZSAYORMyK0PsRntDbPFNKD2d4UOZsLZplo2+nFOE3f0=;
        b=e65AQGhnvdaLKgQEePASEnn1uArSYPcLLtNE/LagVjnVXxWPQE0M5Z+STwJUYnDuxh
         VkCO0K9HHao6r1CR8g1Wv4+Sk6RjSmCFjjdyR7cPmqtCA30gJnQl5LA7iJ8ZeQMsFUrQ
         6G60TqXAEDOo1YNK5mNsToHVJqTxjqpdjtDf+RimrkyI4/cw5av0OjHxpkHQTMLkJAK1
         R2q6G5wd/a/xaU8HosV2er5VumaFi9KzcSVJIxR4FbI+dPMbKqYCEz6D9fHuL+Dkgf16
         A0h+lo939gv0Dm+VXZT91NDaHxX5nYfQLJWR6mkUN/U67u/e7SlVauf1tzkDeE5QJ+Mc
         4nvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770722106; x=1771326906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZSAYORMyK0PsRntDbPFNKD2d4UOZsLZplo2+nFOE3f0=;
        b=XEYAIu4zJDbvWLpVaNkS2+U5Zd9cryXRx7RdyCUR+D2WLrv0mMPjWhhaaw5sBsjjrc
         LoZmrmUDvXVJvZzcTPHfOuNU3YwIYzYBE/USFhUaqNSHzRW7pPgcNBHiqLshPOCKwQz0
         AqER38r0H7/rccKyXHsA3i6CanxVMaDXSrb2shCuTjISwh2bjQzywuCk7cSDgTc8xeaB
         3UjgX2u8K2d5iUlHgrXANlqB+xTxVKMohx2JPr1v/pngT4Yrc1ooYqaMrBGEVyNWxPCA
         5Xjo2wpliuEWXSjZ6ldRyOZa3aKYCaWp+TZ8tMOLqwclWlBYNS4z45+etVMyGnH5avki
         ZIFw==
X-Forwarded-Encrypted: i=1; AJvYcCVz3bRDsivTh5FeRS8uylbjceBGeXS3WccDk/KBm9ClLOKorFmpAJlpjCwT7wSxMbjriBoLsZ9nAUBlig==@vger.kernel.org
X-Gm-Message-State: AOJu0YwD71fdai3HqngOxophhne7XDvFmZzsOB67o8NuLgVjz6xCZZIX
	6d+TneXx1lshJsAyT8t8/0Gm+WLTkD8QoJBj4b8XFUnNLU0f5tELn6B6co4XRDtpZkU2ZB3RDtx
	B46ikv27ynFOoYES4x5D58G9zB1Gm8pk=
X-Gm-Gg: AZuq6aL7r+y9jQ/YXugpBIbNBKR5xHZXkOLSRjyw/ZCFy8EFFe1cV3K7OSwJiC0Dpu5
	v7WE8LrR75+ry3u5A0CdBdQ3UOir4IRw56TlYEWaUBbPedRkEemAE5t/Uranzc0Yv/oUp6DGxse
	ptZ9MtOU5ps3NNa0sHnxV7jn9Csywcwp4FCY7PNvco2hSV3boVxMT3QtLN4YLLV5TE3V9n1iVGu
	DuWPB1kdfovawc81ACRki/baEcTbOv43mRfbAPDWyNhqVrIsJuZyMvzV6RG3asznGbYGV7ffgC/
	oFyw7XkL25UhTsq/EqM=
X-Received: by 2002:a05:6000:613:b0:437:678b:83cd with SMTP id
 ffacd0b85a97d-43779ead3ecmr3197089f8f.15.1770722105549; Tue, 10 Feb 2026
 03:15:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209104407.116426-1-clamor95@gmail.com> <20260209104407.116426-4-clamor95@gmail.com>
 <20260210-sexy-grumpy-sambar-44edd2@quoll> <CAPVz0n3fizf=r58Fr4YQ6pnjHq5p-7yFz95obss6w6x0bfgnDg@mail.gmail.com>
 <d1973810-d3f5-4ed7-ba0f-6bf93c1c7f3d@kernel.org> <CAPVz0n1foyy9g7MAurSAyLCUHTzrPPu0ceqy9YpcDA9uzgjGng@mail.gmail.com>
 <cb91898e-10f1-4d64-bace-41bbed08179b@kernel.org>
In-Reply-To: <cb91898e-10f1-4d64-bace-41bbed08179b@kernel.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 10 Feb 2026 13:14:54 +0200
X-Gm-Features: AZwV_QjE-AzqhPkZWgl4Q7_crb7bzCw5fMSH51bvzWcCqyTypBK83ZwA3GpjXGc
Message-ID: <CAPVz0n0O_uSAPYFtg8s+Ni0buyGJys6d0jEMob6SNWx-aeKUEw@mail.gmail.com>
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

=D0=B2=D1=82, 10 =D0=BB=D1=8E=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 13:04 Krzy=
sztof Kozlowski <krzk@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On 10/02/2026 11:59, Svyatoslav Ryhel wrote:
> >>>>> +  asus,clear-factory-mode:
> >>>>> +    type: boolean
> >>>>> +    description: clear Factory Mode bit in EC control register
> >>>>
> >>>> Why would this be a static/fixed property over lifecycle of all devi=
ces?
> >>>>
> >>>
> >>> Specify pls.
> >>
> >> Provide rationale why we need to clear it every time, not once. Or any
> >> other rationale why we would accept that property.
> >>
> >
> > Cause it is done by original Asus code and Asus did not provide
> > schematic or any data apart from downstream source regarding this EC.
>
> So that's a no. downstream code which is poor quality, not following DT
> rules at all, is never an argument for a DT property.
>

This property indicates that this controller on every reset restores
factory bit hence it must be cleared. Bit is write only and cannot be
detected. EC remains in factory mode which blocks its functions.

> >
> >>>
> >>>>> +
> >>>>> +  battery:
> >>>>> +    type: object
> >>>>> +    $ref: /schemas/power/supply/power-supply.yaml
> >>>>> +    unevaluatedProperties: false
> >>>>> +
> >>>>> +    properties:
> >>>>> +      compatible:
> >>>>> +        const: asus,ec-battery
> >>>>> +
> >>>>> +    required:
> >>>>> +      - compatible
> >>>>> +
> >>>>> +  charger:
> >>>>> +    type: object
> >>>>> +    $ref: /schemas/power/supply/power-supply.yaml
> >>>>> +    additionalProperties: false
> >>>>> +
> >>>>> +    properties:
> >>>>> +      compatible:
> >>>>> +        const: asus,ec-charger
> >>>>> +
> >>>>> +      monitored-battery: true
> >>>>> +
> >>>>> +    required:
> >>>>> +      - compatible
> >>>>> +
> >>>>> +  keyboard-ext:
> >>>>> +    type: object
> >>>>> +    description: top row of multimedia keys
> >>>>> +    additionalProperties: false
> >>>>> +
> >>>>> +    properties:
> >>>>> +      compatible:
> >>>>> +        const: asus,ec-keys
> >>>>> +
> >>>>> +    required:
> >>>>> +      - compatible
> >>>>> +
> >>>>> +  led:
> >>>>> +    type: object
> >>>>> +    additionalProperties: false
> >>>>> +
> >>>>> +    properties:
> >>>>> +      compatible:
> >>>>> +        const: asus,ec-led
> >>>>> +
> >>>>> +    required:
> >>>>> +      - compatible
> >>>>> +
> >>>>> +  serio:
> >>>>
> >>>> All of these children are pointless - no resources. Drop all of them=
,
> >>>> it's btw explicitly documented rule in writing bindings.
> >>>>
> >>>
> >>> They are all needed to be able to disable them individually from the
> >>> device tree if needed.
> >>
> >> They should not be disabled from DT, so they are not valid here. The
> >> given EC for given device is fixed/static. Does not change.
> >>
> >
> > Have you considered a possibility that function may be
> > disabled/unrouted within the controller. By the vendor.
>
> And then it is implied by the compatible, so no need for any of that.
> Otherwise, if it is not specific per device, then specifying it for DTS
> for all devices would make no sense.
>

So you propose introduce a compatible for every single ec used in
transformers instead of simply disable unpopulated functions? And how
then battery and charger can reach monitored cell if they have no
dedicated node?

> Best regards,
> Krzysztof
