Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE8031A558
	for <linux-input@vger.kernel.org>; Tue, 10 Feb 2026 11:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770723633; cv=pass; b=qEHK+k0g/g8jbz1yBy8pihJWIjPnfIpP5Uy6wKi1KJZDTjyjmFgXFKLRTkYP5dVvark9W1Fe7ozYtKWEk6BOTZx1xItvSSRxpOW6LAe1IFocWKxRgjF/MdtT0H+1+toWnyC10USIZkbhaCbQOYq9iK3hsgxqOx7Sw31dJzIwtmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770723633; c=relaxed/simple;
	bh=6/FnaCDrg0Je5LmR0DbI9pHLZ0ePao0o0SrXDi9lfBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eChJZVsJPHFMQxqOT5RyCYIezOqEKeqi57DNvCMlURd+FFmYL1xkaY2BIZCY/WYf0m2TFz4WYftIZ1S8hrrLUTbXRaCrXRYVaVO6xRRvrAMCm/fALi72QQ22PiAQY0iFLuKMoexF8PG6TgzmQRfn+M8yvCV+qp5XaQpNGFGrE24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bFK1gLAO; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFK1gLAO"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43626796202so592739f8f.3
        for <linux-input@vger.kernel.org>; Tue, 10 Feb 2026 03:40:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770723630; cv=none;
        d=google.com; s=arc-20240605;
        b=cyXDfEVeKkUvtdSa5MrVv2KIWnPAc3c69YhkKG/nsXNt+DIC0IjXBK5DEbIogBK3Te
         xnGhS673Bm/AqBNnigqV1vV6iZbQioduCoiELgKIFY+dmeLrkCszcfPKAfK0491hjU+Y
         8JvjuAjJfH8qCU3UqNeKJ3ZPwQxKnB1OLwO/GNyWp1H43NNMkT7emvVcRb3A3AZm7qsi
         iOAQIJccQQ1kTEn9UvbQCrzu5sizcHOkNxyPcgG3liszBo3Nl6hy+eY8PswCkTWBQNPL
         o1+2QTh+0Sj024M6FEs03linydOtvNlafyrrDchuxWoaEK3f6xcRsyOKRMW/lFLyk4Pu
         JR8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6R3QvEhmtCk9xuXNSfNCHPXokJj1HMXLUrDoDJsbjjM=;
        fh=42HHPu3qCz0OltDK+ZfC6/0/OjfuEWGJmqAbJnCbrlA=;
        b=dXs+6fzDPeNYr5UXOQ3LavvED4/Wm+0xims5nDmP/NArw5Uy3AplxKgw9RuloLUGRG
         pLzeWIVSwRi6Rm7uR27JaNs6Yoqq9a9XZpj810M9IQiBqlYP8TqI0/4NzivJ9p1eGRnw
         jQ7+f3+oKFVv0P941YXQjeTaYW0fhCsPt1ur3kjeKaLB27EksG82AduVj3M45tnKLMjC
         zTyC0ivac//UAIB+Ig9QtWUibVysEWJGcxxXp/Oi8Xqpnz95j6bzeGmgwraOB6fwEgz2
         i5nwkHUpWYrwkGoJDIKJvPaCjucM2MZRJoHu/YE6ACFVNsGeMRIHQZSc+JIA+lDtAFTo
         5mjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770723630; x=1771328430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6R3QvEhmtCk9xuXNSfNCHPXokJj1HMXLUrDoDJsbjjM=;
        b=bFK1gLAORXD86WhbOvJtdsyqyLiPceDOd8Xzaj1QbHwim3MON6hwIEZADsC8rb0b6+
         tpYqfPJBhB/xTXqXRK8YhV2macbt7xQiGhkRJU9TvQ8Uw7fYvdMqL3w0ktdKN+dI82D8
         Gw0bGj4rgBMs3CmpgiTnXc+0UjmlQ2e4O7wXW5PgqIKs3YoiX8Z1KZW2EvmVUp1q/h/+
         Y29WNpMgZKDBbP5uAezhqvqS8EUuUMy0vkqsI15Ws/LWtNuKBPA9hnpcSX8H7nZtXHDK
         WhdbuP9qEg1WgY7ssOfcMEoCDcQ5pkPxpXDdv+PHaU6ZQz/6XhU9NJXH09NXweYpO0mH
         5r0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770723630; x=1771328430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6R3QvEhmtCk9xuXNSfNCHPXokJj1HMXLUrDoDJsbjjM=;
        b=dpl1Bl1LvevSW7Y/vE25yTR8BVem2bA7iNEwwVc2frEuc5DHZKnQFeKS8SmFv0iJHn
         job0QHBM4mxH26iOFqSDEMXdzvtaAt3mPkwtxb0v44gW7dXsEY8eQHNeR1D9cbtOZyqb
         GQiy0BOTbfA9F9noeTM7JvDUh+eywjHO2pFjD9jwc7cGzb15eR8H9n2Umihx5F9GIdtL
         nRdBlSYUvG4CknEAkQiD+xxOIlTkS8O3Vo13icwhqsJPaTO9GzLNJkckQeHLGyX7WS6w
         CT4++hFmFWl1ugSFxvWUFQfMGztGTvjEX2LbkJW7r0ui1AcgTyGpopVcOBfXXrDokOes
         ZjWg==
