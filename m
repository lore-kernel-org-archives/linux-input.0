From: Vishnu Patekar <vishnupatekar0510-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v5 0/4] ARM:sunxi:ps2 Added support for A10/A20
 ps2 controller
Date: Sun, 25 Jan 2015 19:10:05 +0530
Message-ID: <1422193209-17787-1-git-send-email-vishnupatekar0510@gmail.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBD64TFVR3YIBB5PESOTAKGQEVTRMEXA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vishnu Patekar <vishnupatekar0510-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

This adds  PS2 controller support for Allwinner A10, A20 SOCs. 

I've tested PS2 keyboard on A20 Olimex-Lime2 board. 
Hans had tested previous patch on A10 as well.

v4 --> v5
1. used legagy calls instead of devm* interfaces to avoid mixing of managed
 and manually freed resources.
2. shutoff interrupts before requesting irq and before synchronize_irq.
3. removed freeing serio in sun4i_ps2_remove, as it is refcounted.
4. added defines in dtsi file instead of hardcoded constants.
5. dropped the default enabled ps2 nodes from Lime2 dts, as there is no 
 dedicated ps2 connector on lime2 board.

v3 --> v4
1. Reported errors(SERIO_FRAME,SERIO_TIMEOUT, SERIO_PARITY) to consumer.
2. Handled the transmit timeout in sun4i_ps2_write.
3. Removed the resetting the ps2 controller in case of errors.
4. Added synchronize_irq() in sun4i_ps2_close to make sure pending interrupts are handled.
5. Explicitly disabled interrupt in probe to avoid spurious interrupts.
6. Removed disable_irq from sun4i_ps2_remove as serio_close will take care of it.
7. Removed the obvious comments.
3. Corrected the style errors.
4. As there is not conflict with ps2 pins, enabled ps2 pins in lime2 dts by default.

v2 --> v3
1. changed config to SERIO_SUN4I_PS2 from SERIO_SUNXI_PS2
2. changed driver name to sun4i-ps2 from sunxi-ps2.
3. changed the function names to sun4i_ps2_*.
4. added locking in sun4i_ps2_open.
5. kept compatible "sun4i-a10-ps2" for A10 and A20, as A10 is earlier SOC.
6. corrected the style errors.
7. separated the dts patches.
8. removed commented ps2 notes from lime2 dts.
9. added note that ps2 pins confilt with hdmi.
10. corrected the interrupt property for A10.
11. moved dt-bindings to Documentation/devicetree/bindings/serio

v1 --> v2:
1. added default n depends on ARCH_SUNXI || COMPILE_TEST in Kconfig.
2. handled errors and free resources on errors.
3. used BIT(x), DIV_ROUND_UP macros.
4. corrected style errors.
5. added support for A10 also, A10 and A2 have same properties of PS2 controller.
6. by default commented ps20 and ps21 nodes,as ps20 pins conflict with HDMI.
7. added compatible as allwinner,sun4i-a10-ps2.
8. corrected the possible race condition.

Vishnu Patekar (4):
  sunxi:dts-bindings:input: bindings for A10/A20 ps2
  ARM:sunxi:drivers:input Add support for A10/A20 PS2
  ARM: sunxi: dts: Add PS2 nodes to dtsi for A10,A20
  ARM: sunxi: dts: Add A10/A20 PS2 pin muxing options

 .../bindings/serio/allwinner,sun4i-ps2.txt         |   23 ++
 arch/arm/boot/dts/sun4i-a10.dtsi                   |   30 ++
 arch/arm/boot/dts/sun7i-a20.dtsi                   |   30 ++
 drivers/input/serio/Kconfig                        |   11 +
 drivers/input/serio/Makefile                       |    1 +
 drivers/input/serio/sun4i-ps2.c                    |  347 ++++++++++++++++++++
 6 files changed, 442 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serio/allwinner,sun4i-ps2.txt
 create mode 100644 drivers/input/serio/sun4i-ps2.c

-- 
1.7.9.5
