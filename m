Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC50223DEA;
	Thu, 17 Sep 2026 18:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789668043; cv=none; b=ulzfGa7vcq0GV8SIk5QlSzwj8zRCvCL9vOAqMUJlUhGDduGC6lUOGTA/5WAfDFBISgw490yYqJAjbDUPHnVcsX6FRUjmMXeynEQBsPTK2qu1TpUzIVdZ3n/VBvHDoZChnHVrW8QZoOrYlebGPMXsew00ogwNhaFKVxAjWOCIME0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789668043; c=relaxed/simple;
	bh=SwmFplgdvfZk74xWXHbUdLsf9CUwvb66wjy26upL8Ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ui9PmQJxrjmdUnfdOKgH6re0VN6u1Dj8uHgLehxUSa/Lj/ujNNj0OeTobvYWYF7IiixkayQQcSeD3PeKXGxehoLnyoEaZSrZUxyTvMlb1GQCzXt/0atWPziPF/zxkSc148OG9KqYTQm6L2cHelyErFGqcixwibpRoSjuhaeHaNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVkG09Hq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVkG09Hq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACBF31F00893;
	Thu, 17 Sep 2026 18:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789668042;
	bh=bDkA9Is1Jx1AOE6Tvx2VWAovPxbpbhANimFsfanmC0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LVkG09HqfsKZmJFS9qmt6OvQIdIMnn38+xzlPNcI19TxAJDAVqDvcv13mx5RhiTJF
	 BLFpnR+BysQpygTq/jJME04w/nYC6JbWWyngMv/UqyKfFg/XRgx7vghrbUABrl1xVa
	 gzPWxiGrTTasJL7YDq+byQVo+FUUD/WjlOUBbOLR/Xd71lWSaRrldlsJicJcKWYeHS
	 hiIJQAirnKUCBG3M/4JbVZfqSp+8BFzJVS57Tp/RKVgvNfoJF+cer2fMfEtKfCDQB9
	 69UFkPdaOAPFuQu79OdO6zaHZJVHecxL8QaqbdLDMo5FenvMFzH+F34vu3f36Eukda
	 OZliUmPKbP87Q==
Date: Thu, 17 Sep 2026 23:30:37 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Daniel Matyas <matyasdaniel006@gmail.com>
Cc: Lee Jones <lee@kernel.org>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	Ulf Hansson <ulfh@kernel.org>, Liang Yang <liang.yang@amlogic.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	Ray Jui <ray.jui@broadcom.com>,
	Scott Branden <scott.branden@broadcom.com>,
	Atish Patra <atishp@rivosinc.com>, Shawn Guo <shawn.guo@linaro.org>,
	Dmitry Osipenko <digetx@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
	Okan Sahin <Okan.Sahin@analog.com>, devicetree@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>,
	linux-rtc@vger.kernel.org, Ricard Wanderlof <ricardw@axis.com>,
	patches@opensource.cirrus.com, Lukas Wunner <lukas@wunner.de>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Eugen Hristev <ehristev@kernel.org>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
	linux@analog.com, linux-input@vger.kernel.org,
	chrome-platform@lists.linux.dev, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: Expand flow lists to block lists
Message-ID: <aqwqxSxqg7aRjchE@parshuram>
References: <20260917144028.459053-1-matyasdaniel006@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917144028.459053-1-matyasdaniel006@gmail.com>

On 17-09-26, 17:40, Daniel Matyas wrote:
> Running dt_bindings_check returned:
> [error] string value is redundantly quoted with any quotes (quoted-strings)
> 
> The files used quotation marks in flow lists because the strings had
> commas and these commas were interpreted as separators. Convert flow
> style lists to block style lists, so that there is no problems with the
> commas.

Acked-by: Vinod Koul <vkoul@kernel.org>


-- 
~Vinod
