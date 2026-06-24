Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050A32F360A
	for <linux-input@vger.kernel.org>; Wed, 24 Jun 2026 02:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782267692; cv=none; b=a+RZtIVOFc9zOHcl07q2IZQc5SKZjB0fq5BfjhbTXHbDAYe+96SOQk4pq9/eepwOYYM/w6rdQtgYGQYv3WMKKW+aVjSonpuxS+NwPcQVFg218E6SdhlwNlMuwUm1MORYuKZJMgwzD1rsWI8LUteQD0I01KGLMfhN37dpuqz1Tmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782267692; c=relaxed/simple;
	bh=Nma3makbf5F4oWHD1cvxjqiv+0v4zUKMkUKJHtBYGQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CJ9ERef0nV1cHIqp46A2EiAy5aowDNHCmVle16rTIqpPrl6jvt730Gfv9WdtJJOIlF9GN7m3g+b/XjUPWHOuXulj8WaxpbJX76nVIlaT9dh/3bIsderSAMToGGKy3+QtSXpNNDjnY1C2tO0fCgsX8L5aPXszpWXpL82w/jlRbAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=owHeH0WP; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="owHeH0WP"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-30c591fb1cbso732009eec.1
        for <linux-input@vger.kernel.org>; Tue, 23 Jun 2026 19:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782267689; x=1782872489; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDEcTl/nZeYFzYjH89suWisGkUDLns6WdQFqSxdadfc=;
        b=owHeH0WPP4zTa1K+nXcupnngSHeagOZFuHe0kt4NyqZm3/AOLEeVl2CJGJlw7sV0Hh
         Aaz9BAPvNkBQTKCk2pLxH54UYcLYdfKqj3q509OKWdVRdqzip0gE0hu95+Qk3d/4L8lw
         xIutrj6TF3n0SkHI22JCjxgTa29VNVEwRpIjMfO5wXZJk0e09mwC6+dlpyZ/S3m+peFZ
         JiqyTrs9+goR6cD3zI/em2pg2EmY/deGhYOi4CoXFbMJ0miU2Suqkf6Fadj8SBwB8b4G
         zhqUEjdirumJ7BTjbb0wdC3+k/Yhnz7lpyKc1ucz5ThuHL8KotDTRjsroX6xAaupnWtw
         F34A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782267689; x=1782872489;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vDEcTl/nZeYFzYjH89suWisGkUDLns6WdQFqSxdadfc=;
        b=AoCmDcIq+VYOngw8hdpeTpbESs292F7V1SCxHMJpgx3FsP7MmQnFgYIdMJ7oyDJmPQ
         HCEVqAR8erlY6MRZCK52+Mn128hsGXDf//K1LEqAum9M1S847RHsjjCc1wQn76k5yDE2
         Y1ef8RWWnOw6op8GTO81HQej+nct0EF+SLkkb0DLHnhURL2wurQbLJYoTMhhmhNx0esD
         GUCv6MlM4qACc+WLiCnYinqRq16vW30YnHXFTSPGTKG/OzW3WwjR8FAChw4KkeWanP1Z
         jTMNi+ZU21oWzFjjfx+OBU4n8B5sLi2PTEukVS/mi7duJu6sxli0CNNYQaxb/Cj/WDhj
         +jbA==
X-Forwarded-Encrypted: i=1; AHgh+Ro/llHpHtjkI5RKa6X/Nu3bsizLum9ok1fT9sRAEqVHAdGtpXhMabcqm+lxEGEJSpNLv3/9vNc9W8IlLw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQrn6CCAV8x5eeWVyw++NhUu0jdrwh5as/lfi227FvX/7IMLJv
	G6zMSCA6Rm41OXsbHVT6d42SxdujjlyVTb3s3CqZC6zHUYeF/Kl9mkTv
