From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH 0/2] mfd: cros_ec_keyb: MKBP event support
Date: Fri,  1 Jul 2016 11:07:54 +0200
Message-ID: <1467364076-20172-1-git-send-email-enric.balletbo@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Vic Yang <victoryang@google.com>, Lee Jones <lee.jones@linaro.org>, Olof Johansson <olof@lixom.net>, Gwendal Grignou <gwendal@chromium.org>, Brian Norris <briannorris@chromium.org>
List-Id: linux-input@vger.kernel.org

Hi,

The cros-ec MKBP event support will be used on different EC drivers like EC
keyboard, EC USB PD and EC sensors drivers. The first attempt to merge these two
patches was within the EC USB PD series [1] sent by Tomeu Vizoso, but these
series are blocked possibly until we figure out how this maps into the proposed
type-c infraestructure.

As these patches ([2] and [3]) were a dependency for other possible patch
series and have sense send it alone, makes no sense wait for the upstreaming of
the full EC USB PD series, so I created a new patch series with only these two
patches and rid of the USB PD stuff.

Note that the following patch series apply cleanly on top of mainline plus the
patches to add support for ChromeOS EC PWM by Brian Norris [4] to avoid
conflicts and because I think are close to be accepted.

Also note that the two patches need to be taken together, massively reducing the
chances of a fail.  The chances that a) a bisect will fall exactly between the
2 patches and then b) the drivers try to handle the same interrupt at the same
time are significantly small enough for us to take that risk.

The patches were tested by myself on a Veyron Jerry checking that after some
suspend/resumes cycles the keyboard is working.

Changes:
 * Add the SoB Vic Yang
 * Rebased on top of mainline + cros_ec pwm patches, resolved the conflicts.

[1] https://lwn.net/Articles/679228/
[2] https://patchwork.kernel.org/patch/8809921/
[3] https://patchwork.kernel.org/patch/8809931/
[4] https://lwn.net/Articles/691861/

Vic Yang (2):
  mfd: cros_ec: Add MKBP event support
  Input: cros_ec_keyb - Stop handling interrupts directly

 drivers/input/keyboard/cros_ec_keyb.c   | 135 ++++++++------------------------
 drivers/mfd/cros_ec.c                   |  58 +++++++++++++-
 drivers/platform/chrome/cros_ec_proto.c |  92 ++++++++++++++++++++++
 include/linux/mfd/cros_ec.h             |  18 +++++
 include/linux/mfd/cros_ec_commands.h    |  34 ++++++++
 5 files changed, 230 insertions(+), 107 deletions(-)

-- 
2.1.0
