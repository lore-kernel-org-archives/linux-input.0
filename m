From: Anthony Felice <tony.felice-jEh4hwF5bVhBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 0/4] Enable display and touchscreen for Vybrid Tower
Date: Fri, 24 Jun 2016 15:44:42 -0400
Message-ID: <1466797486-31558-1-git-send-email-tony.felice@timesys.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tony.felice-jEh4hwF5bVhBDgjK7y7TUQ@public.gmane.org
Cc: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, stefan-XLVq0VzYD2Y@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, fabio.estevam-3arQi8VN3Tc@public.gmane.org, geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org, mwelling-EkmVulN54Sk@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, damien.riegel-4ysUXcep3aM1wj+D4I0NRVaTQe2KTcn/@public.gmane.org, maitysanchayan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-input@vger.kernel.org

This patchset enables the TWR-LCD-RGB display and the CRTouch-based touchscreen
on the Vybrid Tower platform. Both display and touchscreen have been tested and
verified working with this patchset on a Rev J Vybrid Tower system.

Anthony Felice (4):
  ARM: dts: vf610-twr: Enable display controller
  input: touchscreen: crtouch_ts: Add driver
  ARM: dts: vf610-twr: Add crtouch node and pinmux
  ARM: imx_v6_v7_defconfig: enable useful configurations for Vybrid

 .../bindings/input/touchscreen/crtouch_ts.txt      |  14 ++
 arch/arm/boot/dts/vf610-twr.dts                    |  62 +++++
 arch/arm/configs/imx_v6_v7_defconfig               |   6 +-
 drivers/input/touchscreen/Kconfig                  |  10 +
 drivers/input/touchscreen/Makefile                 |   1 +
 drivers/input/touchscreen/crtouch_ts.c             | 279 +++++++++++++++++++++
 6 files changed, 368 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/crtouch_ts.txt
 create mode 100644 drivers/input/touchscreen/crtouch_ts.c

-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
