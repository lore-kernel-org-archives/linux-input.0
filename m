Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DED347CC97
	for <linux-input@vger.kernel.org>; Thu, 20 Aug 2026 16:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787243011; cv=pass; b=QMRNsL/6cGGzjTKMAOq7VY3Uvx8FI8Vi94irVThUNw7kG175wu4voNNyI5beTGYNLzOvcXjoA+ToPJpdRpDCTdeXHZza7NtfBiIsXYJ005Mj7JJRtklUWW65trx+SZRsXSN8nXwpcKMiphTlP3PiGlLunPhdf6XCSstgX024hOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787243011; c=relaxed/simple;
	bh=nM7522pMTSm6ohXpjcirSMLxO2bUSl44i0fllcYRFAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DoHi53YAHvmia9iICxLzsEXg+vs2XjQZr8CnQmQqS9iLk+0pk+MNosakF7PHobHBM9NoHfzvbMrxW5Ry4wMRWqfU3+k374uOv3peaYk78ETgs/os1yY6cHKeBImhBLz7ViOyHkaSKY2PUYQbsN3wKEP5Q9f2j44BjSqLHdWZDM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bOlEWY0M; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOlEWY0M"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c1677c91969so1123166b.1
        for <linux-input@vger.kernel.org>; Thu, 20 Aug 2026 09:23:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787243008; cv=none;
        d=google.com; s=arc-20260327;
        b=SKJNLu/ur4l03tLtj7hDTT6PxncgyBlO6uw2Yp48mBq8vUQuxm55W+7Z5wv2g13Mbl
         ydv0hpBA9qz3hv3eZwHnwTqIgPtY5CO8gTfDQ7ZzHQ8ksmCQ67TOllYTG14RtxwksJWK
         ggMqaZWYcUmHuUMuhrtCJtj2SiWi3WcYAFFIjZE80iUcQB/uWZaf0efM3L6qrbp2/lSn
         iAqQ6/oLFs32JubkV7+lwUWt14gji4pVfzWfaNXg7T+3NovqMc4KvTjOMi5u4NJBT1xs
         FsZaji1VtwGYM/4WpuyUYxQ0M6YA8m8ii78CVqBkbOjobgwnZdA2y8MkWo2j6gZ3WiJN
         gR5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yKhR9WkhIUiBs/DXzAMG9ly3j13B+5WjNx96hhgAatQ=;
        fh=s5ayX/tL1sDxEJSDAjAIQVFEUpyFtpfYK0PN2x/7RCo=;
        b=fligASv3SGBiBvaIgq+NdbhA9til2hfk67IdrzFwFnRNBLS38fXsJF2OuXgww/zX0P
         PVyCTU29r1UrYpfesXn1Zpcfcc2dgjWxCmWeHMxYt6rZ9nS6z58hK+lm7NR7Leo1GbVL
         t4br+R+ZJJYDLzzjLPdr4NccE7tHK9X8LRpsMg18aGChW5DSrZyS0Byb2mO7MBltMyid
         O/9uR6v/9UZyHyzITfFTukRM7fva/z42I2Y3/PZ4NR4+KXoqob2wYxIfhm2rY9zXZtmK
         8OX1YH8JDaSdSSQ3EOkxQf5DRyu4gSLDxpJ4iMgZVwmUbUwsISfLJH6ZQIwYfiQBbj4p
         qSmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787243008; x=1787847808; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yKhR9WkhIUiBs/DXzAMG9ly3j13B+5WjNx96hhgAatQ=;
        b=bOlEWY0Mb292rIMAKTE6vd/2FxvUetWzvZEY63S9Avih8hLO9+PCK5rb0GHwFLtbKH
         kk6Yyekz7v8JyRhvAMKxxrElNC5posK7Q/kEiwL2lTIIDaq9/a08fizXIo7lDyJrgqP0
         b5gdhtWHvAoPgZjSNxI+CQ4NsOydysVImcu+u/xsGrEcKrPHk5smpVKqGROCgs7aVEkv
         yFqwB/fLbbyTtVeP8L4wcLkSq/Ot1NHJjgJ8Y/wFGbCLecv3jNkvmi+gt/rtzxb6/A5F
         2a6XcFm0RVzDVbzeeb5oq8dNKe2jOt7WD5xzQ7b54KuQM0ddOntBTLtv02t+AFfyfokM
         Igwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787243008; x=1787847808;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yKhR9WkhIUiBs/DXzAMG9ly3j13B+5WjNx96hhgAatQ=;
        b=FFoX4P2hu9KUt79kAPzurqMcOCkTZ6XLai5JeJNDWuu+afavJCaz1xdeW8UJkfFUix
         d20jmL2lmKRWB+KZdXn4uD/9YMAn8xLeUM0zveIhIZT55As2/dOJhPmPJePS9O3kH3Qg
         V9q4Q+AyihVfSdbwPAjFiwn/6YaiRanIyf+97PsVp6YOtJMnGTpohCy8wzu8IZlxaYbo
         1bU31AbGuUDgdfoERCAk9lJJIEl2wjxYohou7WbLsCKUY9O2sVefvjYxBWbeLjHSPJIH
         4/w7BKhaF4eVCXc37rHEI2+VE8nI6CPbEjhN73XVTlAOhx5G2PtwuNgAzKhXmRiXbw8h
         Ij4Q==
