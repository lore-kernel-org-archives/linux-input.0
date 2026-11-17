Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794930315;
	b=YhHwqydTB6FpgnEUh8INVYcgKMk2O2+gJ981KunElgjFLPD8VF8dqISJK5QYI7iaYLmG
	 bnL0m1iLT9VXVmgOsu4NSWsBtor4jYA35cNZGLw8vTslbQIYENH2GpuFR9awJ2r2FztNR
	 357AhjzXYOCz2F2iwP19Utm19eFGI1aGHAWO0HlSNdPGpy53IUW1MOXCBvP6QjjgpmFWd
	 xtCXzX9/Yzehts3YcbumIXfvOrADqd5Aw/36r+2/y8PfatMc4aU2/QZ4iJ0BovVgvk7mC
	 VeM0Vznkn/vQHyhL6E4X4izfKJcp6KUoaZKr7HjvtnD2x+egqJUiNLVGMFikgE0rk/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794930315;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=yx0f3Yir639syvYfkg79O7Kpd9xzBO9aaexbdF9atUs=;
	b=izB1FUCNGMrwxHcIZjpnwC1s2oUedyCZZITd0m7/wgMoerXdp2hkp1yzWyqUo7z+hlFw
	 y6uvXq22q+w3ubakcRXyXcSweedHNdhWvQr2zN/zcOu9qrwxegdLLq08VjZxvd+tR43cF
	 sCq31I8NeImohJdFYBvqzvSbl1k8VvEGkOSOnJMX8GEuwFGzabaZ4ZZkxQsK+Ni2eISMh
	 +EK9xWu5RrXS7jLpITGyrSM51epQaapmMHGMqIAZYlDjHZAxr7aQYxSHCKMmFWkNasMdY
	 EqPqJdvKYp0lhduxM8YCUTF15wYq19B5HtzG3c0z7LOD5RbtXK6ydJCxn11VInEbyWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FUFEc8xz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A514606A32C;
	Tue, 17 Nov 2026 15:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FUFEc8xz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5285A1F000C4;
	Tue, 17 Nov 2026 15:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794930315;
	bh=yx0f3Yir639syvYfkg79O7Kpd9xzBO9aaexbdF9atUs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=FUFEc8xz6COW3EN33vCksYZgW8fYeid15xpqnE6bkjYb8ds8GnfyBq3Jbse/StGin
	 aFc60FNTgNgw3W7d5QemIGS0no4qXZ1Y57Q9TPuawziXH2c0TuhNEaoDdCicQt1eXO
	 mLINKQJOly7zZT9EFWEI89QXybe9XKEKLynkfDPWAdsbnbF1QJFyvbCGaJTiW5m1kG
	 XV+aUd9kYT4zdS55zGYU4rzkdTaIqOWm/F3pmctvLM4fIiS4R5++zvkDuE/N2nVRgc
	 xtB6/ntvlXr7/lq7RG0/fxX7qf/mQPblvAEk0mrhKHaLqmggThe5uOeR1czsdpOvVx
	 mwyhL/Fo9nomA==
From: Srinivas Kandagatla <srini@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Abel Vesa <abelvesa@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Krishna Manikandan <quic_mkrishn@quicinc.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Muzaffer Kadir <muzafferkadir@mainlining.org>
Cc: David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
 linux-watchdog@vger.kernel.org, linux-clk@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 linux-remoteproc@vger.kernel.org, linux-input@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261105-msm8952-initial-support-v8-0-311ae8e8f14b@mainlining.org>
References: <20261105-msm8952-initial-support-v8-0-311ae8e8f14b@mainlining.org>
Subject: Re: (subset) [PATCH v8 00/11] Add Initial Support For MSM8952, Add
 General Mobile Shamrock
Message-Id: <179493030479.124445.18019484431206678491.b4-ty@kernel.org>
Date: Tue, 17 Nov 2026 15:45:04 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Thu, 05 Nov 2026 13:54:04 +0300, Muzaffer Kadir wrote:
> MSM8952 is a SoC with 8 core cpu and Adreno 405 gpu.
> 
> Ported without uart connection. ramoops and usb
> mainly used to debug.
> USB is not enabled in this series because it
> depends on the not yet upstreamed (and not developed by me)
> pmi8950_smbcharger.
> 
> [...]

Applied, thanks!

[01/11] dt-bindings: nvmem: Add compatible for MSM8952
        commit: a3543a8b163f1edb45f0e631ea0f5905256a3684

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>

