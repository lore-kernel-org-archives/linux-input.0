Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792566389;
	b=os7DafdoBumhnVSp3sCdpJvKGxZLoHn64IXSTnK2/9Q9hYDZtXUlcL46XbW+o65FgSXs
	 NsSSSQI2D7B/Jo4ksBEFmsb+fACdo8NVj2TC1vIWUuCpjdZwpo0eBGJv4WQCbbsaYe8+w
	 /6JEHaP4TVOZr2M5Qyhzm3a+atdh+tryYDxyZIjGz/vVEiPCjFpCCyX9ScjBffBzJABtE
	 /QLgpwnw5LAmY17wkD6rEwxUs6Ojrf5PqPpS+YnbiP3sfOoxkHBmfP25TXn9P/Kr+4g1i
	 nsO1ObrlA1dZhEgW98bEjcF8D5vFB3noabxe5YfjFpz3NZk6T56Yg0SC+J7x0ALk80w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792566389;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=MrXSvMObVmUzW/wExlXkMf3oMLCJJTWEEpBTKn/sJ+Y=;
	b=V7rPZpZ3tDddk84QVPLo78nSbLBAFmKIgafonyLHpJ4lB4zkWTKkS8eRxFNM6PzFTJcv
	 /I8DowwccBESjmEgVHn2qYs8PP2XFGQl03oMEg4WVpOcMegygn6D7/wNw6spD6gOJwoad
	 cZz//6Ujs1Z3NnOsqIBfK5OxyBD7Rm45lE9iumIUsHeNcKwCHNcpe2+BJ41kV6F2xRau5
	 Th0I9OBrDVe9oNbLKPewf6FvT3aLn4pnz0nzAnmM+cVuiO5V4VfCBwexO/vF7+aBLxs66
	 q/uPwc2Z2/jWt6fvFfLRmhNsuRvxltjDa6WomoNuBDUQ619iY07ONStdFhCCk7M2l3Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=C2aW6AfO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2827606A31A
	for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 07:06:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2827606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=C2aW6AfO
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6afbc363efeso538415a12.3
        for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 00:06:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792566387; cv=none;
        d=google.com; s=arc-20260327;
        b=MXJEXpT+lIyF5NOdiDc85ZlgEo60lxlrmKvMDv9fLJeJN/lq0PLKbd4TpF3z23vGkL
         YNFaqjn9/D1ySbDWIXrp/DLaINqN3BvXTfN/Mk5a6pO2fevxeTFtAH/mFWLclJ+aaB2d
         5CsXt3N9vdVVrBDA+GS9WIB5j4HbEuzgUbjW/5NqlWBKwYYJUUStdO+bhoY5MH/ZLijm
         /8QbKz4u19QsCmjB0cpJjSxDgdT/YDpOvO3dh3p7dRxAH7ToEwYeJ5h5m4d9Km0HD/Lu
         aJ2TgFEI65G66Th1Qh7SyLPww7Gh5mMBD2UIfe/ots01Tj9BcGlKFOuW3Ia+mo6D5hQP
         gO7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MrXSvMObVmUzW/wExlXkMf3oMLCJJTWEEpBTKn/sJ+Y=;
        fh=zcB+dAPRIVTcXfj2jOno+mPvfXEetMbdghNYgik1gsU=;
        b=JsqjVBQpx+BeOazfnMpKonIbiOtlC17tsdx4idAcSj4tu3PMqrIA9le7Zn+BgSZqSv
         WCsuk8BkQedPkZF+VAn3E70g+9uMyKoy5HDUDZ0q3vGHGi7C6gwVFKwa/xcMWFJkOqaE
         ytKAS4DcD/z90ZPDR1wmocJA+a2bbMsajsJFumrMeA234ynmpyXmkzs6QGyIbLILulZ3
         Xlb7SqjF3zC4Yx6cdbEei+Y2Gdr2vsHv40hFEDTf/ho9yeAvut0WiPa7U2pXZuu6eQUF
         2Sq19MooWdsCNwD0C4SBY+rgF2CtggjHK6wcSaOrB9ROhUynOEphfSl0fn7lBj92T99U
         tMRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792566387; x=1793171187; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MrXSvMObVmUzW/wExlXkMf3oMLCJJTWEEpBTKn/sJ+Y=;
        b=C2aW6AfO2tXqS0Oxlx14bTBMVNZFQOYYIP++4Zjy0XAUzXRNiZIyd/we1pVq076aHi
         iVYIhUPzTRpHWbk8TgjZRClfvVa/ZIrYZGMbZO3DJMSCV5UIvg3fS/yC6mcleMkr5AZl
         CDc9kVye1E9N/IkJg93m7mi7sqO0whCAZMX9QcPqw07cX41RvUCWYBX2Ni2g9I4qZnBc
         vQc5Edq7qEPfSyUtvQ+/172O9D4MiKBbq1sWvU7Tk2+K4adLUinXmEHtrQ6sATHMl6NQ
         saHvu7vFC0jl/+EFXD61TpmMKJksXH1W78BY/OXH4ikoNly2no/97ZmvjpXcLfZRBf40
         7B3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792566387; x=1793171187;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MrXSvMObVmUzW/wExlXkMf3oMLCJJTWEEpBTKn/sJ+Y=;
        b=ZBqZqTAqK9tgCDj5STz0JFJoC8+Ep5deBSE+NDJVWvqkPpIM2vMH5YfWJjCZrhS/I7
         9DhHBrE5PPFJLna8knvS9MZOzpy1JmmUB5A1zXN0frvb5oszNFrOw56OcQjd2ZGpDfjp
         ODnACiwIZpIGfcjkPxL29HhWXy9+Cb1EpMdVMgEdXi5BPi18J5R4nDY20nR8eFUqrPgY
         cP1E4DI6na3QRJxvYeEhG20EhgraB1G7Ipoe18pgRl4pOTP1o447NjylwYW+7tjl+Vnn
         EZ/SDpbjBFrUDabqL47DWt14i8llHPQsd+HA3J0Qdy4Mg2hr0fXFmGocAf1SIm31ADXN
         u/Ag==
