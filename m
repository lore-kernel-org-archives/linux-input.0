Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794559743;
	b=dxSP2TuKthjD3Kb16+i65U60/k6D+i+bdaGqPe7xPQ8wyc6PN/nZ1SuSuL0vzaNT0YVa
	 5NVOhKVe5PEetCa+XbF6iAx3m5PKl7M7MtO0gyABTr3AQ0yBZ9917t22zAHthqf2zAwyS
	 d5r2vmZL16EiRarTUvWmHvRXY3wP5xlUnB5vLlu1M5P/arOaSHqe50S7aocw50y+4Y0vq
	 O7pM2p07Gg39FfnqaBaQ2+jYCRbJfJToAEdnNUV2Xgxl+Z1APy/RR3Zw5AN3fO43oLtq/
	 cm4I05OV2YYX6/g3nV/tOKk2aNvRfXCWD3RcVYhpsC1UwcwpYJpZB81enFAeELmr/FQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794559743;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qx6anf3hBdJB8SU0X3cTGKNeyaZPKU1W0S8sS4JiQgM=;
	b=f5438F/tMl/i/XahpsnBpJ9ThQfUaxOrZSA8w0QVdgBJezoURmav8ozQVtNOKOkI9MtE
	 i5V9VnOE6DCNZmKolaXu6P3ZxqNqDgutSGpE3u2fc7iMNQkjpGl3oLcAu3k7OPII+5wv2
	 1mUPSaBw9URVY3SxAmGfAJ5hrMvDtNnaUEbmvbGelPib3EJSjDl4epotTQeqiTpUJd2N8
	 fiHfIyyBBLWaHRjNCSiJVz//2dq5sUrEIJoRDfiK23GjncFjYsMoA0aqkNM3+Ot4oMDDj
	 xwL8ueKZ9rxGIcpEU13y52vMgi3freYknemZGIgJ2OTaNJ/zdb6oE6tTSztLzDtE6Og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uXbDGLQb;
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEC1606A323
	for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 08:49:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DEC1606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uXbDGLQb
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8b271e573adso464941b3a.2
        for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 00:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794559742; x=1795164542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qx6anf3hBdJB8SU0X3cTGKNeyaZPKU1W0S8sS4JiQgM=;
        b=uXbDGLQbF0w26QAw6MJrM+Gn/WE9SHb8OtRQkAj9lO266801X+jv0LVPreBz6oz94a
         B92xhj2j1To789uEuSuRZKr3zzsuxMeBmH0dbBnMJnT54gk68b70J1d5rKe7c45aS80R
         Hg7JVCq2OYsF4ORvO93oQGyjExlaRb9HVQBZGLLvF94c9QBrEFXVB16EPcRyrXIxKm31
         vh50ZnIGEI+CSKCCOrTQezfbF6rb160F8KYZoNI3fcxRDUz8kQ0PqGfhBB5JkUnV3buX
         j/5Gy7hNjzBDPzunZypx2PLkuIroU/j8E+codgCOSinm05fSiidcjrrlDIOKtWVWFv2U
         gq6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794559742; x=1795164542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qx6anf3hBdJB8SU0X3cTGKNeyaZPKU1W0S8sS4JiQgM=;
        b=Hy2w0N33Xy1CZl6sA8JUC5WeO2DkNHOTIu5mobYbG7gM1zzm3OXW9kgYzH+SrcsTXx
         5hVibd3h93pS0unlReme/bH9ygfn0ZOqf8a6XmfHzVxCSD0umVERtXSHgCI/Cw71kTyU
         wFv2RkgksChcY+T5en6DHAqHS0CErwHoe0YhJznmg0tAAEtyy8ayY0wMTSG/3h8MJDt+
         nyfuH0futar+Ol1h3E31jSY+YZHvgHuCOMdQp7rqBIERlrPcXlgacy3cPHt2MTmq5oTY
         fDs/s6fxl1W9rL1dCW8S2xbuUrEeHW2e6wbI1OOUQnH9qwmsind8HjDk6P7Ryjr49V0W
         xCDA==
