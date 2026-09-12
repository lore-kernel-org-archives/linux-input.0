Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEC6373BE6
	for <linux-input@vger.kernel.org>; Sat, 12 Sep 2026 06:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789195366; cv=pass; b=KTJzTzMlZuYg59fZN3wi8SJu21IHAiXGk2ZihksiFYU0713A7Thx/fP6ZP4DlBDhWP00hspFXnKi1ZS9oLlaMImK8Avjw10+qJndyoub2gXraZLBW0fnGpGAyuyzx1hzeaiCnrmlWGZNzNpuBcz0Z71/52gd4kbfutaoFDJDGdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789195366; c=relaxed/simple;
	bh=tJjQDgXYqlnPmpKINoz2d/oWMTDr4BO/qDJAgzNKoVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E0XoBOZmVWT36dzjQemDvEf1SaAlHDuaAdFAK7JX6RS8O9eCyU2uvFw5i8iMRgrzOsVwlb5ee2CS1DxQsFnXWrzXx9MYcnUb+AyvdIFAqo91ubcAdIXBxCY1npPxzNYFmx/XV/6SZ5453l7uoKJHHIcORjWlYcJpzX3E8oQIPxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqw2uZiR; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqw2uZiR"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2dd1dcdcf95so13561535ad.1
        for <linux-input@vger.kernel.org>; Fri, 11 Sep 2026 23:42:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789195361; cv=none;
        d=google.com; s=arc-20260327;
        b=MBkjzpu1iCOJTbZgPQmJoIZSur2zEKautvMddZgkAnP1sDzkIHRxH+JXyS4zliY83h
         ZW/YED6Of6lHQF36QN2dPMj8gyCiqxGd5BmggcA9V1JGuJFfstQsqSwxveEoeq+xjvj7
         KoN80SAXT4oTgd6EL+L+Eq7HOUb27wWx+vCOL9IwPRo0JRywKYRE8YWgWMV/jdm6n/+M
         mLP+tQsLa4GbzrZkv4JzPjii4qmqGtUNkCRbLv5S66U0mcOkU2SWXtAaLSSdyaP5pAfe
         CFXiQiI0f9h9o3X6jHORBOpji+nff0GUL9QKS2SkCozuLGUk5j6+0HSAje6CQPW8/I45
         eIrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cIueFh+gkuoIg/zyR6m8UHNu9YPuEhQan6MTb8FOTWM=;
        fh=UwAar4Odtn0t43R+pANGdQHfhtQANnw/w2N3QL/KQTs=;
        b=Ce8a9fyVa868H6vJ7e4ATylE9c1pe3M1IZ/D/SR2TlJlmptLyAIVDo1HheMVuhVkJM
         op3U0RjKZxdFTNWsEF4aIiuc7tqkzolWrSVvs8sxus6CHNC1vO3sVekvPlinxRj9u5rj
         q+BMmIXF0R0lhf3Q9Z/0uFJIYMoiouAwWjDf+wZgi/ysODxBG6yOYxNI2ratVDCOQgki
         Xdeur7EzvyT9XqM4EaUrZi3XrAf7Z6R4B3okQtxXeAn/pgjXXFtOWYk/6xtYmQeFCdzZ
         MsPwwyQ8L+N8Ovo8rEEtGqw+AyB6RdCgicfvtvCbOc5cuqcTBOtts9gOA1bTdvdF5Ga+
         /+Kw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789195361; x=1789800161; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cIueFh+gkuoIg/zyR6m8UHNu9YPuEhQan6MTb8FOTWM=;
        b=nqw2uZiRYy9kU82/HHF9q541/rHCJ6TVpY8clukoqIDDG9bRVtESBncDRCnER89YOc
         CpJlynGEdw1aO5LnFsuRuk4gas/Ofx92Q+jF6MYllXmpCM5mLz+PzRM4Ubhe7OHkXsme
         H+IUZ7Md8hkcl7GiKojDWyr/EEub5WWZyj9/Xqj5zYNO8dyjkvRcSSMQ0h28Bv5rVfSr
         tIGHFX+Myu7BamKjJdQ8MKL3un8JM5apb8Xyrw6Lih6QCfxUMPO4gRzXKeSq/YgoXL2C
         A5eH90yPkrdNlGjFaVBo503zHm1UO0ISUiJWSQJ+Le2lKGNnpWyU/wVtMBf0bafJGDrw
         meLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789195361; x=1789800161;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cIueFh+gkuoIg/zyR6m8UHNu9YPuEhQan6MTb8FOTWM=;
        b=GnUGhCQJUUcp39evGx/WfVkTLnjp1L66/w54RRtCVtXXxGHV2r/Byf2jNISh9ng1Da
         dMrNUyb+ULi9SjuTj9vJ73k9fmFUWUmakIRvjpFx+Svz3LpC7Y+a1YL3tJ5fHcTc7B/E
         7boJTXfRzLQCuhaM4/mYHog2Q8jqQ1GeNOHXX1uVDNkQ8U1YqNEsMIvLq3J1lUbdHj4Y
         CldRZOpj6Xgg36G9WQ9+H7O7JI5TUi5De2RjmLp5aQFDWkUQwY19HA40AnypqSXxyTGB
         euBD1BCLmv1bXMyn2uJ4nwYeYfsglXfW3yVt8uoOpWR0ey9Ohc53BsEIWnKBM6TSo/Hp
         C5FQ==
