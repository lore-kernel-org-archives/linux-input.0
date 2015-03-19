From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/2] tc3589x OF only enforcement
Date: Thu, 19 Mar 2015 15:52:43 +0100
Message-ID: <1426776765-18812-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:36418 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756AbbCSOw6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Mar 2015 10:52:58 -0400
Received: by lamx15 with SMTP id x15so64304191lam.3
        for <linux-input@vger.kernel.org>; Thu, 19 Mar 2015 07:52:57 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>

These two patches removes the non-DT probe/config path from the
TC3589x driver. I suggest merging both through the MFD tree if
Dmitry can ACK the input patch.

Linus Walleij (2):
  input: keypad: tc3589x: localize platform data
  mfd: tc3589x: enforce device-tree only mode

 drivers/gpio/Kconfig                    |  1 +
 drivers/gpio/gpio-tc3589x.c             |  3 --
 drivers/input/keyboard/tc3589x-keypad.c | 58 +++++++++++++++++++--------------
 drivers/mfd/Kconfig                     |  1 +
 drivers/mfd/tc3589x.c                   |  9 -----
 include/linux/mfd/tc3589x.h             | 23 -------------
 6 files changed, 35 insertions(+), 60 deletions(-)

-- 
1.9.3

