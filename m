From: Steve Twiss <stwiss.opensource@diasemi.com>
Subject: [PATCH V4 0/8]  da9061: DA9061 driver submission
Date: Mon, 14 Nov 2016 08:22:46 +0000
Message-ID: <cover.1479111766.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: DEVICETREE <devicetree@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Eduardo Valentin <edubezval@gmail.com>, Guenter Roeck <linux@roeck-us.net>, LINUX-INPUT <linux-input@vger.kernel.org>, LINUX-KERNEL <linux-kernel@vger.kernel.org>, LINUX-PM <linux-pm@vger.kernel.org>, LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Lukasz Luba <lukasz.luba@arm.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Steve Twiss <stwiss.opensource@diasemi.com>, Wim Van Sebroeck <wim@iguana.be>, Zhang Rui <rui.zhang@intel.com>
Cc: Support Opensource <support.opensource@diasemi.com>
List-Id: linux-input@vger.kernel.org

From: Steve Twiss <stwiss.opensource@diasemi.com>

This patch set adds support for the Dialog DA9061 Power Management IC.
Support is made by altering the existing DA9062 device driver, where
appropriate.

In this patch set the following is provided:

[PATCH V4 1/8] Binding for watchdog
[PATCH V4 2/8] Binding for thermal supervisor
[PATCH V4 3/8] Binding for MFD and regulators
[PATCH V4 4/8] MFD core support
[PATCH V4 5/8] BUCKs and LDOs
[PATCH V4 6/8] Watchdog
[PATCH V4 7/8] PMIC temperature monitoring
[PATCH V4 8/8] MAINTAINERS update

Some previous patches from this set have been applied already:

Onkey binding -- https://lkml.org/lkml/2016/11/8/958
Onkey driver  -- https://lkml.org/lkml/2016/10/26/1169

This patch applies against linux-next and v4.8 

Thank you,
Steve Twiss, Dialog Semiconductor Ltd.

Steve Twiss (8):
  Documentation: devicetree: watchdog: da9062/61 watchdog timer binding
  Documentation: devicetree: thermal: da9062/61 TJUNC temperature
    binding
  Documentation: devicetree: mfd: da9062/61 MFD binding
  mfd: da9061: MFD core support
  regulator: da9061: BUCK and LDO regulator driver
  watchdog: da9062/61: watchdog driver
  thermal: da9062/61: Thermal junction temperature monitoring driver
  MAINTAINERS: da9062/61 updates to the Dialog Semiconductor search
    terms

 Documentation/devicetree/bindings/mfd/da9062.txt   |  49 ++-
 .../devicetree/bindings/thermal/da9062-thermal.txt |  37 ++
 .../devicetree/bindings/watchdog/da9062-wdt.txt    |  23 ++
 MAINTAINERS                                        |   4 +
 drivers/mfd/Kconfig                                |   5 +-
 drivers/mfd/da9062-core.c                          | 424 ++++++++++++++++++++-
 drivers/regulator/Kconfig                          |   4 +-
 drivers/regulator/da9062-regulator.c               | 301 ++++++++++++++-
 drivers/thermal/Kconfig                            |  10 +
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/da9062-thermal.c                   | 300 +++++++++++++++
 drivers/watchdog/Kconfig                           |   4 +-
 drivers/watchdog/da9062_wdt.c                      |  12 +-
 include/linux/mfd/da9062/core.h                    |  27 +-
 include/linux/mfd/da9062/registers.h               |   2 +
 15 files changed, 1154 insertions(+), 49 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/da9062-thermal.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/da9062-wdt.txt
 create mode 100644 drivers/thermal/da9062-thermal.c

-- 
end-of-patch for PATCH V4

