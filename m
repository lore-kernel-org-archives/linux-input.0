Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39D52744F
	for <linux-input@vger.kernel.org>; Sun, 15 Feb 2026 03:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771126783; cv=none; b=RZzg4lOp8GdA9THILt4fyRM7jeiWBudfD/l/DFeoeDuqoRjCPpOY2K1vSaUU/80pua/EJC8xmxZfJBgqExR+vpWzCo3mBnlyIde8mSljczVnYwKfQXD0KStAd5benR4T3Dn6BwwwoqU44Ru21Pl7YTaeJpwuf7WRFD77fSWgZO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771126783; c=relaxed/simple;
	bh=Xo79RpGcOW6m2/6ugFI5xMoZyaeRVuMO1k0/Jmr6RAE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MKvOqAD76zjseQjARFocvsPckgaKkAgT9fbkh7Z+IwbyCEf13UxMPGN4SeXev0G9hmkLvrgnZvF5UWQQGn+i8hSDDK3HU5ubdnIOPG1VY+9Z6PjUaWlUifwapocqZTCmtm6yljCOu7fLUca9r5ZIz3nyZZds+VQLl/rwYfiNlMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PtoDWQTx; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtoDWQTx"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2ba64b5a53aso1996023eec.0
        for <linux-input@vger.kernel.org>; Sat, 14 Feb 2026 19:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771126781; x=1771731581; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/hnHxhj/M4kr+gqIqpVmltJdxHArt8+fD256oLg2W2g=;
        b=PtoDWQTxzsqyfhehKhEB5yFNaObLqs1RJXaKFmXHSWl6NByofeMsEM64gUhxTyBRx9
         1dmmrjd5MXhEBqlzwBmZZQc16bQ7acu8krdsOjdCao8Wx0lVFrFJmqe6pGUgVnQbo/Jg
         2cYyccldn000AYSX7hrIMHXZm9ypH2xqBm+rklUXn7U1R9pLYJHlUWosihqwSmkWJyzI
         tWWuYQIeNWCkonRGLem/9H/AlHcdXmREsGzR4OY06pOEGbQ8QTkaARVLuoLTKM2cs6MB
         RAATbGRrId9o7WIPbLMwWxGv6yLKepuKfhedKcpCma1agsqvPoHrPMitsILL0l6vWQlb
         N0qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771126781; x=1771731581;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/hnHxhj/M4kr+gqIqpVmltJdxHArt8+fD256oLg2W2g=;
        b=nDWmfiOX3fi8As/LnpFbaONkjChgCqBMVyCJvd0uNFBQs2ZaJJglgDoZddy6qSgOqU
         z0nIzt2qlUMTNZYni+vY8jrMuRdO/tL8Ye9yEgDwO49pBbccEyxEtSLNKvuZ8bzy/M0f
         abxzk74RcUtKHnObr2BXyxRPsFDI+C6o/MCdL6J051LJGEHnxratMu2ovHqjFVBvsCas
         FfZ1WIjBEMzqbESnk+NeuKZfgq0I0s/WlzQJzW5bdDxDx/1htliuiu6NUeDiUaNZGi38
         qYVxgod/gpyghm6k2v5+tM+De0K/3YwAsSag7SqLFSidWUD+FQOX+VQ+0xLCXgbvEUuB
         rXJw==
X-Forwarded-Encrypted: i=1; AJvYcCX9/srNMhz0pw9kuqaTGrExYHgpvR1Zx5dD2antjV0Ykdok+99BofSVm28iXbWacXxBEBp6ftnrtX3bWA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxDTPTrTlHSHy5dcseijrbyz/cwTsRYszH4YDoDjonsA1SsAbBB
	yv/9e9J4OUTGaRNVXOltGuMhev3vNtM2OyqO4y7ch9F7OCQj67eCQeai8Av0rg==
X-Gm-Gg: AZuq6aKrX+OnHF3jpUK4KPY/R9mF/UN8EIFjw4dhkZ3UFR93pFRuaKNvkmOCcW6zS2K
	xIjmEBYIQbzPRmw8FUBUUrqDyyBX6a3x++pG7XIpRDfFJFHrUOhxv1BFxOd5NcO6eoukVqG4ftr
	mhRw9KqrTzyfiNL7ha+TD0IgTZPYdvNHF3rHwxPTSqJlp1Zq+XwP3gbjREknQIw0M1N5cTYqh/3
	dvUL7kiLaJfjG5aPaMME8mFxkLCICNpx0SkNc4bgG2RDr0IFsFzX1lBYVcs4GrmCrIVUBpNv9T1
	GtSRnCsv7m/BU0+Zn8njPoncBLwaZpPjoMqIB1QHYQIgfIUDIKy8ASdCPRxbBFWvRX+4+0hgSIn
	8+3VPvcAKPxkpdSV8aORDst4jnGG98posWjfYPjGDMfRM0A+gH50c9nZbdvLlb2m+DWobwRE698
	/xyF4506tdclqbw6hCjhJlvWaWj6spmiUxnEm0vL/qv1CfQbX+nfGAs5sqZ0drBlc0
