Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793605716;
	b=JET6WWxU6rDYomU3/bTRCgT7rVxYNe7wScb59ygu0fHSc5CYNs1uuhnZWObRHmeaWa3e
	 fJa6E81YWzceSRg5tH8iRYhNJr1C1Syf3sAhn1IYVez2malBuW5ElpMXjgYdGzjEJwdqD
	 gw3eKhbCshe/N90iMZdRf5KOCbr8aGvyUkduSSc5k8vj5iBOJSE/HEk/l8UyJcqIvA8tW
	 IMM/eSZOZkW70+tllR74BefMTdx0xHyO5RVAXmO3+rMsQAHQRtWWlvWqyYpbsuEGr2+c1
	 T0piAuDw8nOThWSPdnJC94V47fvYArQjBUeYeCoJI57EgHSgx0qR/egsAXyI6GzqgIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793605716;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=nVQ8uQ8EBtB66FVkdkeahhd5McyzCUW6GqWt7KinKNs=;
	b=Sg/WBaHlCsPEHvtXfLmJ+U3Ku469wfO+03y2DZzD4CtjAeRR9SCU3/MpCzgaN3EO6SKJ
	 e9Ur2kQcrO/2CmwccKnZQBB+bLtIlbTT7EAIiiCoAPj+hNTt352/XGNZMDIKH7q3R3Z1x
	 wKXrRyKSVhhoxIX+BwlL1y7ytXzxUyInsM9pRMYjy2Q6gJpUuE2PA+v+3+GXc1oBoKYD2
	 IZBlMeKZY06tLYSl1bTnfMND5Pt9bxgz+kQTc0pEqfEzMY3AE3a9xKsYACc74mEUtZbFa
	 YCm3xsWArv5LAc3jt/msxok3k8KsCyyAsI5yWbqBIwwCSnzRusd/D0Q8zgPeQGH4Hog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pklyxlag;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79251606A326;
	Mon,  2 Nov 2026 07:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pklyxlag
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 619C51F00A17;
	Mon,  2 Nov 2026 07:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793605715;
	bh=nVQ8uQ8EBtB66FVkdkeahhd5McyzCUW6GqWt7KinKNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PklyxlagO6tQm2cVGswU8nU4eOuTBHos/OweD9u3f/ca41Lm4iCyJbL9U0qxRikrv
	 yWIzLO0cmC0d3VFz7QKkFx/ZpZyze+NuakSCqqTiQncEkJzAYycdkwXah3+Ak6jbLn
	 ydjJSC/rhs+gzXiXIlcAT2zsnnqDq5A6KF54Bzm1Yjt5j7Z3I4Gh0vwikrkrcafJ+m
	 vGIV+APXdN+V5kbITNlGnC2StM2e37BY/UJ1Hv3oC2jCUQJgnIr3tsubFPEdwx9kYi
	 THAeVc7SUobHqUdx9NYyAUxKfaMB31YgcEPaxZxODLGkzafDxC82RdKtEwT8Sw3lzs
	 B8rW6g7YgU4Og==
Date: Mon, 2 Nov 2026 08:48:31 +0100
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
Subject: Re: [PATCH v7 07/11] dt-bindings: display: msm: dsi-controller-main:
 Add MSM8952 compatible
Message-ID: <20261102-blazing-tortoise-of-vitality-6f92cf@quoll>
References: <20261030-msm8952-initial-support-v7-0-ad748ace375d@mainlining.org>
 <20261030-msm8952-initial-support-v7-7-ad748ace375d@mainlining.org>
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
In-Reply-To: <20261030-msm8952-initial-support-v7-7-ad748ace375d@mainlining.org>

On Fri, Oct 30, 2026 at 12:02:38AM +0300, Muzaffer Kadir wrote:
> Document the DSI Controller found on the MSM8952.
> 
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
> ---
>  Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

