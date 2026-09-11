Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE33232395;
	Fri, 11 Sep 2026 07:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789111503; cv=none; b=KV+IGgXFsQMPevUP4+7mQA1lf2cSBZ5NB/nrjEIWH0WR3ClTj0p2HYI+ue88G4kEXizvdlyYY8Lbs/d/SQUFjrRzle3HrOsTwSp4u+i17cFnhVzpGKv05jRSJNnKJ5bBkofntu5AX2BU5cgyaa1p+/QKGQv0BBtVMaGGY+RzRzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789111503; c=relaxed/simple;
	bh=GWroBVEzFoQk4S/34nBzYkm+qHO729shFJDiDKYbJl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C71P2j8HTpbUfn8LdhLyUlC/xlvcCLwHmTebJq1U4PeGaxsI87u5dtEnm9WN1cN6WHW9kIg25Hyi8HBAFSnnbenQS4tfDO1CwRlveaGsKA0y0V5bQ1zHsJaboIo7Zoea5dRNRPoAGc35+3llqIqZPPWXNviGdotwKImcca9Oz7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ANl9844t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ANl9844t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D7E1F000FF;
	Fri, 11 Sep 2026 07:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789111501;
	bh=BH+kR55l7q2T4yQ9SIaFXw37h9ozVxD3HhYmGKf8G4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ANl9844tOuE5AoQGY+DjaIFqCkPogFuzPNdfQWqulQ1ewcXnDBgt4NdOoaAxooGZH
	 otw3WqXN/dfJ1pNs0X0yevkODFTPh3pxA9BwxVVkBA1iktQgUJQewif5xVbMODOWQG
	 p/mWIch3ra5WH3jLHFaw3cWT0YrPLRjUedj8sYvbwLEFVFwspXynmHIaliKaD8MzHM
	 Xaf5Qs18Xas8eGIznU7yaUWvc+9ptKBerpjAHFGKEw0DHIqd0hSZcM1yyqzMhkH095
	 IUQbqVg1ph51dt/CUhqYAMrmXLp66EUw6RS72Jj/2UD9lzJLKJvRcTkZjvnML1Ja+L
	 dkfqQ0ihw0QKA==
Date: Fri, 11 Sep 2026 09:24:57 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Lee Jones <lee@kernel.org>, mfd@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Arnd Bergmann <arnd@arndb.de>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Guenter Roeck <linux@roeck-us.net>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@kernel.org>, 
	Michael Hennerich <michael.hennerich@analog.com>, Support Opensource <support.opensource@diasemi.com>, 
	Sebastian Reichel <sre@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
	linux-media@vger.kernel.org, devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	patches@opensource.cirrus.com, linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, llvm@lists.linux.dev
Subject: Re: [PATCH 01/14] mfd: remove unused 88pm80x driver
Message-ID: <20260911-righteous-arboreal-angelfish-3bcbdf@quoll>
References: <20260909132153.1596191-1-arnd@kernel.org>
 <20260909132153.1596191-2-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260909132153.1596191-2-arnd@kernel.org>

On Wed, Sep 09, 2026 at 03:21:38PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This pair of drivers was originally added as companion chips for pxa/mmp
> SoCs, but the corresponding platform code was never merged, so it has
> been unused the entire time.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  .../devicetree/bindings/regulator/88pm800.txt |  38 --

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

