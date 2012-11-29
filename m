From: Jan-Matthias Braun <jan_braun@gmx.net>
Subject: Re: hid-multitouch: eGalax Touchscreen not resuming after suspend
Date: Thu, 29 Nov 2012 15:03:04 +0100
Message-ID: <3334839.0y63iIARTX@orthese>
References: <8159607.SRZZrRIPNF@orthese> <alpine.LNX.2.00.1211272123370.3933@pobox.suse.cz> <1655801.HZ7A866RlZ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:39228 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753096Ab2K2ODK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Nov 2012 09:03:10 -0500
In-Reply-To: <1655801.HZ7A866RlZ@vostro.rjw.lan>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Greg Kroah-Hartman <greg@kroah.com>, linux-input@vger.kernel.org

Hi Rafael,

thanks for looking into this.

Am Donnerstag, 29. November 2012, 01:20:04 schrieb Rafael J. Wysocki:
> On Tuesday, November 27, 2012 09:26:11 PM Jiri Kosina wrote:
> > On Sun, 25 Nov 2012, Jan-Matthias Braun wrote:
> > > I have now done a git bisection from 3.0 to 3.1 and have found commit
> > > 1e2ef05bb8cf851a694d38e9170c89e7ff052741 PM: Limit race conditions between runtime PM and system sleep (v2)
> > > to be the first one to introduce the necessity of a module reload after resume.
> 
> So with that commit your device doesn't work after resume from system suspend
> unless you reload the driver?

Yes. Additionally, with later kernel revisions even this won't help, but I could imagine this to be a consequence of the same problem.

> > > I hope that this helps in finding a solution. As I (again) don't immediatly
> > > know how to go on, I kindly ask you to give me some hints for testing/patching
> > > or even a possible solution. :-)
> 
> Can you apply the patch below to the current mainline kernel and see if it makes any
> difference, please?

It does: Current mainline kernel (version >3.7.0-rc7 from git) is not showing the problem, if the patch is applied.

Cheers,

Jan

> ---
>  drivers/base/power/main.c |    4 ----
>  1 file changed, 4 deletions(-)
> 
> Index: linux/drivers/base/power/main.c
> ===================================================================
> --- linux.orig/drivers/base/power/main.c
> +++ linux/drivers/base/power/main.c
> @@ -589,8 +589,6 @@ static int device_resume(struct device *
>  	if (!dev->power.is_suspended)
>  		goto Unlock;
>  
> -	pm_runtime_enable(dev);
> -
>  	if (dev->pm_domain) {
>  		info = "power domain ";
>  		callback = pm_op(&dev->pm_domain->ops, state);
> @@ -1136,8 +1134,6 @@ static int __device_suspend(struct devic
>  
>  	if (error)
>  		async_error = error;
> -	else if (dev->power.is_suspended)
> -		__pm_runtime_disable(dev, false);
>  
>  	return error;
>  }
> 
> 
> 
