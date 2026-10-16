Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78304A2E3C
	for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 12:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792154044; cv=none; b=jqRlruWLvnD57yyDq22P7LOXqHQDaN2zLmACyH9gyU2keuYcVUqgX1nHIlIHHXRzpERVxfjxigSgCFM2SenY5PKBpyiFOtmjDTmKjmQBOaFH4FkGqt+nVHAqor6/N6ZTpYgG1W76Imw8tE3N7E1p5oduS/l2c614rT/6JNCdFiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792154044; c=relaxed/simple;
	bh=1vU3NCxLFVHdnJywnJQnG9sCBBB2oPGI2MFppoXSbZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JWZtq6MVOOeb/RCpbkYqbYmL09j8kPD+lusZtZfvxQfyG490+NsfH+Lr1eK/brxVuAF7JflWBNHL4MHfel69lkpIyxLx93bJkHVuMmVVToleYt/KPwwa403Y2UwZ2GXeWKCsT6ChQ1VQM82cc97nd0K3WZnqVDRjIGw4o8BgCXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CbMAiZwt; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbMAiZwt"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d6e954afbdso15174635ad.2
        for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 05:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792154041; x=1792758841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eTy4IXuSvKSJKpenSSv/dDuZ3Ab3mm4pLG3Vp1dvcio=;
        b=CbMAiZwt2qZ/kFiAfH8MATg5kBZNGjVbYTBuixuTHvY6LCnJu6UQYiHDspjyDFg2re
         6C3gEbkub3FwW/6SRSbi/IogaOzi10965TJ+Nibg7Pd1M1pddQX5Zkhpc47jqA6brpXg
         fBY0r5pH8SnNJP4cLYeboAnNpBfVpQACTyGFs6SZaJrsSixfqaSEwhacc7VLgUE6QrwL
         RQI2TfjJgzCeefd4xbG/1tWeuViY9gqRLCQUE4fjTQAlGbZfO/b6FIfuBD+2n5vXRlAW
         tMahX79MmC8jRPfizRpv5r7npUgdvxvSGUiXDot/BAQjuNoJ7NOqy79Rd26uct3Cltw6
         1d7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792154041; x=1792758841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eTy4IXuSvKSJKpenSSv/dDuZ3Ab3mm4pLG3Vp1dvcio=;
        b=LvR5Z6FzTid+DDhbNCW3UEIY1CLsVxq8cdI8W1uUR+53WTa0NXxJyWgPd1aibyMhR5
         bW+RTzJJxfDtQYoON+p37c8O1EVVftWpxbip6PuuM3X1N3GcMnJpxuL+78Mw64JePoEs
         gvl6YsKZLKg6nbivfEvMH45sw5gKx5c1wbCIdfHA8lNp7RhG+S2doRe8v80RwFPeOJbN
         8IZu63n0FEKUWZjKhBlG2ALKQPqh8GL0G4qO3IhGsWODTvQ3rWN0q70QalmN8NN8tBqt
         33z+aT4AfafzaWIxe8EkEzl+3enM7SF7/ojohnRPZuxnPi0P3QrjwOlXwQ+LfViEziKG
         lxqQ==
X-Forwarded-Encrypted: i=1; AKwUvBw4ozSg74HlFnbx6f9FZg5tcvLqi3l8PJYtrVd+ofZnFt02c2U7PN4H8gTr2kxNJ2vm0aJM3lTN5Eyaag==@vger.kernel.org
X-Gm-Message-State: AFq9FYLJ6LC9nVxdDrpuQfeUFq56P9ThsCRxLjgD1WTA+1AEAV8Gd0x5
	kb3XvInbRfzkDa39+FHXBf5PdSVCDcjE1XbwCYQOEE2405lgsX4xb4j+XZihnn8QN1w=
X-Gm-Gg: AYBFou11TsWBxJ00G+W0LBWxk8qEsNG1MbC8/IKJWpO2XayepenHkwbSJPOLe2Jz+L6
	49diexbOwFDQKfGoJ/2KCj3WhJw+IUGi5zYrbkQzRw5kgHTP+0e5P8hruJS+sxI8tR5dVG485y5
	GrRS60G3kA7RhH0PIaPpSAwjfddQ2V/VVGLzaaTiNWR7gFOqD6l5UUuTG50sz4EWJeWLbZcUShv
	VYtlh3gXbYKUjsk3G7/NT7HbuLyzbhgPI1G2vpbxYd0VWyp/Z+0yAsoqKcpGWbPsQsuaQGJZ1Il
	RUV0QcH29Uk0VzXNbYWCqedO3hw5NB9N0zARwg1XXuTayQ2yuCNyfbm8dF0ftNiL6Y/9eCeNBs+
	XOt1vEXmgf95gMYhB7sWJp1fjdlQpWc6yyq6/DyJNG3DgcoBdHWIi4n4u1qjQqwnRBZklmIcEXH
	t8rvHz20Lju/ZwzCeA60HK+1iGPwRs8c4mRMNKkPypduN+rIxhD7NMNyHGsNUZTZN2pvM=
