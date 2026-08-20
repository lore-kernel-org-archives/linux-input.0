Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5D843E9C9
	for <linux-input@vger.kernel.org>; Thu, 20 Aug 2026 12:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787228742; cv=none; b=KT3s4/KBoHs7EpdbsMMC+YFfnEKBo0nv7haTH2NNznQEJq5yaWjILACS8dniosr9jVKtUN/vN80Yl0iwPA4kXPXK5AT0DeBw5G8fhTK3cYR/pi/bDjp5ZvS9Wc5mVYKhhR/jO+KOBSLtEN45fdkPlNS0o7KcZ99h0Aguzk2FFh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787228742; c=relaxed/simple;
	bh=5EqwE72lB3dCmSiHsbuHnJ0dwESRP2TpD3/4zPtIdKk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jDC9K/n4roTHwRDoeEp8PJ57DRyXisyRbnZPK2Ok6cUbpJUGxd8Qu3po0wsSX6agykuB9hWQcNkp+00NdU/rUKY7AlSewzdSNkdPLtAYXC5ZdjdMq+enZMvZ0AWobtIrLhw6jnlXyu0NlznMF/LvHkPrmxvlatG3o2MK9IX9N7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o+PuASMV; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+PuASMV"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49954b88fffso22518905e9.0
        for <linux-input@vger.kernel.org>; Thu, 20 Aug 2026 05:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787228739; x=1787833539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5cG8/G+LZIThnaZEGrxtNWIAVyCLkFjFn4+BdzM/oQk=;
        b=o+PuASMVWoDB/6hcukGdp8k7jHbAEFIEZAer0oxRBKTQeFJXoX0CccxjHaC77W8ssM
         rfs2CJOfDKjdjAPiMztIcvhzITas7DwG4DBousmBNJNzQshwht13gfsd/Z9eTLyp0U7A
         /kaR4VAk3Yr/4553+0xBScO9riuLX6asHqt7u4PaNMWFBNbA08Qhh4r3vum8m5TUKPgE
         OYtIJmcEMuP0FlFEmfC6pzj/72poKncZ/kqg18dPTowamIR+u9uEYkphrNGZ0qpb+oer
         xvFDqSaYxc4VAZdY63bnjfQ5peWmuATh90f+dADTTL6h7eC7HMXbU92aYS4mEMhjFHDO
         +YRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787228739; x=1787833539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5cG8/G+LZIThnaZEGrxtNWIAVyCLkFjFn4+BdzM/oQk=;
        b=BZmVVXirsl/DYwNE6IN0Psoz0nyc88xHaxAkfxQSXbK6QKXbsu8yMpRpWmiRteUvAh
         XxGBYXwkX7xrZ0MvdtcKgCQgh+MEzYyDArSRQNm4MfzGJRVNsz9InNuN9h4sdLkVS3d7
         a1Cp49VStJ9K3EmVWAus0SkNZhrDe0jruuEOtsxGO94hTRAYqb9xJVUr87IRVdokDggL
         xXooeeUTzP8KMB+opsRSp+EDLxLpz1jWMg5BYdlMqwHcxrghcnwFiFgro8U8Ymzbv+IW
         r3Dpcuum06ki2NMH13acpw7pac9+wxUHD1B71FFNZMQ4jfCalZuj4EM90A3USGmcS7Jz
         n90g==
X-Forwarded-Encrypted: i=1; AHgh+RqL/JUlRSJQ1aw73VZEZfPzzC+4diYOgeivCbhvoja0EB08VgRalBZ59IKBV8DpcH0Ku51KM8IAkdk4dg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc6qnw42WfG7rus4tFEgzkB2HHZTMJNBhvUePAOQQxSm5TiR8B
	svasMYpzzLKEm70OW8nqA6l2iyIfJQGqDm+KLuWahIYLfkohwHafzziJ
X-Gm-Gg: AR+sD12Nj5jMiEQ50EJyZeRzsC9uzeVxeBCD/MfocQUNQrda0Oxcq+ApsjDYaCBXSjj
	bGt8SdimV/5cJavPW3tSe5eDZ+cq1I1eB6xoVsn5KW9cHWaFXvqnJ7GWsFSIJW4cOVU1O9G1cFE
	GS/UbJucxNB1GUeY1bYUADuUMRJbQEBThb6cx94PI8Joy8bdAmfc3dXl0b2sRQUcLylvvTWa38M
	DiD/jn8AjUADnx0sBhxnpAS7IV9Hnw4YnHZ+vyG3vl7S/C5rK4RR/MEV8HuZwHCByFS+0pkV9gN
	Jiyvf+9RDtXAV2mSYzeE5sK9rjnJtYtvc1xEpQb/+Lt7o9B+UfUPhtRkX6wN1yPToXD/rviPV3W
	9NnqhPHzMoVIYeAKfB7WM1gont/BN3u0Yap/fueO4cuhZTRVaHEHOe41EcMpzVY7nI2TsypDVFg
	DoaXkt1E+fgfzsNaxerJ8tLfS4smqPJS2jS0sMYCUGLAoOp5DxPau1uBX5RAmzZy2U
