Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB47317B425
	for <linux-input@vger.kernel.org>; Sun, 12 Jul 2026 02:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783822380; cv=none; b=dM2wwBmVwl6aSocl91BlGNWlJbdmFde20Gr7D0FEYSSKtQakQnXJlAbGabPQtJjSwlMtElQ4isSpSF0HYyZIKgxe6EX4bqrWnsCE3FxZchSibhl9QyIAhktKHu53f5fkKgKZMItOd8usm62aS9tnh9U1iJftpjhC5hKu6SSwUTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783822380; c=relaxed/simple;
	bh=hvTXNaq5urOGZLsi2ZFCjd3V+3EespLnbI3oOLSonsM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WF7O3B120C3lK6RrUldsXLYuvb1N446QmQYfGd71sttaeDm8iVEyjj3POXvj6zVYajPRY0ewZ1rwgZOsryS5wbOsZdAU9hC1/YtjcFV2VLjbWbhSpK+TTHBqSYU++dzeWo2j7gPr5VUI2rp+Ql6+QUhPCiL/0jfKtmehm+kUOEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L+Jg5D3A; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+Jg5D3A"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cca0c5799eso20927515ad.0
        for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 19:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783822378; x=1784427178; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=akuiiPDroRfJeMxQ3ozyBHs44kZ19VHRGG2J2TIkiPU=;
        b=L+Jg5D3AYD7EaLi7Rom6AdJHoDoXb3foXSB554j3divtSX6oiCLDNMG0umvwMoLvbG
         v2Uy2EWRiq9/KJsZxs9KlGBiwR9c9Dy1lSme+Pkk3YesO4GwjynUvqP9L7oa1VixJGAl
         cq4PLiBmQslaoPFfg5HjWKUxvuNGMFTBVFqM14DbIlCWC6t7ivhz7V2wToVmIAapZoP+
         YyEaGmsKxvXnhMYg7gqSKBsTOJQxv4HpTkf6VMDzWqktNBUaqHeg2a4Cqg+tJ4ed+xb+
         W6T6ifMhF9KV25LJYGait46YfXRwaZnEtdap5S7DvMU48I1beCWbuLrtA7sXN6v29OAA
         I30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783822378; x=1784427178;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=akuiiPDroRfJeMxQ3ozyBHs44kZ19VHRGG2J2TIkiPU=;
        b=DK2nz++skHlsVHTKdsr7cJkHfu10LfbzQrY9KheqLZlDkqOQKvEkIh/TWNrt/lxlnS
         pJkuhedrZzPuwEv4muxwRTypAm1QWSeMI8c6lT45SjW6KMYLalaV8WAmBdy5diZIUJUX
         yoxG0PhzSnJ1l+nPQFWiWL0lLYT8lBnieqyibajmSE53vfazljQaKZnf9pxfrOlGV2tD
         tKUTWavIyXKzFP7K+yM/693vXbdcZyMQBZ3yDXkXOHtDscvc3xdo5SvfCdjsPT/JG0Lx
         TCOTjeiGlmtnUeTorwzrKbUoZDkGzUCz/tA7osFa46yLe7mQyxh3d+HkZNR/O4X/l7uT
         qqZg==
X-Forwarded-Encrypted: i=1; AHgh+RrqyPT73Dlcs4VCBnhESEvDa+fH0FORZWIclUPnM0AIhPWXALz6E+etlEwDyFVs/72D60Z28DRWRaINmg==@vger.kernel.org
X-Gm-Message-State: AOJu0YySssuws8bz3YoVF3gSjBNJzT4cmoK2nKMCu9ZYK/uuS5rmoP8v
	T7TtKyp8cnrHK6+qaIc7tAhW7SA/ESW/XztGLsS4Cmi/9XIkuT2k0YbA
X-Gm-Gg: AfdE7clOuiK6zLB3a8odgV+iiDoFkzc12MNcABAc6x+0eKgg81/laj66/jEkNRG5e+X
	yLbj1rSAneYCJhjeO6pJGi8/dCdRjeQb+BXNL8IvHxte5NOmY+nkJIIlL9YFbj7R1z3GnqI8mZe
	GPRVgoKMEp22r+MJ+PSmpoARrvnUugJ9Q8ZDHwdk6KhYjLSCi+dWADPwckJCHug6cLgXMEPSeXR
	47rhQaLl3tSYF5nQKgq6tZ2wGPvjruJU5UVjd40qOmrSGyxS8nBXiKbuFxJjuE6xIsDbOGIKqB9
	7QRaZN18B2ISsbvqSaEbxMI2KxWBEplmAFYp1wYutEiRHQK+wCMnm5wKEhp1J/1h6bvSwZyE05f
	pCAUb4OGeTq4WUMxsIdLFeZz/o0PH2uMCr1tmtKI9ipz1OAaFWEPk95wn+9tBtLstNeDxQjsb/0
	BNrSUYnED1vv2pHH+279WQEL5c4osKwCWH+BVv7YpgF9daePoVmKsQgif+6zBxadienV6UAz3TV
	SI=
X-Received: by 2002:a05:6a21:7701:b0:3c0:9c1a:8951 with SMTP id adf61e73a8af0-3c110b34ff1mr4611577637.73.1783822378295;
        Sat, 11 Jul 2026 19:12:58 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:c63e:9756:a95c:c75])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117d847e17sm54796692eec.18.2026.07.11.19.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 19:12:57 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v3 00/10] Remove support for platform data from samsung
 keypad