X-Forwarded-Encrypted: i=1; AJvYcCUl7NoZDEHhkUoHtKJryk8S6KdlK1RTVX7hv5lE8jjBzfXME7ccra9CxiYvttIGAwpT8pqXcEzAQVtXFQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ4Ca8bJL5lPva01Nu5snxhq/+mEwLlMSEWMQ/TBut8WtL9RoR
	gfnfLyl2Uu2OdwSZp5JmF8cnoPG8LR+2fr9TogsctNykTVmYXky214TDSCUqOGpnHh2awZiRfv/
	TZFAtc+groOhf4bVLJohNubDMG7l9OiE=
X-Gm-Gg: AZuq6aL1RhC84mxif908zdIDp2m+dISAQPW8x1R5yAFVM8eoKWZMZLXYyZvfiXidGtu
	FWAqUqfudssSbKzWC7esICf40eqmcgRcXg+OdjvRN8q8YOgHHJlENlH6nzXfT+jP6TBflgeniZ/
	KMSA2fcSpby/MRfIGHsUlkZxtJup/vSMlx8G9+w7xhyC7xkDZNsdmMehtZIMxLyfwofq061WlpB
	fIexKLK6/UlG8s1LzuX1MrJYmBwwXfhu0PmiMdbHxNekidlRkwmRvBinfFnUEDkZY5T6wtRji1v
	StFRT0ld
X-Received: by 2002:a5d:5690:0:b0:436:3563:499c with SMTP id
 ffacd0b85a97d-43635634ba8mr10638942f8f.8.1770723629941; Tue, 10 Feb 2026
 03:40:29 -0800 (PST)
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
 <dc7acd1e-91e8-492c-8665-cb680c6164fd@kernel.org>
In-Reply-To: <dc7acd1e-91e8-492c-8665-cb680c6164fd@kernel.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 10 Feb 2026 13:40:18 +0200
X-Gm-Features: AZwV_Qj_PU3fakrGR59GUwZHjil71UqQv1RxthP-ur70Fb66TccCFSfBCI4qmfU
Message-ID: <CAPVz0n0u_0ZukcKXt0QpiyCMhWsg2VE-dE19wDCbRQvBvVOf+A@mail.gmail.com>
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

