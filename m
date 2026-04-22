Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECD9311958
	for <linux-input@vger.kernel.org>; Wed, 22 Apr 2026 15:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776870342; cv=none; b=rnY1GvpE7K3OXFAWtAjuxnaxdN0rNHG2p/8zxlyqpXUb+cbGzQqWWdFMDWUgOu0sNvEsoHh8in0Kh5piwfsQHqawLheiYiXlC9/EBmNQgxD65Q+rKjjSgUmXfVk5P+Ov77sIluYDozYOKOyvUuvJbXzkQjYWeQvZX7HXFa9fjsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776870342; c=relaxed/simple;
	bh=WiL7XYIFIpxFsfTFfe+7GgyL8ThoSYS/T6J0skjp+48=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=md15aZtFZzwRPBzTYO5O6Yswa0gk0KMp9Gbh9ZgrXcX7os0ddPg4ge9qpiZA/P9yTt/iG3JJd9huvIP1Gw6fbe9QQ49ssMMwrlr0lSBmcQjnXrDfY6bo2JhcmOSycmM0AvITw70sOED23RbWAeHk9DGK9Y91VD9JxTDdE4gTkWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IloShMvu; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IloShMvu"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2d8ffdc31d0so2349303eec.0
        for <linux-input@vger.kernel.org>; Wed, 22 Apr 2026 08:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776870340; x=1777475140; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QzGZi4JVjwbhBzZOR2A8PN3CxGyWr8/N4/SF0g9BOr0=;
        b=IloShMvuWBG0P9exXrsSPPQY/E7Y0GlZvAWnTYDluwmW/oO0FoW42yXf06Mv6C3rug
         n0mnAK+Owu4SplVjPDoQZWuIIs8Cr7DC6GFm+KkHmZ1PDldPEJsJqf5mnoFkf4uDPnDx
         fBta2vct36pkya3qOE8/luHnqYknc2DCoF/yT1LVqPAlG19VfBt7MBvaHd3u9xQiIzUZ
         0c62ujYlZGlMwhLlFLkaAIq0oWP/9VL4zbi2nDjFLukOAx+b+jwCPqtI9brkL5SeonIr
         VwXg6IzwDFjuWFQLb4LYRzQfZ0JOhqd95JIw0mAMTsNtKrtDMvcwMuGo1gsSEmZX2ttK
         rfHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776870340; x=1777475140;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QzGZi4JVjwbhBzZOR2A8PN3CxGyWr8/N4/SF0g9BOr0=;
        b=mV/q09vdAjp9YBmiPQB3Z14Q0f53YXXd2Cfh++jSE84wGdFgy5bFe6oHK9XI9y1EeM
         Ov0y9EfmJl022R4oLV3Vw87ph5/QrG5NlulyocDDVa1w+5fVV9tyUO3KUkkAUE47gaG3
         c6FwK89t0DEVrqsNbrrYm1Z/meEPkw4yZcW68KQDQgcoYsSO7ho/tHOSWkX/mjKAklVu
         a9plmOqEdGgbcfv+XlODGdWC4fXMBz5Bx+QFVgeL5rs8IcYvKZYkBovTc/nD1CTuf7Zv
         W+rjAgu+8btNUYofDhCADukvtIDE+gMv1wbV3Iwq3YIhDVvJeh9GD/7s1cNn/eYmQxD5
         CWvQ==
X-Forwarded-Encrypted: i=1; AFNElJ9sZxHBIF4mXJO28LuVDmKKYPasO1E6hDzVHMq0zBnCTwipVg++4k/W8V/McskkQrvnG5hT0L3lE4FxNg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxeHfSqTgta5qkuK+f0QFPSY2KGLJuzYSWC/rj0o6FAS8GDA91w
	fxKZfhd60ogR0vChCDUql+xcLjtnadvgnBYANLpXoG5RsonNyf1EN43F
