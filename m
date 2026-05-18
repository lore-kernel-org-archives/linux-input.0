Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57601381AF0
	for <linux-input@vger.kernel.org>; Mon, 18 May 2026 09:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779098378; cv=none; b=fEg5yjiRP6FOHBIsrnjgOogx/4cAl9heSQCmroEOq5akJVI/mzraZ967KbtiOEU5qOJIhWwOLwKahAfPHgDSHnja8gdxyz0MNxDwqJi+ecni1g75yVNeDpA0RigRGHmpH6rTem7A71UGsVYnqziUD7UxxzsI7Pzk6S5Hv/8CQw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779098378; c=relaxed/simple;
	bh=esAbANfm0QoNyiPBFvmZqDjUGYZ/B+s4N5Ry/JqlxMs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n0dyaNe/qWLczdwnRauU6pCVpRe5tQ7FFAdXy5whA6J1INqL9L8iTys3YP1+HeA/L9xgO9rxDQI8QCfY5vmwvsB/J0IX2+WXZFXKq2xcpXVRSBmJGxv0qtdFPgn6TDq/OA0rXzwQ4I28SUvSxfg+g+SsaeN0gBrQbPtsjbp+Ar4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ua595WSi; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ua595WSi"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488b0046078so18299785e9.1
        for <linux-input@vger.kernel.org>; Mon, 18 May 2026 02:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779098373; x=1779703173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DJIG7dSSUSCrB0X+7bTr2JvS66WVWYC1a7BqZhmjf3s=;
        b=Ua595WSi/9sKrcmYLS0uV64FJPYwuhnoBm8IL0ZaMRFy7jjVAKvywcNILXoUzqGy8K
         csju/G3DYTlT+5U3Xfp0Xa20RRq3hhayacoZPtuAIqlpahT4Jab5RiAvy0TioBoI6lR/
         GyDB24ihe8xLbelkNIJ6Y6Kw2BiSrIXQK9z17k5fHiQSL6ArTHFOfyf1Dcp+BA3dZL9V
         m1YJvZYHFQZyGLhZUri2q8Jhz/wFQoa7mE2xKFHsS7DV3nGWpByEtYCIi0lrOmFR4gec
         XSuciJNb/ZxCpK0nV2N2RTNHcyJ7GAacdWsC20mQ+lRhVezwhNJvfV7uynrBjWkGpemk
         xFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779098373; x=1779703173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJIG7dSSUSCrB0X+7bTr2JvS66WVWYC1a7BqZhmjf3s=;
        b=JI/5wLCgiE8IvkzWvuj4HTs0tBz2k9pyzn2/dftTYOZDr6Hx/1TCi/RW4LCHUt9tUy
         JKpZNAHtrSngK/FP3tXiNJDiNpIZ38uUSJBV1KI/ESSc/u30A84LC5F4seuJQHMgcWke
         8/B0sGaw1monENfZn+9UKUtc1q9zP0qXxe0yKrMSeQXGhzKYSKVukTmHsPWGmzG29hXc
         vFyf/q0pzhAdPxZl26mAGh5C/p1R/hv2+DJtbKUnz4XMdf77yJi+mPsVUfuTR0srTVPC
         Eo1jojwklKw7AivgRJ1KNh9nFWZmlQdNKOuqPKliL0Pe6CQUk8OTHF0EluInRinFR2Bf
         Zliw==
X-Forwarded-Encrypted: i=1; AFNElJ/vJHbaaZgK2FSsN08YoCqzRrHw5VANIB9i0EqYvF0zlBojS4j+uHnW5/M6OaNkU4rhR7e+3/di9qfXdA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3aYjOeVWZYh+jFKrrkMGLmgOK4DBQp9cy/YMfoke3xKXwWuDJ
	GbwVWPXr7gvl7gO+7ds6t0+xIae8Hq1wIfJTefZfLtEcI3ZSC22qnMqc
