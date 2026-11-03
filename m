Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702320;
	b=UnJKZ4ZhtwX5pyfvtV4Y/vgsyP8bnTp3meAecCc+xTE2THXmi90JiVvQhyy5XCNll+fl
	 82A5LmXa9sxIFNDLwyrIXfrUSVtEToD+fEfdU8ZhVRq5Sxb7tiyM9rY6w7646R6Ho8dQg
	 NpykOgKLKbw382Ddr8YQ8zyNb148s7EKAlkZvBVEN1ckjc4AU+y+biFGr2fiH0jjhc2/U
	 uOfVzSiMr2zbimGsooPv1vpo3kWK338LCe0mI0V2UNKriPRnhOy91rEbn9uKFz834F7zp
	 rL+Dh838l+R5uJNs2RWlBTT9qPfGi/Wx4tIXuY26pdm16M/OxiAV7wA0IgyZ8lNfcGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702320;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=18p/3OUExDCqEZMFFUDX0fp7Tsm8MCYEZebkfiTkCgI=;
	b=U57L5Byp4R5DzxJC5ut+zmZsWKvmB1d+iax9VaOdFuGNnr6aV2AORVNPnWXqKjtviXlv
	 w4sbHS7c3N+DlkhejkQqZqt31LWSYBNy2/dEEw+YlFzll9PS6gz4X03hApCcQprYmudej
	 RHLqc0jAuO6zW5vD0rWHcsBGQTE8ntIVNuh0kFsOqu9wvBufzNoV7h/YDVOo++sIkiPaK
	 CN73lejLzd4Y0afCggeo1kTEeXLzyv4556aGWCC5JTq9zEuZ5qo3xxPy+s4T1/uqY91Yj
	 EVrmsQLnAYlbNVNSJtxIaK89BbWzbrc2FIoUSPbHa6LpNqRlxKEBEYLl5OMa3z/2X/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JmNmc5De;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BC56074A09;
	Tue,  3 Nov 2026 10:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JmNmc5De
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18D4E1F0093A;
	Tue,  3 Nov 2026 10:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793702319;
	bh=18p/3OUExDCqEZMFFUDX0fp7Tsm8MCYEZebkfiTkCgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JmNmc5De8ae+E0694Kb7AHeDeMBLb0gsWDIl+8tSDlprK4UoYh/OAJ85aS0TzHMNd
	 asKOsnCAV+Yz+9soju42obCN9pdGUsruTh2EbPt5hv11JNxkRYh+nT3yaGHbCFz+mS
	 suRLVwVz6xmJqoyQ7bnpgTAwPVCcsmB9g+PeL6bo/8apag/iXFOXpXlCTrHBPvtfus
	 qp1Hv2pzgAToFxouF0+CLwSwwW81B/zWzHhxzWwJ7ohTMKevFNve+uQnekPvrx9aPn
	 Sz78+LBMZr103t0CIQ1EQw92THfWYspLKEJctGOIJSjAfzUZ3NQ9DehGNISZcDYFvc
	 6UJ9CqUQOnGLA==
Date: Tue, 3 Nov 2026 11:38:37 +0100
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
Subject: Re: [PATCH v7 05/11] dt-bindings: mailbox: qcom: Add MSM8952 APCS
 compatible
Message-ID: <20261103-rapid-turquoise-viper-70686b@quoll>
References: <20261030-msm8952-initial-support-v7-0-ad748ace375d@mainlining.org>
 <20261030-msm8952-initial-support-v7-5-ad748ace375d@mainlining.org>
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
In-Reply-To: <20261030-msm8952-initial-support-v7-5-ad748ace375d@mainlining.org>

On Fri, Oct 30, 2026 at 12:02:36AM +0300, Muzaffer Kadir wrote:
> Document the APCS mailbox compatible for the MSM8952.
> 
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
> ---
>  Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml | 5 +++++
>  1 file changed, 5 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

