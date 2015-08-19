From: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Subject: [PATCH 0/6] ChromeOS EC Kconfig cleanups
Date: Wed, 19 Aug 2015 13:19:52 +0200
Message-ID: <1439983198-4696-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Gwendal Grignou <gwendal-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hello,

This patch series attemp to fix the issues that exist with the ChromeOS
EC drivers Kconfig symbols. These are:

1) The MFD_CROS_EC config symbol select CROS_EC_PROTO and CHROME_PLATFORMS
   which caused a Kconfig unmet direct dependencies warning.

2) Mix of select and depends on for the CROS_EC_PROTO config symbol which
   may lead to circular Kconfig dependencies.

The first issue was because CHROME_PLATFORMS depend on X86 || ARM and the
MFD_CROS_EC didn't have this dependency. I thought the correct solution
was to remove the dependency for CHROME_PLATFORMS since in theory there
could be Chromebooks for other architectures.

That was made in commit d12bbcd3ea44 ("platform/chrome: Don't make
CHROME_PLATFORMS depends on X86 || ARM") but Geert nacked that and told me
the correct fix was the opposite, to add the dependencies to the driver
and possibly extend it with || COMPILE_TEST to have more build coverage.

So patch 1/5 do this and patch 2/5 reverts the mentioned commit and also
add || COMPILE_TEST to CHROME_PLATFORMS.

Patches 3/5 to 5/5 fix 2) by not making the drivers depend on CROS_EC_PROTO
since these should really depend on MFD_CROS_EC. And since MFD_CROSEC select
CROS_EC_PROTO already, that dependency is met as well.

Only patches 1/5 and 2/5 have to be applied in the same order and picked
through a single tree to avoid the Kconfig warning to appear again. The
other patches are independent and can go through the other subsystem trees.

Thanks a lot to Geert and Bartolomiej for the feedback and suggestions.

Best regards,
Javier


Javier Martinez Canillas (6):
  mfd: Add MFD_CROS_EC dependencies
  Revert "platform/chrome: Don't make CHROME_PLATFORMS depends on X86 ||
    ARM"
  platform/chrome: Make depends on MFD_CROS_EC instead CROS_EC_PROTO
  mfd: cros_ec: Remove CROS_EC_PROTO dependency for SPI and I2C drivers
  i2c: Replace I2C_CROS_EC_TUNNEL dependency
  Input: Replace KEYBOARD_CROS_EC dependency

 drivers/i2c/busses/Kconfig      | 2 +-
 drivers/input/keyboard/Kconfig  | 2 +-
 drivers/mfd/Kconfig             | 5 +++--
 drivers/platform/chrome/Kconfig | 5 +++--
 4 files changed, 8 insertions(+), 6 deletions(-)

-- 
2.4.3
