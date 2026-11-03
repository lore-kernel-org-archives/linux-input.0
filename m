Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793698407;
	b=cgtqkLJ6Q9RVYrFyY/qBxm2Nh278eoH3loiKHg+cU/+zY+HV0hH+Qmoudo09Z56VNBeC
	 x4wMlYEb6OynjolHDm2cdfVqxVN5Iht47pMKaSm8OjghTjaZJr79ePPAArYmMBbDXYO28
	 Gzkfe/Ve04RofsvaQSgI3OqmPFtfg9hCQ9++xO+r8VYwMnR36/gcR3V1uvVonTkwYwfx6
	 8glKARWLIMAZod2/RwKtgd7IOHCuNBtQUU4M4gYCWe+tiDUufCluP8JztjU0SRAtmhjVP
	 y28VrpOjQL/v/wlKzZYnTB8nZqCtax3ca74AEl3z1F4YsYXMRz2omw9eXc90m7Bn3IA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793698407;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ipybBpddf0p268OSOnOQL/8r5MWmqU5YBcO4856aeD0=;
	b=kp1Ms4PWxw8/RTCoH7TL5XalAPAWfsGiMi9Ak61WBgxPc8sX5PnV7JFiC+wy0697N9XX
	 J2Ys4h7BqLQ82CxZd0NE5RT0m4zjHwUoPYXS0ABskolOtlAhyyJpFrqw/5L9rxYt7U/M4
	 HF0c3eh80PmF9lSvE/r0GrdR5kUmSQxrDH96C3pQf6rsjEle0ZzfEHLZlwd0cqxCHUV94
	 XXox6t7Jvs8iGn9f8PrJA9vt2ncmXx5hXwc0KXg41fT7v9k+5FxUUgDQWQoolX+yzVJQg
	 iiABb7dHFTTVRBeiwEubQkuoLbXiaMfcUfKt/ICZGjn4sCEJxxY9ojAiHe3IJm051vA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A4XKniS7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15861606A329;
	Tue,  3 Nov 2026 09:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A4XKniS7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 434A01F000C1;
	Tue,  3 Nov 2026 09:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793698406;
	bh=ipybBpddf0p268OSOnOQL/8r5MWmqU5YBcO4856aeD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=A4XKniS7FhANxVtKKHjvBqnEaTTUEEQuesw2Q+KrK94YfJc6vbRuMb3ONLLTgkPW7
	 r8pCqLOcMYNj6KMuvx1K1oW9F8YaqQOLwfayI+TaZd3P+zYPnLr+0atfvDEbhbj2hf
	 UrfUV9S5vwNtUERbbi4W12uG7QHy3XJIyiqQBuzUxMbSPpjTDL5YOtBvEVUmDQx0iU
	 M27+nxFXHawOeavenVKe6/7ubsIoKyytbZlr6pwHPRIhbKv5xHNZQPPW06mfRz2cgB
	 R+zie4LaPb/9Zmm+opu7wYAfLyEWza5jCyX89Sy2qcAX1tl8pMK7QJe1PxEfxxvTxd
	 LQ4/DzMvJ9Kgw==
Date: Tue, 3 Nov 2026 10:33:22 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Muzaffer Kadir <muzafferkadir@mainlining.org>
Cc: Srinivas Kandagatla <srini@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Konrad Dybcio <konradybcio@kernel.org>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Rajendra Nayak <quic_rjendra@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Abel Vesa <abelvesa@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, 
	Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>, 
	Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Krishna Manikandan <quic_mkrishn@quicinc.com>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-watchdog@vger.kernel.org, linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-remoteproc@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v7 06/11] dt-bindings: clock: qcom,a53pll: Add MSM8952
 compatible
Message-ID: <20261103-venomous-viridian-bug-a61ace@quoll>
References: <20261030-msm8952-initial-support-v7-0-ad748ace375d@mainlining.org>
 <20261030-msm8952-initial-support-v7-6-ad748ace375d@mainlining.org>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261030-msm8952-initial-support-v7-6-ad748ace375d@mainlining.org>

On Fri, Oct 30, 2026 at 12:02:37AM +0300, Muzaffer Kadir wrote:
> Document the a53pll found on MSM8952.
> 
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
> ---
>  .../devicetree/bindings/clock/qcom,a53pll.yaml     | 25 +++++++++++++---------
>  1 file changed, 15 insertions(+), 10 deletions(-)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

