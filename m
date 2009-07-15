From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: fix EVIOCGNAME regression
Date: Wed, 15 Jul 2009 08:21:29 -0700
Message-ID: <20090715152129.GA21611@dtor-d630.eng.vmware.com>
References: <1247503151-15615-1-git-send-email-daniel@caiaq.de> <20090713165205.GA28063@dtor-d630.eng.vmware.com> <20090713171130.GH19257@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f197.google.com ([209.85.222.197]:62750 "EHLO
	mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755234AbZGOPVg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Jul 2009 11:21:36 -0400
Received: by pzk35 with SMTP id 35so2061145pzk.33
        for <linux-input@vger.kernel.org>; Wed, 15 Jul 2009 08:21:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090713171130.GH19257@buzzloop.caiaq.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <daniel@caiaq.de>
Cc: linux-input@vger.kernel.org, s.neumann@raumfeld.com, Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>

On Mon, Jul 13, 2009 at 07:11:30PM +0200, Daniel Mack wrote:
> On Mon, Jul 13, 2009 at 09:52:05AM -0700, Dmitry Torokhov wrote:
> > On Mon, Jul 13, 2009 at 06:39:11PM +0200, Daniel Mack wrote:
> > > Commit 3d5cb60e ("Input: simplify name handling for certain input
> > > handles") introduced a regression for the EVIOCGNAME ioctl.
> > > 
> > > Before this, patch, the platform device's name was given back to
> > > userspace which was good to identify devices. After this patch, the
> > > device was ("event%d", minor) which is not descriptive at all.
> > > 
> > > This fixes the behaviour by taking input_dev->name.
> > > 
> > > Signed-off-by: Daniel Mack <daniel@caiaq.de>
> > > Reported-by: Sven Neumann <s.neumann@raumfeld.com>
> > > Cc: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
> > > Cc: Dmitry Torokhov <dtor@mail.ru>
> > > ---
> > >  drivers/input/evdev.c |    6 +++---
> > >  1 files changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
> > > index 114efd8..c81e042 100644
> > > --- a/drivers/input/evdev.c
> > > +++ b/drivers/input/evdev.c
> > > @@ -608,8 +608,8 @@ static long evdev_do_ioctl(struct file *file, unsigned int cmd,
> > >  						    p, compat_mode);
> > >  
> > >  			if (_IOC_NR(cmd) == _IOC_NR(EVIOCGNAME(0)))
> > > -				return str_to_user(dev_name(&evdev->dev),
> > > -						   _IOC_SIZE(cmd), p);
> > > +				return str_to_user(evdev->handle.name,
> > > +						    _IOC_SIZE(cmd), p);
> > 
> > No, this actually should be just dev->name, handle names were always in
> > the form of eventX or jsX. The change below is not needed either.
> > Btw, there is the similar issue in joydev.c as well.
> 
> Ok, how about the one below?
> 
> Daniel
> 
> 
> From 0c754925117421778bd9adf1bd8f4e818fc65c74 Mon Sep 17 00:00:00 2001
> From: Daniel Mack <daniel@caiaq.de>
> Date: Mon, 13 Jul 2009 18:33:53 +0200
> Subject: [PATCH] input: fix EVIOCGNAME/JSIOCGNAME regression
> 
> Commit 3d5cb60e ("Input: simplify name handling for certain input
> handles") introduced a regression for the EVIOCGNAME/JSIOCGNAME
> ioctl.
> 
> Before this, patch, the platform device's name was given back to
> userspace which was good to identify devices. After this patch, the
> device is ("event%d", minor) which is not descriptive at all.
> 
> This fixes the behaviour by taking dev->name.
> 
> Signed-off-by: Daniel Mack <daniel@caiaq.de>
> Reported-by: Sven Neumann <s.neumann@raumfeld.com>
> Cc: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
> Cc: Dmitry Torokhov <dtor@mail.ru>
> ---
>  drivers/input/evdev.c  |    3 +--
>  drivers/input/joydev.c |    7 +++----
>  2 files changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
> index 114efd8..1148140 100644
> --- a/drivers/input/evdev.c
> +++ b/drivers/input/evdev.c
> @@ -608,8 +608,7 @@ static long evdev_do_ioctl(struct file *file, unsigned int cmd,
>  						    p, compat_mode);
>  
>  			if (_IOC_NR(cmd) == _IOC_NR(EVIOCGNAME(0)))
> -				return str_to_user(dev_name(&evdev->dev),
> -						   _IOC_SIZE(cmd), p);
> +				return str_to_user(dev->name, _IOC_SIZE(cmd), p);
>  
>  			if (_IOC_NR(cmd) == _IOC_NR(EVIOCGPHYS(0)))
>  				return str_to_user(dev->phys, _IOC_SIZE(cmd), p);
> diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
> index 0e12f89..16397aa 100644
> --- a/drivers/input/joydev.c
> +++ b/drivers/input/joydev.c
> @@ -536,14 +536,13 @@ static int joydev_ioctl_common(struct joydev *joydev,
>  	default:
>  		if ((cmd & ~IOCSIZE_MASK) == JSIOCGNAME(0)) {
>  			int len;
> -			const char *name = dev_name(&dev->dev);

I like my temps so I'll just change it to "const char *name = dev->name"
here, otherwise applied to for-linus, thanks Daniel.

-- 
Dmitry
