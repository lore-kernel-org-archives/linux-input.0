Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DBF3921E6
	for <linux-input@vger.kernel.org>; Mon, 13 Jul 2026 23:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783985312; cv=none; b=BDpuf/wWjO+X2Fol+VzhWq54NvS4JfVIuNIrlhEQ98cYsBZDIgWjufIKAWrQ24F3zCtnYAVvIUsJG0UcJIXfQkAVLGAvoegcgPSXofxdCmq0+ZnnEAxbyTP2VfQRTLOlvDJk8KK+Hp4sJ/XbN1QGMgBhzq4iVlItWkr/NrrlbBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783985312; c=relaxed/simple;
	bh=DwO6y+Ab0cx+SrTxwPQilr6LVoLTkmY/M+Nb0LYw8Yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sGrJuCSM9GhdYAUrAE6K+KzH1KsQJnt4hG6qOWwStjau1SiV8UvbdruQ8QW50kJ3FtTslRJeNggZEypCw7m+TFPo8nTylPotL86GHPQxLjVidT5N1BitqH1yLeT/ZZ9N9WdrLzkPFQBg4GF90VxQV4A+9Yv4uoez8t2AH3/L9jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHqlKbVq; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHqlKbVq"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-384c94c9414so348553a91.3
        for <linux-input@vger.kernel.org>; Mon, 13 Jul 2026 16:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783985311; x=1784590111; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MbmA7lPtg8lHve0ezKTNG03RsW6RcvxCYabLXJ2hr7U=;
        b=FHqlKbVq+t0yECzCAxWIuLv3XhObgGhbLkLH6v5x+QgA8NklRsZ8j8BY8J/PaGceGx
         V0obtKTtfdeR7gxwhuAftx1n4KURarSFt3oA3GXliYmtT7FFcD1AhkAEh/JoS/rEd65J
         5NCkALHCqqrZpYGR9RtkJxESLwGqgjMGruP15Gwu7f4Gmt2N4Ki1OpO3QvyPd6tw3vNA
         N/8g3gB2qCU+UrTeWw07+ebH3R7beXw9ijD5ux00bS+kOmPwHSRgB+9wH2GiY3Z5IAVO
         6PAWt3hpqzslab38mJv3/1E/VMQgplFEzDPz0kE7TReRRbRVU7jaq4fOMeZvChRHWR/v
         kyOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783985311; x=1784590111;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MbmA7lPtg8lHve0ezKTNG03RsW6RcvxCYabLXJ2hr7U=;
        b=SMZrxUEaQFiL4lB1RbNa3+PGDejtb7rTQiYnQJU3pjG/1kEwIDDwOO1vAKvfz4pkiX
         sOrkxde4WYpDjwgaDFQhtD2wjCq5ywW+HKrBh157+77SUPeQNwNNSy4G7r1OCQWCvojj
         ZRWFFqq+J+SwM9F1a6UHQDUXW0ztCVDu+z4eRi/5DXFNhKpPDls6LJ6L3uyMApfTuqOv
         NPU+OLGOLfHyL4UaY8ATLwNGWQ4Eh7Ml+qCxcia3FETV/qXJTZV6pOqAXQwzlwL9OBT9
         fDxLOLa9tnDOgBJDVKKW9qFnE3mrzgO+Ys/7z26QZ1Vg1v7d8bw8W4A4kXzjOUC5ME+F
         ujLw==
X-Forwarded-Encrypted: i=1; AHgh+RoJX0w8/JRogM63Lcd08fSTjTOzy/Sp2J/DIuYN13eXiL7eFIuwzyiw21OKpnZXeKTCPg7DBlSlHkwjlQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+QsLr2XiBc/CQBNZ2ep0BDVytU9twrwZHiVdL4aWtMmOI2Ehm
	x5Dc0XDYoQV7Owgmt4pLwlyrCAV4eHwzYChBrsa2a1hwp4Mo5/QrZ5EO
