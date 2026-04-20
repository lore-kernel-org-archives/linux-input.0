Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA3E307AC6
	for <linux-input@vger.kernel.org>; Mon, 20 Apr 2026 21:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776720969; cv=none; b=ibjWPJvakN9DB1+XC4SYGclIeqKMP8I6nKZkIoDzD1cKo4Tg+JhvOQ/sD+sgEsF6AmHW0taD8lDqix84ue/mFuRh/v+Je4TY9RAdFd5zMd0hr9RXrUqzi5zDvR18QyydinXEQB1v1nhZfa1Dwa+72V55YqMz1Sn5JqbXhXAmF+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776720969; c=relaxed/simple;
	bh=UgW3k1vXeuAXYJVVUE3uw4fYebqcjx6HXfLWRx4YEts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tUc9s1TJeWWSx5YIipM0eEW+sb/CcbNTdEgyLRrytLnay8Ft/VnduULq9aS1sWzPUqqXtxIfwYm+/1/kTzP+uFVuF+sCfEtye14PwNoZmV647esJfDS68qH56HHnMnckUBsC6OrZFdU2oh+46K2IVaIQhN3TPa/qHyTCkYjJY9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ET5GGz6P; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ET5GGz6P"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso27243895e9.0
        for <linux-input@vger.kernel.org>; Mon, 20 Apr 2026 14:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776720967; x=1777325767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yKbbLjMj5a+s95ZY4aMoYwg6sSM5rUeqb55KfE7XVeI=;
        b=ET5GGz6P3Sud7C9voRyK0mRbRtxGpYw+gBrgsLLVB+Cy6JlkzDDMT8BK3XvP+yYEek
         P4OvBv9lVEj0oVUt8YiG7X/XXmyZO3etqGaGAwvYuE7bmD4TMtWrJ49hJSnYDLU2S+3n
         TiaRPMAbeL75wRAlIgU4iDTq18x2ns/JCqV+YpWu7nVRuG7++m31eQgtQHqQsfOAQzpL
         m5Bucd48Wruf6zFk0IA/F5PhHG5jGiz2ickyidvabpUOHG2CHfIMr5FVH2NTYatXtIsG
         MLCL7xM5x+21r3QsGGJyEQgNz6YKqwOevNUdyAUJlRhICL+/iFjqqPbNSs3gBmeWewzV
         Raug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776720967; x=1777325767;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yKbbLjMj5a+s95ZY4aMoYwg6sSM5rUeqb55KfE7XVeI=;
        b=GTrl4jta/8G5aoAs1ZO3Fvo1UcLAB96VQGMGiAKDBo9OEgGNz+NXvu2w9K4/ttOrB5
         L+iEDuRPFUvKTdrw4qzFfH7Kd3aoQOJBy9eXnX5oj2R2Q4y7VoUpff7+ELZ2Fi4fADP1
         htUbIMnjBRMTmomsxkCjjsHAsxC2NZf/1KheLy5lqYfFXO0nS4+bZ5U62rD/u+hgzuTA
         PCbXOU+EhM2M+jxvmEEk6TD3k1vG+jN6WqFIaxrdOovM8nM6ox13JDPFLQl2iXOKJDm5
         vfWeboXWPPuN4L556ftMG+Dh4rEAjbnMyYbslZvc7/WHaAFkR+SYrQcVTIQZCOQNp417
         M1vA==
X-Forwarded-Encrypted: i=1; AFNElJ/yLNA8UDL3PJrT41HJNr7oNBLrUnmMdA9wJ3uGjBdTCdYvRHouxGpvrIsCcRisUefZKOxR/TQzlC0T6A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNLQDf3Xs3yKQnEa5Ss35m7FOM30ZTQijAefoQjCmu8iKK1IRS
	g5Tva1KlzsPU9qgU3Bp+WqKIrmMgIGPhZZyvk10RvDhPVyBBjPfVXCZC
