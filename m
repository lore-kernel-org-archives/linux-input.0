Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793605537;
	b=Y7248MXOzoZko3zQeAo2mnkQYaosQRydxUSFJ01QBbXx5hBzgG7El/BKydUWMipapsX1
	 YuTyy0MxxsJywefkGFPIW8y7+7VrZuyPJfeOMzer5G8dhEhXP6aWPxXQX8pLcsluzm2LL
	 xZ51z3/lw0QirVcVTDPGPbrC5/neRvmZETKSMgEbwy9ZIJMmux7tzr/IWzqUqgfEPuBWo
	 cKTtVrVu2KfoTXVYgmPN1oL1K0vUM+mwJT7tXJRiHkcZnCq1FK2LtjFEMZIVLF9G0ZI1P
	 AjF30xViWQYup9mpoupRf4sKHG11ng/u4wUe0Oa9y6o+tBxvfQNrgMcqmSfh55G35RQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793605537;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=rNLFtKEPB1Fui1lARc25zwjBP1SgCWoDsJiIweYWhk0=;
	b=o63LeK1XsZki05lwvKZhgC2+4RGNR22TTJAiwNF8XYmlLV/v3W7ihQUtW/aS2JnMqIpT
	 YOEstgcUxFghh1GKDRF6TevCdwyiL3FK7Ytz0fxLxfyCr+stLl5cIj85VhOLm4hutf55N
	 m2S9rnJnvybRafzQFFRrn+0tqKYPNCZ/an1JN/iPBawVam1omKfY0UpL3C/ZHE668wWcp
	 fcYK5u1IqWT+Ouyp7zA+8MrOhgwXiPbVxFNhVtiCWbT+/W5G3kcZxP/032/DgjHpadY0D
	 yLMMRNeLV5/Z8k16N6xC7FeXLNT59oSwnbfAnErpCJb40o6xDO1ZYvTLWL9dQ1UfwNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PKmJRlxh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE55606A329;
	Mon,  2 Nov 2026 07:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PKmJRlxh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 058221F000C1;
	Mon,  2 Nov 2026 07:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793605537;
	bh=rNLFtKEPB1Fui1lARc25zwjBP1SgCWoDsJiIweYWhk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PKmJRlxhjUN4+FXCVR+nLcRzXVYMPh6XmvvOmLkQl507NH3pJ9igSl/sxu1zt0Mba
	 FFsjLF2cdMR0iIfR8r2jb03qvEPkLVBBnBzQAd1o2pCmXz0/w8YwsszUEamdQCKfid
	 GBpTcaXvGjw82jA3x+MRFJNQ43IMou1i41rcpLWMlN5E6pSZIb2N+ylgICw1B6LinY
	 1ezU1IO1svD8akn6RObmGfkY+UQMDTUJMPWGZ5ruOz92LaU9ABSDWLYsjmzsFJfUzo
	 8mzOFHnNaCL5HXkRqPHwrysDQwRCYPMUeiHVk23R1EsUu5AKR2jEAFOLzvhD7PZ1ZB
	 Sxo6QVLotPbWA==
Date: Mon, 2 Nov 2026 08:45:33 +0100
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
Subject: Re: [PATCH v7 08/11] dt-bindings: remoteproc: qcom: adsp: Add
 MSM8952 ADSP compatible
Message-ID: <20261102-first-ambrosial-urchin-3a4bcb@quoll>
References: <20261030-msm8952-initial-support-v7-0-ad748ace375d@mainlining.org>
 <20261030-msm8952-initial-support-v7-8-ad748ace375d@mainlining.org>
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
In-Reply-To: <20261030-msm8952-initial-support-v7-8-ad748ace375d@mainlining.org>

On Fri, Oct 30, 2026 at 12:02:39AM +0300, Muzaffer Kadir wrote:
> Document the ADSP remoteproc found on the MSM8952.
> 
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
> ---
>  .../devicetree/bindings/remoteproc/qcom,adsp.yaml  | 31 +++++++++++++---------
>  1 file changed, 18 insertions(+), 13 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

