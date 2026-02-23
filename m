Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692BF330B00
	for <linux-input@vger.kernel.org>; Mon, 23 Feb 2026 17:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771867031; cv=none; b=U1TmDNSY5nHLI0fQQpfTlG/IkJT7o4Wvcitnp2psQMa0kW53fOUMVuzaohN3xD8Ur9xaxyMwwW9rjVXFd+g4KikG8yKxNtbJ6+Wy7ektKIvjAtPfOxaYkutKMZa5WlYTFaIfFAM9eoFFe0y2nSOz7wab5ljQL0Zqrndx98lzhYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771867031; c=relaxed/simple;
	bh=WVs/g4cQmQqVe2J2+nIoMwPE/ef3LT19rVqgZxkT9UE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fkaDYJ8BwYVNLF3e+Q1AluRqobE+O7jWzBC7qcZczVlCR4hZ35UlanKMjRJ4TpQfirb4iHVMOFQUZKeS2n/xq4S251bePXqhls5VpYQ4FyyRhAWkOt35ooXsCEPgI0RKAV5a1y4UdOqN793ccrMR3lHKtDxZLERn9v8TwBuBipc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9IPm/hf; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9IPm/hf"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-436309f1ad7so3454761f8f.3
        for <linux-input@vger.kernel.org>; Mon, 23 Feb 2026 09:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771867029; x=1772471829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hyGEcrLpV4bwwocVSCsdzUyZjiaZncJT9oIq/dUyqxc=;
        b=V9IPm/hfjv8OQgb6O/hWFilVSPV6B+cULb9Tcqm7zCE4kaTuD0eH4Rmk/iO6R2Kz43
         qkS/HitSuu7H09EBA/wA4xYFKAO/kcOapN63tSN6QTGT8kPketMJEGOUOCE8/nd5jfMp
         gBztAqzIcksfDSpur1ZaaVoWE6p/g5fp7uRK8bVBpAgWAeQhUt+S+QoYi4qf/mW9r+BD
         MyvRSBZVgxG+I/UvWvg/+Gfh/Ksw8IKbcKiAOCeokmyQessNhLoDISCTIJJLX6Z4OF8u
         OTdeIpJ6VOvCEGz4O4wNIgOqKFn6KopgDnWtB6M/vv+3XdIV0dHPMhYqmud0rV9U0a70
         iDmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771867029; x=1772471829;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hyGEcrLpV4bwwocVSCsdzUyZjiaZncJT9oIq/dUyqxc=;
        b=uR1aXGGWPxiaeEnCrjR6cODERqX59gKNhUuHO/u+43SvB1qGNnGvhx3bLxnE+3du3P
         hR7GOmoPfSP2mAjGtL8zPqtRnwvjtTf3P9EabA0f0FQ9Zr4xELcjWDAoM/psy04yEclZ
         imfsbM38JaQ+6dawupfKfew8U0ALd47WYcumd3AS5i3vVVpWDbEpazDaChzVW3zF1A1J
         CwshbDCak3tLGVUFwj41LpvkDWElbG+pR3h4jZDMGEUgn0GYqfUB5YRQmO9JGeYNHzIB
         DWT+cqT/9pzAkFMWM9vzYUOlLR49QY8haGz7pzpnqHrEs6ptKln8SnrV/b3qnmsHTmo2
         JBSA==
X-Forwarded-Encrypted: i=1; AJvYcCVx7ZjR42+NCnHM35/0mBHWcrkjxuB6Pzz/SrXUCqhUAreDQpwSl0+Oj+tRWJ6gAgY4qie505vwS3f2LA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwSA/PNNQmT6ATF7S6ZR9WrG95gwouDfIFbcDdJLmpLJIUZ119a
	o7q7fVO9PYyePzoDRvWPMUTA4PhDFM5Xb7Rb/0JrYvJ0jdzkxrU8Pky6
