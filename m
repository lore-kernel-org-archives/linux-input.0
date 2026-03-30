Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5DF39EF17
	for <linux-input@vger.kernel.org>; Mon, 30 Mar 2026 07:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774856366; cv=pass; b=E+valQTtBLYgn7w/KK9/XKNhJtWI7PNPjXV9RDykFrhsamRnaHY6Tw9Cm7jjwmHy8sewPBbN7jt4gU3wmY/DEu8S2+YljyvqocdNbIfkY95ikp4hFzzY9MDMKi/kJjEKzAr26Hix7yr+6vCjl6RQI/Pe5YM3APA8vBUW0GMN8sc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774856366; c=relaxed/simple;
	bh=zYnQOFZ4bGFIeTmozNqeJkBObILJLvK0jBuil+gfMNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MkI0Z6KhQXNYLXdKI+Iz5sWbb5jbkwMJtydkaGsTCi9BiwHy/sPwLBDWlZ/EIkBj67hCos/r1Z8JvX8SOq9nq0J6FpwgngpyC5LtgkL/gJhbiKVBGgknQSv4SYoZZpPFH/rbydabK+uWBpsbsdM7Zco7PE3hnTQ8kVVCzbsWR1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ltGT/++V; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltGT/++V"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-66abe08cdf5so6323998a12.0
        for <linux-input@vger.kernel.org>; Mon, 30 Mar 2026 00:39:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774856363; cv=none;
        d=google.com; s=arc-20240605;
        b=Bo8qZWAXnK9LcaLNDxzFZcHiTnQaxmx5nQBOnW607YdklzspqqheTKjFz8vY+zbief
         JLSSUraDErn5bAJhHBUHfe2xMAnGjEzOmu5unPNdHA1Nr7Gq4gu9+eDxruz/6rtjlebD
         M9alx6TqhRkgiVLoBlTiBmBqieiYN2LUYt5uF9pZglH6iJTi64kjp3eECtZD43CIQlcC
         rjfoFcBCHVYzzCRuFrPgujOSC5mNGXD4qDmpiswzNcTMrevT/D8UonwChH79CM7WAsot
         r0R6MOWp+bYLcSS6ccQLFPHE5Z+NEoMDTLY5WN0XXxf+vDBKOXaT85958GA1YcskrlXE
         Kh4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=zYnQOFZ4bGFIeTmozNqeJkBObILJLvK0jBuil+gfMNk=;
        fh=K9bZbQHt82i2KqK4VpEGc3JCUEj6O4fX4UQo+aty+L8=;
        b=i8xOq59sK/tvAwTK1ovjnrJNeLZDIOlexVux0XLgVF+GvB6sfKW1YFsTlHlAhSiRjZ
         W0YzNZ2gLEtwwwRIz/48ainuJPybVqWcrH9v5cwShjV9GAwlcOlWSB/twEtXcNzg7ldB
         MKcgpE/kwFp+W/4NnojzpUF8K7PvOddcmnSwOcg7CfPWfWq9sd4/Qhv+weXHRtqsk71x
         WLN1UVaqov+7NBv7NUCy+z5xNprvwYSV2QsOE7QM1bIEyDeuA5rW8m7ENBXUSpXNfp+v
         J7FtnJ8gXZGHPQVfnstLup1AZ7ciySDGEiSqZeChDkzXXFTceO1qfNSP3gSZD6NfBd4e
         oJmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774856363; x=1775461163; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zYnQOFZ4bGFIeTmozNqeJkBObILJLvK0jBuil+gfMNk=;
        b=ltGT/++Vw0wLROzvE0ZJl7pTg3Cu8NEOafpbs0pE8r3RpE8q0sJpAfXfzjUWl2eKao
         CwibCxdmVAMROEpagKD2P2BeipXDsZxOnJFg4r0p1SI3Yxt3GNT45BOnZwwLk95Eo4Ur
         bic/mmzzsS430V9YyHZrF1oEuD07CcJd9k5Xpfei4bC7LfoMpiFCPtea52XCLajH1NFL
         w0y8A5r8REZkulM0KoCdY+PSvUpt12E0BymdQDrtioO5gbl3BEQKOToNLoa4Q24RP4EU
         migiCy+shBWDS5wRco4kXyBXokQ/DvrpRXnXp/N/8qO1ZGQyZXYdOlwrIUfNsxc9mpWJ
         iQzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774856363; x=1775461163;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zYnQOFZ4bGFIeTmozNqeJkBObILJLvK0jBuil+gfMNk=;
        b=BmLKYBkpZNiM+v4ocZ1s1DyPVNzPhKwcmC4FSPhCRAG+kC1v55hU8RLsCsJcUr5RIG
         h0NFJG6HP0Gm8p5k9koAT9fFXiyzqnLDrm9DUAqYFLeEiIrJHlrsJlCmFEMQ6clQeVFg
         FYMSexws0Z0qAade5mBZFPEjI1DZv5uI68ifSVPzhO1NONpqB8hpAjm4nCaNTwxhQWCl
         WgFXdFs5i3Z7otJk+lZlluc4Wjb4azz4RWKFcbFc/Bty+bGb1Hlh5f+jVJOTxZKl2KBX
         OhGHiQFDR2JYDG/c1ocQHywDxsu6BvmeNXMoUOrsJ1HJu2l4XVAWr3tiN2DNJkjGQk9s
         E8oQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlzubuDve7HQIa2ST7uQoe9H1E1RxrWJ7J0iATeILNLXT6CxlSdiMyF3clAQy0vqcrBIydAVOBcwMFOg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzETdo52qqYSdV2wRMjVl4gYZtnIMxvW8F2cljBALtbtVNf7wcu
	X7117l6iKUyIVM3MfVrIfUlBhtpBjgJEOTLeQnBUauRlbr8niACidOHTU9ttA90Gtj7mIZgIYce
	iVb4uVhB54DwB3aANBnoQrjOUKciJ9A8=
