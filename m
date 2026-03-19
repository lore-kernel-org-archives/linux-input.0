Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBBE26ED59
	for <linux-input@vger.kernel.org>; Thu, 19 Mar 2026 04:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773896042; cv=pass; b=ZYvSEyo4LmRcDPizN+7PDNWzgQ8xe4rPlprMeTTBJ1cIX1Fs+ekBB7AUnvR+z8+gnjftATPsDewY+UFtHS/8s0t2fTsTok/SpFQdWi0PWmMIHc7MXkBRe7WIuxNP59p0urdm7tt1KUo1haMuDUc70sGI7VGuG8Z3fX6NMP0bj9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773896042; c=relaxed/simple;
	bh=EFP3LExiJe++o/o5vN4IaxbEwciH5djcNFNzyfCnjVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y9b2PJPVjfzB8hRLodc6q0ARDgmQyLEm+utf3qbkTFbXWDlnGRoBT4BbbZpCOpwxyJ6PHyzlKfeyiATMFJgp9ofWZTcw+/6MA/DNl/nx5nmO9bv2RJhIThAY7T/LImMy6Xf2prZpI7wvc38PveSY7w56sFQLgDha8c36eHIsmas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gV+Eq2BI; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gV+Eq2BI"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a13e1cfa45so561843e87.2
        for <linux-input@vger.kernel.org>; Wed, 18 Mar 2026 21:54:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773896039; cv=none;
        d=google.com; s=arc-20240605;
        b=H7OPG2PfgtU4ARiV1b3kK4XxQ7SQ4EEhzTTCk52koDKnf7nspFCGz83qCHZB628H8Y
         7OJIUjKIFRIQ3WAOmy6Bgx4D22qC5VNWpxhKdKKxIQB/0mwZf7n+1TqHmES1mWKXz08e
         LZCC/V3X5r2Zir5YmK2n/Lt6ojQJHFyYwagdYxCwsrdW3+rDxNmOgaTyK4gwY2ItXzvK
         poUphMfjHV5f/doCyUkUmzBnvME8noDs6CKs8yVDqtvEMp5vEuMhzjz7j0LoNOhV0bbp
         OkoZTqoIgfw9QvwvU9bnqHxI+tqlcoyOYHmIPOxFr1DCnviYTp3bzuFeaSdbvnI9M8sP
         Rowg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ycSewpuz2GDH8JHlWYt42sU/cLJKsJubh50gU2e8SKI=;
        fh=NgBGkJwIxHe8zbthbYUHJOG2x9Zm0GhOkz9BPB4+GQ4=;
        b=KUSdJDrOqcUe4Ab7o3ArWlUzkIiw+BIcdfcSbYea8ufFcTc2fR3SLYrD06YR89iSb+
         bKGgAQLW/B6w1YJjIcph9po/DBQxwwqlaHr3QLX8Zbj3Ybj+5hv7z7KWpjJ8+2AiMwsm
         nU3tubz5YsJsABg25H5WsBeTF62NnqXTL8Yty5fG84mdZTM7NCJJPhviq6qmNbTVV/Py
         wEaeiCEijw2wE5/2OwxmDIJNGwMcdF6HxtholOt85EniHrnXN+vi1WADT+CaI8x6JPMX
         OcxDfacObAKGgHAku6m1vHej+dCXH84L9YVFYAOkSEZyThS/y8unBrTONDn0zkE5oITb
         ugxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773896039; x=1774500839; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ycSewpuz2GDH8JHlWYt42sU/cLJKsJubh50gU2e8SKI=;
        b=gV+Eq2BIKKtmoCQOdQC5FlNrQM8p+4HX/PqIIXMiozS+ptENcq+pHxtuZnnbcRm7X4
         N3XZ08QmOOGKMmgzgiA9MVyuk1xGtfZ3uS9ZrVSTpf3emtCfX5CJ2RcvZTTCdddBBESt
         LpNq+ENxnX/JCZ6dcP/etaR4pM7hdQ1317nUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773896039; x=1774500839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ycSewpuz2GDH8JHlWYt42sU/cLJKsJubh50gU2e8SKI=;
        b=BFWTpUs0Q5v4OTMbM/T8lR5qvK/2SYZwApD6mTysc2tH7aGDlJ9aDusnxzAAQrF1ok
         5SbyiNTaCYUuosxBJa6IEPCmiVA5nR6JsGfkcgstU/lwhAFwFHDdkcd40DnfM2K0Clta
         ygbYsmDl9piYr6d1ihCfHnCTUCPehv/oRc+VFNCn94n4sOT+4sebey2zqozZ4kyALOw8
         0npju2jE3o4qKfZZd1iRb0N1vIfKA9w29eRiZznLvQ14PLOUn956/eYOfqhQKgLCysMk
         KNSLCRsKff2AZBfpS7Bvt72uk7E3JiOpv3qCUcC80+aTEitTBI5VlZuK8iQSkvIAlhRl
         QKjg==
