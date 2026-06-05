Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9CD3AEF2E
	for <linux-input@vger.kernel.org>; Fri,  5 Jun 2026 07:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780643400; cv=none; b=Zk79TYsj6eEwC/HI2NMapJM5c1RX4Y0A1N/0opeXB6s3YIQxVjJ+2J+v0I7Az79Ms/lhRpPrhntrGeO0v5t37Bazc0wWoRbfn6kTsCOw4bxmGccg3uOfyQknp5idOIdhMJb08cNtCHHCjjgApuF0Jar6OsXyi5POlEd7WNuEfI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780643400; c=relaxed/simple;
	bh=kPxD2xqtkEPZer9DS0+UOtR3laxKhWE3HZkrB9dL9dc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pFzXQoR7/4orYbL7tZElmF1iYNuW19kDagVvnL3IzSOcBogxPdpZcb9W1deNdfmOBTSC/aSSe90Lk7yB2H9FIl/ttLmRU16TCsDixs7c4fv6thVXoItixTrIY85mY3Y3EgXWqcD29uGuRYcmDu1/kZynxCxgdOIhGnzAS4Q1rLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ly43ke4X; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ly43ke4X"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490be03d47bso12367045e9.0
        for <linux-input@vger.kernel.org>; Fri, 05 Jun 2026 00:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780643397; x=1781248197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6wf5wsEaBEbi7V4bTOA8WpiI2FMdMe2pmDS666iTnCU=;
        b=Ly43ke4XviqHTXK/jnR0h0KHE2lB/Ld3nsm23z6FVLSs1QHZ7V01Z/NjW+G3I5GXtF
         TIAd2rL2HA4DTZ3+sDScvWIb0bppJeuIi6vgZJWRBLnF42cPpFkVsJvocfAzRlVolYBU
         jUpxpHTUqGz14zNfVP1Yzf8Sv7ue+TQ1y+YEAdmYlEu6gA7BQWFVNYFaF5nQ3EF52ld4
         Os7KDbGORZDVEmgQ0UPZyNOo86EsBhoEI+xF8etZrrmqwGlDPAUk0jcce55uRBE37fAY
         e8RrsZ+naAjBtUK/DG3I1ZgaxmopuGHOg2NB68z7Frh9LtXBUBuArI/CYyEbo7uCbWuR
         FGnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780643397; x=1781248197;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6wf5wsEaBEbi7V4bTOA8WpiI2FMdMe2pmDS666iTnCU=;
        b=msmpPWeC5a09CuX/VBjBpLWONPv0SR4AW0JvYB3K/dBQ6Y98FHZ7qyOjDsH/mnsZam
         HLS850duzNFEiMDZwDeDtP6DCLrChlbjh7ptahtZZSB4i8u10Y5hUCEOjuP7MGKsfC0D
         X4VDj89AICVnbdPsGCOro+bv3kJBd8y/j//R8/qxLgRwGlX7SbukPIxy5+wN9w0qdZxH
         cXyNQ4FVYOP4L3jVpbYkEFapYA2paIBsDb5u2P9h72h7WkRAFb/hwl+ZFxE6q2iEp3JL
         RM6WgLJmUpLqlyZKsK66qOa15su8FcTpb6CcbMPhdmZ2c7qprCGPmszrqLqq//Z1wh46
         DJiQ==
X-Forwarded-Encrypted: i=1; AFNElJ9JrYuWcF4350F8BLhLRhK8zM8RLBFg57ZPCZrep4uxE6eMy8EG+44BqBJYur+lPlE6dOKHeJSUpjhtWw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFq0BsGvDRFKeuS0IaDWr36yxWglZMOdkfXmnaf6asBjaY1EbP
	Uy0T+8zTxf78uJN8UhTjTxDa1TZhPRJQswGRS70gkvy0GIjX2ry6m412
X-Gm-Gg: Acq92OFeiOILzqh59wVIddkSGoBS7OwrRexcb/r3jhF0MJ8lQBq+a/Ar3ff4Hl18/E5
	+YXtus2eoXN6tTkgYrEhYFS/NqMOMFLeKalyJBsyIP5CaKOb3EdNoHqXsk2UH8jhnFbMICyaDTU
	gh2NPKb+S48dgFIMCNJQASFzFWnS/AYlIGoYP34/TxPXHkwI473o73FYCRwd1l0qKILvOS2kvNR
	mEfnyszxNL+KvTSjuznQgLd7TxQ/ukFkUIkdcdU/+bw+IVbG6DII0TDNL/LGa+4Kcmsvy2g5f2K
	LAAAAjSA5sEkRqnnAFqTUfDrKPmhG02sEqn7TYqmxhyiBeH42Z0PtCoZDFZxz3a50ATNu2t2myr
	pbxjfgi1B7Ur6DRDRLziZP7C3NUUsz/OaAMK3Bo1ju65RxTyEibOPw32hlLL5+z+WBMp2QhWpbE
	EnlmqwztDKuagk//kz9XoZRN9Yt/ttaLOmcFFHzDmjvU94r4e8vfYrT7jj2vAVFYDylaHKq2rY4
	SUcK4pWG+SjjUcfXdllMg==