X-Forwarded-Encrypted: i=1; AKwUvBy44xW4y6OM0ygDGJDxsKY1974cxGh+u+lGhorQ2R/XZwQSSWSonhvK6shiQ01fAhbhYDy20B01Ie+Ncw==@vger.kernel.org
X-Gm-Message-State: AFuF++ntTtsbU8ONVaZ49yBvEbYiyvYBSC/bTR4zPeug1Sbr4Cpzio1e
	FwjaUV1/w0B1dtO5azmK2h9+W30IF1hlxRQhr29AhvTFM+MLUcKMRpip9lr+eCs+iaptzW8Cmtm
	9pLWakGiqfdO+BsBYBbCEl4fYAMMlxAE=
X-Gm-Gg: AYBFou3u2muzMKiYzxQRKUqBq1Zz28F8Ho3iHfKT2uNmoMknbOp7afjOjae5WLGgny4
	uuISDcC2KlVUUexVF5poVkPJ9NPQ84IOLOjY5+f8lV9QWteSf7EeoKDJzC0OJZjAG4fqDJrhgzn
	CJOxRaoSDdOoZAkMNDhr2EwmDn+qp2+0cP3ghiRSF0n7dg4kH5FUH3FaJpRl4ucU9mlEtgoS7Jh
	YF9MJF/uo9GG9zb+u+WzgORatrk44MCIEtJgxQSMw+qUCRdt8Kys4vh6BQlCIJYGLyyDIeAfC1M
	AXHaW8a0PGssEPHeHKla02o05953gFPmRUJB4A8rrBk7pOXMCePu2oxaYgzSXLYZW27uilWmO/M
	PwKPmlYMdWTTH
X-Received: by 2002:a17:902:f092:b0:2dd:4438:4290 with SMTP id
 d9443c01a7336-2dd443843aamr24758605ad.3.1789195361107; Fri, 11 Sep 2026
 23:42:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPVz0n0ryOns2sCJE_jFana9MVzwEj1QZuPEa8FNhGbHXnMB+A@mail.gmail.com>
 <11652e5e-053e-45b0-98a0-0c1cb2aeedc4@app.fastmail.com>
