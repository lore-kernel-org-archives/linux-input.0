Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863E137702E
	for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 11:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784632908; cv=none; b=nXNNKD8OvS5Py1JZqKYP0D7Ym9qeELIhQy/O8lkZzLvyu7rCmzln/Imzo7WxUS6htwR69Jf3qS5QXCtV1s/vS+HbrM7/3XoWnY6b9clFBFxxl+sFGhw8DmizScTBa3Sk5jk6Zfm6oz6Nw6dN6F/rzeHo1Pcfzx4Ykp5k+BQttow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784632908; c=relaxed/simple;
	bh=LjMm0PBKh/Bx+amzkvhuyIeZuvgi3gtmnabaArRttWg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mWwnOHrh7hPdrGtmRNb2sP4P/rZXATSMRF64i2KO9GHg419lJF5T28cbim5oOGPfjSBh1FmmPGisJHca5p6ZPuJkHaRqNg8ggEtemeekXFXPk+lUKNQmh/ZAA0Ihb9XU+mVsPebvM0tjQvHhqPz8FKllaHoQbXmwOu7QsKASeQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kuiw0QoH; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuiw0QoH"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49555a0e68bso13755755e9.2
        for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 04:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784632905; x=1785237705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=y2+LKseJXzKxktbUWoc1WNBTZXl1F3xYy2w48c5tdQY=;
        b=kuiw0QoHi8Zx+wZjfBeqtNiwArvcCHxpM/BijsuDWkLzdkpqLsQxbrsG8rGlqhKTmK
         qkxxN4PXkd6GLz23JPBxmsmaDoFIUHsmndpfnTvgY/wTS+FA8XAWz3q6GylsEVvS75hc
         pvw7VpJ0Jz7rTwX05aU8SpA+pVLackhWi81/I69irt/rglgkeBYzSjsAtLwDa20lIZib
         48RvdYeZX4Cw2ZJNR5h9qQLHLAwt8ryixzfmO259CNHXF3XD5F1EgHQcQ4V5GT2cDso9
         IdGBiTNP0xavNjIRfV/uTBPz7k1lpXMe35NbjL3wSw9ODGLSHSHivyNa9AmZ5b67e4IF
         ShEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784632905; x=1785237705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y2+LKseJXzKxktbUWoc1WNBTZXl1F3xYy2w48c5tdQY=;
        b=pUidpB662NSNonP8YNIJKh0y4DmePT0I0SbOAt/meHdK2V6SlrgfAPi2MlatHN2QGm
         H986n8uzx+bhNRz0F+YjVSU/dgE4QkCGfDyJDsr6XqC0vBip+WDb0wMlbzYoBlXGmJj7
         jv2c+Tul3BDMoRG52mBqHQzDF60L/SruCwU407PneLjMkddbJzPgZBUTKWvTKM2D/H9A
         b8a7ygyTxCVJ95HPV9pvGlk+sJmStEEFIoK8OoA5vPUd0D196Uch20klY9SFvJf9Lnxw
         ZW4MYUoYYveltABZo6m9FKy5QZqRtgZkaNtuMgBoPS9ftrvALjFhPk9FOroE5OaTIryC
         2luQ==
X-Forwarded-Encrypted: i=1; AHgh+RqGyu4Rmb1WrkYlH/94fwa+pD5FNiiqMydqul+ioeqzBDbqaQv/kUqsdJ5tdnrko+gFiFiLuOTOMBticA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxgfJapW7+akuY55PE6GyaS+HOxLJz7zHeFnXMrkV+28iyYKf14
	wpa7zsf8dO9T2w8fyCjEwHIFTH8lIC/hVOj+YNXQ7ZsupOTf2ileAqTV
