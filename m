From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: ads7846: fix gpio_pendown configuration
Date: Thu, 5 May 2011 09:13:56 -0700
Message-ID: <20110505161356.GF27251@core.coreip.homeip.net>
References: <1304438573-7692-1-git-send-email-grinberg@compulab.co.il>
 <20110503161818.GD6509@core.coreip.homeip.net>
 <4DC0F558.90705@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:62893 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753810Ab1EEQOE (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 5 May 2011 12:14:04 -0400
Received: by pzk9 with SMTP id 9so1030678pzk.19
        for <linux-input@vger.kernel.org>; Thu, 05 May 2011 09:14:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4DC0F558.90705@compulab.co.il>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: linux-input@vger.kernel.org

On Wed, May 04, 2011 at 09:42:32AM +0300, Igor Grinberg wrote:
> On 05/03/11 19:18, Dmitry Torokhov wrote:
> 
> > On Tue, May 03, 2011 at 07:02:53PM +0300, Igor Grinberg wrote:
> >> The pendown gpio was requested but not configured for input.
> >> Request and configure it in one shot.
> >>
> >> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
> > There is no significant change from the previos version of the patch by
> > Sourav Poddar that I tried to apply and had to revert. Does it compile
> > if !CONFIG_GENERIC_GPIO?
> 
> shout!?!? It has been just several month we had this discussion,
> but I've completely forgot it took place... shame on me...
> 
> Back to business, either way, the gpio direction must be configured
> before accessing the gpio.
> I can propose two solutions to this:
> 1) ads7846 relies on gpio subsystem, so add depend on
>    CONFIG_GENERIC_GPIO to Kconfig ads7846 entry.
> 2) just don't use gpio_request_one(),
>    but gpio_request() and then gpio_direction_input().
> 
> Logic behind 1 is that platforms that don't use CONFIG_GENERIC_GPIO
> most likely don't use ads7846. Anybody know of such platform?
> The second one is less intrusive and more local, but will do the job.
> 
> What do you think is more preferable?

I'd prefer adding gpio_direction_input(). While I do not know of
instances where ads7846 is used without CONFIG_GENERIC_GPIO it does not
mean they do not exist.

Thanks,

-- 
Dmitry
