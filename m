From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: rfkill-input understanding help
Date: Mon, 14 Apr 2008 14:12:28 -0400
Message-ID: <20080414141054.ZZRA012@mailhub.coreip.homeip.net>
References: <200712110333.40946.carlos@strangeworlds.co.uk> <200801220055.39044.carlos@strangeworlds.co.uk> <200804121821.32519.carlos@strangeworlds.co.uk> <200804131223.13417.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:22472 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757426AbYDNSMf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Apr 2008 14:12:35 -0400
Received: by ug-out-1314.google.com with SMTP id z38so514336ugc.16
        for <linux-input@vger.kernel.org>; Mon, 14 Apr 2008 11:12:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200804131223.13417.carlos@strangeworlds.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: Ivo van Doorn <ivdoorn@gmail.com>, linux-input@vger.kernel.org

Hi Carols,

On Sun, Apr 13, 2008 at 12:23:12PM +0100, Carlos Corbacho wrote:
> On Saturday 12 April 2008 18:21:31 Carlos Corbacho wrote:
> > Any thoughts at all on how to diagnose why rfkill-input is not able to find
> > a device to attach to the first time it loads (or more specifically, why
> > input_match_device() fails to return a match the first time around),
> > because I'm still scratching my head on this four months later...
> 
> I think I've found the problem here.
> 
> rfkill-input isn't being attached to a device because it's looking for 
> KEY_WLAN. The problem is that at boot time, I don't have a KEY_WLAN - the key 
> isn't mapped until HAL & hal-info kick in much later.
> 
> I've tested this by blacklisting rfkill-input, waiting until HAL has loaded 
> and run setkeycodes, and then loaded rfkill-input, which then works properly 
> first time round.
> 
> Unfortunately, that's only a workaround, not a real solution, so we're going 
> to need a better way of handling this case.
> 

Yes, setting KEY_X later, after registering input device will not
cause device/handler rescanning. We'll have to do something about
it now that we recommend using HAL to update keymaps properly.

-- 
Dmitry
