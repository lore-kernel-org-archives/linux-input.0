From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH RFC] Input: Add Microchip AR1021 i2c touchscreen
Date: Tue, 11 Feb 2014 08:34:09 -0800
Message-ID: <20140211163409.GC12106@core.coreip.homeip.net>
References: <1391074185-26973-1-git-send-email-christian.gmeiner@gmail.com>
 <20140131010131.GA29566@core.coreip.homeip.net>
 <CAH9NwWfb1zVrgeKB7+fPyS80yC6BuokvmA4TE0tr7BAs_jwQSA@mail.gmail.com>
 <20140131171521.GA20872@core.coreip.homeip.net>
 <20140131171647.GB20872@core.coreip.homeip.net>
 <CAH9NwWcpttFN9=QKeCM_StJiLsvcYSapuDqcwtKQJTAxfQLGng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:57555 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752979AbaBKQeN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Feb 2014 11:34:13 -0500
Received: by mail-pd0-f177.google.com with SMTP id x10so7708242pdj.36
        for <linux-input@vger.kernel.org>; Tue, 11 Feb 2014 08:34:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAH9NwWcpttFN9=QKeCM_StJiLsvcYSapuDqcwtKQJTAxfQLGng@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: linux-input@vger.kernel.org

On Tue, Feb 11, 2014 at 02:10:50PM +0100, Christian Gmeiner wrote:
> Hi Dmitry
> 
> 2014-01-31 18:16 GMT+01:00 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> > On Fri, Jan 31, 2014 at 09:15:21AM -0800, Dmitry Torokhov wrote:
> >> Hi Chrisitian,
> >>
> >> On Fri, Jan 31, 2014 at 12:40:19PM +0100, Christian Gmeiner wrote:
> >> > >> --- /dev/null
> >> > >> +++ b/drivers/input/touchscreen/ar1021_i2c.c
> >> > >> @@ -0,0 +1,201 @@
> >> > >> +/*
> >> > >> + * Microchip AR1021 driver for I2C
> >> > >> + *
> >> > >> + * Author: Christian Gmeiner <christian.gmeiner@gmail.com>
> >> > >> + *
> >> > >> + * License: GPL as published by the FSF.
> >>
> >> By the way, you probably do not want GPL v1 to apply... Maybe say GPL v2
> >> or GPL v2 and later (depending on your preference and the license of the
> >> code you used as a base)?
> >>
> >> > >> +
> >> > >> +static int ar1021_i2c_resume(struct device *dev)
> >> > >> +{
> >> > >> +     struct i2c_client *client = to_i2c_client(dev);
> >> > >> +
> >> > >> +     enable_irq(client->irq);
> >> > >
> >> > > You do not want to enable IRQ if there are no users (nobody opened
> >> > > device).
> >> > >
> >> >
> >> > Okay.. but then I also do not need the disable_irq(..) call in
> >> > ar1021_i2c_suspend
> >> > and can totally remove the PM stuff - or?
> >>
> >> No, I think you still need the PM methods, you just need to check if
> >> device is opened (take dev->mutex, check dev->users) and decide if you
> >> need to enable/disable IRQ or not.
> >
> > Hmm, on the other hand enable/disable does the counting for you so maybe
> > you should leave it all as it was.
> 
> ok
> 
> At the moment I am doing the final tests of the driver and it fails to
> load via device tree :(
> I changed the compatible string from "mc,ar1021-i2c" to "microchip,ar1021-i2c".
> 
> and this is how my dts looks like on an imx6d board:
> 
> &i2c2 {
>        status = "okay";
>        clock-frequency = <100000>;
>        pinctrl-names = "default";
>        pinctrl-0 = <&pinctrl_i2c2_1>;
> 
>        ar1021@4d {
>                compatible = "microchip,ar1021-i2c";
>                reg = <0x4d>;
>                interrupt-parent = <&gpio3>;
>                interrupts = <26 0x2>;
>        };
> };
> 
> 
> Any hints?

Not really. Does the driver bind to the device if you define I2C device
in the board code? Are there any errors reported by the kernel?

Thanks.

-- 
Dmitry