X-Gm-Gg: AfdE7cnUR6fZDTVL396JzjdfK2eC6tgrdti+L9SI15HAMlOX61h7Xqf0DYcRWeEPgkG
	z/TgaOgnHg32FxLkXAEVzYd55A41WbFd2uq/nP3O1meyGvEYH+DZOVndAhf84NuAqTT4/Rl8xlG
	M6nQJU4PLPCaEKnetGN75ltbxzSd4+nwqM/k5p6F72l4KDemWIcsRmI8c5FkgsUnI90oJSWlTlq
	g+cQudzZovHFH6OhHFYeOC7p+ZVhAO25XuyDRPNn83APs6CahiILqCwuI9/EVb76Sw/XSrC13ce
	aPpCGLvpMA3g6X6Ya1hGzCrRK/KXhOb/bMqp/TkHl2LncGwln8lGJ/gu/p/OrN2y7E7jWsA80y0
	sxWcaZnhYJ3jKwVDFLanAjoZ6phZpSjpcZe7JqtGqfuF5WTXlYig3NutpmZWp29FpTdAim+mVkj
	ciPuqB69tvq761JnIcPWz5Z/s1TJKWHzi/E4Ai4cTvYmBAyVMkTh6Jvg==
X-Received: by 2002:a05:7300:80cf:b0:2f2:6dde:df54 with SMTP id 5a478bee46e88-30c68e904d5mr1852517eec.33.1782267688995;
        Tue, 23 Jun 2026 19:21:28 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:6026:1e6d:4a80:9bd0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1ba1c32csm21918345eec.6.2026.06.23.19.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 19:21:28 -0700 (PDT)
Date: Tue, 23 Jun 2026 19:21:25 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v7.2-rc0
Message-ID: <ajs_Hmo3Zo4aEFZ7@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v7.2-rc0

to receive updates for the input subsystem. You will get:

- A new driver for Wacom W9000-series penabled touchscreens

- Updates to STM FTS driver adding support for reset line and preparing
  the driver for STMFTS5 support
  
- Updates to RMI4 and IMS PCU drivers hardening the code

- Support for half-duplex mode restored in ADS7846 driver

- Updates to driver's device_id tables to use named initializers

- Removal of no longer used PCAP keys and touchscreen drivers (support
  for the ezx series of phones was removed in 2022)

- Removal of xilinx_ps2 driver which is no longer used either

- Updates to userio to allow setting up additional serio port
  characteristics (such as id, extra and proto)

- Assorted hardening and cleanup fixes for other drivers.


Changelog:
---------

Aaro Koskinen (1):
      Input: ads7846 - restore half-duplex support

Arnd Bergmann (2):
      Input: pcap_keys - remove unused driver
      Input: pcap_ts - remove unused driver

Bryam Vargas (4):
      Input: touchwin - reset the packet index on every complete packet
      Input: mms114 - reject an oversized device packet size
      Input: goodix - clamp the device-reported contact count
      Input: iforce - bound the device-reported force-feedback effect index

Colin Ian King (1):
      Input: lm8323 - remove space before newline

David Heidelberg (6):
      Input: stmfts - fix the MODULE_LICENSE() string
      Input: stmfts - use dev struct directly
      Input: stmfts - switch to devm_regulator_bulk_get_const
      Input: stmfts - abstract reading information from the firmware
      Input: stmfts - disable regulators and disable irq when power on fails
      dt-bindings: input: touchscreen: st,stmfts: Introduce reset GPIO

