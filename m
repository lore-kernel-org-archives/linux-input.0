From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: cap11xx - fix module alias
Date: Thu, 29 Jan 2015 17:47:04 -0800
Message-ID: <3156867.rxIHxb1lA7@dtor-glaptop>
References: <1422581293.4982.1.camel@phoenix> <CAKzfze9A=vZXNof9uYSDYmidDz0fV0RD6=LjFHNge-nLJg+kjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:52720 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058AbbA3BrI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Jan 2015 20:47:08 -0500
Received: by mail-ie0-f169.google.com with SMTP id rl12so519010iec.0
        for <linux-input@vger.kernel.org>; Thu, 29 Jan 2015 17:47:07 -0800 (PST)
In-Reply-To: <CAKzfze9A=vZXNof9uYSDYmidDz0fV0RD6=LjFHNge-nLJg+kjg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matt Ranostay <mranostay@gmail.com>
Cc: Axel Lin <axel.lin@ingics.com>, Daniel Mack <daniel@zonque.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi,

On Thursday, January 29, 2015 05:36:22 PM Matt Ranostay wrote:
> Signed-off-by: Matt Ranostay <mranostay@gmail.com>

Why signed off? Were you involved in writing this code? Reviewed-by or Acked-
by are more appropriate here I think.

> 
> On Thu, Jan 29, 2015 at 5:28 PM, Axel Lin <axel.lin@ingics.com> wrote:
> > This is a I2C driver, so use i2c prefix for the module alias.
> > 
> > Signed-off-by: Axel Lin <axel.lin@ingics.com>
> > ---
> > 
> >  drivers/input/keyboard/cap11xx.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/input/keyboard/cap11xx.c
> > b/drivers/input/keyboard/cap11xx.c index 4f59f0b..938f0d5 100644
> > --- a/drivers/input/keyboard/cap11xx.c
> > +++ b/drivers/input/keyboard/cap11xx.c
> > @@ -370,7 +370,7 @@ static struct i2c_driver cap11xx_i2c_driver = {
> > 
> >  module_i2c_driver(cap11xx_i2c_driver);
> > 
> > -MODULE_ALIAS("platform:cap11xx");

This is clearly incorrect.

> > +MODULE_ALIAS("i2c:cap11xx");

However I do not see what this gives us. I see:

dtor@dtor-ws:~/kernel/work$ modinfo drivers/input/keyboard/cap11xx.ko 
filename:       
/usr/local/google/home/dtor/kernel/work/drivers/input/keyboard/cap11xx.ko
license:        GPL v2
author:         Daniel Mack <linux@zonque.org>
description:    Microchip CAP11XX driver
alias:          platform:cap11xx
alias:          of:N*T*Cmicrochip,cap1188*
alias:          of:N*T*Cmicrochip,cap1126*
alias:          of:N*T*Cmicrochip,cap1106*
alias:          i2c:cap1188
alias:          i2c:cap1126
alias:          i2c:cap1106
depends:        i2c-core,regmap-i2c
intree:         Y
vermagic:       3.19.0-rc6+ SMP preempt mod_unload 

So it looks like we have all needed i2c aliases coming form 
MODULE_DEVICE_TABLE.

> > 
> >  MODULE_DESCRIPTION("Microchip CAP11XX driver");
> >  MODULE_AUTHOR("Daniel Mack <linux@zonque.org>");
> >  MODULE_LICENSE("GPL v2");
> > 
> > --
> > 1.9.1

Thanks.

-- 
Dmitry
