Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA3D36EA88;
	Wed,  3 Jun 2026 22:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780525601; cv=none; b=urQxwX+jPrvl1zKQ+BEIsNgUbxlPGiwrdl8lxyHShEGMVJtWVJ40CX1zUqDu+S31bT+US/3EBuoQ/Qi0lVqGGxDETxxWhIAaSKL/kOr4+LmOVTAvQ9RgVeFeWWPFKKwd3tyVxnqqPUyANV+nAPUg6dIKq+IQpXfcNPXRJoia4Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780525601; c=relaxed/simple;
	bh=ZywTaRy1msXOxaGd4EYGfCCbubvXJ1Jk0ITU8WIeDMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ys12XYxNWMEYdzMLo33OCzzI/SvWSUiEQEUDm9++a43JjZccvmHhJVWpv2TntdINxB0LreVuAH67gn8YnoGTUjPU6tsBHu+3t3PAasnNZm4pJX9dUnr4tCRO8gP+eZ2lvbgTCAzKP0JRzAZIJ9+MGwmp1t5AF1f/gWeZpAQrZdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZgaVmRuf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZgaVmRuf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1463C1F00893;
	Wed,  3 Jun 2026 22:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780525600;
	bh=RrIKouTk6LrlkPuhry9kKUBhABYZtLMPUz5HqEvghk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZgaVmRufssWWHj+XbZOoJjIk1UlxS+Y70wvbAoI1JonWba43ThzW9mscyoB3MkSdo
	 D04MkQT8kMXwvLvk5C0ptnEM+187F8/JvU57y5u5TCa8hGWyKMquvtz/PJ0cnX5WOS
	 LpaX6F+s2ym1XpM92HT8VFcwF7pIOMnFRvFamMlGLna1lARiJTIP02HWi+pAjvXb8C
	 2U1Bb99gk4u4np3xAEyE+PdDxqszFOno/y7fmqMLLAaNuagG2l/2MnJB/xrR8cK5Yr
	 2wM0wnGy0aGcsc9ys4SSgxbaYSXWH6nlUp5hfDbd+CHwlAjY0/bTO2UnqIDbenP5st
	 yWeaDqREmmHzg==
Date: Wed, 3 Jun 2026 17:26:38 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Akash Sukhavasi <akash.sukhavasi@gmail.com>
Cc: Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>, linux-tegra@vger.kernel.org,
	linux-input@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	linux-media@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Simon Horman <horms@kernel.org>, devicetree@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Lee Jones <lee@kernel.org>,
	netdev@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2 4/4] dt-bindings: input: remove obsolete
 matrix-keymap.txt
Message-ID: <178052559618.2296868.8781332297681333925.robh@kernel.org>
References: <20260603-b4-remove-redirect-stubs-v2-0-c8c19876ab64@gmail.com>
 <20260603-b4-remove-redirect-stubs-v2-4-c8c19876ab64@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603-b4-remove-redirect-stubs-v2-4-c8c19876ab64@gmail.com>


On Wed, 03 Jun 2026 15:42:21 -0500, Akash Sukhavasi wrote:
> matrix-keymap.txt has been a single-line redirect to
> matrix-keymap.yaml since commit 639d6eda3b80 ("dt-bindings: input:
> Convert matrix-keymap to json-schema"), which introduced the .yaml
> schema and reduced the .txt to a stub in the same change. The .yaml
> has the same filename in the same directory, making this redirect
> unnecessary for discoverability.
> 
> Eight instances across six files still reference matrix-keymap.txt,
> forcing readers through an extra hop to reach the .yaml. The stub has
> not been touched since June 2020. Update all references across input
> and mfd binding documentation to point directly to matrix-keymap.yaml
> and remove the stub.
> 
> Signed-off-by: Akash Sukhavasi <akash.sukhavasi@gmail.com>
> ---
> v2:
> - Patch 4/4: corrected commit message (eight references in six files,
>   not eight files), Sashiko review.
>   https://sashiko.dev/#/patchset/20260529052246.4934-1-akash.sukhavasi@gmail.com?part=4
> 
> v1: https://lore.kernel.org/all/20260529052246.4934-5-akash.sukhavasi@gmail.com/
> ---
>  Documentation/devicetree/bindings/input/brcm,bcm-keypad.txt    | 2 +-
>  Documentation/devicetree/bindings/input/clps711x-keypad.txt    | 2 +-
>  Documentation/devicetree/bindings/input/matrix-keymap.txt      | 1 -
>  Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.txt | 2 +-
>  Documentation/devicetree/bindings/input/pxa27x-keypad.txt      | 2 +-
>  Documentation/devicetree/bindings/input/st-keyscan.txt         | 2 +-
>  Documentation/devicetree/bindings/mfd/tc3589x.txt              | 6 +++---
>  7 files changed, 8 insertions(+), 9 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