X-Received: by 2002:a05:7301:1297:b0:2ba:6b03:90af with SMTP id 5a478bee46e88-2bac9337cabmr1723559eec.6.1771126780854;
        Sat, 14 Feb 2026 19:39:40 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:54f1:86b4:bd6a:867e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb6782e5sm4434660eec.29.2026.02.14.19.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 19:39:40 -0800 (PST)
Date: Sat, 14 Feb 2026 19:39:37 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v6.20-rc0
Message-ID: <aZE_tkCsDuCAH3Ux@google.com>
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

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v7.0-rc0

to receive updates for the input subsystem. You will get:

- support for FocalTech FT8112 added to i2c-hid driver

- support for FocalTech FT3518 added to edt-ft5x06 driver

- support for power buttons in TWL603x chips added to twl4030-pwrbutton
  driver

- an update to gpio-decoder driver to make it usable on non-OF
  platforms and to clean up the code

- an update to synaptics_i2c driver switching it to use managed
  resources and a fix to restarting polling after resume

- an update to gpio-keys driver to fall back to getting IRQ from
  resources if not specified using other means

- an update to ili210x driver to support polling mode

- a number of input drivers switched to scnprintf() to suppress
  truncation warnings

- a number of updates and conversions of device tree bindings to yaml
  format

- fixes to spelling in comments and messages in several drivers

- other assorted fixups.

Changelog:
---------

Andreas Kemnade (2):
      Input: twl4030 - add TWL603x power button
      Input: twl4030 - fix warnings without CONFIG_OF

Andy Shevchenko (19):
      Input: dynapro - switch to use scnprintf() to suppress truncation warning
      Input: egalax_ts_serial - switch to use scnprintf() to suppress truncation warning
      Input: elo - switch to use scnprintf() to suppress truncation warning
      Input: gunze - switch to use scnprintf() to suppress truncation warning
      Input: hampshire - switch to use scnprintf() to suppress truncation warning
      Input: fujitsu_ts - switch to use scnprintf() to suppress truncation warning
      Input: inexio - switch to use scnprintf() to suppress truncation warning
      Input: mtouch - switch to use scnprintf() to suppress truncation warning
      Input: penmount - switch to use scnprintf() to suppress truncation warning
      Input: touchit213 - switch to use scnprintf() to suppress truncation warning
      Input: touchright - switch to use scnprintf() to suppress truncation warning
      Input: touchwin - switch to use scnprintf() to suppress truncation warning
      Input: tsc40 - switch to use scnprintf() to suppress truncation warning
      Input: wdt87xx_i2c - switch to use dev_err_probe()
      Input: gpio_decoder - make use of device properties
      Input: gpio_decoder - unify messages with help of dev_err_probe()
      Input: gpio_decoder - replace custom loop by gpiod_get_array_value_cansleep()
      Input: gpio_decoder - make use of the macros from bits.h
      Input: gpio_decoder - don't use "proxy" headers

Daniel Peng (2):
      dt-bindings: input: i2c-hid: Introduce FocalTech FT8112
      HID: i2c-hid: Add FocalTech FT8112

David Heidelberg (1):
      Input: stmfts - correct wording for the warning message

Dmitry Torokhov (4):
      Input: ilitek_ts_i2c - switch mdelay() to fsleep()
      Input: synaptics_i2c - switch to using managed resources
      Input: appletouch - fix potential race between resume and open
      Input: gpio_keys - fall back to platform_get_irq() for interrupt-only keys

Fabio Baltieri (1):
      Input: cros_ec_keyb - clarify key event error message

Gianluca Boiano (1):
      Input: novatek-nvt-ts - drop wake_type check

Josua Mayer (1):
      Input: ilitek_ts_i2c - fix warning with gpio controllers that sleep

Kuan-Wei Chiu (1):
      dt-bindings: input: google,goldfish-events-keypad: Convert to DT schema

Lukas Bulwahn (1):
      MAINTAINERS: adjust file entry in HIMAX HX83112B TOUCHSCREEN SUPPORT

Marco Crivellari (4):
      Input: gpio_keys - replace use of system_wq with system_dfl_wq
      Input: palmas-pwrbutton - replace use of system_wq with system_dfl_wq
      Input: synaptics_i2c - replace use of system_wq with system_dfl_wq
      Input: psmouse-smbus - add WQ_UNBOUND to alloc_workqueue user

Marek Vasut (3):
      Input: ili210x - convert to dev_err_probe()
      dt-bindings: touchscreen: trivial-touch: Drop 'interrupts' requirement for old Ilitek
      Input: ili210x - add support for polling mode

Micah Ostrow (1):
      Input: apbps2 - fix comment style and typos

Minseong Kim (1):
      Input: synaptics_i2c - guard polling restart in resume

Petr Hodina (2):
      Input: stmfts - make comments correct
      Input: stmfts - use sysfs_emit() instead of sprintf()

Rakesh Kota (1):
      dt-bindings: input: qcom,pm8941-pwrkey: Document PMM8654AU

Raymond Hackley (1):
      dt-bindings: input: touchscreen: imagis: allow linux,keycodes for ist3038

