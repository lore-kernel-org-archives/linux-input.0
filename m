Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.58.216
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795574556;
	b=ORHp0X4ARDr64vRdpMurlhZm799qx6HzadBBn6yp44i36H0NnMPDDXPA6hMGfZiTUC2t
	 bTUyEiwqESYYetIzvTNN3v2rn06m18SiWk+i+/t2z0atL1H9S49J2v9Bu9ALedY5s3YFM
	 uoN6yZ+uASKd/8t02LZ7Vv4l4Y8QvmK8oaWDr9l8uKTpLdJuNkISmJIa6fj7yQ+yQDmW7
	 eSU/YdPnAwbNvJBak8KIJUTq+btEykgjvVtHDV6fHFMprG0khI88IcTvUHZd/sgiP4F6P
	 0giZLNPvT+t/gINsqFqw7pFhspwz4sLPgCty0AzYFXYTo/LR3Ed1Wik5uIJGLdGgjBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795574556;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=lp0oHscFRzcaU+tigkhoLnkTa9Tl8okogNrxOKQol5E=;
	b=ZXdCRapPWoNkG1osiuF+k5bTGjwRBq2NlmuZv7u3i800pN4Ubdur5R78SXz+2OTOBQK4
	 kfXFdHih2b1Zy8FJSaAyfszO9gODlvTbxyuikYuhCOI9EaQuoo7W/OmEApRWfRG1oaz23
	 +F9TB7nT/JwiwrCez3jlw2JDBHm0mnzfnY2NaHtivGKSd0XeIwflnkHz1F6aU1zLNyRdH
	 WCkKfdV7yn1wWCEkClO1Uhp+LjVGZEgRhJ4sbw/MjJc7wuuBChYb0WbbAQiB0/kNgZdjO
	 W1N6VmZsxWpgpCtl1D/h5VZvWTyqKSiry+/A7kQTjK5pDC4ggdp26kSQL76cmAf3atg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=xv5n8o+7;
	arc=none smtp.remote-ip=162.62.58.216
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37959606A326;
	Wed, 25 Nov 2026 02:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37959606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=xv5n8o+7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795574549; bh=lp0oHscFRzcaU+tigkhoLnkTa9Tl8okogNrxOKQol5E=;
	h=From:To:Cc:Subject:Date;
	b=xv5n8o+78YUrfPz5d77NiEDiRaTJ5QvMlGnJZ7qtjsv/Anpz/LoXnvgoOAxC1kcgb
	 AChP4SwRochcrkSbrggi1632r3SJFFqV0KZCr57/n2eGf6wQhR9m6uR6jvKKLu4EYe
	 fo8STPjEHy4n05xLa3Bc/6XPfap2v7iDxJZiRCz0=
Received: from HF ([113.90.236.90])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id A9B394D4; Wed, 25 Nov 2026 10:42:27 +0800
X-QQ-mid: xmsmtpt1795574547tbybluce3
Message-ID: <tencent_2C38BE3108839F007E855001C6AF3E8CAC09@qq.com>
X-QQ-XMAILINFO: NhKbcYr69dwuCE11zu1dK8szOBK5LZCf/A3r6KsSRqvNDwjcHRxmHYe1VEz4x1
	 Cmmyp7JW0SNo8qs973wUtSMaoIOMlsp2sAH4BU5zrls4CB8owldVeNLN1Qsw9vGXr3mxKWCC8rm3
	 9U7a5iAIguQ5xw/akvdI5M6veeonVNNgeCgQ73WvI17l9UkOHpOgPsj1H3HmFSMuv8Nk+F2fCiC5
	 u3dm4FTgpQhti6E7bO6mno/ig3b9APT+3ZVhjllDJgoEGT46fW7HZjCI9MfhiEQdwcpR1MbRFxNm
	 3aDCMWLdwrtuiMjNBC2c+hvl2OWyZJ5NgBwy4OfhNqvGGw02aQZR1ZmAp1z88B3EOSkJZkz3Kqh6
	 rRivuwlurRlCgmy0gYdpBs/ya0yxhQoPeytLqifXzzpRCPt3rv5JRDrkHXQNh9qderkp5BOwzJDv
	 y8S/KBqu6bfBSWuuC53yaxLwYjXNGM1ZrQZ31j6e1s8LC1LHoAyS2QfYcd1UlnXkg7PWf68ka6JD
	 8/7lNejAAJ5ACpQqP+ohlvRAhwVNEqWuqnrsMqn6IXgYanL11xzesj+1DGGeMPYu6GbAqiD6nz44
	 avgk6k0o8OyTWqGISBVgLD2VCuR/uUA1aa82yNIiOzhbvOaCiWmrgM0/z/LT3nA26/CYizKl2CCr
	 bbaiig7YPeQxBmpLeE0fMp+1OzTHQCIFvZK4NgYIrH+mk6w5ytOq9VB9WLmf4JNNsphPZ00pGEay
	 knVfNGcvAr6lrRyExE/VyIDcca+Xggmhdp54xzj1xGBnFhKDTVq3Mgyb1NtVseJj4V3G9dPvPIO6
	 QtHUoEr0t4gBc2IfPChXmB4wMwjoZ3Bz/n9P9PgXfn2qc0TE7REtRqSPIqqFX8PW5NSMF9ve0n9Y
	 d7EeUw2qmdjWC3aZcbYs51ylcDw0WSFNP59gK+lizoxEnrpdFKjs1qmwxKYDH0xLRnKar9R+NbMs
	 x1r50uHQHGeT+kwQtPgMJSJvZVLGAXPA2GhTdbNj/labMDkRp07VgwOZmhdVi12Emxm8Xe/mbYlD
	 dRHQn0586tySWKQJeBaDxDYvZVHa6BQ63ndAZjxsDoae29Gjo1Cl37K4XMyOcNe6LL6xsaJvQEvf
	 wTt+0hP/raNYiwHHQ=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: Hefei <3066883572@qq.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	conor@kernel.org,
	Hefei <3066883572@qq.com>
