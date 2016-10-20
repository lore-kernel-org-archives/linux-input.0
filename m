From: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/4] Input: goodix - Support dynamic reconfiguration
Date: Thu, 20 Oct 2016 14:59:13 -0500
Message-ID: <20161020195917.20051-1-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org, octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, merker-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, nm-l0cyMroinI0@public.gmane.org
Cc: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Goodix touchscreen controller supports the ability to update its settings
at runtime. Currently, the driver supports this by loading a firmware
and reconfiguring the panel. However, this may lead to a large quantity
of firmwares being created and managed. This is a hassle since likely a
preexisting firmware or even the default configuration is good enough and
only a couple of changes need to be made.

This patchset adds the capability to dynamically alter the firmware
utilizing several new DT properties.

These new properties will allow a user to specify the touchscreen
resolution and also allow x and y coordinates to be interchanged. All of
this configuration changes are done dynamically by the driver and can work
using the default touchscreen controller configuration or even on top of
a firmware that was loaded.

Franklin S Cooper Jr (4):
  Input: goodix - Restructure cfg checksum function
  Input: goodix - Allow tweaking of configuration file dynamically
  Input: goodix - Tweak configuration to use passed in touchscreen
    resolution
  Input: goodix - Support interchanging x and y coordinates in hardware

 .../bindings/input/touchscreen/goodix.txt          |   4 +
 drivers/input/touchscreen/goodix.c                 | 109 +++++++++++++++++----
 2 files changed, 96 insertions(+), 17 deletions(-)

-- 
2.10.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
