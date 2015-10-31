From: Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>
Subject: [PATCH v4 0/4] tsc2005 - Add support for tsc2004
Date: Fri, 30 Oct 2015 19:41:22 -0500
Message-ID: <1446252086-24334-1-git-send-email-mwelling@ieee.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, kbuild test robot <lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, kbuild-all-JC7UmRfGjtg@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Adds support for the i2c based tsc2004.

Due to the overlapping functionality of the tsc2004 and tsc2005
the common code was moved to a core driver (tsc200x-core).

v4: Break patch into series. Isolates the I2C and SPI commands to
respective drivers.
v3: Splits the tsc2004 and tsc2005 into separate drivers with
with common routines in tsc200x-core.
v2: Fixes Kconfig based on report for 0-day build bot.

Michael Welling (4):
  Input: tsc2005 - Seperate SPI and core functions
  Input: tsc200x-core - Rename functions and variables
  Input: tsc2004 - Add support for tsc2004
  Input: tsc2004 - Document ts2004 dt bindings

 .../bindings/input/touchscreen/tsc2005.txt         |  39 ++
 drivers/input/touchscreen/Kconfig                  |  17 +
 drivers/input/touchscreen/Makefile                 |   2 +
 drivers/input/touchscreen/tsc2004.c                |  86 +++
 drivers/input/touchscreen/tsc2005.c                | 711 +--------------------
 .../touchscreen/{tsc2005.c => tsc200x-core.c}      | 408 +++++-------
 drivers/input/touchscreen/tsc200x-core.h           |  78 +++
 7 files changed, 393 insertions(+), 948 deletions(-)
 create mode 100644 drivers/input/touchscreen/tsc2004.c
 copy drivers/input/touchscreen/{tsc2005.c => tsc200x-core.c} (51%)
 create mode 100644 drivers/input/touchscreen/tsc200x-core.h

-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