X-Gm-Gg: AfdE7clm+LeD7Hb136V1zb1rjsgDtfOyxEvRiQDY88JJOAhvcWHaQ0fXtaAtyN1Xk9q
	LaW62+L4GSNPSeY8yfXH+NGp9ijBnd1Wgptr30+ZxwwX5cK9EGWqkoO/FikDNwVLA6cgx1NFWFO
	WYiXzuqqFUPWVXDvD+E/fX+lt6aF4N0HyEpBuaZK9jHJMRtWa0q8C/X6rWIsokMC6YQlqLa2pjD
	yMne3XjDIOKORDgFeeR9WiBtu4WfHipHafpxigSdl8ySEZc1fIX1ZNW7F6v9/8DhtAN2qf4rV8w
	z1EkRAZSxsidOBbXaRgytQqOSAGX5H2isEadnU/gOENopyuyNP+l6Q90hxLocikqSQi9KVK9D94
	95WvwhmSO4Iu+A2pDz/gbUwbxygdacHPlRrWef4hGKMCa84jC0+aClNEULKrjXVORdWgn4fsDO6
	Vg7rg5tq+loIGlQ6HnTIrN40/PZ7PGrUuXZ1CHqb66P9f8gLSG1GW/DQ==
X-Received: by 2002:a05:6a20:244d:b0:3c0:b766:750c with SMTP id adf61e73a8af0-3c110b751b0mr11657167637.58.1783985310413;
        Mon, 13 Jul 2026 16:28:30 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:e15f:5d5f:580b:f2e9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b987fc629sm28553811c88.0.2026.07.13.16.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 16:28:29 -0700 (PDT)
Date: Mon, 13 Jul 2026 16:28:26 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Peter Griffin <peter.griffin@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Russell King <linux@armlinux.org.uk>, Mark Brown <broonie@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, 
	Sam Protsenko <semen.protsenko@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, patches@opensource.cirrus.com, 
	Conor Dooley <conor.dooley@microchip.com>, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v3 00/10] Remove support for platform data from samsung
 keypad
Message-ID: <alVyvlknt7HaRgs4@google.com>
References: <20260711-samsung-kp-v3-0-b2fcaba77aff@gmail.com>
 <20260712-musical-shrimp-of-fruition-b921df@quoll>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260712-musical-shrimp-of-fruition-b921df@quoll>

On Sun, Jul 12, 2026 at 02:30:50PM +0200, Krzysztof Kozlowski wrote:
> On Sat, Jul 11, 2026 at 07:12:41PM -0700, Dmitry Torokhov wrote:
> > Hi,
> > 
> > This series converts the Samsung keypad driver and the Cragganmore 6410
> > board to generic device properties, allowing the removal of legacy platform
> > data and GPIO lookup tables.
> > 
> > We rework the Samsung keypad driver to stop using platform data, utilizing
> > a new compact matrix keypad binding. To support this on the Cragganmore
> > board, we add infrastructure to associate software nodes with Samsung
> > gpio_chips, and add software node propagation support to the wm831x MFD
> > core to route DVS GPIO to the PMIC regulator.
> > 
> > Finally, we convert all peripherals on the Cragganmore board (including
> > keypad, GPIO keys, PMIC, WM1250, SPI0, basic-mmio-gpio, and LEDs) to
> > software properties. This allows us to eliminate all legacy GPIO lookup
> > tables and fixes incorrect GPIO chip names from previous conversions.
> > 
> > Mark, it would be great if you could give this a spin on Cragganmore.
> > 
> > The majority of changes are in arch/board code, with a couple of input
> > matches and one for MFD. If everyone agrees maybe we can merge it all
> > through the soc tree?
> 
> Yes, I could take it via samsung-soc. I assume I have your acks for
> unput parts.

Yes, of course.

Regarding Sashiko review:

- IRQ concerns are pre-existing and will be addressed in a separate
  series

- TOCTOU with device tree overlay changing DT properties in the middle
  of the probe I will not attempt to address. If this is a real concern
  it should be addressed globally 

- Introduction of 5ms default debounce on proximity and suspend seem
  harmless

- Copying of MFD cells is necessary because we need to "mix in" software
  nodes from platform data. I originally tried to handle this is the
  regulator, but the result was worse as it needed to add software node
  to the device after it was created. Doing it in the core is much
  cleaner overall.

Thanks.

-- 
Dmitry
