From: Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: [PATCH 0/2] use correct values for startup time bits for AXP22X/AXP8XX PEKs
Date: Mon, 17 Jul 2017 11:53:05 +0200
Message-ID: <20170717095307.15986-1-quentin.schulz@free-electrons.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:45541 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751278AbdGQJxv (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 17 Jul 2017 05:53:51 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, wens@csie.org, lee.jones@linaro.org
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>, hdegoede@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, thomas.petazzoni@free-electrons.com, maxime.ripard@free-electrons.com

According to their datasheets, the AXP221, AXP223, AXP288, AXP803,
AXP809 and AXP813 PEK have different values for startup time bits from
the AXP20X PEK (which are currently used for all the aforementioned PMICs).

This patch series adds support for platform_device_id to axp20x-pek driver
to support different startup time bits depending on PMIC's variant and set
the correct platform_device_id in the mfd.

This has been tested on AXP813. To perform the test, modify the value of
startup and/or shutdown of the pek in sysfs. Press the button soldered to
PEK input of the AXP the amount of time you set in sysfs. The PMIC shuts
down the board without needing to unplug any power supply. Press PEK button
the amount of time you set in sysfs for startup and the PMIC will start the
board. Note that the time bits are obivoulsy hardware reset to their
default when you unplug all power supplies from the board.

Thanks,
Quentin

Quentin Schulz (2):
  Input: axp20x-pek: add support for AXP221 PEK
  mfd: axp20x: use correct platform device id for many PEK

 drivers/input/misc/axp20x-pek.c | 62 ++++++++++++++++++++++++++++++++++-------
 drivers/mfd/axp20x.c            | 12 ++++----
 2 files changed, 58 insertions(+), 16 deletions(-)

-- 
2.11.0

