Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9FE358D00;
	Sun, 12 Jul 2026 12:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783859455; cv=none; b=orjeJa1bYqwxwDAXtYGGeWmueRtRWuLiHV3CzaAcDKRudGGKf9SUSzMtu9qIYpE5nMuh9psIDtdKxVtV1ccYyQOQnUfbObY01G6nt/3OY79hHft3/jqBOnja+FCPaXqn58aTcZtxiug/Uzn1xWVL+uE2eWVttUgV1hBd9/J9Tkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783859455; c=relaxed/simple;
	bh=pk87CeSrNpXX9jN0MdaORKmwE9wXpc2PDw5VJNW96Hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BACzP1FSMcB2mzKmjLzktfW26k9SEeAd/pnpe8Wgdtf/eLhuCvoVgxaOSo0oyQLIGBpz4g3kFK/IcswZacFVzcaCxHVbdJD2M8CI2Mr9TNCwrnJHwDRY7aSTiYDOy93TfUcMY/jEtNV0wifdNv3Le8NYut+KUEwBDnK0NhWKQew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H7qwpalI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7qwpalI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A9BD1F000E9;
	Sun, 12 Jul 2026 12:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783859454;
	bh=Gy9MJ063WpQuTdSQRRK8YP6m6riIIdrXysJgOkGPzeE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H7qwpalIOgjV9fonMoUa6xGWNGLUj7bPBCVer5pjNyKeehxUgyS8Y2rRLtsESuYBa
	 Nuc12plGqFOKkNVMjYB3VpTnqhVh0Qgj8d6tZ1e3RfAAwl8mUtrdk3aRRQhAQfOUK7
	 q2VZbud6iihamDK5/B0NKAwaNIKyfTkk2m1ZpvY8dQ4xFBbA64t4rJLG/jdaXHrxKL
	 4GACJqUuQtINVqxS/iY7OKwFLKeLAydfSwNB8zKhG1AxCFg972iCF2Ub16Y7A2yCu8
	 kuh6nYb3sQb6lcGwRiuOee9DWLXRPXhaQCdPwGqdhid/gr7RGPwkTYTnkCgQdjSjiF
	 I4UaP1WpTHekQ==
Date: Sun, 12 Jul 2026 14:30:50 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
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
Message-ID: <20260712-musical-shrimp-of-fruition-b921df@quoll>
References: <20260711-samsung-kp-v3-0-b2fcaba77aff@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260711-samsung-kp-v3-0-b2fcaba77aff@gmail.com>

On Sat, Jul 11, 2026 at 07:12:41PM -0700, Dmitry Torokhov wrote:
> Hi,
> 
> This series converts the Samsung keypad driver and the Cragganmore 6410
> board to generic device properties, allowing the removal of legacy platform
> data and GPIO lookup tables.
> 
> We rework the Samsung keypad driver to stop using platform data, utilizing
> a new compact matrix keypad binding. To support this on the Cragganmore
> board, we add infrastructure to associate software nodes with Samsung
> gpio_chips, and add software node propagation support to the wm831x MFD
> core to route DVS GPIO to the PMIC regulator.
> 
> Finally, we convert all peripherals on the Cragganmore board (including
> keypad, GPIO keys, PMIC, WM1250, SPI0, basic-mmio-gpio, and LEDs) to
> software properties. This allows us to eliminate all legacy GPIO lookup
> tables and fixes incorrect GPIO chip names from previous conversions.
> 
> Mark, it would be great if you could give this a spin on Cragganmore.
> 
> The majority of changes are in arch/board code, with a couple of input
> matches and one for MFD. If everyone agrees maybe we can merge it all
> through the soc tree?

Yes, I could take it via samsung-soc. I assume I have your acks for
unput parts.

Best regards,
Krzysztof

