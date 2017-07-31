From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: sony: Add touchpad support for Sony's NSG-MR5U and
 NSG-MR7U remotes
Date: Mon, 31 Jul 2017 16:01:28 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1707311559340.4705@cbobk.fhfr.pm>
References: <20170211050004.GA3944@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36864 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752083AbdGaOBa (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 31 Jul 2017 10:01:30 -0400
In-Reply-To: <20170211050004.GA3944@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Todd Kelner <tsopdump@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org

On Fri, 10 Feb 2017, Todd Kelner wrote:

> Sony's NSG-MR5U and NSG-MR7U remote controls have a full keyboard and a
> touchpad.  The keyboard is already supported by the existing Linux kernel
> and drivers but the touchpad is not recognized.  This patch adds the code
> needed to bring full functionality to the touchpad.
> 
> Note that these remotes use the vendor code for SMK even though they are
> Sony branded.

Ouch, sorry for missing this. I've just found this patch hiding in a dark 
corners of my inbox.

[ ... snip ... ]
>  	/* We map the button underneath the touchpad to BTN_LEFT. */
>  	__set_bit(EV_KEY, sc->touchpad->evbit);
>  	__set_bit(BTN_LEFT, sc->touchpad->keybit);
> +	__clear_bit(BTN_MIDDLE, sc->touchpad->keybit);
> +	__clear_bit(BTN_RIGHT, sc->touchpad->keybit);

Could you please explain (perhaps in a comment and/or commitlog) why this 
change is okay even in !(sc->quirks & NSG_MRXU_REMOTE) cases?

Otherwise the patch looks good to me; if you could please rebase it on top 
of current codebase, I'll merge it immediately.

Thanks,

-- 
Jiri Kosina
SUSE Labs

