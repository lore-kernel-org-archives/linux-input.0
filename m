From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Changes on xpad.c
Date: Wed, 1 Jan 2014 11:24:02 -0800
Message-ID: <20140101192402.GB30798@core.coreip.homeip.net>
References: <CAAXmX-mzTOgEPmDWTx2hU_=6hpe3gEZ44_=032diL4rJoDc4vA@mail.gmail.com>
 <20131226233137.GF18562@core.coreip.homeip.net>
 <CAAXmX-ma_xX-AVbBJ-DeOQL09T6ZkE9wsN1R1MTuu=rHxwm58Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:47470 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752993AbaAATYG (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 1 Jan 2014 14:24:06 -0500
Received: by mail-pa0-f50.google.com with SMTP id kp14so11875606pab.23
        for <linux-input@vger.kernel.org>; Wed, 01 Jan 2014 11:24:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAAXmX-ma_xX-AVbBJ-DeOQL09T6ZkE9wsN1R1MTuu=rHxwm58Q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thomaz de Oliveira dos Reis <thor27@gmail.com>, Mag <magissia@magissia.com>, Ilia Katsnelson <k0009000@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>

Hi Thomaz, Nol, Ilia,

Happy New Year!

On Thu, Dec 26, 2013 at 10:07:58PM -0200, Thomaz de Oliveira dos Reis wrote:
> Hi!
> 
> Hope it is correct.

You forgot to add "Signed-off-by: ..." to your change.

Ilia, Nol, you have added the initial mappings for Razer devices and
chose to map directional pad to buttons instead of HAT0X/Y axis. Could
you remind me why?

Thanks!

> 2013/12/26 Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> > Hi Tomaz,
> >
> > On Sat, Dec 21, 2013 at 09:48:12PM -0200, Thomaz de Oliveira dos Reis
> > wrote:
> > > Hi!
> > >
> > > I noticed that Razer Onza controller, different from tradional xbox
> > > gamepad, the dpad doesn't works in most games. (Some games is possibile
> > to
> > > configure changing a config file or with interface options but many games
> > > it doesn't works at all)
> > >
> > > Looking at module source code, I saw that  it uses the
> > MAP_DPAD_TO_BUTTONS
> > > that was created to use with dance pad (with this controller is not), as
> > > written on this comment:
> > >
> > > Line 69:  *  - dance pads will map D-PAD to buttons, not axes
> > >
> > > Change this to 0 improve overal compatibility of the controller in most
> > > games, without losing any meaningful functionality.
> > >
> > > Also, if someone REALLY need this strange configuration, the user can set
> > > the "dpad_to_buttons" module param as described here:
> > >
> > > Line 103: MODULE_PARM_DESC(dpad_to_buttons, "Map D-PAD to buttons rather
> > > than axes for unknown pads");
> > >
> > > Attached the modified xpad.c module, downloaded from linux-next git file
> > > from today.
> >
> > Please generate a unified diff for your change. See
> > Documentation/SubmittngPatches for explanation how to do this.
> >
> > Thanks.
> >
> >
> > --
> > Dmitry
> >

> --- drivers/input/joystick/xpad.c.orig	2013-12-26 22:02:44.239687200 -0200
> +++ drivers/input/joystick/xpad.c	2013-12-26 22:03:13.199687196 -0200
> @@ -166,8 +166,8 @@ static const struct xpad_device {
>  	{ 0x1430, 0x4748, "RedOctane Guitar Hero X-plorer", 0, XTYPE_XBOX360 },
>  	{ 0x1430, 0x8888, "TX6500+ Dance Pad (first generation)", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX },
>  	{ 0x146b, 0x0601, "BigBen Interactive XBOX 360 Controller", 0, XTYPE_XBOX360 },
> -	{ 0x1689, 0xfd00, "Razer Onza Tournament Edition", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360 },
> -	{ 0x1689, 0xfd01, "Razer Onza Classic Edition", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360 },
> +	{ 0x1689, 0xfd00, "Razer Onza Tournament Edition", 0, XTYPE_XBOX360 },
> +	{ 0x1689, 0xfd01, "Razer Onza Classic Edition", 0, XTYPE_XBOX360 },
>  	{ 0x1bad, 0x0002, "Harmonix Rock Band Guitar", 0, XTYPE_XBOX360 },
>  	{ 0x1bad, 0x0003, "Harmonix Rock Band Drumkit", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360 },
>  	{ 0x1bad, 0xf016, "Mad Catz Xbox 360 Controller", 0, XTYPE_XBOX360 },


-- 
Dmitry
