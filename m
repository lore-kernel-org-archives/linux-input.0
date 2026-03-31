Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D603A1E70
	for <linux-input@vger.kernel.org>; Tue, 31 Mar 2026 10:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774952116; cv=pass; b=T7zc/37zCnYBaxIoVyf1IBKAFGvuGZHKilXxxQGcfecpsAwSRgSFy0HRDuocxfDCrkbEWWfHZUWeHsmnS8/LFNEw3rqVZkDp2l0UGq1yaG1J3kW71OQ3uUJ07DpSA1NZVrWAXej1Uhey5aG/pIw0SVVE2IA9k6j+n7eFk3ekAIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774952116; c=relaxed/simple;
	bh=+BfKSKWqlI1AALMWRDnBgfbKxVWZIsKfVTDoY9LW9As=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gQ1kYfqXQHEm+0Hx8xgojK55Vr2dEaShWtdL6U4fJtAR3tOuA8gOCUElWGVUa5gujC+FtfZ8sMMuH0r7yCHumJV7MnNaVzc85mWjOocekfDQgzuzCHdIFo6WyJHJ/+km4jZJ984VIrayutbVUVpkaOyQI+H+1J32oGxK06Chypo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=e5BZFsRn; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e5BZFsRn"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a2b636b944so1695237e87.1
        for <linux-input@vger.kernel.org>; Tue, 31 Mar 2026 03:15:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774952113; cv=none;
        d=google.com; s=arc-20240605;
        b=RmBB+MBPWz8KwrzkFt2N/KHXLFe4du1meQb6N4lME2KOJ/C6mAzksHtuQW7Ovio0Aw
         xe5wopoWVfT2b5dha0hQMsaYPGDfWqnljOycyhpqyiFhCPpdLqkVv5FzV0RQcMQ18DaA
         2qKAjkHgrn/NSIoUlu40J1tdVYrdNenmCtkeDVYIpLCenfOxKHVfd38sO+oQ1lhItmZj
         AJ35C6h/2Dl0c1MbcP6+/Yx91eFv2qNcqYWuDfFYIZQHOjCPGLcmzXPefK78uBSQW5oR
         6uR0Mwufszvb7yuxkAkqXcZh6d7lm5iyuFdmZKLnt8VgS+bTc8Ah66a8naujd4sIsa1V
         7H+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IwM4Dg0oPoF1Vd4vmJzcbvBl/vV3R15yI0dEAidybMw=;
        fh=H0qSs6mt+7/IxRlRxplX1QhdUnrzZeWAjPzogh2DnuQ=;
        b=Sh8a3bqchj04vYwT6BFC/4R4mAmkugXDwWVUKS9xDmHn53cGO+0iCNvn9K5TURHJUQ
         xdiEPYCMUygSaGdSWpRyyXtMf3PqoRwHDsNY6e6mqLzn+jsbZhsUCeKOzbL8QUB86Xly
         Z7rAHmH0bpTSUA4iHG3Kb/Bs+3YTj8b9mlRseIvcA7bMRRVACMbnl2Afg5hSDc6Ov8CF
         JWo1TTZniQqsW1BXehd2PrWAqQmMGbRDeoQE66rAz1pTn+IrzPJx9HZ1vfjDt1uYZFPF
         9LorlPlhdvwDp6VMLULOtPhqcKSdbYz4jXNyifFp9N0gef4qPe9Q4j8AHXeopDnSzJHg
         1xHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1774952113; x=1775556913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IwM4Dg0oPoF1Vd4vmJzcbvBl/vV3R15yI0dEAidybMw=;
        b=e5BZFsRn/cfpSycQzHhx6SgKcDUhEghskKFh5tjggHr+u1Q5FSqdzgqusYEcSCjvQ4
         exY5t/ZwDAOFgB1YJN5OD0uSazh0rbi1aaNP/EzL2I5FVQPPaHYlBt+YICa2lHtBJrzo
         sufMri1ejYJf8oRnZWnESOlRSYZcHIZ8UGZrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774952113; x=1775556913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IwM4Dg0oPoF1Vd4vmJzcbvBl/vV3R15yI0dEAidybMw=;
        b=F1VCHZhpG9KG/hV8LOaNnGSTSzx/Jb9T9xXu9TWqGxqwZLSHfrB27F+3vOhFcD0RvH
         R5G5NXAYu7umqqqmnboF/8KZ3m2xM8q6S6ONlEy8JYpEB+W0+wd9OEsKWKCIw4XGd0vP
         PsBnoNvY6SYu+mQa4dbFEpctGQbuIede88vRp0RmAvDYr8JGmSC9I4VPV1pJ/hNYPrwE
         vyZkgykHZ1rq/mx2iODlYHPWxNCYXIFRzyF+ov0lLyGR3qiJJcV6xagT/4IBu1qlZ1/V
         r4QTXtrQQwS8g6J8zqpegWOUfNu9+hOe3FgORQcBGY1qKTYiOXTfiemoIAgo+0Cjx2wf
         E4KQ==
