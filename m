Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB3E54774
	for <linux-input@vger.kernel.org>; Mon, 17 Aug 2026 03:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786937472; cv=none; b=lheITOfu91tOjK9mQjUR2jcQWkmkXCqBW7ZSmr2lIxoUXBXzP+rWS2tgKbPTK/JbNgi56TTbZZGpY0hExE43OdIhbpfsFj4pbo93X3/XW7UWBLC2iWQMlQ/zW0egCd5LWL0bS/2LD3uefhBolYlfV6Ey05Y57fKSbr7uyXrqBes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786937472; c=relaxed/simple;
	bh=a3gCeMRUt0Rrs4+ahI4VBhzFW1PjKJeuBazV56+miOI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=b9cjRKt6WqQVxrU/blF2/pv52aFtGjJQNgO7Ij9n3FtY6zxEyLviSxW7xnbrjIGD0mPiY3IFcBNY+JKrxbJopeFU3wLywpP7uuo64IQPmJbpsuNKQ1s6WHc3ETlsY9OGMKQ56WjYDkD4juDLRDblKPNWbj71W5t2vIzVDr+OpcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VnUdiBuM; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VnUdiBuM"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cace91f112so32477065ad.0
        for <linux-input@vger.kernel.org>; Sun, 16 Aug 2026 20:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786937470; x=1787542270; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AJ86HgjoGIVlHYKs2krNkNP29rTactBljK3BVhC9gaA=;
        b=VnUdiBuM/STPyW76adiY6EHh3XKoQwWd7xHPOOxOjz+ieV4DxP3K34tMGS/Is8kWgm
         KUIS8iLib1xq68itKTN7eGfQdQUwZRSH9YRQoxo/gP5PjKlMQj3r+nxfkCO6T2GR4uPD
         DAsfCBlmuaJl4mNXBvaMLVYFDJP7X47io4345r6HSI5uBxSvyfU8S8YcU8UJMgtnbozO
         ml57iG4/BfLmpmjHxAYch8JkrofD0d6yZeGg8KNGbDV7xgJWizAAJlEZ41p8Nrd4/Zuu
         xa7u4KNGGCMTqLHAqcoSsC8TRWTG0UAg4iU20E2IyusfDBmN9WlVp9pzpaWuy6XEV872
         ThDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786937470; x=1787542270;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AJ86HgjoGIVlHYKs2krNkNP29rTactBljK3BVhC9gaA=;
        b=NPcSaZNQkXrkZTytixs0koB1XU34n5GRLyBPX8UJJxtZQ8xXFSaH4dJcJtwG6zNMue
         TuH5RF4Kg4a0dq5yQLsUz3R+vdEw2WxP8DL7C+LzlEh//iKRH6GD0IWeZVzlpfie4krg
         nBCNOhHF2uN0cW6CNXLNGLHvmgrT0F32mkNWEHu4SOC2sAQZW0TAiJSf+3oEWwOWoIZ5
         ry20Paqn6LHbEKefKiFsy9zKtciKKtQBxBzzS7uY+hLkA9TwHk/GkEr0oI2HkHWe4Ot6
         9qHT/fscYhWVmX6N3s1aHVqrQXVI4kdVLcDs+m+cHZZ8TM/S62f5fvaH6EnAyHv86fKd
         zQwQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpo+7XhbfJZv15iFiZw5Hset4o7HusXoIPOOVJuhcFXZJ1yl/5N4Ayf1eWGWJcDQ762r4e3I3S/51BXpA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/QYWxIKygfcVfeY2YF3iu9TkOymMbANgG8d+N7iG2VKoCnVLL
	Ojz5Q3SwRDe6bZ0Dl4sNgvLLt3vdnpXc2dqNlqYgOEWQXuaCrDXqskkr
