Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84D844D6A9;
	Wed,  6 May 2026 15:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778081490; cv=none; b=rDJCzpxwhYd1+YRFKwjII9yDPErd8cT4pfb9sYmYAG3JYzCw2rbLW3q8Jh/KkoRFatRWgUhICZxPGT0k9KWFRRJ2HP6NnaPgIuX2mZ2wYvL4C5Ani4ECDBJXK/hNPAFfVe+mIfaJvHuN8fW/m/O43dVCEH4ppxu2ohkBcJOqntw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778081490; c=relaxed/simple;
	bh=IgHqoBvpmtUA7FgXX/Le9CmNm36RAHe0VSyPKzaNLfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZO5f1ecyTaYrSqVwJ3xxNrv1ZKuJVqRvJPCO+Nd1eucmpmVOpXAZThrRk+qYYLpG6zVwrGnGqFkW20jujIlFcAz6a94Ta3o17KdlRCXFqb7cQZE3SEim/KBtBSlpNRnZQ8HBI6G5W4TjlHCh1WjfZ5ase9q7i1GguEMI8TpoKww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qapj2ZbJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qapj2ZbJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6784C2BCB0;
	Wed,  6 May 2026 15:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778081489;
	bh=IgHqoBvpmtUA7FgXX/Le9CmNm36RAHe0VSyPKzaNLfU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qapj2ZbJvROo6HMGSV8FORvgrI9+0dhDdr5aft67gXjbpw92uNrsHG5vt8FhEeQ3e
	 ItYO/Aowm+Dg6y/ZaoLVCdxffOSyqnVLui0pLHwEAmCpkH7F84xGgW2fH2weUl6uU/
	 TFGVlgx9gljReqc2Leb7nX1UO/vL9CHvZLQKhtER/RISgk1ylzCBe9/VeTrAcVJDWI
	 B8NHnsRILYZYFUo0bPIbQhBe4NwJ7RUIll/oC2Aa9bLprg4Nxl81L5lk2uwN57SHnI
	 0XHdf1CF/wXotjhxzx1lVcWaA6XOrzkb3miEXU25G+R/2k/mQ+197EnuUOS7iVeCW7
	 0PU+5kX9UVJGw==
Date: Wed, 6 May 2026 10:31:26 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: Sen Chu <sen.chu@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>, Lee Jones <lee@kernel.org>,
	linux-mediatek@lists.infradead.org,
	Jonathan Cameron <jic23@kernel.org>, devicetree@vger.kernel.org,
	kernel@collabora.com,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-input@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	Chen Zhong <chen.zhong@mediatek.com>, linux-pm@vger.kernel.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-iio@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] dt-bindings: mfd: mediatek: mt6397: Add rtc for
 MT6359
Message-ID: <177808148601.2163979.5712342936678937427.robh@kernel.org>
References: <20260429-mediatek-genio-mt6365-cleanup-v1-0-6f43838be92f@collabora.com>
 <20260429-mediatek-genio-mt6365-cleanup-v1-1-6f43838be92f@collabora.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429-mediatek-genio-mt6365-cleanup-v1-1-6f43838be92f@collabora.com>


On Wed, 29 Apr 2026 11:44:14 +0200, Louis-Alexis Eyraud wrote:
> The rtc block of MT6359 PMIC is compatible with the one found in MT6358
> but this compatibility was never expressed in the dt-bindings, so add
> the missing compatible string for the rtc subnode.
> 
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
> ---
>  Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

