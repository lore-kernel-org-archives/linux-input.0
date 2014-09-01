From: Jaewon Kim <jaewon02.kim@samsung.com>
Subject: [PATCH 0/3] Add max77693 haptic driver
Date: Mon, 01 Sep 2014 20:14:28 +0900
Message-ID: <1409570071-26719-1-git-send-email-jaewon02.kim@samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:19414 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751832AbaIALOn (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 1 Sep 2014 07:14:43 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, Jaewon Kim <jaewon02.kim@samsung.com>

This series adds max77693 haptic driver.
The max77693 is a Multifunction device with PMIC, CHARGER, LED,
MUIC, HAPTIC and this series is haptic device driver in MAX77693.
The haptic driver use regmap method for i2c communication and 
support force feedback framework in input device.

Jaewon Kim (3):
  mfd: max77693: Initialize haptic register map
  Input: misc: Add haptic driver on max77693
  mfd: max77693: add haptic of_compatible in mfd_cell

 Documentation/devicetree/bindings/mfd/max77693.txt |   19 ++
 drivers/input/misc/Kconfig                         |   13 +
 drivers/input/misc/Makefile                        |    1 +
 drivers/input/misc/max77693-haptic.c               |  333 ++++++++++++++++++++
 drivers/mfd/max77693.c                             |   23 +-
 include/linux/mfd/max77693-private.h               |    9 +
 6 files changed, 394 insertions(+), 4 deletions(-)
 create mode 100644 drivers/input/misc/max77693-haptic.c

-- 
1.7.9.5