X-Gm-Gg: AR+sD12YzondOZL+4PnKy/CH17WhV6MvJX1fzhP665/xg/0eDYrA84qT1x8HDI8+ZIl
	3FcYVNRTrZjhC/lCw4dw5b+p1LqsdLr7NTIcTir74F7yXBAhH7Y54XSJg9uFrkqtLe1SgXzgkIZ
	YwV7ozrbLkGrwSBs6OmAXXK2eaNVYBx6AfAMxfutuJQO1j7Bqy7HRlUp+f0TNJqcW+aZYIDmDeL
	P2RU+HGCOMAqMQMpOX5QMmu8bFCE8CfBzq/BBMX7yMf7Rn55yhGPhkBtmJCJnyXfQoJx8SWXeDW
	0TRQmAJUpTrnNEaxE97MFbc/DaJS9l5MCq/2DWrEm8cR5ak+grMsJXag3zUGfZJhu9b4ewiRbMR
	i/OR2eQ5jXi0+vCt139i5z9i0NeSwoNiiNbtqirvd3jHpDuCOGJ3+fNgb0EyrWPQ4c/tzQrdBqX
	HG+9xzX/Jm39GgwFvnHKZSus0mXupXnEOYyx4KY87MVVIrDkiotphKk7cp3MUN8lPolz/ep3yWA
	Z+A1g1JCf9uNp3CT5NBPQYnq7VsruMmB14yjILt
X-Received: by 2002:a05:6a21:1786:b0:3c8:e140:63c3 with SMTP id adf61e73a8af0-3cc720d1fc3mr26530805637.37.1786937469762;
        Sun, 16 Aug 2026 20:31:09 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:5ab4:90f4:c0f9:b344])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3267cc91278sm927625eec.31.2026.08.16.20.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 20:31:08 -0700 (PDT)
Date: Sun, 16 Aug 2026 20:31:06 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v7.3-rc0
Message-ID: <aoKAIGTdF7pVYqiu@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v7.3-rc0

to receive updates for the input subsystem. You will get:

- A new driver and device tree binding for Imagis ISA1200 haptic motor
  controller

- Improvements to input core opening, closing and inhibiting devices,
  ensuring devices are fully ready before delivering events, deferring
  handler start() until the device is opened, resyncing state on
  uninhibit, and rejecting inhibit requests during unregistration

- Updates to cap11xx capacitive touch driver to support Microchip
  CAP1114, optional hardware reset GPIO handling, and per-chip LED
  constraints

- Fixes for MELFAS MMS114 touchscreen driver hardening incoming data
  parsing, endianness fixes for I2C packet layout, Y-resolution
  configuration, and refactoring to use chip variant descriptors

- Updates for psmouse driver resolving a potential UAF during protocol
  disconnect, cleaning up PNP ID matching, and making use of guard()

- Fix for FocalTech PS/2 protocol to prevent coordinate underflow and
  cursor jumps at boundaries

- A change to Synaptics driver to enable InterTouch (SMBus) mode on
  Dell Inspiron 3521

- Refactoring of PA-RISC keyboard support in gscps2 to supply keymaps
  via software node device properties, removing architecture-specific
  tables from the generic atkbd driver

- Updates to Samsung keypad driver to keep interrupts disabled while
  device is closed, along with wakeup logic cleanups and use of
  pm_runtime_active guards

- Updates to NXP i.MX SNVS power key driver to report press events
  during resume to avoid lost events, and error handling cleanups

- Updated TCA8418 keypad driver enabling overflow mode per hardware
  errata

- Conversion of ROHM BD718x7 and BD71828 PMIC drivers to instantiate
  gpio-keys child devices using software nodes instead of platform data
  (coming from MFD immutable branch)

- Updates to Synaptics RMI4 driver to use touchscreen dimensions from
  platform data when specified

- Firmware update speed optimization for IC Type 0x19 in ELAN I2C driver

- A fix to Azoteq IQS5xx driver to validate firmware record spans
  against programmable map size

- Update to Samsung SUR40 contact count based on PixelSense
  specification

- A number of updates to device tree bindings, including TI TPS65217
  power button schema conversion and new compatibles for FocalTech
  FT3D81 and Synaptics S3706B

- Other assorted driver cleanups, style fixes, and conversions to
  modern string and cleanup helpers

Changelog:
---------

Arnd Bergmann (1):
      Input: matrix_keyboard - remove linux/gpio.h inclusion

