From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: The way for disabling input device?
Date: Tue, 15 Mar 2011 21:55:52 -0700
Message-ID: <20110316045551.GB2582@core.coreip.homeip.net>
References: <4D7F2C12.5020509@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:37064 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090Ab1CPEz6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Mar 2011 00:55:58 -0400
Received: by ywj3 with SMTP id 3so515833ywj.19
        for <linux-input@vger.kernel.org>; Tue, 15 Mar 2011 21:55:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4D7F2C12.5020509@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: linux-input@vger.kernel.org

On Tue, Mar 15, 2011 at 06:06:26PM +0900, Joonyoung Shim wrote:
> Hi, all.
> 
> The many smartphones and embedded devices have LCD panel with
> touchscreen. The LCD panel is turned off for power saving and
> touchscreen also is disabled if there isn't user input for a while or if
> user presses power key briefly. This state is such idle, not suspend.
> 
> The framebuffer device driver of kernel supplies sysfs interface to
> control blanking level of framebuffer and  we can turn off LCD panel
> using this sysfs at the above case.
> 
> Currently i know there isn't the generic way for disabling input device
> via user interface, so i am looking for the way for disabling
> input device on kernel side for above case.
> 
> The above case has a condition which the touchscreen is disabled if LCD
> panel is turned off. The framebuffer framework of kernel has notifier
> block to callback on events like hardware display blank change occured,
> so the callback function disabling and enabling input device can be
> called using notifier block of framebuffer. The callback function is
> implemented in each touchscreen driver or can be implemented though
> input core if this can be generic way for input device.
> 
> Actually i wonder whether this approach makes sense. I know this is a
> specific case but certainly necessary function in the smartphone and
> embedded devices.

I do not believe that we should tie the 2 together. I can come up with
scenarios where you woudl want to put the keeboard/touchcsreen to sleep
before turning off the display and vice versa.

Thanks.

-- 
Dmitry
