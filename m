Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770D1126BF9;
	Fri, 14 Mar 2025 23:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741995813; cv=none; b=YdcuiX1zvB7Q9++cqfJ3hlcyIgDUbHYDQOmEBA3FzWW6kfmIcY1SLAwBvCPvmliHlYx1C++6LTC0jMIBzVLrOw2VTni/hcherMfR2JSPtM60iwwYYDojR8UTXzjnEOItkZhAUs+aK2/0XR39RK72T0m/dHVCamuREw3P+lvjt9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741995813; c=relaxed/simple;
	bh=qQdDxdb0afkimp72/QzJMmAlfH9sg3FLL40dNEOcaSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q6jPkMgDAQwwTLRO7PQGtCaEs6uTejJaq1g9UhZsf7wFY/uhhxXy8e6PXDp1/sHIOXq0XV5jRliaLr6dXrPmBT0JUtIRa0tY+5P9vKZSF93I1jSuj1ulsWXFchQBayfBTtWNmQtbP6TdjlFZ2LiGG/Xhvx47BqjV6tTMeAfgWOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3KIhIdF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3KIhIdF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C73A8C4CEE3;
	Fri, 14 Mar 2025 23:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741995813;
	bh=qQdDxdb0afkimp72/QzJMmAlfH9sg3FLL40dNEOcaSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H3KIhIdFYxnlhnp3CKEjKYiHImna2sHEMJSURXS4lFJZSdDbeFAvVIeDqJC2QtImr
	 lS2bp6fnCA6J8ZwYZP9qXb/S2/K3ehFic6SCUrjOeMB02QjsdA+fMsEdR5EQ/6/eo1
	 imfmTUv83Ihu3WybfiVbFEmtFQZ7ixhP+0+lhI1bs0lyUaAQEU/wbbR36wAa/G7AIh
	 e8/jPR27tPADSOke2jocd0gYLCta/KFU0ppltjYYLUwabuHvlakDEabncqNcHMnKgj
	 MjGi48jWOU1sLM8gvjKyzRcWsnBXLmrqKbHe+dAtu60+SB6QyWgMgaa0zl2M2eDxwx
	 PpfEEU4P+HmGg==
Date: Fri, 14 Mar 2025 18:43:31 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	chrome-platform@lists.linux.dev, linux-input@vger.kernel.org,
	Benson Leung <bleung@chromium.org>,
	linux-arm-kernel@lists.infradead.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	devicetree@vger.kernel.org, Tzung-Bi Shih <tzungbi@kernel.org>
Subject: Re: [PATCH 2/8] dt-bindings: arm: mediatek: Merge MT8186 Voltorb
 entries
Message-ID: <174199581084.2541058.17920956442449315665.robh@kernel.org>
References: <20250312104344.3084425-1-wenst@chromium.org>
 <20250312104344.3084425-3-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312104344.3084425-3-wenst@chromium.org>


On Wed, 12 Mar 2025 18:43:36 +0800, Chen-Yu Tsai wrote:
> There are only two different SKUs of Voltorb, and the only difference
> between them is whether a touchscreen is present or not. This can be
> detected by a simple I2C transfer to the address, instead of having
> separate compatible strings and device trees.
> 
> Drop the SKU-specific compatible strings and just keep the generic
> "google,voltorb" one.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 3 ---
>  1 file changed, 3 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

