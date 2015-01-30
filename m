From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH v3 00/20] power_supply: Allow safe usage of power supply
Date: Fri, 30 Jan 2015 15:47:38 +0100
Message-ID: <1422629278-12202-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@googlemail.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Darren Hart <dvhart@infradead.org>, Support Opensource <support.opensource@diasemi.com>, Milo Kim <milo.kim@ti.com>, Julian Andres Klode <jak@jak-linux.org>, Marc Dietrich <marvin24@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-acpi@vger.kernel.org, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, patches@opensource.wolfsonmicro.com, ac100@lists.launchpad.net, linux-tegra@vger.kernel.org, devel@driverdev.osuosl.org, Linus Walleij <linus.walleij@linaro.org>, Samuel
Cc: Thomas Gleixner <tglx@linutronix.de>, Pavel Machek <pavel@ucw.cz>, Kyungmin Park <kyungmin.park@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: linux-input@vger.kernel.org

Hi,

The patchset changes power supply API and drivers implementing
power supply class.


TLDR for driver and subsystem maintainers
=========================================
Two patches of patchset change power_supply_register() function so in
the same time they touch all drivers. I am kindly asking for acks,
review and help in testing.

Please look at:
 - patch 2: power_supply: Move run-time configuration to separate structure
 - patch 11: power_supply: Change ownership from driver to core

These are huge.


Introduction
============
Patchset tries to fix following race scenario:

Thread 1: charger manager, CONSUMER
Thread 2: power supply driver, PROVIDER

THREAD 1 (charger manager)         THREAD 2 (power supply driver)
==========================         ==============================
psy = power_supply_get_by_name()
                                   Driver unbind, .remove
                                     power_supply_unregister()
                                     Device fully removed
psy->get_property()

To properly fix the race the patchset:
1. Moves ownership of power_supply structure from driver (provider) to
   power supply core.
2. Adds power_supply_get_property()-like API for safe access by consumer.
3. Adds power_supply_put() which will reclaim memory.


Description
=========== 
The patchset is quite big and touches power supply API so a lot of
changes in drivers are needed.

I modifed all drivers I found. However I only compile tested them
(plus Smatch, Sparse and coccicheck). I did not test them on real
hardware (except max14577, max77693, max17040, max17042
and charger-manager).

This is a little different than my previous approaches [1][2] for fixing
usage of power supply by some consumer, if driver implementing it is
unbound.

My previous approach [1][2] limited the race but did not close it.
Still the consumer of power supply by calling power_supply_get_propert(psy...)
may reference invalid memory because the producer freed it.

Actually, because struct power_supply is exposed to consumers, the
core should be the owner of it. This is accomplished in patch 11/20
("power_supply: Change ownership from driver to core").


