From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 00/10] Handle platform_get_irq's error checking and returns
Date: Sat, 18 Nov 2017 00:45:22 +0530
Message-ID: <1510946132-13554-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:43426 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935515AbdKQTP4 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 17 Nov 2017 14:15:56 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, maxime.ripard@free-electrons.com, wens@csie.org, linux@roeck-us.net, wsa@the-dreams.de, daniel.thompson@linaro.org, mcuos.com@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The platform_get_irq() function returns negative if an error occurs.
zero or positive number on success. platform_get_irq() error checking
for zero is not correct and we must check its return value.

Arvind Yadav (10):
  [PATCH 01/10] Input: ep93xx_keypad: Fix platform_get_irq's error checking
  [PATCH 02/10] Input: omap4-keypad: Fix platform_get_irq's error checking
  [PATCH 03/10] Input: twl4030_keypad: Fix platform_get_irq's error checking
  [PATCH 04/10] Input: serio: Fix platform_get_irq's error checking
  [PATCH 05/10] Input: cpcap-pwrbutton: Handle return value of platform_get_irq
  [PATCH 06/10] Input: w90p910_ts: Handle return value of platform_get_irq
  [PATCH 07/10] Input: sun4i-ts: Handle return value of platform_get_irq
  [PATCH 08/10] Input: twl4030-pwrbutton: Handle return value of platform_get_irq
  [PATCH 09/10] Input: sirfsoc-onkey: Handle return value of platform_get_irq
  [PATCH 10/10] Input: palmas-pwrbutton: Handle return value of platform_get_irq

 drivers/input/keyboard/ep93xx_keypad.c  | 2 +-
 drivers/input/keyboard/omap4-keypad.c   | 2 +-
 drivers/input/keyboard/twl4030_keypad.c | 2 +-
 drivers/input/misc/cpcap-pwrbutton.c    | 3 +++
 drivers/input/misc/palmas-pwrbutton.c   | 5 +++++
 drivers/input/misc/sirfsoc-onkey.c      | 3 +++
 drivers/input/misc/twl4030-pwrbutton.c  | 3 +++
 drivers/input/serio/sun4i-ps2.c         | 2 +-
 drivers/input/touchscreen/sun4i-ts.c    | 3 +++
 drivers/input/touchscreen/w90p910_ts.c  | 4 ++++
 10 files changed, 25 insertions(+), 4 deletions(-)

-- 
2.7.4