X-Gm-Gg: AeBDieuXEleQegen4vK0+E6riM/C/UeUBnQ9L3G98er6OB8e22tW0BP70ekrULzubc6
	4+tEQFkFrbcH0KyNkdVaHILBRK67VAPD90X3orU+o1y2aOpOFy/XetA0iBXV2TV7F7ROTInE9xY
	Z5czw2IxIrBunYJGRVWWaMvFWClJUtptZX/zz64c/39hOTAjcv11qLKmcBHg6b1+5GdO8fuYI+t
	x3wozsyHfjqo74KShaYpd3uUb0jcL7kkZwyQ9MnwhYotRxnB+aQLf/3GZpI3O0CAPO3hllDe8/a
	E2giqEtnQxITHw0OEWpmQ+5Tz+w3qDMNB2eubf4Yy4S5vXwF+HDrgbdHOM6H7C4VJ8ZXS3h3w1j
	t038TkGifUMslO0i1dSyDjuskUzROksX/pEQ1OSGOTterYllRuUK64b7jOEr4G15NQneZUNg35G
	aswMtTdlA+pw7eCX0/zDizSGbVSKoWqg==
X-Received: by 2002:a05:600c:34c3:b0:485:41c4:e2e4 with SMTP id 5b1f17b1804b1-488fb792dd0mr216654415e9.23.1776720966527;
        Mon, 20 Apr 2026 14:36:06 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc140c82sm289500355e9.12.2026.04.20.14.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 14:36:06 -0700 (PDT)
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
	Linus Walleij <linusw@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Julien Massot <julien.massot@collabora.com>,
	Val Packett <val@packett.cool>,
	Gary Bisson <bisson.gary@gmail.com>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Fabien Parent <parent.f@gmail.com>,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH v5 0/9] Add support for MT6392 PMIC
Date: Mon, 20 Apr 2026 22:29:59 +0100
Message-ID: <20260420213529.1645560-1-l.scorcia@gmail.com>
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

This series only enables four functions: regulators, keys, pinctrl
and RTC.

I added a handful of device tree improvements to fix some dtbs_check
errors, added support for the pinctrl device and addressed the comments
from last year's reviews.

The series has been tested on Xiaomi Mi Smart Clock X04G.

Changes in v5:
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

Fabien Parent (4):
  dt-bindings: mfd: mt6397: Add MT6392 PMIC
  dt-bindings: input: mtk-pmic-keys: Add MT6392 PMIC keys
  mfd: mt6397: Add support for MT6392 PMIC
  regulator: Add MediaTek MT6392 regulator

Luca Leonardo Scorcia (3):
  regulator: dt-bindings: Add MediaTek MT6392 PMIC
  dt-bindings: pinctrl: mediatek,mt65xx: Add MT6392 pinctrl
  pinctrl: mediatek: mt6397: Add MediaTek MT6392

Val Packett (2):
  input: keyboard: mtk-pmic-keys: Add MT6392 support
  arm64: dts: mediatek: Add MediaTek MT6392 PMIC dtsi

 .../bindings/input/mediatek,pmic-keys.yaml    |   1 +
 .../bindings/mfd/mediatek,mt6397.yaml         |  27 +-
 .../pinctrl/mediatek,mt65xx-pinctrl.yaml      |   1 +
 .../regulator/mediatek,mt6392-regulator.yaml  |  76 ++
 arch/arm64/boot/dts/mediatek/mt6392.dtsi      |  73 ++
 drivers/input/keyboard/mtk-pmic-keys.c        |  17 +
 drivers/mfd/mt6397-core.c                     | 118 ++-
 drivers/mfd/mt6397-irq.c                      |   8 +
 drivers/pinctrl/mediatek/pinctrl-mt6397.c     |  37 +-
 drivers/pinctrl/mediatek/pinctrl-mtk-mt6392.h |  64 ++
 drivers/regulator/Kconfig                     |   9 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/mt6392-regulator.c          | 740 ++++++++++++++++++
 .../pinctrl/mediatek,mt6392-pinfunc.h         |  39 +
 .../regulator/mediatek,mt6392-regulator.h     |  24 +
 include/linux/mfd/mt6392/core.h               |  42 +
 include/linux/mfd/mt6392/registers.h          | 487 ++++++++++++
 include/linux/mfd/mt6397/core.h               |   1 +
 include/linux/regulator/mt6392-regulator.h    |  42 +
 19 files changed, 1776 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6392-regulator.yaml
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6392.dtsi
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt6392.h
 create mode 100644 drivers/regulator/mt6392-regulator.c
 create mode 100644 include/dt-bindings/pinctrl/mediatek,mt6392-pinfunc.h
 create mode 100644 include/dt-bindings/regulator/mediatek,mt6392-regulator.h
 create mode 100644 include/linux/mfd/mt6392/core.h
 create mode 100644 include/linux/mfd/mt6392/registers.h
 create mode 100644 include/linux/regulator/mt6392-regulator.h

-- 
2.43.0

