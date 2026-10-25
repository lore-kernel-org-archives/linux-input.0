Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792894027;
	b=MYCet/lgRy+wbW6XzRnzD+VbVH1UqRW/+NS9E+ae7+GBjDf0dBJxC8l5yZsto0hDlU9W
	 JFWETTUKkzpcsSB2ZbNdak0b7xlRec7EtWy3LfaJJ0uBVfrxHN+q1BfphBXXttKhsoXcV
	 oiR9bXrghv3fK54DtfWYJx6OgDLSurPxyUuqrdj8UvInk5O3VI81gaO5Yk9Spko3zP3XB
	 N4x7ygUErqHEzev5k/0mkJ9/CY5hnBgpknNLFHLYVK2HYMQ8Omxye18eKKmpqfEylYQYb
	 5ypBdn74n/naazC40qb+/mVzD87Kpd0o0C8nG8U/KUiE/5T37DEevcmkvICoX2iMg2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792894027;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding;
	bh=kT5jczTWjpVEtFbXjx0wDEmlz0lFSNa8Dp/5ZmbafD8=;
	b=qFLT0AULPBYUEXhskdew8qlWmZhFys3Z9fY8MSZ9F39YClkax9NObmD6qlWVQLfW/3If
	 akoOb1hOK7lWv+Hr9uORlo3x7+OnFOAapYsymZkVpbthR6ojNsa0hAnVTSSgSuv/Mj9kp
	 IEbtzBrfcQ3j5FEwnwYVF7vffcVgK1lwzUYm2s9lw7btOLjcLKczkhMJ+pI+aIzqvDiW3
	 rrqJ5G+Ixf35dPJwa7oTppVXl3wZ7L+kim9XeWI9C3wcZbuRqnXUVyil6Qc05wdcZXwzr
	 ayTrJ/uXFTZPGxvtbcLr291mlG3BuUhS0Na2uHuX2obfLaSm8gkxFBRtq3GcHgwV2Bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IcrCWgfF;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64C2606A31D
	for <linux-input@vger.kernel.org>; Sun, 25 Oct 2026 02:07:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B64C2606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IcrCWgfF
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-36661f953e4so3719479eec.1
        for <linux-input@vger.kernel.org>; Sat, 24 Oct 2026 19:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792894026; x=1793498826; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kT5jczTWjpVEtFbXjx0wDEmlz0lFSNa8Dp/5ZmbafD8=;
        b=IcrCWgfFm8/4E6xZKHSrH8AKfkOmCuc2EEPho8czLqrA/HYkR2I5WNfPEB+HYy1f3u
         n+K+JjiTXDk8Pkn8Z8yLw102xS/nhOiDO1Kyi5au8eQTAQxskL/XdUnnbhSb6d1Z5556
         R7gUD2kG3NuhEP7wsWog7OHtlImr8nYdOBtbBLmwqTQTdPL6BeE0EpjQg3cWLiHGBgzU
         Ckc1ZBL7JZXrwL1mnZ1Xx38IdQxWNcYk8rMNyWpKnzThSfLm183zYAcZiMSwxmHv+s50
         e/4d7ZF6AOoi7biOuXvzLFZv3eoqfn6FsS7eTvunZHMIVKKWo8COtddIqf7NSc/str8V
         ah5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792894026; x=1793498826;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kT5jczTWjpVEtFbXjx0wDEmlz0lFSNa8Dp/5ZmbafD8=;
        b=ehFHjNKE0ZOSuEiJVWZ2u/mkZ3natfXcEH6UXRxg+KQtP6lX9Ywx8dM/LNAjTytG4Q
         Egan0quqG+buUwOA95uMiZEugsP35GOMB6VqV94Cd3sp3AmdOkD5IvDzEk3a2g7zhzf0
         T5Pnvdh2jU11T583KuNSUXXT6HXaChSUKkAEvnfLkd61zBuudllM6A9tlj3F5zc8grjj
         TBiaiFlhJbi53HqiBL+sbj3fWGNqzVTKj3+yXqzcETo+YECXdEgRN2hWMiqbWq9onLyZ
         40P7oeLDbQBHtCJtS/kk9Azd8BXOw+ei8WAcBj8i1Le0sXNeE+v9QsXdQ+QLKkZ7EGVi
         PTfg==
X-Forwarded-Encrypted: i=1; AKwUvByRPDeeB0+Lm3OyPjmGDJH059iRA6laNjqz8pQXncs2gmhuDlas/sVao14EpBJ9byZJDC6tyoQBbAQaIg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLzWXS5Sgmn7E785RG60s5Sk91uLXHmUOM7pp18UwXqjHforUmT
	v6JiGdc3FSAEU+WORqEbLcyhp2PV78gtDRnFeOOkLxx9LbeWL4NwJsWY
