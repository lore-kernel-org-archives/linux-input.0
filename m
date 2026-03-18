Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD8B36C588;
	Wed, 18 Mar 2026 07:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773820051; cv=none; b=owouuG7MRaUxpDIJPWHftA/4izLLiw4Pp0bgdxmRVeInt7XhLmjlJVzA4A7JPMpPbX7WxxqCfqYmlESrre9cl+Y3eR9xugV4t6fiLCQMaoiAiZPM7jRwao1YJGEiHsaTjbbdsLuGuP5zdtxrL9ssHjYGNVLS1AIpwyjMLtg/Js8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773820051; c=relaxed/simple;
	bh=VDiIhLFFonrPUteX43LY9+5XNgD2tV9IN6RK86KlBeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gnh3REHTjDZPeJtZBDxMJD4yUCZbndFjozav+HNvIgLzZwyaswdn2/uHTr5Ubxjv6CmUAdJjNE331wucxaOSA/s3YRLoraXIAra3/U77GO3Lro/aUgEv89RLxLEcfyE6rCNp/LE4OANxTFinMPGbntTgGoNyNn52pukp7m34yFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TDz15YjX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TDz15YjX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06ECBC2BCAF;
	Wed, 18 Mar 2026 07:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773820050;
	bh=VDiIhLFFonrPUteX43LY9+5XNgD2tV9IN6RK86KlBeE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TDz15YjXx23S4PukSS4zG1ixMHYOaF0o2HiXgBgyWaSJ1KiBKSJ0uUoLB4tF37Qvp
	 IbynjUFxrG+U/quK/7jTBv2AfWXcVN5b3kZ5PmSIsgoPJttKoCrDVPM6yffQgVtCog
	 n84PUu9HcvMBBcalXHeNSIk4eAZwXcNBHguMgFCX8z+w3218Dr9cZCKF7wFNuM9wrZ
	 +s1Hk1mZSqigFCbgTu2QWBS39p8oErfj6L7Hz3IIURBLqyb1/bCLjBPEJaeR7bIbaD
	 POLoSQrWMke1OYFSYAgDwK/NXr/h59ccz7Pw/PPRvCxjPfwFOCwRWFVZ3ySeOeEvuU
	 ZuUMe4SXyU7fg==
Date: Wed, 18 Mar 2026 08:47:28 +0100
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
	Gary Bisson <bisson.gary@gmail.com>, Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>, 
	Julien Massot <julien.massot@collabora.com>, Chen Zhong <chen.zhong@mediatek.com>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 1/9] dt-bindings: mfd: mt6397: Add bindings for MT6392
 PMIC
Message-ID: <20260318-natural-hummingbird-from-sirius-ada960@quoll>
References: <20260317184507.523060-1-l.scorcia@gmail.com>
 <20260317184507.523060-2-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260317184507.523060-2-l.scorcia@gmail.com>

On Tue, Mar 17, 2026 at 06:43:04PM +0000, Luca Leonardo Scorcia wrote:
> @@ -92,6 +100,7 @@ properties:
>                - mediatek,mt6328-regulator
>                - mediatek,mt6358-regulator
>                - mediatek,mt6359-regulator
> +              - mediatek,mt6392-regulator

So this also should be dropped. I understand that we added compatibles
to MFD device children 10-15 years ago, but what is the point of doing
this still? What is the benefit? See also rules in overall-design in
writing-bindings.

>                - mediatek,mt6397-regulator
>            - items:
>                - enum:

Best regards,
Krzysztof