X-Forwarded-Encrypted: i=1; AJvYcCWf12tNH20LB5vEwfmhD2OdkQ3B4kXFG41b7p8jM8n6Cx2OJaVbE6Dup3uErWd7MCnKFleVLoOJTVfM0g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnPkft1KmVn/C6U2DH3yeCK3IsNdOCAORqODPXBV/JIL/MHVNo
	K6/44By9imQWQoBJKNrf7a39CUVtWmEy5sy1vc/9tCYb25dpsEi1x953VQMt55RpAeOH+BFhIIX
	Bzs5PxYHk9SyjBwm9mRpx6alepX8oqciLpqFGc9lm
X-Gm-Gg: ATEYQzxL9LcmzKHstVjNu+34y0qK/cd3R/R4QjZiEn2iQBjESYFaX1c6nMT0pXOa2fQ
	idw6IAvEN1ry4pmenqjOtKON1CjKqmS0dMfqG3IESd24Fb2Yg8scva1Z4/U9AxqBoB6dYLxD46i
	bpKoJvgQKj99cD5yltuQOjU9Cwa7raGCh+n+GklqSQCBfJ5ClrS71UytuzKk9Z/1/1GCLxr1Sqj
	SuqBoTz0X+LvS/rjU6hp9JmYJP7mu32tmYsg7vZO9ey7gykuby09z421uj7XZOhrm6hrR72PWjf
	+Np9UBzY4chrAFy8f8+YQ/xSF9rXV7+CgctBXQ==
X-Received: by 2002:a05:6512:10d1:b0:5a2:a5f6:dfce with SMTP id
 2adb3069b0e04-5a2ab7ea285mr5687077e87.11.1774952111900; Tue, 31 Mar 2026
 03:15:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330083429.359819-1-l.scorcia@gmail.com> <20260330083429.359819-2-l.scorcia@gmail.com>
 <20260331-flawless-bronze-lorikeet-59a6ff@quoll> <CAORyz2+1bc9Z-opoNqyUU_WFzyXZKGQmR_Ur=4UonOC=AWtQ8w@mail.gmail.com>
In-Reply-To: <CAORyz2+1bc9Z-opoNqyUU_WFzyXZKGQmR_Ur=4UonOC=AWtQ8w@mail.gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 31 Mar 2026 18:15:00 +0800
X-Gm-Features: AQROBzCSfOwC7PpxPWsVcV8RwypXUnG7y9-g_GLDlmzGCrhYIDEBqda8qgwR7SE
Message-ID: <CAGXv+5F2nMwftF4JvXLuJr8Oz9VSoB1f1qq9mPcMYegmJ6BP_g@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] dt-bindings: mfd: mt6397: Add MT6392 PMIC
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-mediatek@lists.infradead.org, 
	Fabien Parent <parent.f@gmail.com>, Val Packett <val@packett.cool>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
	Lee Jones <lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Linus Walleij <linusw@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>, Gary Bisson <bisson.gary@gmail.com>, 
	Julien Massot <julien.massot@collabora.com>, Chen Zhong <chen.zhong@mediatek.com>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 4:36=E2=80=AFPM Luca Leonardo Scorcia
<l.scorcia@gmail.com> wrote:
>
> > > -    required:
> > > -      - compatible
> >
> > Not really, this affects existing ABI and might make the child schema
> > being applied. Basically regulators node can be anything now.
> >
> > This is definitely not a binding we want. The syntax for parent schema
> > when listing only compatibles is requiring this compatible. You cannot
> > have here whatever empty node.
>
> Hi, it felt quite strange to me too, but that's what I thought you
> meant with your previous suggestion [1].
> To keep the required attribute I would be happy to reintroduce the
> compatible here, in the regulator schema and the pmic dtsi.
>
> Before I do that and resubmit, could you please help me understand
> what you meant before?

I think the point is that compatibles for regulator sub-nodes on MFDs
is no longer accepted.

Instead if you want to have a separate binding for the regulator part,
you would need to reference the binding directly.

Say the binding is at bindings/regulator/mt6392.yaml, in this patch
you would have something after the "additionalProperties: false" like:

allOf:
  - if:
      properties:
        "compatible":
          contains:
            const: mediatek,mt6392
    then:
      properties:
        regulators:
          $ref: /schemas/regulator/mt6392.yaml
    else:
      properties:
        regulators:
          required:
            - compatible

And drop the "required: - compatible" part from the common regulator
node bits of the binding.


ChenYu

> Thank you!
>
> [1] https://lists.infradead.org/pipermail/linux-mediatek/2026-March/10506=
0.html
> --
> Luca Leonardo Scorcia
> l.scorcia@gmail.com
>
