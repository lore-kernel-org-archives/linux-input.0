Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC31271456
	for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 08:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782375359; cv=none; b=R7MKkVKD4c39IVJyifqUAQMeqBu10Gg6W8E60k5DtmH5gSzHVzibJmLM3H+yBkF2EJdWv/A5k4QANOx4FU72D2YNwO6v9qBqWb6bL9EQ/Fw7jPplSoQ3WNBGZ9ZxjKiZPvyztzDG8eR2ZyUOW59hEbOf/DHIGIZffbXEgEeBzxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782375359; c=relaxed/simple;
	bh=xGd6NGwZIKu6bwxgG9+VFyp81S1AlTved33dLwV5kz0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=naiBy1vINHooGbQKvohPa20CVIM3VFrB2TWBi4Y/2yTmfxHkuAD7xrg4Vx8yQLY7IervZtVWQ71sgkIcwLY8GsDSw+/58du5jPZLVrS6ztnupGtxsH0rasUkG0lcsIoZ22BSVQvVYqmN5h1yLcSY7nz9aX5HI8s8Q9ViFtlwzko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eq+tDkf7; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eq+tDkf7"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-39977ab0562so18137961fa.1
        for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 01:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782375355; x=1782980155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gg0fXFMFgIBOcyFcTi6Gl524W+rUCg7wosxNG5EPRuE=;
        b=eq+tDkf7DwxeeWNyexOwEP0T0LLDdl9yq/JHQ2+Ua0VhlEDiyvmq69mDVsdWxF+HIv
         EbYVXbVj69vnyzxhYn1d1uiPb1WhoedmHIfkgQSozSxcPx0at8TbO0+2yvQN0HAMLMs8
         Lt1sctrYJIo+xcGsEZ29pDpvCYjs4NvEpJkse87KY6/JMt7DtDyLPuAg95bryY33KJJn
         RszSKd9uh6jULkVyBYOUCmSW8EOPeuiU6Et9itmonW52OFZt1t/EY8efzWY+jf7HpJ7h
         NQIVxiWCAMXLG+hxetu5JuWWoAxLkDNRP/nC8lSN+/28+CvMpKVQP20hE7BqIRqPy+Bg
         CAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782375355; x=1782980155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gg0fXFMFgIBOcyFcTi6Gl524W+rUCg7wosxNG5EPRuE=;
        b=paJhn3pTOPWWbYLuJLdxrrlQ/g/7BlBLVZAQLd62h7j6X9715PyJoJU/7GE/Q5DMxT
         J8qSObS4kTf3ZX+Kgvwl85kRXY8MpUIOg1AWKd/Erob2/7uBmo9h7L5+R4IxxjWuCc4f
         //Js5418nIxmCtqZUCNR5U54GMz6Mx7WygkRASKwO2eqw8ZihQNx4VNTKBaOnloxssyF
         wA+ZPAmjcHbiF6BybT75hEdRQgiLvluG3V/ldZU5k5Cz8sLY/s5tqWrQeXkJ5v/KVcOj
         yh4DI8DO5++IJujQvmdGZ3mQtiiMnIk095jEy9NFTnWVqGWQsmGOqd2cXxV6qzRc5YZH
         sHdQ==
X-Forwarded-Encrypted: i=1; AHgh+RpO2JPR5UaLnKYi1P5ExmkhPtUmogPF8Sj7Pk76z2GJVFiYBCCUDg8ZsckZ6tKSSsDN/ELjMyhHoMQOBw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxcK+YLkr2fpzaSllWFfOtR2ooEefAbRiXjk9WZcqO4WpEpLnqn
	DxGXOB13D0DDnAd6HAJHEdM6S5mSGyxPMN0M+3rU3fy2WYYS0G53Qubk
