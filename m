From: Chen Zhong <chen.zhong@mediatek.com>
Subject: [PATCH v4 0/5] Add MediaTek PMIC keys support
Date: Sun, 17 Sep 2017 16:00:47 +0800
Message-ID: <1505635252-27716-1-git-send-email-chen.zhong@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Eddie Huang <eddie.huang@mediatek.com>, Alessandro Zummo <a.zummo@towertech.it>, Andi Shyti <andi.shyti@samsung.com>, Jaechul Lee <jcsing.lee@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Chen Zhong <chen.zhong@mediatek.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
List-Id: linux-input@vger.kernel.org

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

Chen Zhong (5):
  mfd: mt6397: create irq mappings in mfd core driver
  dt-bindings: input: Add document bindings for mtk-pmic-keys
  dt-bindings: mfd: Add bindings for the keys as subnode of PMIC
  input: Add MediaTek PMIC keys support
  mfd: mt6397: Add PMIC keys support to MT6397 driver

 .../devicetree/bindings/input/mtk-pmic-keys.txt    |   41 +++
 Documentation/devicetree/bindings/mfd/mt6397.txt   |    6 +
 drivers/input/keyboard/Kconfig                     |    9 +
 drivers/input/keyboard/Makefile                    |    1 +
 drivers/input/keyboard/mtk-pmic-keys.c             |  354 ++++++++++++++++++++
 drivers/mfd/mt6397-core.c                          |   26 +-
 drivers/rtc/rtc-mt6397.c                           |    7 +-
 7 files changed, 437 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
 create mode 100644 drivers/input/keyboard/mtk-pmic-keys.c

--
1.7.9.5
