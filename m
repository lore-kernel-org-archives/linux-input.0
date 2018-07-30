From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: [PATCH v11 0/2] mfd/regulator/clk/input: bd71837: ROHM BD71837 PMIC
 driver
Date: Mon, 30 Jul 2018 13:41:44 +0300
Message-ID: <cover.1532946848.git.matti.vaittinen@fi.rohmeurope.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, eballetbo@gmail.com, linus.walleij@linaro.org, mazziesaccount@gmail.com, dmitry.torokhov@gmail.com
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, sboyd@kernel.org, broonie@kernel.org, linux-input@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
List-Id: linux-input@vger.kernel.org

Patch series adding support for ROHM BD71837 PMIC.

BD71837 is a programmable Power Management IC for powering single-core,
dual-core, and quad-core SoCs such as NXP-i.MX 8M. It is optimized for
low BOM cost and compact solution footprint. It integrates 8 buck
regulators and 7 LDOs to provide all the power rails required by the
SoC and the commonly used peripherals.

This is reduced set of patches containing only the MFD and devicetree
bindings. This enables alrady applied regulator part and power button
support using gpio-keys. Clock and reset support will be sent as separate
set of patches.

Changelog v11
More fixes based on comments from Lee Jones
- styling issues/spelling errors.
- drop i2c_client struct from driver data.
- add chip revision validation.

Changelog v10
Fixes based on comments from Lee Jones
- Drop the platform data.
- Drop the regmap wrapper functions and use regmap directly.
- Rename files with rohm-prefix.
- Replace goto from probe by in-place returns.
- Drop unnecessary i2c_id table.
- Change gpio_keys_button array to simple struct.
- Fix return value checks for regmap functions.
- Various styling/spelling fixes.
- Replace foo-bar with something more meaningfull in DT example

Changelog v9
Fixes initiated by feedback from Enric Balletbo Serra, Lee and Dmitry.
- Simplified control flow for probe
- Removed accidentally left squash commit message
- Some comma presence toggling after last member in an array =)
- Styling of multi line comments.

Changelog v8
- Dropped clk-bd71837 from series (will send later)
- Dropped bd718xx-pwrkey driver and used gpio_keys instead.
- Added power-button short/long press duration configuratio to MFD
- Cleaned MFD driver according to comments from Enric Balletbo Serra.
  (used devm, removed unnecessary header inclusions, removed redundant
  assignment, styling issues, allow building MFD part as module, fixed
  license mismatch).

Changelog v7
- patch 1: Cleaned MFD probe since MFD no longer directly reads DT
  properties.
- patch 1/4: Moved power-key related definitions from powerkey patch (4)
  to MFD patch (1) so that powerkey can be applied independently
- Patch 2 is unchanged.
- patch 3: Added missing allocation check back to clk probe

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
        enabling clk, regulator and input subsystems.
patch 2:
        MFD driver DT bindings

This patch series is based on for-mfd-next

---

Matti Vaittinen (2):
  mfd: bd71837: mfd driver for ROHM BD71837 PMIC
  mfd: bd71837: Devicetree bindings for ROHM BD71837 PMIC

 .../devicetree/bindings/mfd/rohm,bd71837-pmic.txt  |  62 ++++
 drivers/mfd/Kconfig                                |  13 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/rohm-bd718x7.c                         | 208 +++++++++++++
 include/linux/mfd/rohm-bd718x7.h                   | 332 +++++++++++++++++++++
 5 files changed, 616 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
 create mode 100644 drivers/mfd/rohm-bd718x7.c
 create mode 100644 include/linux/mfd/rohm-bd718x7.h

-- 
2.14.3