In-Reply-To: <11652e5e-053e-45b0-98a0-0c1cb2aeedc4@app.fastmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sat, 12 Sep 2026 09:42:29 +0300
X-Gm-Features: AcwNN1UU9hydFOGImBeWBO5hjkcNCRQ2PnPzv9Tt-xAUH4b_sUlrCRdkTJ4wt_0
Message-ID: <CAPVz0n0pBxP2J=5DN+k+ut0HRnTmsU64orXwxa19G0+WAxN-zg@mail.gmail.com>
Subject: Re: [PATCH 08/14] mfd: remove unused aat2870 driver
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, Mark Brown <broonie@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Daniel Thompson <danielt@kernel.org>, Helge Deller <deller@gmx.de>, devicetree@vger.kernel.org, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, dri-devel@lists.freedesktop.org, 
	Jonathan Cameron <jic23@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Linus Walleij <linusw@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-hwmon@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-rtc@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, 
	linuxppc-dev@lists.ozlabs.org, llvm@lists.linux.dev, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, mfd@lists.linux.dev, 
	Michael Hennerich <michael.hennerich@analog.com>, patches@opensource.cirrus.com, 
	Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
	Support Opensource <support.opensource@diasemi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 10 =D0=B2=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 21:15 Arnd=
 Bergmann <arnd@arndb.de> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Thu, Sep 10, 2026, at 18:40, Svyatoslav Ryhel wrote:
> > __
> > Hello Arnd! May you please spare AAT2870 from being removed? I have a
> > device which uses aat2870 (LG Optimus 2X P990 Tegra 2, not upstreamed
> > yet, but in process as well) and atm I am working on converting this
> > driver to use OF. Thank you!
>
> Sure, I have removed this patch from my series now.
>

Thank you!

> > P. S. If you are planning to remove more old drivers, please CC me in
> > since I may be interested in some additional driver upgrades for
> > devices I own.
>
> Please have a look at
>
> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git/log/?h=3Dboar=
d-remove-7.3
>

Thanks, I will keep my eye on this branch.

> I tried to be careful about figuring out exactly which drivers are
> unused, but I'm sure there are still a few false positive and false
> negative ones in there. I've added the current list of driver files below=
,
> let me know if you see something that shouldn't be there.
>
>      Arnd
>
> drivers/ata/pata_icside.c
> drivers/ata/pata_pxa.c
> drivers/char/ds1620.c
> drivers/char/hw_random/mxc-rnga.c
> drivers/char/nwbutton.c
> drivers/char/nwbutton.h
> drivers/char/nwflash.c
> drivers/clk/clk-axm5516.c
> drivers/clk/clk-stm32f4.c
> drivers/clk/clk-stm32h7.c
> drivers/clk/imx/clk-imx31.c
> drivers/clk/imx/clk-imxrt1050.c
> drivers/clk/nxp/clk-lpc18xx-ccu.c
> drivers/clk/nxp/clk-lpc18xx-cgu.c
> drivers/clk/nxp/clk-lpc18xx-creg.c
> drivers/clk/ti/clk-2xxx.c
> drivers/clocksource/armv7m_systick.c
> drivers/clocksource/mps2-timer.c
> drivers/cpufreq/sa1110-cpufreq.c
> drivers/dma/lpc18xx-dmamux.c
> drivers/dma/sa11x0-dma.c
> drivers/gpio/gpio-adp5520.c
> drivers/gpio/gpio-htc-egpio.c
> drivers/gpio/gpio-lpc18xx.c
> drivers/gpio/gpio-rc5t583.c
> drivers/gpio/gpio-rdc321x.c
> drivers/gpio/gpio-reg.c
> drivers/gpio/gpio-sa1100.c
> drivers/gpio/gpio-wm8350.c
> drivers/hwmon/ds620.c
> drivers/hwmon/f75375s.c
> drivers/hwmon/max1111.c
> drivers/hwmon/max197.c
> drivers/hwmon/wm8350-hwmon.c
> drivers/i2c/busses/i2c-acorn.c
> drivers/i2c/busses/i2c-axxia.c
> drivers/i2c/busses/i2c-lpc2k.c
> drivers/i2c/busses/i2c-stm32f4.c
> drivers/iio/adc/ad7266.c
> drivers/iio/adc/ad7791.c
> drivers/iio/adc/ad7793.c
> drivers/iio/adc/ad7887.c
> drivers/iio/adc/lp8788_adc.c
> drivers/iio/adc/lpc18xx_adc.c
> drivers/iio/dac/lpc18xx_dac.c
> drivers/iio/frequency/ad9523.c
> drivers/input/joystick/as5011.c
> drivers/input/keyboard/adp5520-keys.c
> drivers/input/keyboard/ipaq-micro-keys.c
> drivers/input/keyboard/jornada720_kbd.c
> drivers/input/keyboard/lm8323.c
> drivers/input/keyboard/lm8333.c
> drivers/input/keyboard/locomokbd.c
> drivers/input/misc/88pm80x_onkey.c
> drivers/input/misc/ad714x-i2c.c
> drivers/input/misc/ad714x-spi.c
> drivers/input/misc/ad714x.c
> drivers/input/misc/ad714x.h
> drivers/input/misc/adxl34x-i2c.c
> drivers/input/misc/adxl34x-spi.c
> drivers/input/misc/adxl34x.c
> drivers/input/misc/adxl34x.h
> drivers/input/misc/bma150.c
> drivers/input/misc/cma3000_d0x.c
> drivers/input/misc/cma3000_d0x.h
> drivers/input/misc/cma3000_d0x_i2c.c
> drivers/input/misc/kxtj9.c
> drivers/input/misc/max8997_haptic.c
> drivers/input/misc/mc13783-pwrbutton.c
> drivers/input/mouse/rpcmouse.c
> drivers/input/serio/rpckbd.c
> drivers/input/serio/sa1111ps2.c
> drivers/input/touchscreen/ad7877.c
> drivers/input/touchscreen/da9034-ts.c
> drivers/input/touchscreen/ipaq-micro-ts.c
> drivers/input/touchscreen/jornada720_ts.c
> drivers/input/touchscreen/mc13783_ts.c
> drivers/input/touchscreen/tps6507x-ts.c
> drivers/irqchip/irq-nvic.c
> drivers/irqchip/irq-sa11x0.c
> drivers/irqchip/irq-stm32-exti.c
> drivers/leds/leds-adp5520.c
> drivers/leds/leds-bd2802.c
> drivers/leds/leds-da903x.c
> drivers/leds/leds-ipaq-micro.c
> drivers/leds/leds-lm3530.c
> drivers/leds/leds-lm3532.c

