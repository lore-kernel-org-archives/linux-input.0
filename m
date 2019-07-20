From: Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH v3 0/2] Support for buttons on newer MS Surface devices
Date: Sat, 20 Jul 2019 17:05:09 +0200
Message-ID: <20190720150511.95076-1-luzmaximilian@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Chen Yu <yu.c.chen@intel.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Maximilian Luz <luzmaximilian@gmail.com>
List-Id: linux-input@vger.kernel.org

This series adds support for power and volume buttons on 5th and 6th
generation Microsoft Surface devices. Specifically, it adds support for
the power-button on the Surface Laptop 1 and Laptop 2, as well as
support for power- and (on-device) volume-buttons on the Surface Pro 5
(2017), Pro 6, and Book 2.

These devices use the same MSHW0040 device as on the Surface Pro 4,
however, whereas the Pro 4 uses an ACPI notify handler, the newer
devices use GPIO interrupts to signal these events.

The first patch of this series ensures that the surfacepro3_button
driver, used for MSHW0040 on the Pro 4, does not probe for the newer
devices. The second patch adapts soc_button_array to implement the
actual button support.

Changes in v3:
  - [PATCH 1/2] platform/x86: surfacepro3_button: Fix device check
    - Changed subject line to fit conventions.
    - Added comments to clarify ACPI/DSM specific behavior.
    - Change return type of introduced device check function to bool.

  - [PATCH 1/2] Input: soc_button_array - Add support for newer
      surface devices
    - Changed subject line to fit conventions.
    - Explicitly require CONFIG_ACPI via Kconfig instead of guarding
      with #ifdef CONFIG_ACPI in code.
    - Add supported Surface devices to module description in Kconfig.
    - Allow -EPROBE_DEFER and other errors to be propagated from
      gpiod_get.
    - Fix deferral process in case GPIO subsystem is not initialized.

Changes in v2:
  - [PATCH 1/2] platform: Fix device check for surfacepro3_button
    No changes.

  - [PATCH 2/2] input: soc_button_array for newer surface devices
    Ensure the patch compiles without CONFIG_ACPI.

Maximilian Luz (2):
  platform/x86: surfacepro3_button: Fix device check
  Input: soc_button_array - Add support for newer surface devices

 drivers/input/misc/Kconfig                |   6 +-
 drivers/input/misc/soc_button_array.c     | 141 ++++++++++++++++++++--
 drivers/platform/x86/surfacepro3_button.c |  47 ++++++++
 3 files changed, 178 insertions(+), 16 deletions(-)

-- 
2.22.0