X-Forwarded-Encrypted: i=1; AKwUvBzzYj4uAkpIfvjyEZJCoaCXToz/CD0txOvasfDRcIlm1LU0bmTVuUcRp6LToJgrnFr9XbAj7FXGlr0AGQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYKKq/M//4a/ojoXea5V6Ub1suUKwhylQwAG85vvMtRvlRdpkqk8
	iE8nT6dkX8Cqcpa87NL0tshNK9OrEchMFKcc9PnfPDYN4pHg8mH1ca9cf9WfG4TQAZifWHXsVaO
	xAyXgq0m//gE5XIhPmwodTeVdSb9V2kI=
X-Gm-Gg: AYBFou1i7BtLj9FB2nz65kOObqPoLSIQzb42sTGzTTtxoPQqAnQouEAtTEPRxh8Y34i
	G6SrwKC+Ml30YmLoJ/GRkn1Q7EA4hFn2JeTgGT4BHVgB+9NhtshKlCex6A4U4TIrE00Tz8OGa1O
	vBJgC4k6oga8orEn5zg4wcriJpoVmjrt4CYdB8UmYxl79bNCMxgZ3S0GjgtnGophVj8UjlWBdi0
	9PKhecUn+Je5reK1OP1P0Ra1qutRgE7WM8XVHNWn+kpyFJwQZTwAxeJnnmUVRKRLSw6kAvzwsUZ
	VdfPfAnCPJrRQDztnAISZaKlwbEQ0lZrjHqSGl4AdekMFaPGNzYMNzVTJmZ80VkHrB8fOyhq6+5
	ljmrxvLu8EIKswwbEMZIGTiO08eKgjBUQhNk=
X-Received: by 2002:a05:6402:1585:b0:6b1:cea1:a011 with SMTP id
 4fb4d7f45d1cf-6b40893d0e9mr633902a12.0.1792566386899; Wed, 21 Oct 2026
 00:06:26 -0700 (PDT)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020173556.632798-1-l.scorcia@gmail.com> <20261020173556.632798-2-l.scorcia@gmail.com>
 <43b58ad7-5934-4895-b48d-5b5a7b92e253@kernel.org> <CAORyz2JaJ40+F1oyrvY_0WdqH=fritbPuuQaZ98sXagVayZPLA@mail.gmail.com>
 <2426ffdd-9438-4166-a67b-96620650a59b@kernel.org>
In-Reply-To: <2426ffdd-9438-4166-a67b-96620650a59b@kernel.org>
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Date: Wed, 21 Oct 2026 09:06:15 +0200
X-Gm-Features: AclHuK9050nRGHSTN9753pi8bjuF0vHRU3cnUbJida-ygLIdS4pPdAAtcMwmgKA
Message-ID: <CAORyz2KsozjmcDCd+KVfvLokuxs-YAP0E5yJawHECu9pbPQmKA@mail.gmail.com>
Subject: Re: [PATCH RESEND v10 1/9] dt-bindings: mfd: mt6397: Add MT6392 PMIC
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-mediatek@lists.infradead.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
	Lee Jones <lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Val Packett <val@packett.cool>, Fabien Parent <parent.f@gmail.com>, 
	Akari Tsuyukusa <akkun11.open@gmail.com>, Chen Zhong <chen.zhong@mediatek.com>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mfd@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> The dependency of this patch. This one uses compatibles defined in other
> patch.
>
> Just apply it yourself and run full testing - you will see notice about
> undocumented compatibles.

Thank you, now I get it. I had already removed the example from my
testing branch and removing the example also removed the dependency.
I'll run another round of dt tests to be sure and resubmit without the example.