X-Forwarded-Encrypted: i=1; AL+hErH6yUtbTd9JgCl5sCihIWCGHSnxcK/wTzUzrQrOPetgVHLvAkGWh5Lx6tXc50egyvkqRv/nLcGkLLVadw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8sP8DUpIfh6jIdu1n9/57boQ8jdaaA8njinb58w5urYY62XKr/
	1JpDmJLM0ME9DONgR7x/AnjasduNjBpOECcJQJiFrDdzYeDQ7v+KoRmD
X-Gm-Gg: AYBFou237qrU2L7Fb20x2GknAIQF071jcWjfc0dli4nrcX0HWrizEIQvBRJiWA+hWgq
	RD5ewT3lj6sDp5jgjMqirZB6Rx6rsM0kR/lkLg09lmPtILgBnPvJBHWN/rZ1bEhbCRVFGcqb9ah
	bQe2H0CXtbyKpdfNc5zpzvhan2nlXK5vagEGkChzxtb7XIogxeeTMKT1O/mxF/GniyJVhIAGKXz
	3oHcO/JTF5EBi/8oEzDrgkr2kTakupAy8moS+fmuf1fnXfCjSK6CQYI8EaRuxjVRVxKJnq7cMkH
	4kjG8lPEtALNaNfBLKQD0wWCZcBc8dXQPhF//qUH2pLar4QBvvSrhkU7Glbnv+t2MNuW/nSDsMB
	1vllqSCGqg6/7moWAIacBnhOpgAWtLvZVdFDfLkfPJe9q4un5RlQFMv/NwV1rTx4kxIstDVkHz6
	0Ls1PPC2kWYof771VSsRrwB1tSyF6PYLDsFRQOOJLInXz0SKwcYFp64ideoLg59cL62xJYH2SLk
	jBmaS4bN4FMdpMPH1laxTXPd7CwpSEgGp3Vpd0dJrhXum0aBb3HzT0GgucikBB+0Qo+TNUmWn8z
	0Jn2tTVJf6IzfhxH2swCK/PJ2dHNoKntQHuCjRcgmLA0J6eGtLv5Y2fHyj6ESozjmFKDaD1oq4x
	+ixwf
X-Received: by 2002:a05:6a20:a11c:b0:3e0:eae8:7525 with SMTP id adf61e73a8af0-3f7a8bd20camr1630922637.64.1794559742523;
        Fri, 13 Nov 2026 00:49:02 -0800 (PST)
Received: from fyhsueh.. (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bececcce76sm742540b3a.5.2026.11.13.00.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 00:49:02 -0800 (PST)
From: Feng-Yi Hsueh <fyhsueh4linux@gmail.com>
To: dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: ychuang3@nuvoton.com,
	schung@nuvoton.com,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Add Nuvoton MA35D1 keypad controller support
Date: Fri, 13 Nov 2026 16:48:50 +0800
Message-ID: <20261113084852.32727-1-fyhsueh4linux@gmail.com>
X-Mailer: git-send-email 2.43.0
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

The Nuvoton MA35D1 SoC provides a hardware matrix keypad
controller supporting up to eight rows and eight columns.

This series adds the Device Tree binding and input driver
for key press/release events, clock management, and system
suspend/resume support.

Tested on a Nuvoton MA35D1 board with a 4x1 keypad
configuration and a 1 MHz KPI clock using evtest.

Feng-Yi Hsueh (2):
  dt-bindings: input: Add Nuvoton MA35D1 keypad controller
  Input: keyboard: Add Nuvoton MA35D1 keypad driver

---
Changes since v1:
  - dt-bindings: add optional resets and reference input.yaml.
  - dt-bindings: fix interrupt, clock, and keymap formatting.
  - input: use guard(mutex) in suspend/resume callbacks.
  - input: rename error variables from ret to error and
    explicitly return 0 on successful resume.
  - input: remove the unnecessary linux/mod_devicetable.h include.

 .../bindings/input/nuvoton,ma35d1-keypad.yaml |  75 ++++
 drivers/input/keyboard/Kconfig                |  11 +
 drivers/input/keyboard/Makefile               |   1 +
 drivers/input/keyboard/ma35d1_keypad.c        | 407 ++++++++++++++++++
 4 files changed, 494 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/nuvoton,ma35d1-keypad.yaml
 create mode 100644 drivers/input/keyboard/ma35d1_keypad.c

-- 
2.43.0

