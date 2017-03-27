From: Steve Twiss <stwiss.opensource@diasemi.com>
Subject: [PATCH V6 0/7]  da9061: DA9061 driver submission
Date: Mon, 27 Mar 2017 10:51:33 +0100
Message-ID: <cover.1490608293.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: DEVICETREE <devicetree@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Eduardo Valentin <edubezval@gmail.com>, Guenter Roeck <linux@roeck-us.net>, LINUX-INPUT <linux-input@vger.kernel.org>, LINUX-KERNEL <linux-kernel@vger.kernel.org>, LINUX-PM <linux-pm@vger.kernel.org>, LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Lukasz Luba <lukasz.luba@arm.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Steve Twiss <stwiss.opensource@diasemi.com>, Wim Van Sebroeck <wim@iguana.be>, Zhang Rui <rui.zhang@intel.com>
Cc: Support Opensource <support.opensource@diasemi.com>
List-Id: linux-input@vger.kernel.org

From: Steve Twiss <stwiss.opensource@diasemi.com>

This patch set adds support for the Dialog DA9061 Power Management IC.
Support is made by altering the existing DA9062 device driver, where
appropriate.

In this patch set the following is provided:

[PATCH V5 1/8] Binding for watchdog
[PATCH V5 2/8] Binding for thermal supervisor
[PATCH V5 3/8] Binding for MFD and regulators
[PATCH V5 4/8] MFD core support
[PATCH V5 5/8] BUCKs and LDOs
[PATCH V5 6/8] Watchdog
[PATCH V5 7/8] PMIC temperature monitoring
[PATCH V5 8/8] MAINTAINERS update

Hello,

The only minor changes this time.

- minor comments to the thermal driver
- rebase from v4.9 to v4.11-rc3
- update the copyright header for the Dialog Legal dept
- fix checkpatch warnings
- add Acked-by

Some previous patches from this set have been applied already:

- Onkey binding
- Onkey driver
- Watchdog driver

This patch applies against linux-next and v4.11-rc3 

Thank you,
Steve Twiss, Dialog Semiconductor

Steve Twiss (7):
  Documentation: devicetree: watchdog: da9062/61 watchdog timer binding
  Documentation: devicetree: thermal: da9062/61 TJUNC temperature
    binding
  Documentation: devicetree: mfd: da9062/61 MFD binding
  mfd: da9061: MFD core support
  regulator: da9061: BUCK and LDO regulator driver
  thermal: da9062/61: Thermal junction temperature monitoring driver
  MAINTAINERS: da9062/61 updates to the Dialog Semiconductor search
    terms

 Documentation/devicetree/bindings/mfd/da9062.txt   |  49 ++-
 .../devicetree/bindings/thermal/da9062-thermal.txt |  37 ++
 .../devicetree/bindings/watchdog/da9062-wdt.txt    |  23 ++
 MAINTAINERS                                        |   4 +
 drivers/mfd/Kconfig                                |   5 +-
 drivers/mfd/da9062-core.c                          | 427 ++++++++++++++++++++-
 drivers/regulator/Kconfig                          |   4 +-
 drivers/regulator/da9062-regulator.c               | 303 ++++++++++++++-
 drivers/thermal/Kconfig                            |  10 +
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/da9062-thermal.c                   | 315 +++++++++++++++
 include/linux/mfd/da9062/core.h                    |  29 +-
 include/linux/mfd/da9062/registers.h               |   5 +-
 13 files changed, 1162 insertions(+), 50 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/da9062-thermal.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/da9062-wdt.txt
 create mode 100644 drivers/thermal/da9062-thermal.c

-- 
end-of-patch for PATCH V6
