Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4DA435A85
	for <linux-input@vger.kernel.org>; Thu, 23 Jul 2026 10:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784801180; cv=none; b=iYfGQEgnUV4dKXY6Bwyk+z5WAQg7V2UWeyHKZsOMdZNPWiM8UnwhHsxCbxGIpk9Ipv7toEHI5HT7fPksykXGxykyI9e1KpJspuis+w7vzX7YePCJo1evPku/t71x+HYQlLMNg7Fta2W5W2oJTw9t4AnLq9ya7poV7Ots22M/8RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784801180; c=relaxed/simple;
	bh=+Wyfo2vtIbswyXq9efM7rosBVsTJwzmKdaBzzC/aYRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ea3M+EOPB9kJqps2mZkcc07xcEbz81xyCktV6S4Pddf9UIJX07UAmhyvdOQ6lyIpxMsxKlUTd36yhafyi0/fLOA2I9O9Ca3+Ts36nWIumrFA2eGQHz1MzYcjvSagW27RJh91DN2m+y5zyhD7wXYuedPslG3Pf8KaCMPMoVcCaGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FXwYL5Cp; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXwYL5Cp"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4954d383e64so2934425e9.1
        for <linux-input@vger.kernel.org>; Thu, 23 Jul 2026 03:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784801176; x=1785405976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BcGqlv2rED4NMS/3uzjzLmpezgSMOIuZyea8FmG7iIE=;
        b=FXwYL5CpobBGYaEXcsi7sfU/6zrVN+9MWYNCWa0tCT18D4dDmbXrVK5NqH0gOsWfCe
         TrFl0WWlwGXcPvIK8yWyaUTM6alsB06ngOdyMJJYnhiybARvXq1MyS7QIXhveZPHIPCH
         SfPLk2lk2XWkzMq806Cru7wBi8yLywO+i+Crk5TwdRwRUPJ3jDTOKfUCe1tqEuCmIPcQ
         u53zSiyYtRvDPkwxUQ64OV6pjw2IedJVh5EZHucUAULDCYp0AKU94k0bq0xF1TYn5b14
         7r7wd+CMhTXXhJiXQV/KP0JFKzwRwg4eTflMaxb6p3WO6oTwu9kka5mdNgtqPURVXmV9
         6F1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784801176; x=1785405976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BcGqlv2rED4NMS/3uzjzLmpezgSMOIuZyea8FmG7iIE=;
        b=CcxqqWadNIF1tno9jURpu6laeSYBgtTvwJCCj7wAtK7193fKiUh4g9+4Vv9I91VOAO
         eyzQdQPejaTp1z4vvXaEZFRrveqAqWwOrC5JhKzqT5zp6BpI+lxMhDJAZSbPWhfGDkdc
         SZv21OC2XUDBMLmNgyCvtpMpVT0V2cYO6+tRjQfhjsoO8JBmVQPSV8vkLv+bDbr1Yd7u
         jEqSdm+UGY1DD/1+KoVoH6dDbPoNuX8O9CNcdyxu6YzS9+shd96OBT4mF3SkBKgHWlJt
         ngTYsFxjk7AITsdcUFmhPcoPyRYAlKviqSpmfOYqHiJGRd9qN/WGURdKI/P0iNlXoqHE
         LTsw==
X-Forwarded-Encrypted: i=1; AHgh+RpF8KxdX/82mcSmPy3tiEpOyup/87nQW3BDkmZagZSQiHJbxWUS3mZ9hMnyHqk6X6+ab9FXcdqHycJmtQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfgkg12RZsxLhJNxtnmVSecb5AcZk3J6tHiBhDsO23JHoyc7om
	CmY5Uxu1e88MB212s5tjI9eTBJiOia6E1o9uRb3ePUllWiKl49Wq+O1i