X-Received: by 2002:a17:902:e801:b0:2e9:99cc:154d with SMTP id d9443c01a7336-2e999cc18cfmr9568805ad.41.1792154040732;
        Fri, 16 Oct 2026 05:34:00 -0700 (PDT)
Received: from wyb-ms7e59 ([38.55.195.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e87993esm9286735ad.59.2026.10.16.05.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 05:34:00 -0700 (PDT)
From: wyibo6109@gmail.com
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yibo Wang <wyibo6109@gmail.com>
Subject: [PATCH v5 0/2] Input: add support for OnePlus/OPPO Pad pogo-pin keyboards
Date: Fri, 16 Oct 2026 07:33:32 -0500
Message-ID: <20261016123334.1019257-1-wyibo6109@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015110859.203989-1-wyibo6109@gmail.com>
References: <20261015110859.203989-1-wyibo6109@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yibo Wang <wyibo6109@gmail.com>

This series adds support for the magnetic pogo-pin smart keyboards of
the OnePlus Pad 3 Pro / Pad 4 and the OPPO Pad 5 Pro.  The keyboard is
built around a Tinno MCU attached to a tablet UART.  Both sides share a
single data wire, so the host gates its transmission onto the bus with a
PMIC GPIO for the duration of a frame, and every host frame is echoed
back on RX.

The MCU speaks a framed "one wire bus" protocol over the half-duplex
921600 8N1 UART: 8x 0x55 preamble, 0xF1, src/dst addresses, command,
length, payload, CRC16-IBM (poly 0x8005, init 0xC596), 0xFE and 4x 0xAA.
The protocol was reverse engineered from the vendor kernel driver; this
is a clean-room serdev reimplementation that replaces the downstream
platform driver, which depends on a private msm_geni_serial callback and
a user-space held tty fd.

The core protocol (framing, keys, touchpad, sync/heartbeat) has been
carried unchanged across four SoC generations of these keyboards, from
the sm8550 era to the sm8850 ones covered here; only the 0x3A general
sub-commands grew over time.  Patch 1 adds the DT binding, patch 2 the
driver.

Changes in v5, addressing Rob Herring's comments on the binding:

- dropped the block scalar from the top-level description;

- rewrapped the descriptions to stay within 75 columns;

- restored the serial parent node in the example.

Changes in v4, after Krzysztof Kozlowski's comment that the binding
describes the keyboard rather than the MCU (wording only, no functional
change):

- the binding description and the commit messages now describe the
  keyboard (built around the Tinno MCU) instead of the MCU itself, and
  spell out that a keyboard is a fixed physical device, so the touchpad
  geometry and the product names are per-compatible constants in the
  driver.

Changes in v3:

- the compatible names the tablet project the pogo port belongs to
  (oneplus,caihong- / erhai- / iceland-pogo-keyboard, the codenames
  used by the vendor trees), and the driver carries a per-project
  description in the OF match data: feature flags gate each 0x3A
  general sub-command (caihong, sm8650 era, has no wake notification
  and no backlight; erhai, sm8750 era, adds the wake notification;
  iceland, sm8850 era, adds the keyboard backlight), while the touchpad
  geometry and the per-brand product names are per-project constants -
  the wake notification is skipped and the backlight LED only
  registered where supported;

- the touchpad geometry and product names are no longer DT properties:
  they are fixed per project and live in the driver; the common
  touchscreen properties (touchscreen-size-x/y, touchscreen-x-mm/y-mm)
  remain as an optional override, parsed with
  touchscreen_parse_properties(), for the unlikely case of a variant.

Changes in v2:

- dropped the redundant "binding" from the dt-bindings subject;

- replaced the custom oneplus,touchpad-xy-max/-resolution properties
  with the common touchscreen properties;

- dropped the serial wrapper node from the binding example;

- the MAINTAINERS entry added with the binding references only the
  binding file; the driver F: line is added together with the driver
  patch.

Tested on the OnePlus Pad 4 (iceland) running Linux 7.2.0-sm8850
(v7.2-based iceland tree).

Yibo Wang (2):
  dt-bindings: input: add OnePlus pogo-pin keyboard
  Input: add OnePlus/OPPO Pad pogo-pin keyboard serdev driver

 .../bindings/input/oneplus,pogo-keyboard.yaml |   76 +
 MAINTAINERS                                   |    7 +
 drivers/input/keyboard/Kconfig                |   13 +
 drivers/input/keyboard/Makefile               |    1 +
 drivers/input/keyboard/oneplus-pogo-kbd.c     | 1263 +++++++++++++++++
 5 files changed, 1360 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/oneplus,pogo-keyboard.yaml
 create mode 100644 drivers/input/keyboard/oneplus-pogo-kbd.c

-- 
2.53.0

