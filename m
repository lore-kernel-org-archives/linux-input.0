Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF9F2FFDD5;
	Tue, 16 Jun 2026 13:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781617416; cv=none; b=Rsj9xfRTC/v3PFWAZTmVYZVrYC5BYCRK3WxfvwDM62EbDTDohcEkn0nBJZW2Emxr3E1zOnkz7GyOiqdQvqNHV+Y26W8PBiykSDDoqSPOGms2PiMvrF+3nQBF7WnW5guMI9p9VI8a4T75rWwZEZ9+N2GPLm0ZiyAvzuy/++ivq1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781617416; c=relaxed/simple;
	bh=ST2lle1KcnnwV/8PklK2xmFPsEiN1ovOB2uql/ROkUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kC6VnI5+pFyLQXa7969l4v8+DA5FmgCom4yY4UkKR4pk3kf8HpLJusiE7ZxIU6GpdSwds7Pm4xHjcV59SsyLHm0I452/XPSBUQdR2DCAERSHwWJLWOdjsoleDzQmhHGzjAYWnsEvgvHmmRbSuxVH0/vTSYxpIjhsiiG7Qmg6/kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbB3m3hU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbB3m3hU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E0801F00A3D;
	Tue, 16 Jun 2026 13:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781617414;
	bh=q8iDUL7W0TQmeYxpCd6HKXwGPJyYmHCMd+sglFpYlvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nbB3m3hUDC1grbUUzhtcl3F2bp9B05pmaVgqTc0TdCizZL4tT2ccGPTgm7LgN032i
	 Qy1vIIQ9Kz+3G2zNDUFggwOIe2HemGDDfQwBRxIyAzYQHanjtp6ribGBv7iZniToS7
	 AwgTQzHyAkvmJiHSPllY1D2Z014kz+eLivVu4EvN1fN3GFxBdlVzfkJFc7WmqkPGzm
	 KrCOFwoETXL6cN4B9qA8wzzOVQSTLROLxiS3C9n4atqef9vSelS0CQGINxmrvmmN3s
	 IBw8MYRXJk11S9TuqDc9dK1mYQoPPJi8OAo9Lb0o3xri7dbI2mq63CYYxoFTckerqX
	 4Y3+TRA0Ijs0A==
Date: Tue, 16 Jun 2026 08:43:32 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Mark Brown <broonie@kernel.org>,
	linux-input@vger.kernel.org, linux-pm@vger.kernel.org,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	linux-kernel@vger.kernel.org,
	Julien Massot <julien.massot@collabora.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	Fabien Parent <parent.f@gmail.com>,
	linux-mediatek@lists.infradead.org, Val Packett <val@packett.cool>,
	linux-arm-kernel@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	devicetree@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
	Sen Chu <sen.chu@mediatek.com>, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v7 1/9] dt-bindings: mfd: mt6397: Add MT6392 PMIC
Message-ID: <178161741195.2350422.8190069791847704503.robh@kernel.org>
References: <20260615071836.362883-1-l.scorcia@gmail.com>
 <20260615071836.362883-2-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615071836.362883-2-l.scorcia@gmail.com>


On Mon, 15 Jun 2026 09:16:07 +0200, Luca Leonardo Scorcia wrote:
> Describe the MT6392 PMIC and its RTC and regulator devices. This device
> is mostly based on MT6323 with some similarities to MT6397 and is usually
> found on boards using the MT8516/MT8167 SoC.
> 
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
> ---
>  .../devicetree/bindings/mfd/mediatek,mt6397.yaml         | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

