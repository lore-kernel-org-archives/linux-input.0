Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CD13E92B4
	for <linux-input@vger.kernel.org>; Thu,  9 Jul 2026 08:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783584636; cv=none; b=WFAGkp6hegwkXPk+YvHV4oc0j48CDjE+4DCQlD0nioHZ0BBQzDHrr9rbhQ9yISbJnVEm/wTn7nvpHB/vQ/ApKEUGdc+fEKAMGmC4mduDeZ6sVhRvidAQoZ7gq5SOdDxGSozpbZC3Mp4Jl5jDipERNDihZLtnoQ/sgNmUfvkKDXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783584636; c=relaxed/simple;
	bh=OEahzOA/KTRGTvkyoCk8o8fpVF85458RzotimJ/M6YA=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oroi2JV9R4Aus1OQRYqw7sPZQR7so//EkZ/x7QRy7r17W9TelliBbmEkHmiyNtNpw6gUVW/UDdfUk2to1PQcLs/7dQv+etEiT3yF9KMe0FvP+DAMut0+0TWYj8qXryD6nCGeWO3NKOutb323hRRd2RqfJDY/iHa7NrFcMwjQgMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTBH081n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTBH081n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C1791F00ADF
	for <linux-input@vger.kernel.org>; Thu,  9 Jul 2026 08:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783584633;
	bh=OEahzOA/KTRGTvkyoCk8o8fpVF85458RzotimJ/M6YA=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=WTBH081nAVdwug7LFzIXFDgrbegoCxoadFT6WO6Frj2908/6QzMGpqt+CfrEXJqRU
	 rcgGiDX4HCNTU8FqoW1govO01jdvhuzUXNNJ0tTwJ/a75ha6cknVn+4Ri9j8V9UT6j
	 FEDw2qbGgQMoPPJBJI33u2xbH/NNR/2Po70XNcNawxYMXR37COZ6bP05UqWxnXPglt
	 +/3qvpADr+xjrw+F8R/KNXi2aw9RGkyyEgsPKWJU1EspALz+kc34kr4mUtD5XemHJd
	 k7mj/FGZm/6JeoPOKEQouTiImik/jECjqVZ4/3PN4IM+ItDJKnXZfeOx0R9CmyjUkp
	 t8QVaWsR+PBRg==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5aeb2df5cc1so1404497e87.3
        for <linux-input@vger.kernel.org>; Thu, 09 Jul 2026 01:10:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrdHTE2HElrgoV0NovsujljLNC4pHuJO62Fs8eBxcpRxIab8cDpAMVQob2pqZuDwzSohX7w5dQqxFrmZw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzB1P3QGi1xJ3yafUj30Yat4z7TsM5NRk2MRaVbmP4X5xn9FHhG
	8wy9bKyvOXlaZzDq5uxaJw0j0DP1c/rO62TdOQwaNTaJQzlOzMUI7gcFrlgS0DRbP+gLdVjTANh
	QyHacavIaqcGhYNHqiJFOG8MnfdhJG1vnHndgSf5E7g==
X-Received: by 2002:ac2:57cb:0:b0:5ae:b75a:7176 with SMTP id
 2adb3069b0e04-5b0115b31cbmr957946e87.65.1783584632201; Thu, 09 Jul 2026
 01:10:32 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Jul 2026 01:10:30 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Jul 2026 01:10:30 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260708-samsung-kp-v2-0-3c6ed4c9b3b6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708-samsung-kp-v2-0-3c6ed4c9b3b6@gmail.com>
Date: Thu, 9 Jul 2026 01:10:30 -0700
X-Gmail-Original-Message-ID: <CAMRc=MfJQm8RqhiLbRA1x7skt=jW8vvTD-1VCDcw-dO_VjisZQ@mail.gmail.com>
X-Gm-Features: AVVi8CddxA9iUF7IgAB_SRFc1uKWkA3NnqyOXCt0i1LuR82tf86E-F3pS5f_rfg
Message-ID: <CAMRc=MfJQm8RqhiLbRA1x7skt=jW8vvTD-1VCDcw-dO_VjisZQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] Remove support for platform data from samsung keypad
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-input@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	patches@opensource.cirrus.com, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Peter Griffin <peter.griffin@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Russell King <linux@armlinux.org.uk>, Mark Brown <broonie@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, 
	Sam Protsenko <semen.protsenko@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 Jul 2026 06:52:58 +0200, Dmitry Torokhov
<dmitry.torokhov@gmail.com> said:
> Hi,
>
> This is a reworked and extended version of the series previously posted
> to convert the Samsung keypad driver and Cragganmore 6410 board to
> generic device properties. The first 8 patches of the original series
> (general cleanups) have been merged into mainline, and this version
> focuses on the remaining keypad rework and extends the board conversion.
>
> Specifically, we rework the Samsung keypad driver to stop using platform
> data and instead rely on generic device properties, and convert the
> Cragganmore board to use software nodes for all its peripherals, removing
> legacy GPIO lookup tables.
>
> We start by introducing a compact matrix keypad binding and implementing
> it in the driver. To support referencing Samsung GPIO chips in board
> properties, we add infrastructure to register and attach software nodes
> to Samsung gpio_chips. We then switch the Cragganmore keypad to use
> software properties and drop platform data support from the driver.
>
> To convert the PMIC DVS regulator on Cragganmore, we add software node
> support to the wm831x regulator driver, allowing DVS configuration via
> device properties. Once the board is converted, we clean up the driver
> by removing legacy DVS platform data fields.
>
> Finally, we convert the remaining peripherals on Cragganmore (GPIO keys,
> PMIC, WM1250, SPI0, basic-mmio-gpio, and LEDs) to software properties.
> This allows us to eliminate all legacy GPIO lookup tables, which also
> fixes incorrect GPIO chip names ("GPIO<N>" vs "GP<N>") from previous
> descriptor conversions.
>
> Mark, it would be great if you could give this a spin on Cragganmore.
>
> Thanks!
>

I admit I haven't looked at the series in great detail but it looks sane and
you've been doing these conversions before so I trust your judgment.

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Thanks,
Bartosz
