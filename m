Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36F52D879A
	for <linux-input@vger.kernel.org>; Mon, 26 Jan 2026 20:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769460483; cv=none; b=t6cspU7HjUNLFH5usMSBo+I1tAGX5DJq4sKQByu2CDOp3LFxPWe/xBf11vaP5giO3FslGW4k9NhlNGeyepd7AxCJQNY75MxgRJdm4PVOuHHImKnCEGShiJ14SXIhfzFLGuwPv0Sex1d1jVWZLkOLPH27MrQzJpre/aMhjf8W1co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769460483; c=relaxed/simple;
	bh=WqSXMgwN1bj6WlKNWD0giAIg11OWSEsUWJe5KbkBJ/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u6YDbq+TY9dcl2WqCDoJzIc5aeNwG00kYkcBJblNGnCrYC7UGidvLmkxEj4fMk5aQ4oeQr80lzmdwYnmBedlmEQC5a0J4YrivvA2G/x9Hlw0qkW4HykU3B9UISX+UX+iHlW/xbV/bBpMhdDQMPdVXg5oVCWL84ppxyGCLLpcAfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Omt9GC8K; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Omt9GC8K"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-5eea9f9c29bso3321649137.2
        for <linux-input@vger.kernel.org>; Mon, 26 Jan 2026 12:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769460481; x=1770065281; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iCW3LI0lwZJMRrEDS+3kqbUxY3kv4Hh4/Y+P85JSc/0=;
        b=Omt9GC8K/qths/X9T8xt6w6jB6jmEiuKBoYdSeMBzyAoPMWyHK5ZX8XEn70L0fHWol
         CBBV85De73I+xMFKqMGquDenBuSka+bJnTf7+PpB+lyKQz9GV6tPODBi8FemrO1QZfpP
         /P/O0A1IycRUr9J0fxQUY8w2hRosBnTmhRkfsLB/vrklDSpmaniYK6U9ELPgEipE1beo
         Pvg7m2Ai+7R92yHrbU+xBGDgbBFu9cLQ4/ROTaQmmlmdzwfow2leho5jP7l9OWaYXpAB
         S6ZobFxLk5X91RNq9492fShKVECgkXpeI9w/6l8kACazT0hCO2ARS3f84neBMw4HP7o5
         H5hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769460481; x=1770065281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iCW3LI0lwZJMRrEDS+3kqbUxY3kv4Hh4/Y+P85JSc/0=;
        b=U76BzurQ5aEevfWp3ceaC3UNPqVz4EXz50IGsfffsfeAyrdQQExGZHO1cGGBl3S7q6
         5ra9g/3FxEjqi+XjOzWjnXnV19ylQgSC+j9zBXDucldfDMX0TkM5E47EtFeSWkBtYvG+
         1RDxseNDlEpfeBv4K4eqaglqkqlHFxB/0SaPs03yHJ2U8PVNpC5ggdQaMFR/gNjX2Em7
         LAxq/VZIv2srGb5+0kInxUWzdG/+Dhb/9R1yBGU9wIMk4QNXpe4Wm6VNeqMN1/E6rd0c
         tQma6CiNGH7Kumb2brq7KEu6mV3XWUpysjx2uR/fdlXXsfyWtBtMLpngxSgNCIGUpoFa
         TJlw==
X-Forwarded-Encrypted: i=1; AJvYcCXm4CM1hhDze6Rwo3xnxx+OBT1/LfTd6jJLiE3PIRzAE6jgvpIyvymBN9dfmso92t/gSvNBT0c74iv5gw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxRPKpDvJzXUODObDAgsGqF2e57wKjq07ZOPZeZFsLiTv/jJhgT
	lbmbyiYxwYrxf7NVF+dnQHG7lA7ZwjujnSF88EsJb5paosaJGuCkBTgkCijUEA==
X-Gm-Gg: AZuq6aLpNQLGF6DVP8Agf6jeMTrkB2VnjcOCEOJfh6zKBKXIIoIkoo2vz0+v94zv5Kl
	Lzodp3kjPAA9GPwkI/4c8WWdKByI35yXDAITw8Lu/rFlTJE+KtdcVpBM5a8EKJGje6ZV4sLkMMe
	3sgYiBmj/CXd2drVo7OKpmU6hT56drBvxln4aK5UjwbRxmjPf3bZ2EmTqBnBmXzFGtoQmH2w3O4
	Qt3vs72v9uQHQDNrLYXmCZqF3q7/HKrX38+/QWc26o84tqgE9MNIqCwGtW+qx3UH0iIzCJXcZ1E
	L+sVKM5/vSeZglNojGJsemgji/3JpAsZjUdcFTaWETe6EgEB8VTVTaQ/1C7Y6gFvJTotxjAyVA8
	YvBdyNRGkEbEqCpUaaQe/e2tzn04MwqqUP809G86HhOELBePtQ9f3DkJugO4IRFAXLT61M/F2tC
	gbR4yIMRxqT7GJ+TPhfd7UyJ5pHmmkCz0YBV9IUyIolClSAoqhpskt
