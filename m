Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793795186;
	b=HhpAkQ2PqO5G4FMD/bg2SFSxBdI1bh1QX88x4MBxFmFzpY48yUtXUrLnRFYKbp6Ny6Qa
	 fc+lTxejxM7zB1/0DV4wVK3r/0X+aHSfKcOQ5z3UZNfu4PKGwXzZXH6uYlYcDm6tlDFQ5
	 aqun4OUtKQXijQtKkoNk6GV6TPHy1CKEnvNi2bmLI9VzVnLRGdf8qqdzcUY2RIqILzRLl
	 DH83hHtX9uh1TBZIplRpsSlpuBui6SicjO0dhLiVDc4FuGyGHtPeMze4/5GSp/G1JUJE/
	 p0q+FENBrg2K3JeB1JnDrnXjgJi5KlihgAWrbfhlwawCJAUdhQFDJT3edCeAaFUCaog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793795186;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=thomxBGmhlzEQD85NB4cuQLLeHvP2M634LL7QtV22Rw=;
	b=0+CaykUkB1YssWyAmbrczeRG2J2fCqnv4gwozc9RKd8pNvuBTW5tD5EoeNi+tphM+2Nv
	 Y2PwBorTEAd7td0WJT3D+sG1Wn+ZMUkQQvMrYnA39lgEyRjnP2dhCRzw/uC5mMjNGTFXF
	 Q8PCy6p5tY3P9vVQVsJlE13U0kM2Zrf2FR0YgVYPb6yL/IcrDeBa9Xk4Pzggk2kdfqnRd
	 Ipbwl+mztpcSGeschgdfVDk16u7kN4bG+rH83BK22nI+YVrSokiDmL3hXo40v13h9fMCH
	 Dm44/aJmp66OAHh8nXK0buKdLywq79jKAo6WU8adVEiXaNT+eiuolcbi/Db9y7scIIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HRBcL15j;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94E9606A32D
	for <linux-input@vger.kernel.org>; Wed,  4 Nov 2026 12:26:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C94E9606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HRBcL15j
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a20bde60a0so5285555e9.3
        for <linux-input@vger.kernel.org>; Wed, 04 Nov 2026 04:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793795184; x=1794399984; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=thomxBGmhlzEQD85NB4cuQLLeHvP2M634LL7QtV22Rw=;
        b=HRBcL15j+yHMy3baKSzZG+feycDT3bLz/2Py0auzYiUnpUrrwKeNmbv2D93vhW+Y6y
         4GFqlUTeaAxVs9Ja5WdO7TxR7CuFlucR8E9ngwCf3jN78C+Iad65or/2zRQV5tOXzDdl
         baL5Y9sPvdHOysZNSsz2mrdqfUY4TPoe8QcRemBMDZAZ9pvOqYezCN3Kt9v01FO2hm7A
         /vACd1WxhJGMCaIb0SheVEM4alHwz/yJNILaKigsl6JE4hdJGYjj7R7Lx/K6B9+e5f6O
         A493Gudgn/Ervo4IDnA9vrDfTX28gDzpeqQwRkVCanlMTpy1m2K9BlzF7fOANqCa8C5r
         ffmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793795184; x=1794399984;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=thomxBGmhlzEQD85NB4cuQLLeHvP2M634LL7QtV22Rw=;
        b=Z17qHPP8KFt0vAlLaQTJ80RJiNr5iREl9bHVhIIkDL/mpC2vlBXlgR972+8Y0otvQF
         dqCK6UI+fgCb7UciFFsx7ZqxPUzUVYsIrQdpeswLUw10CKZ1+psBCegeTpzA8IabMbnn
         DGAgkc3page286pdynq10woUILhckyezed84kq7NrKi4b4yHdjvZ5dd+reeeuUePqPwA
         oNrAk9a7zyNhJLe85Bd8c26QqmqLBWW6IhrOpLcOjWicBNDLs0s0J84In36o74kHeJkr
         uC0ZlzxKhUKdsTlKbg+mySjS6pyFDC8T/y+dL3yW3RkZpsDv/SY33Imp+IE+wfT1Ai+c
         IxvQ==
X-Forwarded-Encrypted: i=1; AKwUvBxulnpvigpruOnGQ40qSOEtxuIHIZ/BAhY/U4J9Xo6xm1c/NAbfJ8n4+Mj5yrv60HFIPeRfgw+pRLVtNg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8OmnhHPsNWNJSg17QdsT2cvaGd2HcsEIVWzvhWO9zEpjaDqRXB
	0P9DtXNQmpKYUw1yLtWUI1X/kSZz9XUUQTeg9F23LKawRSa7H3VYNiPw
