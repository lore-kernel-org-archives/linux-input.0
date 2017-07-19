From: Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: [PATCH v2 0/3] add support for AXP22X/AXP288/AXP8XX PEK
Date: Wed, 19 Jul 2017 09:43:34 +0200
Message-ID: <20170719074337.19189-1-quentin.schulz@free-electrons.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:54387 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751683AbdGSHoB (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 19 Jul 2017 03:44:01 -0400
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

v2:
  - instead of duplicating all extended attributes, use the driver_data of
  platform_device_id to get startup and shutdown times and their respective
  masks,
  - remove extended attributes and use the structure storing startup and
  shutdown times and their respective masks,
  - separate in different patches,
  - removed mfd patch to correct mfd cell name since Chen-Yu will take care
  of it in another patch series,

Thanks,
Quentin

Quentin Schulz (3):
  Input: axp20x-pek: use driver_data of platform_device_id instead of
    extended attributes
  Input: axp20x-pek: remove mention to extended attributes
  Input: axp20x-pek: add support for AXP221 PEK

 drivers/input/misc/axp20x-pek.c | 146 ++++++++++++++++++++++++++++------------
 1 file changed, 103 insertions(+), 43 deletions(-)

--
2.11.0

