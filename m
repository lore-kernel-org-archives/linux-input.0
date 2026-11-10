Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794309998;
	b=netW5kuwnYmXbNaWLgmofUV4nbiUN7MLQ/1rAikBdxb9E8dqiJw7K1hNRVGqzV4mk5Ol
	 T3MuqKGtZ+NEaNTItnz/musvDd8y54Y+TRte9K9YzK0IGWhRWbZcIvvwvIQzcoWxdg31M
	 1JvCp+br7qvlr//soww7aCtCyXwzpCJ9Gseg3RGQEP5w8ruYzoesz0FfXyz0josTyOD1Y
	 Kjsx0Ui+v+jr6qnMgi7S0bgE2JBmF/8L+ajF9+JAqr4QikJt52ZX0uKQpnrWoM4WHVMYi
	 b2feaq6BOMDHFchXwuLFoTvphWNRJZTl5AZGVmTRwM31/DrTA+AlCPZY2f3B1PCYhOA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794309998;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=/JeUA5XPTGoy/KR5mIq1snlQu7zsd7kO4TAs7obddKQ=;
	b=ow8wbXNAsuQJYxzoAidzi7bZ8dWPL1WMmLIOEbQMvifYSRn+yT+GSFjIBTsvC59kD8y0
	 Y36ww3OgkNF42B8SaHnp6oHwMKEVkw4Y9oNnELoT/zk8zrmalPktCQx9qwXMMwiXj1xkO
	 OnsN5eK1HAW/w7lI/vJHCGKvsIyrSVRf6eGCDxsEu7wGkKfNWm0A+7DUKX/s2xLBZTH5c
	 0fs8oR5kj3oZIRfYr2UOZSsXHati2K65vSrg8S6o1a96Btx5g9ebFZHPPSYIjtotehlDd
	 5hkVg+AuVPQL1kwEWTckomtv7AFLYNEMCUF3GE9pZ3EP5QymNekS3csCdEJUFmhf2bA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="O8QUX/jx";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.179
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494DA606A331
	for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 11:26:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 494DA606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O8QUX/jx
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8b305312e4fso15313097b3.2
        for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 03:26:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794309997; cv=none;
        d=google.com; s=arc-20260327;
        b=kAcYdqMXpqxEGiKWzTVa5rTXu1m+FstN37RKb3FitNzXgJv3TQn7dyqNdYZLUcVu5+
         mB6n8Cz/+mF+lK4lh7ggOwl6O93tJ7UivLdrS+VvY8CkYJe45y9px41Q2LzUE5loQZNN
         Pp/i4yaAHiQPFCaN63S9bnjHkIBVVXT6ZE+uyY7RntFrEYIYuThQfAG30P8AvYSKOjV2
         sNFuSjgt5ijtJbciEkry1vvMb2RKtCVmiJJU1psRh4mR/6I7JAsJrxkwkpNa/wz0QU44
         ZFChgytoQAFoKPg4UCFys3EkLIA8+JGW/w98nDDnw9Rt/OTR6QHZNEwmMtshxUegYUoy
         1e3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/JeUA5XPTGoy/KR5mIq1snlQu7zsd7kO4TAs7obddKQ=;
        fh=u1au0wQ5ETI8DNbdg8hR3DN5Z/kSWaWeLC8OnAVLfp8=;
        b=FfzpnApc7L8nLxY+XUdOVYedT9qJZFVf+adFfT5l7cIlidQUu/foSOnyyxMgGLC3AW
         VxVFw+IO9j4TKTIAqdBQVZviR6bH7NcSR/53ApPh9AqDzcwP61K5do5AGC2JEL0S4K60
         eWZ8K8BACFakI3PuKq8I1HyiX9yeuSsdMxQhvfiA5I68ttGogIF+5UvyPbm/EOruPfC8
         Xa084gFA5Vo2FfmgkvmsXwG2KPgPCB366qGnizkq17LDAlOx9ajbUyeYqFamrQFhh+Il
         gvWsVJl1UZNvZwZ2a5g17pLJHkySAvM7nsLg2m2JKK5h0sfBcVBzBM2jB/2Fdo9uGglS
         ScXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794309997; x=1794914797; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/JeUA5XPTGoy/KR5mIq1snlQu7zsd7kO4TAs7obddKQ=;
        b=O8QUX/jxibFeXJZFXp3x9ekr6Hb5ZyG8ENJYU/s24eioSequ3810kAvz6PFc/NR+b9
         2wgMS4nzsryX7Ryjx85SwvLOAFbiCNUBrbN8yXToI4x3Ui9XtYJb3/WysQxwd/G5OfPv
         0F676GV8BgNIp8SP0IuEPdpG4sjqx+Lv7pii9P/bgfoj/l4HSzlbqnlZv4Yx25ZReLS5
         ia9aHbmJ8mHx/M5K71HC8fgNRYBKSiNQ0FEkFRvQ0ZQinORZ6Bs0B5l/JoMwVNI815PP
         RJU5E3Q8caUSx78qX5nas5C6co5zsxOYb6RQPwgHPO/VumJXOqiSu1LRROhe+SSSfrH9
         7J0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794309997; x=1794914797;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/JeUA5XPTGoy/KR5mIq1snlQu7zsd7kO4TAs7obddKQ=;
        b=RkXst2/0KDxHTnS7LNGoGbZ8HqHVSYcoweaIoG/Nk/GPrNWZQWfikgBATRBH1ucYbF
         PMeM0Pn0QdPkRbMgnUWDzKiVh4Yp0BwsObwGHmx0LIVf9czPBE7CEvZBbe2qPqRJegyu
         EEQ8gamiWZdjAusndEvgSpwFPIX9hjuUU2/sKvHB25gctDxVyn6iAdWeUwmdDeRgNYle
         9XzbOMpXJp4bsv1HYIfFMuCCEVq37UH/wB2dGpI0AxCIu/3NM7I9aYaSLQfBHav0EXJf
         +58ykaVz1ntkqjoQ4m71gE56QZ9/nXIFhVSrB0PsBwM5229lgXbaSHRwyUuk1AbIraHy
         59Eg==
