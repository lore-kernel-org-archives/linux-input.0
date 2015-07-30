From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 8/8] Input: xpad: do not submit active URBs
Date: Wed, 29 Jul 2015 23:59:58 -0700
Message-ID: <20150730065958.GD35939@dtor-ws>
References: <1436572068-10661-1-git-send-email-rojtberg@gmail.com>
 <1436572068-10661-9-git-send-email-rojtberg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:36586 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753509AbbG3HAD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 30 Jul 2015 03:00:03 -0400
Received: by pdjr16 with SMTP id r16so19841005pdj.3
        for <linux-input@vger.kernel.org>; Thu, 30 Jul 2015 00:00:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1436572068-10661-9-git-send-email-rojtberg@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Rojtberg <rojtberg@gmail.com>
Cc: linux-input@vger.kernel.org, pgriffais@valvesoftware.com, gregkh@linuxfoundation.org

On Sat, Jul 11, 2015 at 01:47:48AM +0200, Pavel Rojtberg wrote:
> From: Pavel Rojtberg <rojtberg@gmail.com>
> 
> track the active status of the irq_out URB to prevent submission while
> it is active. Failure to do so results in the "URB submitted while
> active" warning/ stacktrace.
> 
> Also add missing mutex locking around xpad->odata usages.
> 
> This is an workaround for a suspend/ resume issue on my machine, where
> after resume irq_out is completely dead.
> 
> In preliminary testing I could not observe any dropping of packets.
> (controlling rumble with fftest while setting the LEDs using sysfs)
> If there actually are cases where packets are dropped an extension of
> this patch to queue the URBs instead of dropping is straightforward.

We need to implement it. If you weren't able to reproduce the race it
does not mean it does not exist.

Also you can not take mutex in xpad_play_effect as it is called under a
spinlock with interrupts disabled.

Thanks.

-- 
Dmitry
