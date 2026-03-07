Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1815C342528;
	Sat,  7 Mar 2026 15:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772895750; cv=none; b=j6P1dMDxkcLR5g3Rmr0m3hKWZ5rVRqZgeIPynsNdSYzVrw82z4WK8hEuMDwRLcxmt9/SQP29V+C0xQu12qHNOOFnp3xm91+c09k2aBu6opx2vdSBpr36cH0QsHpTPaWsDtqNxl87Si3LDrN99sMrtDsOAtT4hz8nQRYKOREkyy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772895750; c=relaxed/simple;
	bh=N9zwgBF8iPgt8yqTJ2wZaHrPhuH/H9yN1zkdEbPtRns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7ukbfHThoz/L8/ytFHBPq/lG4xy8soNLOT6ON2F0KBP/WL1JMjxMzft+0ka32XCuMBbF7FdmRJFVStJ8jJDrr0tk2fGTsCC151OKfGAFvxtLlddMj2aJcr0SZU4L+tLFWjxPdpOWEyvbFC1pC1u1L3GT+wq/qe84jvAPQrQc2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHuXF+lX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHuXF+lX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 215C2C19422;
	Sat,  7 Mar 2026 15:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772895749;
	bh=N9zwgBF8iPgt8yqTJ2wZaHrPhuH/H9yN1zkdEbPtRns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GHuXF+lX/w3NR/FKeipqwmjTxQqtKYOkhCR+t+8Ltqk0LeMbq+R769ceF+FTRDIyF
	 eUsldXhJ+LbBlH1RW3C8ywY4YZp+vZv/HzBvHLviiU+A37iqAQY0NfRmy9il1Grse8
	 5tY+GqfWVlQYwWSBJyaJ1a1/b5pZX+XF+DO6gbbcIbBqQhLk7vj7wkpwnf/RyidjLT
	 jzv89oOYiGVzhrFKTDK+hCvAI25Tgsqjrjz1e17GwSp/b3vmB9tAJOhlPEQ0F1I0NW
	 e1sKTlia0VQ/Onr+S3/tCeMECtbRKPcMxEMkeMcZQAeE80nrd7PMMMED8JhNM2+XGM
	 2j35jxF7k46vg==
Date: Sat, 7 Mar 2026 16:02:27 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: linux-mediatek@lists.infradead.org, Fabien Parent <parent.f@gmail.com>, 
	Val Packett <val@packett.cool>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
	Lee Jones <lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Gary Bisson <bisson.gary@gmail.com>, 
	Julien Massot <julien.massot@collabora.com>, Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>, 
	Chen Zhong <chen.zhong@mediatek.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/7] dt-bindings: mfd: mt6397: Add bindings for MT6392
 PMIC
Message-ID: <20260307-serious-jolly-tuna-b072a8@quoll>
References: <20260306120521.163654-1-l.scorcia@gmail.com>
 <20260306120521.163654-2-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260306120521.163654-2-l.scorcia@gmail.com>

On Fri, Mar 06, 2026 at 12:03:05PM +0000, Luca Leonardo Scorcia wrote:
> From: Fabien Parent <parent.f@gmail.com>
> 
> Add the currently supported bindings for the MT6392 PMIC.
> 
> Signed-off-by: Fabien Parent <parent.f@gmail.com>
> Signed-off-by: Val Packett <val@packett.cool>
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
> ---
>  .../devicetree/bindings/mfd/mediatek,mt6397.yaml          | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
> index 6a89b479d10f..c358b2f8059c 100644
> --- a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
> +++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
> @@ -40,6 +40,10 @@ properties:
>            - mediatek,mt6358
>            - mediatek,mt6359
>            - mediatek,mt6397
> +      - items:
> +          - enum:
> +              - mediatek,mt6392
> +          - const: mediatek,mt6323
>        - items:
>            - enum:
>                - mediatek,mt6366
> @@ -72,6 +76,10 @@ properties:
>                - enum:
>                    - mediatek,mt6366-rtc
>                - const: mediatek,mt6358-rtc
> +          - items:
> +              - enum:
> +                  - mediatek,mt6392-rtc
> +              - const: mediatek,mt6397-rtc

Why not mt6323-rtc?

Mixing different fallbacks should be briefly explained in the commit
msg.

Best regards,
Krzysztof

