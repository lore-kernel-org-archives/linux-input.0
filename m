From: Brian Norris <briannorris@chromium.org>
Subject: [PATCH 0/2] cros_ec: utilize cros_ec_cmd_xfer_status()
Date: Mon, 25 Jul 2016 11:14:09 -0700
Message-ID: <1469470451-111822-1-git-send-email-briannorris@chromium.org>
Return-path: <linux-i2c-owner@vger.kernel.org>
Sender: linux-i2c-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Olof Johansson <olof@lixom.net>, Brian Norris <computersforpeace@gmail.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Enric Balletbo <enric.balletbo@collabora.co.uk>, Shawn Nematbakhsh <shawnn@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Brian Norris <briannorris@chromium.org>
List-Id: linux-input@vger.kernel.org

Hi all,

I was sorting through some out-of-tree patches to these drivers, and I realized
we should probably start making use of cros_ec_cmd_xfer_status() in these
drivers, now that Thierry has queued them up for v4.8; see:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git
  refs/heads/for-4.8/mfd

  9798ac6d32c1 mfd: cros_ec: Add cros_ec_cmd_xfer_status() helper

Thierry originally provided the above branch for Lee's sake, but I don't see
why (if these are deemed fixes worthy of v4.8) that can't be pulled by Wolfram
and/or Dmitry for their respective subsystems' patches.

Please review.

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
