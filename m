From: Chen Zhong <chen.zhong@mediatek.com>
Subject: [PATCH v5 0/6] Add MediaTek PMIC keys support
Date: Wed, 27 Sep 2017 18:44:02 +0800
Message-ID: <1506509048-19032-1-git-send-email-chen.zhong@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Eddie Huang <eddie.huang@mediatek.com>, Alessandro Zummo <a.zummo@towertech.it>, Linus Walleij <linus.walleij@linaro.org>, Chanwoo Choi <cw00.choi@samsung.com>, Chen Zhong <chen.zhong@mediatek.com>, Jaechul Lee <jcsing.lee@samsung.com>, Andi Shyti <andi.shyti@samsung.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-rtc@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Changes since v4:
- rebase to Linux 4.14-rc1
- add a common keyboard binding document
- use child device tree node to define each key

Changes since v3:
- make the naming to be consistent as mtk_pmic or MTK_PMIC
- add suspend/resume functions to enable/disable irq
- change binding properties to define wakeup sources

Changes since v2:
- use standard properties for keycodes and debounce time
- change to use platform_get_irq in leaf drivers
- use better ways to define IRQ resources

Changes since v1:
- create irq mappings in mfd core driver instead of leaf drivers
- remove some unused parts in mtk-pmic-keys driver

MediaTek PMIC are multi-function devices that can handle key interrupts,
typically there are two keys attached to PMIC, which called pwrkey
and homekey. PWRKEY usually used to wake up system from sleep. Homekey
can used as volume down key due to board design. Long press keys can
shutdown PMIC, the mode can be choose to be one key only or two keys
together.
This series add support for key functions for MediaTek PMIC MT6397/MT6323.

Chen Zhong (6):
  mfd: mt6397: create irq mappings in mfd core driver
  dt-bindings: input: Add common keyboard document bindings
  dt-bindings: input: Add document bindings for mtk-pmic-keys
  dt-bindings: mfd: Add bindings for the keys as subnode of PMIC
  input: Add MediaTek PMIC keys support
  mfd: mt6397: Add PMIC keys support to MT6397 driver

 Documentation/devicetree/bindings/input/keys.txt   |   8 +
 .../devicetree/bindings/input/mtk-pmic-keys.txt    |  43 +++
 Documentation/devicetree/bindings/mfd/mt6397.txt   |   6 +
 drivers/input/keyboard/Kconfig                     |   9 +
 drivers/input/keyboard/Makefile                    |   1 +
 drivers/input/keyboard/mtk-pmic-keys.c             | 341 +++++++++++++++++++++
 drivers/mfd/mt6397-core.c                          |  26 +-
 drivers/rtc/rtc-mt6397.c                           |   7 +-
 8 files changed, 434 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/keys.txt
 create mode 100644 Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
 create mode 100644 drivers/input/keyboard/mtk-pmic-keys.c

-- 
1.9.1
