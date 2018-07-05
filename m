From: Pascal PAILLET-LME <p.paillet@st.com>
Subject: [PATCH 0/8] Introduce STPMU1 PMIC Driver
Date: Thu, 5 Jul 2018 15:14:21 +0000
Message-ID: <1530803657-17684-1-git-send-email-p.paillet@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "lee.jones@linaro.org" <lee.jones@linaro.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "wim@linux-watchdog.org" <wim@linux-watchdog.org>, "linux@roeck-us.net" <linux@roeck-us.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>
Cc: Pascal PAILLET-LME <p.paillet@st.com>
List-Id: linux-input@vger.kernel.org

From: pascal paillet <p.paillet@st.com>

The goal of this patch-set is to propose a driver for the STPMU1 PMIC from 
ST Microelectronics. 
The STPMU1 regulators supply power to an application processor as well as 
to external system peripherals such as DDR, Flash memories and system
devices. It also features onkey button input and an hardware watchdog.
The STPMU1 is controlled via I2C. 

Main driver is drivers/mfd/stpmu1 that handle I2C regmap configuration and
irqchip. stpmu1_regulator, stpmu1_onkey and stpmu1_wdt need stpmu1 mfd
as parent.

stpmu1 mfd regulator drivers maybe mandatory at boot time.

*** BLURB HERE ***

pascal paillet (8):
  dt-bindings: mfd: document stpmu1 pmic
  mfd: stpmu1: add stpmu1 pmic driver
  dt-bindings: regulator: document stpmu1 pmic regulators
  regulator: stpmu1: add stpmu1 regulator driver
  dt-bindings: input: document stpmu1 pmic onkey
  input: stpmu1: add stpmu1 onkey driver
  dt-bindings: watchdog: document stpmu1 pmic watchdog
  watchdog: stpmu1: add stpmu1 watchdog driver

 .../devicetree/bindings/input/st,stpmu1-onkey.txt  |  31 +
 .../devicetree/bindings/mfd/st,stpmu1.txt          | 138 ++++
 .../bindings/regulator/st,stpmu1-regulator.txt     |  72 ++
 .../devicetree/bindings/watchdog/st,stpmu1-wdt.txt |  11 +
 drivers/input/misc/Kconfig                         |  11 +
 drivers/input/misc/Makefile                        |   2 +
 drivers/input/misc/stpmu1_onkey.c                  | 321 +++++++
 drivers/mfd/Kconfig                                |  14 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/stpmu1.c                               | 490 +++++++++++
 drivers/regulator/Kconfig                          |  12 +
 drivers/regulator/Makefile                         |   2 +
 drivers/regulator/stpmu1_regulator.c               | 919 +++++++++++++++++++++
 drivers/watchdog/Kconfig                           |  12 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/stpmu1_wdt.c                      | 177 ++++
 include/dt-bindings/mfd/st,stpmu1.h                |  46 ++
 include/linux/mfd/stpmu1.h                         | 220 +++++
 18 files changed, 2480 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/st,stpmu1-onkey.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/st,stpmu1.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/st,stpmu1-regulator.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/st,stpmu1-wdt.txt
 create mode 100644 drivers/input/misc/stpmu1_onkey.c
 create mode 100644 drivers/mfd/stpmu1.c
 create mode 100644 drivers/regulator/stpmu1_regulator.c
 create mode 100644 drivers/watchdog/stpmu1_wdt.c
 create mode 100644 include/dt-bindings/mfd/st,stpmu1.h
 create mode 100644 include/linux/mfd/stpmu1.h

-- 
1.9.1
