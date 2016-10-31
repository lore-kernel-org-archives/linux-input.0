From: Steve Twiss <stwiss.opensource@diasemi.com>
Subject: [PATCH V3 0/9]  da9061: DA9061 driver submission
Date: Mon, 31 Oct 2016 16:02:05 +0000
Message-ID: <cover.1477929725.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: DEVICETREE <devicetree@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Eduardo Valentin <edubezval@gmail.com>, Guenter Roeck <linux@roeck-us.net>, LINUX-INPUT <linux-input@vger.kernel.org>, LINUX-KERNEL <linux-kernel@vger.kernel.org>, LINUX-PM <linux-pm@vger.kernel.org>, LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Steve Twiss <stwiss.opensource@diasemi.com>, Wim Van Sebroeck <wim@iguana.be>, Zhang Rui <rui.zhang@intel.com>
Cc: Support Opensource <support.opensource@diasemi.com>
List-Id: linux-input@vger.kernel.org

From: Steve Twiss <stwiss.opensource@diasemi.com>

This patch set adds support for the Dialog DA9061 Power Management IC.
Support is made by altering the existing DA9062 device driver, where
appropriate.

In this patch set the following is provided:

[PATCH V3 1/9] Binding for onkey
[PATCH V3 2/9] Binding for watchdog
[PATCH V3 3/9] Binding for thermal supervisor
[PATCH V3 4/9] Binding for MFD and regulators
[PATCH V3 5/9] MFD core support
[PATCH V3 6/9] BUCKs and LDOs
[PATCH V3 7/9] Watchdog
[PATCH V3 8/9] PMIC temperature monitoring
[PATCH V3 9/9] MAINTAINERS update

Some patches from this previous set have been applied:

[PATCH V2 07/10] Onkey -- https://lkml.org/lkml/2016/10/26/1169

This patch applies against linux-next and v4.8 

Thank you,
Steve Twiss, Dialog Semiconductor Ltd.

Steve Twiss (9):
  Documentation: devicetree: input: additions for da9061 onkey driver
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

 .../devicetree/bindings/input/da9062-onkey.txt     |  45 ++-
 Documentation/devicetree/bindings/mfd/da9062.txt   |  52 ++-
 .../devicetree/bindings/thermal/da9062-thermal.txt |  37 ++
 .../devicetree/bindings/watchdog/da9062-wdt.txt    |  23 ++
 MAINTAINERS                                        |   4 +
 drivers/mfd/Kconfig                                |   5 +-
 drivers/mfd/da9062-core.c                          | 427 ++++++++++++++++++++-
 drivers/regulator/Kconfig                          |   4 +-
 drivers/regulator/da9062-regulator.c               | 301 ++++++++++++++-
 drivers/thermal/Kconfig                            |  10 +
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/da9062-thermal.c                   | 291 ++++++++++++++
 drivers/watchdog/Kconfig                           |   4 +-
 drivers/watchdog/da9062_wdt.c                      |  12 +-
 include/linux/mfd/da9062/core.h                    |  27 +-
 include/linux/mfd/da9062/registers.h               |   2 +
 16 files changed, 1181 insertions(+), 64 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/da9062-thermal.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/da9062-wdt.txt
 create mode 100644 drivers/thermal/da9062-thermal.c

-- 
end-of-patch for PATCH V3
