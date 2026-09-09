Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79EA56B865;
	Wed,  9 Sep 2026 13:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788961505; cv=none; b=krIu8sTamChw6KWI3Tps5QAyIUBF8jDskyfDfrUG7RNTwfy4ZFRikTxsh8JjoNtp5OPSFncewZbCahCmNkUPQ9PHh3u0tW0sa+38r6v3A3VDcr0IX3ej0PUJiqVeJLCNa/iE5XXxq1vwYgfQUOmFLdrrvirte14JdXMg6jkmQBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788961505; c=relaxed/simple;
	bh=y3IPVZTXECKU3Ru2MnRhAyWP4E2YqVnEqyRE5lwGlAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umYVvmkjKqdZS28TZvht9HwpbbS/SXG4mmhQkx2+VcbjG+IzHJ37itj+/kjyUgxSR/7JtW7YdHrAnPy8zlVDHXyLSIoBT/DEywHbjlfVIUoDho2o+aAqTF9BE9/93C+7p0CFILbcrDBYD1SwD+nX4KDvaNU+lvA2mhIQ3cYy6aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=qFOrBYn+; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="qFOrBYn+"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 315BE1A1A70;
	Wed,  9 Sep 2026 13:45:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E847760448;
	Wed,  9 Sep 2026 13:45:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6CCDC11C7AF3A;
	Wed,  9 Sep 2026 15:44:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788961494; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=SddRT3djP09Ed0ShkS8xpytcBnp+LMCenJGnP73m0/E=;
	b=qFOrBYn+NlO3vUgsMN69fPT6LsFBYJ9WZx3ZN0bi+TXRklU5lr5/kdcqj8w+UMRPRv0j5t
	1K3rOH7Bm7qvQu3jiyoKp6uHYGM8c6x1rhNO8aOD1Lqa6rFd6ssvwG5tRwPsppSGAGtRgd
	5b7gVfCUPfVEFQMfGBUsdERF2y+Dm2OOXl5ZKnXmxvHCRKffwFRioHPfWG2OwRUDNrwXtE
	ercet4pqf4lgc/m27S+AgsBlIdNPFQsq5ss03yxvE6jIxeHl0BvkjKMfvAs9dRYxJa2i7A
	gY/Zw554xS/+HkDK8qpgmxzcL+SfGlFij2ztErujl+hxzRnuQbt80smJlDX5gQ==
Date: Wed, 9 Sep 2026 15:44:43 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Lee Jones <lee@kernel.org>, mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Arnd Bergmann <arnd@arndb.de>, Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Support Opensource <support.opensource@diasemi.com>,
	Sebastian Reichel <sre@kernel.org>, Helge Deller <deller@gmx.de>,
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
	linux-media@vger.kernel.org, devicetree@vger.kernel.org,
	linux-hwmon@vger.kernel.org, patches@opensource.cirrus.com,
	linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org, linux-fbdev@vger.kernel.org,
	linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH 01/14] mfd: remove unused 88pm80x driver
Message-ID: <20260909134443876d2166@mail.local>
References: <20260909132153.1596191-1-arnd@kernel.org>
 <20260909132153.1596191-2-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909132153.1596191-2-arnd@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

On 09/09/2026 15:21:38+0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This pair of drivers was originally added as companion chips for pxa/mmp
> SoCs, but the corresponding platform code was never merged, so it has
> been unused the entire time.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
