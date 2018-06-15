From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: [PATCH v6 0/4] mfd/regulator/clk/input: bd71837: ROHM BD71837 PMIC
 driver
Date: Fri, 15 Jun 2018 16:27:43 +0300
Message-ID: <cover.1529067662.git.matti.vaittinen@fi.rohmeurope.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, lee.jones@linaro.org, lgirdwood@gmail.com, broonie@kernel.org, mazziesaccount@gmail.com, arnd@arndb.de, dmitry.torokhov@gmail.com, sre@kernel.org, chenjh@rock-chips.com, andrew.smirnov@gmail.com, linus.walleij@linaro.org, kstewart@linuxfoundation.org, heiko@sntech.de, gregkh@linuxfoundation.org
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
List-Id: linux-input@vger.kernel.org

Patch series adding support for ROHM BD71837 PMIC.

BD71837 is a programmable Power Management IC for powering single-core,
dual-core, and quad-core SoC’s such as NXP-i.MX 8M. It is optimized for
low BOM cost and compact solution footprint. It integrates 8 buck
regulators and 7 LDO’s to provide all the power rails required by the
SoC and the commonly used peripherals.

Rewgulator part is already applied. This is reduced set of patches
containing the MFD part, clock gate for 32.768 KHz clock buffer, input
driver for power button and device-tree bindings for MFD.

Changelog v6
- Added power-key input driver
Based on feedback from Rob Herring and Stephen Boyd
- Added link to datasheet
- Removed interrupt-controller from DT and fixed binding document
- clk styling fixes
- remove clkdev usage
- add clk bindings to MFD documentation
- removed clk binding document

Changelog v5
- dropped regulator patches which are already applied to Mark's tree
Based on feedback from Rob Herring and Stephen Boyd
- mfd bindings: explain why this can be interrupt-controller
- mfd bindings: describe interrupts better
- mfd bindings: require one cell interrupt specifier
- mfd bindings: use generic node names in example
- mfd driver:   ack masked interrupt once at init
- clk bindings: use generic node names in example
- clk driver:   use devm
- clk driver:   use of_clk_add_hw_provider
- clk driver:   change severity of print and how prints are emitted at
                probe error path.
- clk driver:   dropped forward declared functions
- clk configs:  drop unnecessary dependencies
- clk driver:   other styling issues
- mfd/clk DT:   drop clk node.

Changelog v4
- remove mutex from regulator state check as core prevents simultaneous
  accesses
- allow voltage change for bucks 1 to 4 when regulator is enabled
- fix indentiation problems
- properly correct SPDX comments

Changelog v3
- kill unused variable
- kill unused definitions
- use REGMAP_IRQ_REG

Changelog v2
Based on feedback from Mark Brown
- Squashed code and buildfile changes to same patch
- Fixed some styling issues
- Changed SPDX comments to CPP style
- Error out if voltage is changed when regulator is enabled instead of
  Disabling the regulator for duration of change
- Use devm_regulator_register
- Remove compatible usage from regulators - use parent dev for config
- Add a note about using regulator-boot-on for BUCK6 and 7
- fixed warnings from kbuild test robot

patch 1:
        MFD driver and definitions bringing interrupt support and
        enabling clk and regulator subsystems.
patch 2:
        MFD driver DT bindings
patch 3:
        clock driver for BD71837 clock output
patch 4:
        power button driver for power button connected to BD71837

This patch series is based on for-mfd-next

---

Matti Vaittinen (4):
  mfd: bd71837: mfd driver for ROHM BD71837 PMIC
  mfd: bd71837: Devicetree bindings for ROHM BD71837 PMIC
  clk: bd71837: Add driver for BD71837 PMIC clock
  input/power: Add driver for BD71837/BD71847 PMIC power button

 .../devicetree/bindings/mfd/rohm,bd71837-pmic.txt  |  67 ++++
 drivers/clk/Kconfig                                |   6 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/clk-bd71837.c                          | 145 ++++++++
 drivers/input/misc/Kconfig                         |  10 +
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/bd718xx-pwrkey.c                |  90 +++++
 drivers/mfd/Kconfig                                |  13 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/bd71837.c                              | 249 ++++++++++++++
 include/linux/mfd/bd71837.h                        | 370 +++++++++++++++++++++
 11 files changed, 953 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
 create mode 100644 drivers/clk/clk-bd71837.c
 create mode 100644 drivers/input/misc/bd718xx-pwrkey.c
 create mode 100644 drivers/mfd/bd71837.c
 create mode 100644 include/linux/mfd/bd71837.h

-- 
2.14.3
