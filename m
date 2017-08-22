From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/3] Dollar Cove TI PMIC support for Intel Cherry Trail
Date: Tue, 22 Aug 2017 07:57:07 +0200
Message-ID: <20170822055710.26515-1-tiwai@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Lee Jones <lee.jones@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Johannes Stezenbach <js@sig21.net>, linux-input@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi,

this is a patch set to add the support for Dollar Cove TI PMIC found
on some Intel Cherry Trail laptops / tablets.  All drivers are based
on the original code from Intel downstream patches, with lots of
rewrites and cleanups.  MFD driver is implemented as a stand-alone
like a few other variants, and the input driver got a diet in a
minimalistic form.

The patch set has been tested on ASUS E100H and E200H, as well as on
HP x210.


thanks,

Takashi

===

Takashi Iwai (3):
  mfd: Add support for Cherry Trail Dollar Cove TI PMIC
  input/keyboard: Add support for Dollar Cove TI power button
  ACPI / PMIC: Add opregion driver for Intel Dollar Cove TI PMIC

 drivers/acpi/Kconfig                  |   6 ++
 drivers/acpi/Makefile                 |   1 +
 drivers/acpi/pmic/intel_pmic_dc_ti.c  | 135 ++++++++++++++++++++++++
 drivers/input/keyboard/Kconfig        |   7 ++
 drivers/input/keyboard/Makefile       |   1 +
 drivers/input/keyboard/dc_ti_pwrbtn.c |  85 +++++++++++++++
 drivers/mfd/Kconfig                   |  13 +++
 drivers/mfd/Makefile                  |   1 +
 drivers/mfd/intel_soc_pmic_dc_ti.c    | 189 ++++++++++++++++++++++++++++++++++
 9 files changed, 438 insertions(+)
 create mode 100644 drivers/acpi/pmic/intel_pmic_dc_ti.c
 create mode 100644 drivers/input/keyboard/dc_ti_pwrbtn.c
 create mode 100644 drivers/mfd/intel_soc_pmic_dc_ti.c

-- 
2.14.0

