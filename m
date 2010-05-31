From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: [PATCH v3 0/5] Add samsung keypad
Date: Mon, 31 May 2010 13:40:59 +0900
Message-ID: <4C033DDB.1030906@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: ben-linux@fluff.org
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org, kyungmin.park@samsung.com, dmitry.torokhov@gmail.com
List-Id: linux-input@vger.kernel.org

This is patch v3 series to add Samsung keypad.

Changes since v1:
- Include linux/gpio.h instead of mach/gpio.h
- Switch to dev_pm_ops in the samsung keypad driver

Changes since v2:
- Add keypad device types to remove platform specific #ifdef
- Remove unnecessary include and checking codes.
- Rename from 'kp' to 'keypad'
- Rename keypad registers definition
- Modify 'rep' variable declaration

---
Joonyoung Shim (5):
      ARM: SAMSUNG: Add keypad device support
      ARM: S5PV210: Add keypad device helpers
      ARM: S5PV210: Add keypad device to the GONI board
      ARM: S5PV210: Add keypad device to the Aquila board
      input: samsung-keypad - Add samsung keypad driver

 arch/arm/mach-s5pv210/Kconfig                    |    9 +
 arch/arm/mach-s5pv210/Makefile                   |    1 +
 arch/arm/mach-s5pv210/cpu.c                      |    4 +
 arch/arm/mach-s5pv210/include/mach/map.h         |    3 +
 arch/arm/mach-s5pv210/mach-aquila.c              |   25 ++
 arch/arm/mach-s5pv210/mach-goni.c                |   26 ++
 arch/arm/mach-s5pv210/setup-keypad.c             |   34 ++
 arch/arm/plat-samsung/Kconfig                    |    5 +
 arch/arm/plat-samsung/Makefile                   |    1 +
 arch/arm/plat-samsung/dev-keypad.c               |   50 +++
 arch/arm/plat-samsung/include/plat/devs.h        |    2 +
 arch/arm/plat-samsung/include/plat/keypad.h      |   57 +++
 arch/arm/plat-samsung/include/plat/regs-keypad.h |   49 +++
 drivers/input/keyboard/Kconfig                   |    9 +
 drivers/input/keyboard/Makefile                  |    1 +
 drivers/input/keyboard/samsung-keypad.c          |  397 ++++++++++++++++++++++
 16 files changed, 673 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s5pv210/setup-keypad.c
 create mode 100644 arch/arm/plat-samsung/dev-keypad.c
 create mode 100644 arch/arm/plat-samsung/include/plat/keypad.h
 create mode 100644 arch/arm/plat-samsung/include/plat/regs-keypad.h
 create mode 100644 drivers/input/keyboard/samsung-keypad.c