X-Forwarded-Encrypted: i=1; AHgh+Rpu9nQKUEQ+oPYfI8KKpwy+wVVIzSx9Im64nJvJKpSvPjzCyVUa0+5hU3Z8ryRYc8xXXy2MTaRGbWhALA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXh3eYJikur0XHX+nrA/pn0XPdsNkgBLWGv2BPQb+2XI4uCO9J
	TCp5C51GYES1MOGdlYFzWopmllaRotVq57UyZ8I03rkCOwVL8oI60aglxPqWzEZ6rbXW4VMrQiu
	fRaqOXcAsvrlccF3DbL9r6e7MAHWnm6M=
X-Gm-Gg: AR+sD11gt7sM1wpnI2Su9gIzFcIDaQlFzUBQJo6ttstlsPxCZO4WwC8WQZ6x4FrX4mM
	k4SGdfyS0atCM3pH0fYOaCjj31bS1lweh3mXNTWhs8PaP85NoVQTPpjy0iZTyJ2eBsY3mmAnken
	1QaCu4U5dgKC4ZDNoQviha7zjcmV83zSTolVMlvxB1fTqaFPF0HBYWBSmMfBVvVwH7wbmBrpsim
	XlYOZRA0sBn6dREYdX0QfmtKFlWZEE2h4wsfn5dNQOUYpqNsZpHhdwIpaogWGtbK7G4lLYW4sz1
	sDxQsVZe7FQpDwit8lftwZClU4r6icmVhRdZcrWG328=
X-Received: by 2002:a17:907:a647:b0:c12:9b93:61fd with SMTP id
 a640c23a62f3a-c23e86dd23fmr1141726266b.6.1787243007488; Thu, 20 Aug 2026
 09:23:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820122242.120039-1-l.scorcia@gmail.com> <20260820122242.120039-2-l.scorcia@gmail.com>
In-Reply-To: <20260820122242.120039-2-l.scorcia@gmail.com>
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Date: Thu, 20 Aug 2026 18:23:16 +0200
X-Gm-Features: AcwNN1WN15gIPFE-wS5GMikP40k9b6tUzSd1TSg8R6uNQUbH06o6RfXy9sJzOY8
Message-ID: <CAORyz2Lgo=teK89gxm6QBMfREY=_cAFN2TuLUFvwGcYpozkWww@mail.gmail.com>
Subject: Re: [PATCH v9 1/9] dt-bindings: mfd: mt6397: Add MT6392 PMIC
To: linux-mediatek@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
	Lee Jones <lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Val Packett <val@packett.cool>, 
	Julien Massot <julien.massot@collabora.com>, Fabien Parent <parent.f@gmail.com>, 
	Akari Tsuyukusa <akkun11.open@gmail.com>, Chen Zhong <chen.zhong@mediatek.com>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mfd@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> --- a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
> +++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
> @@ -40,6 +40,10 @@ properties:
>            - mediatek,mt6397
> +      - items:
> +          - enum:
> +              - mediatek,mt6392
> +          - const: mediatek,mt6323
>        - items:

Please disregard this patch/series. Sashiko correctly pointed out that
it's not necessary and actually wrong to provide a fallback on
"mediatek,mt6323", which was needed on a previous iteration of the
series but not in the current one.
I will mark the series as archived on patchwork and provide a revised
v10 once completed testing on devices.
-- 
Luca Leonardo Scorcia
l.scorcia@gmail.com