X-Gm-Gg: AYBFou10oPOn9TScXUycT/3Ay/Dd+POqDv88Dwa5shVARMOm+45ai0THF3tjAudDp/c
	YPBYoIe68jHXXn0UpORx21aHESR+wbUHl1M4fR0J0c7VM/KBd0aQ6/khcztJE/0XELNte2Xqb9n
	d8aURBOCIyMl7MQkk9MTvrHIsPZn6qrnNVm0/69HL/PLa6X9hIqLCGGM4j6pSvbNkNPeR5MGmNN
	s3fpHzx3ZpVUpxmWd/5yQiFdg1XaIa3CGFHtwG4005RVpB4hj5KX0vz9cPQPz6iC2YScuMzr5+l
	KfhvNaO2xp97jTcLDjYkuU5GjQIFtxEGh8ubv4JcWRWp7dOzG63ZFOHeY+vBvgD+Hpa7h18WCRr
	c8mEBDKnLq3J3SLbYcg8scwvtiSNGphIP5HxSg274Kk0UBHGgKfRAu+0ArZovPdLJCkjvKTlhTz
	W6ht2zkaEfM/CqWaQIsZ5iGWKiRCUinMM5v8NU/Tft+HuMcEqAXsasVXraCP/RnjmC3tLq6H1lW
	txSpbYgirXqL/vrBtitm58Y/Ri/dbQVvfmVLYRKtT/wX2Iv6FcVw8nGvMDIfcKTpOvPzjkKvjA1
	4dUgUOh0IVoSMHqd9TlR
X-Received: by 2002:a05:7022:3b8b:b0:169:9f67:a91b with SMTP id a92af1059eb24-1993505df87mr5833060c88.12.1792894025678;
        Sat, 24 Oct 2026 19:07:05 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:8fe4:693:7158:24de])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a1bfaf25sm11421531c88.14.2026.10.24.19.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 19:07:04 -0700 (PDT)
Date: Sat, 24 Oct 2026 19:07:02 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v7.4-rc0
Message-ID: <at1kDafUvUUJTnPr@google.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v7.4-rc0

to receive updates for the input subsystem. You will get:

- Updates to input core to reject parent device overrides on managed
  input devices so devres lifetime management is not split across
  different devices, along with fixes for da7280, drv2665, drv2667, and
  tps6507x-ts that were reparenting managed input devices, and removal
  of redundant parent assignments across multiple drivers

- A fix in input core to always accept EV_SYN events in input_event()
  and input_inject_event() so events seeded before device registration
  are properly flushed by input_sync()

- A fix in matrix-keymap helper to reject keycodes above KEY_MAX and
  prevent out-of-bounds bitmap writes

- Fixes and cleanups for HP GSC PS/2 (gscps2) serio driver to resolve
  race conditions in port list management, ring buffer access, and
  interrupt handling, return IRQ_NONE for unhandled shared interrupts,
  and drop busy-waiting on transmit

- Fixes for maple_keyb driver to correct inverted key press detection,
  implement open and close methods so polling only runs while the device
  is open, and clean up unused driver fields

- Fixes for maplecontrol driver to emit EV_SYN after reporting events,
  only enable axes reported by the controller with corrected hat limits,
  and stop polling and clear the callback on close

- Updates to maplemouse driver to stop polling and clear the callback on
  close and drop redundant driver data cleanup

- Fixes for matrix_keypad driver reverting forced switching of row GPIOs
  to input mode that broke row interrupts on platforms with separate
  GPIO and interrupt pinmux functions, and propagating the actual error
  code from matrix_keypad_build_keymap()

- A fix for st-keyscan driver to keep the interrupt disabled while the
  peripheral clock is gated off to prevent bus faults, along with probe
  error handling improvements

- A fix for mms114 touchscreen driver to disable interrupts before
  synthesizing touch release events during suspend so concurrent
  interrupts do not leave stuck active touch slots

- Updates to xpad driver to support GameSir Nova Lite controller

- A number of updates to device tree bindings, including a new schema
  for Analog Devices AD7147 CapTouch controller, conversion of SiS 9200
  I2C touchscreen binding to DT schema format, and allowing the
  wakeup-source property on Dialog DA9062 onkey

- Other assorted driver cleanups, style fixes, and conversions,
  including switching to named initializers for acpi_device_id tables
  and converting cyttsp5 to DEFINE_SIMPLE_DEV_PM_OPS.

Changelog:
---------