=D0=B2=D1=82, 10 =D0=BB=D1=8E=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 13:24 Krzy=
sztof Kozlowski <krzk@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On 10/02/2026 12:14, Svyatoslav Ryhel wrote:
> > =D0=B2=D1=82, 10 =D0=BB=D1=8E=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 13:04 =
Krzysztof Kozlowski <krzk@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >>
> >> On 10/02/2026 11:59, Svyatoslav Ryhel wrote:
> >>>>>>> +  asus,clear-factory-mode:
> >>>>>>> +    type: boolean
> >>>>>>> +    description: clear Factory Mode bit in EC control register
> >>>>>>
> >>>>>> Why would this be a static/fixed property over lifecycle of all de=
vices?
> >>>>>>
> >>>>>
> >>>>> Specify pls.
> >>>>
> >>>> Provide rationale why we need to clear it every time, not once. Or a=
ny
> >>>> other rationale why we would accept that property.
> >>>>
> >>>
> >>> Cause it is done by original Asus code and Asus did not provide
> >>> schematic or any data apart from downstream source regarding this EC.
> >>
> >> So that's a no. downstream code which is poor quality, not following D=
T
> >> rules at all, is never an argument for a DT property.
> >>
> >
> > This property indicates that this controller on every reset restores
>
> Implied by compatible then and you can drop the property.
>
> > factory bit hence it must be cleared. Bit is write only and cannot be
> > detected. EC remains in factory mode which blocks its functions.
> >
> >>>
> >>>>>
> >>>>>>> +
> >>>>>>> +  battery:
> >>>>>>> +    type: object
> >>>>>>> +    $ref: /schemas/power/supply/power-supply.yaml
> >>>>>>> +    unevaluatedProperties: false
> >>>>>>> +
> >>>>>>> +    properties:
> >>>>>>> +      compatible:
> >>>>>>> +        const: asus,ec-battery
> >>>>>>> +
> >>>>>>> +    required:
> >>>>>>> +      - compatible
> >>>>>>> +
> >>>>>>> +  charger:
> >>>>>>> +    type: object
> >>>>>>> +    $ref: /schemas/power/supply/power-supply.yaml
> >>>>>>> +    additionalProperties: false
> >>>>>>> +
> >>>>>>> +    properties:
> >>>>>>> +      compatible:
> >>>>>>> +        const: asus,ec-charger
> >>>>>>> +
> >>>>>>> +      monitored-battery: true
> >>>>>>> +
> >>>>>>> +    required:
> >>>>>>> +      - compatible
> >>>>>>> +
> >>>>>>> +  keyboard-ext:
> >>>>>>> +    type: object
> >>>>>>> +    description: top row of multimedia keys
> >>>>>>> +    additionalProperties: false
> >>>>>>> +
> >>>>>>> +    properties:
> >>>>>>> +      compatible:
> >>>>>>> +        const: asus,ec-keys
> >>>>>>> +
> >>>>>>> +    required:
> >>>>>>> +      - compatible
> >>>>>>> +
> >>>>>>> +  led:
> >>>>>>> +    type: object
> >>>>>>> +    additionalProperties: false
> >>>>>>> +
> >>>>>>> +    properties:
> >>>>>>> +      compatible:
> >>>>>>> +        const: asus,ec-led
> >>>>>>> +
> >>>>>>> +    required:
> >>>>>>> +      - compatible
> >>>>>>> +
> >>>>>>> +  serio:
> >>>>>>
> >>>>>> All of these children are pointless - no resources. Drop all of th=
em,
> >>>>>> it's btw explicitly documented rule in writing bindings.
> >>>>>>
> >>>>>
> >>>>> They are all needed to be able to disable them individually from th=
e
> >>>>> device tree if needed.
> >>>>
> >>>> They should not be disabled from DT, so they are not valid here. The
> >>>> given EC for given device is fixed/static. Does not change.
> >>>>
> >>>
> >>> Have you considered a possibility that function may be
> >>> disabled/unrouted within the controller. By the vendor.
> >>
> >> And then it is implied by the compatible, so no need for any of that.
> >> Otherwise, if it is not specific per device, then specifying it for DT=
S
> >> for all devices would make no sense.
> >>
> >
> > So you propose introduce a compatible for every single ec used in
> > transformers instead of simply disable unpopulated functions? And how
> > then battery and charger can reach monitored cell if they have no
> > dedicated node?
>
> Just like for other bindings for nodes without resources, fold into
> parent. This is already explained in writing bindings, so you could have
> just read that. I will pass with answering more questions till you read
> that doc.
>

Unfolding asus,ec-pad and asus,ec-dock will result in this list:

asus,tf101-dock-ec
asus,tf101g-dock-ec
asus,sl101-pad-ec
asus,tf201-pad-ec
asus,tf201-dock-ec
asus,tf300t-pad-ec
asus,tf300t-dock-ec
asus,tf300tg-pad-ec
asus,tf300tg-dock-ec
asus,tf300tl-pad-ec
asus,tf300tl-dock-ec
asus,tf600t-pad-ec
asus,tf700t-pad-ec
asus,tf700t-dock-ec
asus,tf701t-pad-ec
asus,p1801-t-pad-ec

with minor variations in populated cells. Is this acceptible?

>
> Best regards,
> Krzysztof