X-Received: by 2002:a05:7301:1003:b0:2b0:5028:bafd with SMTP id 5a478bee46e88-2b7642198c5mr2076868eec.8.1769454774472;
        Mon, 26 Jan 2026 11:12:54 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:cb35:17f5:7e82:90c4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b749e301f0sm13452476eec.35.2026.01.26.11.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 11:12:53 -0800 (PST)
Date: Mon, 26 Jan 2026 11:12:49 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: "Rob Herring (Arm)" <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Christopher Ruehl <chris.ruehl@gtsys.com.hk>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, 
	Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, 
	Frank Li <Frank.Li@nxp.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Fix emails with spaces or missing brackets
Message-ID: <m5ckxhpvhtjcc6fzlsz7y5sjxvzlbx6n7vel264hbw47joivi6@iwchebcbyjod>
References: <20260126164724.2832009-1-robh@kernel.org>
 <9a3d4ae8-b57e-450e-971b-d09fc923eee1@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a3d4ae8-b57e-450e-971b-d09fc923eee1@roeck-us.net>

On Mon, Jan 26, 2026 at 09:21:15AM -0800, Guenter Roeck wrote:
> On 1/26/26 08:47, Rob Herring (Arm) wrote:
> > Fix email addresses with spaces or missing brackets. A pending
> > dtschema meta-schema change will check for these.
> > 
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> 
> For hwmon:
> 
> Acked-by: Guenter Roeck <linux@roeck-us.net>

For input:

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> 
> > ---
> >   Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml    | 2 +-
> >   Documentation/devicetree/bindings/input/syna,rmi4.yaml          | 2 +-
> >   .../devicetree/bindings/media/samsung,exynos5250-gsc.yaml       | 2 +-
> >   Documentation/devicetree/bindings/pci/mbvl,gpex40-pcie.yaml     | 2 +-
> >   4 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml b/Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml
> > index 3d14d5fc96c5..7b38f2182ffa 100644
> > --- a/Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml
> > +++ b/Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml
> > @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
> >   title: Sensirion SHTC1 Humidity and Temperature Sensor IC
> >   maintainers:
> > -  - Christopher Ruehl chris.ruehl@gtsys.com.hk
> > +  - Christopher Ruehl <chris.ruehl@gtsys.com.hk>
> >   description: |
> >     The SHTC1, SHTW1 and SHTC3 are digital humidity and temperature sensors
> > diff --git a/Documentation/devicetree/bindings/input/syna,rmi4.yaml b/Documentation/devicetree/bindings/input/syna,rmi4.yaml
> > index f369385ffaf0..8685ef4481f4 100644
> > --- a/Documentation/devicetree/bindings/input/syna,rmi4.yaml
> > +++ b/Documentation/devicetree/bindings/input/syna,rmi4.yaml
> > @@ -8,7 +8,7 @@ title: Synaptics RMI4 compliant devices
> >   maintainers:
> >     - Jason A. Donenfeld <Jason@zx2c4.com>
> > -  - Matthias Schiffer <matthias.schiffer@ew.tq-group.com
> > +  - Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> >     - Vincent Huang <vincent.huang@tw.synaptics.com>
> >   description: |
> > diff --git a/Documentation/devicetree/bindings/media/samsung,exynos5250-gsc.yaml b/Documentation/devicetree/bindings/media/samsung,exynos5250-gsc.yaml
> > index 878397830a4d..9196cf5dac0f 100644
> > --- a/Documentation/devicetree/bindings/media/samsung,exynos5250-gsc.yaml
> > +++ b/Documentation/devicetree/bindings/media/samsung,exynos5250-gsc.yaml
> > @@ -9,7 +9,7 @@ title: Samsung Exynos SoC G-Scaler
> >   maintainers:
> >     - Inki Dae <inki.dae@samsung.com>
> >     - Krzysztof Kozlowski <krzk@kernel.org>
> > -  - Seung-Woo Kim <sw0312.kim@samsung.com
> > +  - Seung-Woo Kim <sw0312.kim@samsung.com>
> >   description:
> >     G-Scaler is used for scaling and color space conversion on Samsung Exynos
> > diff --git a/Documentation/devicetree/bindings/pci/mbvl,gpex40-pcie.yaml b/Documentation/devicetree/bindings/pci/mbvl,gpex40-pcie.yaml
> > index d286b77921e0..8f5d33050348 100644
> > --- a/Documentation/devicetree/bindings/pci/mbvl,gpex40-pcie.yaml
> > +++ b/Documentation/devicetree/bindings/pci/mbvl,gpex40-pcie.yaml
> > @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
> >   title: Mobiveil AXI PCIe Host Bridge
> >   maintainers:
> > -  - Frank Li <Frank Li@nxp.com>
> > +  - Frank Li <Frank.Li@nxp.com>
> >   description:
> >     Mobiveil's GPEX 4.0 is a PCIe Gen4 host bridge IP. This configurable IP

Thanks.

-- 
Dmitry