Bivash Kumar Singh (2):
      Input: elo - fix coding style issues in elo_setup_10()
      Input: inexio - replace printk with dev_dbg and fix missing space

Chen-Yu Tsai (1):
      Input: elan_i2c - sort include statements

David Heidelberg (2):
      dt-bindings: input: syna,rmi4: Document syna,rmi4-s3706b
      Input: rmi4 - use platform data instead of query, when available

Dmitry Torokhov (23):
      Input: mms114 - prefer GPL over GPL v2 for module license
      Input: mms114 - use appropriate register argument types
      Input: mms114 - replace udelay with usleep_range
      Input: mms114 - replace BUG() and fix alignment
      Input: mms114 - refactor chip variant handling using descriptors
      Input: mms114 - fix endianness portability in I2C packet layout
      Input: mms114 - fix Y-resolution configuration
      mfd: rohm-bd71828: Use software nodes for gpio-keys
      mfd: rohm-bd718x7: Use software nodes for gpio-keys
      Input: samsung-keypad - clean up wakeup configuration logic
      Input: samsung-keypad - keep interrupt disabled while closed
      Input: samsung-keypad - use pm_runtime_active guard
      Input: psmouse - fix use-after-free during protocol disconnect
      Input: psmouse - clean up locking around disable_work_sync()
      Input: psmouse - modernize PNP ID parsing
      Input: psmouse - use guard() for resource management
      Input: focaltech - use signed coordinates to prevent underflow
      Input: gscps2 - supply PA-RISC keyboard keymap via device property
      Input: ensure device is ready before delivering events
      Input: clear inhibited flag before re-opening device on uninhibit
      Input: call handler->start() when uninhibiting device
      Input: defer handler's start() until device is opened
      Input: reject inhibit and uninhibit requests on unregistering devices

Eduard Bostina (1):
      dt-bindings: input: Convert TI TPS65217 power button to DT schema

Ian Bridges (2):
      Input: i8042 - replace strlcat() with seq_buf and scnprintf()
      Input: wacom_w8001 - replace strlcat() with a strscpy() helper

Jingle Wu 吳金國 (1):
      Input: elan_i2c - optimize update speed for IC Type 0x19.

Joy Zou (4):
      Input: snvs_pwrkey - make use of dev_err_probe()
      Input: snvs_pwrkey - propagate error code of platform_get_irq()
      Input: snvs_pwrkey - use local device pointer to simple code
      Input: snvs_pwrkey - add press event reporting to avoid event loss during suspend

Jun Yan (10):
      Input: cap11xx - clean up duplicate log and add probe error logs
      Input: cap11xx - remove unused register macros
      dt-bindings: input: microchip,cap11xx: Update datasheet URL and LED reg range
      dt-bindings: input: microchip,cap11xx: Add microchip,cap1126 LED reg constraints
      dt-bindings: input: microchip,cap11xx: Add reset-gpios property
      Input: cap11xx - add reset gpio support
      Input: cap11xx - refactor code for better CAP1114 support.
      Input: cap11xx - guard unsupported DT properties before parsing
      dt-bindings: input: microchip,cap11xx: Add CAP1114 support
      Input: cap11xx - add support for CAP1114

Linus Walleij (1):
      Input: isa1200 - new driver for Imagis ISA1200

Longlong Xia (1):
      Input: elan_i2c - use device-id/acpi.h for ACPI IDs

Manuel Ebner (1):
      dt-bindings: input: gpio-charlieplex-keypad: add missing parenthesis

Oliver (1):
      Input: sur40 - fix MAX_CONTACTS value based on PixelSense specification

Pengpeng Hou (2):
      Input: ims-pcu - add missing MODULE_DEVICE_TABLE()
      Input: iqs5xx - validate firmware record destination span

Pradyot Kumar Nayak (1):
      dt-bindings: input: focaltech,ft8112: Add focaltech,ft3d81 compatible

Sang-Heon Jeon (3):
      Input: pmic8xxx-keypad - remove conditional return with no effect
      Input: rmi_smbus - remove conditional return with no effect
      Input: synaptics_i2c - return 0 explicitly on success

