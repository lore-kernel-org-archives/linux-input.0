Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8321A5B90
	for <linux-input@vger.kernel.org>; Mon, 23 Feb 2026 06:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771828291; cv=none; b=fZBvmrDp9y7jb5r+kqqLvJ85Jw8QPXKOx8u89gZML3PT7y+bYTuaUp64rDIgCxoftrRcUiBikUts2gjnaZiG/GdpWSkwPPclt++l32+6J1ihFMGeKWJwFN2rNsG9K/sQLJrJiCCe9mBlOQ9iDOzAj4naQ7z4yvkQ5uvDT0Gpzlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771828291; c=relaxed/simple;
	bh=3JKhQ9beP6hoqU3EcKP3gop2A/k01QbGeVyTyZU4Hps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XW0tM2E+ekEgg8ByHPjKrJj72ZNnqqUNEuA8PlfIo6PblLGCeTQTIUEbqj8+QP/fcsTucwb+PwvCQWjuk4fNobyiBH1tt4V4B4jREmI+pOmYf6QPIi0hbrI6yXIb/vKV7AW5BuK+rr+nJgYcmkLfwzUt48M1rEQ8SVYT7AZxxSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YcZL5Uf/; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcZL5Uf/"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-59e5eaa491cso5253475e87.0
        for <linux-input@vger.kernel.org>; Sun, 22 Feb 2026 22:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771828288; x=1772433088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KdetahYQfYhDlhuTa9nYkHK4GpTIEKzr2ZQLLZ1gumA=;
        b=YcZL5Uf/RdWlESKhvLk8DiVdnvltEvqFRteLZ4HvEHDg+vnYBWeD+JSWAVyGpZzI+B
         H/DxLD3dVadaL1U/YnyumzrSylXgSe9j531mt5W1sVb/6bSwMcwynXhhIL2qkrFBOHYT
         vH31kcaO913KcrWDv2VYrFKdvqPV1s6LlrfAA3epfA1a8OWX/L9EELxIp/yd3d4XvYDO
         NfL50o/4quObmKqYepPIONHlrOlpC1xkmJALUb09+WVvDf+4AgleZ2iroe2S44PD4n7Z
         2TFeIrLljwOk9zy7C/isxk1Bqieth3doVWEnERvcRxNUQQZz0mlQRMqjwLiex4dLhsX1
         msWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771828288; x=1772433088;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KdetahYQfYhDlhuTa9nYkHK4GpTIEKzr2ZQLLZ1gumA=;
        b=MM8UAlCxjlW61X6144ep17PsrzWHLlmXL9YcwDtBNJ6DcREIx0qob/wkr5Oj1CPbEY
         vk+3L7vekanh5dxpg8TLGzvUIAT+5DWsLamjNWiw1jGxybzc38M1MkEW3iwLMTZeBMpE
         UvEeqnHCwOiUB8KVkkzp0qEHrwht727pz0Nf//aF8A3Sb/fpE90imPa0epwK3eB6l7Ox
         NXkE3BKeXI7TVyxCkJJ//bWyTLKbQLXqLSZpjZZmzr/+oP5hsFNCkSHxszvPYWs3fSKz
         KSQkwVxaVndpi8mKkVazCUsPGDTYHPqbQcorxjKhtbSFYKgrh0G4Wl74RkTmq1J4Vq7e
         skLA==
X-Forwarded-Encrypted: i=1; AJvYcCVm6gVAj9Rct8ds6j1zf6FEEonCj/abbkt6JYKoON91FCA5t2xveVom+9nrjJT3puQyOtEct9gQH6J5Gg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCOCwm0gyjg8VtiSixjwqPX15/tevili420LlL+X9Fh8hPjEfv
	TX3kE8aZP2BSXvx7TS1VQAm1DjZUOG1Uda+2Am/Jbwm8N+JLbyakoFXu