LM3532 has full OF support and is functional, it just does not have
device tree users yet. I have a device using it - Motorola Atrix 4G
(Tegra 2 based).

Here is commit removing LM3532
https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git/commit/?id=3D46=
a6457870825d8b782d350fdc7e27c540734d41
Here are my patches bringing up Motorola Atrix 4G support
https://lore.kernel.org/lkml/20260721100245.444623-3-clamor95@gmail.com/

> drivers/leds/leds-lm355x.c
> drivers/leds/leds-lm3642.c
> drivers/leds/leds-locomo.c
> drivers/leds/leds-lp3944.c
> drivers/leds/leds-lp8788.c
> drivers/leds/leds-wm8350.c
> drivers/media/i2c/ths7303.c
> drivers/media/platform/samsung/s3c-camif/Kconfig
> drivers/media/platform/samsung/s3c-camif/Makefile
> drivers/media/platform/samsung/s3c-camif/camif-capture.c
> drivers/media/platform/samsung/s3c-camif/camif-core.c
> drivers/media/platform/samsung/s3c-camif/camif-core.h
> drivers/media/platform/samsung/s3c-camif/camif-regs.c
> drivers/media/platform/samsung/s3c-camif/camif-regs.h
> drivers/media/platform/st/stm32/dma2d/dma2d-hw.c
> drivers/media/platform/st/stm32/dma2d/dma2d-regs.h
> drivers/media/platform/st/stm32/dma2d/dma2d.c
> drivers/media/platform/st/stm32/dma2d/dma2d.h
> drivers/media/radio/radio-si476x.c
> drivers/mfd/88pm800.c
> drivers/mfd/88pm805.c
> drivers/mfd/88pm80x.c
> drivers/mfd/adp5520.c
> drivers/mfd/da903x.c
> drivers/mfd/ipaq-micro.c
> drivers/mfd/lp8788-irq.c
> drivers/mfd/lp8788.c
> drivers/mfd/mcp-core.c
> drivers/mfd/mcp-sa11x0.c
> drivers/mfd/menelaus.c
> drivers/mfd/rc5t583-irq.c
> drivers/mfd/rc5t583.c
> drivers/mfd/rdc321x-southbridge.c
> drivers/mfd/si476x-cmd.c
> drivers/mfd/si476x-i2c.c
> drivers/mfd/si476x-prop.c
> drivers/mfd/ucb1x00-assabet.c
> drivers/mfd/ucb1x00-core.c
> drivers/mfd/ucb1x00-ts.c
> drivers/mfd/wm8350-core.c
> drivers/mfd/wm8350-gpio.c
> drivers/mfd/wm8350-i2c.c
> drivers/mfd/wm8350-irq.c
> drivers/mfd/wm8350-regmap.c
> drivers/mfd/wm8400-core.c
> drivers/misc/bh1770glc.c
> drivers/mtd/maps/dc21285.c
> drivers/mtd/maps/pxa2xx-flash.c
> drivers/mtd/maps/sa1100-flash.c
> drivers/mtd/nand/raw/sharpsl.c
> drivers/mtd/parsers/sharpslpart.c
> drivers/mtd/spi-nor/controllers/Kconfig
> drivers/mtd/spi-nor/controllers/Makefile
> drivers/mtd/spi-nor/controllers/hisi-sfc.c
> drivers/mtd/spi-nor/controllers/nxp-spifi.c
> drivers/net/can/bxcan.c
> drivers/net/ethernet/8390/etherh.c
> drivers/net/ethernet/i825xx/ether1.c
> drivers/net/ethernet/i825xx/ether1.h
> drivers/net/ethernet/lantiq_etop.c
> drivers/net/ethernet/samsung/Kconfig
> drivers/net/ethernet/samsung/Makefile
> drivers/net/ethernet/samsung/sxgbe/Makefile
> drivers/net/ethernet/samsung/sxgbe/sxgbe_common.h
> drivers/net/ethernet/samsung/sxgbe/sxgbe_core.c
> drivers/net/ethernet/samsung/sxgbe/sxgbe_desc.c
> drivers/net/ethernet/samsung/sxgbe/sxgbe_desc.h
> drivers/net/ethernet/samsung/sxgbe/sxgbe_dma.c
> drivers/net/ethernet/samsung/sxgbe/sxgbe_dma.h
> drivers/net/ethernet/samsung/sxgbe/sxgbe_ethtool.c
> drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
> drivers/net/ethernet/samsung/sxgbe/sxgbe_mdio.c
> drivers/net/ethernet/samsung/sxgbe/sxgbe_mtl.c
> drivers/net/ethernet/samsung/sxgbe/sxgbe_mtl.h
> drivers/net/ethernet/samsung/sxgbe/sxgbe_platform.c
> drivers/net/ethernet/samsung/sxgbe/sxgbe_reg.h
> drivers/net/ethernet/seeq/ether3.c
> drivers/net/ethernet/seeq/ether3.h
> drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c
> drivers/net/wireless/marvell/libertas/if_spi.c
> drivers/net/wireless/marvell/libertas/if_spi.h
> drivers/net/wireless/st/Kconfig
> drivers/net/wireless/st/Makefile
> drivers/net/wireless/st/cw1200/Kconfig
> drivers/net/wireless/st/cw1200/Makefile
> drivers/net/wireless/st/cw1200/bh.c
> drivers/net/wireless/st/cw1200/bh.h
> drivers/net/wireless/st/cw1200/cw1200.h
> drivers/net/wireless/st/cw1200/cw1200_sdio.c
> drivers/net/wireless/st/cw1200/cw1200_spi.c
> drivers/net/wireless/st/cw1200/debug.c
> drivers/net/wireless/st/cw1200/debug.h
> drivers/net/wireless/st/cw1200/fwio.c
> drivers/net/wireless/st/cw1200/fwio.h
> drivers/net/wireless/st/cw1200/hwbus.h
> drivers/net/wireless/st/cw1200/hwio.c
> drivers/net/wireless/st/cw1200/hwio.h
> drivers/net/wireless/st/cw1200/main.c
> drivers/net/wireless/st/cw1200/pm.c
> drivers/net/wireless/st/cw1200/pm.h
> drivers/net/wireless/st/cw1200/queue.c
> drivers/net/wireless/st/cw1200/queue.h
> drivers/net/wireless/st/cw1200/scan.c
> drivers/net/wireless/st/cw1200/scan.h
> drivers/net/wireless/st/cw1200/sta.c
> drivers/net/wireless/st/cw1200/sta.h
> drivers/net/wireless/st/cw1200/txrx.c
> drivers/net/wireless/st/cw1200/txrx.h
> drivers/net/wireless/st/cw1200/wsm.c
> drivers/net/wireless/st/cw1200/wsm.h
> drivers/nvmem/lpc18xx_eeprom.c
> drivers/nvmem/lpc18xx_otp.c
> drivers/pcmcia/max1600.c
> drivers/pcmcia/max1600.h
> drivers/pcmcia/pxa2xx_base.c
> drivers/pcmcia/pxa2xx_base.h
> drivers/pcmcia/pxa2xx_sharpsl.c
> drivers/pcmcia/sa1100_generic.c
> drivers/pcmcia/sa1100_generic.h
> drivers/pcmcia/sa1100_h3600.c
> drivers/pcmcia/sa1111_generic.c
> drivers/pcmcia/sa1111_generic.h
> drivers/pcmcia/sa1111_jornada720.c
> drivers/pcmcia/sa1111_neponset.c
> drivers/pcmcia/sa11xx_base.c
> drivers/pcmcia/sa11xx_base.h
> drivers/pcmcia/soc_common.c
> drivers/pcmcia/soc_common.h
> drivers/phy/phy-lpc18xx-usb-otg.c
> drivers/pinctrl/freescale/pinctrl-imxrt1050.c
> drivers/pinctrl/freescale/pinctrl-imxrt1170.c
> drivers/pinctrl/pinctrl-lpc18xx.c
> drivers/pinctrl/stm32/pinctrl-stm32f429.c
> drivers/pinctrl/stm32/pinctrl-stm32f469.c
> drivers/pinctrl/stm32/pinctrl-stm32f746.c
> drivers/pinctrl/stm32/pinctrl-stm32f769.c
> drivers/pinctrl/stm32/pinctrl-stm32h743.c
> drivers/power/reset/axxia-reset.c
> drivers/power/supply/collie_battery.c
> drivers/power/supply/da9030_battery.c
> drivers/power/supply/ipaq_micro_battery.c
> drivers/power/supply/lp8788-charger.c
> drivers/power/supply/twl4030_madc_battery.c
> drivers/power/supply/wm8350_power.c
> drivers/pwm/pwm-lpc18xx-sct.c
> drivers/regulator/88pm800-regulator.c
> drivers/regulator/da903x-regulator.c
> drivers/regulator/lp3971.c
> drivers/regulator/lp3972.c
> drivers/regulator/lp8788-buck.c
> drivers/regulator/lp8788-ldo.c
> drivers/regulator/max8649.c
> drivers/regulator/rc5t583-regulator.c
> drivers/regulator/wm8350-regulator.c
> drivers/regulator/wm8400-regulator.c
> drivers/reset/reset-lpc18xx.c
> drivers/rtc/rtc-88pm80x.c
> drivers/rtc/rtc-lp8788.c
> drivers/rtc/rtc-lpc24xx.c
> drivers/rtc/rtc-rc5t583.c
> drivers/rtc/rtc-wm8350.c
> drivers/scsi/arm/Kconfig
> drivers/scsi/arm/Makefile
> drivers/scsi/arm/acornscsi-io.S
> drivers/scsi/arm/acornscsi.c
> drivers/scsi/arm/acornscsi.h
> drivers/scsi/arm/arm_scsi.h
> drivers/scsi/arm/arxescsi.c
> drivers/scsi/arm/cumana_1.c
> drivers/scsi/arm/cumana_2.c
> drivers/scsi/arm/eesox.c
> drivers/scsi/arm/fas216.c
> drivers/scsi/arm/fas216.h
> drivers/scsi/arm/msgqueue.c
> drivers/scsi/arm/msgqueue.h
> drivers/scsi/arm/oak.c
> drivers/scsi/arm/powertec.c
> drivers/scsi/arm/queue.c
> drivers/scsi/arm/queue.h
> drivers/spi/spi-tle62x0.c
> drivers/tty/serial/21285.c
> drivers/tty/serial/8250/8250_acorn.c
> drivers/tty/serial/8250/8250_lpc18xx.c
> drivers/tty/serial/mps2-uart.c
> drivers/tty/serial/sa1100.c
> drivers/usb/host/ohci-sa1111.c
> drivers/usb/host/sl811-hcd.c
> drivers/usb/host/sl811.h
> drivers/usb/host/sl811_cs.c
> drivers/usb/musb/tusb6010.c
> drivers/usb/musb/tusb6010.h
> drivers/usb/musb/tusb6010_omap.c
> drivers/usb/phy/phy-mv-usb.h
> drivers/video/backlight/adp5520_bl.c
> drivers/video/backlight/adp8860_bl.c
> drivers/video/backlight/adp8870_bl.c
> drivers/video/backlight/ams369fg06.c
> drivers/video/backlight/bd6107.c
> drivers/video/backlight/corgi_lcd.c
> drivers/video/backlight/da903x_bl.c
> drivers/video/backlight/ep93xx_bl.c
> drivers/video/backlight/ipaq_micro_bl.c
> drivers/video/backlight/jornada720_bl.c
> drivers/video/backlight/jornada720_lcd.c
> drivers/video/backlight/lm3639_bl.c
> drivers/video/backlight/lms501kf03.c
> drivers/video/backlight/locomolcd.c
> drivers/video/backlight/lp8788_bl.c
> drivers/video/backlight/tdo24m.c
> drivers/video/fbdev/acornfb.c
> drivers/video/fbdev/acornfb.h
> drivers/video/fbdev/arcfb.c
> drivers/video/fbdev/broadsheetfb.c
> drivers/video/fbdev/core/fb_notify.c
> drivers/video/fbdev/ep93xx-fb.c
> drivers/video/fbdev/hecubafb.c
> drivers/video/fbdev/metronomefb.c
> drivers/video/fbdev/mmp/Kconfig
> drivers/video/fbdev/mmp/Makefile
> drivers/video/fbdev/mmp/core.c
> drivers/video/fbdev/mmp/fb/Kconfig
> drivers/video/fbdev/mmp/fb/Makefile
> drivers/video/fbdev/mmp/fb/mmpfb.c
> drivers/video/fbdev/mmp/fb/mmpfb.h
> drivers/video/fbdev/mmp/hw/Kconfig
> drivers/video/fbdev/mmp/hw/Makefile
> drivers/video/fbdev/mmp/hw/mmp_ctrl.c
> drivers/video/fbdev/mmp/hw/mmp_ctrl.h
> drivers/video/fbdev/mmp/hw/mmp_spi.c
> drivers/video/fbdev/mmp/panel/Kconfig
> drivers/video/fbdev/mmp/panel/Makefile
> drivers/video/fbdev/mmp/panel/tpo_tj032md01bw.c
> drivers/video/fbdev/n411.c
> drivers/video/fbdev/pxa168fb.c
> drivers/video/fbdev/pxa168fb.h
> drivers/video/fbdev/s1d13xxxfb.c
> drivers/video/fbdev/sa1100fb.c
> drivers/video/fbdev/sa1100fb.h
> drivers/watchdog/lpc18xx_wdt.c
> drivers/watchdog/rdc321x_wdt.c
> drivers/watchdog/wdt285.c
> drivers/watchdog/wdt977.c
> drivers/watchdog/wm8350_wdt.c
> sound/soc/codecs/si476x.c
> sound/soc/codecs/wm8350.c
> sound/soc/codecs/wm8350.h
> sound/soc/codecs/wm8400.c
> sound/soc/codecs/wm8400.h
> sound/soc/pxa/pxa2xx-i2s.c
> sound/soc/pxa/pxa2xx-i2s.h
> sound/soc/pxa/spitz.c
> sound/soc/ti/n810.c
> sound/spi/Kconfig
> sound/spi/Makefile
> sound/spi/at73c213.c
> sound/spi/at73c213.h

Other drivers from this list seem to not be used in any of my devices.

Best regards,
Svyatoslav R.
