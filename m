From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Report FSP gesture code through EV_MSC?
Date: Thu, 19 Aug 2010 22:14:22 -0700
Message-ID: <20100820051419.GC12243@core.coreip.homeip.net>
References: <10082011211418.7744@cnaqrzbavhz.fragryvp.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:38179 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930Ab0HTFOd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Aug 2010 01:14:33 -0400
Received: by pzk26 with SMTP id 26so1077861pzk.19
        for <linux-input@vger.kernel.org>; Thu, 19 Aug 2010 22:14:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <10082011211418.7744@cnaqrzbavhz.fragryvp.pbz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tai-hwa Liang <avatar@sentelic.com>
Cc: Linux Input <linux-input@vger.kernel.org>

Hi Tai-hwa,

[Noe really cc-ing linux-input...]

On Fri, Aug 20, 2010 at 11:30:14AM +0800, Tai-hwa Liang wrote:
> Hi,
> 
>   Is it okay to use input_event(dev, EV_MSC, MSC_GESTURE, code) to report
> gesture code sent from our FSP?  It looks to me there is no MSC_GESTURE
> user in various kernel input driver so far.
> 
> * gesture code is a feature provided by Sentelic FSP, which converts
>   particular finger movement(single or multiple fingers) into a 8 bit
>   integer.  This supposes to save userland applications some time to
>   parse/process the gesture through multiple abs. coordinates.
> 

While the preferred way is to perform gesture recognition in userland
(where it is easier to adjust to user's preferences and share the code
between all kinds of input devices), for devices that do not report
absolute coordinates, like FSP, it should be OK to use MSC_GESTURE.
Or are you planning to activate absolute mode on your devices?

I think we should define a set of known values for this events so of
there is another driver using these they could use the same values.

Thanks.

-- 
Dmitry
