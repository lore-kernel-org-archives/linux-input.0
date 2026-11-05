Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793907894;
	b=nOfo53zHTUPJ+v0Kk4IELZxA0VUM6OvdunVFTfrWrwVXpzsLGINLNERBBIYytW2Bqjcn
	 j0Kl5C3sCCLPp/HSwVdXlDLABwHBirhtSPaQfft3STPW6D22Qb8/HDQqpH6x31xPukWWS
	 wHoHTCQ2hekkTL3U+LqxqjUSbReVrYcpQjZOQ1padL6Ol5lNTInfJMxmOiTrfwljJjpA9
	 IWZHEi+J4MwCjTytoCjeTFbIjzFcu3M/N2ZsHKGFkOjgVB30XBu8Qm5qDxEqh0EZgC8ie
	 bMOTG/fNZRZm7U9grm6i+45O06SFO1F9A9wFHTP1bIQ8PJ/IBnHMsM1If+8UKzOvdzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793907894;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qKMu7fZRj+bInVCVJVTcipZVR9tOYgtfexJmTWWS9M0=;
	b=xf2/XwwwyF1RV1UsG48KF7vKq0yT7zmovP45laUnHX4hf7EwOhlfC4XWnoBIYKtb2OSd
	 o6glUK7ETNH/YEj2VQCrxUUyTkb2xJdLF1qK3xXi2lX6xpAxU9nXq1f3viH7/cvmSe24H
	 UkisqxNNBnkU52t3X05PwK1a4WZiueSTIQ/tTD3lM3/mWaUNI2InSjuWjQP8xxlkhsq7m
	 4OXZw/CTpVwzCCOimQfATouAHb9z0yZs5dTOCXW75bsn0A7mTKYr2U4iEI63mwur/SRHI
	 J/To1Xyae8cuOK/u5AZShn3GurDhbgjRgOyXlxTK8U3gDZaFSQPut7ZNTSMuZlDbIWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jj3npcTJ;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39337606D811
	for <linux-input@vger.kernel.org>; Thu,  5 Nov 2026 19:44:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39337606D811
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jj3npcTJ
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4b467581b98so16465355e9.0
        for <linux-input@vger.kernel.org>; Thu, 05 Nov 2026 11:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793907891; x=1794512691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qKMu7fZRj+bInVCVJVTcipZVR9tOYgtfexJmTWWS9M0=;
        b=Jj3npcTJndb7f71qsSJWJZOyUlYtdh7J6p+0Yk/L3wmBAu/SA56DeSuwgnXgBsHVtg
         8WERU86HTmLSeju5w3I/OUSZeDfr8FAaAEq4+uXjr5J2zyo1mlX2yI28Q13kieRB1VUg
         TtudPH5d/FMw8gVLRU/OZllCMBs3IaMOsReaYsDuAw7aJK53Ju0Dlnp3+5eKEYhoqnYQ
         3lwjRs/3aKTmZNdoUaN7rjIbyakGQ/ba57NtKSVtYxSUvrmfekbqbmPEuhrARZ9patVS
         379w83Up9HkG6+oMEyjmCW8UXTwyyKBdG0Y7/OoQ4sDSZMTToRAb2sQs5X65EKMM3kOf
         cdtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793907891; x=1794512691;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qKMu7fZRj+bInVCVJVTcipZVR9tOYgtfexJmTWWS9M0=;
        b=u0UFNQZb9THC+OXY6EAudakCXRP8Bv6A4wOiE/DrN9dKWhC6kces09Vz62ZQprWumZ
         BSdHm3mnX8fjgfH9tXiaztszZoy2hmk8cDXRHKR4eOKbLx5wX1fIL3fKSL8jFCOA1uny
         POLVJI3AA9ec4wRlaV76huXx4vwePdaU+QU793dDIsqN6q0OCN+iWn4Wki1tcqGm6WTQ
         qEqqcbYapVZmAM2ZiJBvrkExOdXkNB+jQ13dzarvCtxe4pTvHKqnnFO2221CT7LOwCLq
         cq/KLXvKm9rroLqjBLYuVDWPdlbEMEZB6I8/OtW/COLXKAqWcyENfsKb3MhR9qMIRztC
         M6fw==
