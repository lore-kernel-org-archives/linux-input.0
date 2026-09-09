Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D636549387;
	Wed,  9 Sep 2026 13:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788961722; cv=none; b=oMLtJIv1DkR0PdjZZ0sYySVsu+CL2tNzsDL+Exrk8vTvtNp9zjxm2IEXjeCRMV2ymSkzkTre6UbXD37ykEuv7g3dVgMj+zvB97EJmyA9WFBt5YBy5XCAK11MRYU5Was1sa3+33C/ryVJdmPKf2+ZvFQAU5ByXjaP14jn+Y+KJCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788961722; c=relaxed/simple;
	bh=LU0pjNZDcDRNOQh5AIrDN0NS8sO34pg2lKemqSMk6oY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ji5NWm5p8dMHOqu6jt5YaGf6JdDcCP7ef8s2vO5sFKhSdiwKjAgjxT6hBS529VtiipsggbjMNa8u3R2+TFkz+eoVdWdVZucSvgKhj+KJBuz7iBsrC52BIZ5vHx/EZZryNojbRKaAoQi/GbI8x6RLtdtP5OD3Lrig5ruaCNNIOK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=e4hV0USw; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="e4hV0USw"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C0ECE4E41592;
	Wed,  9 Sep 2026 13:48:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 92C9460448;
	Wed,  9 Sep 2026 13:48:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 60FF411C7AF7E;
	Wed,  9 Sep 2026 15:48:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788961712; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=SjNDOXDeuB2hgWmjfXk2EUyO9cutSwBc1XNCZLTUAlQ=;
	b=e4hV0USw2592sArlmqCFVDTCozCtOc6LjMSbUDXNj5N8xWuQPilc8ETI4F3BiY8ykW8CSK
	V7FAYn/uQfEtyQZp5rzZwuRicmERsJRGQQv+4DILDAZXhYfMKwQzHcnKX7rpvzN8QR21Dd
	IJXcAHyZKNbstaLcijpTwXaDTSqj+PZCY0BtnIbX3ngZ+smMvutnMSpa7cW7FLgXbgiKt7
	Mxb4rVD5vU178/mSnWvSrGdrmvEsrxcRBrkwPvmCJfF/0+8IsfxbL+gaYLQqHljWPs9+RO
	tsTofIw6j+hBiz1+Esu6B9+hGjveoYmKfjL5g4jEgrwMNi3GO3FYOOk5CKsUag==
Date: Wed, 9 Sep 2026 15:48:24 +0200
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
Subject: Re: [PATCH 10/14] mfd: remove unused rc5t583 driver
Message-ID: <202609091348246a76051b@mail.local>
References: <20260909132153.1596191-1-arnd@kernel.org>
 <20260909132153.1596191-11-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909132153.1596191-11-arnd@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

On 09/09/2026 15:21:47+0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Ricoh RC5T583 support was added in 2012, but no upstream code ever
> defined the corresponding platform_data, and there is no devicetree
> support, so this is all dead code.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
