From: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v5 00/20] power_supply: Allow safe usage of power supply
Date: Fri, 27 Feb 2015 09:19:41 +0100
Message-ID: <1425025201-15926-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, David Herrmann <dh.herrmann-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, Cezary Jackiewicz <cezary.jackiewicz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Darren Hart <dvhart-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Support Opensource <support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Milo Kim <milo.kim-l0cyMroinI0@public.gmane.org>, Julian Andres Klode <jak-4HMq4SXA452hPH1hqNUYSQ@public.gmane.org>, Marc Dietrich <marvin24-Mmb7MZpHnFY@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, platform-driver-x86-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, ac100-oU9gvf+ajcQ97yFScArB1dHuzzzSOjJt@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel
Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi,


The patchset fixes invalid memory accesses in certain race scenarios by
moving ownership of struct power_supply to the core. All drivers are
modified.


TLDR for driver and subsystem maintainers
=========================================
Two patches of patchset change power_supply_register() function so in
the same time they touch all drivers. I am kindly asking for acks,
review and help in testing.

Especially please take a look at:
 - patch 2: power_supply: Move run-time configuration to separate structure
 - patch 11: power_supply: Change ownership from driver to core

I still need acks for changes in subsystems:
1. x86/olpc,
2. ACPI,
3. HID.


Problem to fix
==============
Patchset tries to fix invalid memory accesses occurring in following
race scenario:

Thread 1: charger manager, CONSUMER
Thread 2: power supply driver, PROVIDER

THREAD 1 (consumer)                THREAD 2 (provider)
===================                ===================
psy = power_supply_get_by_name()
                                   Driver unbind, .remove
                                     power_supply_unregister()
                                     Device fully removed
psy->get_property()

The consumer of power supply will reference invalid memory because
the provider already freed it.


The fix
=======
To properly fix the race the patchset:
1. Moves ownership of power_supply structure from driver (provider) to
   power supply core.
2. Adds power_supply_get_property()-like API for safe access by consumer.
3. Adds power_supply_put() which will reclaim memory.


I modifed all drivers I found. However I only compile tested them
(plus Smatch, Sparse and coccicheck). I did not test them on real
hardware (except max14577, max77693, max17040, max17042
and charger-manager).


