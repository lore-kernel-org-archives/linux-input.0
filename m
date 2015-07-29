From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH 0/4] Input: Merge max77843 haptic driver into max77693
Date: Wed, 29 Jul 2015 15:31:26 +0900
Message-ID: <1438151490-13751-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:64067 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750957AbbG2Gbl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Jul 2015 02:31:41 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Jaewon Kim <jaewon02.kim@samsung.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>

Hi,


Description
===========
The Maxim 77843 haptic driver differs from 77693 by:
1. Setting the bias.
2. Different configuration register.
3. Not enabling the low-sys DAC.
4. Using same regmap for PMIC and haptic blocks.

The patchset merges max77843 driver into the max77693.


Dependencies
============
The patchset *depends on* "regulator: Merge max77843 into max77693" [0]
which was applied by Mark Brown (regulator tree). The mentioned
regulator patchset actually changed also MFD drivers and other headers
so the child drivers (like max77693 regulator or haptic) can be used
with both max77693 and max77843 main MFD drivers.


Merging ideas
=============
0. Patches 1 and 2 can be applied directly.
For rest of it (patches 3 and 4):
1. If this will go to v4.3, then maybe Mark Brown could prepare
   an immutable branch (or a tag) with the [0] patchset?
2. If this will go to v4.4, then patchset can wait till MFD/regulator
   changes reach Linus' tree.


Best regards,
Krzysztof

[0] https://lkml.org/lkml/2015/7/15/554


Krzysztof Kozlowski (4):
  Input: max77693: Remove a read-only pwm_divisor field
  Input: max77693: Prepare for adding support for Maxim 77843
  Input: max77693: Add support for Maxim 77843
  Input: Remove the max77843 haptic driver

 drivers/input/misc/Kconfig           |  18 +-
 drivers/input/misc/Makefile          |   1 -
 drivers/input/misc/max77693-haptic.c |  91 +++++++--
 drivers/input/misc/max77843-haptic.c | 359 -----------------------------------
 4 files changed, 82 insertions(+), 387 deletions(-)
 delete mode 100644 drivers/input/misc/max77843-haptic.c

-- 
1.9.1

