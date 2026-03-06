Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B22B3659F0
	for <linux-input@vger.kernel.org>; Fri,  6 Mar 2026 12:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772798754; cv=none; b=I4J3Vtk6oRwcgsjwcNqqPcuR3WmfTZ80XsEHg63uv6QhysxjhqZD8HK814OK76qfXMWtMEto9Sqa7t5Gv3JI7gtX5iPDNhl13vHAiodfk2IYATq8Pjvv8nEO6UR5uNDsrPRUKxhVeL0CXYhqBG08bwbmE135mqyIBsT9EOaheQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772798754; c=relaxed/simple;
	bh=1OGPesTTQ6PdHg6rziXwtnglSKn5QCyc2GI25XQeshs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S6JXLea2Ah2cb4TD7aK6LgSW8jJDtCGOtMSoueERVRBh2U+stDBsuv+ZDt4vNQrxyb4J4CRj9ULOqdLy3w4b0woDlW8oGI/mxDLFG94O5EWPOfDpc6VGsT++oBbvjMaA/mewjuBLiMVl8xV9wav4pwSHwm1R6w8nPkhR5RZHues=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FqBKTlNH; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqBKTlNH"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4852a8482fcso498825e9.3
        for <linux-input@vger.kernel.org>; Fri, 06 Mar 2026 04:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772798751; x=1773403551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mTkk7uiuigPho3KVdrJ5hWiT++sJi9u25O2m/ZkmXhs=;
        b=FqBKTlNHodQghvPRUQQuvUXRcNRwclphFXeubRab5/d6hOXFyG3JF+j2b1/hOIqODh
         fVU0apcCXG2S6SLCC+dH1aPPp+ID0Q27MX92FqgJ+hT4rY59FZngNaGe8RWeTV+sWFIj
         +M6IN4Fop6/LYSiebKwsqxKyDP2VAWgOfELb5hQPl+Z+rPjLjHV6SRZLw61l2MMKOWjv
         4yaMA3C9UwnOrtERp5kBaLNj+VJV0vhTGlhNhVlATTir5wAmYeEoWhMnHacF4pQsKiY/
         NW0DEFSmZC4pauV5PUo1ZPWPhP8OvzFXxVkT+ZsBaxkLAXPAajm7Jpx2fMyJwl7hXlOB
         HDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772798751; x=1773403551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mTkk7uiuigPho3KVdrJ5hWiT++sJi9u25O2m/ZkmXhs=;
        b=DdDNBAvVUpp3mojbNt0TPFLxnSpYCUX+T3/J8mWoDX2fs+sgyvaT+3eYwpgmcCZeBJ
         pYaA503touGmSWOXmrCGnhlBHPje2Wp/mv8Cek40atV8Nuhz6HA7mAthePeFnW+5TOdo
         ahSQH1856ycs9d4P3H3Ew9tpcHVTu/0jTnC3q1NWXMtqvXwYprvJPl7Q39fgqPQ/yGxK
         b4ln81SbC0p+KHDN1JJNtO6sXX6uJQaYcp2F1n16QuhUADGTnY6yS4YKvEU04fSeP/Ah
         6S2/dPoRZN9ScITlJN43nsrUgKqnx1CAh8PwOjBadPXRX1hwbR+UWTBVVghMy7Z6aBcW
         Modg==
X-Forwarded-Encrypted: i=1; AJvYcCXGtBfLR6hARXTgV9Lk4yOsNGgFFPEDaYvwblYsHXMZX7kYqXsmzghTtlCI6UfsCH511b6T3LjfbeYcVw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMl3JBS9dxGjL9zzVyJZ5GhzikP8rVcHVUKwyXy+4hYejalkIu
	w3kTQ/0xps++tth+K2STfIsLkLxRSmlPT40Zg9zsAdSxeppKqXOpjuCR
