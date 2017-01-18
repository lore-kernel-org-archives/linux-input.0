From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 00/33] Input: Automated coccinelle cleanup
Date: Wed, 18 Jan 2017 09:46:21 -0800
Message-ID: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-input@vger.kernel.org

This patch series is the result of applying a set of coccinelle semantic
patches to the input subsystem. The patches are only cleanup patches;
there is little or no change in functionality.

A more complex series of patches making actual code changes will be sent
separately. This patch series is a fallout from this more complex series.
It may be questionable if the patches in this series, or any of them,
are worth it. I'll leave that up to the maintainers to decide.

A surprising aspect of this patch series is the number of removed calls
to platform_set_drvdata() and i2c_set_clientdata(). While I have not found
any problems with those removals, this deserves some extra scrutiny from
reviewers.

The conversion was done automatically with coccinelle using several semantic
patches. The semantic patches and the scripts used to generate this commit
log are available at https://github.com/groeck/coccinelle-patches.
A few files had to be edited manually to fix checkpatch issues.
Those edits were also handled automatically with fixup patches included
in the repository.

The series was build tested on kerneltests.org and by the 0day build system.

To reproduce this series of patches, checkout the tree above, then run
the following commands from the Linux source tree.

sh ~coccinelle-patches/input/make-base.sh
sh ~coccinelle-patches/input/do-commit-base.sh

The patch series is based on v4.10-rc3. For convenience, the series
is available at:
	git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git input-base

The semantic patches used in this series were written with substantial help
from Julia Lawall. Without her support, this effort would not have been
possible.

----------------------------------------------------------------
Guenter Roeck (33):
      Input: adp5520-keys - Drop unnecessary error messages and other changes
      Input: bcm-keypad - Drop unnecessary call to platform_set_drvdata and other changes
      Input: cap11xx - Drop unnecessary call to i2c_set_clientdata and other changes
      Input: cros_ec_keyb - Drop unnecessary call to dev_set_drvdata and other changes
      Input: imx_keypad - Drop unnecessary error messages and other changes
      Input: samsung-keypad - Drop unnecessary error messages and other changes
      Input: sh_keysc - Drop unnecessary error messages and other changes
      Input: spear-keyboard - Drop unnecessary error messages and other changes
      Input: sun4i-lradc-keys - Drop unnecessary call to platform_set_drvdata and other changes
      Input: twl4030_keypad - Drop unnecessary call to platform_set_drvdata and other changes
      Input: ab8500-ponkey - Drop unnecessary call to platform_set_drvdata and other changes
      Input: axp20x-pek - Use devm_add_action_or_reset and other changes
      Input: bfin_rotary - Use 'dev' instead of dereferencing it and other changes
      Input: gpio_decoder - Drop unnecessary call to platform_set_drvdata and other changes
      Input: kxtj9 - Drop unnecessary error messages and other changes
      Input: mma8450 - Drop unnecessary call to i2c_set_clientdata and other changes
      Input: retu-pwrbutton - Simplify error return and other changes
      Input: soc_button_array - Use 'dev' instead of dereferencing it and other changes
      Input: tps65218-pwrbutton - Drop unnecessary call to platform_set_drvdata and other changes
      Input: elan_i2c_core - Use 'dev' instead of dereferencing it and other changes
      Input: arc_ps2 - Drop unnecessary error messages and other changes
      Input: at32psif - Drop unnecessary error messages and other changes
      Input: xilinx_ps2 - Use 'dev' instead of dereferencing it and other changes
      Input: ar1021_i2c - Drop unnecessary call to i2c_set_clientdata and other changes
      Input: atmel-wm97xx - Drop unnecessary error messages and other changes
      Input: atmel_mxt_ts - Drop unnecessary error messages and other changes
      Input: eeti_ts - Drop unnecessary error messages and other changes
      Input: egalax_ts - Drop unnecessary call to i2c_set_clientdata and other changes
      Input: melfas_mip4 - Use devm_add_action_or_reset and other changes
      Input: raydium_i2c_ts - Simplify error return and other changes
      Input: rohm_bu21023 - Use 'dev' instead of dereferencing it and other changes
      Input: sis_i2c - Drop unnecessary call to i2c_set_clientdata and other changes
      Input: sx8654 - Drop unnecessary call to i2c_set_clientdata and other changes

 drivers/input/keyboard/adp5520-keys.c      |  4 +-
 drivers/input/keyboard/bcm-keypad.c        |  2 -
 drivers/input/keyboard/cap11xx.c           | 14 ++-----
 drivers/input/keyboard/cros_ec_keyb.c      |  3 +-
 drivers/input/keyboard/imx_keypad.c        |  4 +-
 drivers/input/keyboard/samsung-keypad.c    | 12 ++----
 drivers/input/keyboard/sh_keysc.c          | 15 +++-----
 drivers/input/keyboard/spear-keyboard.c    |  4 +-
 drivers/input/keyboard/sun4i-lradc-keys.c  |  7 +---
 drivers/input/keyboard/twl4030_keypad.c    |  1 -
 drivers/input/misc/ab8500-ponkey.c         |  1 -
 drivers/input/misc/axp20x-pek.c            |  6 +--
 drivers/input/misc/bfin_rotary.c           | 18 ++++-----
 drivers/input/misc/gpio_decoder.c          |  1 -
 drivers/input/misc/kxtj9.c                 | 12 ++----
 drivers/input/misc/mma8450.c               |  2 -
 drivers/input/misc/retu-pwrbutton.c        | 12 +-----
 drivers/input/misc/soc_button_array.c      |  6 +--
 drivers/input/misc/tps65218-pwrbutton.c    | 11 ++----
 drivers/input/mouse/elan_i2c_core.c        | 59 +++++++++++-------------------
 drivers/input/serio/arc_ps2.c              |  4 +-
 drivers/input/serio/at32psif.c             | 12 ++----
 drivers/input/serio/xilinx_ps2.c           |  7 ++--
 drivers/input/touchscreen/ar1021_i2c.c     |  6 +--
 drivers/input/touchscreen/atmel-wm97xx.c   |  4 +-
 drivers/input/touchscreen/atmel_mxt_ts.c   | 47 +++++-------------------
 drivers/input/touchscreen/eeti_ts.c        |  7 +---
 drivers/input/touchscreen/egalax_ts.c      | 21 ++---------
 drivers/input/touchscreen/melfas_mip4.c    | 10 ++---
 drivers/input/touchscreen/raydium_i2c_ts.c | 18 +++------
 drivers/input/touchscreen/rohm_bu21023.c   | 12 +++---
 drivers/input/touchscreen/sis_i2c.c        |  1 -
 drivers/input/touchscreen/sx8654.c         | 14 ++-----
 33 files changed, 105 insertions(+), 252 deletions(-)