X-Gm-Gg: AYBFou39vGRpWhZTDu/7dnyMl4fGte15xei7AcaDzI5J7xa3ZnQM1xXeUA8qsOn9G7G
	DpmfiCED+SieqSDgJgVyH/+2AIGI9xlJ3LTL7xlJ4nQRB9PoDCm4ML42lIKJO8j6fed9J9NM5ez
	SS9Rfq1iHBZmH4IVv6ko8gsvueo1Y9Xm0OfuTBvwcwu0TJjZuCtHtUIDlEnyo48k8JRk1uR21hx
	v+LBq3E4Frm1nW3WMjIQw92kGIKswv0nc1s6S9ZjddgtPs01der1SDJLyv38sxN1unlvxD80GBo
	J8yxX3zswx6ePLOyogANItTqD+L3TK58k90Lpok7w0Fj2KUKHRZMwyH7uiQ3zqlM6TumwM7kJPi
	3Vgv8gbaECWF3aYFNlcdT1Y7F3F/hNgHCiO+b/Ew3/Gd/zgN5H960y3KzhqyDpGpLcUA+M4z4CU
	gLRpoq3ejFFAM+BTaKwh+WOF5vd0GMYlhUBBrj79AmzD+pfOqOk/l+yDHSRqmQJwoA2yqYma/w8
	i7c9w/Rm7LF82oayCpp7/CmKmgva/JGIQJFJ5SvT539Ck6nNxvRPH9f+9AXfgxf7hNtlQZJ4QsA
	kXqP6Mv+TgoZY228VsCxYorTKjjUoHf4OHBGfdhYhQ9CAXpmPQ==
X-Received: by 2002:a05:600c:a30a:b0:4ac:b0b2:fa12 with SMTP id 5b1f17b1804b1-4acb0b2fac0mr259956635e9.1.1793795183945;
        Wed, 04 Nov 2026 04:26:23 -0800 (PST)
Received: from xeon ([188.163.112.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b43da9825bsm50492415e9.15.2026.11.04.04.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 04:26:23 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Griffin Kroah-Hartman <griffin@kroah.com>,
	Sebastian Reichel <sre@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Ion Agorria <ion@agorria.com>,
	=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
	Florian Krischer <florian.krischer@fkr.dev>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v13 0/7] mfd: Add support for Asus Transformer embedded controller
Date: Wed,  4 Nov 2026 14:25:59 +0200
Message-ID: <20261104122606.215629-1-clamor95@gmail.com>
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

Changes in v11:
- applied changes from Florian Krischer (read_size parameterized and fix keyboard response framing)
- ec-kbc: switch notifier and serio register calls
- ec-keys: used WRITE_ONCE()/READ_ONCE() for priv->special_key_pressed

Changes in v12:
- removed unused includes
- fixed kernel-doc warns
- added check if dockram client and data are not NULL
- replaced handler in media keys with Dmitry's implementation
- calculate battery time props with unsigned value

Changes in v13:
- switch to PLATFORM_DEVID_AUTO
- move notifier registration into input device open()/close()
- remove code check in asus_ec_keys_setup_keymap()
- register notifier before serio ports
- wrap mfd and leds at 100 chars
- moved retry in asus_ec_reset() into loop scope
- removed asus_ec_leds_data from leds
- removed platform_set_drvdata form leds probe
- iterator remains i becuase name led is already taken by struct asus_ec_led pointer
- unfolded driver struct fill in led platform_driver
- minor formatting changes in serio and keyboard drivers
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
 .../input/keyboard/asus-transformer-ec-keys.c | 216 +++++++
 drivers/input/serio/Kconfig                   |  15 +
 drivers/input/serio/Makefile                  |   1 +
 drivers/input/serio/asus-transformer-ec-kbc.c | 258 ++++++++
 drivers/leds/Kconfig                          |  11 +
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-asus-transformer-ec.c       | 114 ++++
 drivers/mfd/Kconfig                           |  16 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/asus-transformer-ec.c             | 551 ++++++++++++++++++
 drivers/power/supply/Kconfig                  |  22 +
 drivers/power/supply/Makefile                 |   2 +
 .../supply/asus-transformer-ec-battery.c      | 289 +++++++++
 .../supply/asus-transformer-ec-charger.c      | 208 +++++++
 include/linux/mfd/asus-transformer-ec.h       | 100 ++++
 18 files changed, 1935 insertions(+)
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

