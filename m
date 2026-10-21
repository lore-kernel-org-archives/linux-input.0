Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792579890;
	b=2qDJBmj0T6UjbIaVjq6rxb6p+lw8TgFyRw0SBopsm1B2qvFWvbSSCzKrFGQn/aL146NE
	 mc4OtHjpaJyeD2fKaH7gfnexSCZ5R/M5UWGzhfqetFc/B6FA4MNmTyM6avbmcfVg1ec4A
	 7NI0DuFpPXy/1IMZQGJlaxNM+QExyVTzLAmnGCVJigIie1nHpJ+xgyHC26cLQaX6Gm+6t
	 dnLjlCNt0FCUggysgp6DlelB8Chd092kTm8BviyFvNhdYFVjlIDtF8lyvF4pGGwLkvVVd
	 KxisoI7uxCvHoNFNUU8g0iBUaEvzAI+cqzzAlo+MMaYcJO1VVct8v/iEr4Vj+EiMMSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792579890;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Q19lKEnG8THeG/yXYppxXwK4fJmenAR0pQMrApiY6Z4=;
	b=ja/cK2OYGvWSTix/atcJZJofDOyIAPsq/7S89CtPgRodr5NpgH6LyHA+HnM0hgMAKh9m
	 Nyu2YpWNiKeEoSCSRKgFhAZkgNv11hcR+/cCMas2kSGMyb8VQjPA8cM2kITIXBU3Z2zNu
	 k1dRE3JBYk0Mfj++DVn/dVFvwtZAJ2jnHBwIhP0Zg86QLM7FuNI9aaOTCJzBjLxqzQYtH
	 c/KVpUKao5my65NLaxVJxahlSHxV4SozmFlAo/CALnWP39Puoi7p5Fh4bhNS0HctS36cR
	 329HLTAilmxJfcMr6El21sL1GQjD6BXLiPYfUyvEUZWDx3r9KLAWPCWpEHSuSizhyUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QP+1EgHr;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23D9606A31D
	for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 10:51:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F23D9606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QP+1EgHr
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a16af2a232so3384955e9.1
        for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 03:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792579888; x=1793184688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q19lKEnG8THeG/yXYppxXwK4fJmenAR0pQMrApiY6Z4=;
        b=QP+1EgHraZT0KGov01tm4BGPvg0tNu2mzHsoHm6ituMiu72VorMRkUhS42jJFS65DM
         hTmzGxBNF2CnAw+oTg4QjYgFDQ/BWA6jbObxdGJAdHQoaqL/lJ+un1A3F/egmVIak6Ab
         txQJ2xtO0/8CfnAfzIbwdqkrfbaqSb6eZPcKRgiWTwDh7tELOIG5JifFPqTqYB01oWhD
         T/vPMRY+5JQUPmvusYYJ6VVreUw9Chb4s+V6B8KY91HRs9H/fZJjb2SIS1e+YmNIRykz
         JeuasueuXOTufnH6hl0iSHHGNoCs6kn8QIYJdwAsRx8MVZZcE1n74v5kI7u53GsVFR2V
         llZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792579888; x=1793184688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q19lKEnG8THeG/yXYppxXwK4fJmenAR0pQMrApiY6Z4=;
        b=qSyYMmzu+yMyPzkRfb5iPyqc5q4jCU39CvHlzjIg1COkBjxqoYFq0hVu3ro+w58ggs
         hyaTrGSntX2/DFSKz7nMzClb7+3vHhSNgICd74mxa/HJlmvDWZZXc2uyUlGamPTTw16/
         YjIQUk/loAx+0p6S/KT/ik4WQyS1zbUA1vAHBI+5JUK9F1PqLYCZG8HewsVeUV38g0lR
         jvcGQhpv9SKQBdv+uJqAElDFj8KwOn8RiBfqFL308yG93a3Z8/0bIjERKwHyEJKUDx2O
         sEATkpK+I/0ppGOsTVYL9VOPgQX9VWQU2pqN3E7yynXVmfKEelgavySYiidOh6ByGMdF
         UPdQ==
