From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 1/2] Input: Add device_enable handler to DaVinci
	Keyscan platform data
Date: Mon, 7 Dec 2009 16:48:32 -0800
Message-ID: <20091208004832.GA9495@core.coreip.homeip.net>
References: <1258141434-18351-1-git-send-email-miguel.aguilar@ridgerun.com> <87hbs25n38.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f191.google.com ([209.85.216.191]:64472 "EHLO
	mail-px0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965207AbZLHAsb (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Dec 2009 19:48:31 -0500
Received: by pxi29 with SMTP id 29so1341006pxi.1
        for <linux-input@vger.kernel.org>; Mon, 07 Dec 2009 16:48:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <87hbs25n38.fsf@deeprootsystems.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: miguel.aguilar@ridgerun.com, davinci-linux-open-source@linux.davincidsp.com, nsnehaprabha@ti.com, linux-input@vger.kernel.org, santiago.nunez@ridgerun.com, todd.fischer@ridgerun.com, clark.becker@ridgerun.com

On Mon, Dec 07, 2009 at 04:24:59PM -0800, Kevin Hilman wrote:
> <miguel.aguilar@ridgerun.com> writes:
> 
> > From: Miguel Aguilar <miguel.aguilar@ridgerun.com>
> >
> > Add a function pointer in the platform data of the DaVinci Keyscan driver
> > called device_enabled, in order to perform board specific actions when
> > the device is initialized, like setup the PINMUX configuration.
> >
> > Signed-off-by: Miguel Aguilar <miguel.aguilar@ridgerun.com>
> 
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> 
> Dmitry,
> 
> Will you be queueing this driver (and this patch) for 2.6.34?  I
> thought you had accepted the original driver, but I don't see it in
> the master or next branch of your input tree at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git

The driver is there, commit bc09dcadc1a3da87d58aa70ebc8e9441205be75c on
'next' branch (I don't really use master branch).  It was committed back
in October, probably that's why you don't see it?

As far as the patch goes - I got an impression from email sent by Steve
that there are ways to do automatic PINMUX detection and thus this patch
was not needed. Is this ture? If not I am stull unsure what happens if
you unload the driver. How do you restore the old configuration so that
the device you took over from can start working again? Maybe pinmux
should be controlled via sysfs attribute (in board code) so that user
can switch on-fly between the devices?

Thanks.

-- 
Dmitry
