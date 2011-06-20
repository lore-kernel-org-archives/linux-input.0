From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4 1/3] Input: gpio_keys.c: Simplify platform_device ->
 device casting
Date: Mon, 20 Jun 2011 01:32:06 -0700
Message-ID: <20110620083205.GA23113@core.coreip.homeip.net>
References: <1308042491-20203-1-git-send-email-david@protonic.nl>
 <1308042491-20203-2-git-send-email-david@protonic.nl>
 <20110618101925.GC2401@core.coreip.homeip.net>
 <20110620085213.1e506cdd@archvile>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:35681 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751921Ab1FTIcP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Jun 2011 04:32:15 -0400
Received: by iwn6 with SMTP id 6so991315iwn.19
        for <linux-input@vger.kernel.org>; Mon, 20 Jun 2011 01:32:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110620085213.1e506cdd@archvile>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Jander <david.jander@protonic.nl>
Cc: David Jander <david@protonic.nl>, Grant Likely <grant.likely@secretlab.ca>, linux-input@vger.kernel.org

Hi David,

On Mon, Jun 20, 2011 at 08:52:13AM +0200, David Jander wrote:
> 
> Hi Dmitry,
> 
> On Sat, 18 Jun 2011 03:19:25 -0700
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
> > On Tue, Jun 14, 2011 at 11:08:09AM +0200, David Jander wrote:
> > > This patch factors out the use of struct platform_device *pdev in most
> > > places.
> > > 
> > 
> > Why? We are dealing with a platform device so why would we switch to
> > generic device?
> 
> Actually, when I wrote this patch there still was a difference between
> the platform bus and the of_platform bus, and this change was necessary. There
> also were ifdefs around platform_driver_register and
> of_platform_driver_register. Now it seems this has been merged, and I am
> not sure it is necessary anymore, but I still think it simplifies the code
> quite a bit. Also, why should the driver be bus-dependent, when it doesn't
> even need a real "bus" (it talks to an abstract device through another driver,
> potentially connected to any bus), besides due to how linux views devices and
> drivers.

While there isn't real hardware bus the driver is fitted into platform
device framework and so we should use platform device API unless there
is compelling reason for using another API.

> 
> > I also think that we should not be mixing dev_get/set_drvdata() and
> > <bus>_get/set_drvdata() calls
> 
> AFAICS, we are not mixing.... it is dev_*_drvdata() only.

"Mixing" was probably not the best word. "Using API from a different
layer" would probably be better.

> 
> > but rather use appropriate bus-specific version to access data on given
> > layer.
> 
> Doesn't that make the driver much too complex? And why would that be
> necessary? The driver isn't bus-specific anymore... except for the binding and
> probing part.

Why would it make the driver more complex? Aside from a couple of
PM methods coming from the driver core and therefore operating on
"struct device *" the rest is using platform device directly.

Thanks.

-- 
Dmitry
