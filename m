From: Brian Norris <briannorris@chromium.org>
Subject: [RESEND PATCH 0/2] cros_ec: utilize cros_ec_cmd_xfer_status()
Date: Wed, 10 Aug 2016 13:37:17 -0700
Message-ID: <1470861439-129201-1-git-send-email-briannorris@chromium.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34370 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934418AbcHJUhf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Aug 2016 16:37:35 -0400
Received: by mail-pa0-f47.google.com with SMTP id fi15so18896565pac.1
        for <linux-input@vger.kernel.org>; Wed, 10 Aug 2016 13:37:35 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Olof Johansson <olof@lixom.net>, Brian Norris <computersforpeace@gmail.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Enric Balletbo <enric.balletbo@collabora.co.uk>, Shawn Nematbakhsh <shawnn@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Brian Norris <briannorris@chromium.org>

Hi all,

This is a resend of some patches I sent previously:

https://lkml.org/lkml/2016/7/25/488

There are no changes to the patch content. Only some additional commit
description and tagging.

The cros_ec_cmd_xfer_status() helper (which helps us better handle some error
scenarios) is now present in v4.8-rc1.

These can be taken independently by their subsystem maintainers. (Wolfram and
Dmitry, who already acked them.)

Regards,
Brian

Brian Norris (2):
  i2c: cros-ec-tunnel: Fix usage of cros_ec_cmd_xfer()
  Input: cros_ec_keyb - Fix usage of cros_ec_cmd_xfer()

 drivers/i2c/busses/i2c-cros-ec-tunnel.c | 2 +-
 drivers/input/keyboard/cros_ec_keyb.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.8.0.rc3.226.g39d4020

