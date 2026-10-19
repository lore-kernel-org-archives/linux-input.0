Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AAF493635
	for <linux-input@vger.kernel.org>; Mon, 19 Oct 2026 10:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792404261; cv=none; b=C/Y0xAnHECmo4ip+qUQhi+2+KnQykibm1jZyWakJsp4x+wVfUTiE7EvNUgD+qH8gRf2/+x0b2TYI7SplW7+jQc6NrjJdkLP1KKvoGvmn1sNV6+hX0n3ksYseCiw6U77yBIekwaMJvX7lANXVpJJl3jaSsjwnmn2jt1IDgmK/sOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792404261; c=relaxed/simple;
	bh=7ZVlR6IOSlaX5Xi1ni8xup4aog2W0EF/VKd5geDGGow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ee1/tsXTFf6ouJzaYLf8Wd/aTtZu37zdVECtnR1e1TG8h84lTknNNvHBd+vJUsoV8m697DezWVedeH5EGlwj50uO1qaprtcsjOnKoqoUIGv2jKIUVl9jygyQVHfPbShwZ3T70oJy3+46H0vVy6ign0aBSfr7mTunLz0u+CLyJPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n1MFw7z3; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n1MFw7z3"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a0286c981dso20363495e9.2
        for <linux-input@vger.kernel.org>; Mon, 19 Oct 2026 03:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792404258; x=1793009058; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yU02A5QCA5uDezHjXk/3H4+qztF2H6rEt8SEU7U24Oc=;
        b=n1MFw7z3ErMugaHuu6yz2XD6X436+RUzOgBtqzmPkxKPUK2J7G1G7gqxdhCgGWUlVe
         JKm/th3r/hRD0JtP8XAOfHHPDBaUU2kMGpaDKOv6keEuEN+CIWcjNrwNRbibc5r0udu2
         X7/P5KKGPRevCV+YuyIz+0XOJUIsrrPGxaObni9Jad5d3U5oL9ZC9ITSRdA6OhbIYmg1
         wwBG37zvtn4CvSpiBOqBM+/H6/R68LaJqOzYLG2+jUdJn6nhxiZHvstOTyW+FLOMiGpX
         6ACkxL2XniXt+jBOC5KRMOnYXiFP41Fw7hQqwOA08GbhpJK1DasPUydLN8K1SspejwMJ
         HeSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792404258; x=1793009058;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yU02A5QCA5uDezHjXk/3H4+qztF2H6rEt8SEU7U24Oc=;
        b=BxGNrgmw4fGidU8XoeV2x/zFGBZuPvIRcXPLtB7SBwgteNuSNYI6WDcG/GLilCfvMo
         YQ3lDK+aLqBnrUmumNps8ErHLbZjIARFebfFDgfdJx3KXAjxjo6IcezqdZs8EEUj3bpM
         1flpC2mmCsvik1a9QSfdKDvjCoJr6fAF/nBd1xQ98HYbm36ie7oR8vzmOML6YqQE3G4H
         DbqCpg8hfknIWDAJ3YlivbUwIRiQmp3UcZIp/LT2GeZrqmpYRLKb//XLnsVpp0H43zjn
         Q+LpKOompuwYsfThXn0nqk0BxypdXgld9UClDDAQ14PrZjUwE3pFnF5B3XJLb0r4c3Js
         9z/w==
X-Forwarded-Encrypted: i=1; AKwUvBxrswQ9f1oN2FTC5fgEFk/vVdTXtH7LTWP3eJFUO1p3/eADCViTodES/9Isxn1qQpscpjZ7LBUCZgkqiA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJrQRC/MlPwITXWvdtlXPGig8MIbuwKZn3mMZI0SRJLPjKyHmK2
	xLRdf6WgWcRACUzRp0ARokG75VxH429Q9pP9HEKjsDScm/H0OBXZQaWK
X-Gm-Gg: AYBFou3VWp9wJvayqI+Rju2aN4OQx93iN/XcPpJM4CxUvO/pI7BjT+Anv+Jn1o+DaEs
	3Q5u3rvw9lliSQGvFANADBtOrK+i4LknK6x9naHKBunf2TpJNUQHBz7CI1SlR1wVW+FQD7QxRyT
	QoDavO6AIMf3W6bM4eawaa1og9+9t5v/nL49biReoIp/rNWLBqVXu/J3mmF+/mWXnIuwMIQjpgV
	ze2QZwAxptv0t87/BumR4KYPWwsBRY5p8nldMs8wzRAIuzAN/lelwW9MNUd8FF9JV8Eja3yO13r
	nXSOAFXXgvfkmEYFiLUIY0kGIzvM4AA5O4/fuNT9hSsUkTwS0JLyrzb4WIKQJ5VZVCge5qDm6DP
	GQtAnWR+4fbcvXQJE/BfbLDsiAHyYmXNXtA2opg5PhV/nP9Mg9x3E0jE1+yUsBVsiZQVOs72WpI
	5IE4/SCdQvlnqqZgHR6Oyu7eYAERLjWP6QO+b4WzWlEVT7gf/DFE6XH+NFIqLzyT6zHtcdoRQSd
	fw8mALV7aO/Y6oRtFs=
X-Received: by 2002:a05:600c:4eca:b0:4a1:e271:2d53 with SMTP id 5b1f17b1804b1-4a1e271308emr83287625e9.3.1792404257920;
        Mon, 19 Oct 2026 03:04:17 -0700 (PDT)
Received: from xeon ([188.163.112.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1df164777sm177811485e9.5.2026.10.19.03.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 03:04:17 -0700 (PDT)
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
	=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
	Florian Krischer <florian.krischer@fkr.dev>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v12 0/7] mfd: Add support for Asus Transformer embedded controller
Date: Mon, 19 Oct 2026 13:03:59 +0300
Message-ID: <20261019100406.103687-1-clamor95@gmail.com>
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
 .../input/keyboard/asus-transformer-ec-keys.c | 212 +++++++
 drivers/input/serio/Kconfig                   |  15 +
 drivers/input/serio/Makefile                  |   1 +
 drivers/input/serio/asus-transformer-ec-kbc.c | 264 ++++++++
 drivers/leds/Kconfig                          |  11 +
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-asus-transformer-ec.c       | 125 ++++
 drivers/mfd/Kconfig                           |  16 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/asus-transformer-ec.c             | 569 ++++++++++++++++++
 drivers/power/supply/Kconfig                  |  22 +
 drivers/power/supply/Makefile                 |   2 +
 .../supply/asus-transformer-ec-battery.c      | 289 +++++++++
 .../supply/asus-transformer-ec-charger.c      | 208 +++++++
 include/linux/mfd/asus-transformer-ec.h       | 100 +++
 18 files changed, 1966 insertions(+)
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