Dmitry Torokhov (40):
      Input: stmfts - fix formatting issues
      Input: atmel_mxt_ts - use __free() for obuf in mxt_object_show
      Input: atlas_btns - modernize the driver
      Input: ims-pcu - only expose sysfs attributes on control interface
      Input: ims-pcu - fix logic error in packet reset
      Input: ims-pcu - release data interface on disconnect
      Input: ims-pcu - fix use-after-free and double-free in disconnect
      Input: ims-pcu - fix type confusion in CDC union descriptor parsing
      Input: ims-pcu - fix firmware leak in async update
      Input: ims-pcu - fix race condition in reset_device sysfs callback
      Input: ims-pcu - validate control endpoint type
      Input: ims-pcu - fix out-of-bounds read in ims_pcu_irq() debug logging
      Input: ims-pcu - fix DMA mapping violation in line setup
      Input: ims-pcu - add response length checks
      Input: ims-pcu - fix potential infinite loop in CDC union descriptor parsing
      Input: ipaq-micro-keys - fix potential deadlock
      Input: ipaq-micro-keys - add length check in micro_key_receive
      Input: rmi4 - fix register descriptor address calculation
      Input: rmi4 - refactor register descriptor parsing
      Input: rmi4 - fix type overflow in register counts
      Input: rmi4 - fix num_subpackets overflow in register descriptor
      Input: rmi4 - initialize attn_fifo properly
      Input: rmi4 - fix memory leak in rmi_set_attn_data()
      Input: rmi4 - iterative IRQ handler
      Input: rmi4 - fix bit count in bitmap_copy()
      Input: rmi4 - fix limit in rmi_register_desc_has_subpacket()
      Input: rmi4 - use local presence map in rmi_read_register_desc()
      Input: rmi4 - refactor function allocation and registration
      Input: rmi4 - use kzalloc_flex() for struct rmi_function
      Input: rmi4 - refactor F12 probe function
      Input: rmi4 - change reg_size type to u32
      Input: rmi4 - use unaligned access helpers in F12
      Input: rmi4 - use flexible array member for IRQ masks in F12
      Input: rmi4 - use devm_kmalloc for F12 data packet buffer
      Input: rmi4 - use sizeof(*ptr) and idiomatic checks in f12 allocators
      Input: rmi4 - simplify size calculations in F12
      Input: rmi4 - propagate proper error code in F12 sensor tuning
      Input: rmi4 - update formatting in F12
      Input: stop force-feedback timer when unregistering input devices
      Input: mms114 - fix touch indexing for MMS134S and MMS136

Elliot Tester (1):
      Input: remove changelogs

Haoxiang Li (1):
      Input: synaptics-rmi4 - unregister function handlers on physical driver registration failure

Hendrik Noack (2):
      dt-bindings: Input: Add Wacom W9000-series penabled touchscreens
      Input: Add support for Wacom W9000-series penabled touchscreens

Kris Bahnsen (1):
      Input: ads7846 - don't use scratch for tx_buf when clearing register

Petr Hodina (2):
      Input: stmfts - use client to make future code cleaner
      Input: stmfts - add optional reset GPIO support

Ranjan Kumar (1):
      Input: elan_i2c - prevent division by zero and arithmetic underflow

Ricardo Ribalda (1):
      Input: atmel_mxt_ts - set byte_offset as signed

Rosen Penev (3):
      Input: xilinx_ps2 - remove driver
      Input: apbps2 - simplify resource mapping and IRQ retrieval
      Input: ipaq-micro-keys - simplify allocation

Uwe Kleine-König (The Capable Hub) (3):
      Input: Use named initializers for arrays of i2c_device_data
      Input: iqs5xx - drop unused i2c driver_data
      Input: Drop unused assignments from pnp_device_id arrays

Vicki Pfau (2):
      Input: userio - update maintainer name
      Input: userio - allow setting other id values

Yuki Horii (1):
      Input: tsc2007 - reduce I2C transactions for Z2 read