X-Gm-Gg: ATEYQzwf/e5e8xtI4Xr5CmkQscdEvXQ/JlfnK7VT3iPAqKuk4Fz036ttdm/XuoR0K3K
	tcRrCbYoNU50wS4f1McFplxKvw2I87TaAMoxMZ/BPtTcG4u+kgUNUzvvhgmXll0P9G5gLcODNEX
	QBX3LpBN4iVHzKyq/Ip9vJhV1IkggfNry0XseyQ0PXRlXdehcR8NFAlVQoGFLL0ij4gn4/h9p98
	TiP8wtv+cYP83f53k/kyF9aGN6vwS106110z9pus8y0FCitDANwVWW1T09wx3tInpYeA5kKnqaf
	l+Fd+g==
X-Received: by 2002:a17:907:9621:b0:b98:13a:c92e with SMTP id
 a640c23a62f3a-b9b502b5aa6mr732407066b.2.1774856362950; Mon, 30 Mar 2026
 00:39:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317184507.523060-1-l.scorcia@gmail.com> <20260317184507.523060-8-l.scorcia@gmail.com>
 <CAGXv+5GmDtrtFHJXs+fDyF+dZ5YW-TSEqXnPs2xCH8cu-Xcn9w@mail.gmail.com>
In-Reply-To: <CAGXv+5GmDtrtFHJXs+fDyF+dZ5YW-TSEqXnPs2xCH8cu-Xcn9w@mail.gmail.com>
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Date: Mon, 30 Mar 2026 09:39:11 +0200
X-Gm-Features: AQROBzCKAAw0QfB5IMl3n57JlPRQDr7IJq4vT7zpNh4df3HsPMVBkVCKdEdIBnw
Message-ID: <CAORyz2J355NZH=7iQ9sTDBhAmtjP7xTpXe21_3Z9J_R5YvdXAQ@mail.gmail.com>
Subject: Re: [PATCH v3 7/9] regulator: mt6392: Add support for MT6392 regulator
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: linux-mediatek@lists.infradead.org, Fabien Parent <parent.f@gmail.com>, 
	Val Packett <val@packett.cool>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Linus Walleij <linusw@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Gary Bisson <bisson.gary@gmail.com>, 
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>, 
	Julien Massot <julien.massot@collabora.com>, Chen Zhong <chen.zhong@mediatek.com>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Il giorno gio 19 mar 2026 alle ore 06:04 Chen-Yu Tsai
<wenst@chromium.org> ha scritto:

> If this PMIC is anything like the MT6358, then it has 0.01V fine
> tuning for most if not all the LDOs. It is sometimes needed as
> a rail may have a 0.04V boost that would otherwise be invisible
> to the system. And then if you have something like 3.04V set in
> the DT constraints, you end up with something the regulator driver
> doesn't support, but the hardware does.
>
> Please see how it's done in the MT6358 driver. I spent a lot of
> time on that driver to make it actually support the full range
> of voltages, and describing the supplies.
>

I had a good look at the datasheet (MT6392 PMIC Datasheet v1.0 08 Dec.
2016) and unfortunately I did not see any fine tuning option in there.
I'm sure this data sheet is not perfect as it's missing some regulator
registers that are clearly used in the Android sources, but there's no
mention of fine tuning in that code either. I guess it does not have
that capability.

I will shortly submit v4 that hopefully addresses the rest of the comments.

Thanks for your help!
--
Luca Leonardo Scorcia
l.scorcia@gmail.com
