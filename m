Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DB1333440
	for <linux-input@vger.kernel.org>; Mon,  9 Mar 2026 05:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773035094; cv=none; b=Ec05vzxaT6NBmijRQGdoVUgmM09Nf2tt4ZPCuvUtQnVGLSts65Qhu28sl/a2KKkdJWhWQaKvSl5XUPKvGFzGZHaDC+5jcynuDC3wD216UD1aA2wiL1vCZmtoUBPE2JdKzLmuzMko11xhCEzG1afw+4zX75MGXFffR6DUNXeXLGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773035094; c=relaxed/simple;
	bh=hqi/Df1JPDp/BlPm0GTdyjJF+qjIicQyIWh3azQlrf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLu6UsuddlqucznDvXNzGNzzuPORlG43iKi94EhkuHLDDB6nZOruN2YgSrOUGHd6U9mbtOIIC9pR7K4PRhhF5cD+FelpNWmg1963miXfVjq875Qn+sruffACdHdfjRc/4sBcjuBiKoaTOWYZJjRsjHIaol51TCqOQW2dvM2U+Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PH9kTvFY; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PH9kTvFY"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12776bebe9fso4362586c88.1
        for <linux-input@vger.kernel.org>; Sun, 08 Mar 2026 22:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773035093; x=1773639893; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ug9w3Bfo3Ur8mbdFfczjnMxT2pbrXyiERJeMtAuIh8g=;
        b=PH9kTvFYazGcAHB330To/OeFzVVVoAetzeAqLqtqgO8FTevOSlJFg0vBVgSis1D2qx
         ei4tNvhFPmh9rlOXr2szTzSoqAD0b7HIcOIrEvL5+ngd6IVklpLZT6rHLnG7PimKZxJ9
         WNgr1m+pUKPVhXczgU5mbe5tNGgj5xXXBCyEvkqnAFWkvr0DnL5lcVxj8bcLuaBKAWQj
         nuRXFxAHJBYhnJ9oofghicqrvnLlnsy7xl+xR5W6CAGNw7Ab3S8+FdKBlMHTEgwLb98/
         MWsGRvDGo8vDBF/Va9cyyNDPmbCaaATQfCaHXHHlieVPDqYlbgqs+bSBorjqAbNtezJr
         wD2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773035093; x=1773639893;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ug9w3Bfo3Ur8mbdFfczjnMxT2pbrXyiERJeMtAuIh8g=;
        b=wM5ZUuFmgCflf6wWCbP1GGEpS1cJWjGzfOdKjFEgWEvRRPFW7ZEvyDblP4f81un1kV
         RP+ficWzWf/N1+dUfMwHS+bjtD3opkC1+tydFa7bBCo8SSQigEJhDdFL5d1XhYWW6rjX
         Hv5c5W05Cgjf+MYhjrcxZwZnOTdJhf3jmrA0PnrNMhKE15iMhnOwdUsoKbmbEXcqPHXD
         7BLNSY/p3TtQKIqnAPYlFeYiIFKUhiClSqKl/fZLv21vvT+RUSsMiVvqhpU0h7wRq+aq
         YqOw+4jorNzlcgeAjEiwZrKt7bMg0gFGywhlNTUowrlPBXlIF3vUvDLK6C7tJZTn97Ur
         PJTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXO6mKnndpoXSGdujJZPY5FXsEB+M/qFwCNEtuHaYCdvZNMyoCBYAX06K2iLBDWEgjULZro8Aj1G+ogog==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXM7OrBfun+5ypH4aTjkPNMYdHn1HprkgHoUcqznb6m7mIq3dd
	t+X6KJQe4iZPZFJCn1z+8u09YdDi5NEvm0LGXqCtLGXyF2jUTE1hhlw2