Rob Herring (Arm) (1):
      dt-bindings: input: touchscreen: sitronix,st1232: Add Sitronix ST1624

Sakari Ailus (3):
      Input: omap4-keypad - remove redundant pm_runtime_mark_last_busy() calls
      Input: cs40l50 - remove redundant pm_runtime_mark_last_busy() calls
      Input: cyapa - remove redundant pm_runtime_mark_last_busy() calls

Svyatoslav Ryhel (1):
      dt-bindings: input: touchscreen: tsc2007: document '#io-channel-cells'

Vaibhav Gupta (1):
      Input: pf1550 - remove "defined but unused" warning

Vivek BalachandharTN (1):
      Input: byd - use %*ph for Z packet dump

Vladimir Zapolskiy (1):
      Input: adp5589 - remove a leftover header file

Wentong Tian (1):
      Input: serio - complete sizeof(*pointer) conversions

Yedaya Katsman (2):
      dt-bindings: input: touchscreen: edt-ft5x06: Add FocalTech FT3518
      Input: edt-ft5x06 - add support for FocalTech FT3518

Diffstat:
--------

 .../devicetree/bindings/goldfish/events.txt        |  17 --
 .../bindings/input/focaltech,ft8112.yaml           |  66 ++++++
 .../input/google,goldfish-events-keypad.yaml       |  41 ++++
 .../bindings/input/qcom,pm8941-pwrkey.yaml         |  17 +-
 .../bindings/input/touchscreen/edt-ft5x06.yaml     |   1 +
 .../bindings/input/touchscreen/ilitek,ili210x.yaml |  51 +++++
 .../input/touchscreen/imagis,ist3038c.yaml         |   4 +-
 .../input/touchscreen/sitronix,st1232.yaml         |  10 +-
 .../bindings/input/touchscreen/ti,tsc2007.yaml     |   3 +
 .../bindings/input/touchscreen/trivial-touch.yaml  |   4 -
 MAINTAINERS                                        |   2 +-
 drivers/hid/i2c-hid/i2c-hid-of-elan.c              |   8 +
 drivers/input/keyboard/cros_ec_keyb.c              |   3 +-
 drivers/input/keyboard/gpio_keys.c                 |  19 +-
 drivers/input/keyboard/omap4-keypad.c              |   4 -
 drivers/input/misc/cs40l50-vibra.c                 |   4 -
 drivers/input/misc/gpio_decoder.c                  |  74 ++++---
 drivers/input/misc/palmas-pwrbutton.c              |   2 +-
 drivers/input/misc/pf1550-onkey.c                  |   2 +-
 drivers/input/misc/twl4030-pwrbutton.c             |  67 ++++++-
 drivers/input/mouse/appletouch.c                   |   9 +-
 drivers/input/mouse/byd.c                          |   6 +-
 drivers/input/mouse/cyapa.c                        |   3 -
 drivers/input/mouse/cyapa_gen5.c                   |   1 -
 drivers/input/mouse/psmouse-smbus.c                |   2 +-
 drivers/input/mouse/synaptics_i2c.c                | 223 +++++++++------------
 drivers/input/serio/altera_ps2.c                   |   2 +-
 drivers/input/serio/apbps2.c                       |  14 +-
 drivers/input/serio/arc_ps2.c                      |   3 +-
 drivers/input/serio/olpc_apsp.c                    |   2 +-
 drivers/input/touchscreen/dynapro.c                |   4 +-
 drivers/input/touchscreen/edt-ft5x06.c             |   6 +
 drivers/input/touchscreen/egalax_ts_serial.c       |   3 +-
 drivers/input/touchscreen/elo.c                    |   2 +-
 drivers/input/touchscreen/fujitsu_ts.c             |   3 +-
 drivers/input/touchscreen/gunze.c                  |   2 +-
 drivers/input/touchscreen/hampshire.c              |   4 +-
 drivers/input/touchscreen/ili210x.c                |  96 +++++----
 drivers/input/touchscreen/ilitek_ts_i2c.c          |  10 +-
 drivers/input/touchscreen/inexio.c                 |   2 +-
 drivers/input/touchscreen/mtouch.c                 |   2 +-
 drivers/input/touchscreen/novatek-nvt-ts.c         |   5 -
 drivers/input/touchscreen/penmount.c               |   2 +-
 drivers/input/touchscreen/stmfts.c                 |  21 +-
 drivers/input/touchscreen/touchit213.c             |   4 +-
 drivers/input/touchscreen/touchright.c             |   2 +-
 drivers/input/touchscreen/touchwin.c               |   2 +-
 drivers/input/touchscreen/tsc40.c                  |   2 +-
 drivers/input/touchscreen/wdt87xx_i2c.c            |  14 +-
 include/linux/input/adp5589.h                      | 180 -----------------
 50 files changed, 518 insertions(+), 512 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/goldfish/events.txt
 create mode 100644 Documentation/devicetree/bindings/input/focaltech,ft8112.yaml
 create mode 100644 Documentation/devicetree/bindings/input/google,goldfish-events-keypad.yaml
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/ilitek,ili210x.yaml
 delete mode 100644 include/linux/input/adp5589.h

Thanks.


-- 
Dmitry
