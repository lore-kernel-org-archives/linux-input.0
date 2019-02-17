From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for v5.0-rc6
Date: Sat, 16 Feb 2019 23:41:23 -0800
Message-ID: <20190217074123.GA248187@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem:

- tweaks to Elan drivers (both PS/2 and I2C) to support new devices.
  Also revert of one of IDs as that device should really be driven by
  i2c-hid + hid-multitouch

- a few drivers have been switched to set_brightness_blocking() call
  because they either were sleeping the their set_brightness()
  implementation or used workqueue but were not canceling it on unbind.

- ps2-gpio and matrix_keypad needed to [properly] flush their works to
  avoid potential use-after-free on unbind.

- other miscellaneous fixes.

Changelog:
---------

Dmitry Torokhov (6):
      Input: cap11xx - switch to using set_brightness_blocking()
      Input: ps2-gpio - flush TX work when closing port
      Input: matrix_keypad - use flush_delayed_work()
      Input: qt2160 - switch to using brightness_set_blocking()
      Revert "Input: elan_i2c - add ACPI ID for touchpad in ASUS Aspire F5-573G"
      Input: apanel - switch to using brightness_set_blocking()

Gabriel Fernandez (1):
      Input: st-keyscan - fix potential zalloc NULL dereference

Jonathan Bakker (2):
      Input: pwm-vibra - prevent unbalanced regulator
      Input: bma150 - register input device after setting private data

Matti Kurkela (1):
      Input: elantech - enable 3rd button support on Fujitsu CELSIUS H780

Mauro Ciancio (1):
      Input: elan_i2c - add ACPI ID for touchpad in Lenovo V330-15ISK

Paweł Chmiel (1):
      Input: pwm-vibra - stop regulator after disabling pwm, not before

Stefan Agner (1):
      Input: snvs_pwrkey - allow selecting driver for i.MX 7D

Diffstat:
--------

 drivers/input/keyboard/Kconfig         |  2 +-
 drivers/input/keyboard/cap11xx.c       | 35 ++++++-----------
 drivers/input/keyboard/matrix_keypad.c |  2 +-
 drivers/input/keyboard/qt2160.c        | 69 +++++++++++++---------------------
 drivers/input/keyboard/st-keyscan.c    |  4 +-
 drivers/input/misc/apanel.c            | 24 ++----------
 drivers/input/misc/bma150.c            |  9 +++--
 drivers/input/misc/pwm-vibra.c         | 19 +++++++---
 drivers/input/mouse/elan_i2c_core.c    |  2 +-
 drivers/input/mouse/elantech.c         |  9 +++++
 drivers/input/serio/ps2-gpio.c         |  1 +
 11 files changed, 75 insertions(+), 101 deletions(-)

Thanks.


-- 
Dmitry