What the patchset does in steps
===============================
1. Some preparation steps are necessary - patch 1 and 2. The driver
   implementing power supply won't be able to fill structure before
   calling power_supply_register(). So 'power_supply_config'
   is introduced in patch 2 ("power_supply: Move run-time configuration
   to separate structure"). Unfortunately this touches all drivers.
   *All drivers are touched.*

2. Safe API wrappers (and usage counter) are added (power_supply_*()).

3. Patch 11: ownership of 'struct power_supply' is moved from driver
   to the core.
   *All drivers are touched.*

4. power_supply_put() is added which reclaims resources.


Dependencies
============
The patchset is rebased on v4.0-rc1, latest battery tree and my latest
power supply changes:
1. compal-laptop: two fixes [1].

Bisect-ability is preserved. All later patches depend on previous ones
so it could be pulled in steps, but cherry-picking won't work.

Patchset is available also here:
https://git.linaro.org/people/marek.szyprowski/linux-srpol.git
branch: v4.0-rc1-power-supply-core-ownership


Changes since v4
================
1. Rebased on current battery tree. This introduced new changes:
   - new devm-like register functions,
   - new driver: da9150-charger.
2. Add acks: Darren Hart (compal-laptop.c, p. 11), Lee Jones
   (mfd, p. 11).

Changes since v3
================
1. Fix Jonghwa's email in his ack (spotted by Stefan Wahren)
2. Update power_supply_register() documentation.
3. Fix putting the reference to power supply in bq2415x_charger.c (put
   it when it is non-NULL).
4. Add acks: Robert Jarzmik (patch 20), Darren Hart (p. 2), Pavel
   Machek (p. 1-3), Marc Dietrich (p. 2 and 11).

Changes since v2
================
1. Rewrite all drivers to new power_supply_register().
2. Add reviewed-by Bartlomiej Zolnierkiewicz (internal review)
3. Add reviewed-by Sebastian Reichel [2] (to patches which I did not
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


[1] https://lkml.org/lkml/2015/1/21/471
[2] https://lkml.org/lkml/2015/2/20/150

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
 drivers/acpi/ac.c                         |  32 +--
 drivers/acpi/battery.c                    |  54 ++---
 drivers/acpi/sbs.c                        |  68 +++---
 drivers/hid/hid-input.c                   |  51 +++--
 drivers/hid/hid-sony.c                    |  43 ++--
 drivers/hid/hid-wiimote-modules.c         |  41 ++--
 drivers/hid/hid-wiimote.h                 |   3 +-
 drivers/hid/wacom.h                       |   8 +-
 drivers/hid/wacom_sys.c                   |  70 +++---
 drivers/mfd/ab8500-sysctrl.c              |   9 +-
 drivers/platform/x86/compal-laptop.c      |  29 ++-
 drivers/power/88pm860x_battery.c          |  40 ++--
 drivers/power/88pm860x_charger.c          |  61 ++++--
 drivers/power/ab8500_btemp.c              |  75 ++++---
 drivers/power/ab8500_charger.c            | 139 ++++++------
 drivers/power/ab8500_fg.c                 | 130 +++++------
 drivers/power/abx500_chargalg.c           |  98 ++++-----
 drivers/power/apm_power.c                 |   6 +-
 drivers/power/bq2415x_charger.c           | 107 +++++-----
 drivers/power/bq24190_charger.c           | 103 +++++----
 drivers/power/bq24735-charger.c           |  53 ++---
 drivers/power/bq27x00_battery.c           |  70 +++---
 drivers/power/charger-manager.c           | 159 ++++++++------
 drivers/power/collie_battery.c            |  75 ++++---
 drivers/power/da9030_battery.c            |  33 +--
 drivers/power/da9052-battery.c            |  25 ++-
 drivers/power/da9150-charger.c            |  80 +++----
 drivers/power/ds2760_battery.c            |  56 ++---
 drivers/power/ds2780_battery.c            |  45 ++--
 drivers/power/ds2781_battery.c            |  47 ++--
 drivers/power/ds2782_battery.c            |  30 +--
 drivers/power/generic-adc-battery.c       |  54 ++---
 drivers/power/goldfish_battery.c          |  63 +++---
 drivers/power/gpio-charger.c              |  42 ++--
 drivers/power/intel_mid_battery.c         |  57 +++--
 drivers/power/ipaq_micro_battery.c        |  34 +--
 drivers/power/isp1704_charger.c           |  49 +++--
 drivers/power/jz4740-battery.c            |  37 ++--
 drivers/power/lp8727_charger.c            |  94 ++++----
 drivers/power/lp8788-charger.c            |  62 +++---
 drivers/power/ltc2941-battery-gauge.c     |  51 +++--
 drivers/power/max14577_charger.c          |  34 +--
 drivers/power/max17040_battery.c          |  31 +--
 drivers/power/max17042_battery.c          |  45 ++--
 drivers/power/max77693_charger.c          |  32 +--
 drivers/power/max8903_charger.c           |  52 ++---
 drivers/power/max8925_power.c             |  98 +++++----
 drivers/power/max8997_charger.c           |  31 +--
 drivers/power/max8998_charger.c           |  32 +--
 drivers/power/olpc_battery.c              |  54 ++---
 drivers/power/pcf50633-charger.c          | 105 +++++----
 drivers/power/pda_power.c                 |  66 +++---
 drivers/power/pm2301_charger.c            |  48 +++--
 drivers/power/pm2301_charger.h            |   1 +
 drivers/power/pmu_battery.c               |  42 ++--
 drivers/power/power_supply_core.c         | 344 +++++++++++++++++++++++-------
 drivers/power/power_supply_leds.c         |  25 +--
 drivers/power/power_supply_sysfs.c        |  24 +--
 drivers/power/rt5033_battery.c            |  27 ++-
 drivers/power/rx51_battery.c              |  27 ++-
 drivers/power/s3c_adc_battery.c           |  77 ++++---
 drivers/power/sbs-battery.c               |  71 +++---
 drivers/power/smb347-charger.c            | 108 +++++-----
 drivers/power/test_power.c                |  53 +++--
 drivers/power/tosa_battery.c              | 112 ++++++----
 drivers/power/tps65090-charger.c          |  43 ++--
 drivers/power/twl4030_charger.c           |  65 +++---
 drivers/power/twl4030_madc_battery.c      |  41 ++--
 drivers/power/wm831x_backup.c             |  26 ++-
 drivers/power/wm831x_power.c              |  95 +++++----
 drivers/power/wm8350_power.c              |  89 ++++----
 drivers/power/wm97xx_battery.c            |  37 ++--
 drivers/power/z2_battery.c                |  60 +++---
 drivers/staging/nvec/nvec_power.c         |  34 +--
 include/linux/hid.h                       |   6 +-
 include/linux/mfd/abx500/ux500_chargalg.h |  11 +-
 include/linux/mfd/rt5033.h                |   2 +-
 include/linux/mfd/wm8350/supply.h         |   6 +-
 include/linux/power/charger-manager.h     |   3 +-
 include/linux/power_supply.h              |  82 +++++--
 83 files changed, 2608 insertions(+), 1926 deletions(-)

-- 
1.9.1