X-Forwarded-Encrypted: i=1; AKwUvBy7Aqt+PnqUlhbVsBr8DVTLiOwhaju5Fb9ZzovWO5KXFA75L9IGrhkTpdXrZtumO9wtPOgzSlS5B9ESmg==@vger.kernel.org
X-Gm-Message-State: AFq9FYKCPBqjA1gqRv2exhCq+UaHmA+nQyOZ5FXKbwP1aCqJdRC3zbFI
	T4N7chbN8kF8sKobjtmLOP/ryxIBMs4HKOfX0hLYwzBb9shB7VgIeCrR
X-Gm-Gg: AYBFou0h3oByQdm9zj6IyB9Q5i8MaeTl3GoCd04RdxxL5mrLN7HkyFIA+Wc4ufTtBN6
	EbLSuRpnVl6snVfpFATIxbraBGM+dqZQobCLm4G100ijI4qK/wT8Egq70at3gGXpb82e7NUr5CY
	0s866CdqUq/Xy+P39WygnzUM4NnwjgtwhpoddKdCD7Lgi0FwhF6Z/9VCupmfjtMk51kB8Nl0S99
	b+nERDnBgrmYxqPX0BuYcEFqVD2sKJvvzjbsAySVaPf5jrUaZYXMpKy8mEl0QSGDU31zTdH31Td
	NjNitjfK321sD7Q+Yd/2nL/9NM0HPYhx9RuKn+3sKb0NWEyQWQkgBnl0ychkAh+WIAy6sq5XT9v
	/46m34TraT7ZIqNB8xpW9kUQpCpkQXQqxgGbC3ZbSLeL5S557bMyYIjFxZHQV3PNLKxwM9LTmpB
	N3ZXcQBgq7720saztTB6FH+7YwndGqqlCfYVIy9NctGRCMllhMn/loXBV8GWjuVnEoAKFhpCHdG
	GTH9Jqfz8u5T4j5nCr7X/aMxnMkMwiFSUHJs13TOKftQFLBeOusk3fq8BYb358AGBpcK/LV
X-Received: by 2002:a05:600c:4684:b0:4a1:d36f:1ba0 with SMTP id 5b1f17b1804b1-4a1fdd74b6cmr33371145e9.35.1792579888215;
        Wed, 21 Oct 2026 03:51:28 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2d6e2dbsm153388305e9.13.2026.10.21.03.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 03:51:27 -0700 (PDT)
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
Subject: [PATCH v11 0/9] Add support for MT6392 PMIC
Date: Wed, 21 Oct 2026 12:47:18 +0200
Message-ID: <20261021105109.199886-1-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
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
Lenovo Smart Clock 2 CD-24502F, on Sony PlayStation Classic Mini
SCPH-1000R and on the Lenovo Tab E7 TB-7104F.

Changes in v11:
- Removed the example from the PMIC binding, fixing some bisecting issues.

Changes in v10 [12]:
- Removed the fallback on mediatek,mt6323 in the MFD binding document
  and in the dtsi file. Suggested by Sashiko [11], thus removed the
  Reviewed-by tag provided by Kryzsztof Kozlowski in patch #1, version 9.

Changes in v9 [10]:
- Correct binding for vrtc as it does not support mode setting.

From Sashiko:
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
[10] https://lore.kernel.org/linux-mediatek/20260820122242.120039-1-l.scorcia@gmail.com/
[11] https://sashiko.dev/#/message/20260820125850.3B34D1F000E9%40smtp.kernel.org
[12] https://lore.kernel.org/linux-mediatek/20260902193351.185771-1-l.scorcia@gmail.com/

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
 .../bindings/mfd/mediatek,mt6397.yaml         |   6 +
 .../regulator/mediatek,mt6392-regulator.yaml  | 112 +++
 arch/arm64/boot/dts/mediatek/mt6392.dtsi      | 145 ++++
 .../boot/dts/mediatek/pumpkin-common.dtsi     |   7 +
 drivers/input/keyboard/mtk-pmic-keys.c        |  18 +
 drivers/mfd/mt6397-core.c                     | 307 ++++---
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
 18 files changed, 1908 insertions(+), 168 deletions(-)
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

