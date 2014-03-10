From: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
Subject: [PATCH V1 0/2]  da9063: Support for OnKey
Date: Mon, 10 Mar 2014 16:24:04 +0000
Message-ID: <cover.1394468644.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail1.bemta5.messagelabs.com ([195.245.231.143]:35549 "EHLO
	mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753502AbaCJQct (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Mar 2014 12:32:49 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>
Cc: David Dajun Chen <david.chen@diasemi.com>, LKML-INPUT <linux-input@vger.kernel.org>, LKML-KERNEL <linux-kernel@vger.kernel.org>, Mark Brown <broonie@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>

From: Opensource [Steve Twiss] <stwiss.opensource@diasemi.com>

This patch series adds support for the DA9063 OnKey.

It has been split into two parts because the OnKey driver
requires a minor alteration to the da9063-core.c file and
the platform data header file. These parts have been
separated out.

- Add a new OnKey driver for DA9063;
- Minor addition "ONKEY" name to OnKey IRQ resource structure;

Thank you,
Steve Twiss, Dialog Semiconductor Ltd.

S Twiss (2):
  mfd: da9063: Linkages for ONKEY support in core files
  input: misc: da9063: OnKey driver

 drivers/input/misc/Kconfig        |  10 ++
 drivers/input/misc/Makefile       |   1 +
 drivers/input/misc/da9063-onkey.c | 209 ++++++++++++++++++++++++++++++++++++++
 drivers/mfd/da9063-core.c         |   1 +
 include/linux/mfd/da9063/pdata.h  |   1 +
 5 files changed, 222 insertions(+)
 create mode 100644 drivers/input/misc/da9063-onkey.c

-- 
end-of-patch for PATCH V1

