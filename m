From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for v4.14-rc0
Date: Sat, 16 Sep 2017 06:34:30 -0700
Message-ID: <20170916133430.GA29183@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive second round of updates for the input subsystem. You will get:

- a new driver for PWM-controlled vibrators

- ucb1400 touchscreen driver had completely busted suspend/resume handling

- we now handle "home" button found on some devices with Goodix touchscreens

- assorted other fixups.

Changelog:
---------

Cameron Gutman (1):
      Input: xpad - validate USB endpoint type during probe

Colin Ian King (3):
      Input: adi - make array seq static, reduces object code size
      Input: surface3_spi - make const array header static, reduces object code size
      Input: elantech - make arrays debounce_packet static, reduces object code size

Dmitry Torokhov (1):
      Input: ucb1400_ts - fix suspend and resume handling

Kai-Heng Feng (1):
      Input: i8042 - add Gigabyte P57 to the keyboard reset table

Luca Ceresoli (1):
      Input: edt-ft5x06 - fix access to non-existing register

Sebastian Reichel (1):
      Input: add a driver for PWM controllable vibrators

Sergei A. Trusov (1):
      Input: goodix - add support for capacitive home button

Diffstat:
--------

 .../devicetree/bindings/input/pwm-vibrator.txt     |  66 +++++
 drivers/input/joystick/adi.c                       |   2 +-
 drivers/input/joystick/xpad.c                      |  10 +-
 drivers/input/misc/Kconfig                         |  12 +
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/pwm-vibra.c                     | 267 +++++++++++++++++++++
 drivers/input/mouse/elantech.c                     |   8 +-
 drivers/input/serio/i8042-x86ia64io.h              |   7 +
 drivers/input/touchscreen/edt-ft5x06.c             |   3 +-
 drivers/input/touchscreen/goodix.c                 |   9 +
 drivers/input/touchscreen/surface3_spi.c           |   2 +-
 drivers/input/touchscreen/ucb1400_ts.c             |   4 +-
 12 files changed, 380 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/pwm-vibrator.txt
 create mode 100644 drivers/input/misc/pwm-vibra.c

Thanks.


-- 
Dmitry