X-Gm-Gg: Acq92OEbW9qplkCUH6bnZllqjks1WPJ+4nY7R2/cC/8FaR297jIdbiUiXZEg9jOBpX2
	SAd/VNVOiphyMutveDelF7mL0HpgL/t+vBN2CIAm9oOXf23B5VlySKyQU6Vh+iIijkS8yx+MA/A
	ifLYrS8iTItto/+3KUo6lMYzSzu4jvcId1wYkJbM8jQ+XJwPE/+KgSCVdZZPIdzzempDJJo+M93
	7+D1w4DqwZbFhz/9gsgI3Fv6OW0qiGKIJZAUo/gOy2jt5C67gsyaQdjhmbf4vXoWknvf1MmuSHl
	dBm+WqdmxL9ZHZ6Xhwd3LdZrxvBaWS2Vcil3zs63nDieLMl2ptNhFD5ZRnhghjw1A9vjb/qBvrP
	owifW8BVO2H0C7ZgUwscGMYBrrSKa5NF7LWnMPncsh8zNLIro/PSl/U3rMHP5kMvQiXNXY/s9ln
	dcknID4Rxi7ZoKnN+MdYkUPJU=
X-Received: by 2002:a05:600c:a01:b0:48a:76a3:2b9b with SMTP id 5b1f17b1804b1-48ff33460f5mr158732155e9.17.1779098373057;
        Mon, 18 May 2026 02:59:33 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe7dd22sm102995005e9.7.2026.05.18.02.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 02:59:32 -0700 (PDT)
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
Subject: [PATCH v7 0/7] mfd: Add support for Asus Transformer embedded controller
Date: Mon, 18 May 2026 12:59:00 +0300
Message-ID: <20260518095907.36158-1-clamor95@gmail.com>
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

Changes in v5:
- added asus,tf600t-ec-dock compatible to schema
- rebased on top of v7.0
- kzalloc > kzalloc_obj in keys and kbc

Changes in v6:
- removed asus_ec_handle_smi casting
- asus_dockram_access_ctl > asus_ec_get_ctl in control_reg_*
- fixed battery Kconfig description

Changes in v7:
- added status check of devm_kasprintf where missing
- devm_asus_ec_register_notifier dropped, added .remove where it was used
- removed cell_to_ec, asus_dockram_read, asus_dockram_write, asus_ec_* public API
  asus_ec_i2c_command, devm_asus_ec_register_notifier, asus_ec_read, asus_ec_write
- renamed asusec_info > asusec_core
- ec-kbc: added packed size check
	  ret > error
	  improved key remap logic
- ec-keys: improve formatting and comments 
	   ret > error
	   switched to dev_err_probe
- ec-leds: reworked to register both leds via loop
- ec-mfd: adjusted Kconfig description
	  fixed smbus operation sizes
	  fixed saving of EC fw model
	  adjusted IRQ flags
	  converted to use definer for set cell composition
	  added factory mode states enum and handling
	  defined some "magic" values
	  self > client, info > ec, ecreq > ecreq_gpio, priv > ddata
	  asus_ec_chip_data data > asus_ec_chip_info info
	  ec_data > ec_buf, ctl_data > ctl_buf
	  added and improved comments, added structure descriptions
	  asus_ec_magic_debug > asus_ec_susb_on_status
	  removed all dev_dbg and most of dev_info
	  pronts with model, fw behavior, factory and susb state preserved
	  switched to MFD_CELL_* macros
	  removed debugfs
- ec-battery: swithced to BIT macro
	      lock usage moved to asus_ec_battery_get_value
	      in asus_ec_battery_poll_work fixed possible rescheduling fail
	      in asus_ec_battery_poll_work fixed missing not charging
- ec-charger: POWER_SUPPLY_PROP_MODEL_NAME set as the first check
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

 .../asus,tf201-ec-pad.yaml                    | 119 ++++
 drivers/input/keyboard/Kconfig                |  10 +
 drivers/input/keyboard/Makefile               |   1 +
 .../input/keyboard/asus-transformer-ec-keys.c | 281 +++++++++
 drivers/input/serio/Kconfig                   |  15 +
 drivers/input/serio/Makefile                  |   1 +
 drivers/input/serio/asus-transformer-ec-kbc.c | 157 +++++
 drivers/leds/Kconfig                          |  11 +
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-asus-transformer-ec.c       | 109 ++++
 drivers/mfd/Kconfig                           |  16 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/asus-transformer-ec.c             | 534 ++++++++++++++++++
 drivers/power/supply/Kconfig                  |  22 +
 drivers/power/supply/Makefile                 |   2 +
 .../supply/asus-transformer-ec-battery.c      | 286 ++++++++++
 .../supply/asus-transformer-ec-charger.c      | 207 +++++++
 include/linux/mfd/asus-transformer-ec.h       |  92 +++
 18 files changed, 1865 insertions(+)
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

