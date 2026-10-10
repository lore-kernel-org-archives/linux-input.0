Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEA721E097
	for <linux-input@vger.kernel.org>; Sat, 10 Oct 2026 14:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791643130; cv=none; b=ITAulfmYjj28EWs/IvwKMNxLKfQkpx7vwrUh/fmEWmb5eIxL5CV6FJ30fmZDrnRNv8d6BI9aTF/cbhFv3BzLbp1GqTDFxa2HvtfI7MUir/dCZeCcRSqcWe2ssDn+8GDALRNkUstalGNiSFi84HECZRl7OfNk9Fi9NqiMfosqYAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791643130; c=relaxed/simple;
	bh=XIR+F21hTFTrNd71D+I8BNEbEsbcq5OR1jCOUmmpFGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lp5um3P72B6cZXC9O/mLK94trVXg5gG87BueAlSc4PGbodHzdqFzxDVEIxMU0XC70JcR8Qg7BWd3EDPnaODJYAYT9aHplsYd2/xdU2hNIDdfFPd3IiiFOoL1bQpjQ8gYgINlA7mItfCfP679dy7etalo2y0qIqPNW+5WLTRm1T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F92XmAwm; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F92XmAwm"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cc147d86bebso266152a12.0
        for <linux-input@vger.kernel.org>; Sat, 10 Oct 2026 07:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791643128; x=1792247928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W4yObmjORIUS+HdWEYUQPrVnB688dbLM+egsRNt/fx4=;
        b=F92XmAwmtZn2Lh2CCa2mCJuL6bgJgXWSi68pzSJuTIiZTXQ6tHLKEtltsIxKvGIqVS
         1BSMeGF+KQpSNJFq7r0oRItJcJ7Bmpyv5HUYiFo+0bHLVGTRnpFc8T7KsdROJsuU2oJx
         FBSkmuP7a+Q0DapoXpa5PqaGTuGQ6Si3vpFS6NkNf3JMbvX4/fSdDGfjXrAZeXI6ZHG4
         57dtA7LWcCTjUP3YNRWDplzZXobQPtNthWF3PBd+oYjkKse5H7jeKT57IxE97cjc8DRw
         2MBtkLYGYKKQWaU7BgLf38F/l2w3UaQc+MJ2CkDEV9Vju3OXkzUPzr+m7VZZj8+DuYcl
         wCmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791643128; x=1792247928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W4yObmjORIUS+HdWEYUQPrVnB688dbLM+egsRNt/fx4=;
        b=CsPBJgT7wCy1zwnNSaEEFL/+HsLtir1TDHvjYfzQ500fpt2XQne/SaiU9SOWE47mZP
         2x0Ipl7X+TLFNHc1Dxz1SM0GGwVmhh81Z/UXZhh4yHDrWVpbZLyvQy15OykF86z+fqVF
         rL0HMRv8Lhq1mNOOubTurJPGVpOC8G8cQt8FddHUBEq4pVFF9yn/1dr/yxgr1RTW1NaC
         voB8Li9rF7AyXB7QkEvnljd4y527B8AFyVbG3PiG4Llt/xo7uJg+XM8eEiv9CMcfmHog
         oyIMzD62t5ac2mZnOnxbCgCd/SZOgUS8CVeJjW6HBGHrabWAzbK3LlA9Plnnbvaaqdgi
         eD+A==
X-Forwarded-Encrypted: i=1; AKwUvBwhXzjOUV+r5KM7LsuCkdcTb20ADEly24Bd3Ti0RZhjSmyWvg+smPFgkpMfNbk3DLUMzSp58xZspc7U1A==@vger.kernel.org
X-Gm-Message-State: AFq9FYJJcvx2tbhtkiLU76I7P/zilPiIbW4KM6jQJZ9sR1qwDJAd2AEI
	HYyLPqtoWogwRGjbgkvaiKC34GRupAoe+6SltwCsuGGXMzmM2CzyWuKe