Date: Sat, 11 Jul 2026 19:12:41 -0700
Message-Id: <20260711-samsung-kp-v3-0-b2fcaba77aff@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABn4UmoC/1XOQQ6DIBCF4as0rDsGEVG76j0aFwijEosYsKbGe
 PeiK7v8M5kvbyMBvcFAHreNeFxMMG6Mkd1vRPVy7BCMjk0YZZyWaQVB2vAZOxgmUIha85a1BaM
 kPkweW/M9sVcdu/XOwtx7lH8E5XmZZglLcy44gxS0NbNfk9l5N/RueXZWmneinD3Q3oR4WM+BC
 zvoAxK0oOV1y8KAQqYEaq6qJmvERan3ff8BOv6NlukAAAA=
X-Change-ID: 20240819-samsung-kp-ceedd4f2f720
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Russell King <linux@armlinux.org.uk>, 
 Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Charles Keepax <ckeepax@opensource.cirrus.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-input@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 patches@opensource.cirrus.com, Conor Dooley <conor.dooley@microchip.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.16-dev-b242f

Hi,

This series converts the Samsung keypad driver and the Cragganmore 6410
board to generic device properties, allowing the removal of legacy platform
data and GPIO lookup tables.

We rework the Samsung keypad driver to stop using platform data, utilizing
a new compact matrix keypad binding. To support this on the Cragganmore
board, we add infrastructure to associate software nodes with Samsung
gpio_chips, and add software node propagation support to the wm831x MFD
core to route DVS GPIO to the PMIC regulator.

Finally, we convert all peripherals on the Cragganmore board (including
keypad, GPIO keys, PMIC, WM1250, SPI0, basic-mmio-gpio, and LEDs) to
software properties. This allows us to eliminate all legacy GPIO lookup
tables and fixes incorrect GPIO chip names from previous conversions.

Mark, it would be great if you could give this a spin on Cragganmore.

The majority of changes are in arch/board code, with a couple of input
matches and one for MFD. If everyone agrees maybe we can merge it all
through the soc tree?

Thanks!

Changes in v3:
- Fixed legacy property handling regression in the keypad driver by
  separating compact and verbose binding paths
- Removed redundant registration of crag6410_mmgpio_node from
  mach-crag6410.c
- Removed dead S3C64XX_SETUP_KEYPAD Kconfig symbol definition and
  selection
- Fixed missing newline in pr_err() message in mach-crag6410.c
- Redesigned PMIC DVS support to keep regulator driver changes minimal
  (untouched) and only use software nodes for GPIO routing via MFD core
- Link to v2: https://patch.msgid.link/20260708-samsung-kp-v2-0-3c6ed4c9b3b6@gmail.com

Changes in v2:
- Patches 1-8 of v1 were merged into mainline, dropping them from this
  series
- Rebased remaining patches (9-14 of v1) onto latest next
- Resolved conflicts in mach-crag6410.c
- Removed redundant "out of memory" error messages from the keypad
  driver
- Added an infrastructure patch to register and attach software nodes
  for Samsung gpio_chips
- Converted basic-mmio-gpio and LEDs on Cragganmore 6410 to software
  properties in a new separate patch
- Addressed DT bindings feedback on the compact binding patch
- Fixed proximity switch event type for GPIO keys
- Added support for software nodes in wm831x regulator driver
- Converted PMIC DVS on Cragganmore 6410 to software properties using
  the new driver support
- Removed legacy DVS platform data fields and cleaned up driver
  fallback.

---
Dmitry Torokhov (10):
      dt-bindings: input: samsung,s3c6410-keypad: introduce compact binding
      Input: samsung-keypad - handle compact binding
      ARM: s3c: register and attach software nodes for Samsung gpio_chips
      ARM: s3c: crag6410: switch keypad device to software properties
      Input: samsung-keypad - remove support for platform data
      ARM: s3c: crag6410: use software nodes/properties to set up GPIO keys
      mfd: wm831x: support software nodes for DCDC regulators
      ARM: s3c: crag6410: convert PMIC DVS GPIO to software properties
      ARM: s3c: crag6410: convert basic-mmio-gpio and LEDs to software properties
      ARM: s3c: crag6410: convert remaining GPIO lookup tables to property entries

 .../bindings/input/samsung,s3c6410-keypad.yaml     |  53 ++-
 arch/arm/mach-s3c/Kconfig                          |   5 -
 arch/arm/mach-s3c/Kconfig.s3c64xx                  |   7 -
 arch/arm/mach-s3c/Makefile.s3c64xx                 |   1 -
 arch/arm/mach-s3c/devs.c                           |  62 ----
 arch/arm/mach-s3c/devs.h                           |   2 -
 arch/arm/mach-s3c/gpio-core.h                      |   3 +
 arch/arm/mach-s3c/gpio-samsung-s3c64xx.h           |   5 +
 arch/arm/mach-s3c/gpio-samsung.c                   |  72 +++-
 arch/arm/mach-s3c/keypad.h                         |  27 --
 arch/arm/mach-s3c/mach-crag6410.c                  | 369 +++++++++++++--------
 arch/arm/mach-s3c/setup-keypad-s3c64xx.c           |  20 --
 drivers/input/keyboard/samsung-keypad.c            | 200 +++++------
 drivers/mfd/wm831x-core.c                          |  47 ++-
 include/linux/input/samsung-keypad.h               |  39 ---
 include/linux/mfd/wm831x/pdata.h                   |   2 +
 16 files changed, 472 insertions(+), 442 deletions(-)
---
base-commit: 8e9685d3c41c35dd1b37df70d854137abcb2fbac
change-id: 20240819-samsung-kp-ceedd4f2f720

Thanks.

-- 
Dmitry

