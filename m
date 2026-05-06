Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C5E3F0745;
	Wed,  6 May 2026 15:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778081542; cv=none; b=Rf25FttTE9parBTcUq6MvqsI/3FipgYwaw+L31NJ6xI1VAtf3wG9kMFRZ4N7r2b9NTSX8iNEXcChYhlVGx5dCMgz1sPA4ZPOY6F+bDodhT+s4YHrxtPsg8j/KICxaBqCnOU7fX48VYwmVnjHQZXcf33+6ffxVU6H/ZdiKZbZd0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778081542; c=relaxed/simple;
	bh=Z8nEPenX4TJdhrXgJ7ghrwizbjBvQ1xCIwn0oI8yavA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=miHroRBntQs+TYl3maS+Jnp1S/OIGh+nxG9ZylM6mSWDlxLMcowF6VF9OAXNxywAxC8YKE/Rvgd2ajHc2LTQRmFBlGn+wIh11fS+57n3hJkG6YbtIj5azz7F95/xLHmpIKP/o7kQzbbaxQ9V8xO7YWVprAp49RBYEx57V0QUf5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URVdJszv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URVdJszv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 690D3C2BCB0;
	Wed,  6 May 2026 15:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778081540;
	bh=Z8nEPenX4TJdhrXgJ7ghrwizbjBvQ1xCIwn0oI8yavA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=URVdJszvdIFFyTDuQUlwecaT++vnVVLr0/BQkIc8MD8H2nfKf8gxdYHZbiNHA9Ylk
	 Y8cR0+NjDS5HhyPC+/gwBvbz/dsnXwYh35XLDyio9uIAPxP2YVQ2hUrfoVzFSPjVYB
	 Z7cF09xM7rdK6DhzPETQnq1K/1Q4zw611gAIaF0rV/x4LWgPes/1N1csPAhWdXglIL
	 GVhb2UVOFR/N6MuaPgG0pSmsvq55R7Pu1k2X7UMHS894+L5cW1uQbkhIu4H7g6lW/A
	 /sKevocI26B6gL9hj3xnZ5Er4zySpmEihZHCHxaxH0w6z7aGpCo/vBFtOCGeTTrFl8
	 33/ZbPuCbBHHQ==
Date: Wed, 6 May 2026 10:32:18 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, kernel@collabora.com,
	Andy Shevchenko <andy@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>, linux-iio@vger.kernel.org,
	linux-pm@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Sean Wang <sean.wang@mediatek.com>, Sen Chu <sen.chu@mediatek.com>,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, Lee Jones <lee@kernel.org>,
	linux-input@vger.kernel.org, Chen Zhong <chen.zhong@mediatek.com>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 2/9] dt-bindings: mfd: mediatek: mt6397: Add MT6365 PMIC
 support
Message-ID: <177808153813.2165238.1499393868566610666.robh@kernel.org>
References: <20260429-mediatek-genio-mt6365-cleanup-v1-0-6f43838be92f@collabora.com>
 <20260429-mediatek-genio-mt6365-cleanup-v1-2-6f43838be92f@collabora.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429-mediatek-genio-mt6365-cleanup-v1-2-6f43838be92f@collabora.com>


On Wed, 29 Apr 2026 11:44:15 +0200, Louis-Alexis Eyraud wrote:
> MT6365 PMIC is compatible with MT6359, so add the compatible strings
> for the main and sub devices (regulator, rtc, audio codec).
> 
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
> ---
>  Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

