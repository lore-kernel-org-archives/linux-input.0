From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: [PATCH v4 0/3] Add samsung keypad
Date: Fri, 11 Jun 2010 17:08:44 +0900
Message-ID: <4C11EF0C.8060109@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: ben-linux@fluff.org
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org, kyungmin.park@samsung.com, dmitry.torokhov@gmail.com, kgene.kim@samsung.com
List-Id: linux-input@vger.kernel.org

This is patch v4 series to add Samsung keypad. I've removed board file
patchs for samsung-keypad support in the v4, They don't have any change
but i will post later because of dependence problem with other patches.

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
 arch/arm/plat-samsung/dev-keypad.c               |   58 ++++
 arch/arm/plat-samsung/include/plat/devs.h        |    2 +
 arch/arm/plat-samsung/include/plat/keypad.h      |   59 ++++
 arch/arm/plat-samsung/include/plat/regs-keypad.h |   49 +++
 drivers/input/keyboard/Kconfig                   |    9 +
 drivers/input/keyboard/Makefile                  |    1 +
 drivers/input/keyboard/samsung-keypad.c          |  400 ++++++++++++++++++++++
 14 files changed, 631 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s5pv210/setup-keypad.c
 create mode 100644 arch/arm/plat-samsung/dev-keypad.c
 create mode 100644 arch/arm/plat-samsung/include/plat/keypad.h
 create mode 100644 arch/arm/plat-samsung/include/plat/regs-keypad.h
 create mode 100644 drivers/input/keyboard/samsung-keypad.c