Shashwat Agrawal (1):
      Input: synaptics - enable InterTouch on Dell Inspiron 3521

Surendra Singh Chouhan (1):
      Input: charlieplex_keypad - check gpiod_direction_output() return value

Svyatoslav Ryhel (1):
      dt-bindings: input: Document Imagis ISA1200 haptic motor driver

Zhian Liang (1):
      Input: tca8418_keypad - enable overflow mode per datasheet (SCPS215G)

Diffstat:
--------

 .../bindings/input/focaltech,ft8112.yaml           |   9 +-
 .../bindings/input/gpio-charlieplex-keypad.yaml    |   2 +-
 .../devicetree/bindings/input/imagis,isa1200.yaml  | 141 ++++++
 .../bindings/input/microchip,cap11xx.yaml          |  90 +++-
 .../devicetree/bindings/input/syna,rmi4.yaml       |  11 +-
 .../bindings/input/ti,tps65217-pwrbutton.yaml      |  42 ++
 .../bindings/input/tps65218-pwrbutton.txt          |  30 --
 drivers/input/input.c                              | 172 ++++---
 drivers/input/keyboard/Kconfig                     |  38 --
 drivers/input/keyboard/atkbd.c                     |   8 -
 drivers/input/keyboard/cap11xx.c                   | 275 +++++++----
 drivers/input/keyboard/charlieplex_keypad.c        |   4 +-
 drivers/input/keyboard/hpps2atkbd.h                | 110 -----
 drivers/input/keyboard/matrix_keypad.c             |   1 -
 drivers/input/keyboard/pmic8xxx-keypad.c           |   8 +-
 drivers/input/keyboard/samsung-keypad.c            |  39 +-
 drivers/input/keyboard/snvs_pwrkey.c               | 143 ++++--
 drivers/input/keyboard/tca8418_keypad.c            |   3 +-
 drivers/input/misc/Kconfig                         |  12 +
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/ims-pcu.c                       |   1 +
 drivers/input/misc/isa1200.c                       | 533 +++++++++++++++++++++
 drivers/input/mouse/elan_i2c.h                     |   3 +-
 drivers/input/mouse/elan_i2c_core.c                |  36 +-
 drivers/input/mouse/elan_i2c_i2c.c                 |   5 +-
 drivers/input/mouse/elan_i2c_smbus.c               |   3 +-
 drivers/input/mouse/focaltech.c                    |  17 +-
 drivers/input/mouse/psmouse-base.c                 |  90 ++--
 drivers/input/mouse/synaptics.c                    |   1 +
 drivers/input/mouse/synaptics_i2c.c                |   2 +-
 drivers/input/rmi4/rmi_f12.c                       |  16 +-
 drivers/input/rmi4/rmi_smbus.c                     |   7 +-
 drivers/input/serio/Kconfig                        |  27 ++
 drivers/input/serio/gscps2.c                       | 155 +++++-
 drivers/input/serio/i8042-acpipnpio.h              |  27 +-
 drivers/input/touchscreen/elo.c                    |   4 +-
 drivers/input/touchscreen/inexio.c                 |   4 +-
 drivers/input/touchscreen/iqs5xx.c                 |   3 +-
 drivers/input/touchscreen/mms114.c                 | 299 ++++++------
 drivers/input/touchscreen/sur40.c                  |   4 +-
 drivers/input/touchscreen/wacom_w8001.c            |  17 +-
 drivers/mfd/rohm-bd71828.c                         | 125 +++--
 drivers/mfd/rohm-bd718x7.c                         | 123 +++--
 include/linux/input.h                              |  20 +-
 include/linux/input/elan-i2c-ids.h                 |   2 +-
 45 files changed, 1901 insertions(+), 762 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/imagis,isa1200.yaml
 create mode 100644 Documentation/devicetree/bindings/input/ti,tps65217-pwrbutton.yaml
 delete mode 100644 Documentation/devicetree/bindings/input/tps65218-pwrbutton.txt
 delete mode 100644 drivers/input/keyboard/hpps2atkbd.h
 create mode 100644 drivers/input/misc/isa1200.c

Thanks.


-- 
Dmitry
