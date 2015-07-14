From: S Twiss <stwiss.opensource@diasemi.com>
Subject: [PATCH RFC V1 0/3]  da9062: Add DA9062 OnKey support using the existing DA9063 OnKey driver
Date: Tue, 14 Jul 2015 14:07:50 +0100
Message-ID: <cover.1436879270.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: DEVICETREE <devicetree@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, LINUXINPUT <linux-input@vger.kernel.org>, LINUXKERNEL <linux-kernel@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, RTCLINUX <rtc-linux@googlegroups.com>, Rob Herring <robh+dt@kernel.org>, S Twiss <stwiss.opensource@diasemi.com>, Samuel Ortiz <sameo@linux.intel.com>
Cc: David Dajun Chen <david.chen@diasemi.com>, Support Opensource <support.opensource@diasemi.com>
List-Id: linux-input@vger.kernel.org

From: S Twiss <stwiss.opensource@diasemi.com>

This patch set adds OnKey support for the Dialog DA9062 Power Management IC.
Changes are made to the existing DA9063 OnKey component so that functionality
in this device driver can be re-used to support the DA9062 OnKey.

This following patch set is the proposed method for re-using the existing
kernel OnKey drivers for chips whose OnKey blocks are functionally similar
to the DA9063 OnKey.

The main points for the MFD core and device tree changes are as follows.

- Alteration of the DA9063 OnKey Kconfig needs to be updated to depend on
  both MFD_DA9063 "or" MFD_DA9062. There is no explicit DA9062 OnKey Kconfig.
- The DA9062 MFD core should add a new OnKey resource as usual and an entry
  in the mfd_cell to support a component name and of_compatible for
  "da9062-onkey" and "dlg,da9062-onkey".
- The device tree binding support should include a compatible string for
  "dlg,da9062-onkey"

The main points for the OnKey changes are as follows:

A generic structure is used (called da9063_compatible_onkey_regmap) to hold
all generic registers and bitmasks for use with this type of OnKey component.

Functions in the DA9063 OnKey will be refactored to use this compatibility
struct and all accesses to generic registers/masks will be made through
this table look-up instead of using defines from the register header files
directly

Linkage between the DA9062 MFD and the DA9063 OnKey driver is created through
the use of an of_match_table entry in the platform_driver structure.
A re-work of da9063_onkey_probe() is necessary to use the of_match_node() and
dev_get_regmap() functions: this will provide initialisation of the generic
registers and masks and allow access to the regmap according to the correct
device tree specification.

The addition of a of_device_id table for DA9063 and DA9062 default data
is created. 

In this patch set the following is provided:
 - [PATCH V1 1/3]: MFD changes in DA9062 to support OnKey
 - [PATCH V1 2/3]: Update existing DA9063 OnKey to add DA9062 support
 - [PATCH V1 3/3]: Device tree bindings for DA9062 OnKey component

This patch applies against linux-next and next-20150708 

Thank you,
Steve Twiss, Dialog Semiconductor Ltd.

S Twiss (3):
  mfd: da9062: Support for the DA9063 OnKey in the DA9062 core
  onkey: da9063: Add DA9062 OnKey capability to DA9063 OnKey driver
  devicetree: da9062: Add device tree bindings for DA9062 OnKey

 Documentation/devicetree/bindings/mfd/da9062.txt |  18 +++
 drivers/input/misc/Kconfig                       |   6 +-
 drivers/input/misc/da9063_onkey.c                | 139 ++++++++++++++++++-----
 drivers/mfd/da9062-core.c                        |  11 ++
 4 files changed, 141 insertions(+), 33 deletions(-)

-- 
end-of-patch for PATCH RFC V1