X-Gm-Gg: ATEYQzxGYX4lZjGm0rRfHKTaAub01PkXIx/sQz/kwn8J8hU666DjXLQd65kL8NUyyGz
	GcpFGL1Z1iB0/4Uh824D/Da03oXMM6/AAx+ZYM1MxB5TK3B+VHERoPPpPi9/simOmlu886Yvqhn
	jl7JWUR4WLiOCILtHxuZXI4Z0qyMREleL2oThMwx87luwbs62LAhZaeA0bjE1InxRBU+HWgiCxx
	cRXfuwnF9YqgcqcTEftXMDjYd8egEvSMdVPmdx0aHp1YcrV9OqJWsYILMLj/Hv8Hi48J1OQNcjg
	PnLt9IEuXC8NaP/USXfUJaIl5qc+EPNCF7ulTds77Jn7Wqa9WWVs35wNB4Fb294j+xJ9qJU/2ov
	rHeLM6I25xrISr22v9P8WpX1sf9mNeGelAtrhd9w549iB+rKfBIMWX7GJwfUo77I8lBJSi3RCnh
	u/NOjX9qrrSiGDOzUi0AI=
X-Received: by 2002:a05:6000:2910:b0:437:8111:e2d0 with SMTP id ffacd0b85a97d-4396f1562efmr16272260f8f.8.1771867028658;
        Mon, 23 Feb 2026 09:17:08 -0800 (PST)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d4c982sm20871454f8f.31.2026.02.23.09.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 09:17:08 -0800 (PST)
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
	Eddie Huang <eddie.huang@mediatek.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Julien Massot <julien.massot@collabora.com>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Gary Bisson <bisson.gary@gmail.com>,
	Val Packett <val@packett.cool>,
	Fabien Parent <parent.f@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rtc@vger.kernel.org
Subject: [PATCH 0/9] Add support for mt6392 PMIC
Date: Mon, 23 Feb 2026 17:12:39 +0000
Message-ID: <cover.1771865014.git.l.scorcia@gmail.com>
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

Fabien Parent (5):
  dt-bindings: mfd: mt6397: Add bindings for MT6392 PMIC
  dt-bindings: regulator: add support for MT6392
  dt-bindings: input: mtk-pmic-keys: add MT6392 binding definition
  mfd: mt6397: Add support for MT6392 pmic
  regulator: mt6392: Add support for MT6392 regulator

Val Packett (4):
  soc: mediatek: mtk-pmic-wrap: add compatible for MT6392 PMIC
  input: keyboard: mtk-pmic-keys: add MT6392 support
  rtc: mt6397: add compatible for MT6392 PMIC
  arm64: dts: mt6392: add mt6392 PMIC dtsi

 .../bindings/input/mediatek,pmic-keys.yaml    |   1 +
 .../bindings/mfd/mediatek,mt6397.yaml         |   3 +
 arch/arm64/boot/dts/mediatek/mt6392.dtsi      | 133 +++++
 drivers/input/keyboard/mtk-pmic-keys.c        |  15 +
 drivers/mfd/mt6397-core.c                     |  43 ++
 drivers/mfd/mt6397-irq.c                      |   8 +
 drivers/regulator/Kconfig                     |   9 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/mt6392-regulator.c          | 491 ++++++++++++++++++
 drivers/rtc/rtc-mt6397.c                      |   1 +
 drivers/soc/mediatek/mtk-pmic-wrap.c          |   1 +
 include/linux/mfd/mt6392/core.h               |  42 ++
 include/linux/mfd/mt6392/registers.h          | 487 +++++++++++++++++
 include/linux/mfd/mt6397/core.h               |   1 +
 include/linux/regulator/mt6392-regulator.h    |  40 ++
 15 files changed, 1276 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6392.dtsi
 create mode 100644 drivers/regulator/mt6392-regulator.c
 create mode 100644 include/linux/mfd/mt6392/core.h
 create mode 100644 include/linux/mfd/mt6392/registers.h
 create mode 100644 include/linux/regulator/mt6392-regulator.h

-- 
2.43.0

