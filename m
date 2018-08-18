From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for v4.19-rc0
Date: Fri, 17 Aug 2018 17:53:43 -0700
Message-ID: <20180818005343.GA95184@dtor-ws>
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

to receive updates for the input subsystem. You will get:

- a new driver for Rohm BU21029 touch controller

- new bitmap APIs: bitmap_alloc, bitmap_zalloc and bitmap_free

- updates to Atmel, eeti. pxrc and iforce drivers

- assorted driver cleanups and fixes.

Changelog:
---------

Andy Shevchenko (5):
      dm: Avoid namespace collision with bitmap API
      md: Avoid namespace collision with bitmap API
      bitmap: Add bitmap_alloc(), bitmap_zalloc() and bitmap_free()
      Input: gpio-keys - switch to bitmap_zalloc()
      Input: evdev - switch to bitmap API

Chen Zhong (1):
      dt-bindings: input: add common keyboard document bindings

Colin Ian King (1):
      Input: cros_ec_keyb - remove redundant variable num_cols

Daniel Mack (4):
      dt-bindings: input: touchscreen: add bindings for eeti touchscreen controller
      Input: eeti - add device tree matching table
      Input: eeti - drop module parameters, parse DT properties
      Input: eeti - fix link to documentation and email address in header

Dmitry Torokhov (6):
      Input: pxrc - fix freeing URB on device teardown
      Input: pxrc - move module device table closer to where it is used
      Input: pxrc - do not store unneeded data in driver structure
      Input: pxrc - flatten probe code
      Input: stop telling users to snail-mail Vojtech
      Input: do not use WARN() in input_alloc_absinfo()

Enric Balletbo i Serra (2):
      Input: cros_ec_keyb - make license text and MODULE_LICENSE match
      Input: cros_ec_keyb - switch to SPDX identifier

Fabio Estevam (5):
      Input: imx_keypad - switch to SPDX identifier
      Input: snvs_pwrkey - switch to SPDX identifier
      Input: fsl-imx25-tcq - switch to SPDX identifier
      Input: imx6ul_tsc - switch to SPDX identifier
      Input: egalax_ts - switch to SPDX identifier

Gustavo A. R. Silva (2):
      Input: raydium_i2c_ts - use true and false for boolean values
      Input: mark expected switch fall-throughs

Jia-Ju Bai (6):
      Input: wdt87xx_i2c - replace mdelay() with msleep() in wdt87xx_resume()
      Input: keyspan_remote - replace GFP_ATOMIC with GFP_KERNEL in keyspan_probe()
      Input: powermate - replace GFP_ATOMIC with GFP_KERNEL in powermate_alloc_buffers()
      Input: yealink - replace GFP_ATOMIC with GFP_KERNEL in usb_probe()
      Input: appletouch - replace GFP_ATOMIC with GFP_KERNEL
      Input: aiptek - replace GFP_ATOMIC with GFP_KERNEL in aiptek_probe()

Julia Lawall (1):
      Input: elan_i2c_smbus - cast sizeof to int for comparison

Marcus Folkesson (2):
      Input: pxrc - do not store USB device in private struct
      MAINTAINERS: Add PhoenixRC Flight Controller Adapter

Matti Vaittinen (1):
      Input: gpio_keys - add missing include to gpio_keys.h

Nick Dyer (9):
      Input: atmel_mxt_ts - only use first T9 instance
      Input: atmel_mxt_ts - use BIT() macro everywhere
      Input: atmel_mxt_ts - remove duplicate setup of ABS_MT_PRESSURE
      Input: atmel_mxt_ts - remove unnecessary debug on ENOMEM
      Input: atmel_mxt_ts - config CRC may start at T71
      Input: atmel_mxt_ts - refactor config update code to add context struct
      Input: atmel_mxt_ts - zero terminate config firmware file
      Input: atmel_mxt_ts - don't report zero pressure from T9
      Input: atmel_mxt_ts - move completion to after config crc is updated

