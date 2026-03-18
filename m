Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8794B3D75B5;
	Wed, 18 Mar 2026 12:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773837552; cv=none; b=aVmpR3Smfi2kTzqh2F6sXKEtXI0l9Wsjt9pOiGfk/JlXlwe+YzKoT9LPOwVutUzTjyEjNfrcZSJEyY1VjBFPf/MjZ04G3vsx8bt0+A/1g5vWYJ1D4PBbFXG6ViLaWy7UTXgTiGVptkp4HRafJjZwg1H0EoovgmhMNMk3QDoLF38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773837552; c=relaxed/simple;
	bh=/9GsD8Paw2FG8zbS8w+TdnFQsZUhCwbrgaXvCp6ENE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qu+80n5ygJCjLgaQQDai6mOzUrD3ZO0icTm+Uc4H27efz0vjkr9OKrzIgIr42YCw9fPosAqUgJHh9t4FGCL/H7lmB+rTpbe6gZ20BM3q5WWr1M+J2lUVKVqLQg0c5r9oeh46L6XIq4SYVWIiH6EXC9+PeJFKMOKZOOX6IfTk9uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=oavHusXk; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="oavHusXk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1773837547;
	bh=/9GsD8Paw2FG8zbS8w+TdnFQsZUhCwbrgaXvCp6ENE0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oavHusXkCkB7Kqa5VC0x2RW+xdZIuSLE32GVO8SOJWcjAeukEHxn/HEle9dvPQjZo
	 YpmhpbYQVnKYqeeVNjitJTwB0xV3NmVNNNHFDGYnJ+6/iVWpp17z03ZLMHHP2w5lAP
	 8CX2myd0Eu0aRHM1KQkcsBtgmfMMHCLU3xWiUxQFf4P1NWXRy3HYZN/XjjyNUy9mtA
	 TQ5v/x+GT5ZnIHt8KpnaFukD4BZbBaLM5YRLy9tIvYJNuYneJkphNfV7+oMw+2Pxro
	 lzUU8XFTTB4MOGPiglYKWWa6PtnxlSvNOQVlN71YVkhj05JkR4VF4Zzm5wlJgoRPI5
	 ItYnGPP27d/9A==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1426617E1330;
	Wed, 18 Mar 2026 13:39:07 +0100 (CET)
Message-ID: <8e1ce45b-e001-40a5-9b20-b113e3e6ed54@collabora.com>
Date: Wed, 18 Mar 2026 13:39:06 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/9] dt-bindings: mfd: mt6397: Add bindings for MT6392
 PMIC
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>,
 linux-mediatek@lists.infradead.org
Cc: Fabien Parent <parent.f@gmail.com>, Val Packett <val@packett.cool>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>,
 Lee Jones <lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Linus Walleij <linusw@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Gary Bisson <bisson.gary@gmail.com>,
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
 Julien Massot <julien.massot@collabora.com>,
 Chen Zhong <chen.zhong@mediatek.com>, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-gpio@vger.kernel.org
References: <20260317184507.523060-1-l.scorcia@gmail.com>
 <20260317184507.523060-2-l.scorcia@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260317184507.523060-2-l.scorcia@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 17/03/26 19:43, Luca Leonardo Scorcia ha scritto:
> From: Fabien Parent <parent.f@gmail.com>
> 
> Add the currently supported bindings for the MT6392 PMIC.
> 
> Signed-off-by: Fabien Parent <parent.f@gmail.com>
> Signed-off-by: Val Packett <val@packett.cool>
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   .../devicetree/bindings/mfd/mediatek,mt6397.yaml         | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
> index 6a89b479d10f..22b09e148d7c 100644
> --- a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
> +++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
> @@ -40,6 +40,10 @@ properties:
>             - mediatek,mt6358
>             - mediatek,mt6359
>             - mediatek,mt6397
> +      - items:
> +          - enum:
> +              - mediatek,mt6392
> +          - const: mediatek,mt6323
>         - items:
>             - enum:
>                 - mediatek,mt6366
> @@ -68,6 +72,10 @@ properties:
>                 - mediatek,mt6331-rtc
>                 - mediatek,mt6358-rtc
>                 - mediatek,mt6397-rtc
> +          - items:
> +              - enum:
> +                  - mediatek,mt6392-rtc
> +              - const: mediatek,mt6323-rtc
>             - items:
>                 - enum:
>                     - mediatek,mt6366-rtc
> @@ -92,6 +100,7 @@ properties:
>                 - mediatek,mt6328-regulator
>                 - mediatek,mt6358-regulator
>                 - mediatek,mt6359-regulator
> +              - mediatek,mt6392-regulator
>                 - mediatek,mt6397-regulator
>             - items:
>                 - enum:


