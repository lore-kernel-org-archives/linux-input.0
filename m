Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com [209.85.167.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B415C344DA8
	for <linux-input@vger.kernel.org>; Mon, 23 Feb 2026 06:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771828752; cv=none; b=g3HcG0kuTMP57ZfLHrhraZ5vYNTxy8Aj9r+QDw+gkak5kV8rlmJrBTVUjVn3cRWE0cqWvaut+GKBi3zEtAXqGS3ODqDJ8NzTrH2ND+Ie5449zz0GXcb4Ny3gL7YtsXm4tzrSUPMQMo2BYhKLRc02BelBDPSqp2NT605YQLHUmOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771828752; c=relaxed/simple;
	bh=k0UhZSHIQfO0HDHJkw8IbSbfZ311DvIpeYJjb/2LtU8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F52CqYUZ8TYgDa4kZIfrtWNXTi02S2LYdWdilTtpODzB0xUOO/iaQZxCh3/iECC1zPo3LqT52QTASJuL/fAVZstCwl6Xg6n7yRzrxWmBbJLlrLGzS6gim39/1gY0Ny2y6nrBmgWuKs0tGcffD0VT8iEtYHBCmPkcAH1nYGp8SPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K3jCFIm2; arc=none smtp.client-ip=209.85.167.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3jCFIm2"
Received: by mail-lf1-f66.google.com with SMTP id 2adb3069b0e04-59e63b427aaso4187044e87.2
        for <linux-input@vger.kernel.org>; Sun, 22 Feb 2026 22:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771828749; x=1772433549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=64fXO+/BrfVHyK+e3Z6d/GgzvitBotdXgadt/CHztxw=;
        b=K3jCFIm2sdlm98uGCBMvNRCOWKfKmqXYCK5A0vc80EwRE+kf5fD27VWr6GKy3OzihO
         tV+oRwBSuxcln0g7tbJTkGHcdjV7y6FsDfMsR5LQcrdICyCENJTCIGOIFRkq/yfdveYi
         IjL3Y0l+vDyLtLdqLnZmGZUGzJ0Kmfc7XNBt3b3uoZI0P3cDSOkTcQzngmejfTmcfgSO
         Azfrd9PfX5prYGuB5JWi2SH9i5vtb9IbeHXJU34e9kvBpuLNmoUZMHiZaZPofId83lkY
         Wajz4HJlfkH5Y3LNlCMykqKHfwSnB8eCnfqv9Qpg9TZUCqtksvWDWDi0Ociqj7c7/egw
         rLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771828749; x=1772433549;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=64fXO+/BrfVHyK+e3Z6d/GgzvitBotdXgadt/CHztxw=;
        b=PUx74hbQzaVn5bhziTtgtpQ6fZBYA9/Fa91sQ2b10eW4+lxd0SqCtnv8pjEstVciBG
         DLSTNNBD2Q1gDuuFiJfskMOZOsCVesykDw/AlPX5QnjtF0mAgqha0o4QOrHNwwFDw5WY
         K2QWyPQdT5dd3dj8kfQnk85pwlpwGn5nSR5pUUaX11z6iEIObLUggloih+V9vbOYs/bb
         teVo1Cfb/pIq5YEqHCmjmMZC2cgiTtG16uhZsEX2kjowogeGV0r/S6PvzxSrwupTFHo6
         D4+KAlRByLZasC3rwFCyCHEWCgOom1N7v4V6HYfqUSy5z0bsdmYPmGTFF3soEL9a3kfH
         dE0A==
X-Gm-Message-State: AOJu0Yx+1sQ2DH8F/+5RNQHNvOchQuYHoNd9BkS/ja6zqGQ+xcgspc5E
	jbXTPJOkm50um2TxrL30PxJAerRS7R7OtQTOI8xV6CHNv+ji4XopZBin
X-Gm-Gg: AZuq6aKxpdaV+Mp2QHBfjY8+x/mhZI1JUMvXiXqmhjbcni179XOQtpX7KeBxDC7GJHy
	ESq/0ZAkptUHmdkaOdEJDwPw6S9IPrYK7Xpyn5p6o22hLSDAQKLuD8xh+0W+/KcM3GR5wLbQfFa
	NASnKv/y0jKr7VtvuhotlJxEgle47W6BJBWk4wxOcXtF6wtegZj6BeoP8p8GGNP9GbKkxgUux2q
	WPYLAITbiFjt6etgyfZE5Az9F9r2lJLZPW9ocZOfnk8aRQt/zNlow6hKwtAt6udjfQb+N6Zp96F
	sHE/6nICabnbLTIuTMyKaudIxGss5fn5GZqMTuYP+phCdUE4b3nSSM3c0ax7RTo2jhWCnvk3Bzm
	LoW/TWYH9LXiy/dzsaQbY8XqzTExC033L0Rs5cedrxSMqOla35pviZtX3ume0wXBuLW8wL5QJPL
	+5FxFk0JtjbkPX
X-Received: by 2002:ac2:5b91:0:b0:5a0:ee0b:c257 with SMTP id 2adb3069b0e04-5a0ee0bc325mr1650088e87.10.1771828748858;
        Sun, 22 Feb 2026 22:39:08 -0800 (PST)
Received: from xeon ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a0eeb13abbsm1369626e87.23.2026.02.22.22.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 22:39:08 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Tony Lindgren <tony@atomide.com>
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: [PATCH v3 0/9] mfd: cpcap: convert documentation to schema and add Mot board support
Date: Mon, 23 Feb 2026 08:38:49 +0200
Message-ID: <20260223063858.12208-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The initial goal was only to add support for the CPCAP used in the Mot
Tegra20 board; however, since the documentation was already partially
converted, I decided to complete the conversion to schema too.

The CPCAP regulator, leds, rtc, pwrbutton and core files were converted
from TXT to YAML while preserving the original structure. Mot board
compatibility was added to the regulator and core schema. Since these
were one-line patches, they were not separated into dedicated commits;
however, the commit message notes this for both cases.

Finally, the CPCAP MFD was slightly refactored to improve support for
multiple subcell compositions.

---
Changes in v2:
- fixed code style
- rtc conversion was picked, so patch dropped
- added audio ports description into mfd schema
- splitted schema conversion and compatible addition
- minor style improvements and typo fixes

Changes in v3:
- added regulator node names list into pattern
- filled spi_device_id with driver data
- ADC patches were picked, so changes dropped
---

Svyatoslav Ryhel (9):
  dt-bindings: regulator: cpcap-regulator: convert to DT schema
  dt-bindings: regulator: cpcap-regulator: document Mot regulator
  regulator: cpcap-regulator: add support for Mot regulators
  dt-bindings: leds: leds-cpcap: convert to DT schema
  dt-bindings: input: cpcap-pwrbutton: convert to DT schema
  dt-bindings: mfd: motorola-cpcap: convert to DT schema
  dt-bindings: mfd: motorola-cpcap: document Mapphone and Mot CPCAP
  mfd: motorola-cpcap: diverge configuration per-board
  mfd: motorola-cpcap: add support for Mot CPCAP composition

 .../bindings/input/cpcap-pwrbutton.txt        |  20 -
 .../input/motorola,cpcap-pwrbutton.yaml       |  32 ++
 .../devicetree/bindings/leds/leds-cpcap.txt   |  29 --
 .../bindings/leds/motorola,cpcap-leds.yaml    |  42 ++
 .../bindings/mfd/motorola,cpcap.yaml          | 416 ++++++++++++++++++
 .../bindings/mfd/motorola-cpcap.txt           |  78 ----
 .../bindings/regulator/cpcap-regulator.txt    |  35 --
 .../regulator/motorola,cpcap-regulator.yaml   |  47 ++
 drivers/mfd/motorola-cpcap.c                  | 151 ++++++-
 drivers/regulator/cpcap-regulator.c           | 105 +++++
 10 files changed, 775 insertions(+), 180 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/cpcap-pwrbutton.txt
 create mode 100644 Documentation/devicetree/bindings/input/motorola,cpcap-pwrbutton.yaml
 delete mode 100644 Documentation/devicetree/bindings/leds/leds-cpcap.txt
 create mode 100644 Documentation/devicetree/bindings/leds/motorola,cpcap-leds.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/motorola-cpcap.txt
 delete mode 100644 Documentation/devicetree/bindings/regulator/cpcap-regulator.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/motorola,cpcap-regulator.yaml

-- 
2.51.0

