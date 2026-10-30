Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793348339;
	b=vWARb85smxwlSnP3RkjeqZ++7SLkxrFlL+eN/q+ggc/L5Q+QUd9W/dq517hcJgwkoAty
	 Fco2LZ1ykVmZk+FHZY7v1XVEWbFRXotWbaVLuY2/lnxa3nUsiuctec1JxhpZ8FAE4ajUk
	 5NtqDsPCN6AF3XfmSzEHQ3+F5FXc3ivXEXEPLWonuI7udLYBkmMRR01TnIB+KaV9vXfai
	 bSfeVBfU6aZIEKv14pUPR6FXi9ud0w0kvDyS1L6O0hFet6WnLeQVFUnqZw7kEbD2DXNCw
	 P8SD1LTZbe1HxlfqKcIDRxzZR5kmTvzB8VYK1XwuBKbXn5PdIlzV7no6YP5R5JUzZhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793348339;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Mb9nK7C88AA0XX7+dkq9DLF84KPAyUNf2hmpuTFCm7A=;
	b=wTR2UaW2wQQigE1RsMhiREjrW31u3f9Ef0Y/u6urDt+OiDxOhhMtIeSn9M3ilsAilmzo
	 XWk4GSHL4QYE897dULFiazTydWOZlpGmlSi2EfcPpO9faNStybrabG6fzIt7Zr2KrjWyt
	 xBEH7aVnmJ72ZF9S5RDctKwb/DxsNEG/t6XVUYVGWraRUFmG/xY6l8bWvgpQp2SkDaA7g
	 53LjvHu4r3OLgrQ30npwHZACFC5p8tJ6b8yUrSLPw1Q3lwMtEyhKlhqd8HjEMgG2KccFg
	 52FMXqX1RLL5yiH/Esl8KNb3pZR476S68MB4y/fWBTndueDWAyqQakP2fOJVyM8tnWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aGi+krf7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888C7606A31A;
	Fri, 30 Oct 2026 08:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aGi+krf7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDAB71F000C1;
	Fri, 30 Oct 2026 08:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793348339;
	bh=Mb9nK7C88AA0XX7+dkq9DLF84KPAyUNf2hmpuTFCm7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aGi+krf7xcDXjZG+aCrcGgkyMEdP0I3fr312ylcIHL5Et2iKMPq8Fw7kIY64ar+uR
	 KoIYVG7NZPLH+o7p19hommRYKC4Nz90DVmSr4bGhrvD1k+njk7BD0EIemrLvqkAcl6
	 dAAKbGpEfLhQF/63qbcJv/CnWcp6jdJcxYnCaI4SFLeDS/x5YEhEXxkDoEeCRgxvD0
	 cy/G3LljTTFpRAKYc36ayAwb6RKh15aYm8qnKjwC+juFRSnioV2XLb6CUnDtLnVtQB
	 ZhXHPJdE63+YBhHN6LHdXdnLnK5stfFGsL5S94nkKjGosdRlpyVVTGSkHfj0NDhViZ
	 KmZQI/iHYHJ9A==
Date: Fri, 30 Oct 2026 09:18:55 +0100
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
Subject: Re: [PATCH v7 03/11] dt-bindings: watchdog: qcom-wdt: Document
 MSM8952 watchdog
Message-ID: <20261030-encouraging-diligent-kudu-dbd1a7@quoll>
References: <20261030-msm8952-initial-support-v7-0-ad748ace375d@mainlining.org>
 <20261030-msm8952-initial-support-v7-3-ad748ace375d@mainlining.org>
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
In-Reply-To: <20261030-msm8952-initial-support-v7-3-ad748ace375d@mainlining.org>

On Fri, Oct 30, 2026 at 12:02:34AM +0300, Muzaffer Kadir wrote:
> Document the watchdog found on MSM8952.
> 
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
> ---
>  Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