X-Gm-Gg: AeBDievCmb8oIH08h1JjsFEKsgNVm0VmEffzzzVZusxquRkhDwSGd1NNcrr/XBUIMxI
	ScHgeNQtGqsi20xx3Ij/u2VAOvfjJmYfZ6FjIEKYKkfv0Ryy9wSKY6UCa0k9l/I6rzR7v05yTc6
	YCFWwPmIujTIzvnjnZHlw21lZdHgu7QvV+WjiLXvSrlb9OaLsT99eTwETbADt6ZNRZjm4a6v2Wi
	8nW2DB5ACfyz1FnvlqXef4pdHlqGnUdoTrTUGuiZ/IxzqnQ3xDG1ifQrEiD/vAp237fWtoyBAm9
	WPECxQXdP7KJolbVQviKrdj+WCCHF/CePnnL1doZRHc8VU+bgQeRWra9QgPE6SCWvjENgSXctET
	UeCM7clfi4RTIp7CkjbX3yQOneAUKQ14rd6rF828tdZMv3hORVqaXlO0RlfdETmnh4HCja6EvXA
	aXkQv24NesMchpgNq0pLpIDy1TD/TwRq4t2Ut/mJsdh2/DMdpg4DwOyHkaHTDxSTT3L6c5H5DtG
	LQ=
X-Received: by 2002:a05:7301:3f07:b0:2da:b77a:d7a0 with SMTP id 5a478bee46e88-2e46519e391mr13321217eec.9.1776870339360;
        Wed, 22 Apr 2026 08:05:39 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:7b40:6bc2:138d:fb7c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ea8e4b373dsm6812599eec.6.2026.04.22.08.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 08:05:38 -0700 (PDT)
Date: Wed, 22 Apr 2026 08:05:35 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v7.1-rc0
Message-ID: <aejjiyVgBhKsw2-4@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v7.1-rc0

to receive updates for the input subsystem. You will get:

- a new charlieplex GPIO keypad driver

- an update to aw86927 driver to support 86938 chip

- an update for Chrome OS EC keyboard driver to support Fn-<key> keymap
  extension

- an UAF fix in debugfs teardown in EDT touchscreen driver

- a number of conversions for input drivers to use guard() and __free()
  cleanup primitives

- several drivers for bus mice (inport, logibm) and other very old
  devices have been removed

- OLPC HGPK PS/2 protocol has been removed as it's been broken and
  inactive for 10 something years

- dedicated kpsmoused has been removed from psmouse driver 

- other assorted cleanups and fixups.

Changelog:
---------

Ariel Silver (1):
      Input: atkbd - validate scancode in firmware keymap entries

Bhushan Shah (1):
      dt-bindings: input: touchscreen: edt-ft5x06: Add FocalTech FT3519

Dmitry Torokhov (57):
      Input: cros_ec_keyb - use u8 instead of uint8_t
      Input: cros_ec_keyb - use BIT() macro instead of open-coding shifts
      Input: cros_ec_keyb - simplify cros_ec_keyb_work()
      Input: cros_ec_keyb - do not allocate keyboard state separately
      Input: cros_ec_keyb - factor out column processing
      Input: atkbd - use __free() cleanup facility in when parsing FW keymap
      Input: atkbd - use dev_warn_ratelimited()
      Input: atkbd - switch to using explicitly sized types
      Input: atkbd - fix various formatting issues
      Input: hgpk - remove protocol support
      Input: alps - use standard workqueue when registering supplemental device
      Input: psmouse - remove dedicated kpsmoused workqueue
      Input: ad7877 - use guard notation when acquiring mutexes/locks
      Input: ad7879 - use guard notation when acquiring mutexes
      Input: ads7846 - switch to using cleanup functions
      Input: atmel_mxt_ts - switch to using cleanup functions
      Input: auo-pixcir-ts - use guard notation when acquiring mutexes
      Input: bu21029_ts - use guard notation when acquiring mutex
      Input: chipone_icn8318 - use guard notation when acquiring mutex
      Input: cyttsp - use guard notation when acquiring mutex
      Input: edt-ft5x06 - use guard notation when acquiring mutex
      Input: eeti_ts - use guard notation when acquiring mutexes
      Input: ektf2127 - use guard notation when acquiring mutex
      Input: elants_i2c - switch to using cleanup facilities
      Input: elo - use guard notation when acquiring mutex
      Input: exc3000 - use guard notation when acquiring mutex
      Input: goodix - switch to using cleanup functions in firmware code
      Input: hideep - switch to using cleanup functions
      Input: hycon-hy46xx - use guard notation when acquiring mutex
      Input: imagis - use guard notation when acquiring mutex
      Input: imx6ul_tsc - use guard notation when acquiring mutex
      Input: ipaq-micro-ts - use guard notation when acquiring mutex/spinlock
      Input: iqs5xx - switch to using cleanup functions
      Input: iqs5xx - simplify parsing of firmware blob
      Input: iqs7211 - use cleanup facility for fwnodes
      Input: lpc32xx_ts - use guard notation when acquiring mutex
      Input: melfas_mip4 - switch to using cleanup functions
      Input: mk712 - use guard notation when acquiring spinlock
      Input: mms114 - use guard notation when acquiring mutex
      Input: msg2638 - use guard notation when acquiring mutex
      Input: mxs-lradc-ts - use guard notation when acquiring spinlock
      Input: novatek-nvt-ts - use guard notation when acquiring mutex
      Input: pixcir_i2c_ts - use guard notation when acquiring mutex
      Input: raydium_i2c_ts - switch to using cleanup functions
      Input: stmfts - use guard notation when acquiring mutex
      Input: sur40 - use guard notation when acquiring spinlock
      Input: sx8654 - use guard notation when acquiring spinlock
      Input: sx8654 - use IRQF_NOAUTOEN when requesting interrupt
      Input: tsc2007 - use guard notation when acquiring mutexes
      Input: wdt87xx_i2c - switch to using cleanup functions
      Input: wm97xx - use guard notation when acquiring mutex
      Input: zinitix - use guard notation when acquiring mutex
      Input: inport - remove driver
      Input: logibm - remove driver
      Input: mk712 - remove driver
      Input: ct82c710 - remove driver
      Input: edt-ft5x06 - fix use-after-free in debugfs teardown

