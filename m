Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A943356762;
	Mon, 22 Jun 2026 06:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782111151; cv=none; b=TLaCC0s7AsGjcst7nDHC9e9He3xCOJQyopKN2yIKyahQJX3nXDsbTu8KLvGOzUFsge8NLigoPqZXfNII73HeqXLlcbfB6VhPX+UxFfP7rzXWcwB6Xm4UWMW1Co/dHIZdNQobo58OqmIu6vh8jg259yhe3+BJUE6yCmSD9aGmk3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782111151; c=relaxed/simple;
	bh=4mO+JB9kWvCwCBFhPfdi368u+MzOhbrx/bSV/OR4/Pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJECqkJBnT8tU1EIXRjMvRt1/89WNPW6V1KKBUTCR9fKzFQyVq5TN6UXD+NhL1NBEYfQUCQNNjkHzLtqmvmdm7Wnb22AMaXaYzF0JyMt78JcVZL1h/wA5gy2EKG+fC03R6bh1JL+4hS7AUhkvEXFqst0wCKHZNvmnSGbO02Q4G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F1V+JVAD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1V+JVAD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D021F1F000E9;
	Mon, 22 Jun 2026 06:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782111149;
	bh=K9yXc4y5TjSK3lJ8YLzi5eKybWJ0QmDtjiJE8WrpXYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F1V+JVAD9trv53sLLNI0iV+YhGCMKyzDcpRbwvmYVkSrS0sStVnE0N/AVl+aU9J6C
	 k6IGomCbSWF/kXzQh/+Ajm5ON4aU/DE0hoL46Xmoccvz1Xl6HFq7LC5mSHofd6x/Sw
	 F5Q1Ftzug8RO+ROJSUDM0GekGn83GU0hKcG3kNMMWClzSew0eDhJf/S4nrEAJ+ls25
	 aKZe3b45rW9FUW1/4gwW/w6QyHMr8Aeb5nOQBqoQB3JnTlDG7iNsBYnm3mK2V+2hIf
	 P1n72+fSuu6ih+qkkCgzm0UnOVOhITITjXCuIdF4sG3j5S9VyFlCwa/0WS51ZtwJIU
	 6TH1T3MdhNojA==
Date: Mon, 22 Jun 2026 08:52:25 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: linux-mediatek@lists.infradead.org, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Val Packett <val@packett.cool>, Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>, 
	Julien Massot <julien.massot@collabora.com>, Fabien Parent <parent.f@gmail.com>, 
	Akari Tsuyukusa <akkun11.open@gmail.com>, Chen Zhong <chen.zhong@mediatek.com>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v9 1/9] dt-bindings: mfd: mt6397: Add MT6392 PMIC
Message-ID: <20260622-independent-auspicious-saluki-f9e6bb@quoll>
References: <20260621081634.467858-1-l.scorcia@gmail.com>
 <20260621081634.467858-2-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260621081634.467858-2-l.scorcia@gmail.com>

On Sun, Jun 21, 2026 at 10:13:26AM +0200, Luca Leonardo Scorcia wrote:
>                - enum:
>                    - mediatek,mt6359-rtc
> @@ -99,6 +107,7 @@ properties:
>                - mediatek,mt6331-regulator
>                - mediatek,mt6358-regulator
>                - mediatek,mt6359-regulator
> +              - mediatek,mt6392-regulator
>                - mediatek,mt6397-regulator
>            - items:
>                - enum:
> @@ -663,3 +672,69 @@ examples:
>              compatible = "mediatek,mt6397-rtc";
>          };
>      };
> +
> +  - |
> +    #include <dt-bindings/input/input.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    pmic {
> +        compatible = "mediatek,mt6392", "mediatek,mt6323";

You already have three examples, that's rather close to max expected
number of them. I suggest dropping.

Anyway,

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

