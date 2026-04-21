Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E7240DFC6;
	Tue, 21 Apr 2026 07:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776755614; cv=none; b=txL2q9/1ND/7V1iJAEeGrC3vMdTGTimT62c5l6VSz5DxTikrkI8MYkP37ofM75BZGhbEUdu3N+SuuThIPYvWrvBcvwkpmifqf+VtqcE1uB6QXR5iUyJoBRIsUXfDoN8sRUE4OQYoJn3ENOD2gB6LMWu+AksKWa+TFvptluVcMto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776755614; c=relaxed/simple;
	bh=FBWfjsIqM+7TuqnxYjhjiUQj1QqggKY45UCCbcTaQWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PvEuOZm4yHnwjPE07ThZd3lTP6lZ6pk5INrPKXEBHsTmwx2nwrRGekW6BMbVYGVRM6u4uF3wdYB2vhz0sfq+74Tg2CY/By22KNM7zVV3+rfoZmbgcb8p1yJwBQ4KgZZWId5iTi4puzexBDvS69RJ8SWBZUQAJp5tPacNnbmsqsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rk54KrE1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rk54KrE1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1872C2BCB0;
	Tue, 21 Apr 2026 07:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776755614;
	bh=FBWfjsIqM+7TuqnxYjhjiUQj1QqggKY45UCCbcTaQWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rk54KrE161LTqGHyDseDnQJW9W+VdRSX+EJ2x09B826Rm888eSnDOS65Ig+dvbr2U
	 M48YutSEbjzxtKF8DliJ9DYkjPxNv7U2xOZAyvzdfKzxLKMYamaehk6QIOd5gfumYp
	 IJpMwY2dnTATYIoGB3I/ncrVLTwVKcvY0ycF/HNKq5vBZ73vOXKmS+w3N2Cs7vgrue
	 im3cJtO4Jq8B7eAPaNx8d/rLJAN10ajV0wZYd6zy580tUCsJSRlO1lLsw0HL1dbcTg
	 iNIctkMIRQPn1nx34cpV6hRMZDGgm5YQU8JPq8rbt5P8D1qpCkEPSo9q/aFxJLhN1a
	 +8t7yT/JtC7jg==
Date: Tue, 21 Apr 2026 09:13:31 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: linux-mediatek@lists.infradead.org, Fabien Parent <parent.f@gmail.com>, 
	Val Packett <val@packett.cool>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
	Lee Jones <lee@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Linus Walleij <linusw@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Gary Bisson <bisson.gary@gmail.com>, Julien Massot <julien.massot@collabora.com>, 
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>, Akari Tsuyukusa <akkun11.open@gmail.com>, 
	Chen Zhong <chen.zhong@mediatek.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v5 1/9] dt-bindings: mfd: mt6397: Add MT6392 PMIC
Message-ID: <20260421-sincere-cherry-waxbill-1aada6@quoll>
References: <20260420213529.1645560-1-l.scorcia@gmail.com>
 <20260420213529.1645560-2-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260420213529.1645560-2-l.scorcia@gmail.com>

On Mon, Apr 20, 2026 at 10:30:00PM +0100, Luca Leonardo Scorcia wrote:
> From: Fabien Parent <parent.f@gmail.com>
> 
> Add the currently supported bindings for the MT6392 PMIC. Its MFD driver
> does not use the compatible property to bind the regulator driver, so
> don't mark it as required.
> 
> Signed-off-by: Fabien Parent <parent.f@gmail.com>
> Signed-off-by: Val Packett <val@packett.cool>
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
> ---
>  .../bindings/mfd/mediatek,mt6397.yaml         | 27 ++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
> index 05c121b0cb3d..2866e95e338b 100644
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
> @@ -68,6 +72,10 @@ properties:
>                - mediatek,mt6331-rtc
>                - mediatek,mt6358-rtc
>                - mediatek,mt6397-rtc
> +          - items:
> +              - enum:
> +                  - mediatek,mt6392-rtc
> +              - const: mediatek,mt6323-rtc
>            - items:
>                - enum:
>                    - mediatek,mt6366-rtc
> @@ -99,9 +107,6 @@ properties:
>                    - mediatek,mt6366-regulator
>                - const: mediatek,mt6358-regulator
>  
> -    required:
> -      - compatible

Please create a new binding file for your device. Having two ways to
define child is not making this binding easier to follow.

The style of defining children with compatibles should be followed by
"requierd: compatible". I am rather against of exceptions, unless needed
and this is not such case where you need one.

Best regards,
Krzysztof

