Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193A629A309;
	Fri,  6 Mar 2026 00:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772756931; cv=none; b=g0UGfPdbWredwRxEmKkS8Af52Sa7NFIFGiyL4rMTxCIoPSKsd8BBk1Jo6F4JYi95SIMi4d4wMtRDE5hsaWDmRuNFRp0BGlq9HVfydobuyFp73yqy2R8IxhB7lJObEs0ofaz1aAys0HQxcRi6+RNlWxhWrcHno7H8fBcIZRhCxKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772756931; c=relaxed/simple;
	bh=EXIStN1B/izsA6vGyFCAGh+w3xMM+thmSuO0J4C0Xvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s5+yWMgA6v8sSqlkGkM2+u0n47cYSy4oQp7Ju8Z/7BwDBl7u0bJV1GL6vLc3pUdDiSfWo9ILuggZauXl2lv7XoruczEIdq39RlXijP24rRcALwJ50sBd4N4E31vDUpzzw20dLB58OYMYjZfaVH/x1gdOYEJuEwQSo/pQ4E21UR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1fWMiSV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1fWMiSV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6E4EC116C6;
	Fri,  6 Mar 2026 00:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772756930;
	bh=EXIStN1B/izsA6vGyFCAGh+w3xMM+thmSuO0J4C0Xvo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k1fWMiSVv9ZBMUvKy4qYRdIOqJzOmk3HXhNYLX4RKFCXSipyjH8GD9CkxuqVaOYd3
	 t0ehgvplc3/7pGkWH/WKQVUtxj5l+8MkWdS8AnScmPCNhTJb8Lnrw2pa8IV8TVjKXM
	 WdN19c/dGxbKjTwtmtLdNOmaSa9igq5318juqOVuFvEfQ9lUa/pyx11nHRO3m90EpW
	 zFbvnnIAj8jJpkRDYodTJwgJrzcMzIqixXoUVCRSGBeASZqqAquFt8cjnndVjNEYIt
	 NTkA+HFiCEKxhzxqbX2bC+I/kSZisc0mD+NlPJEI6P1cGjKrE5vb4KgJUNcy3K2CvR
	 F2V0H94O8MlZQ==
Date: Thu, 5 Mar 2026 18:28:49 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Chen Zhong <chen.zhong@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>, linux-pm@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
	Julien Massot <julien.massot@collabora.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Fabien Parent <parent.f@gmail.com>, linux-input@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Val Packett <val@packett.cool>, Sen Chu <sen.chu@mediatek.com>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Gary Bisson <bisson.gary@gmail.com>,
	Eddie Huang <eddie.huang@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>
Subject: Re: [PATCH 2/9] dt-bindings: regulator: add support for MT6392
Message-ID: <177275692938.853845.10496663055638089922.robh@kernel.org>
References: <cover.1771865014.git.l.scorcia@gmail.com>
 <b7664f4d9a7b038b0603b6bba79cfab4e18cbdd6.1771865015.git.l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7664f4d9a7b038b0603b6bba79cfab4e18cbdd6.1771865015.git.l.scorcia@gmail.com>


On Mon, 23 Feb 2026 17:12:41 +0000, Luca Leonardo Scorcia wrote:
> From: Fabien Parent <parent.f@gmail.com>
> 
> Add binding documentation of the regulator for MT6392 SoCs.
> 
> Signed-off-by: Fabien Parent <parent.f@gmail.com>
> Signed-off-by: Val Packett <val@packett.cool>
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
> ---
>  Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