X-Forwarded-Encrypted: i=1; AL+hErERhrhuTdtQAxpHnqvag/i5s+DO/4FQUMdXCydSv1BlIoeVxx5KhCPtVEBaFN88Sqte/URUWuoFhMedKg==@vger.kernel.org
X-Gm-Message-State: APuU4Z81F6RB+G0hSNQkqQ2L8Y6ZzL1FmAoOm1j/k8mnHuL7G4Ak6TXq
	Cajpc5hsrdWAs7xWXLwI99nasd/4HtghW/mmeROIX2eYm7Mqv08NI22u9WxgJifKDfYMNQOSWNy
	PuLLYE2SsNu+jsPtzDtrM6Mavq+bIAm+xMheUJ+E=
X-Gm-Gg: AYBFou0S66czI+ToweDqbXYwsFFiWgcZ6bf5ZlP82ip2hR4rMGHVVOou/SN4cecZJEi
	3R9a3Mh+VEQ134npfG0zuJ6PllCI4UBdmF1cTZ8c5qhsqdLl+sLxRw/N95YmzlNoNNGLmUw2lWJ
	VKIISPwAdp6UH8RNvNUgBlLSVs0BZRKJJjdrPdBP8QtDldCGZk5a7/XrSMtCeQgMo9iQCTJaLiu
	RN0mLgL9nHMf7j+czrRWNCtKV7tWYij+9pNQUNO/v4Zgj60+LCPV7o5Xgm/Wgy6sX8ewWZ65KeX
	Gj3tt5V7i3ISkhZ5ELh0shXtw9RMZXhNCJkyeW+n/8ytgGGKLLliS709TbaluDkqC+SsyJPckWg
	LHSCt7ZN2RsGValZQC/r0+x4hsUC1n/ihI+DeSqI7zrWJ13zbOM+/aceYVH4zCIAMNF5LcPIUR2
	p6+g2cEPjLZuECHh4dzd7evaSC+6fEi5mTh6F1RKjNUTRjQzI=
X-Received: by 2002:a05:690e:4506:10b0:67b:e544:7adf with SMTP id
 956f58d0204a3-67c567cb670mr755726d50.104.1794309997113; Tue, 10 Nov 2026
 03:26:37 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261108-b4-apple-mtp-keyboard-v5-0-e2c97b82669a@gmail.com>
 <20261108-b4-apple-mtp-keyboard-v5-2-e2c97b82669a@gmail.com> <20261110-accurate-unselfish-cockle-3a39bd@quoll>
In-Reply-To: <20261110-accurate-unselfish-cockle-3a39bd@quoll>
From: Michael Reeves <michael.reeves077@gmail.com>
Date: Tue, 10 Nov 2026 22:26:25 +1100
X-Gm-Features: AclHuK-5Sr8Vu0dogwKG9EMBtjFYwuxFFj20UBqhmDk8dxo-p_0NSr8q2RJWh1g
Message-ID: <CANpmGNufv4_PM=1D1E-KRNQOuCPj8k+sGUJ1Y2HkkAtoSuL0Ow@mail.gmail.com>
Subject: Re: [PATCH v5 2/8] dt-bindings: input: apple: Add DockChannel HID transport
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 8:20=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
> Just an enum instead of items and const below.

Thanks, will do in next version.

> > +  apple,has-stm:
> > +    type: boolean
> > +    description:
> > +      Specifies that the coprocessor provides STM device and serial
> > +      number query endpoints that must be ready before registering HID=
 devices.
>
> Isn't this implied by the compatible?
>

No, it isn't, because whether there's an STM or not is decided by the
type of trackpad
used, not the SoC or even the MTP coprocessor itself. My wording in
the description
wasn't great and I will make that clearer in v6.

Rob suggested apple,has-stm as feedback on v4[1], we used to have it
as a separate
empty node.

Right now, as a heuristic SoC works because the only device to have the "ch=
eap"
trackpad (and thus no STM) is the MacBook Neo, which is the only
device with A18 Pro.

But that isn't guaranteed to be the same in future. I don't think it's
right to base STM
presence off something which actually isn't the actual determinant,
and just a byproduct.

> > +
> > +  hid-country-code:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      HID country code for the keyboard layout variant.
>
> What is the meaning of values? Do they map to any existing ABI? Like USB
> HID? Otherwise, why country code is 32 bit integer instead of ISO3166
> codes? As pointed last time, this should go probably to a common hid
> schema.

It is USB HID country code. I will specify that in the description in
next version.

Would you like me to add it to
Documentation/devicetree/bindings/input/input.yaml,
or make a new hid.yaml in that same folder?

>
> No default? Not required?
>

I will make it have a default of 0 in v6, so that way it can be
omitted by the Linux
DT. The intention is that the bootloader fills/adds it.

> > +            hid-country-code =3D <0>;
>
> Which country is 0? Isn't this just a default?
>

It is "Not Localized". As said above I will make this the default in v6.

Thanks,
Michael

[1] https://lore.kernel.org/asahi/20260925-apple-mtp-keyboard-final-v4-0-30=
4c267518f4@gmail.com/T/#mc53edc016ef1484c18e217b941b927bbf86f2cea
