Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792548893;
	b=IUoPYLVDvohlLbsnBdytnmxtuD+lTwHKcY7/zqjG6NZ/i30avIUg4xJ6WMR3L1CLmcvr
	 qANX6DQ5sKXjYZMVu4Lp3Gey4W79WRa7wNlylOIqMYsV04pWy91YfTarnulJeLk6WQEDk
	 yMdIjDAKZ8k0XvSYJpDCzr2Rc8VdimjB6sbdCJJLeD1VhRo7SmdmbypehnubxOnFwQrF0
	 Nsz5GTvl9EAhTsqGYcTYsdsYOUxu+jucnnHB4ysNFr+7Hb1Sicl93vTm26rf099IYsPHg
	 BANbGox+6sFyEROk9Yee19mn0J7rJq+FGO2N2VXdEm/ge6wQHOjsArK2Wx84i2OaNnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792548893;
	h=Received:DKIM-Signature:Date:Content-Type:Content-Transfer-Encoding:
	 MIME-Version:From:Cc:To:In-Reply-To:References:Message-Id:Subject;
	bh=fbPRryJ8n9XhLJpBCPRDsYKT7tAPTsmQIcGjUBmw0wA=;
	b=aEp9Zhi3kYXQZBfv7UoTmiINvXjsbkZEPxylhcK5up8DhEFjA0rYxhKISV7V+HHAe0mC
	 8fWr3ZjjB7IU3wBFyw0w2W/bPeb8JBND9UcbF7W4CdSjhfVnO8j10FQVtG4u1JchhChK1
	 0ZgTwaCWJYlVc27874ArHXcnF1/E1dLgdCY1hxHNNl135mNBU4ig960PNoDBrazoadfqh
	 d+0PLjsCX69PygoPvw2wbGsqs5M+0l+v3bUHjMPL31jIRagO4IbW1+fWKnsUwwMgs61qN
	 3vlCe+/5zb4N8EqEQoHK0INK/vHUOyhsFLIk88HtYAchrEbhyl96kIEs2LE7/UVfqtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="AQK54XH/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A4B606A31C;
	Wed, 21 Oct 2026 02:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AQK54XH/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29A871F000C9;
	Wed, 21 Oct 2026 02:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792548893;
	bh=fbPRryJ8n9XhLJpBCPRDsYKT7tAPTsmQIcGjUBmw0wA=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=AQK54XH/NenajOYZnX0q/PdIt7svKjFZwieZ/EtVcj8PC4HrSuE3cZFlw8hW146TF
	 Pknq2XyUVJ5rFTZ4OD0VNUTe1cqhjGsFUpR4vD0RIlWUYnzehEVj0I72y5dO6Z4jZu
	 sDniZF6/CZmCTnPzBbtqXlgo5hgB33bTQF8tCnwaEgrFuE19HSrth8aWoVXpF0bNkS
	 j4SCuHT38hfHqaTXJpJfYvNv5OfKhCgbYJ+YTq9Y+7Yf51NlTc2kmif4O8kTkJ8bv+
	 Lo2f9sarltbTkplNxd+3C3Tbfh1UoWtPGM60U6qe5AOfOlu95vD9AyDttE1gckwYYd
	 bmI50RAwkl+nA==
Date: Tue, 20 Oct 2026 21:14:50 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Macpaul Lin <macpaul.lin@mediatek.com>, 
 Sean Wang <sean.wang@mediatek.com>, linux-input@vger.kernel.org, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, linux-pm@vger.kernel.org, 
 Fabien Parent <parent.f@gmail.com>, linux-gpio@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Mark Brown <broonie@kernel.org>, 
 Sen Chu <sen.chu@mediatek.com>, Linus Walleij <linusw@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Val Packett <val@packett.cool>, 
 devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Conor Dooley <conor+dt@kernel.org>, Chen Zhong <chen.zhong@mediatek.com>, 
 Akari Tsuyukusa <akkun11.open@gmail.com>, Lee Jones <lee@kernel.org>, 
 linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, 
 linux-mediatek@lists.infradead.org, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 mfd@lists.linux.dev
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>
In-Reply-To: <20261020173556.632798-2-l.scorcia@gmail.com>
References: <20261020173556.632798-1-l.scorcia@gmail.com>
 <20261020173556.632798-2-l.scorcia@gmail.com>
Message-Id: <179254885010.3549549.1306117296712722010.robh@kernel.org>
Subject: Re: [PATCH RESEND v10 1/9] dt-bindings: mfd: mt6397: Add MT6392
 PMIC


On Tue, 20 Oct 2026 19:33:22 +0200, Luca Leonardo Scorcia wrote:
> Describe the MT6392 PMIC and its RTC and regulator devices. This device
> is mostly based on MT6323 with some similarities to MT6397 and is usually
> found on boards using the MT8516/MT8167 SoC.
> 
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../bindings/mfd/mediatek,mt6397.yaml         | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/mfd/mediatek,mt6397.example.dtb: pmic (mediatek,mt6392): keys:compatible: 'oneOf' conditional failed, one must be fixed:
	['mediatek,mt6392-keys'] is too short
	'mediatek,mt6392-keys' is not one of ['mediatek,mt6323-keys', 'mediatek,mt6328-keys', 'mediatek,mt6331-keys', 'mediatek,mt6357-keys', 'mediatek,mt6358-keys', 'mediatek,mt6359-keys', 'mediatek,mt6397-keys']
	'mediatek,mt6392-keys' is not one of ['mediatek,mt6365-keys']
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml
Documentation/devicetree/bindings/mfd/mediatek,mt6397.example.dtb: /example-3/pmic/keys: failed to match any schema with compatible: ['mediatek,mt6392-keys']

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20261020173556.632798-2-l.scorcia@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

