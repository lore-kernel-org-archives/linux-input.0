From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: [PATCH v6 0/3] Add samsung keypad
Date: Mon, 28 Jun 2010 20:34:09 +0900
Message-ID: <4C2888B1.7080704@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org, ben-linux@fluff.org, dmitry.torokhov@gmail.com, kyungmin.park@samsung.com, kgene.kim@samsung.com
List-Id: linux-input@vger.kernel.org

This is patch v6 series to add Samsung keypad.

Changes since v1:
- Include linux/gpio.h instead of mach/gpio.h
- Switch to dev_pm_ops in the samsung keypad driver

Changes since v2:
- Add keypad device types to remove platform specific #ifdef
- Remove unnecessary include and checking codes.
- Rename from 'kp' to 'keypad'
- Rename keypad registers definition
- Modify 'rep' variable declaration

Changes since v3:
- Use schedule_delayed_work and remove timer
- Modify memory alloc codes
- Add MODULE_ALIAS() and missing error printk
- Change from rep to no_autorepeat and it's type to bool
- Add report EV_MSC/MSC_SCAN and wakeup control
- Remove s3c_set_platdata() call because there is not yet

Changes since v4:
- Add and use samsung_keypad_setname function
- Add more specific gpio comments

Changes since v5:
- Add Dmitry patch about threaded IRQs and some fixing
- Remove clock gating for irq

Joonyoung Shim (3):
      ARM: SAMSUNG: Add keypad device support
      ARM: S5PV210: Add keypad device helpers
      input: samsung-keypad - Add samsung keypad driver

 arch/arm/mach-s5pv210/Kconfig                    |    5 +
 arch/arm/mach-s5pv210/Makefile                   |    1 +
 arch/arm/mach-s5pv210/cpu.c                      |    4 +
 arch/arm/mach-s5pv210/include/mach/map.h         |    3 +
 arch/arm/mach-s5pv210/setup-keypad.c             |   34 ++
 arch/arm/plat-samsung/Kconfig                    |    5 +
 arch/arm/plat-samsung/Makefile                   |    1 +
 arch/arm/plat-samsung/dev-keypad.c               |   58 +++
 arch/arm/plat-samsung/include/plat/devs.h        |    2 +
 arch/arm/plat-samsung/include/plat/keypad-core.h |   31 ++
 arch/arm/plat-samsung/include/plat/keypad.h      |   59 +++
 drivers/input/keyboard/Kconfig                   |    9 +
 drivers/input/keyboard/Makefile                  |    1 +
 drivers/input/keyboard/samsung-keypad.c          |  491 ++++++++++++++++++++++
 14 files changed, 704 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s5pv210/setup-keypad.c
 create mode 100644 arch/arm/plat-samsung/dev-keypad.c
 create mode 100644 arch/arm/plat-samsung/include/plat/keypad-core.h
 create mode 100644 arch/arm/plat-samsung/include/plat/keypad.h
 create mode 100644 drivers/input/keyboard/samsung-keypad.c