X-Forwarded-Encrypted: i=1; AKwUvBwmJkeBvjscm41Ywg8K8YKiG5jmcy3+ewtQSZPRWVYfC8H+OLM4Jkztfx2AkMVIbwJlF71U6zHxanxmgw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8ENiC1q+K2I/jU5WFGF6S5JFS/NR/4H5D26IZP5lNzJQoTmlJA
	Pl/ExeL9gSAoJzkugHt2BQL9BSSbXd73zhp4/9XTP6/ZRqATZ+QTrGq3
X-Gm-Gg: AYBFou2/f+sVv4784SPsq9sVIdS86yzD5H6bcDgwGtCZ5fC1cJeFnSHBtDoaAxVYVe/
	unAgKDaT50l2xziXSRaWPPrno5Dk7rJbYFp5CltVGykV45NrFE5Zk4qAcMvAyX6gwu9dotq2vAR
	RU2h30HmGjQZTt+xfSF1lhjaI1/valYkObrueyg9FHt17BdinEPs8AEF/PGUnRyVAkC1ZZv0j2J
	FeJEI4RqR1iIfjWJnlRgsS4ngWab8KQpSnU2FQRZ7F/KC/wHuBTqQ/5GRs0QIwO/y6k0nd7ziRP
	LJ7eLbOy06WNVRHZHanZMcGLPZBdNXJ9mqbJIYVXMktwap8lO3ds99BHGYRpQHC4HXLPzjAcSGH
	+h4K6e5dPOtuc63lJC2OVa0M/QnC79xzgr1LwmtlyinTS/1Si4mCq0XuUSxO6CwD3WE0uLCQUpi
	acSzolSpby/1z0eRk4EBl6wKDsEEHhDg0Q/JuptDmB33B9vuziBsZmwNJa/tQQ0B7I8rANvqpgc
	bjEVqfd8dV3fqOH6uq9gVB3+8qw/05Gtnt/BQ6r07SW1rPAbJTGGdYaiYSrW8A8ms4dS0UW5MwC
	K6aigUdp6L+lWAQmFodk4M8c
X-Received: by 2002:a05:600c:c168:b0:4a0:1c0e:b057 with SMTP id 5b1f17b1804b1-4b6db2ba2demr2607695e9.4.1793907891234;
        Thu, 05 Nov 2026 11:44:51 -0800 (PST)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b6df5eaabbsm4204265e9.2.2026.11.05.11.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 11:44:50 -0800 (PST)
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
Subject: [PATCH v12 0/8] Add support for MT6392 PMIC
Date: Thu,  5 Nov 2026 20:41:31 +0100
Message-ID: <20261105194426.1113050-1-l.scorcia@gmail.com>
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

Changes in v12:
- Rebased over v7.4-rc1;
- The patch to convert all mt6397 cells to MFD_CELL_OF was removed from
  the series, as it's not strictly relevant for mt6392 support. It has
  been submitted separately [14] and can be applied independently.
- Added the regulator-always-on properties and basic voltage restrictions
  for core regulators for Pumpkin boards to prevent boot failures
  (suggested by Sashiko).

Changes in v11 [13]:
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
[13] https://lore.kernel.org/linux-mediatek/20261021105109.199886-1-l.scorcia@gmail.com/
[14] https://lore.kernel.org/linux-mediatek/20261105104837.1105227-1-l.scorcia@gmail.com/

Fabien Parent (3):
  dt-bindings: input: mtk-pmic-keys: Add MT6392 PMIC keys
  mfd: mt6397: Add support for MT6392 PMIC
  regulator: Add MediaTek MT6392 regulator

Luca Leonardo Scorcia (3):
  dt-bindings: mfd: mt6397: Add MT6392 PMIC
  regulator: dt-bindings: Add MediaTek MT6392 PMIC
  pinctrl: mediatek: mt6397: Add MediaTek MT6392

Val Packett (2):
  input: keyboard: mtk-pmic-keys: Add MT6392 support
  arm64: dts: mediatek: Add MediaTek MT6392 PMIC dtsi

 .../bindings/input/mediatek,pmic-keys.yaml    |   1 +
 .../bindings/mfd/mediatek,mt6397.yaml         |   6 +
 .../regulator/mediatek,mt6392-regulator.yaml  | 112 +++
 arch/arm64/boot/dts/mediatek/mt6392.dtsi      | 145 ++++
 .../boot/dts/mediatek/pumpkin-common.dtsi     |  82 ++
 drivers/input/keyboard/mtk-pmic-keys.c        |  18 +
 drivers/mfd/mt6397-core.c                     |  97 ++-
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
 18 files changed, 1913 insertions(+), 28 deletions(-)
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

