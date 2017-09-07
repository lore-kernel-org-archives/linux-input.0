From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for v4.14-rc0
Date: Wed, 6 Sep 2017 17:26:48 -0700
Message-ID: <20170907002648.GA14458@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f49.google.com ([74.125.83.49]:37464 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752063AbdIGA0w (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 6 Sep 2017 20:26:52 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. You will get:

- a new GPIO bit-banging driver implementing PS/2 protocol; 
- a new power key driver for Rockchip RK805 PMIC;
- bunch of patches constifying various device ID structures;
- Elan I2C touchpad driver now supports devices with 2 buttons;
- other assorted fixes. 

Changelog:
---------

Arvind Yadav (56):
      Input: serio - constify attribute_group structures
      Input: aiptek - constify attribute_group structures
      Input: constify attribute_group structures
      Input: synaptics-rmi4 - constify attribute_group structures in F34
      Input: synaptics-rmi4 - constify attribute_group structures in F01
      Input: ims-pcu - constify attribute_group structures
      Input: yealink - constify attribute_group structures
      Input: gpio_keys - constify attribute_group structures
      Input: elantech - constify attribute_group structures
      Input: psmouse - constify attribute_group structures
      Input: raydium_i2c_ts - constify attribute_group structures
      Input: elants_i2c - constify attribute_group structures
      Input: ads7846 - constify attribute_group structures
      Input: iforce - constify usb_device_id and fix space before '[' error
      Input: keyspan_remote - constify usb_device_id
      Input: powermate - constify usb_device_id and fix space before '[' error
      Input: appletouch - constify usb_device_id
      Input: synaptics_usb - constify usb_device_id
      Input: acecad - constify usb_device_idi and fix space before '[' error
      Input: kbtab - constify usb_device_id
      Input: xpad - constify usb_device_id
      Input: ati_remote2 - constify usb_device_id
      Input: i8042 - constify pnp_device_id
      Input: iforce - constify serio_device_id
      Input: magellan - constify serio_device_id
      Input: spaceball - constify serio_device_id
      Input: spaceorb - constify serio_device_id
      Input: stinger - constify serio_device_id
      Input: twidjoy - constify serio_device_id
      Input: warrior - constify serio_device_id
      Input: zhenhua - constify serio_device_id
      Input: iatkbd - constify serio_device_id
      Input: hil_kbd - constify serio_device_id
      Input: lkkbd - constify serio_device_id
      Input: newtonkbd - constify serio_device_id
      Input: stowaway - constify serio_device_id
      Input: sunkbd - constify serio_device_id
      Input: xtkbd - constify serio_device_id
      Input: constify serio_device_id
      Input: wacom_serial4 - constify serio_device_id
      Input: dynapro - constify serio_device_id
      Input: elo - constify serio_device_id
      Input: fujitsu_ts - constify serio_device_id
      Input: gunze - constify serio_device_id
      Input: hampshire - constify serio_device_id
      Input: inexio - constify serio_device_id
      Input: mtouch - constify serio_device_id
      Input: penmount - constify serio_device_id
      Input: touchit213 - constify serio_device_id
      Input: touchright - constify serio_device_id
      Input: touchwin - constify serio_device_id
      Input: tsc40 - constify serio_device_id
      Input: wacom_w8001 - constify serio_device_id
      Input: ambakmi - constify amba_id
      Input: tegra-kbc - handle return value of clk_prepare_enable
      Input: pxa27x_keypad - handle return value of clk_prepare_enable

Colin Ian King (1):
      Input: byd - make array seq static, reduces object code size

Danilo Krummrich (1):
      Input: PS/2 gpio bit banging driver for serio bus

Dmitry Torokhov (1):
      ARM: pxa/raumfeld: mark rotary encoder properties as __initconst

Fabio Estevam (1):
      Input: mxs-lradc - do a NULL check on iores

Florian Echtler (3):
      Input: sur40 - add additional reverse-engineered information
      Input: sur40 - silence unnecessary noisy debug output
      Input: sur40 - skip all blobs that are not touches

Joseph Chen (1):
      Input: add power key driver for Rockchip RK805 PMIC

Julia Lawall (1):
      Input: sun4i-ts - constify thermal_zone_of_device_ops structures

KT Liao (1):
      Input: elan_i2c - support touchpads with two physical buttons

Liang Yan (1):
      Input: xen-kbdfront - enable auto repeat for xen keyboard frontend driver

Michal Simek (1):
      Input: xilinx_ps2 - fix multiline comment style

Munir Contractor (1):
      Input: pcspkr - fix code style and error value in pcspkr_event

Nick Desaulniers (1):
      Input: mousedev - fix implicit conversion warning

Pan Bian (1):
      Input: mxs-lradc - use correct error check

Quentin Schulz (2):
      Input: axp20x-pek - use driver_data of platform_device_id instead of extended attributes
      Input: axp20x-pek - add support for AXP221 PEK

Sebastian Reichel (2):
      Input: atmel_mxt_ts - use more managed resources
      Input: atmel_mxt_ts - add support for reset line

Wei Yongjun (1):
      Input: mxs-lradc - make symbol mxs_lradc_ts_irq_names static

Diffstat:
--------

 .../devicetree/bindings/input/atmel,maxtouch.txt   |   2 +
 .../devicetree/bindings/serio/ps2-gpio.txt         |  23 ++
 Documentation/gpio/drivers-on-gpio.txt             |   5 +
 arch/arm/mach-pxa/raumfeld.c                       |   2 +-
 drivers/input/input.c                              |   6 +-
 drivers/input/joystick/iforce/iforce-serio.c       |   2 +-
 drivers/input/joystick/iforce/iforce-usb.c         |   2 +-
 drivers/input/joystick/magellan.c                  |   2 +-
 drivers/input/joystick/spaceball.c                 |   2 +-
 drivers/input/joystick/spaceorb.c                  |   2 +-
 drivers/input/joystick/stinger.c                   |   2 +-
 drivers/input/joystick/twidjoy.c                   |   2 +-
 drivers/input/joystick/warrior.c                   |   2 +-
 drivers/input/joystick/xpad.c                      |   2 +-
 drivers/input/joystick/zhenhua.c                   |   2 +-
 drivers/input/keyboard/atkbd.c                     |   2 +-
 drivers/input/keyboard/gpio_keys.c                 |   2 +-
 drivers/input/keyboard/hil_kbd.c                   |   2 +-
 drivers/input/keyboard/lkkbd.c                     |   2 +-
 drivers/input/keyboard/newtonkbd.c                 |   2 +-
 drivers/input/keyboard/pxa27x_keypad.c             |  15 +-
 drivers/input/keyboard/stowaway.c                  |   2 +-
 drivers/input/keyboard/sunkbd.c                    |   2 +-
 drivers/input/keyboard/tegra-kbc.c                 |   5 +-
 drivers/input/keyboard/xtkbd.c                     |   2 +-
 drivers/input/misc/Kconfig                         |  11 +
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/ati_remote2.c                   |   2 +-
 drivers/input/misc/axp20x-pek.c                    | 149 +++++--
 drivers/input/misc/ims-pcu.c                       |   4 +-
 drivers/input/misc/keyspan_remote.c                |   2 +-
 drivers/input/misc/pcspkr.c                        |  17 +-
 drivers/input/misc/powermate.c                     |   2 +-
 drivers/input/misc/rk805-pwrkey.c                  | 111 +++++
 drivers/input/misc/xen-kbdfront.c                  |   5 +-
 drivers/input/misc/yealink.c                       |   2 +-
 drivers/input/mouse/appletouch.c                   |   2 +-
 drivers/input/mouse/byd.c                          |   2 +-
 drivers/input/mouse/elan_i2c.h                     |   2 +-
 drivers/input/mouse/elan_i2c_core.c                |   9 +-
 drivers/input/mouse/elan_i2c_i2c.c                 |  13 +-
 drivers/input/mouse/elan_i2c_smbus.c               |   4 +-
 drivers/input/mouse/elantech.c                     |   2 +-
 drivers/input/mouse/psmouse-base.c                 |   2 +-
 drivers/input/mouse/synaptics_usb.c                |   2 +-
 drivers/input/mousedev.c                           |  62 +--
 drivers/input/rmi4/rmi_f01.c                       |   2 +-
 drivers/input/rmi4/rmi_f34.c                       |   2 +-
 drivers/input/serio/Kconfig                        |  11 +
 drivers/input/serio/Makefile                       |   1 +
 drivers/input/serio/ambakmi.c                      |   2 +-
 drivers/input/serio/i8042-x86ia64io.h              |   4 +-
 drivers/input/serio/ps2-gpio.c                     | 453 +++++++++++++++++++++
 drivers/input/serio/serio.c                        |   4 +-
 drivers/input/serio/serio_raw.c                    |   2 +-
 drivers/input/serio/xilinx_ps2.c                   |  12 +-
 drivers/input/tablet/acecad.c                      |   2 +-
 drivers/input/tablet/aiptek.c                      |   2 +-
 drivers/input/tablet/kbtab.c                       |   2 +-
 drivers/input/tablet/wacom_serial4.c               |   2 +-
 drivers/input/touchscreen/ads7846.c                |   4 +-
 drivers/input/touchscreen/atmel_mxt_ts.c           |  46 ++-
 drivers/input/touchscreen/dynapro.c                |   2 +-
 drivers/input/touchscreen/elants_i2c.c             |   2 +-
 drivers/input/touchscreen/elo.c                    |   2 +-
 drivers/input/touchscreen/fujitsu_ts.c             |   2 +-
 drivers/input/touchscreen/gunze.c                  |   2 +-
 drivers/input/touchscreen/hampshire.c              |   2 +-
 drivers/input/touchscreen/inexio.c                 |   2 +-
 drivers/input/touchscreen/mtouch.c                 |   2 +-
 drivers/input/touchscreen/mxs-lradc-ts.c           |   8 +-
 drivers/input/touchscreen/penmount.c               |   2 +-
 drivers/input/touchscreen/raydium_i2c_ts.c         |   2 +-
 drivers/input/touchscreen/sun4i-ts.c               |   2 +-
 drivers/input/touchscreen/sur40.c                  |  46 ++-
 drivers/input/touchscreen/touchit213.c             |   2 +-
 drivers/input/touchscreen/touchright.c             |   2 +-
 drivers/input/touchscreen/touchwin.c               |   2 +-
 drivers/input/touchscreen/tsc40.c                  |   2 +-
 drivers/input/touchscreen/wacom_w8001.c            |   2 +-
 80 files changed, 947 insertions(+), 190 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serio/ps2-gpio.txt
 create mode 100644 drivers/input/misc/rk805-pwrkey.c
 create mode 100644 drivers/input/serio/ps2-gpio.c

Thanks.


-- 
Dmitry
