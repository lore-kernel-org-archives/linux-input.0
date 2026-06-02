Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3469A2F8EA2;
	Tue,  2 Jun 2026 19:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780430289; cv=none; b=NTMc4cGZ3BihBFCKhKFuCmHVDmRpogCqkp0qFE4r+lXC/fOrEXnM40q+dNScFtnPuQxw6/qnNO/yq5x4NevcScNBNjiGd6TCuLR8cSDINqiedDK7l6pK4XSNcAHOR7eXEW34gkq9RVUY3Q0JsGsMJJGIw/ZzMF43mcdRkYWe0P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780430289; c=relaxed/simple;
	bh=zWmUa9IoGsfRyRSXVEZh1hDJdjIO4Y+uoIZvYw4doy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uCPuYqGMz6ZiJkLqMxgWbHH6/YGSWiFPFmPC/9CaI51Xpda+/ODXIT21inW+6d39k8cFbqy+2y4kjWrb/dKUHsBXSyaeTCfvJpspZafNNV1NzcUD/F7TCXLVQWVbu7UY+9Oans7OQNyH09V7cEsXQK4+i7j7xV0mSTdkYko6kag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GoR/ooG3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GoR/ooG3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD89E1F00893;
	Tue,  2 Jun 2026 19:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780430287;
	bh=fnLig1efP0TuJ12veBvKUYnUO2mrsAHX1oK+MYE3e7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GoR/ooG3A23xypxe/2xIjqhXBgNQL6JSdsjAIy5mcUDJyifn889NEwPXaX9plNUoQ
	 95s+38nJXC3BmSI6OEEU9xfocEKCy4p3TuYErHQCifEiF5vj2uv69ycot9xDWNk8Uo
	 lKQgRWyKxyn1v7TCaUc4ZigPwyxw7+23CyRtPwNMCb9g0wGFAEmy64M2jxJBQRt77t
	 MCghHnNJMLBMEnrPwsa+jZT59Iykyxv3SbFGTk1qCENU3CeqW37zeThZjKl4tlDHWo
	 waTd9ltZGETh15fjYkBwNpQEtlbfYmE0w6t/84CMFfn9gIPvZkLqmeid/filaiA1Xz
	 GWL3TLidwOjjw==
Date: Tue, 2 Jun 2026 14:58:07 -0500
From: Rob Herring <robh@kernel.org>
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, kernel@collabora.com,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/9] MT6365 PMIC support cleanup
Message-ID: <20260602195807.GA1062343-robh@kernel.org>
References: <20260429-mediatek-genio-mt6365-cleanup-v1-0-6f43838be92f@collabora.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429-mediatek-genio-mt6365-cleanup-v1-0-6f43838be92f@collabora.com>

On Wed, Apr 29, 2026 at 11:44:13AM +0200, Louis-Alexis Eyraud wrote:
> Several Mediatek and Radxa boards, based on MT8370, MT8390 or MT8395
> SoC, integrate the MT6365 PMIC, that is a MT6359P variant:
>  - Mediatek Genio 1200-EVK
>  - Mediatek Genio 700-EVK
>  - Mediatek Genio 510-EVK
>  - Radxa NIO-12L
> It is compatible with the MT6359 PMIC.
> 
> But both MT6365 PMIC support and compatibility were never expressed in
> the dt-bindings and there is no MT6365 include file as well.
> So, since these board support was introduced, their devicetrees use the
> mt6359 include file to enable this PMIC support. 
> 
> The goal of this series is to clean this support by adding the missing
> compatible strings for this MFD main and subdevices in the dt-bindings,
> and add a include for MT6365 definitions to replace the MT6359 include
> in these board devicetrees and for future ones (like Genio 520/720
> EVKs).
> 
> The series is based on linux-next tree (tag: next-20260428) and has
> been tested on Mediatek Genio 510, 700 and 1200-EVK boards.
> 
> ---
> Louis-Alexis Eyraud (9):
>       dt-bindings: mfd: mediatek: mt6397: Add rtc for MT6359
>       dt-bindings: mfd: mediatek: mt6397: Add MT6365 PMIC support
>       dt-bindings: input: mediatek,pmic-keys: Add MT6365 support
>       dt-bindings: iio: adc: mt6359: Add MT6365 PMIC AuxADC

Applied these 2 to fix warnings in linux-next.

Angelo, Apply the binding changes along with the .dts changes if they 
haven't been picked up yet.

Once again, Mediatek warnings are moving in the wrong direction. :(

Rob

>       arm64: dts: mediatek: mt6359: use proper compatible for rtc
>       arm64: dts: mediatek: add MT6365 PMIC include
>       arm64: dts: mediatek: mt8390-genio-common: use MT6365 PMIC definitions
>       arm64: dts: mediatek: mt8395-genio-common: use MT6365 PMIC definitions
>       arm64: dts: mediatek: mt8395-radxa-nio-12l: use MT6365 PMIC definitions
