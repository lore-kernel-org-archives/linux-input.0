Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4738478F26
	for <linux-input@vger.kernel.org>; Thu, 28 May 2026 05:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779946351; cv=none; b=Ra944VpEcKEjTwcgdMMiPO/tRPjj8ZHY84iqnLB6Tl9qP0RlNX8CQJqLtF1nDbwQEXhnCeIpgZAJnkRvdVOTbQyB2V0iNA9tBZazV7ikFkWH/sbeSWwJfaLtsTpWF66El6SsX5MaBQdHhWKKBeE2oza0uMZ2/b1DBvefLZX/E5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779946351; c=relaxed/simple;
	bh=clNVtbBfViwKLpG9zmkSUgXMyGZnR+a/g79EpBF+4us=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ee+yBQuXVVBMQ3NRtey8+i/ZPustJN0ckVYRbvSwYdaSaX8Yqca2MTIhIExvTuhudKZjzDfXz/ysCCe+m2d6y8zas3p9bcrDfgw5qGBWbZfiq84hI1VIWymGDwm9fSgiiW0nmewyebq7FoiNMrCfUT2l32OfQ6mghOC1urz8NtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6VkT+s4; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6VkT+s4"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-bd56d108454so2214935266b.2
        for <linux-input@vger.kernel.org>; Wed, 27 May 2026 22:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779946349; x=1780551149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uNrRcVw+e7yAa5bCgioJSE1tWr6W5F6AeUGiymutBGA=;
        b=S6VkT+s4l1ummC6oJfUbk5TpYcCSrESxn0p30cNrsMOeL13oUu4fXPUNfm0Nyuc6PB
         OmR15ON4PuNbFJnQNeNUoj/W9sLJg6ST1n1ZUfwea676yqZM9tPS55ww3EKlJeM63l7N
         nnBzaJXemYw6gbF/IGHf/S8nrjogKhow0gNRPLjOJpbegEDit6Fp1H3ef9ugrCQ/HSG7
         d0BpJ/ptQ1dYG7aNXOoXpZsRxIVdlnjIU+/BcyQONZOzLB0nTc0uAIPvpN9Lio/VXhL+
         3uRBCMY+BcBieUbEXEJVuHyB2bmkNNkh7ynyzN1naSa4IgV09DWaqo6pS/dwRVj9+SAW
         d1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779946349; x=1780551149;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uNrRcVw+e7yAa5bCgioJSE1tWr6W5F6AeUGiymutBGA=;
        b=F1ooCBk97ZIGBeSx5f0m7FaP8OkKORNhGsZZT2aUdi9jHK6JAYeGpjS5ffOhxGmbcT
         9fQE1OT2SNA+f9GBkiB/h8LM/oxPqT9B7feIw+DSJPsqAa9xQkpjuhQOVo5vvY5q3f98
         32QqNp/F1uflPvg8OpBSQsJ1LKxMnFVpYeKwetf+KLegrMKGRVPydlEDvtD2Bd9Epkww
         IwP9tlqVj6QxqI6HhSY3wSr7/aXAnBNWknQHaULAHGB9gTWW8w7LgD1AvlcuKCcZlCaR
         +TFW5ZcJEDA/HdJjeirzMFgof50CSXtk325DMCpxAjX+/yKKGt1ufZEnC2RDU75vCJzY
         Ue0w==
X-Forwarded-Encrypted: i=1; AFNElJ82CV7+kDnlLxL4FZA91PKzeQX3mebM/IWqDtLwzJolJ+/uQTvMCTyzUiWyAbuubWV7xb9g1msPHdIfVw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4ygK3PA9wmlrwZAnDeKey2ucRJLIQlbhFzvu27DVNobXwG+Fo
	/d+IWINgw17063ZiSxFuzSyRXP1crlOBNCzWgld6HK9baURKiqCwvc14
X-Gm-Gg: Acq92OFZnRDwTEgkLhXYlV8kHEnkVXSsdLrJfKZWkDTI9hnWSE3iv4eyVnNETcgOZIk
	UrpFRzbn2CkEZ+dJ4ckPz8QoU52CBdntxvHveA0oazrACViNSedIxVQ03ArchMh4gf7+MJBXkTL
	exv5R1SdQHNX76//b9YXiSCxaNh2qx+THmr3GhVfV5IIfme0JZe0abFaSJcft60DFJfO80SHaO4
	OhFLU1c26N2B9NSVOdfq59A1pV9k0xAvqwiem0UlqT3IZD+VaSkW5cZytTWwSxFqHsjYwuF35qi
	fM68pyZ7PTw26Lme8r7+6Xotv1mon2bkCrZljt4HmvZFzJS6CBnKmUStv4fwy6ICE2RG2J5HYf4
	m2D1NHry94dKYimSoxxltyDe4UdGoXzam6oBUXx9u+Qw2l8C+X9OcyTCJYhpxU1AYwtrmUXOx2N
	3rgCaOfX4p0CtKxUOEV73gUVA=
X-Received: by 2002:a17:907:1dee:b0:bda:5265:423 with SMTP id a640c23a62f3a-bdd269b7370mr1175915966b.44.1779946348345;
        Wed, 27 May 2026 22:32:28 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bddc5eca616sm693427966b.30.2026.05.27.22.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 22:32:26 -0700 (PDT)
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
Subject: [PATCH v8 0/7] mfd: Add support for Asus Transformer embedded controller
Date: Thu, 28 May 2026 08:31:56 +0300
Message-ID: <20260528053203.9339-1-clamor95@gmail.com>
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

Changes in v8:
- added MODULE_ALIAS
- renamed DOCKRAM_* to ASUSEC_*
- ec-keys: input_handler moved into private structure
- ec-leds: added brightness_get
- ec-mdf:  fixed i2c_smbus_* return checks ()
	   improved model storing
- ec-batt: added status check of devm_kasprintf
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
 .../input/keyboard/asus-transformer-ec-keys.c | 286 +++++++++
 drivers/input/serio/Kconfig                   |  15 +
 drivers/input/serio/Makefile                  |   1 +
 drivers/input/serio/asus-transformer-ec-kbc.c | 158 +++++
 drivers/leds/Kconfig                          |  11 +
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-asus-transformer-ec.c       | 125 ++++
 drivers/mfd/Kconfig                           |  16 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/asus-transformer-ec.c             | 542 ++++++++++++++++++
 drivers/power/supply/Kconfig                  |  22 +
 drivers/power/supply/Makefile                 |   2 +
 .../supply/asus-transformer-ec-battery.c      | 289 ++++++++++
 .../supply/asus-transformer-ec-charger.c      | 208 +++++++
 include/linux/mfd/asus-transformer-ec.h       |  92 +++
 18 files changed, 1899 insertions(+)
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