X-Received: by 2002:a05:600c:34d1:b0:499:49f3:77b1 with SMTP id 5b1f17b1804b1-499aa14a6a6mr214121195e9.3.1787228738421;
        Thu, 20 Aug 2026 05:25:38 -0700 (PDT)
Received: from luca-vm.. ([81.56.18.151])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499ab2a8b34sm170494645e9.8.2026.08.20.05.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 05:25:37 -0700 (PDT)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Luca Leonardo Scorcia <l.scorcia@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sen Chu <sen.chu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Lee Jones <lee@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Val Packett <val@packett.cool>,
	Julien Massot <julien.massot@collabora.com>,
	Fabien Parent <parent.f@gmail.com>,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH RESEND v9 0/9] Add support for MT6392 PMIC
Date: Thu, 20 Aug 2026 14:19:58 +0200
Message-ID: <20260820122242.120039-1-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MediaTek MT6392 PMIC is usually found on devices powered by
the MT8516/MT8167 SoC and is yet another MT6323/MT6397 variant.

This series is mostly based around patches submitted a couple
years ago by Fabien Parent and not merged and from Val Packett's
submission from Jan 2025 that included extra cleanups, fixes, and a
new dtsi file similar to ones that exist for other PMICs. Some
comments weren't addressed and the series was ultimately not merged.

These patches enable four functions: keys, regulator, pinctrl and RTC.
Mono speaker amp will follow later as I need to work further on the
audio codec.

I added a handful of device tree improvements to fix some dtbs_check
errors, added support for the pinctrl device and addressed the comments
from last year's reviews.

Please note that patch 0006 and 0008 depend on patch 0005 as they need the
registers.h file, but belong to different driver areas. I'm not sure if
I'm supposed to squash them even if they belong to different driver
areas of if it's fine like this. Any advice is welcome.

Patch 0009 also depends on patch 0003 because of mt6392-regulator.h.

The series has been tested on Xiaomi Mi Smart Clock X04G, on the
Lenovo Smart Clock 2 CD-24502F and on Sony PlayStation Classic Mini
SCPH-1000R.

Changes in v9:
- Correct binding for vrtc as it does not support mode setting.

From sashiko:
- Added missing include in MFD documentation example.
- Fixed constraints for regulator-initial-mode in regulator binding.
- Fixed wrong register write while setting LDO standby mode.
- Added missing pmic interrupt definition in the pumpkin-common include.

Changes in v8 [9]:
From reviewers:
- Added example code to the MFD device binding, removed it from the
  regulators docs.
- Added minItems/maxItems constraints on the regulator mode definitions,
  improved the mode constants.
- Fixed formatting issues in the regulator binding.
- Import the mt6392.dtsi file in pumpkin-common.dtsi, as it was originally
  meant in [8].

From sashiko:
- Added more explicit constraints on the regulator modes definitions.
- Use the appropriate modeget register for LDO regulators, Buck registers
  don't have the corresponding register according to the data sheet.
- Added the missing of_map_mode function.
- Removed some debugging code that had no use and masked error codes.

Changes in v7 [7]:
- Removed patch 0008 dependency on patch 0003.
- Reintroduced the regulator driver. In earlier revisions of this series,
  it was proposed to remove the dedicated compatible for the regulator
  device [3]. The driver does not use actually it, but it is not possible
  at this time to remove it from the bindings since it's a required
  property.

  Making the regulator-required property conditional was NACKed in [5],
  with the suggestion to create a separate binding altogether for devices
  that do not require the compatible property. I tried implementing this,
  but since the parent device needs to be declared as compatible with
  mt6323, it leads to a warning in dt_binding_check since mt6323 would
  be declared as a compatible in both mt6392 and mt6397.

  In the end the only regulator driver from the mt6397 documentation that
  still declares an of_match is mt6397-regulator and it does not seem
  to be necessary, so it should be possible to remove it and make the
  regulator compatible optional for all regulators, but that change would
  probably deserve its own separate patch series.

Changes in v6 [6]:
- Dropped the regulators driver for the moment
- Explained the FCHR key name origin in the commit message
- Introduced the MFD_CELL_* macro in the sub-devices definitions.
  A separate, independent commit introduced MFD_CELL_* to all the
  subdevices in the mt6397-core.c file for consistency
- Replaced of_device_get_match_data with device_get_match_data
- Removed the mfd_match_data enum in favor of the preexisting
  chip_id enum
- Adjusted the error message if the device is unsupported

