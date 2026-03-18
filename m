Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB55B37B417
	for <linux-input@vger.kernel.org>; Wed, 18 Mar 2026 21:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773869141; cv=pass; b=vCaGDg71WNNZ/LdWFGj3y3kiA+qDWdzM0aHarMHwkviYo2oM+DtIYzm+KNYWHJMOPG0OzjReqvfNtnebNrKvl7oi8ykzVKxPZKzqMJhSNSPGhrUy7nemmE1J05u5At7sf2s4Xd7TDf6JD9flRA9ZmkCSaFxxpI9Fj+Z/NtnWpIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773869141; c=relaxed/simple;
	bh=EQzldedRTpvLua9RqcprZmThFLsNIvG4JO/73zahzZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GzvGPvh1jbtOI9c5qVm8RrV5lwtlwVoJPnaWnh6DySqslcaWbbJaRComx54cCh1OIkAWVMmDb4ST6GkM9tb38zotlunXsb+U6ITXBYM/K13ptomB9J4znJ+k/JS9Lf4sjhdwEBwWC7kUgKUebr1VLKsyP9A8ZrdLB4hDDClpcN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Re2OHwjP; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Re2OHwjP"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b8d7f22d405so44194266b.0
        for <linux-input@vger.kernel.org>; Wed, 18 Mar 2026 14:25:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773869139; cv=none;
        d=google.com; s=arc-20240605;
        b=cLQosSQUrvdmY7VMiCI7THoJfYw4m3j/QP5bPogv55IAYR9CzNsrjZ7B/9ZgascX8l
         i7qreeGqud9Vh2DoYrG/XZ7w6JzIuvzVsPpCa//7rrC6oxM2pQpWgyDhPPq+6/R+OE4+
         9t+DKZcUajM7X4LdfQr4l2PhcK4asilDRiWOAwTkvlbW25ScTw+paRarLFIxkTpEuL2R
         COR0zhn86rI5R1dkwVlKC7n51azig9PklrJOJlpznjkePsMG6zPAdARYo29BJaKednJA
         eqeCTva6YH1mqctLIPzAAsRhKFB1Z0ZXF2bVpyZLuxLK7x8MRlgnu5SlU5TzjfPoX7e9
         3wVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=K6f1m8W1umobQ+ktMqqvSwqw9J/2mgt2skFeEG9RxsI=;
        fh=vC+2g04IfRAehfrYl+DHkKoPxLRKUgxUnRe9GRDYZNI=;
        b=NGMmPxdHLG/LzPcsXeyMgGoczXB4JSDjOk8LBc3WX+HiD2MHLR8qAfsVLf+ahrtjSG
         AUcqgkoczHweq57OM7PsWYSIzq4tLM0/EulvaiPSBge/PfhOAEt75Gdo53dq4B4IxBU5
         QFE5Xl7S13YGHuNvz7Q+jeYJ5W91vvXqYfedWZLWrSAj6/wH0kj2xsOYnsHds0GDmDbw
         OUV38XowObm2uNXjXu+H34EGVuK+iTTWSSb4kvgiv/Q8oashCi951HMUhEgzXRBZWvZr
         yfH28fj7RtS6MLPC5UIPR8EndWVFeE2z3nFBGZNBInUNrHLST+crHzL6yZKC85B9JyS6
         55Ug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773869139; x=1774473939; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K6f1m8W1umobQ+ktMqqvSwqw9J/2mgt2skFeEG9RxsI=;
        b=Re2OHwjPI/wDcppVPDTGr/Fitxq6TGT4tDY56to6JnJhMTzzYCnafDK2PCKKqDSUhn
         BsEOrJGmt853phtdlbowPRteBqyNBP2j/wLp2BNDngQ8Hr+WDtb0lfJTnLWr8J3xSMFv
         M6J6232/9vpMujn96uwoXZjGFD0Mvgz7BE8MN6bSibhrvytfifEJT/eGz63qWwHHuLYi
         YrUA0/dWuACmf31FnFD1Na/MNCDQ7gFYhTyFqTPVoSiNmt6c6Qpp7TClWNTea3UMaECd
         rWXoYYF793tZZfc3i3TgpUr5JwMODjualvrvBQTo5Fyfgcc+6nUn9WM3fkL17AaQ+Md5
         i19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773869139; x=1774473939;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6f1m8W1umobQ+ktMqqvSwqw9J/2mgt2skFeEG9RxsI=;
        b=GySIz+XtNjutup2nbl0aAaNfx6Ia5r+bx4OE5HiGGneoRgrVycGcPfnI5WW1zMTJ5/
         PjQ1ungFcGxncxNw5UY5Wg6OvRu0BaH+Wi14Wh71Cnn6A327BE2GYCX4kljUYyrCXenc
         Iy3ektCXPCiS2jL9/WGCqqV9QLjvwk3ci3mzBe+by/G7l582sJjh5nzZ52t6CqQibKmJ
         4gPS7vtwJgqxCJvPM5oRY1O4b7ADiIAN8QALr86HeylEIaCyoiEmgEtyl1ihlgrdCaRQ
         hS3mel1yawiLN6cdP4WhCQF6hsNUtD9rFBrMzlGUFDi/RxXlaV3b3y41GxFxr7sdf7zX
         T/dQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUzSJ+Can8HKn9k6vTdzaq8L6nb+z5ObdPosSxM+ftPwPKZ0rA0O0hlOv8128Mo3ecjJ59oQFiM0y7JQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8aDNFl5hZOSCQWRYPskluXF7Q/Tc+ut4X8BMwUAcuNUUDU4Vc
	eHqK3a+fM1tIQJ5gnJ1irrsY6A9cp0YXivbddP+3LFSVD156EknAdDzp0GtDkcLXnGiGGWkr7uy
	tsCpJsUPmYF2DawHVSw5XfHv7t6nPM8E=
