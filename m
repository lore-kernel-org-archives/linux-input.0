From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: egalax: Send touch end event when is about to
 suspend
Date: Sun, 29 Dec 2013 16:36:21 -0800
Message-ID: <20131230003621.GB11528@core.coreip.homeip.net>
References: <1386720196-5821-1-git-send-email-eu@felipetonello.com>
 <20131215104053.GC20197@core.coreip.homeip.net>
 <52AF90B6.1000204@felipetonello.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:49282 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752800Ab3L3AgY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 29 Dec 2013 19:36:24 -0500
Content-Disposition: inline
In-Reply-To: <52AF90B6.1000204@felipetonello.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Felipe Ferreri Tonello <eu@felipetonello.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Sachin Kamat <sachin.kamat@linaro.org>, Heiko Abraham <abrahamh@web.de>

Hi Felipe,

On Mon, Dec 16, 2013 at 03:45:58PM -0800, Felipe Ferreri Tonello wrote:
> Hi Dmitry,
> 
> On 12/15/2013 02:40 AM, Dmitry Torokhov wrote:
> >Hi Felipe,
> >
> >On Tue, Dec 10, 2013 at 04:03:16PM -0800, Felipe F. Tonello wrote:
> >>From: "Felipe F. Tonello" <eu@felipetonello.com>
> >>
> >>This is useful to report for users of this device that don't know anything
> >>about the suspension of the device. So users will receive a touch end event
> >>when the device is about to suspend, making it more user friendly.
> >>
> >>One example of users is the X Server with the evdev input driver. This patch
> >>make sure that the X server will propagate a touch end event to its windows.
> >>
> >
> >Hmm, I would argue we need to do this in input core, similarly to what
> >we do for the keys, so that all drivers would benefit from the change.
> >
> >Thanks.
> 
> I agree with you. I didn't do in this case because previous patches
> that I had to change core functionality were declined due the fact
> it's hard to maintain backwards compatibility.
> 
> Do you recommend me something in this case?

I am not sure why your other patches were declined, but I think in this
particular case it makes sense to move this functionality into input
core as many multitouch drivers would need it.

Thanks.

-- 
Dmitry
