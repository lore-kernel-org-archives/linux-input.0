Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795853922;
	b=qDGoz2Wg8QyUlRi+FbE0UGrKytEM19MuFNLMRxJZlQMaqexO8jpUy0pGMv5/XIk7RJHS
	 Jk17K7vdk/+kJ5J5hW2NNCGb03vd9ZHZ0EWTRdyULvOMqcMDhHaTbkh/fVtz0UjKaVovQ
	 H5N9nPWWcRSn2iF9+32i0YqdAwIHHYaQ57tgjO884WzdmJptRJw+Neyl3CBczAon03gm2
	 2xjn3I85OzfMaj3KnEcld4elAfBp9zQNCylQJEAYmM/Lobwve0laCPdh0n/AjnUlI46dj
	 Htbw6bou5fw4Ssz+OuAHHHitEySOM+u9hDNOPygfRtYKndWaQO6SXkYr2pZOHE4dI3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795853922;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5e4yoQg/j5YEK37mURWiQZOmG6BYjI+8fHMt09fqOkc=;
	b=S0g7CyDTjLtHomVp/tXPM6xX+cAjT9SNwoFXKJTxj0EyKHTnhZEj/H4piyq7ShD1gHov
	 +WfPp8vWmpOhzy8nsK1cjdLo7FbUL4UC4tnnn5yUpJH7NOaq4VmE70kP4kwkEfxGRB+J6
	 tVXMGvr0HbLU3OPeHULZwRUIy5FCpc2s3JBOFnAq9uhPLBNM+Ndz4P8mb414Dnw86SPMA
	 VaWTbq4LJtTIj3vqAnMkDWVpXSjD+5LTfP09PFXp7iL/OU2O8m7TOPYT7wj6pBSE4iczc
	 arzgKFEfnoW3M+zQKrsA/Dy645Va0cCCkxplY580oOUER/QvkrAkeya7MWVS4sJWdtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fFhTpdvx;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD958606A31C
	for <linux-input@vger.kernel.org>; Sat, 28 Nov 2026 08:18:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD958606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fFhTpdvx
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cdece95eca4so600089a12.1
        for <linux-input@vger.kernel.org>; Sat, 28 Nov 2026 00:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795853921; x=1796458721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5e4yoQg/j5YEK37mURWiQZOmG6BYjI+8fHMt09fqOkc=;
        b=fFhTpdvx69cx1gGTuyGtkSu1a0AWHqAQ1SkmO2HlmsRBSUo1gogSl7HkruAQ11EwXe
         Am+MxBhey9wa7Ji7Z84J5S3W0RCrYkVulKMoMeLoRu68IwL3HF23ZUHKYzasTn6ycx9f
         uu53FPDcff0arDYFVBW+1AWhILAkOxGdzUYK/iTF5EEDwkk8U5wtdfu9cvuuOLp6NGf5
         vQ44W/a7lxD8ECJJ+2c7i8tGR5up/L96ZL2+6Ck+6+jws+/fdMVNLtDI7wpxQQozmlSA
         /QB0/QLK90nMTEvlZuJMiCerb1qhvXmy+wKXmpngHrH061SGJRvmX61Tt9aI8kLMBN+8
         ZA2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795853921; x=1796458721;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5e4yoQg/j5YEK37mURWiQZOmG6BYjI+8fHMt09fqOkc=;
        b=wRQEyixIXxYv4vNOn3+RZ0eTED42AllrxZSAm4A46Jj1JimCwXq06+YIxAVUIxQ2cm
         SuH2GOh7DMCQPe7oCCbjEDMMi0TkS7YqGmAMaTk2i90wwjkmZS/WPbwQQQfeqtG7c2wd
         i1IMN00p8zHDbTfwC104vE3hJWU3p3HzCNksWuRTElWD7rBRNSUKr8vV5zOrx/TChwOy
         YwQo1sBi40Z5ngx4L1SKJ4HC1x07jQAKN9NbNMgMM+k0cZIeKE6DmhOAPOrT8hk9FfHu
         q6hUzGcMfxdFqq2RMKRnoDcRFLl20ALgURBnyjn/zEgvpDuKuPQmIuipbgof+zvWqLqr
         repQ==