What the patchset does in steps
===============================
1. Some preparation steps are necessary - patch 1 and 2. The driver
   implementing power supply won't be able to fill structure before
   calling power_supply_register(). So 'power_supply_config'
   is introduced in patch 2 ("power_supply: Move run-time configuration
   to separate structure"). Unfortunately this touches all drivers.
   *All drivers touched.*

2. Safe API wrappers (and usage counter) are added (power_supply_*()).

3. Patch 11: ownership of 'struct power_supply' is moved from driver
   to the core.
   *All drivers touched.*

4. power_supply_put() is added which reclaims resources.


The patchset is rebased on next-20150129. Bisectability is preserved.
All later patches depend on previous ones so it could be pulled in
steps, but cherry-picking won't work.

Changes since v2
================
1. Rewrite all drivers to new power_supply_register().
2. Add reviewed-by Bartlomiej Zolnierkiewicz (internal review)
3. Add reviewed-by Sebastian Reichel [3] (to patches which I did not
   change in major way between v2 and v3).
4. Use atomic usage counter of power supply on each of:
   a. register/unregister,
   b. get/put.

Changes since v1
================
1. Add new patches (1, 2, 11, 19).
2. Preserved ack-s where there weren't any changes.
3. Patch 3: Add use counter.
4. Patch 3: Don't add wrapper for set_charged() because already exists
   one.


[1] https://lkml.org/lkml/2014/11/4/527
[2] https://lkml.org/lkml/2014/10/16/89
[3] https://lkml.org/lkml/2015/1/21/471

Best regards,
Krzysztof


Krzysztof Kozlowski (20):
  power_supply: Add driver private data
  power_supply: Move run-time configuration to separate structure
  power_supply: Add API for safe access of power supply function attrs
  power_supply: sysfs: Use power_supply_*() API for accessing function
    attrs
  power_supply: 88pm860x_charger: Use power_supply_*() API for accessing
    function attrs
  power_supply: ab8500: Use power_supply_*() API for accessing function
    attrs
  mfd: ab8500: Use power_supply_*() API for accessing function attrs
  power_supply: apm_power: Use power_supply_*() API for accessing
    function attrs
  power_supply: bq2415x_charger: Use power_supply_*() API for accessing
    function attrs
  power_supply: charger-manager: Use power_supply_*() API for accessing
    function attrs
  power_supply: Change ownership from driver to core
  power_supply: Add power_supply_put for decrementing device reference
    counter
  power_supply: Increment power supply use counter when obtaining
    references
  power_supply: charger-manager: Decrement the power supply's device
    reference counter
  x86/olpc/xo1/sci: Use newly added power_supply_put API
  x86/olpc/xo15/sci: Use newly added power_supply_put API
  power_supply: 88pm860x_charger: Decrement the power supply's device
    reference counter
  power_supply: bq2415x_charger: Decrement the power supply's device
    reference counter
  mfd: ab8500: Decrement the power supply's device reference counter
  arm: mach-pxa: Decrement the power supply's device reference counter

 arch/arm/mach-pxa/raumfeld.c              |   4 +-
 arch/x86/platform/olpc/olpc-xo1-sci.c     |   4 +-
 arch/x86/platform/olpc/olpc-xo15-sci.c    |   4 +-
 drivers/acpi/ac.c                         |  32 ++--
 drivers/acpi/battery.c                    |  54 ++++---
 drivers/acpi/sbs.c                        |  68 +++++----
 drivers/hid/hid-input.c                   |  51 ++++---
 drivers/hid/hid-sony.c                    |  43 +++---
 drivers/hid/hid-wiimote-modules.c         |  41 ++---
 drivers/hid/hid-wiimote.h                 |   3 +-
 drivers/hid/wacom.h                       |   8 +-
 drivers/hid/wacom_sys.c                   |  70 +++++----
 drivers/mfd/ab8500-sysctrl.c              |   9 +-
 drivers/platform/x86/compal-laptop.c      |  29 ++--
 drivers/power/88pm860x_battery.c          |  40 ++---
 drivers/power/88pm860x_charger.c          |  61 +++++---
 drivers/power/ab8500_btemp.c              |  75 +++++----
 drivers/power/ab8500_charger.c            | 139 +++++++++--------
 drivers/power/ab8500_fg.c                 | 129 +++++++---------
 drivers/power/abx500_chargalg.c           |  98 ++++++------
 drivers/power/apm_power.c                 |   6 +-
 drivers/power/bq2415x_charger.c           | 107 +++++++------
 drivers/power/bq24190_charger.c           | 103 ++++++-------
 drivers/power/bq24735-charger.c           |  53 ++++---
 drivers/power/bq27x00_battery.c           |  70 ++++-----
 drivers/power/charger-manager.c           | 158 +++++++++++--------
 drivers/power/collie_battery.c            |  75 +++++----
 drivers/power/da9030_battery.c            |  32 ++--
 drivers/power/da9052-battery.c            |  25 +--
 drivers/power/ds2760_battery.c            |  56 +++----
 drivers/power/ds2780_battery.c            |  45 +++---
 drivers/power/ds2781_battery.c            |  46 +++---
 drivers/power/ds2782_battery.c            |  30 ++--
 drivers/power/generic-adc-battery.c       |  54 ++++---
 drivers/power/goldfish_battery.c          |  62 ++++----
 drivers/power/gpio-charger.c              |  42 +++---
 drivers/power/intel_mid_battery.c         |  57 ++++---
 drivers/power/ipaq_micro_battery.c        |  34 +++--
 drivers/power/isp1704_charger.c           |  49 +++---
 drivers/power/jz4740-battery.c            |  37 +++--
 drivers/power/lp8727_charger.c            |  94 ++++++------
 drivers/power/lp8788-charger.c            |  62 +++++---
 drivers/power/ltc2941-battery-gauge.c     |  51 ++++---
 drivers/power/max14577_charger.c          |  34 +++--
 drivers/power/max17040_battery.c          |  31 ++--
 drivers/power/max17042_battery.c          |  45 ++++--
 drivers/power/max77693_charger.c          |  32 ++--
 drivers/power/max8903_charger.c           |  52 ++++---
 drivers/power/max8925_power.c             |  98 ++++++------
 drivers/power/max8997_charger.c           |  31 ++--
 drivers/power/max8998_charger.c           |  32 ++--
 drivers/power/olpc_battery.c              |  54 ++++---
 drivers/power/pcf50633-charger.c          | 105 +++++++------
 drivers/power/pda_power.c                 |  65 ++++----
 drivers/power/pm2301_charger.c            |  48 +++---
 drivers/power/pm2301_charger.h            |   1 +
 drivers/power/pmu_battery.c               |  42 ++++--
 drivers/power/power_supply_core.c         | 243 ++++++++++++++++++++++--------
 drivers/power/power_supply_leds.c         |  25 +--
 drivers/power/power_supply_sysfs.c        |  24 +--
 drivers/power/rt5033_battery.c            |  27 ++--
 drivers/power/rx51_battery.c              |  27 ++--
 drivers/power/s3c_adc_battery.c           |  76 +++++-----
 drivers/power/sbs-battery.c               |  71 ++++-----
 drivers/power/smb347-charger.c            | 108 +++++++------
 drivers/power/test_power.c                |  53 ++++---
 drivers/power/tosa_battery.c              | 112 ++++++++------
 drivers/power/tps65090-charger.c          |  43 +++---
 drivers/power/twl4030_charger.c           |  65 ++++----
 drivers/power/twl4030_madc_battery.c      |  41 ++---
 drivers/power/wm831x_backup.c             |  26 ++--
 drivers/power/wm831x_power.c              |  95 ++++++------
 drivers/power/wm8350_power.c              |  89 ++++++-----
 drivers/power/wm97xx_battery.c            |  37 ++---
 drivers/power/z2_battery.c                |  60 ++++----
 drivers/staging/nvec/nvec_power.c         |  34 +++--
 include/linux/hid.h                       |   6 +-
 include/linux/mfd/abx500/ux500_chargalg.h |  11 +-
 include/linux/mfd/rt5033.h                |   2 +-
 include/linux/mfd/wm8350/supply.h         |   6 +-
 include/linux/power/charger-manager.h     |   3 +-
 include/linux/power_supply.h              |  70 +++++++--
 82 files changed, 2467 insertions(+), 1867 deletions(-)

-- 
1.9.1