Changes in v5 [5]:
- Double checked regulator driver with data sheet and Android sources.
  The data sheet I have misses a lot of register descriptions, but
  Android sources have been helpful to fill the gaps
- Reintroduced the required attribute for the regulator compatible
  in the bindings
- Fixed the missing reference to the MT6392 schema
- Fixed casts/unused vars reported by kernel test robot
- Removed Reviewed-by tags from the regulator patches as they have been
  modified in this version

Changes in v4 [4]:
- Dropped usage of the regulator compatible
- Fixed commit messages text to properly reference the target subsystem
- Added supply rails to the regulator
- Reworked the regulator schema and PMIC dtsi. Now all supplies are
  documented and the schema no longer includes voltage information
- Removed redundant ldo- / buck- prefixes
- Renamed the pinfunc header to mediatek,mt6392-pinfunc.h
- Modified the MFD driver to use a simple identifier in the of_match
  data properties

Changes in v3 [3]:
- Added pinctrl device
- Changed mt6397-rtc fallback to mt6323-rtc
- Added schema for regulators
- Fixed checkpatch issues

Changes in v2 [2]:
- Replaced explicit compatibles with fallbacks

Initial version: [1]

[1] https://lore.kernel.org/linux-mediatek/cover.1771865014.git.l.scorcia@gmail.com/
[2] https://lore.kernel.org/linux-mediatek/20260306120521.163654-1-l.scorcia@gmail.com/
[3] https://lore.kernel.org/linux-mediatek/20260317184507.523060-1-l.scorcia@gmail.com/
[4] https://lore.kernel.org/linux-mediatek/20260330083429.359819-1-l.scorcia@gmail.com/
[5] https://lore.kernel.org/linux-mediatek/20260420213529.1645560-1-l.scorcia@gmail.com/
[6] https://lore.kernel.org/linux-mediatek/20260612200717.361018-1-l.scorcia@gmail.com/
[7] https://lore.kernel.org/linux-mediatek/20260615071836.362883-1-l.scorcia@gmail.com/
[8] https://lore.kernel.org/linux-mediatek/20190323211612.860-25-fparent@baylibre.com/
[9] https://lore.kernel.org/linux-mediatek/20260620200032.334192-1-l.scorcia@gmail.com/

Fabien Parent (3):
  dt-bindings: input: mtk-pmic-keys: Add MT6392 PMIC keys
  mfd: mt6397: Add support for MT6392 PMIC
  regulator: Add MediaTek MT6392 regulator

Luca Leonardo Scorcia (4):
  dt-bindings: mfd: mt6397: Add MT6392 PMIC
  regulator: dt-bindings: Add MediaTek MT6392 PMIC
  mfd: mt6397: Use MFD_CELL_* to describe sub-devices
  pinctrl: mediatek: mt6397: Add MediaTek MT6392

Val Packett (2):
  input: keyboard: mtk-pmic-keys: Add MT6392 support
  arm64: dts: mediatek: Add MediaTek MT6392 PMIC dtsi

 .../bindings/input/mediatek,pmic-keys.yaml    |   1 +
 .../bindings/mfd/mediatek,mt6397.yaml         |  75 ++
 .../regulator/mediatek,mt6392-regulator.yaml  | 112 +++
 arch/arm64/boot/dts/mediatek/mt6392.dtsi      | 145 ++++
 .../boot/dts/mediatek/pumpkin-common.dtsi     |   7 +
 drivers/input/keyboard/mtk-pmic-keys.c        |  17 +
 drivers/mfd/mt6397-core.c                     | 295 ++++---
 drivers/mfd/mt6397-irq.c                      |   8 +
 drivers/pinctrl/mediatek/pinctrl-mt6397.c     |  37 +-
 drivers/pinctrl/mediatek/pinctrl-mtk-mt6392.h |  64 ++
 drivers/regulator/Kconfig                     |   9 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/mt6392-regulator.c          | 764 ++++++++++++++++++
 .../regulator/mediatek,mt6392-regulator.h     |  23 +
 include/linux/mfd/mt6392/core.h               |  43 +
 include/linux/mfd/mt6392/registers.h          | 488 +++++++++++
 include/linux/mfd/mt6397/core.h               |   1 +
 include/linux/regulator/mt6392-regulator.h    |  42 +
 18 files changed, 1970 insertions(+), 162 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6392-regulator.yaml
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6392.dtsi
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt6392.h
 create mode 100644 drivers/regulator/mt6392-regulator.c
 create mode 100644 include/dt-bindings/regulator/mediatek,mt6392-regulator.h
 create mode 100644 include/linux/mfd/mt6392/core.h
 create mode 100644 include/linux/mfd/mt6392/registers.h
 create mode 100644 include/linux/regulator/mt6392-regulator.h

-- 
2.43.0

