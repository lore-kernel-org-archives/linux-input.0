From: Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH 0/2] Support for buttons on newer MS Surface devices
Date: Thu, 20 Jun 2019 13:50:54 +0200
Message-ID: <20190620115056.4169-1-luzmaximilian@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Chen Yu <yu.c.chen@intel.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Maximilian Luz <luzmaximilian@gmail.com>
List-Id: linux-input@vger.kernel.org

This series adds suport for power and volume buttons on 5th and 6th
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

I think the changes to soc_button_array in the second patch warrant a
thorough review. I've tried to make things a bit more generic to be able
to integrate arbitrary ACPI GPIO power-/volume-button devices more
easily, I'm not sure if there may be reasons against this.

These patches have also been tested on various Surface devices via the
github.com/jakeday/linux-surface patchset.

Maximilian Luz (2):
  platform: Fix device check for surfacepro3_button
  input: soc_button_array for newer surface devices

 drivers/input/misc/soc_button_array.c     | 134 ++++++++++++++++++++--
 drivers/platform/x86/surfacepro3_button.c |  38 ++++++
 2 files changed, 160 insertions(+), 12 deletions(-)

-- 
2.22.0