Alexander Kochetkov (1):
      Revert "Input: matrix_keypad - force switch rows to input mode"

Diederik de Haas (1):
      Input: cyttsp5 - convert to DEFINE_SIMPLE_DEV_PM_OPS

Dmitry Torokhov (79):
      Input: gscps2 - clean up driver code style and structure
      Input: gscps2 - use RCU for ps2port_list and manage it in open/close
      Input: gscps2 - protect buffer access in read and report helpers
      Input: gscps2 - serialize hardware and buffer access in gscps2_flush()
      Input: gscps2 - return IRQ_NONE when interrupt is not handled
      Input: gscps2 - serialize concurrent interrupt handlers
      Input: gscps2 - drop busy-wait and manual interrupt pump on transmit
      Input: mt - update input_mt_report_slot_state() kerneldoc
      Input: matrix_keypad - propagate error code from matrix_keypad_build_keymap()
      Input: gpio_keys - drop redundant input->dev.parent assignment
      Input: applespi - drop redundant input->dev.parent assignment
      Input: axp20x-pek - drop redundant idev->dev.parent assignment
      Input: cyapa - drop redundant input->dev.parent assignment
      Input: 88pm860x-ts - drop redundant idev->dev.parent assignment
      Input: adp5520-keys - drop redundant input->dev.parent assignment
      Input: bcm-keypad - drop redundant input_dev->dev.parent assignment
      Input: clps711x-keypad - drop redundant input->dev.parent assignment
      Input: cros-ec-keyb - drop redundant idev->dev.parent assignments
      Input: imx-keypad - drop redundant input_dev->dev.parent assignment
      Input: jornada720-kbd - drop redundant input_dev->dev.parent assignment
      Input: lpc32xx-keys - drop redundant input->dev.parent assignment
      Input: max7359-keypad - drop redundant input_dev->dev.parent assignment
      Input: mpr121-touchkey - drop redundant input_dev->dev.parent assignment
      Input: pxa27x-keypad - drop redundant input_dev->dev.parent assignment
      Input: qt1050 - drop redundant input->dev.parent assignment
      Input: st-keyscan - drop redundant input_dev->dev.parent assignment
      Input: stmpe-keypad - drop redundant input->dev.parent assignment
      Input: tc3589x-keypad - drop redundant input->dev.parent assignment
      Input: tegra-kbc - drop redundant kbc->idev->dev.parent assignment
      Input: 88pm860x-onkey - drop redundant info->idev->dev.parent assignment
      Input: ab8500-ponkey - drop redundant input->dev.parent assignment
      Input: ad714x - drop redundant input->dev.parent assignments
      Input: ariel-pwrbutton - drop redundant priv->input->dev.parent assignment
      Input: e3x0-button - drop redundant input->dev.parent assignment
      Input: max77693-haptic - drop redundant haptic->input_dev->dev.parent assignment
      Input: max8925-onkey - drop redundant input->dev.parent assignment
      Input: pwm-vibra - drop redundant vibrator->input->dev.parent assignment
      Input: regulator-haptic - drop redundant haptic->input_dev->dev.parent assignment
      Input: retu-pwrbutton - drop redundant idev->dev.parent assignment
      Input: tps65218-pwrbutton - drop redundant idev->dev.parent assignment
      Input: twl4030-pwrbutton - drop redundant pwr->dev.parent assignment
      Input: wm831x-on - drop redundant wm831x_on->dev->dev.parent assignment
      Input: ad7877 - drop redundant input_dev->dev.parent assignment
      Input: ad7879 - drop redundant input_dev->dev.parent assignment
      Input: ar1021-i2c - drop redundant input->dev.parent assignment
      Input: bcm-iproc-tsc - drop redundant idev->dev.parent assignment
      Input: chipone-icn8318 - drop redundant input->dev.parent assignment
      Input: colibri-vf50-ts - drop redundant input->dev.parent assignment
      Input: cyttsp - drop redundant input_dev->dev.parent assignment
      Input: da9034-ts - drop redundant input_dev->dev.parent assignment
      Input: edt-ft5x06 - drop redundant input->dev.parent assignment
      Input: hycon-hy46xx - drop redundant input->dev.parent assignment
      Input: jornada720-ts - drop redundant input_dev->dev.parent assignment
      Input: max11801-ts - drop redundant input_dev->dev.parent assignment
      Input: mms114 - drop redundant input_dev->dev.parent assignment
      Input: sx8654 - drop redundant input->dev.parent assignment
      Input: wm831x-ts - drop redundant input_dev->dev.parent assignment
      Input: wm97xx - drop redundant wm->input_dev->dev.parent assignment
      Input: mms114 - fix touch slot corruption in suspend
      Input: st-keyscan - disable interrupt while clock is gated
      Input: maple_keyb - fix key press detection
      Input: maplecontrol - only enable present axes
      Input: maplecontrol - emit EV_SYN report after reporting events
      Input: maplecontrol - stop polling and clear callback on close
      Input: maplemouse - stop polling and clear callback on close
      Input: maple_keyb - implement open and close methods
      Input: maplemouse - remove redundant drvdata resetting
      Input: maple_keyb - remove redundant drvdata resetting
      Input: maplecontrol - remove redundant drvdata resetting
      Input: maplemouse - remove unused mdev->driver assignment
      Input: maplecontrol - remove unused mdev->driver assignment
      Input: maple_keyb - remove unused mdev->driver assignment
      Input: da7280 - fix input device parent assignment
      Input: drv2665 - fix input device parent assignment
      Input: drv2667 - fix input device parent assignment
      Input: tps6507x-ts - fix input device parent assignment
      Input: reject parent overrides on managed input devices
      Input: always accept EV_SYN in input_event()
      Input: s6sy761 - drop duplicate axis initialization in s6sy761_probe()

