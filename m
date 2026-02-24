Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D42839E6F9;
	Tue, 24 Feb 2026 14:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771944674; cv=none; b=evuh42E0Pr08DhigG+uzRih5tr0xOckgQ6qnLHjokr7SbPo7vH0xSmGJPeura/xJ3jmQh3iDZc7xEBCYsh3jMOcjbPOymdIc9kKieuKnMpkIMCirXHZxOckAoLm33HQXTOJHgMSJPoNeGeAKXxsN3gJ0Z7bz1Qdl0+ypALofa+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771944674; c=relaxed/simple;
	bh=WE8HtYcRtSahVo/SKZ+DqmPNKUcoMSnUp2yT1VcZd/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hAz6CF0gNTwF1euqm73Zp/ICIUmy0DLKM3LoBl2l0ujb1gFHbybDBEL3zVZw+e14aLJtGKIwX7NSeCuG0J3FajWH9638PDZzw2zZ/TC31SpMGQ1GXl4VFhUiB0f5v0JRsfljlxLhnH4PMi8erAljldcixRgGBhr+/j02gVvdI+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cD2sSTvK; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cD2sSTvK"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 667B04E41098;
	Tue, 24 Feb 2026 14:51:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 24C245FD9D;
	Tue, 24 Feb 2026 14:51:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1CD291036918D;
	Tue, 24 Feb 2026 15:50:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1771944664; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=vv63Bmk8v8hQ7TUParpNLdhU99o6I3+yG2U0bzr7vMM=;
	b=cD2sSTvK9wDOM/N20TtC46mcK2bV3UBwXSPqsbQTDEs6c5NyXjf/DCEa3yMNuckoA+P5KB
	DieONpwghmo3ZeTv3jcgCKxiIeaw717hsi/FDLOyIzct2cPf1A4J7wF8F7j2V2OIaFdyHX
	gzmEKYrZ03o6cdoLelmJpOoZfSSB/1GPE7iy1YPF3O01o5GHs2rgoRqwOpOxIbPtL0wTxx
	0k2ljd6eulJfXgGIiCspal3DXsuVS1hfScxP24FUdWLoZRqbtEv7YVOlYLzuEPwbpGXvqt
	vdnG/K/WWHxudvj0zQHDR/mnbJr56zdLLFQOZshOw4/Agz42COIEf9F6FVm9Dg==
Date: Tue, 24 Feb 2026 15:50:56 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: linux-mediatek@lists.infradead.org, Fabien Parent <parent.f@gmail.com>,
	Val Packett <val@packett.cool>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Eddie Huang <eddie.huang@mediatek.com>,
	Gary Bisson <bisson.gary@gmail.com>,
	Julien Massot <julien.massot@collabora.com>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Chen Zhong <chen.zhong@mediatek.com>, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rtc@vger.kernel.org
Subject: Re: [PATCH 1/9] dt-bindings: mfd: mt6397: Add bindings for MT6392
 PMIC
Message-ID: <202602241450566c680722@mail.local>
References: <cover.1771865014.git.l.scorcia@gmail.com>
 <c5ce038359583c5318c2d5ee341287c213aef880.1771865015.git.l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5ce038359583c5318c2d5ee341287c213aef880.1771865015.git.l.scorcia@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On 23/02/2026 17:12:40+0000, Luca Leonardo Scorcia wrote:
> From: Fabien Parent <parent.f@gmail.com>
> 
> Add the currently supported bindings for the MT6392 PMIC.
> 
> Signed-off-by: Fabien Parent <parent.f@gmail.com>
> Signed-off-by: Val Packett <val@packett.cool>
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
> ---
>  Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
> index 6a89b479d10f..5f422d311d4d 100644
> --- a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
> +++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
> @@ -39,6 +39,7 @@ properties:
>            - mediatek,mt6328
>            - mediatek,mt6358
>            - mediatek,mt6359
> +          - mediatek,mt6392
>            - mediatek,mt6397
>        - items:
>            - enum:
> @@ -67,6 +68,7 @@ properties:
>                - mediatek,mt6323-rtc
>                - mediatek,mt6331-rtc
>                - mediatek,mt6358-rtc
> +              - mediatek,mt6392-rtc

Shouldn't you rather use "mediatek,mt6392-rtc", "mediatek,mt6397-rtc" as
the compatible so you don't have to change anything in the driver?

>                - mediatek,mt6397-rtc
>            - items:
>                - enum:
> -- 
> 2.43.0
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
