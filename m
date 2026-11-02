Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793605302;
	b=UXNTYOdleBrjTf3wk8biSo/11X0e2s/R49i135fKyPxhr0XFfT5s8wVeGW9oowS0ObFK
	 qCV1NrOyj8Qxr5Z9cRjIRbnEsd3lVyDJdOq+lgqceJV9dk8W7o1ODz01z5xtg9PdbxRS4
	 zVZ/LOWWKn2J6pZwmH5c9r++GHhIGrxTlWLVdaVlvt1iJWYQm/7B5hEePgep/8klzLxcb
	 icCHS3E9tKayXU+AsebbW6nDI8W4jrcvCXNcts4qrc8eI29g/OMMb3RPhRbHAHuYFJrb/
	 8yjqRb57zlhENa51rsr3Um+FUtHHvjUCHsCJwNX01xCK1EivvYN7jsowq6aX9NgK9tQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793605302;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=o3CXiVBXl+lfNC5fS2tE1jGGqJWXPOGLe9G07hWwZY0=;
	b=GTGwQNHSB+qf0Vi/AKo6sDq2aWEVZACnmBl2XuYSnkejbBNKzfMANwHXX8wAgqN9fba1
	 2B8cHRAnZReALQHcaBaIA/wLdzpllFVSNWWClytNDx8GtCe7X2Y4t0CUzYQygluyjQjiE
	 HeUkILcN40UQDm7d0gLQ29Q7UkeQBP/Ty8MBqFs8oCcIHNkOj3cIHs1ckUeYMRw0nTLr+
	 CNrIneCOpUfjGyNvX/nGz5c/qt6fUXcmLUYCGVDo91cYRItHnaT3EHOj+8F6y8zOTgDzd
	 nBWfkiEOgR8s3TlRcUEbgYJez09KfsQa2kOzCEaKPvMwtB25IcdKFk6RKN7g/BM2NZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U09q1VwK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4875606A329;
	Mon,  2 Nov 2026 07:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U09q1VwK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1551D1F0093A;
	Mon,  2 Nov 2026 07:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793605301;
	bh=o3CXiVBXl+lfNC5fS2tE1jGGqJWXPOGLe9G07hWwZY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=U09q1VwKKQhxiFlFh4imcH5lh7tFP1PJSEcx2sYF1V7QHYdI79yVOWJB5UCJv0A/Y
	 W1H0wyRvoMTPkpxSdnW15glyu/xbXyjN4z8tbyPOqCrdfUJujO0CzQfaXAJWeCr1z3
	 TvArFDAy/3M49foDCkQ2fKc13C4gCFGKdZ4LlvbJumVeKcwRbFnjGfDPC912vbI4/u
	 ApsqFi4xafQl2Z1dGwP7W3+D6EzsStDEK54NjkpJCdg7Hhx+8ZuAgSgrqWSh5dhQAw
	 nHVvkDwcfHHXAU/Y6an6hjlTOGPEkeyHKFTXjbAr9eawijtr6kn3M/whdfQVcPy5rf
	 J1YhDQcI4keFw==
Date: Mon, 2 Nov 2026 08:41:37 +0100
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
Subject: Re: [PATCH v7 04/11] dt-bindings: sram: qcom,imem: Document MSM8952
 compatible
Message-ID: <20261102-gleaming-aromatic-loris-e0dda4@quoll>
References: <20261030-msm8952-initial-support-v7-0-ad748ace375d@mainlining.org>
 <20261030-msm8952-initial-support-v7-4-ad748ace375d@mainlining.org>
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
In-Reply-To: <20261030-msm8952-initial-support-v7-4-ad748ace375d@mainlining.org>

On Fri, Oct 30, 2026 at 12:02:35AM +0300, Muzaffer Kadir wrote:
> Document the IMEM block found on the MSM8952.
> 
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
> ---
>  Documentation/devicetree/bindings/sram/qcom,imem.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