Francesco Orlando (1):
      Input: xpad - add GameSir Nova Lite support

Frank Li (1):
      dt-bindings: input: dlg,da9062-onkey: Allow wakeup-source property

Krzysztof Kozlowski (1):
      dt-bindings: input: Use consistent indentation in the example

Linmao Li (1):
      Input: matrix-keymap - reject keycodes above KEY_MAX

Pawel Zalewski (4):
      Input: keyboard - use named initializers for acpi_device_id
      Input: misc - use named initializers for acpi_device_id
      Input: mouse - cyapa: use named initializers for acpi_device_id
      Input: touchscreen - use named initializers for acpi_device_id

Peng Fan (1):
      Input: atkbd - use __assign_bit() where applicable

Rob Herring (Arm) (1):
      dt-bindings: input: Add AD7147 CapTouch schema

bui duc phuc (2):
      Input: snvs_pwrkey - tidy up error reporting in probe
      Input: st-keyscan - improve probe error handling

Ștefan Ghețu (1):
      dt-bindings: input: touchscreen: convert sis_i2c to DT schema

Diffstat:
--------

 .../devicetree/bindings/input/adc-joystick.yaml    |  20 +-
 .../bindings/input/adi,ad7147_captouch.yaml        |  48 ++++
 .../devicetree/bindings/input/cypress-sf.yaml      |  14 +-
 .../bindings/input/dlg,da9062-onkey.yaml           |   2 +
 .../bindings/input/mediatek,mt6779-keypad.yaml     |  10 +-
 .../bindings/input/microchip,cap11xx.yaml          |  14 +-
 .../bindings/input/touchscreen/eeti,exc3000.yaml   |  16 +-
 .../bindings/input/touchscreen/sis,9200-ts.yaml    |  61 +++++
 .../bindings/input/touchscreen/sis_i2c.txt         |  31 ---
 .../bindings/input/touchscreen/ti,tsc2007.yaml     |  12 +-
 MAINTAINERS                                        |   2 +-
 drivers/input/input-mt.c                           |   5 +-
 drivers/input/input.c                              |  12 +-
 drivers/input/joystick/maplecontrol.c              |  29 +--
 drivers/input/joystick/xpad.c                      |   1 +
 drivers/input/keyboard/adp5520-keys.c              |   1 -
 drivers/input/keyboard/applespi.c                  |   4 +-
 drivers/input/keyboard/atkbd.c                     |   5 +-
 drivers/input/keyboard/bcm-keypad.c                |   1 -
 drivers/input/keyboard/clps711x-keypad.c           |   1 -
 drivers/input/keyboard/cros_ec_keyb.c              |   4 +-
 drivers/input/keyboard/goldfish_events.c           |   4 +-
 drivers/input/keyboard/gpio_keys.c                 |   1 -
 drivers/input/keyboard/imx_keypad.c                |   1 -
 drivers/input/keyboard/jornada720_kbd.c            |   1 -
 drivers/input/keyboard/lpc32xx-keys.c              |   1 -
 drivers/input/keyboard/maple_keyb.c                |  34 ++-
 drivers/input/keyboard/matrix_keypad.c             |   5 +-
 drivers/input/keyboard/max7359_keypad.c            |   1 -
 drivers/input/keyboard/mpr121_touchkey.c           |   1 -
 drivers/input/keyboard/pxa27x_keypad.c             |   1 -
 drivers/input/keyboard/qt1050.c                    |   1 -
 drivers/input/keyboard/snvs_pwrkey.c               |   9 +-
 drivers/input/keyboard/st-keyscan.c                |  30 +--
 drivers/input/keyboard/stmpe-keypad.c              |   1 -
 drivers/input/keyboard/tc3589x-keypad.c            |   1 -
 drivers/input/keyboard/tegra-kbc.c                 |   1 -
 drivers/input/matrix-keymap.c                      |   7 +
 drivers/input/misc/88pm860x_onkey.c                |   1 -
 drivers/input/misc/ab8500-ponkey.c                 |   1 -
 drivers/input/misc/ad714x.c                        |   4 -
 drivers/input/misc/ariel-pwrbutton.c               |   1 -
 drivers/input/misc/atlas_btns.c                    |   4 +-
 drivers/input/misc/axp20x-pek.c                    |   1 -
 drivers/input/misc/da7280.c                        |   1 -
 drivers/input/misc/drv260x.c                       |   2 +-
 drivers/input/misc/drv2665.c                       |   1 -
 drivers/input/misc/drv2667.c                       |   1 -
 drivers/input/misc/e3x0-button.c                   |   1 -
 drivers/input/misc/max77693-haptic.c               |   1 -
 drivers/input/misc/max8925_onkey.c                 |   1 -
 drivers/input/misc/pwm-vibra.c                     |   1 -
 drivers/input/misc/regulator-haptic.c              |   1 -
 drivers/input/misc/retu-pwrbutton.c                |   1 -
 drivers/input/misc/soc_button_array.c              |  12 +-
 drivers/input/misc/tps65218-pwrbutton.c            |   1 -
 drivers/input/misc/twl4030-pwrbutton.c             |   1 -
 drivers/input/misc/wm831x-on.c                     |   1 -
 drivers/input/mouse/cyapa.c                        |   7 +-
 drivers/input/mouse/maplemouse.c                   |  10 +-
 drivers/input/serio/gscps2.c                       | 277 +++++++++++----------
 drivers/input/tests/input_test.c                   |  34 +++
 drivers/input/touchscreen/88pm860x-ts.c            |   1 -
 drivers/input/touchscreen/ad7877.c                 |   1 -
 drivers/input/touchscreen/ad7879.c                 |   1 -
 drivers/input/touchscreen/ar1021_i2c.c             |   1 -
 drivers/input/touchscreen/atmel_mxt_ts.c           |   4 +-
 drivers/input/touchscreen/bcm_iproc_tsc.c          |   1 -
 drivers/input/touchscreen/chipone_icn8318.c        |   1 -
 drivers/input/touchscreen/chipone_icn8505.c        |   2 +-
 drivers/input/touchscreen/colibri-vf50-ts.c        |   1 -
 drivers/input/touchscreen/cyttsp5.c                |   8 +-
 drivers/input/touchscreen/cyttsp_core.c            |   1 -
 drivers/input/touchscreen/da9034-ts.c              |   1 -
 drivers/input/touchscreen/edt-ft5x06.c             |   1 -
 drivers/input/touchscreen/elants_i2c.c             |   8 +-
 drivers/input/touchscreen/exc3000.c                |   2 +-
 drivers/input/touchscreen/goodix.c                 |   8 +-
 drivers/input/touchscreen/hideep.c                 |   2 +-
 drivers/input/touchscreen/hycon-hy46xx.c           |   1 -
 drivers/input/touchscreen/ilitek_ts_i2c.c          |   4 +-
 drivers/input/touchscreen/jornada720_ts.c          |   1 -
 drivers/input/touchscreen/max11801_ts.c            |   1 -
 drivers/input/touchscreen/melfas_mip4.c            |   4 +-
 drivers/input/touchscreen/mms114.c                 |  13 +-
 drivers/input/touchscreen/raydium_i2c_ts.c         |   4 +-
 drivers/input/touchscreen/s6sy761.c                |   2 -
 drivers/input/touchscreen/silead.c                 |  18 +-
 drivers/input/touchscreen/surface3_spi.c           |   2 +-
 drivers/input/touchscreen/sx8654.c                 |   1 -
 drivers/input/touchscreen/tps6507x-ts.c            |   1 -
 drivers/input/touchscreen/wdt87xx_i2c.c            |   2 +-
 drivers/input/touchscreen/wm831x-ts.c              |   1 -
 drivers/input/touchscreen/wm97xx-core.c            |   1 -
 94 files changed, 453 insertions(+), 406 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/adi,ad7147_captouch.yaml
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/sis,9200-ts.yaml
 delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/sis_i2c.txt

Thanks.


-- 
Dmitry
