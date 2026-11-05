Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=43.154.197.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793846853;
	b=yb36JVLoQT+eczP+fKehjiEf0mE2ztRS5pnbhPWC4eIHs21QVtCNarkLswbUkkzFVf60
	 DvLkLPlDxBIIcCkEW8xRxilEmQUxVzp35zWerNSPBKV4+1tbq7UwlX3e2L+ftoZmJaaPU
	 6uJXiSZb4s+LsSoW14idDDM2gfjJyhZPpkNldK/9xkWCRl7uPqDXemqPPu9ziC80fc8N1
	 ark3knpw/OSTmJJQS2GnPAVoLGJHpBt5HGNsZLGd5NLM6F5Sv+C0qhbOoeJwANZc8Fbvd
	 wzIoj9KeKFokCQJPudvXoJzLmqVzktih87k84EaJ5H4fiiSfaVVethVXcU/jYsgXKzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793846853;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=8nHg2KK9YdUFsDyCN5OyhUk3RMp8EQBW/fDZ8x8OirA=;
	b=xXE7nrYDz9PtQua+hbPYjiNEaGbNdFE6f0zz8KVY7WGmFH1eBVmLh0RWQ7vD7s11Kl1N
	 i1YN/ugyRL2Noyob69LL7rT9fC4ZE0YcL1GGnwkQjkq90J34zlwFExA3kxHl74kVhI2ou
	 WD3H5enUVLaoGmSQsqpPh9GJLPPw0GHvLjMq1GMn3vXmGZu+uRIfFkN6PeUk5not+pH65
	 MWzLpR6vWP/7Z8BGGcqQdCd0bLfJSSlrY2x+BQ+vxBpox3RNRUUPUxAWYLXaltlilD5Cc
	 yed+2ajiOocGvHjhYD4O3W0voYU/lUkcSc3MbG6GwS2G2cMGbAa7Y9XiUSdXZPQNOvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux.spacemit.com;
	spf=none smtp.mailfrom=linux.spacemit.com;
	dkim=pass header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b=nvGnA0DI;
	arc=none smtp.remote-ip=43.154.197.177
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.197.177])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843A2606A326
	for <linux-input@vger.kernel.org>; Thu,  5 Nov 2026 02:47:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 843A2606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b=nvGnA0DI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1793846842;
	bh=8nHg2KK9YdUFsDyCN5OyhUk3RMp8EQBW/fDZ8x8OirA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=nvGnA0DIL8ph3YJ7d9CKqmiNiAvNkO6Hmf9dqP5grXJpNrFpP+zk95x0qfRYLMjlk
	 xiaP5X/EXKsReKkgHDHOaXHi8EaztDIbnff/9AR8hDWdGRt8/raLfI8RELe1qglbhY
	 GlpnQSVyv3h0024+exes62sHb98LOepE4A+OjPRk=
X-QQ-mid: esmtpgz11t1793846841t0278aba5
X-QQ-Originating-IP: lmQbydxD4nAn0x6X8zSmhnz4uWIukPeSEeXAm++Vmy4=
Received: from mail-oa1-f51.google.com ( [209.85.160.51])
	by bizesmtp.qq.com (ESMTP) with SMTP id 0
	for <linux-input@vger.kernel.org>; Thu, 05 Nov 2026 10:47:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4420609804843103380
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-4a77761ff8aso898688fac.2
        for <linux-input@vger.kernel.org>; Wed, 04 Nov 2026 18:47:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBy4FykbmyAxtEHtKjelKj2muwJL50oZRaa5mU1Fi6BJ9fZe2K/ZOhvpIKDR0N4Ijms78GyGWlyt0Z9hOA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/+a3fqqAm8p2wau1cLoTM/4dcGFnA0LCjYiYQ9Xk/3Pe2gcn+1
	jEt215PdlL8eKzh9XeITZpZ9z5dPEAHu2/d2GxsSZVPGvKh+NSd9IksRc7MW6/ghwZIQkCxOVul
	gqANKwAvLNMfO45dUXXTAF94GkJ7yZo4=
X-Received: by 2002:a17:90b:562d:b0:3ad:a462:f07f with SMTP id
 98e67ed59e1d1-3ae8982c1ffmr16206466a91.45.1793846382617; Wed, 04 Nov 2026
 18:39:42 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102135330.2493332-1-robh@kernel.org>
