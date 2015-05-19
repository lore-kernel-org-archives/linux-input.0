From: S Twiss <stwiss.opensource@diasemi.com>
Subject: [RESEND PATCH V4 0/3]  Add OnKey support for DA9063
Date: Tue, 19 May 2015 11:32:45 +0100
Message-ID: <cover.1432031565.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail1.bemta14.messagelabs.com ([193.109.254.108]:6650 "EHLO
	mail1.bemta14.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753711AbbESKfY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 19 May 2015 06:35:24 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Steve Twiss <stwiss.opensource@diasemi.com>
Cc: DT <devicetree@vger.kernel.org>, David Dajun Chen <david.chen@diasemi.com>, INPUT <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Support Opensource <support.opensource@diasemi.com>

From: Steve Twiss <stwiss.opensource@diasemi.com>

This patch set adds OnKey driver support for the Dialog
Semiconductor DA9063 PMIC.

[PATCH V4 1/3]: kernel driver onkey support
[PATCH V4 2/3]: device tree bindings document
[PATCH V4 3/3]: mfd core support

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
end-of-patch for RESEND PATCH V4