X-Received: by 2002:a05:600c:354a:b0:490:44eb:c1e5 with SMTP id 5b1f17b1804b1-490c2607c39mr29819615e9.31.1780643396855;
        Fri, 05 Jun 2026 00:09:56 -0700 (PDT)
Received: from localhost.localdomain (72.92.4.85.dynamic.cust.swisscom.net. [85.4.92.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcad5sm25132882f8f.5.2026.06.05.00.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 00:09:56 -0700 (PDT)
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Hans de Goede <hansg@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Andre Przywara <andre.przywara@arm.com>,
	Jun Yan <jerrysteve1101@gmail.com>,
	Lukas Schmid <lukas.schmid@netcube.li>,
	=?UTF-8?q?J=2E=20Neusch=C3=A4fer?= <j.ne@posteo.net>,
	Eric Biggers <ebiggers@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Luca Weiss <luca@lucaweiss.eu>,
	Sven Peter <sven@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: [PATCH v4 0/7] Add support for Baijie Helper A133 board
Date: Fri,  5 Jun 2026 09:09:14 +0200
Message-ID: <20260605070923.3045073-1-alexander.sverdlin@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Baijie Helper A133 board is a development board around Baijie A133 Core
SBC. Features:

- 1/2/4GiB LPDDR4 DRAM
- 8/16/32GiB eMMC
- AXP707 PMIC
- USB-C OTG port in peripheral mode (via onboard hub)
- 2 USB 2.0 ports
- MicroSD slot and on-board eMMC module
- Gigabit Ethernet
- Bluetooth
- WiFi

Add initial support for both the Helper and Core boards, including UART,
PMU, eMMC, USB, Ethernet, LRADC-connected buttons.

UART1 can only be used for Bluetooth module, but BT-WiFi combo Allwinner
AW869A chip has not mainline driver currently.

Link: https://szbaijie.com/index/product/product_detail.html?product_id=23&language=en

Changelog:
v4:
- reserve RAM for ATF
- sun4i-lradc-keys: Add A100/A133 compatible
- dt-bindings: renamed "Baijie Helper A133" -> "Baijie A133 HelperBoard"
- dt-bindings: renamed "baijie,helper-a133" -> "baijie,helperboard-a133"
- dt-bindings: introduced allwinner,sun50i-a100-lradc
- reserve RAM for ATF
- renamed "sun50i-a133-baijie-helper.dtb" -> "sun50i-a133-helperboard.dtb"
- added "model" property into root of sun50i-a133-helperboard-core.dtsi
- added "cap-mmc-highspeed" and "max-frequency" into &mmc2
- added "x-powers,drive-vbus-en" and "*-supply" into &axp803
- dropped all "regulator-enable-ramp-delay" properties
- replaced &reg_dcdc3 with a "polyphased" comment
- exact DRAM voltage in &reg_dcdc5
- disabled &reg_dcdc6 to avoid "[   31.710641] dcdc6: disabling"
- added &reg_vdd5v "root" regulator
- added "disable-wp" into &mmc0
- commented &usb_otg
- assigned usb1_vbus-supply in &usbphy
v3:
- added lradc node to sun50i-a100.dtsi
- enabled LRADC driver in arm64 defconfig
- added my copyrights into the newly introduced DTs
- all DT nodes sorted alphabetically
- all always-on regulators commented/propetly named
- all regulators got proper voltages (not default ranges)
- ADC-sensed buttons K1..K5 added
- re-labelled "eth_phy" -> "rgmii_phy"
- usbphy 0 switched from host into peripheral mode (downstream from an
  onboard hub)
- typo sun50i-a133-baije-core.dtsi -> sun50i-a133-baijie-core.dtsi
- https://lore.kernel.org/all/20260517234134.2737320-1-alexander.sverdlin@gmail.com/
v2:
- introduced baijie,helper-a133-core compatible for the Core (SoM) board
- https://lore.kernel.org/all/20260510201644.4143710-1-alexander.sverdlin@gmail.com/
v1:
- https://lore.kernel.org/all/20260503191842.2736130-1-alexander.sverdlin@gmail.com/

Alexander Sverdlin (7):
  arm64: defconfig: Enable Allwinner LRADC input driver
  dt-bindings: vendor-prefixes: Add Shenzhen Baijie Technology Co., Ltd.
  dt-bindings: arm: sunxi: Add Baijie HelperBoard A133 compatible
  dt-bindings: input: sun4i-lradc-keys: Add A100/A133 compatible
  arm64: dts: allwinner: a100: Add LRADC node
  arm64: dts: allwinner: a100: reserve RAM for ATF
  arm64: dts: allwinner: A133: add support for Baijie Helper A133 board

 .../devicetree/bindings/arm/sunxi.yaml        |   6 +
 .../input/allwinner,sun4i-a10-lradc-keys.yaml |   1 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm64/boot/dts/allwinner/Makefile        |   1 +
 .../arm64/boot/dts/allwinner/sun50i-a100.dtsi |  25 +++
 .../sun50i-a133-helperboard-core.dtsi         | 197 ++++++++++++++++++
 .../dts/allwinner/sun50i-a133-helperboard.dts | 148 +++++++++++++
 arch/arm64/configs/defconfig                  |   1 +
 8 files changed, 381 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a133-helperboard-core.dtsi
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a133-helperboard.dts

-- 
2.54.0

