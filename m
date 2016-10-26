From: Steve Twiss <stwiss.opensource@diasemi.com>
Subject: [PATCH V2 00/10]  da9061: DA9061 driver submission
Date: Wed, 26 Oct 2016 17:56:40 +0100
Message-ID: <cover.1477501000.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: DEVICETREE <devicetree@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Eduardo Valentin <edubezval@gmail.com>, Guenter Roeck <linux@roeck-us.net>, LINUX-INPUT <linux-input@vger.kernel.org>, LINUX-KERNEL <linux-kernel@vger.kernel.org>, LINUX-PM <linux-pm@vger.kernel.org>, LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Steve Twiss <stwiss.opensource@diasemi.com>, Wim Van Sebroeck <wim@iguana.be>, Zhang Rui <rui.zhang@intel.com>
Cc: Support Opensource <support.opensource@diasemi.com>
List-Id: linux-input@vger.kernel.org

From: Steve Twiss <stwiss.opensource@diasemi.com>

This patch set adds support for the Dialog DA9061 Power Management IC.
Support is made by altering the existing DA9062 device driver, where
appropriate.

In this patch set the following is provided:

[PATCH V2 01/10] Binding for onkey
[PATCH V2 02/10] Binding for watchdog
[PATCH V2 03/10] Binding for thermal supervisor
[PATCH V2 04/10] Binding for MFD and regulators
[PATCH V2 05/10] MFD core support
[PATCH V2 06/10] BUCKs and LDOs
[PATCH V2 07/10] Onkey 
[PATCH V2 08/10] Watchdog
[PATCH V2 09/10] PMIC temperature monitoring
[PATCH V2 10/10] MAINTAINERS update

This patch applies against linux-next and v4.8 

Thank you,
Steve Twiss, Dialog Semiconductor Ltd.

Steve Twiss (10):
  Documentation: devicetree: input: additions for da9061 onkey driver
  Documentation: devicetree: watchdog: da9062/61 watchdog timer binding
  Documentation: devicetree: thermal: da9062/61 TJUNC temperature
    binding
  Documentation: devicetree: mfd: da9062/61 MFD binding
  mfd: da9061: MFD core support
  regulator: da9061: BUCK and LDO regulator driver
  Input: da9061: onkey driver
  watchdog: da9062/61: watchdog driver
  thermal: da9062/61: Thermal junction temperature monitoring driver
  MAINTAINERS: da9062/61 updates to the Dialog Semiconductor search
    terms

 .../devicetree/bindings/input/da9062-onkey.txt     |  39 +-
 Documentation/devicetree/bindings/mfd/da9062.txt   |  45 ++-
 .../devicetree/bindings/thermal/da9062-thermal.txt |  37 ++
 .../devicetree/bindings/watchdog/da9062-wdt.txt    |  21 +
 MAINTAINERS                                        |   4 +
 drivers/input/misc/Kconfig                         |   7 +-
 drivers/input/misc/da9063_onkey.c                  |   8 +-
 drivers/mfd/Kconfig                                |   5 +-
 drivers/mfd/da9062-core.c                          | 427 ++++++++++++++++++++-
 drivers/regulator/Kconfig                          |   4 +-
 drivers/regulator/da9062-regulator.c               | 301 ++++++++++++++-
 drivers/thermal/Kconfig                            |  10 +
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/da9062-thermal.c                   | 289 ++++++++++++++
 drivers/watchdog/Kconfig                           |   4 +-
 drivers/watchdog/da9062_wdt.c                      |  18 +-
 include/linux/mfd/da9062/core.h                    |  27 +-
 include/linux/mfd/da9062/registers.h               |   2 +
 18 files changed, 1180 insertions(+), 69 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/da9062-thermal.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/da9062-wdt.txt
 create mode 100644 drivers/thermal/da9062-thermal.c

-- 
end-of-patch for PATCH V2

