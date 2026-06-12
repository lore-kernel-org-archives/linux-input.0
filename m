Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55673A3E68
	for <linux-input@vger.kernel.org>; Fri, 12 Jun 2026 20:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781295965; cv=none; b=AScQ/hR+obVa/uXnRjnPCBLgZUdCyNz1SmTljGeFpyMLV+Qa6m1srt2ac2DHL4ZAeZ8Ll4fqdCUoTjjy3LpP/jwvKrGvWS5IdmP6lQjjmgImsP3pkOTTOF/pVa7TwBiN+drltGGVX+Fnno5rBuoWNhO94IFTIMjjkK4u8wrD8g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781295965; c=relaxed/simple;
	bh=Cq8cPoBkI+FB/GEbDx3WtxRVRdZkRoFA54OCpSDtqJE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pylD5BfU4WgRs9JpaQG2E0axLJ6fEEVUb25qp9+TeM7/4op7FlneUChDOkwn0mr7JxYDfsieB00tprhKbHOHCSHCEH92fZFBK2+AfmRP0qHtWTXWHpXXAoegMw0mvKNnaVaETy49lsOhXDOZ5hbIQ2iGzRi/mPOqvVGrrbk74/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8y6RWvg; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8y6RWvg"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490b12270b3so8614705e9.1
        for <linux-input@vger.kernel.org>; Fri, 12 Jun 2026 13:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781295962; x=1781900762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8rQCLAIxALSz/Z8tD2vL5V4eDD0YacOILyc6cFmNdB8=;
        b=K8y6RWvg4tLzpXJq9RPzKhkwQeFOMPJRyo/S4I5hrUVeP7lIYA5GAwBMDiA3P9Uz9h
         UlrIzRUGhST1MO055UjF7IOp4NYiJUTGjHHNvzGJWTzbDXKR7PMgvzxjgvLuxhiqIavz
         aBFwyR8Mbhxl6FLkDyK7B9snr/G0mKvokym4bhDLm/Jv73Dnudp3b3A0xT9H1M1E9YxW
         XVW8tZZA0BVKsxpESC2T1D8OJwMyFPy7HLGTD2eRXW77nZ+s6cIjqNVdhzLnnygq8Vhi
         g+Sgsv8hMXIsfAc5GEU4RPlcHjipzeuhpDusCG1QqRUbuGWpVt7jCJyZNFR6daOJpoTE
         wCwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781295962; x=1781900762;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8rQCLAIxALSz/Z8tD2vL5V4eDD0YacOILyc6cFmNdB8=;
        b=Z2mHHk56u4FUZZ/EenF5GDOB7+Bk2mu2ojJBE1WbbD67tioGGI9VumWwoRjHsj4Qe0
         9b3XSexjdbXi7rvDJfzSRw19xz7WPCms330SUn7xyR5qw9AywpKT8rmhF7XFKYjOgCAo
         BtB8uuiLkXkPOD/3apx2SaVX7LinC3g00AvYqtw2i60NFeyrvZHSXDql+O0AoBxHEA0F
         o43NeKZalRLwjUZjLPPKo9kfp2k/F7xLMf8+kyZSsZb1//MobYSh+VakF3gYeNdPPDzf
         t44BE8hkCIGAA5dFSa9D+DvcE0HWMXf6aVX90G2u24b7SbwnkjwTHH8SYj3AQiVp0KmX
         n6BA==
X-Forwarded-Encrypted: i=1; AFNElJ/H3j8Ga2dCirxIdawwwxnHNMfNKvJFU2z+O+xSzVp62dUIfDMITll5eK9ePxpRVOkgkUJnUhllynUlCA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxgwiHC6PptaHfa91coVjMmrKmQr4Zo8JqmIMiaRbdz2gei7N2C
	KSvKC21BbKQMMZuOLpUovGpc1F+SVIMHBKDLVRrz8mWtSL6cF3lK5v1TlVQidNL0