X-Gm-Gg: AYBFou3J85RR665W8vVWC9KnKsiG+1cj16ZhRLo8YLv3IKGoXREM/7EN9/8ip0IcLNX
	IXyRszvqBe7EvPmbMmTo/ILa3i6nMgZh+lPSAgHHkw14wWL5yO7CBRLr+6yYc3zxfOyoLlPOLnG
	jKT0cceHvEnbrBJHYsSKyqb6mBy0OdZx9I23+6Ev09073ijiwF42A0aeIbWAwLkA8D2L/5Syuc0
	Y3kcP2ZLnhzNzCEkosp7vzI+uZuVeevGhzyyqj3TOilEVXKPbnoAijKy8h+5Vhs4kN+B3EHGl/5
	F5TkRKRtEQwBafvmHcI/01Eqt3+y8EdLKNB1nrnLXyoCJUxDGgwg7G+aZpfgaRsVjr6opqS9RHg
	8bt7Si/A1B+pibpqul+TeFS6d2gK0hctEtQEnr7mZ6YkHMilXw5obP08/J123XdR6uzNl8YCcF7
	7bvJYIy+/vpaDH/kvl8MFe9JzyuXf068JEmpv2Ac8zTSQgKHYdrko/VyPos/HX9DI7OY9O
X-Received: by 2002:a17:90a:d44d:b0:39b:5622:d645 with SMTP id 98e67ed59e1d1-3ab3a09d2e0mr3194676a91.0.1791643128050;
        Sat, 10 Oct 2026 07:38:48 -0700 (PDT)
Received: from wyb-ms7e59 ([38.55.195.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab38f2f866sm10821859a91.10.2026.10.10.07.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 07:38:47 -0700 (PDT)
From: wyibo6109@gmail.com
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yibo Wang <wyibo6109@gmail.com>
Subject: [PATCH v2 0/2] Input: add support for OnePlus/OPPO Pad pogo-pin keyboards
Date: Sat, 10 Oct 2026 09:38:34 -0500
Message-ID: <20261010143836.173883-1-wyibo6109@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009122046.551915-1-wyibo6109@gmail.com>
References: <20261009122046.551915-1-wyibo6109@gmail.com>
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

Patch 1 adds the DT binding for the "oneplus,pogo-keyboard" device,
describing the supply, TX-gate and wake GPIOs, with a MAINTAINERS entry.

Patch 2 adds the driver: keyboard matrix, touchpad, function and URL
keys, caps-lock LED, attach detection through the wake GPIO plus a
100 ms heartbeat timeout, and the keyboard backlight as a
"pogo-keyboard::kbd_backlight" LED class device so UPower and the
desktop keyboard-backlight controls drive it through the standard
interface (the level is cached while detached and restored on
re-attach).  A sysfs battery level is exported for the keyboards that
carry a battery.

Changes in v2, addressing Krzysztof Kozlowski's review of the binding:

- dropped the redundant "binding" from the dt-bindings subject;

- replaced the custom oneplus,touchpad-xy-max/-resolution properties
  with the common touchscreen properties touchscreen-size-x/y and
  touchscreen-x-mm/y-mm, parsed with touchscreen_parse_properties() in
  the driver: the MCU protocol has no way to query the touchpad
  geometry and the same MCU is shipped in keyboards with different
  touchpad matrices, so the geometry stays in DT but uses the common
  schema instead of vendor properties;

- dropped the serial wrapper node from the binding example;

- the MAINTAINERS entry added with the binding references only the
  binding file; the driver F: line is added together with the driver
  patch.

Tested on the OnePlus Pad 4 (iceland) running Linux 7.2.0-sm8850
(v7.2-based iceland tree).

Yibo Wang (2):
  dt-bindings: input: add OnePlus pogo-pin keyboard
  Input: add OnePlus/OPPO Pad pogo-pin keyboard serdev driver

 .../bindings/input/oneplus,pogo-keyboard.yaml |   66 +
 MAINTAINERS                                   |    7 +
 drivers/input/keyboard/Kconfig                |   13 +
 drivers/input/keyboard/Makefile               |    1 +
 drivers/input/keyboard/oneplus-pogo-kbd.c     | 1196 +++++++++++++++++
 5 files changed, 1283 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/oneplus,pogo-keyboard.yaml
 create mode 100644 drivers/input/keyboard/oneplus-pogo-kbd.c

-- 
2.53.0