X-Forwarded-Encrypted: i=1; AL+hErEhaOqxM0VQf5DUOdE+2QNqhM/kNBqdPafYGv5g68x3nEpNqGTlxONUdClGfzTTOTd0N6Bh6iov8HdXfg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8F7FmZCiPYGQ83Zgdg21D7Q/Fe2DTxohZHTKHuBivOaEG5meXg
	vfD2ixDLkxzZdwtJkBjW3rhCAsghyAYIhPpOUrUVHtQKc6bjwp4pwcGU
X-Gm-Gg: AZFdTZf4st6jD0F1/Xpzb/XQNEZAeNqksTvWmNOWcihOVCR9geJp7ZcbqAcEcDg6BWP
	sXXmNxfvEfsQKIyot7+Q1y3EOYfF1HvZthcuL9Qgs2ULcoLVu+z2gfexpHb60uyksuhpnPt3n6q
	TLeA+rmbJtXpoU/l5jBlwPA4QWUviQVq0ncsTOwl5KOtJpsMf+16Yr3d1W5dBCHRnE9Z+zczJpV
	jGG/IM/R/8Z/oXq3SxTvEzUl3MRvgGdsznXdJvnMLnJ/VQsoo8Uv6541d2566RJfcLYTngDOxmS
	ld3/7npWH0zfeaqU1Z0eg6uG946NTw8NBSbRN/BmXwNCthw/YNQYl2HKy+PsrHbPY2MvsxzIhrl
	/VEPmN+aqiRr7JpnCbm+ZsyIcK/n4wn3PHXXfmaC1rGGlvIaeIfXGSv22hTRMIuKeo5XLEj7r46
	wopcVWVCK6tYXPySa+Ev3wjYnfsjn/XhP4QMaX6UFZStyTf7FvVuOCURZCjbmKI4V0J0drH7qs5
	EzMALsTDW82MkUsONdVf2VeT1XCvj1mhyUk2ulTSzR9AIuF5LzlAIPZOyr5OVV9Qz63b6slp9So
	iR1wIg==
X-Received: by 2002:a17:90b:224e:b0:3a0:d265:3647 with SMTP id 98e67ed59e1d1-3b41c7d6084mr24828076a91.8.1795853921157;
        Sat, 28 Nov 2026 00:18:41 -0800 (PST)
Received: from wyb-ms7e59 ([2001:df1:7880:4::50a])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde7f91c6f5sm11550749a12.27.2026.11.28.00.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 00:18:40 -0800 (PST)
From: wyibo6109@gmail.com
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yibo Wang <wyibo6109@gmail.com>
Subject: [PATCH v7 0/2] Input: add support for OnePlus/OPPO Pad pogo-pin keyboards
Date: Sat, 28 Nov 2026 02:18:33 -0600
Message-ID: <20261128081835.366128-1-wyibo6109@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Changes in v7, addressing Krzysztof Kozlowski's comments:

- dropped the touchscreen size/mm properties from the binding as
  agreed: the touchpad geometry is per-project driver data and neither
  the binding documents it nor the driver parses it from DT;

- moved the MAINTAINERS entry to its alphabetical place, after
  ONENAND;

- the disclosure prose now says LLM.

Changes in v6:

- disclose the AI assistance in preparing the binding documentation
  with an Assisted-by trailer; no functional change.

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

The binding documentation was prepared with the assistance of an LLM;
the technical content was reviewed, adjusted and validated by the
author.

Assisted-by: Z.ai:GLM-5.3

Yibo Wang (2):
  dt-bindings: input: add OnePlus pogo-pin keyboard
  Input: add OnePlus/OPPO Pad pogo-pin keyboard serdev driver

 .../bindings/input/oneplus,pogo-keyboard.yaml |   70 ++
 MAINTAINERS                                   |    7 +
 drivers/input/keyboard/Kconfig                |   13 +
 drivers/input/keyboard/Makefile               |    1 +
 drivers/input/keyboard/oneplus-pogo-kbd.c     | 1251 ++++++++++++++++++++
 5 files changed, 1342 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/oneplus,pogo-keyboard.yaml
 create mode 100644 drivers/input/keyboard/oneplus-pogo-kbd.c

-- 
2.53.0

