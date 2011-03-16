From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: The way for disabling input device?
Date: Tue, 15 Mar 2011 21:53:46 -0700
Message-ID: <20110316045346.GA2582@core.coreip.homeip.net>
References: <4D7F2C12.5020509@samsung.com>
 <20110315151728.GD17277@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:52927 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887Ab1CPExx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Mar 2011 00:53:53 -0400
Received: by gyf1 with SMTP id 1so508773gyf.19
        for <linux-input@vger.kernel.org>; Tue, 15 Mar 2011 21:53:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110315151728.GD17277@sirena.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>, linux-input@vger.kernel.org

On Tue, Mar 15, 2011 at 03:17:29PM +0000, Mark Brown wrote:
> On Tue, Mar 15, 2011 at 06:06:26PM +0900, Joonyoung Shim wrote:
> 
> > The framebuffer device driver of kernel supplies sysfs interface to
> > control blanking level of framebuffer and  we can turn off LCD panel
> > using this sysfs at the above case.
> 
> > Currently i know there isn't the generic way for disabling input device
> > via user interface, so i am looking for the way for disabling
> > input device on kernel side for above case.
> 
> Isn't the expectation here that userspace closes the input device when
> it blanks the screen?

Closing the device might be a bit unwieldy, I was thinking more along
the lines of having a way of "accelerating" runtime PM timeout and using
that framework to put the device to sleep.

-- 
Dmitry
