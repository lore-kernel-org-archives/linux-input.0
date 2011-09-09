From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC PATCH] Only process ABS_MT_SLOT where there are slots
 available
Date: Fri, 9 Sep 2011 13:54:31 -0700
Message-ID: <20110909205431.GC9157@core.coreip.homeip.net>
References: <1313663333-19810-1-git-send-email-ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:36424 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933420Ab1IIUyh (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 9 Sep 2011 16:54:37 -0400
Received: by yie30 with SMTP id 30so1215423yie.19
        for <linux-input@vger.kernel.org>; Fri, 09 Sep 2011 13:54:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1313663333-19810-1-git-send-email-ospite@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-input@vger.kernel.org, Simon Wood <simon@mungewell.org>, Henrik Rydberg <rydberg@euromail.se>, virtuousfox@gmail.com

Hi Antonio,

On Thu, Aug 18, 2011 at 12:28:53PM +0200, Antonio Ospite wrote:
> This fixes the case when a non-multitouch device happens to have a HID
> code equal to ABS_MT_SLOT, like the Sony Sixaxis has for the left dpad
> analog control.
> 
> Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>
> Cc: Simon Wood <simon@mungewell.org>
> Cc: Henrik Rydberg <rydberg@euromail.se>
> Cc: virtuousfox@gmail.com
> ---
> 
> Hi,
> 
> following up from the discussion at 
> http://thread.gmane.org/gmane.linux.kernel.input/19632 I've come up with this 
> workaround to make the dpad left analog axis of the Sony Sixaxis controller 
> working. What happens is that this button has a code of 0x2f (ABS_MT_SLOT) 
> which gets some special handling regardless of the device being a multitouch one 
> or not.
> 
> I do not know anything about multitouch devices, so I am not sure if this 
> hack may break something else, I'd like some advice here.
> 
> Another possibility could be to remap the code at the HID level for the 
> Sixaxis only, Simon you suggested this, are you willing to do that if this 
> will be the preferred way? My HID-fu is way worse than yours and It'll take a 
> lot more time for me.

No, drivers should not be emitting ABS_MT_SLOT if they are not
multitouch devices and not using MT-B protocol. You'll have to remap the
axis into something more suitable.

Thanks,
Dmitry

-- 
Dmitry