X-Forwarded-Encrypted: i=1; AJvYcCVmL5BqZL7e8sabUQ7MpUxn6+aF2uLla2segb5jyjbQQAr5L31QHIJD+xbNX29p0wIG6Z276PIhQ3voeQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzbLNooCwoRTHw/c7Et7jTZKRJa5s/8k54afq1oxpLm7G6nVFM1
	hxCHbyCnEstPXpkgj7Op3zBQayvc2u2MqDv/Ry465j5r7deh9dFgwUz7a0tEk2voAnLsWVCb5VS
	M+egKq2G+nZpFlVMUPpqDx/UyvDJUAB7AxzFXQBZ5
X-Gm-Gg: ATEYQzx0KpCEec8UoG0HFwzXYiYXEOVmXBbnJiASItaK8/UQqGpmEGlJK4aubI0hNE9
	Zr1SJUF+1q4/rptUMy6I6cxPK1q1JThoplV1kv6BER3ulKTyDlcyMrNIi0b2ZM4mOKpavIL3W6G
	2QG/6nhEK0/4ewe518VBqZVrxKl1FZ2/8lO3j4byNJEpHZqMBh33ti4u3sg3uksy8W5a4Ugky7+
	9lCpdytd+Br5fuhIYaul9to2U7SYwUHlx3uisvijF0MJXqYEnKozstbHeXnZBOXywdWbeK11szw
	hk99FymrounffB7saqx+IIhIjtGrnrSfsrWAGA==
X-Received: by 2002:a05:6512:601:20b0:5a1:76b7:ac06 with SMTP id
 2adb3069b0e04-5a279585449mr1694598e87.3.1773896039222; Wed, 18 Mar 2026
 21:53:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317184507.523060-1-l.scorcia@gmail.com> <20260317184507.523060-4-l.scorcia@gmail.com>
 <20260318-nickel-serval-of-tolerance-621bad@quoll> <CAORyz2Laoo4EiLcHZ-ygLiFGW_h8qV7QxqNsMbueM=nov5zH0A@mail.gmail.com>
 <ad0d1ea1-4c5d-4cfc-af0d-8d843e7e0e9e@kernel.org>
In-Reply-To: <ad0d1ea1-4c5d-4cfc-af0d-8d843e7e0e9e@kernel.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 19 Mar 2026 12:53:47 +0800
X-Gm-Features: AaiRm53rEbzUcysiLnjhOdOv1aJMbQDabqUfN6XBRWKQC_wiMRBidNmKXvI9wx8
Message-ID: <CAGXv+5EqUhJ62fjE0R9nLcu6tsfXan8ZEYe7hvkofKnFM7W8NQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] dt-bindings: regulator: Document MediaTek MT6392
 PMIC Regulators
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Luca Leonardo Scorcia <l.scorcia@gmail.com>, linux-mediatek@lists.infradead.org, 
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
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 6:14=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 18/03/2026 22:25, Luca Leonardo Scorcia wrote:
> >>
> >> Drop compatible. Regulator nodes do not have compatibles.
> >
> > Thanks for this comment. It took me a while to understand what you
> > meant as most of the MediaTek PMIC regulator drivers still require the
> > compatible node to probe, including MT6397 that was the template for
> > this patch. I compared the driver to MT6359 that does not use it and I
> > am now working on the driver to not rely on it.
> >
> >> With this, you can also drop example as it won't be used.
> >
> > Just to be sure - do you mean remove the compatible attribute from the
> > example, or the whole example section?
>
> The entire example because without the compatible it will be no-op.
>
> >
> >>> +
> >>> +patternProperties:
> >>> +  "^(buck_)?v(core|proc|sys)$":
> >>
> >> Nope, underscores are not allowed. Use only hyphens.
> >
> > Got it. I will actually completely remove the (buck_|ldo_) prefix
> > altogether as suggested in another comment.
> >
> >>> +  "^(ldo_)?v(adc18|camio|cn18|io18)$":
> >>> +    description: LDOs with fixed 1.8V output
> >>
> >> If fixed, then encode it in the schema - min/max microvolt.
> >
> > If possible I'd like some clarification here. According to Chen-Yu
> > Tsai comment [1], dtsi shouldn't contain voltage constraints. The way
>
> That's odd, because long time in the past I heard that DTS must
> absolutely set min/max constraints, because these are real hardware
> (board) constraints for each regulator, unlike the generic and broad
> ones from the driver.
>
> IOW, driver has what datasheet tells. DTS has what actually should be use=
d.
>
> Also, I did not actually require to make min/max required, just they
> have to be specific/constrained.
>
> > I understood this is that electrical constraints are a matter of the
> > actual board layout, so if adjustments are needed they have to be in
> > the board dts. But you also specify "If fixed", so maybe there's an
> > exception to this rule when the constraint is "absolute" and boards
> > can't actually set a different value?
>
> Now I am confused. You wrote - LDOs with fixed 1.8V output - so board
> cannot set it to 2.0V for example. They are affixed. This regulator
> CANNOT physically produce anything else.

As you said, it cannot physically produce anything else. IMO it doesn't
even need voltage constraints as it is already implied by the model and
regulator output, in which case I would actually recommend rejecting
min/max voltage being added to this node.


ChenYu
