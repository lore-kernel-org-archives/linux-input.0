From: Courtney Cavin <courtney.cavin@sonymobile.com>
Subject: Re: [PATCH 05/15] Input: synaptics-rmi4 - remove gpio handling and
 polling
Date: Thu, 6 Feb 2014 17:45:14 -0800
Message-ID: <20140207014513.GO1706@sonymobile.com>
References: <1390521623-6491-1-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-2-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-3-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-4-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-5-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-6-git-send-email-courtney.cavin@sonymobile.com>
 <52F172F3.7090003@synaptics.com>
 <20140205023113.GE1706@sonymobile.com>
 <CACRpkdYtGM283y71yWm-GAHXz9UuvxPRddY3wzzvcn40VfHbUw@mail.gmail.com>
 <52F3EAF5.7030203@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from seldrel01.sonyericsson.com ([212.209.106.2]:6170 "EHLO
	seldrel01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751187AbaBGBna (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 6 Feb 2014 20:43:30 -0500
Content-Disposition: inline
In-Reply-To: <52F3EAF5.7030203@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, Linus WALLEIJ <linus.walleij@stericsson.com>

On Thu, Feb 06, 2014 at 09:05:09PM +0100, Christopher Heiny wrote:
> On 02/06/2014 01:28 AM, Linus Walleij wrote:
> > On Wed, Feb 5, 2014 at 3:31 AM, Courtney Cavin
> > <courtney.cavin@sonymobile.com>  wrote:
> >> >On Wed, Feb 05, 2014 at 12:08:35AM +0100, Christopher Heiny wrote:
> >>> >>On 01/23/2014 04:00 PM, Courtney Cavin wrote:
> >>>> >> >Since all the configuration needed for an irq can be provided in other
> >>>> >> >ways, remove all gpio->irq functionality. This cleans up the code quite
> >>>> >> >a bit.
> >>> >>
> >>> >>In certain diagnostic modes, we need to be able to release the IRQ so
> >>> >>the GPIO can be monitored from userspace.  This patch removes that
> >>> >>capability.
> >> >
> >> >Polling a GPIO from userspace is poor design regardless of the use-case, if
> >> >you ask me.  It certainly doesn't motivate the extra gpio<->IRQ code.
>  >
> > I think Courtney is right here, if you want this kind of stuff for debugging
> > it should be debug-add-on-patches, not part of the normal execution
> > path for the driver.
> 
> I'm OK with replacing the current polling implementation with an 
> add-on-patch, as long as the support for the debug-add-on-patches 
> doesn't get torn out of the driver because "hey, I don't see what this 
> is used for in the core driver code, so it must be unnecessary".

An add-on patch shouldn't force dependencies on the code which it
patches.  Thus, the code shouldn't need support for debug add-ons.

Besides, try "hey, this isn't used in the core driver code, so it is
unnecessary."  This whole "there's another tree which depends on things
staying the way they are," isn't conducive to actually making changes to
improve the driver.

> >>> >>As mentioned in previous patch discussions, the polling functionality is
> >>> >>quite useful during new system integration, so we need to retain that.
> >>> >>If you have a proposal for where else it could be done, we'd certainly
> >>> >>entertain a patch that implements that.
> >> >
> >> >Do you actually have systems that have these hooked up to GPIOs without
> >> >IRQ support?
> >> >
> >> >Regardless, if this is the case, implementing a GPIO polling IRQ chip
> >> >should be possible, if extremely ugly.
> > OMG that would be quite horrible.
> >
> >> >Linus may have some comments in this area, though.  Linus?
>  >
> > A driver may rely on polling but a driver may not rely on polling
> > done from userspace.
> 
> Fortunately, the driver doesn't rely on polling from user space.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
