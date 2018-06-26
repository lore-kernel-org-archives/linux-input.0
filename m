From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for v4.18-rc2
Date: Tue, 26 Jun 2018 16:32:26 -0700
Message-ID: <20180626233226.GA170294@dtor-ws>
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

to receive updates for the input subsystem:

- the main change is a fix for my brain-dead patch to PS/2 button
  reporting for some protocols that made it in 4.17

- there is a new driver for Spreadtum vibrator that I intended to send
  during merge window but ended up not sending the 2nd pull request.
  Given that this is a brand new driver we should not see regressions
  here

- a fixup to Elantech PS/2 driver to avoid decoding errors on Thinkpad
  P52

- addition of few more ACPI IDs for Silead and Elan drivers

- RMI4 is switched to using IRQ domain code instead of rolling its own
  implementation


Changelog:
---------

??? (1):
      Input: elantech - fix V4 report decoding for module with middle key

Aaron Ma (1):
      Input: elantech - enable middle button of touchpads on ThinkPad P52

Alexandr Savca (1):
      Input: elan_i2c - add ELAN0618 (Lenovo v330 15IKB) ACPI ID

Ben Hutchings (1):
      Input: elan_i2c_smbus - fix more potential stack buffer overflows

Dmitry Torokhov (3):
      Input: make input_report_slot_state() return boolean
      Input: do not assign new tracking ID when changing tool type
      Input: psmouse - fix button reporting for basic protocols

Enno Boland (1):
      Input: xpad - fix GPD Win 2 controller name

Hans de Goede (1):
      Input: silead - add MSSL0002 ACPI HID

Lucas Stach (1):
      Input: synaptics-rmi4 - fix axis-swap behavior

Nick Dyer (1):
      Input: synaptics-rmi4 - convert irq distribution to irq_domain

Roman Kiryanov (1):
      Input: goldfish_events - fix checkpatch warnings

Wei Yongjun (1):
      Input: synaptics-rmi4 - fix the error return code in rmi_probe_interrupts()

Xiaotong Lu (1):
      Input: add Spreadtrum vibrator driver

Diffstat:
--------

 .../bindings/input/sprd,sc27xx-vibra.txt           |  23 +++
 drivers/input/input-mt.c                           |  12 +-
 drivers/input/joystick/xpad.c                      |   2 +-
 drivers/input/keyboard/goldfish_events.c           |   9 +-
 drivers/input/misc/Kconfig                         |  10 ++
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/sc27xx-vibra.c                  | 154 +++++++++++++++++++++
 drivers/input/mouse/elan_i2c.h                     |   2 +
 drivers/input/mouse/elan_i2c_core.c                |   3 +-
 drivers/input/mouse/elan_i2c_smbus.c               |  10 +-
 drivers/input/mouse/elantech.c                     |  11 +-
 drivers/input/mouse/psmouse-base.c                 |  12 +-
 drivers/input/rmi4/Kconfig                         |   1 +
 drivers/input/rmi4/rmi_2d_sensor.c                 |  34 +++--
 drivers/input/rmi4/rmi_bus.c                       |  50 ++++++-
 drivers/input/rmi4/rmi_bus.h                       |  10 +-
 drivers/input/rmi4/rmi_driver.c                    |  52 +++----
 drivers/input/rmi4/rmi_f01.c                       |  10 +-
 drivers/input/rmi4/rmi_f03.c                       |   9 +-
 drivers/input/rmi4/rmi_f11.c                       |  42 +++---
 drivers/input/rmi4/rmi_f12.c                       |   8 +-
 drivers/input/rmi4/rmi_f30.c                       |   9 +-
 drivers/input/rmi4/rmi_f34.c                       |   5 +-
 drivers/input/rmi4/rmi_f54.c                       |   6 -
 drivers/input/touchscreen/silead.c                 |   1 +
 include/linux/input/mt.h                           |   2 +-
 include/linux/rmi.h                                |   2 +
 27 files changed, 366 insertions(+), 124 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/sprd,sc27xx-vibra.txt
 create mode 100644 drivers/input/misc/sc27xx-vibra.c

Thanks.


-- 
Dmitry
