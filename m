From: S Twiss <stwiss.opensource@diasemi.com>
Subject: [PATCH V3 0/3]  Add OnKey support for DA9063
Date: Thu, 30 Apr 2015 12:26:34 +0100
Message-ID: <cover.1430393194.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Steve Twiss <stwiss.opensource@diasemi.com>
Cc: DT <devicetree@vger.kernel.org>, David Dajun Chen <david.chen@diasemi.com>, INPUT <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Support Opensource <support.opensource@diasemi.com>
List-Id: linux-input@vger.kernel.org

From: Steve Twiss <stwiss.opensource@diasemi.com>

This patch set adds OnKey driver support for the Dialog
Semiconductor DA9063 PMIC.

[PATCH V3 1/3]: kernel driver onkey support
[PATCH V3 2/3]: device tree bindings document
[PATCH V3 3/3]: mfd core support

Thank you,
Steve Twiss, Dialog Semiconductor Ltd.

S Twiss (3):
  input: misc: da9063: OnKey driver
  devicetree: Add bindings for DA9063 OnKey
  mfd: da9063: MFD support for OnKey driver

 Documentation/devicetree/bindings/mfd/da9063.txt |  18 ++
 drivers/input/misc/Kconfig                       |  10 +
 drivers/input/misc/Makefile                      |   1 +
 drivers/input/misc/da9063_onkey.c                | 227 +++++++++++++++++++++++
 drivers/mfd/da9063-core.c                        |  54 ++++++
 include/linux/mfd/da9063/pdata.h                 |   1 +
 6 files changed, 311 insertions(+)
 create mode 100644 drivers/input/misc/da9063_onkey.c

-- 
end-of-patch for PATCH V3
