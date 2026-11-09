Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794210021;
	b=XstbUpfnpLgDvxBKeWSngschYnObCzpGP6RmcWWj9sRdVQg/KOpY81vzrzwwAShfdbLY
	 fU+Tq89ORPJpES4hee7MGTgPfBP9hzzVxyCL3U/Rws1ujkjEetW3Jhmf1cvmgdBzrGezX
	 W2GAtd9gwwJ/jmdwiqPd7WRcZySETx1v1XImRZx8yyWDf1t+sPWbVTKuSsqdeI4BWwJik
	 vh4sFlVgqAkalOoa+j5sK1LIk/U+pABrHqRnD/XPJdo0LoggQw0OSTOhtSyGZtC8oOn/n
	 ZpkZC++tZhW2k+eSR/Y0tzHUby+xIL+TeWTwcVyO/EwBaq3yPRbfL0EmfFt6tKM1HBQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794210021;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=qbtFVfAV0d//avrt7X6KHwZhQyPReObvw80fRr8okBY=;
	b=3BA92Xa3u4xNfVAE7TxzKi6nmCryYwLIuSX5qTOmg/6pDb86ap6nPZVVr+WdxRPEL+74
	 z0/u9f5NqbdTJZmjsIR7UyPNkh1bfNDvyU2MxNGFue6LhXEAAB21vtWcE/K6vKBnmIqGD
	 xBH5k8HYXJ7fiDU58ngp/YVrJLUYm9iT+xbZ0IRFUoCcYuB3saYW4FxBUAtx9dfEIf4Wn
	 xPHvUeCA04Z171QU6OJH/gm3pPZW+bUTaop61eLCZQ5ItVhKTrtV3HhrZWVfrE6B/VbCl
	 Ovd9gP4ZhJkfFfJcFK1/pb+AFfuNz05ubY4BnkBERQFqZWF1UXEwqnupVV0Vv7M9H5g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fw1HJ3eB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CA8606A334
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 07:40:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73CA8606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fw1HJ3eB
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cdab6ae1ee9so228664a12.1
        for <linux-input@vger.kernel.org>; Sun, 08 Nov 2026 23:40:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794210020; cv=none;
        d=google.com; s=arc-20260327;
        b=UAuEXOPV3MZ4hIxAPZYFNdOHGhHM1tXbMo6hZlM4vlJt62bOE9HsaJ0MHOT/OpyeGJ
         84vctcSlmtpPxdzrfXo23ZBH7qefPNdQ78C0Uu3r5wQPkb52LYftq5vM6bxiQsXYAu0+
         bTWtK8NCjih26m4Tdv/1AyCmzNnxEVKZDjDnGWREP9wzOZqcGjmgT3IoU4BGMakjyFro
         WkeaVnuMODWzKh/A/Qc0e5kfMBJHqqFaLE6CGt2QLIRbCgfQfzea/lrn9qFIDGMwfFoA
         0qNvdXkp710gozyvgLAbIoZ36a3pBtnyjBvoJg4NSjTlb9ZW/tbgbi+yPJp4a05fWZaX
         9WqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qbtFVfAV0d//avrt7X6KHwZhQyPReObvw80fRr8okBY=;
        fh=lxY09oEoRRH4txt3ml+UlpRPlMfUBgrqgi1x4NdFbDU=;
        b=KBKAcVgg8SMXPh/Fy7QObOA/BzpJXDnou1f/ssQ7ehvfchb2RA4SHqBIGwZWAscAle
         zAlwtbbzDvLAhd3WPE7hVi7VUpgljJkr/HN2iSgEuU4DZEZtx5YXbYKw4bXobg6KG/8S
         RPtHNP7kgRh2H396mvAoSIFvsDIH90Eip3ekmSjsV1LyD5Bikt3fwfwYBzfyKLl+LAXg
         HeAc50rtJoUcthFCmyxDASoAS0STdlJfNNX3CDJay+HGdWuOS1CDed3/jt4iZq1EZKdk
         A+wlrOxWnFQ46qlHBhVtZbC+eksG/LnlQxQpCtxsMZlQli6DdIqbSLc8jNxyQfJWy0gy
         MrLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794210020; x=1794814820; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qbtFVfAV0d//avrt7X6KHwZhQyPReObvw80fRr8okBY=;
        b=Fw1HJ3eBrEG+YcG2OfXIKNyXLbtxL6pFyShNR64xnTBicLVJTLcqI70PP7XlmXPNx6
         VWmQ662eksYGc8vJo+lcMpjTIaYcJB9aokKPIxavS8OWhjpOs8W89bix1ozwYvKeb3b4
         M7C1Y4n+R7cdsAeFDh3I3fT0WNvzf0CnRZWDlQZYC+5M2rSyX8wMQx9uS+vQs8QSo0d/
         2FLip2Uo0zLuYIubK7TNTBZ4sl8ZrZ+JeHk7SDm/ZlHHFtWu1M3YyNEi+YttPBGWC2RM
         X/hXAhXzRlZNf20NwByFmIPl+GnzmQCqAB4nehLzmm3jWxLA5k3xC+msTg/JbR6XvUqv
         ep4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794210020; x=1794814820;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qbtFVfAV0d//avrt7X6KHwZhQyPReObvw80fRr8okBY=;
        b=bLfm+uh4bOW1JqN046JnbZr/Nd80DjMMH7+6MqmVEc0rRjloBN6yZTY4MKkm08gtli
         KswdrtU0kS5V5wu/VEV8VRpb2oyXA50/9zbtEu9ZYH429V8rxVOwln4PG6d3kjaxRPLx
         LClUyFTLV0qDv/fWV23tfWiXtnGKE9Oo9mCbxfcVGgEA2aX2Xzx8X2QBejHhAq6wKmvB
         TyJTmOnlCcfvkn6Z8EgFvJrrDgApdRWimiEjDm9q+KcatL2rPWmhSIkOKKlMuuglyFqW
         IVw/p3mfx4RT3LYgchsJFjKGjgiqxDroH2k94zsDtJVTYKPF4ULmuPLFF5+lZhGPmNZ4
         2cgg==