X-Gm-Gg: AfdE7cnPfKmDN5e82sQbWjgsnUGN3MT2GrFEGO1ZiQ1SIEUFFs9H+HmdJK3dWbP/qgp
	nYLX85y45LtcpfSutXtPAsGIdhNv+TqGo7vFcqjNz28PZpgOoFqdLASdMKhFe3ffjC0wWxPxaPU
	kb9VE47yOzC0DFmk7GMFO0yHqHDNqAChjSkcksVBiip7ZOAH6ueG94qyGom15rBBihNjEheQ8xh
	sItChAKli4jrNXbYHqK6FvuXU4XCHsX1IfISo95H2oSdZRbRu9fEa2287tG16AS+jsA4mmg1wfr
	juLhAZn4XbOET3iA56FueGFdbSMXEcWcPn99Pp0m+y7PdRidAGEKqRSBrB4EOhkm3Bx1P9BllCl
	mtUTFQ63V0yDzKt0j/VCd+pWZikS+VGytHg0z0nLlX0t4L8L2EnXSsmO9+Pw/HbOPGpfZU8Qldc
	AkIb0h9h6IAeqo0xO9XE1ZiPBb2NRaPD11nxqonI0kCiro
X-Received: by 2002:a05:600c:4504:b0:493:c194:4e7a with SMTP id 5b1f17b1804b1-4954a3d09c8mr194922355e9.3.1784632904451;
        Tue, 21 Jul 2026 04:21:44 -0700 (PDT)
Received: from localhost.localdomain ([188.26.50.240])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-47f63e49ab8sm40232416f8f.5.2026.07.21.04.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 04:21:43 -0700 (PDT)
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
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-omap@vger.kernel.org,
	Mark Jackson <mpfj@newflow.co.uk>,
	Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>
Cc: daniel.baluta@nxp.com,
	simona.toaca@nxp.com,
	goledhruva@gmail.com,
	m-chawdhry@ti.com
Subject: [PATCH v3 0/4] dt-bindings: Convert TI TPS65217 to DT schema
Date: Tue, 21 Jul 2026 11:21:24 +0000
Message-ID: <20260721112133.70382-1-egbostina@gmail.com>
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

Changes in v3:
- Added 'unevaluatedProperties' to the 'charger' and 'pwrbutton' nodes.
- Renamed the example node to 'pmic@24' and added the rest of the
  properties and nodes to it.
- Dropped 'regulator-compatible' from the schema. The property is
  deprecated, so the regulator nodes are now named after the strings the
  driver matches on and the DTS is updated accordingly.

Link to v2:
https://lore.kernel.org/all/20260718215632.3295049-1-egbostina@gmail.com/

Eduard Bostina (4):
  ARM: dts: ti: am335x-guardian: Drop unused isink-en property
  ARM: dts: Rename the TPS65217 regulator nodes
  dt-bindings: input: Convert TI TPS65217 power button to DT schema
  dt-bindings: leds: backlight: Convert TPS65217 to DT schema

 .../bindings/input/ti,tps65217-pwrbutton.yaml |  42 +++++
 .../bindings/input/tps65218-pwrbutton.txt     |  30 ----
 .../bindings/leds/backlight/ti,tps65217.yaml  | 170 ++++++++++++++++++
 .../leds/backlight/tps65217-backlight.txt     |  27 ---
 .../boot/dts/ti/omap/am335x-bone-common.dtsi  |  14 +-
 .../arm/boot/dts/ti/omap/am335x-chilisom.dtsi |  14 +-
 arch/arm/boot/dts/ti/omap/am335x-guardian.dts |  17 +-
 arch/arm/boot/dts/ti/omap/am335x-nano.dts     |  14 +-
 .../dts/ti/omap/am335x-osd335x-common.dtsi    |  14 +-
 arch/arm/boot/dts/ti/omap/am335x-pepper.dts   |  14 +-
 arch/arm/boot/dts/ti/omap/am335x-shc.dts      |  31 +---
 arch/arm/boot/dts/ti/omap/am335x-sl50.dts     |  14 +-
 arch/arm/boot/dts/tps65217.dtsi               |  31 +---
 13 files changed, 275 insertions(+), 157 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/ti,tps65217-pwrbutton.yaml
 delete mode 100644 Documentation/devicetree/bindings/input/tps65218-pwrbutton.txt
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/ti,tps65217.yaml
 delete mode 100644 Documentation/devicetree/bindings/leds/backlight/tps65217-backlight.txt

-- 
2.43.0

