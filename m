From: vishnupatekar <vishnupatekar0510-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCHv2 0/3] ARM:sunxi:ps2 Added support for A10/A20
 ps2 controller.
Date: Sun,  7 Dec 2014 04:45:16 +0530
Message-ID: <1417907719-26775-1-git-send-email-VishnuPatekar0510@gmail.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBD64TFVR3YIBBJM4R2SAKGQEOFRGVJQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org
Cc: leafy.myeh-Q9AEpCAkrSgqDJ6do+/SaQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vishnupatekar <VishnuPatekar0510-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Here is v2 of SUNXI PS2 controller support patch-set as with v1.

Changes in v2: 
1. added default n depends on ARCH_SUNXI || COMPILE_TEST in Kconfig.
2. handled errors and free resources on errors.
3. used BIT(x), DIV_ROUND_UP macros.
4. corrected style errors.
5. added support for A10 also, A10 and A2 have same properties of PS2 controller.
6. by default commented ps20 and ps21 nodes,as ps20 pins conflict with HDMI
   connector on Lime2 Board.
7. added compatible as allwinner,sun4i-a10-ps2.
8. corrected the possible race condition.

Patch 0 Summary: Allwinner A10/A20 PS2 controller. These modifications are
	for PS2 host controller. IBM compliant IBM PS2 and AT-compatible 
	keyboard and mouse can be connected.

Patch 1 device tree bindings.

Patch 2 adds support for sun7i ps2 driver.

Patch 3 device tree support for PS2 controller.
 1) Added A10/A20 ps2 nodes to the dtsi
 2) Added A10/A20 ps2 pinmux to the dtsi
 3) Added ps2 nodes to the lime2 dts file

vishnupatekar (3):
  sunxi:dts-bindings:input:ps2 bindings for A10/A20 ps2.
  sunxi:drivers:input:ps2 Added sunxi A10/A20 ps2 driver
  ARM:dts:sunxi:ps2 dt nodes for A10/A20 PS2 controller.

 .../bindings/input/allwinner,sunxi-ps2.txt         |   23 ++
 arch/arm/boot/dts/sun4i-a10.dtsi                   |   27 ++
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts    |   13 +
 arch/arm/boot/dts/sun7i-a20.dtsi                   |   29 ++
 drivers/input/serio/Kconfig                        |   10 +
 drivers/input/serio/Makefile                       |    1 +
 drivers/input/serio/sunxi-ps2.c                    |  364 ++++++++++++++++++++
 7 files changed, 467 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/allwinner,sunxi-ps2.txt
 create mode 100644 drivers/input/serio/sunxi-ps2.c

-- 
1.7.9.5