X-Forwarded-Encrypted: i=1; AL+hErEvfdvta9DMe5Ve/nvri9vC/ZeiloyyHtQfC5Fa8ZFnruI+csmx/gCT9yr6AmFsMmr17i+mmpaQEc5AUg==@vger.kernel.org
X-Gm-Message-State: APuU4Z90294gTMUcytRDQIsdaDvty4pTXLRSlfFx7QqOBjAr297WAbWn
	RMlrj/+DnTIZxcND1QXno2qIzOQTJq/NRpCA8pY5wzPg8FTaC/mlkjKUi0AZv+lyiuunBgA11xi
	j6u65VdgUqZv33N/8gBJD2Ov1z0kHPXM=
X-Gm-Gg: AYBFou0v8iVF6MZ8BtTdv1aPSPNHx5BCH255FQrjRwzSmu+8oGoaqpXyfZ2qH14TsQM
	2+guWJZBQDbsd9f1X+/iBuOVhumyfe+s7TE4yiDuOBNHAnmt+T2R73NpyLVN8M3FOERbwOm2axX
	CZ+2Hze2U5U4aR0fuublfK/pvgdK0EhyPyBlKsOr7jIrb8UuYaLOe0DXeJjprrHlA5/oDSP49XT
	fS+DjlxtwO0azOX8wDxiZcmtmQKI7Kbkkjv7IIwksdiGhYgkdKMir+9Ys0GOyorGzPL22BhrS/4
	Tab4kOiJ9atDAE8ajBVH35osmbFVxBCPV2i1YtZ8d26EyvW/D0CJx76oyvoQoobcZW3zIPLnS2z
	+U+sgEudJ/wlkeVSCpcM1++4Nbtp6jdnDvKE=
X-Received: by 2002:a17:90b:384c:b0:3ad:a270:a623 with SMTP id
 98e67ed59e1d1-3b12d107e44mr3364118a91.4.1794210019701; Sun, 08 Nov 2026
 23:40:19 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102135330.2493332-1-robh@kernel.org> <CAAfSe-uD=s0RpuqQ_h+_fErcEC+G=N_LA6e=p_sXJ=iG7jMc3Q@mail.gmail.com>
In-Reply-To: <CAAfSe-uD=s0RpuqQ_h+_fErcEC+G=N_LA6e=p_sXJ=iG7jMc3Q@mail.gmail.com>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Mon, 9 Nov 2026 15:39:42 +0800
X-Gm-Features: AclHuK_dnPMk52UN3-2_wspDGRy5a6s-cwmnh8paY6ZY-G54Qz5KZ0bygsAWCVc
Message-ID: <CAAfSe-shr1+0YpxEvf+4k+DyGe3==PUiD72CwjE+RC4gX-ShiQ@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable

On Thu, 5 Nov 2026 at 10:39, Chunyan Zhang
<chunyan.zhang@linux.spacemit.com> wrote:
>
> On Mon, 2 Nov 2026 at 21:53, Rob Herring (Arm) <robh@kernel.org> wrote:
> >
> > Unit-addresses by default (and most commonly) are hexadecimal. There's =
a
> > number of cases using decimal patterns. Fix all of them, limiting the
> > pattern to match the 'reg' limits if there are any.
> >
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > ---
>
> [snip]
>
> > diff --git a/Documentation/devicetree/bindings/thermal/sprd-thermal.yam=
l b/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml
> > index afa551f6185f..222d70baef1e 100644
> > --- a/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml
> > +++ b/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml
> > @@ -47,7 +47,7 @@ properties:
> >      const: 0
> >
> >  patternProperties:
> > -  "^([a-z]*-)?sensor(-section)?@[0-9]+$":
> > +  "^([a-z]*-)?sensor(-section)?@[0-9a-f]+$":
>
> Reviewed-by: Chunyan Zhang <zhang.lyra@gmail.com>

Following up on Andy's note about this:

Please disregard my Reviewed-by. Even though I did look at some of
the other hunks, given that I'm not familiar with the other hardware,
I don't feel comfortable giving a whole-patch Reviewed-by out of
caution. And since I'm no longer the SPRD maintainer, an Acked-by
wouldn't be appropriate either. So withdrawing is the best option =E2=80=94
sorry for the inconvenience.

Thanks,
Chunyan