Oleksandr Andrushchenko (3):
      xen: Sync up with the canonical protocol definitions in Xen
      Input: xen-kbdfront - fix multi-touch XenStore node's locations
      Input: xen-kbdfront - allow better run-time configuration

Ravi Chandra Sadineni (2):
      Input: cros_ec_keyb - remove check before calling pm_wakeup_event
      Input: i8042 - increment wakeup_count for the respective port

Sebastian Andrzej Siewior (1):
      Input: iforce - use GFP_KERNEL in iforce_get_id_packet()

Tim Schumacher (3):
      Input: iforce - reformat the packet dump output
      Input: iforce - assign BTN_DEAD only for specific devices
      Input: iforce - reorganize joystick configuration lists

Vinod Koul (2):
      Input: pm8941-pwrkey - abstract register offsets and event code
      Input: pm8941-pwrkey - add resin entry

Zhu Yi (1):
      Input: add bu21029 touch driver

Diffstat:
--------

 Documentation/devicetree/bindings/input/keys.txt   |   8 +
 .../bindings/input/qcom,pm8941-pwrkey.txt          |  10 +
 .../bindings/input/touchscreen/bu21029.txt         |  35 ++
 .../devicetree/bindings/input/touchscreen/eeti.txt |  30 ++
 MAINTAINERS                                        |   7 +
 drivers/input/evbug.c                              |   4 -
 drivers/input/evdev.c                              |  16 +-
 drivers/input/gameport/emu10k1-gp.c                |   4 -
 drivers/input/gameport/lightning.c                 |   4 -
 drivers/input/gameport/ns558.c                     |   4 -
 drivers/input/input.c                              |  16 +-
 drivers/input/joystick/a3d.c                       |   4 -
 drivers/input/joystick/adi.c                       |   4 -
 drivers/input/joystick/amijoy.c                    |   4 -
 drivers/input/joystick/analog.c                    |   4 -
 drivers/input/joystick/cobra.c                     |   4 -
 drivers/input/joystick/db9.c                       |   9 +-
 drivers/input/joystick/gamecon.c                   |   4 -
 drivers/input/joystick/gf2k.c                      |   4 -
 drivers/input/joystick/grip.c                      |   4 -
 drivers/input/joystick/guillemot.c                 |   4 -
 drivers/input/joystick/iforce/iforce-ff.c          |   8 +-
 drivers/input/joystick/iforce/iforce-main.c        |  30 +-
 drivers/input/joystick/iforce/iforce-packets.c     |  16 +-
 drivers/input/joystick/iforce/iforce-serio.c       |   4 -
 drivers/input/joystick/iforce/iforce-usb.c         |   4 -
 drivers/input/joystick/iforce/iforce.h             |   6 +-
 drivers/input/joystick/interact.c                  |   4 -
 drivers/input/joystick/joydump.c                   |   4 -
 drivers/input/joystick/magellan.c                  |   4 -
 drivers/input/joystick/pxrc.c                      | 166 +++----
 drivers/input/joystick/sidewinder.c                |   4 -
 drivers/input/joystick/spaceball.c                 |   4 -
 drivers/input/joystick/spaceorb.c                  |   4 -
 drivers/input/joystick/stinger.c                   |   4 -
 drivers/input/joystick/tmdc.c                      |   4 -
 drivers/input/joystick/turbografx.c                |   4 -
 drivers/input/joystick/warrior.c                   |   4 -
 drivers/input/keyboard/adp5589-keys.c              |   1 +
 drivers/input/keyboard/amikbd.c                    |   4 -
 drivers/input/keyboard/atakbd.c                    |   4 -
 drivers/input/keyboard/cros_ec_keyb.c              |  69 +--
 drivers/input/keyboard/gpio_keys.c                 |   8 +-
 drivers/input/keyboard/imx_keypad.c                |  12 +-
 drivers/input/keyboard/newtonkbd.c                 |   4 -
 drivers/input/keyboard/snvs_pwrkey.c               |  15 +-
 drivers/input/keyboard/stowaway.c                  |   4 -
 drivers/input/keyboard/sunkbd.c                    |   4 -
 drivers/input/keyboard/xtkbd.c                     |   4 -
 drivers/input/misc/keyspan_remote.c                |   2 +-
 drivers/input/misc/pm8941-pwrkey.c                 |  70 ++-
 drivers/input/misc/powermate.c                     |   2 +-
 drivers/input/misc/xen-kbdfront.c                  | 183 ++++----
 drivers/input/misc/yealink.c                       |   4 +-
 drivers/input/mouse/appletouch.c                   |   7 +-
 drivers/input/mouse/cyapa_gen5.c                   |   1 +
 drivers/input/mouse/cyapa_gen6.c                   |   1 +
 drivers/input/mouse/elan_i2c_smbus.c               |   2 +-
 drivers/input/mouse/elantech.c                     |   2 +-
 drivers/input/mouse/inport.c                       |   4 -
 drivers/input/mouse/logibm.c                       |   4 -
 drivers/input/mouse/pc110pad.c                     |   4 -
 drivers/input/mouse/sermouse.c                     |   8 +-
 drivers/input/serio/ct82c710.c                     |   4 -
 drivers/input/serio/i8042.c                        |   3 +
 drivers/input/serio/q40kbd.c                       |   4 -
 drivers/input/serio/rpckbd.c                       |   4 -
 drivers/input/serio/serio.c                        |   4 -
 drivers/input/tablet/aiptek.c                      |   2 +-
 drivers/input/touchscreen/Kconfig                  |  12 +
 drivers/input/touchscreen/Makefile                 |   1 +
 drivers/input/touchscreen/atmel_mxt_ts.c           | 223 +++++-----
 drivers/input/touchscreen/bu21029_ts.c             | 484 +++++++++++++++++++++
 drivers/input/touchscreen/eeti_ts.c                |  37 +-
 drivers/input/touchscreen/egalax_ts.c              |   5 +-
 drivers/input/touchscreen/elo.c                    |   1 +
 drivers/input/touchscreen/fsl-imx25-tcq.c          |  21 +-
 drivers/input/touchscreen/gunze.c                  |   4 -
 drivers/input/touchscreen/imx6ul_tsc.c             |  14 +-
 drivers/input/touchscreen/raydium_i2c_ts.c         |   4 +-
 drivers/input/touchscreen/wdt87xx_i2c.c            |   2 +-
 drivers/md/dm-raid.c                               |   6 +-
 drivers/md/md-bitmap.c                             | 305 +++++++------
 drivers/md/md-bitmap.h                             |  60 +--
 drivers/md/md-cluster.c                            |  18 +-
 drivers/md/md.c                                    |  44 +-
 drivers/md/persistent-data/dm-space-map-common.c   |  20 +-
 drivers/md/raid1.c                                 |  35 +-
 drivers/md/raid10.c                                |  52 ++-
 drivers/md/raid5-cache.c                           |   8 +-
 drivers/md/raid5.c                                 |  44 +-
 include/linux/bitmap.h                             |   8 +
 include/linux/gpio_keys.h                          |   2 +
 include/linux/joystick.h                           |   4 -
 include/uapi/linux/joystick.h                      |   4 -
 include/xen/interface/io/displif.h                 |   8 +
 include/xen/interface/io/kbdif.h                   |  78 +++-
 include/xen/interface/io/sndif.h                   |  10 +-
 lib/bitmap.c                                       |  20 +
 99 files changed, 1468 insertions(+), 967 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/keys.txt
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/bu21029.txt
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/eeti.txt
 create mode 100644 drivers/input/touchscreen/bu21029_ts.c

Thanks.


-- 
Dmitry