Duoming Zhou (1):
      Input: psmouse - replace flush_workqueue() with disable_delayed_work_sync()

Eduard Bostina (1):
      dt-bindings: input: touchscreen: Convert TS-4800 to DT schema

Elliot Tester (1):
      Input: xpad - remove stale TODO and changelog header

Ethan Carter Edwards (1):
      Input: imx_keypad - fix spelling mistake "Colums" -> "Columns"

Fabio Baltieri (2):
      Input: export input_default_setkeycode
      Input: cros_ec_keyb - add function key support

Griffin Kroah-Hartman (3):
      Input: aw86927 - respect vibration magnitude levels
      dt-bindings: input: awinic,aw86927: Add Awinic AW86938
      Input: aw86927 - add support for Awinic AW86938

Hugo Villeneuve (5):
      dt-bindings: input: matrix-keymap: fix key board wording
      dt-bindings: input: add debounce-delay-ms common property
      dt-bindings: input: add settling-time-us common property
      dt-bindings: input: add GPIO charlieplex keypad
      Input: charlieplex_keypad - add GPIO charlieplex keypad

Johan Hovold (4):
      Input: keyspan-remote - refactor endpoint lookup
      Input: appletouch - refactor endpoint lookup
      Input: synaptics_usb - refactor endpoint lookup
      Input: usbtouchscreen - refactor endpoint lookup

Langyan Ye (2):
      dt-bindings: input: Add Parade TC3408 touchscreen controller
      HID: i2c-hid: elan: Add parade-tc3408 timing

Marek Vasut (1):
      dt-bindings: touchscreen: trivial-touch: Move allOf: after required:

Max Brener (1):
      Input: libps2 - embed WARN_ON(1) macros into their enclosing if statements

Michael Tretter (2):
      Input: st1232 - read firmware version and revision
      Input: st1232 - expose firmware version via sysfs

Oliver Neukum (2):
      Input: aiptek - use HID headers
      Input: pegasus_notetaker - use HID defines

Pengpeng Hou (2):
      Input: gf2k - skip invalid hat lookup values
      Input: aiptek - validate raw macro indices before updating state

Rafael J. Wysocki (1):
      Input: atlas - convert ACPI driver to a platform one

Sanjay Govind (1):
      Input: xpad - add RedOctane Games vendor id

Seungjin Bae (1):
      Input: ims-pcu - fix heap-buffer-overflow in ims_pcu_process_data()

Thorsten Blum (3):
      Input: adxl34x - drop redundant error variable in adxl34x_i2c_probe
      Input: qt1050 - inline i2c_check_functionality check
      Input: qt1070 - inline i2c_check_functionality check

