Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB984499B0
	for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 09:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784627592; cv=none; b=XvWJqqYwizhTKsJ5gfd769W9NlWxvPMGrcd+HgX7pq1+F59g6ooNDqclXEf2p5oThxelXjWqW1m3Z0iEWJbXyx/do/naSTzUueG9rWAqTrdB+Yoe/6qWkaTXNA9w8miyL/17r37eXx9aqc8s8GQlRPkzyCNz6jv9keUs+ALgAck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784627592; c=relaxed/simple;
	bh=qD30dQmKclQ0zx8l1do2zkJv1Fkwy7bpNlXAdgXoaxA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jDNgAzMC8XoctLazOX9vk0s/OTgR0T+rsyVdsff330+5a/zaBTVZ8e1a2ZXdeGVJz2oCdHHP/4ilhgQHEJrK4AbZ+tH3tkZsRYagm5zRofQEBsKcHLSOprAub00bZZdh1IxJalcLppYRjIsieA4OxVCTkSlInD/dX27VDW9rMSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPP/gHKK; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPP/gHKK"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47f785467faso1296425f8f.2
        for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 02:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784627589; x=1785232389; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H+/eOTpenNfUjFPAzBL9uoyeNDvjEemJNpe8zs8B/A0=;
        b=KPP/gHKKqbilDuQ69li2+wcdEqNqffeOtQntyBJg/Wu7dR3knq7PSRGQrHYMg8qX0X
         Vr0hi1QYLR7mZJsewkGI0Uo/KOOZKyEQc6DE6sJ+82x1loM7gNXQ9PXqQ98YLnxgav1k
         I3fZYgeaTOvXy1D1a1KxpxzJQXqTrRdAlQaFfl94mx83NRDMHGv/GYX1klBJBlN2tfJg
         zlWqa/iT4JBvQ/mdKOYvWNUIHGr2AtSxJquHqGkSHPzDlu6omdTJhO03UYX2HlEDzDqv
         EI9GzkucEEdIayvZh+k+dk4Qii8kYz+72Hq9Rowt/zzT3AuXNgcvdRt3O99spQwhS/5T
         yWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784627589; x=1785232389;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=H+/eOTpenNfUjFPAzBL9uoyeNDvjEemJNpe8zs8B/A0=;
        b=N+yocBUhWcM1Y3emXjbN0DYitTCRzxcdv0R7XbRvo5SZf6K8AL1AxiniVdh9AG4/du
         r3dKKMJvuAcMImQ0z1tac/VeUJnpNzEARL9FgemhyvqDo1OFCSpnxKIc92kdb8tEaM1k
         MhClBRN2+hwMmZMxS79MHhVv/kFI/YZ9rJHasbWcJ+LtBf9ENKF2ZR3fQxQ5A7GLbaS+
         x7qpT1eHR9S3NJej7UwJItu6tPzoJd0XoimYIHfnUQ7PM88uAmiigDu+Ziy3Ej7TcCng
         fweakIAs63N4QiaJrhwUf6++WY36fRWQrhZw/x8B4KY2vI71eNGZ+ceN+V5c/znIY71Y
         Y2AA==
X-Forwarded-Encrypted: i=1; AHgh+RrVXoCIA4YUPbjVkQFN7kmlk0GHZlHY60unQ0uGf88UNM2yVPuZJxrsoGqYklclVA1PTyOBKBzkgmDS6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3dKbgf1kSJvkWz1kwNsKLH0FNH2M6zdZqMQUl+FGzqV2Xao6j
	AgMrl/Re+usAlhbOq5hIlz4wJF3jTIO4IjLpeZcJZqmnnxh3+To2qPcZ
X-Gm-Gg: AfdE7clfdYhCPKpFn8faarLKCPoTrXRLMxJRV5ijZbXoJn2Npi3rUj1i2l4IFemDIQu
	2Exz7v0o3fpu2WLPKZGTt6hBdLPEqZM4emhazEZ1l272sZKSJuFVTdHpAiq8oa8+jODPNVHWrcM
	h2mqpRmNEKRL6wbBkab/K0KigMw9X/gt6Z+6EnObFHkMmBcLowuMhdYHoY6+RaE/QvaaD2aNb2K
	a54L2vTthMzGn8X6Ff4VsOTa476rtWJxo9ZEZkVOyWRx4TJnk+vJl2QV8PqldV+5KvB7cT+Ns9S
	8w8DrBp3SB394SHmyjCNmdTp5rcQOUrwL9ydMDtTAZAKxWXP+hWZ1eJQ6eDWYNPEMt50RZ5kr5K
	6ivd/EAYryk4eXwCnX8JG00vEsZAu7mZrldRIh4HQpY0DcpNe2Fqpw5D+8cRtfLmGASf53QxsAa
	Koj9zBvBDLBkOfsNeAtiQUETY=
X-Received: by 2002:a05:600c:4f12:b0:493:f0f5:f2d2 with SMTP id 5b1f17b1804b1-4954a3d0ceemr213824335e9.1.1784627588295;
        Tue, 21 Jul 2026 02:53:08 -0700 (PDT)
Received: from xeon ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49565482c5asm82834285e9.10.2026.07.21.02.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 02:53:07 -0700 (PDT)
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
Subject: [PATCH v10 0/7] mfd: Add support for Asus Transformer embedded controller
Date: Tue, 21 Jul 2026 12:52:26 +0300
Message-ID: <20260721095233.420823-1-clamor95@gmail.com>
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

Changes in v10:
- ec-kbc: fixed possible out of buffer reads
- ec-kbc: set notifier_call before blocking_notifier_chain_register
- ec-keys: dropped input_unregister_device which should be handled by devm_input_allocate_device
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
 .../input/keyboard/asus-transformer-ec-keys.c | 310 ++++++++++
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
 18 files changed, 1940 insertions(+)
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