Subject: [PATCH v4 0/6] Add VIEWE 7" JD9365TX MIPI-DSI panel support
Date: Wed, 25 Nov 2026 10:42:20 +0800
X-OQ-MSGID: <20261125024226.1293-1-3066883572@qq.com>
X-Mailer: git-send-email 2.55.0.windows.5
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

Hi,

This series adds support for the VIEWE 7KF82 7" 720x1280 in-cell MIPI-DSI
panel based on Jadard JD9365TX (2-lane video mode), plus the companion
I2C touchscreen and I2C backlight MCU used on the same FPC.

This is a different programming model from the existing JD9365DA driver
(panel-jadard-jd9365da-h3.c): page select uses 0xDE (not 0xE0), bring-up
uses 0xDF unlock, and lane config is via 0xCC rather than 0x80.

Tested on Raspberry Pi 4 and Raspberry Pi 5 with a downstream dtoverlay
(not included here):
  https://github.com/raspberrypi/linux/pull/7633

Changes in v4:
- register the viewe vendor prefix; rename schemas to match compatible
- panel: use devm_drm_panel_alloc; drop undocumented extra compatible;
  fix Kconfig/Makefile alphabetical order
- touch: probe-time hw init; fixed-slot reporting; optional reset-gpios;
  get_unaligned helpers; optional supplies in the binding
- backlight: parse default-brightness; sync HW at probe; SMBus write;
  BL_CORE_SUSPENDRESUME; unique backlight device name

Please prefer this v4 over earlier revisions.

Thanks,
Hefei

Hefei (6):
  dt-bindings: display: add VIEWE 7KF82 JD9365TX panel
  dt-bindings: input: add Jadard JD9365TX touchscreen
  dt-bindings: backlight: add VIEWE 7KF82 I2C backlight
  drm/panel: add VIEWE JD9365TX 7 inch DSI panel
  Input: add Jadard JD9365TX in-cell touchscreen driver
  backlight: add VIEWE 7KF82 I2C backlight driver

 .../bindings/display/panel/viewe,7kf82.yaml   |  67 ++++
 .../input/touchscreen/jadard,jd9365tx.yaml    |  63 ++++
 .../leds/backlight/viewe,7kf82-backlight.yaml |  46 +++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/gpu/drm/panel/Kconfig                 |  11 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-viewe-jd9365tx.c  | 340 +++++++++++++++++
 drivers/input/touchscreen/Kconfig             |  12 +
 drivers/input/touchscreen/Makefile            |   1 +
 drivers/input/touchscreen/jadard_jd9365tx.c   | 356 ++++++++++++++++++
 drivers/video/backlight/Kconfig               |   7 +
 drivers/video/backlight/Makefile              |   1 +
 drivers/video/backlight/viewe_bl_i2c.c        |  82 ++++
 13 files changed, 989 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/viewe,7kf82.yaml
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/jadard,jd9365tx.yaml
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/viewe,7kf82-backlight.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-viewe-jd9365tx.c
 create mode 100644 drivers/input/touchscreen/jadard_jd9365tx.c
 create mode 100644 drivers/video/backlight/viewe_bl_i2c.c

-- 
2.55.0.windows.5

