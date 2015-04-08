From: Steve Twiss <stwiss.opensource@diasemi.com>
Subject: [PATCH V1 0/2]  Add OnKey support for DA9063
Date: Wed, 8 Apr 2015 15:53:24 +0100
Message-ID: <cover.1428504804.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Steve Twiss <stwiss.opensource@diasemi.com>
Cc: DT <devicetree@vger.kernel.org>, David Dajun Chen <david.chen@diasemi.com>, INPUT <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

From: Steve Twiss <stwiss.opensource@diasemi.com>

This patch set adds OnKey driver support for the Dialog
Semiconductor DA9063 PMIC.

[PATCH V1 1/2]: kernel driver onkey support
[PATCH V1 2/2]: device tree bindings document

Thank you,
Steve Twiss, Dialog Semiconductor Ltd.

S Twiss (2):
  input: misc: da9063: OnKey driver
  devicetree: Add bindings for DA9063 OnKey

 Documentation/devicetree/bindings/mfd/da9063.txt |  22 ++-
 MAINTAINERS                                      |   2 +-
 drivers/input/misc/Kconfig                       |  10 +
 drivers/input/misc/Makefile                      |   1 +
 drivers/input/misc/da9063-onkey.c                | 227 +++++++++++++++++++++++
 drivers/mfd/da9063-core.c                        |  55 ++++++
 include/linux/mfd/da9063/pdata.h                 |   1 +
 7 files changed, 315 insertions(+), 3 deletions(-)
 create mode 100644 drivers/input/misc/da9063-onkey.c

-- 
end-of-patch for PATCH V1