X-Gm-Gg: ATEYQzyd/4UqL4cgRoAPpa7uri+RJC/wAksP22d7brpXHygqCypuEVm1PjJi8nVL6vz
	vmhoQmuZdZeInlqUMrC/mcO2UtNJo9+sPSxuiec9eAKB0vL0lMCsB+UBcnAgD2XeD7ibttwYEI4
	Ccp57PzZj2b3mSd25Oggs63jha1g5Pg5PQ5M84q7ifgojXSz06hLVuHYtX+A60TOVMIspCeV4XH
	aIpJRoFanPEHALpxRWncaWkA6pLKZPze4Ds4pB+qf4smBRkpiUBLgPx0Buwh6a94X/Ov4llEYqF
	yWHwq1IRtGUnl2J7qT7Wk0jExFy5XEgwuevoM9WxnmoRGiO9zk/wz4SnmMtMt77TKVK/X5xaaLy
	2VPcgciogxhaAD9K1YxQeh/koMBOgpAea2pMlXfROc9i41tdNEiRY9nTZ43AiJ1nSoXmGwGPYaW
	ldWarf6K/pde+DLGsRcF8=
X-Received: by 2002:a05:600c:a403:b0:485:2969:cd9f with SMTP id 5b1f17b1804b1-4852969d02emr7858575e9.12.1772798751250;
        Fri, 06 Mar 2026 04:05:51 -0800 (PST)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae2b9d8sm3457225f8f.21.2026.03.06.04.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 04:05:50 -0800 (PST)
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
	Val Packett <val@packett.cool>,
	Gary Bisson <bisson.gary@gmail.com>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Julien Massot <julien.massot@collabora.com>,
	Fabien Parent <parent.f@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/7] Add support for mt6392 PMIC
Date: Fri,  6 Mar 2026 12:03:04 +0000
Message-ID: <20260306120521.163654-1-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MediaTek mt6392 PMIC is usually found on devices powered by
the mt8516/mt8167 SoC, and is yet another mt6397 variant.

This series is mostly based around patches submitted a couple
years ago by Fabien Parent and not merged and from Val Packett's
submission from Jan 2025 that included extra cleanups, fixes, and a
new dtsi file similar to ones that exist for other PMICs. Some
comments weren't addressed and the series was ultimately not merged.

This series only enables three functions: regulators, keys, and RTC.

I have added a handful of device tree improvements to fix some
dtbs_check errors and addressed the comments from last year's
reviews. The series has been tested on Xiaomi Mi Smart Clock x04g.

v2: Review feedback - replaced explicit compatibles with fallbacks

Fabien Parent (5):
  dt-bindings: mfd: mt6397: Add bindings for MT6392 PMIC
  dt-bindings: regulator: add support for MT6392
  dt-bindings: input: mtk-pmic-keys: add MT6392 binding definition
  mfd: mt6397: Add support for MT6392 pmic
  regulator: mt6392: Add support for MT6392 regulator

Val Packett (2):
  input: keyboard: mtk-pmic-keys: add MT6392 support
  arm64: dts: mt6392: add mt6392 PMIC dtsi

 .../bindings/input/mediatek,pmic-keys.yaml    |   1 +
 .../bindings/mfd/mediatek,mt6397.yaml         |   9 +
 arch/arm64/boot/dts/mediatek/mt6392.dtsi      | 134 +++++
 drivers/input/keyboard/mtk-pmic-keys.c        |  15 +
 drivers/mfd/mt6397-core.c                     |  43 ++
 drivers/mfd/mt6397-irq.c                      |   8 +
 drivers/regulator/Kconfig                     |   9 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/mt6392-regulator.c          | 491 ++++++++++++++++++
 include/linux/mfd/mt6392/core.h               |  42 ++
 include/linux/mfd/mt6392/registers.h          | 487 +++++++++++++++++
 include/linux/mfd/mt6397/core.h               |   1 +
 include/linux/regulator/mt6392-regulator.h    |  40 ++
 13 files changed, 1281 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6392.dtsi
 create mode 100644 drivers/regulator/mt6392-regulator.c
 create mode 100644 include/linux/mfd/mt6392/core.h
 create mode 100644 include/linux/mfd/mt6392/registers.h
 create mode 100644 include/linux/regulator/mt6392-regulator.h

-- 
2.43.0