Diffstat:
--------

 .../bindings/input/touchscreen/st,stmfts.yaml      |   4 +
 .../input/touchscreen/wacom,w9007a-lt03.yaml       |  73 ++++
 Documentation/input/userio.rst                     |  25 +-
 MAINTAINERS                                        |   2 +-
 drivers/input/ff-memless.c                         |  27 +-
 drivers/input/gameport/ns558.c                     |  46 +--
 drivers/input/input.c                              |   3 +
 drivers/input/joystick/adafruit-seesaw.c           |   2 +-
 drivers/input/joystick/as5011.c                    |   2 +-
 drivers/input/joystick/iforce/iforce-packets.c     |  18 +-
 drivers/input/joystick/qwiic-joystick.c            |   2 +-
 drivers/input/keyboard/adp5588-keys.c              |   4 +-
 drivers/input/keyboard/cap11xx.c                   |  14 +-
 drivers/input/keyboard/cypress-sf.c                |   2 +-
 drivers/input/keyboard/dlink-dir685-touchkeys.c    |   2 +-
 drivers/input/keyboard/ipaq-micro-keys.c           |  24 +-
 drivers/input/keyboard/lm8323.c                    |   4 +-
 drivers/input/keyboard/lm8333.c                    |   2 +-
 drivers/input/keyboard/max7359_keypad.c            |   2 +-
 drivers/input/keyboard/mpr121_touchkey.c           |   2 +-
 drivers/input/keyboard/qt1070.c                    |   2 +-
 drivers/input/keyboard/qt2160.c                    |   2 +-
 drivers/input/keyboard/tca8418_keypad.c            |   2 +-
 drivers/input/keyboard/tm2-touchkey.c              |   2 +-
 drivers/input/misc/Kconfig                         |  10 -
 drivers/input/misc/Makefile                        |   1 -
 drivers/input/misc/ad714x-i2c.c                    |  10 +-
 drivers/input/misc/adxl34x-i2c.c                   |   2 +-
 drivers/input/misc/apanel.c                        |   2 +-
 drivers/input/misc/atlas_btns.c                    | 109 ++---
 drivers/input/misc/atmel_captouch.c                |   2 +-
 drivers/input/misc/bma150.c                        |   6 +-
 drivers/input/misc/cma3000_d0x_i2c.c               |   2 +-
 drivers/input/misc/da7280.c                        |   2 +-
 drivers/input/misc/drv260x.c                       |   8 +-
 drivers/input/misc/drv2665.c                       |   2 +-
 drivers/input/misc/drv2667.c                       |   2 +-
 drivers/input/misc/ims-pcu.c                       | 131 +++++-
 drivers/input/misc/kxtj9.c                         |   2 +-
 drivers/input/misc/mma8450.c                       |   2 +-
 drivers/input/misc/pcap_keys.c                     | 125 ------
 drivers/input/misc/pcf8574_keypad.c                |   2 +-
 drivers/input/misc/yealink.c                       |   9 -
 drivers/input/mouse/cyapa.c                        |   2 +-
 drivers/input/mouse/elan_i2c_core.c                |  38 +-
 drivers/input/mouse/synaptics_i2c.c                |   2 +-
 drivers/input/rmi4/rmi_2d_sensor.h                 |   4 +-
 drivers/input/rmi4/rmi_bus.c                       |  34 +-
 drivers/input/rmi4/rmi_bus.h                       |   1 +
 drivers/input/rmi4/rmi_driver.c                    | 204 ++++++----
 drivers/input/rmi4/rmi_driver.h                    |  13 +-
 drivers/input/rmi4/rmi_f11.c                       |   2 +-
 drivers/input/rmi4/rmi_f12.c                       | 415 +++++++++----------
 drivers/input/rmi4/rmi_i2c.c                       |   2 +-
 drivers/input/rmi4/rmi_smbus.c                     |   2 +-
 drivers/input/serio/Kconfig                        |  10 -
 drivers/input/serio/Makefile                       |   1 -
 drivers/input/serio/apbps2.c                       |   7 +-
 drivers/input/serio/i8042-acpipnpio.h              |  56 +--
 drivers/input/serio/userio.c                       |  34 +-
 drivers/input/serio/xilinx_ps2.c                   | 363 -----------------
 drivers/input/tablet/aiptek.c                      |  31 --
 drivers/input/touchscreen/Kconfig                  |  22 +-
 drivers/input/touchscreen/Makefile                 |   2 +-
 drivers/input/touchscreen/ad7879-i2c.c             |   4 +-
 drivers/input/touchscreen/ads7846.c                | 173 +++++++-
 drivers/input/touchscreen/ar1021_i2c.c             |   2 +-
 drivers/input/touchscreen/atmel_mxt_ts.c           |  23 +-
 drivers/input/touchscreen/auo-pixcir-ts.c          |   2 +-
 drivers/input/touchscreen/bu21013_ts.c             |   2 +-
 drivers/input/touchscreen/bu21029_ts.c             |   2 +-
 drivers/input/touchscreen/cy8ctma140.c             |   2 +-
 drivers/input/touchscreen/cy8ctmg110_ts.c          |   2 +-
 drivers/input/touchscreen/cyttsp5.c                |   2 +-
 drivers/input/touchscreen/cyttsp_i2c.c             |   2 +-
 drivers/input/touchscreen/eeti_ts.c                |   2 +-
 drivers/input/touchscreen/egalax_ts.c              |   2 +-
 drivers/input/touchscreen/elants_i2c.c             |   6 +-
 drivers/input/touchscreen/exc3000.c                |   8 +-
 drivers/input/touchscreen/goodix.c                 |   5 +-
 drivers/input/touchscreen/hideep.c                 |   2 +-
 drivers/input/touchscreen/himax_hx83112b.c         |   4 +-
 drivers/input/touchscreen/hynitron-cst816x.c       |   2 +-
 drivers/input/touchscreen/ili210x.c                |   8 +-
 drivers/input/touchscreen/ilitek_ts_i2c.c          |   2 +-
 drivers/input/touchscreen/iqs5xx.c                 |   6 +-
 drivers/input/touchscreen/max11801_ts.c            |   2 +-
 drivers/input/touchscreen/melfas_mip4.c            |   2 +-
 drivers/input/touchscreen/migor_ts.c               |   2 +-
 drivers/input/touchscreen/mms114.c                 |  26 +-
 drivers/input/touchscreen/novatek-nvt-ts.c         |   4 +-
 drivers/input/touchscreen/pcap_ts.c                | 252 ------------
 drivers/input/touchscreen/pixcir_i2c_ts.c          |   4 +-
 drivers/input/touchscreen/raydium_i2c_ts.c         |   4 +-
 drivers/input/touchscreen/rohm_bu21023.c           |   2 +-
 drivers/input/touchscreen/s6sy761.c                |   2 +-
 drivers/input/touchscreen/silead.c                 |  12 +-
 drivers/input/touchscreen/sis_i2c.c                |   4 +-
 drivers/input/touchscreen/st1232.c                 |   4 +-
 drivers/input/touchscreen/stmfts.c                 | 162 +++++---
 drivers/input/touchscreen/touchwin.c               |  15 +-
 drivers/input/touchscreen/tsc2004.c                |   2 +-
 drivers/input/touchscreen/tsc2007_core.c           |   8 +-
 drivers/input/touchscreen/wacom_i2c.c              |   2 +-
 drivers/input/touchscreen/wacom_w9000.c            | 444 +++++++++++++++++++++
 drivers/input/touchscreen/wdt87xx_i2c.c            |   2 +-
 drivers/input/touchscreen/zet6223.c                |   2 +-
 drivers/input/touchscreen/zforce_ts.c              |   2 +-
 include/linux/input.h                              |   3 +
 include/uapi/linux/userio.h                        |   7 +-
 110 files changed, 1673 insertions(+), 1501 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/wacom,w9007a-lt03.yaml
 delete mode 100644 drivers/input/misc/pcap_keys.c
 delete mode 100644 drivers/input/serio/xilinx_ps2.c
 delete mode 100644 drivers/input/touchscreen/pcap_ts.c
 create mode 100644 drivers/input/touchscreen/wacom_w9000.c

Thanks.


-- 
Dmitry
