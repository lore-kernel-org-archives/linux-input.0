From: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Subject: [PATCH 00/10] regulator/power/mfd/input/extcon: Merge max77843 into max77693
Date: Wed, 29 Apr 2015 19:58:25 +0900
Message-ID: <1430305114-23598-1-git-send-email-k.kozlowski.k@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35472 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422648AbbD2K7H (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Apr 2015 06:59:07 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

Hi,


The patchset merges max77843 regulator driver into max77693.
I am asking for review and acks from multiple subsystems.


Rationale
=========
The recently added max77843 regulator driver is very similar to
its older brother: the max77693. Both devices provide two safeouts
and a charger.

The main difference is in charger's output capabilities and related
registry values.

With some code additions the max77693 regulator driver can support both
chipsets. This reduces overall code duplication and is a first step
toward integrating other drivers for these devices.


Patchset description
====================
Patches 1-3 do various cleanup.
Patch 4 prepare max77694 regulator driver for supporting different
devices.
Patch 5 switch max77693 drivers to common state container.
Patch 6 updates max77843 drivers to common state container.
Patches 7-8 do final cleanup before merging.
Patches 9-10 do the merge of max77843 regulator into max77693.


Dependencies
============
The patchset is rebased on current regulator tree:
v4.1-rc1-8-ge2a4e9538fe6. It touches all currently merged max77843
drivers: extcon, mfd, input and regulator (charger driver was not yet
merged).


Best regards,
Krzysztof


Krzysztof Kozlowski (10):
  mfd/extcon: max77693: Remove unused extern declarations and
    max77693_dev members
  mfd: max77693: Store I2C device type as enum and add default unknown
  regulator: max77693: Use core code for charger's is_enabled
  regulator: max77693: Support different register configurations
  max77693: Move state container to common header
  max77843: Switch to common max77693 state container
  mfd/extcon: max77693: Rename defines to allow inclusion with max77843
  mfd/extcon: max77843: Rename defines to allow inclusion with max77693
  regulator: max77693: Add support for MAX77843 device
  regulator: Remove the max77843 driver

 drivers/extcon/extcon-max77693.c     |  83 +++++++-------
 drivers/extcon/extcon-max77843.c     |  76 ++++++++-----
 drivers/input/misc/max77693-haptic.c |   1 +
 drivers/input/misc/max77843-haptic.c |   3 +-
 drivers/mfd/max77693.c               |  31 ++---
 drivers/mfd/max77843.c               |  20 ++--
 drivers/power/max77693_charger.c     |   1 +
 drivers/regulator/Kconfig            |  16 +--
 drivers/regulator/Makefile           |   1 -
 drivers/regulator/max77693.c         | 174 ++++++++++++++++++++++------
 drivers/regulator/max77843.c         | 215 -----------------------------------
 include/linux/mfd/max77693-common.h  |  49 ++++++++
 include/linux/mfd/max77693-private.h | 134 +++++++++-------------
 include/linux/mfd/max77843-private.h | 174 +++++++++++++---------------
 14 files changed, 443 insertions(+), 535 deletions(-)
 delete mode 100644 drivers/regulator/max77843.c
 create mode 100644 include/linux/mfd/max77693-common.h

-- 
2.1.4