X-Gm-Gg: AZuq6aI15Mqzk0yI51NHaCGnBWiVrem19WmxzRd/gPGYhoTLps/PduJf4BXOoj+6Ald
	pdQNSpC5F7aJSKZOjHVf9Pb5+glMcKdAV9MI+J0cxN/Vy+9LLTk0aJpEEbKzEw5HVCl5brI7HHi
	0zRoGzSeuyEkcLa95sAoUCE3p6JWS1TB+rRmZFvPtzA1n7W+Wpye1jNMC6nH+z9C6mDb2PHRKUk
	qvGse4yycAE08nDg3Krm402LO5Q+8g2T+ETwMqQgMiNsVtFIHDNk7vwzWXcnefl+ryteQi2xoor
	SONVjesGpo6AsiB9EbBZ7y30VBwKvnjw1xhbrT+aIn3CWE42ejK354hO1z7M6Alr2xZIiznSnYX
	oIRviRbu0zE3m0m2Jsk/Qx32iod31PLU5650uiL/1V/8H9enr433ECQRnvcCmhQvqvF/BwDGZ1u
	JD18EwvoZdvDik
X-Received: by 2002:a05:6512:33d3:b0:59e:53c0:5413 with SMTP id 2adb3069b0e04-5a0ed87d8admr2321278e87.5.1771828288020;
        Sun, 22 Feb 2026 22:31:28 -0800 (PST)
Received: from xeon ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a0eeb14596sm1361320e87.26.2026.02.22.22.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 22:31:27 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Ion Agorria <ion@agorria.com>,
	=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v4 0/7] mfd: Add support for Asus Transformer embedded controller
Date: Mon, 23 Feb 2026 08:30:52 +0200
Message-ID: <20260223063059.11322-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for embedded controller used in Asus Transformers for
managing power and input functions.

---
Changes in v2:
- converted sysfs debug exports into debugfs
- added kernel-doc comments for exposed functions
- fixed minor typos and inconsistencies

Changes in v3:
- dropped DockRAM commits (both schema and driver)
- integrated DockRAM functionality directly into the controller driver
- EC schema moved to embedded controllers folder
- removed all cell descriptions from the schema
- removed all compatibles from the cell drivers
- adjusted naming conventions to better align with the ASUS Transformers
- defined EC variant sets to provide coverage for all known devices

Changes in v4:
- grouped known programming models of EC chronologically (both schema
  and driver)
- call debugfs init only if CONFIG_DEBUG_FS is enabled
---

Michał Mirosław (6):
  mfd: Add driver for ASUS Transformer embedded controller
  input: serio: Add driver for ASUS Transformer dock keyboard and
    touchpad
  input: keyboard: Add driver for ASUS Transformer dock multimedia keys
  leds: Add driver for ASUS Transformer LEDs
  power: supply: Add driver for ASUS Transformer battery
  power: supply: Add charger driver for Asus Transformers

Svyatoslav Ryhel (1):
  dt-bindings: embedded-controller: document ASUS Transformer EC

 .../asus,tf201-ec-pad.yaml                    | 105 +++
 drivers/input/keyboard/Kconfig                |  10 +
 drivers/input/keyboard/Makefile               |   1 +
 .../input/keyboard/asus-transformer-ec-keys.c | 272 +++++++
 drivers/input/serio/Kconfig                   |  15 +
 drivers/input/serio/Makefile                  |   1 +
 drivers/input/serio/asus-transformer-ec-kbc.c | 147 ++++
 drivers/leds/Kconfig                          |  11 +
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-asus-transformer-ec.c       |  79 ++
 drivers/mfd/Kconfig                           |  14 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/asus-transformer-ec.c             | 762 ++++++++++++++++++
 drivers/power/supply/Kconfig                  |  22 +
 drivers/power/supply/Makefile                 |   2 +
 .../supply/asus-transformer-ec-battery.c      | 272 +++++++
 .../supply/asus-transformer-ec-charger.c      | 193 +++++
 include/linux/mfd/asus-transformer-ec.h       | 162 ++++
 18 files changed, 2070 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/embedded-controller/asus,tf201-ec-pad.yaml
 create mode 100644 drivers/input/keyboard/asus-transformer-ec-keys.c
 create mode 100644 drivers/input/serio/asus-transformer-ec-kbc.c
 create mode 100644 drivers/leds/leds-asus-transformer-ec.c
 create mode 100644 drivers/mfd/asus-transformer-ec.c
 create mode 100644 drivers/power/supply/asus-transformer-ec-battery.c
 create mode 100644 drivers/power/supply/asus-transformer-ec-charger.c
 create mode 100644 include/linux/mfd/asus-transformer-ec.h

-- 
2.51.0

