From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 1/2] input: st1232: Add reset pin handling
Date: Mon, 08 Apr 2013 16:26:33 +0200
Message-ID: <1665503.UbR34e1lGM@avalon>
References: <1365254327-10408-1-git-send-email-hechtb+renesas@gmail.com> <2964968.zUPa6PMQYi@avalon> <CABYn4sznm2RWnRjR6NAi_iGe7D+tcFBtdbkEb9D9iGAhGOj2hQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:42047 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757691Ab3DHO0e (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Apr 2013 10:26:34 -0400
In-Reply-To: <CABYn4sznm2RWnRjR6NAi_iGe7D+tcFBtdbkEb9D9iGAhGOj2hQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastian Hecht <hechtb@gmail.com>
Cc: Linux-SH <linux-sh@vger.kernel.org>, linux-input@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Hi Bastian,

On Monday 08 April 2013 14:43:26 Bastian Hecht wrote:
> 2013/4/7 Laurent Pinchart <laurent.pinchart@ideasonboard.com>:
> > On Saturday 06 April 2013 15:18:45 Bastian Hecht wrote:
> >> We add the possiblity to hand over a GPIO number for the reset pin.
> >> This way we can remove existing board code that takes care of it and
> >> group this information properly in the platform data or in the device
> >> tree confguration.
> >> 
> >> The implementation is analogous to the cy8ctmg110 driver, thanks.
> >> 
> >> Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
> >> ---
> >> 
> >>  .../bindings/input/touchscreen/sitronix-st1232.txt |   24 ++++++++++
> >>  drivers/input/touchscreen/st1232.c                 |   47 ++++++++++++--
> >>  include/linux/input/st1232_pdata.h                 |   13 ++++++
> >>  3 files changed, 81 insertions(+), 3 deletions(-)
> >>  create mode 100644
> >> 
> >> Documentation/devicetree/bindings/input/touchscreen/sitronix-st1232.txt
> >> create mode 100644 include/linux/input/st1232_pdata.h
> >> 
> >> diff --git
> >> a/Documentation/devicetree/bindings/input/touchscreen/sitronix-st1232.txt
> >> b/Documentation/devicetree/bindings/input/touchscreen/sitronix-st1232.txt
> >> new file mode 100644
> >> index 0000000..1936969
> >> --- /dev/null
> >> +++
> >> b/Documentation/devicetree/bindings/input/touchscreen/sitronix-st1232.txt
> >> @@ -0,0 +1,24 @@
> >> +* Sitronix st1232 touchscreen controller
> >> +
> >> +Required properties:
> >> +- compatible: must be "sitronix,st1232"
> >> +- reg: I2C address of the chip
> >> +- interrupts: interrupt to which the chip is connected
> >> +
> >> +Optional properties:
> >> +- sitronix,reset-pin: GPIO number of the reset pin
> > 
> > GPIO bindings use phandles, please see
> > Documentation/devicetree/bindings/gpio/gpio.txt.
> 
> Ok done. I haven't tested that part yet as the pfc is not set up via the DT.
> I saw in topic/pinmux-dt that you added OF support for the pfc, but I
> couldn't apply the patch without conflicts. Do you think this part is going
> to be merged to next any time soon?

I need to rework the patches, I hope to get them merged in v3.11

> >> +Example:
> >> +
> >> +     i2c@00000000 {
> >> +             /* ... */
> >> +
> >> +             touchscreen@55 {
> >> +                     compatible = "sitronix,st1232";
> >> +                     reg = <0x55>;
> >> +                     interrupts = <2 0>;
> >> +                     sitronix,reset-pin = <166>;
> >> +             };
> >> +
> >> +             /* ... */
> >> +     };

-- 
Regards,

Laurent Pinchart