X-Gm-Gg: AfdE7ckuSHpYPrC9IVnGuU1sMjQx+jHs8dOAte7tGtNt4gHr6uQQvDnfnLZ6K+wNxWP
	82JNqqlbw72RS+y6GRtl9Trt8jlKPyxoD29aqMF/IsYRDO8JP3nIyz+LNQGwSiw+vxtMisaKlEh
	xwRpvBVkket4REbKmMl0a+K1MLGUNmmgPQhwsZ9y8qp133dTWxrpPtixSQp19N+bXIpfi01ybV7
	nn9og/G3tl5qi9GD+5OX7aIZ93B2tP14SXW2Iuzx670N07OWZ+G85dcTqivP3xEYCG9BI5P2I9F
	/tEG12QmICeunDZm5N6w28CrOouk+osm4tS4SGVUimUVa8KbxCOTwYExOLiu9v5YbQO2BzQZZHN
	Aw4uy85iXAHameNOEJwVFL2p3K8jF5T5llMq7duJiHU1AtJyKLiVneWGG0HvPia/zjylATHGvbR
	b2cw3jv28aLFQqUq3s6w5YHjDAhATn3UfEvg==
X-Received: by 2002:a05:6512:2c86:b0:5ae:a348:1292 with SMTP id 2adb3069b0e04-5aea34815d2mr246101e87.38.1782375355080;
        Thu, 25 Jun 2026 01:15:55 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3999afce64dsm39162221fa.14.2026.06.25.01.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 01:15:54 -0700 (PDT)
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
Subject: [PATCH v9 0/7] mfd: Add support for Asus Transformer embedded controller
Date: Thu, 25 Jun 2026 11:15:22 +0300
Message-ID: <20260625081529.22447-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Changes in v8:
- added MODULE_ALIAS
- renamed DOCKRAM_* to ASUSEC_*
- ec-keys: input_handler moved into private structure
- ec-leds: added brightness_get
- ec-mdf:  fixed i2c_smbus_* return checks ()
	   improved model storing
- ec-batt: added status check of devm_kasprintf

Changes in v9:
- fixed i2c_smbus_read_i2c_block_data return check
- blocking_notifier_chain_register moved before serio registration
- adjusted get_unaligned_le16 bounds check
- unsigned long long > u64
- iterator vars made scoped
- removed "magic" values from ec-mfd
- simplified logging, detect split into detect and init
- improved error logs formatting
- adjusted handler in media keys to connect strictly to dock keyboard
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
 .../input/keyboard/asus-transformer-ec-keys.c | 314 ++++++++++
 drivers/input/serio/Kconfig                   |  15 +
 drivers/input/serio/Makefile                  |   1 +
 drivers/input/serio/asus-transformer-ec-kbc.c | 168 ++++++
 drivers/leds/Kconfig                          |  11 +
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-asus-transformer-ec.c       | 125 ++++
 drivers/mfd/Kconfig                           |  16 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/asus-transformer-ec.c             | 549 ++++++++++++++++++
 drivers/power/supply/Kconfig                  |  22 +
 drivers/power/supply/Makefile                 |   2 +
 .../supply/asus-transformer-ec-battery.c      | 289 +++++++++
 .../supply/asus-transformer-ec-charger.c      | 208 +++++++
 include/linux/mfd/asus-transformer-ec.h       |  92 +++
 18 files changed, 1944 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/embedded-controller/asus,tf201-ec-pad.yaml
 create mode 100644 drivers/input/keyboard/asus-transformer-ec-keys.c
 create mode 100644 drivers/input/serio/asus-transformer-ec-kbc.c
 create mode 100644 drivers/leds/leds-asus-transformer-ec.c
 create mode 100644 drivers/mfd/asus-transformer-ec.c
 create mode 100644 drivers/power/supply/asus-transformer-ec-battery.c
 create mode 100644 drivers/power/supply/asus-transformer-ec-charger.c
 create mode 100644 include/linux/mfd/asus-transformer-ec.h

-- 
2.53.0