Val Packett (1):
      Input: goodix-berlin - report a resolution of 10 units/mm

Yauhen Kharuzhy (5):
      Input: drv260x - add I2C IDs for all device variants
      Input: drv260x - sort all #include alphabetically
      Input: drv260x - add support for ACPI-enumerated devices
      Input: drv260x - handle calibration timeout
      Input: drv260x - fix unbalanced regulator_disable() call

bui duc phuc (2):
      dt-bindings: input: touchscreen: sitronix,st1232: Add wakeup-source
      Input: mpr121 - drop redundant wakeup handling

Diffstat:
--------

 .../bindings/auxdisplay/holtek,ht16k33.yaml        |    5 +-
 .../devicetree/bindings/input/awinic,aw86927.yaml  |    7 +-
 .../bindings/input/cirrus,ep9307-keypad.yaml       |    7 +-
 .../bindings/input/gpio-charlieplex-keypad.yaml    |  108 ++
 .../bindings/input/gpio-matrix-keypad.yaml         |    5 +-
 Documentation/devicetree/bindings/input/input.yaml |   16 +
 .../devicetree/bindings/input/matrix-keymap.yaml   |    4 +-
 .../bindings/input/mediatek,mt6779-keypad.yaml     |    1 +
 .../devicetree/bindings/input/parade,tc3408.yaml   |   68 ++
 .../bindings/input/touchscreen/edt-ft5x06.yaml     |   30 +-
 .../input/touchscreen/sitronix,st1232.yaml         |    4 +
 .../input/touchscreen/technologic,ts4800-ts.yaml   |   42 +
 .../bindings/input/touchscreen/trivial-touch.yaml  |    6 +-
 .../bindings/input/touchscreen/ts4800-ts.txt       |   11 -
 .../devicetree/bindings/mfd/fsl,mc13xxx.yaml       |    2 -
 MAINTAINERS                                        |    7 +
 drivers/hid/i2c-hid/i2c-hid-of-elan.c              |    8 +
 drivers/input/input.c                              |   23 +-
 drivers/input/joystick/gf2k.c                      |    6 +-
 drivers/input/joystick/xpad.c                      |   35 +-
 drivers/input/keyboard/Kconfig                     |   14 +
 drivers/input/keyboard/Makefile                    |    1 +
 drivers/input/keyboard/atkbd.c                     |  133 ++-
 drivers/input/keyboard/charlieplex_keypad.c        |  232 +++++
 drivers/input/keyboard/cros_ec_keyb.c              |  261 +++--
 drivers/input/keyboard/imx_keypad.c                |    4 +-
 drivers/input/keyboard/mpr121_touchkey.c           |    8 -
 drivers/input/keyboard/qt1050.c                    |    3 +-
 drivers/input/keyboard/qt1070.c                    |    3 +-
 drivers/input/misc/adxl34x-i2c.c                   |    5 +-
 drivers/input/misc/atlas_btns.c                    |   22 +-
 drivers/input/misc/aw86927.c                       |   66 +-
 drivers/input/misc/drv260x.c                       |   50 +-
 drivers/input/misc/ims-pcu.c                       |   32 +-
 drivers/input/misc/keyspan_remote.c                |   22 +-
 drivers/input/mouse/Kconfig                        |   36 -
 drivers/input/mouse/Makefile                       |    3 -
 drivers/input/mouse/alps.c                         |   11 +-
 drivers/input/mouse/alps.h                         |    4 +-
 drivers/input/mouse/appletouch.c                   |   21 +-
 drivers/input/mouse/hgpk.c                         | 1063 --------------------
 drivers/input/mouse/hgpk.h                         |   61 --
 drivers/input/mouse/inport.c                       |  177 ----
 drivers/input/mouse/logibm.c                       |  166 ---
 drivers/input/mouse/psmouse-base.c                 |   51 +-
 drivers/input/mouse/psmouse.h                      |    6 +-
 drivers/input/mouse/synaptics_usb.c                |   23 +-
 drivers/input/serio/Kconfig                        |   13 -
 drivers/input/serio/Makefile                       |    1 -
 drivers/input/serio/ct82c710.c                     |  239 -----
 drivers/input/serio/libps2.c                       |   12 +-
 drivers/input/tablet/aiptek.c                      |   20 +-
 drivers/input/tablet/pegasus_notetaker.c           |    7 +-
 drivers/input/touchscreen/Kconfig                  |   12 -
 drivers/input/touchscreen/Makefile                 |    1 -
 drivers/input/touchscreen/ad7877.c                 |   32 +-
 drivers/input/touchscreen/ad7879.c                 |   46 +-
 drivers/input/touchscreen/ads7846.c                |   44 +-
 drivers/input/touchscreen/atmel_mxt_ts.c           |  290 +++---
 drivers/input/touchscreen/auo-pixcir-ts.c          |   43 +-
 drivers/input/touchscreen/bu21029_ts.c             |    8 +-
 drivers/input/touchscreen/chipone_icn8318.c        |    8 +-
 drivers/input/touchscreen/cyttsp_core.c            |   20 +-
 drivers/input/touchscreen/edt-ft5x06.c             |   90 +-
 drivers/input/touchscreen/eeti_ts.c                |   27 +-
 drivers/input/touchscreen/ektf2127.c               |    8 +-
 drivers/input/touchscreen/elants_i2c.c             |   91 +-
 drivers/input/touchscreen/elo.c                    |   32 +-
 drivers/input/touchscreen/exc3000.c                |   31 +-
 drivers/input/touchscreen/goodix_berlin_core.c     |    8 +
 drivers/input/touchscreen/goodix_fwupload.c        |   29 +-
 drivers/input/touchscreen/hideep.c                 |   54 +-
 drivers/input/touchscreen/hycon-hy46xx.c           |   31 +-
 drivers/input/touchscreen/imagis.c                 |   30 +-
 drivers/input/touchscreen/imx6ul_tsc.c             |   19 +-
 drivers/input/touchscreen/ipaq-micro-ts.c          |    8 +-
 drivers/input/touchscreen/iqs5xx.c                 |  190 ++--
 drivers/input/touchscreen/iqs7211.c                |   24 +-
 drivers/input/touchscreen/lpc32xx_ts.c             |    8 +-
 drivers/input/touchscreen/melfas_mip4.c            |  121 +--
 drivers/input/touchscreen/mk712.c                  |  215 ----
 drivers/input/touchscreen/mms114.c                 |   20 +-
 drivers/input/touchscreen/msg2638.c                |   19 +-
 drivers/input/touchscreen/mxs-lradc-ts.c           |    7 +-
 drivers/input/touchscreen/novatek-nvt-ts.c         |    8 +-
 drivers/input/touchscreen/pixcir_i2c_ts.c          |   38 +-
 drivers/input/touchscreen/raydium_i2c_ts.c         |   56 +-
 drivers/input/touchscreen/st1232.c                 |   67 +-
 drivers/input/touchscreen/stmfts.c                 |   63 +-
 drivers/input/touchscreen/sur40.c                  |   23 +-
 drivers/input/touchscreen/sx8654.c                 |   20 +-
 drivers/input/touchscreen/tsc2007_core.c           |    7 +-
 drivers/input/touchscreen/tsc2007_iio.c            |    9 +-
 drivers/input/touchscreen/usbtouchscreen.c         |   43 +-
 drivers/input/touchscreen/wdt87xx_i2c.c            |   44 +-
 drivers/input/touchscreen/wm97xx-core.c            |   57 +-
 drivers/input/touchscreen/zinitix.c                |   19 +-
 include/linux/input.h                              |    4 +
 98 files changed, 1815 insertions(+), 3374 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/gpio-charlieplex-keypad.yaml
 create mode 100644 Documentation/devicetree/bindings/input/parade,tc3408.yaml
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/technologic,ts4800-ts.yaml
 delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/ts4800-ts.txt
 create mode 100644 drivers/input/keyboard/charlieplex_keypad.c
 delete mode 100644 drivers/input/mouse/hgpk.c
 delete mode 100644 drivers/input/mouse/hgpk.h
 delete mode 100644 drivers/input/mouse/inport.c
 delete mode 100644 drivers/input/mouse/logibm.c
 delete mode 100644 drivers/input/serio/ct82c710.c
 delete mode 100644 drivers/input/touchscreen/mk712.c

Thanks.

-- 
Dmitry