X-Gm-Gg: ATEYQzzTlBq1yN5evykYMwXVRQ5KIiiSAlbbbuVd45yqi3LvT8ZCm6uyWYNRO3ebnjw
	EURcjKDV6izkh0Lq4AHplRFV477XGrhwoSX+jnDO6iLVACad05HMePpyJ1jZ29Q6JGOrqPmHgLw
	7tgAgRCjxtnQcw6Uk+fFkIIds9ljX3nI8kjqQNXG7yHAztkUyYe66hQ1WoyDeYvLwDY8q5RtB5o
	uZCTh3qY1SMa6x3Zm/iLjShe+OMIqX1zVQAD9FqrCOe8m8Z6TrPCsKzaoVJ/B5gZ476cKT/rO6t
	mvqH4A==
X-Received: by 2002:a17:906:99c5:b0:b93:9407:ea5c with SMTP id
 a640c23a62f3a-b97f4b70e51mr342818966b.57.1773869138582; Wed, 18 Mar 2026
 14:25:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317184507.523060-1-l.scorcia@gmail.com> <20260317184507.523060-4-l.scorcia@gmail.com>
 <20260318-nickel-serval-of-tolerance-621bad@quoll>
In-Reply-To: <20260318-nickel-serval-of-tolerance-621bad@quoll>
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Date: Wed, 18 Mar 2026 22:25:26 +0100
X-Gm-Features: AaiRm51yI9RGCvrRh7GVNMdJwfVjHSZ_bJ1ljw9KDUXHaZfxU7GvIWfUsRzyb80
Message-ID: <CAORyz2Laoo4EiLcHZ-ygLiFGW_h8qV7QxqNsMbueM=nov5zH0A@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] dt-bindings: regulator: Document MediaTek MT6392
 PMIC Regulators
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-mediatek@lists.infradead.org, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
	Lee Jones <lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Linus Walleij <linusw@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Julien Massot <julien.massot@collabora.com>, Gary Bisson <bisson.gary@gmail.com>, 
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>, Val Packett <val@packett.cool>, 
	Fabien Parent <parent.f@gmail.com>, Chen Zhong <chen.zhong@mediatek.com>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Il giorno mer 18 mar 2026 alle ore 08:43 Krzysztof Kozlowski
<krzk@kernel.org> ha scritto:

> Please use subject prefixes matching the subsystem. You can get them for
> example with 'git log --oneline -- DIRECTORY_OR_FILE' on the directory
> your patch is touching. For bindings, the preferred subjects are
> explained here:
> https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters
>
> You already received this feedback from Mark.

I am sorry I missed these. I will revise all of them in the next version.

> > +++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6392-regulator.yaml
[...]
> > +properties:
> > +  compatible:
> > +    items:
> > +      - const: mediatek,mt6392-regulator
>
> Drop compatible. Regulator nodes do not have compatibles.

Thanks for this comment. It took me a while to understand what you
meant as most of the MediaTek PMIC regulator drivers still require the
compatible node to probe, including MT6397 that was the template for
this patch. I compared the driver to MT6359 that does not use it and I
am now working on the driver to not rely on it.

> With this, you can also drop example as it won't be used.

Just to be sure - do you mean remove the compatible attribute from the
example, or the whole example section?

> > +
> > +patternProperties:
> > +  "^(buck_)?v(core|proc|sys)$":
>
> Nope, underscores are not allowed. Use only hyphens.

Got it. I will actually completely remove the (buck_|ldo_) prefix
altogether as suggested in another comment.

> > +  "^(ldo_)?v(adc18|camio|cn18|io18)$":
> > +    description: LDOs with fixed 1.8V output
>
> If fixed, then encode it in the schema - min/max microvolt.

If possible I'd like some clarification here. According to Chen-Yu
Tsai comment [1], dtsi shouldn't contain voltage constraints. The way
I understood this is that electrical constraints are a matter of the
actual board layout, so if adjustments are needed they have to be in
the board dts. But you also specify "If fixed", so maybe there's an
exception to this rule when the constraint is "absolute" and boards
can't actually set a different value?

[1] https://lore.kernel.org/linux-mediatek/28102417-4a2a-4e29-afbd-d0f2aa76074b@collabora.com/T/#mb1473bb5515f3e5a1bb3ff20c717b387c42373ef

Thank you for your help!
-- 
Luca Leonardo Scorcia
l.scorcia@gmail.com