In-Reply-To: <20261102135330.2493332-1-robh@kernel.org>
From: Chunyan Zhang <chunyan.zhang@linux.spacemit.com>
Date: Thu, 5 Nov 2026 10:39:06 +0800
X-Gmail-Original-Message-ID: <872B2B4EAE847E62+CAAfSe-uD=s0RpuqQ_h+_fErcEC+G=N_LA6e=p_sXJ=iG7jMc3Q@mail.gmail.com>
X-Gm-Features: AclHuK-lEE7dv-iC1Lsio6aPGOufL5hgelB1hFojisk2-zoMsjC0hhsp9HraOXA
Message-ID: <CAAfSe-uD=s0RpuqQ_h+_fErcEC+G=N_LA6e=p_sXJ=iG7jMc3Q@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Use hex unit address patterns
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Jiri Pirko <jiri@resnulli.us>, 
	Ivan Vecera <ivecera@redhat.com>, Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Olivier Moysan <olivier.moysan@foss.st.com>, 
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Lee Jones <lee@kernel.org>, 
	Srinivas Kandagatla <srini@kernel.org>, Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, 
	Ulf Hansson <ulfh@kernel.org>, Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Paul Kocialkowski <paul.kocialkowski@bootlin.com>, Shawn Guo <shawnguo@kernel.org>, 
	Chanh Nguyen <chanh@os.amperecomputing.com>, Alistair Francis <alistair@alistair23.me>, 
	Julius Werner <jwerner@chromium.org>, Paul Cercueil <paul@crapouillou.net>, 
	Dmitry Osipenko <digetx@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Ray Jui <ray.jui@broadcom.com>, 
	Scott Branden <scott.branden@broadcom.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	chrome-platform@lists.linux.dev, linux-gpio@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-sound@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-tegra@vger.kernel.org, mfd@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: M2ThlVfcav35aIVvR63JyQgaYfk1d1JOUJaFw6j6ttxJF4YTCHmWUVsM
	/TUX/5itxZ40PLgx8NOACw1zIOcbMoKDggLq7fdqSddD181Hf9wB09kXxUDr4OkCmojdoUf
	7oOQBq1iHL2AVhM8GqDhxU8f0zIeFJVaZwydUk2ZzWdMbFOBTmRpchH84Hn0RSiQauWlh3r
	iy/2E6Oe6vZqWLzdOGBIqMZuXYjR0DX0f0WjN4jXG/H4Xqrs2rn/VB95fbQEXTc+0teglFD
	kRkKbg31/7cGCLuVX8c+dFnhxWAOsQnWFb8IwbveykPjDbYF+ffmWmiCTHOFwq6goikwknc
	J0w9AT4nPfwh197jDOJcM4KMclOBFdUdJjIn2oCILEf/xY8vItz6e6JLCiXcQuVMptfc54Z
	VV6QTJgfAzeEbZf/WRi/tKQjzKycsGO2uPqJQaNF15E2/RcMZATMLTw0RWfCe0WXtB9NGY/
	L0KqWCEI8Y4KLkoxguLh+wRwwa8K3Ekotrso5eVk3tz5zqd9wytTckegi/mgQwIiEzPxrw7
	NrDvzM/sk87lpEvTHuJssO4wY2rD1DLBMVsCHuHkqNK88JBo8nPnp7Xsaczl/zledkNXsuD
	vlKDTaGMRul0qCkYtsMiQge4v76VFS9iK62CS9axtePZCBvm7p2GXYXa51/nhXEKIsI1toU
	mfPIQV1q6eb4uSz3ixqBJTTpngRxn1gQb5oPTlgSGwjcZGPbu9Ygx12UsuNcBUGuFxOFPlO
	hkxIuJgFusf2PCbHt1pvhDdMpSfH34rOz9kA9evUtuaVX7Kuo7yVTTP9cLvVOjU9jpNImvK
	hpHT3U2jMSzNljnO6BDAVlENOxxb07KkYrL9/APxqGCrkEwwU77QvUQzTxLNcPWaOyUTnrZ
	K/uWzm9cJ4Y06462HzZgPYrlcMmMI+hGAnu05Xwu/W7BSBNhiibRNm4s9c19HJPYX8ypfeR
	q4W2oO/hLvQ1YmL2gRL4JrKh7lpZVteNEBZXMXQDXLFGNiCYlff4W0FaCmTDFMVsj9K6WJO
	4cyUCb++QhWwNSTeJqhYYzizzYqQzKDm8UaweeI5jUA2z06WtWBiSUgbNa/6y14gX+iuX8b
	sFO7r/BrzhUTNLawAB2RrTLt/jl/+8I0wGegjmHA8cO
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

On Mon, 2 Nov 2026 at 21:53, Rob Herring (Arm) <robh@kernel.org> wrote:
>
> Unit-addresses by default (and most commonly) are hexadecimal. There's a
> number of cases using decimal patterns. Fix all of them, limiting the
> pattern to match the 'reg' limits if there are any.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---

[snip]

> diff --git a/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml b/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml
> index afa551f6185f..222d70baef1e 100644
> --- a/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml
> +++ b/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml
> @@ -47,7 +47,7 @@ properties:
>      const: 0
>
>  patternProperties:
> -  "^([a-z]*-)?sensor(-section)?@[0-9]+$":
> +  "^([a-z]*-)?sensor(-section)?@[0-9a-f]+$":

Reviewed-by: Chunyan Zhang <zhang.lyra@gmail.com>

Thanks,
Chunyan
