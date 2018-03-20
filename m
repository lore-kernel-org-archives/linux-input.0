From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v2 00/14] chrome_laptop: stop being a platform driver
Date: Tue, 20 Mar 2018 15:31:24 -0700
Message-ID: <20180320223138.234724-1-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Benson Leung <bleung@chromium.org>
Cc: Nick Dyer <nick@shmanahar.org>, Olof Johansson <olof@lixom.net>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi,

This series is a combination of Atmel touchscreen driver stopping using
platform data and moving over to generic device properties, and
chromeos-laptop switching from being platform driver, which is the wrong
abstraction for it, and moving to using i2c bis notifier. Switching from
platform driver to the notifiers allows us to get rid of the ugly code that
manually tries to handle deferrals in case i2c bus is not ready at the time
we start initializing the module.

Thanks!

Changes v1->v2:

- switched suspend mode handling to use DMI quirk. We'll clean it up properly
  in the Atmel driver later, for now we just want to untangle Atmel and
  chromeos-laptop

- added Nick's Acks.

Dmitry Torokhov (14):
  Input: atmel_mxt_ts - do not pass suspend mode in platform data
  Input: atmel_mxt_ts - switch from OF to generic device properties
  Input: atmel_mxt_ts - switch ChromeOS ACPI devices to generic props
  platform/chrome: chromeos_laptop - add SPDX identifier
  platform/chrome: chromeos_laptop - stop setting suspend mode for Atmel devices
  platform/chrome: chromeos_laptop - introduce pr_fmt()
  platform/chrome: chromeos_laptop - factor out getting IRQ from DMI
  platform/chrome: chromeos_laptop - rework i2c peripherals initialization
  platform/chrome: chromeos_laptop - parse DMI IRQ data once
  platform/chrome: chromeos_laptop - use I2C notifier to create devices
  platform/chrome: chromeos_laptop - rely on I2C to set up interrupt trigger
  platform/chrome: chromeos_laptop - use device properties for Pixel
  platform/chrome: chromeos_laptop - discard data for unneeded boards
  Input: atmel_mxt_ts - remove platform data support

 MAINTAINERS                                |   1 -
 drivers/input/touchscreen/atmel_mxt_ts.c   | 231 +++---
 drivers/platform/chrome/chromeos_laptop.c  | 896 +++++++++++----------
 include/linux/platform_data/atmel_mxt_ts.h |  31 -
 4 files changed, 579 insertions(+), 580 deletions(-)
 delete mode 100644 include/linux/platform_data/atmel_mxt_ts.h

-- 
Dmitry
