From: Pascal PAILLET-LME <p.paillet@st.com>
Subject: [PATCH v6 0/8] Introduce STPMIC1 PMIC Driver
Date: Tue, 27 Nov 2018 16:52:13 +0000
Message-ID: <1543337529-22301-1-git-send-email-p.paillet@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "lee.jones@linaro.org" <lee.jones@linaro.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "wim@linux-watchdog.org" <wim@linux-watchdog.org>, "linux@roeck-us.net" <linux@roeck-us.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>, "eballetbo@gmail.com" <eballetbo@gmail.com>, "axel.lin@ingics.com" <axel.lin@ingics.com>
Cc: Pascal PAILLET-LME <p.paillet@st.com>
List-Id: linux-input@vger.kernel.org

The goal of this patch-set is to propose a driver for the STPMIC1 PMIC from 
STMicroelectronics. 
The STPMIC1 regulators supply power to an application processor as well as 
to external system peripherals such as DDR, Flash memories and system
devices. It also features onkey button input and an hardware watchdog.
The STPMIC1 is controlled via I2C. 

Main driver is drivers/mfd/stpmic1 that handle I2C regmap configuration and
irqchip. stpmic1_regulator, stpmic1_onkey and stpmic1_wdt need stpmic1 mfd
as parent.

STPMIC1 MFD and regulator drivers maybe mandatory at boot time.

Pascal Paillet (9):
  dt-bindings: mfd: document stpmic1
  mfd: stpmic1: add stpmic1 driver
  dt-bindings: regulator: document stpmic1 pmic regulators
  regulator: stpmic1: add stpmic1 regulator driver
  dt-bindings: input: document stpmic1 pmic onkey
  input: stpmic1: add stpmic1 onkey driver
  dt-bindings: watchdog: document stpmic1 pmic watchdog
  watchdog: stpmic1: add stpmic1 watchdog driver
  defc

 .../devicetree/bindings/input/st,stpmic1-onkey.txt |  28 +
 .../devicetree/bindings/mfd/st,stpmic1.txt         |  61 ++
 .../bindings/regulator/st,stpmic1-regulator.txt    |  67 ++
 .../bindings/watchdog/st,stpmic1-wdt.txt           |  11 +
 arch/arm/configs/pascal_defconfig                  | 680 +++++++++++++++++++++
 drivers/input/misc/Kconfig                         |  11 +
 drivers/input/misc/Makefile                        |   2 +
 drivers/input/misc/stpmic1_onkey.c                 | 198 ++++++
 drivers/mfd/Kconfig                                |  16 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/stpmic1.c                              | 213 +++++++
 drivers/regulator/Kconfig                          |  12 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/stpmic1_regulator.c              | 667 ++++++++++++++++++++
 drivers/watchdog/Kconfig                           |  12 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/stpmic1_wdt.c                     | 139 +++++
 include/dt-bindings/mfd/st,stpmic1.h               |  50 ++
 include/linux/mfd/stpmic1.h                        | 212 +++++++
 19 files changed, 2382 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/st,stpmic1-onkey.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/st,stpmic1.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/st,stpmic1-regulator.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/st,stpmic1-wdt.txt
 create mode 100644 arch/arm/configs/pascal_defconfig
 create mode 100644 drivers/input/misc/stpmic1_onkey.c
 create mode 100644 drivers/mfd/stpmic1.c
 create mode 100644 drivers/regulator/stpmic1_regulator.c
 create mode 100644 drivers/watchdog/stpmic1_wdt.c
 create mode 100644 include/dt-bindings/mfd/st,stpmic1.h
 create mode 100644 include/linux/mfd/stpmic1.h

-- 
1.9.1