X-Gm-Gg: Acq92OGN1w+GkKLo9gzXJB01o0zyUXuHw/t7nqBK8/pfY0JHM+RUUIbQdU3wMfOnNmK
	yRfr9y4XFoySR325cIq/Oy/6FqZm8MIQ11CiyAOQHhPd4VwJ+JHRvW8pe5ZeDVfQgB2MkIaYzFl
	4Lc2c3tw3SV3RkkQjaOax1dLxvdmo3smSdhaTTUfZ/TO97QID6s09qH6UINRMiF5Pr73fQRdrX1
	hDP/ZWKjvP5++q3jt9goeAS+YLUe1vNOoC3wKRNLEikF52kxfyKmKIeRkK6RtFLLIX9NJwRZUFK
	eg+U/JaPhv9nzXwdDUPew3mU7Kh/wnd/m62CSmPzlzNNovvf4ErC4EwVr/xWeegzEDljR50A+mj
	g70ov5fVNRl/UubVxuMfwrzlPgJoz+gJI8aVbmB3kDnxwtByD0wCdyKEF9dVCAkWgFY3+Wp2cT+
	S4Pl9NBTgJs27UfAxT
X-Received: by 2002:a05:600c:3585:b0:490:b642:ce29 with SMTP id 5b1f17b1804b1-490ec4d4f71mr59232905e9.8.1781295962029;
        Fri, 12 Jun 2026 13:26:02 -0700 (PDT)
Received: from luca-vm.. ([81.56.18.151])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26434dsm9173261f8f.1.2026.06.12.13.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 13:26:01 -0700 (PDT)
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
	Julien Massot <julien.massot@collabora.com>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Val Packett <val@packett.cool>,
	Fabien Parent <parent.f@gmail.com>,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH v6 0/7] Add support for MT6392 PMIC
Date: Fri, 12 Jun 2026 22:04:05 +0200
Message-ID: <20260612200717.361018-1-l.scorcia@gmail.com>
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

These patches only enable three functions: keys, pinctrl and RTC.
Regulators and speaker amp will follow later as I still need to further
improve those two, but getting the main PMIC in will make the series
easier to review.

I added a handful of device tree improvements to fix some dtbs_check
errors, added support for the pinctrl device and addressed the comments
from last year's reviews.

Please note that patch 0005 depends on patch 0004 as they both need the
registers.h file, but they belong to different driver areas. I'm not sure
if I'm supposed to squash them even if they belong to different driver
areas of if it's fine like this. Any advice is welcome.

The series has been tested on Xiaomi Mi Smart Clock X04G and on the
Lenovo Smart Clock 2.

Changes in v6:
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

Fabien Parent (3):
  dt-bindings: mfd: mt6397: Add MT6392 PMIC
  dt-bindings: input: mtk-pmic-keys: Add MT6392 PMIC keys
  mfd: mt6397: Add support for MT6392 PMIC

Luca Leonardo Scorcia (2):
  mfd: mt6397: Use MFD_CELL_* to describe sub-devices
  pinctrl: mediatek: mt6397: Add MediaTek MT6392

Val Packett (2):
  input: keyboard: mtk-pmic-keys: Add MT6392 support
  arm64: dts: mediatek: Add MediaTek MT6392 PMIC dtsi

 .../bindings/input/mediatek,pmic-keys.yaml    |   1 +
 .../bindings/mfd/mediatek,mt6397.yaml         |   8 +
 arch/arm64/boot/dts/mediatek/mt6392.dtsi      |  41 ++
 drivers/input/keyboard/mtk-pmic-keys.c        |  17 +
 drivers/mfd/mt6397-core.c                     | 294 +++++------
 drivers/mfd/mt6397-irq.c                      |   8 +
 drivers/pinctrl/mediatek/pinctrl-mt6397.c     |  37 +-
 drivers/pinctrl/mediatek/pinctrl-mtk-mt6392.h |  64 +++
 include/linux/mfd/mt6392/core.h               |  43 ++
 include/linux/mfd/mt6392/registers.h          | 488 ++++++++++++++++++
 include/linux/mfd/mt6397/core.h               |   1 +
 11 files changed, 840 insertions(+), 162 deletions(-)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6392.dtsi
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt6392.h
 create mode 100644 include/linux/mfd/mt6392/core.h
 create mode 100644 include/linux/mfd/mt6392/registers.h

-- 
2.43.0