X-Gm-Gg: ATEYQzxPhMMKXdO6R+GA24vddN6UrWzwDB3ZCIAxANmuhUVEWaB9Rsnsm6e2loeQyKx
	q2ULCjgK8MiBNMPDlf/cM7Gxq0SAOIKdP0VtYrj1IRqVd4gEmVKqPAtzVUNSBNOBNk1wacpiTWe
	BY3qfCt5rXWPmXBJ0+zTJkIAAxPGn0BnjRwCH3uKxKwi/RWzPypFCQ65NA1R2JN9lEJLCLbcLqD
	Ma+kRJj9X9o26k0JiW3gMlsqCC7yEQH7BjvDvv/aXgsE//HQFSrGWBZj0LVCkLaGbVuwLpyppX8
	u9BZdxobdn/OCuypQQbdx14biS7SbEAZaKlI2JLA8oot3PX+l626BIG1oyET5qBpFu1QwmJHafQ
	oNF3Pve0Qb/2XTLhL2BS3lSXw8oTTMacF8iYTWykRQCd7QQGFU3afKDS4Mv/l94tngM9G0zL0c8
	RhxsqENE7bMAaNVNeHhNZCmQZ/U7mGKj0=
X-Received: by 2002:a05:7022:906:b0:127:5cfd:785 with SMTP id a92af1059eb24-128c2d8f553mr4232707c88.4.1773035092704;
        Sun, 08 Mar 2026 22:44:52 -0700 (PDT)
Received: from google.com ([2601:647:5e00:4acd:af9:a43b:9d9e:841c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128c3f43593sm8122381c88.9.2026.03.08.22.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 22:44:52 -0700 (PDT)
Date: Mon, 9 Mar 2026 05:44:48 +0000
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Val Packett <val@packett.cool>
Cc: Jingyuan Liang <jingyliang@chromium.org>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Mark Brown <broonie@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, devicetree@vger.kernel.org, hbarnor@chromium.org, 
	Dmitry Antipov <dmanti@microsoft.com>, Jarrett Schultz <jaschultz@microsoft.com>
Subject: Re: [PATCH 09/12] dt-bindings: input: Document hid-over-spi DT schema
Message-ID: <aa5cxFcZrI89g-8s@google.com>
References: <20260303-send-upstream-v1-0-1515ba218f3d@chromium.org>
 <20260303-send-upstream-v1-9-1515ba218f3d@chromium.org>
 <1cc6de61-8b56-492e-ab78-e3aa448f58ad@packett.cool>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1cc6de61-8b56-492e-ab78-e3aa448f58ad@packett.cool>

On Sat, Mar 07, 2026 at 04:25:44AM -0300, Val Packett wrote:
> 
> On 3/3/26 3:13 AM, Jingyuan Liang wrote:
> > Documentation describes the required and optional properties for
> > implementing Device Tree for a Microsoft G6 Touch Digitizer that
> > supports HID over SPI Protocol 1.0 specification.
> > […]
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - microsoft,g6-touch-digitizer
> > +          - const: hid-over-spi
> > +      - description: Just "hid-over-spi" alone is allowed, but not recommended.
> > […]
> > +required:
> > +  - compatible
> > +  - interrupts
> > +  - reset-gpios
> 
> Why is reset required? Is it so implausible on some device implementing the
> spec there wouldn't be a reset gpio?

No, because it is mandated by the spec:

"HID SPI peripheral must provide a dedicated reset line, driven by the
HOST, which, when toggled (pulled LOW for at least 10ms, normally HIGH),
will have the effect of resetting the device. If a HID SPI peripheral is
enumerated via ACPI, the device ASL configuration must expose an ACPI
FLDR (_RST) method to control this line."

The spec also states that the host must initiate reset during
initialization of the device.

> 
> > +  - vdd-supply
> Linux makes up a dummy regulator if DT doesn't provide one, so can
> regulators even be required?

There is still a supply line to the chip even if it is not exposed to
the OS control. So as far as chip is concerned the supply is required.

Thanks.

-- 
Dmitry
