From: S Twiss <stwiss.opensource@diasemi.com>
Subject: [PATCH RFC V1 0/3]  da9062: Add DA9062 RTC support using the existing DA9063 RTC driver
Date: Thu, 9 Jul 2015 08:45:54 +0100
Message-ID: <cover.1436427954.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail1.bemta5.messagelabs.com ([195.245.231.151]:28075 "EHLO
	mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750967AbbGIHvH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 9 Jul 2015 03:51:07 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, DEVICETREE <devicetree@vger.kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, LINUXINPUT <linux-input@vger.kernel.org>, LINUXKERNEL <linux-kernel@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, RTCLINUX <rtc-linux@googlegroups.com>, Rob Herring <robh+dt@kernel.org>, S Twiss <stwiss.opensource@diasemi.com>, Samuel Ortiz <sameo@linux.intel.com>
Cc: David Dajun Chen <david.chen@diasemi.com>, Support Opensource <support.opensource@diasemi.com>

From: S Twiss <stwiss.opensource@diasemi.com>

This patch set adds RTC support for the Dialog DA9062 Power Management IC.
Changes are made to the existing DA9063 RTC component so that functionality
in this device driver can be re-used to support the DA9062 RTC.

This following patch set is the proposed method for re-using existing kernel
RTC drivers for chips whose RTC blocks are functionally similar to the
DA9063 RTC.

There is already a precedence for reuse of this type in the kernel, see
linux-mainline/v4.1 drivers/rtc/rtc-pm8xxx.c +34
This patch set will follow that example.

The main points for the MFD core and device tree changes are as follows.

- Alteration of the DA9063 RTC Kconfig needs to be updated to depend on
  both MFD_DA9063 "or" MFD_DA9062. There is no explicit DA9062 RTC Kconfig.
- The DA9062 MFD core should add a new RTC resource as usual and an entry
  in the mfd_cell to support a component name and of_compatible for
  "da9062-rtc" and "dlg,da9062-rtc".
- The device tree binding support should include a compatible string for
  "dlg,da9062-rtc"

The main points for the RTC changes are as follows:

A generic structure is used (called da9063_compatible_rtc_regmap) to hold
all generic registers and bitmasks for use with this type of RTC component.

Functions in the DA9063 RTC will be refactored to use this compatibility
struct and all accesses to generic registers/masks will be made through
this table look-up instead of using defines from the register header files
directly

Linkage between the DA9062 MFD and the DA9063 RTC driver is created through
the use of an of_match_table entry in the platform_driver structure.
A re-work of da9063_rtc_probe() is necessary to use the of_match_node() and
dev_get_regmap() functions: this will provide initialisation of the generic
registers and masks and allow access to the regmap according to the correct
device tree specification.

The addition of a of_device_id table for DA9063 and DA9062 default data
is created. This method of initialisation for the DA9063 RTC component
works well for different chip types, and is only slightly complicated when
distinguishing the difference between support for DA9063-AD and DA9063-BB.

In this patch set the following is provided:
 - [PATCH V1 1/3]: MFD changes in DA9062 to support RTC
 - [PATCH V1 2/3]: Update existing DA9063 RTC to add DA9062 support
 - [PATCH V1 3/3]: Device tree bindings for DA9062 RTC component

This patch applies against linux-next and next-20150708 

Thank you,
Steve Twiss, Dialog Semiconductor Ltd.

S Twiss (3):
  mfd: da9062: Support for the DA9063 RTC in the DA9062 core
  rtc: da9063: Add DA9062 RTC capability to DA9063 RTC driver
  devicetree: da9062: Add device tree bindings for DA9062 RTC

 Documentation/devicetree/bindings/mfd/da9062.txt |   9 +
 drivers/mfd/da9062-core.c                        |  11 +
 drivers/rtc/Kconfig                              |   6 +-
 drivers/rtc/rtc-da9063.c                         | 435 ++++++++++++++++-------
 4 files changed, 330 insertions(+), 131 deletions(-)

-- 
end-of-patch for PATCH RFC V1