X-Gm-Gg: AR+sD12nPLzcj7uP6AlM/SLHGvaFT/zoZcWBT3+K11/KfRIUdsOxdMqGjW6aW/LOVIX
	x4b20v9DQioSUjqkBStj8w/fCAM9PbrSeYe1j7mZJU40E5kFRDK6+o7OxgSUC6XcQvI6BlhHTLM
	ejs7Ouy9V+Pc06NPwimV8vko3yLHUiVdQiMcEiTm0oX+y+vlbcq9MBWAcau4imD9keb2Xh08jZ7
	MtlYM3LbdrGKOVXQJ/7VHfg2L1b1hqaXwEkb8NS+xmpPgGBjP4PPPbN/c4MeVwShyrmCt7TgCgu
	pCqyeGxe9HWrBVV7V7THdmpThXZ53EAYcMDrFtbfOF2xgDf3AydUwUNh/hBDzzsdbxEfQC8LKy6
	K4R5NCcb7LUvIq84OWFdBRaYU9gvbzbe0ESVVdvRZ6u6WGmG0oinHrRirIUe5lXUqbeB2CDDkDr
	cCvcwCv+5ADRX0ptviFLvhAzBXXlmfSOp8lTRSSqmWVsVI
X-Received: by 2002:a05:600c:1914:b0:495:4d00:2fc0 with SMTP id 5b1f17b1804b1-49573ccb598mr27399575e9.12.1784801175908;
        Thu, 23 Jul 2026 03:06:15 -0700 (PDT)
Received: from localhost.localdomain ([86.126.27.145])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-47f85b9a60asm14212163f8f.3.2026.07.23.03.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 03:06:15 -0700 (PDT)
From: Eduard Bostina <egbostina@gmail.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	devicetree@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	dri-devel@lists.freedesktop.org,
	Eduard Bostina <egbostina@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-omap@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Mark Jackson <mpfj@newflow.co.uk>,
	Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>
Cc: daniel.baluta@nxp.com,
	simona.toaca@nxp.com,
	goledhruva@gmail.com,
	m-chawdhry@ti.com
Subject: [PATCH v4 0/4] dt-bindings: Convert TI TPS65217 to DT schema
Date: Thu, 23 Jul 2026 10:05:58 +0000
Message-ID: <20260723100605.628882-1-egbostina@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series converts the Texas Instruments TPS65217 PMIC bindings to DT
schema.

Changes in v4:
- Removed the regulator/tps65217.txt binding. It documented the same
  'ti,tps65217' compatible and is now fully covered by the new schema.

Link to v3:
https://lore.kernel.org/all/20260721112133.70382-1-egbostina@gmail.com/

The binding covers the whole PMIC, so leds/backlight/ may not be the best
location. I can move it to mfd/ or regulator/ if preferred.

Eduard Bostina (4):
  ARM: dts: ti: am335x-guardian: Drop unused isink-en property
  ARM: dts: Rename the TPS65217 regulator nodes
  dt-bindings: input: Convert TI TPS65217 power button to DT schema
  dt-bindings: leds: backlight: Convert TPS65217 to DT schema

 .../bindings/input/ti,tps65217-pwrbutton.yaml |  42 +++++
 .../bindings/input/tps65218-pwrbutton.txt     |  30 ----
 .../bindings/leds/backlight/ti,tps65217.yaml  | 170 ++++++++++++++++++
 .../leds/backlight/tps65217-backlight.txt     |  27 ---
 .../bindings/regulator/tps65217.txt           |  78 --------
 .../boot/dts/ti/omap/am335x-bone-common.dtsi  |  14 +-
 .../arm/boot/dts/ti/omap/am335x-chilisom.dtsi |  14 +-
 arch/arm/boot/dts/ti/omap/am335x-guardian.dts |  17 +-
 arch/arm/boot/dts/ti/omap/am335x-nano.dts     |  14 +-
 .../dts/ti/omap/am335x-osd335x-common.dtsi    |  14 +-
 arch/arm/boot/dts/ti/omap/am335x-pepper.dts   |  14 +-
 arch/arm/boot/dts/ti/omap/am335x-shc.dts      |  31 +---
 arch/arm/boot/dts/ti/omap/am335x-sl50.dts     |  14 +-
 arch/arm/boot/dts/tps65217.dtsi               |  31 +---
 14 files changed, 275 insertions(+), 235 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/ti,tps65217-pwrbutton.yaml
 delete mode 100644 Documentation/devicetree/bindings/input/tps65218-pwrbutton.txt
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/ti,tps65217.yaml
 delete mode 100644 Documentation/devicetree/bindings/leds/backlight/tps65217-backlight.txt
 delete mode 100644 Documentation/devicetree/bindings/regulator/tps65217.txt

-- 
2.43.0

