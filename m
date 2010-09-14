From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/1] hid: prevent ILITEK multi-touch devices from being
 handled by usbhid
Date: Tue, 14 Sep 2010 14:39:33 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1009141437470.26813@pobox.suse.cz>
References: <AANLkTimFwHASfChvQUPzjQKu-sstrAYTtgXvxA3mdJu9@mail.gmail.com> <alpine.LNX.2.00.1009141109280.26813@pobox.suse.cz> <AANLkTi=sBrXXb4bDy5Sec-gW-WyA9T0KrAU8c=4X3dS+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTi=sBrXXb4bDy5Sec-gW-WyA9T0KrAU8c=4X3dS+@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bradley Chen <bradley7213@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 14 Sep 2010, Bradley Chen wrote:

> Thank you for your reply. I did make a wrong patch, and what I really 
> tried to do was to add things into kernel source not to remove them. 
> Sorry for the confusion, and I will make a new patch for that.
> 
> The specific driver is being modified right now, and we are going to 
> publish it when it get reasonably stable.

Would you then please perhaps send the HID blacklist addition together 
with the other driver?

> When USB HID driver handles our touch panel, the corresponding tapping 
> action works fine but no matter where we touch the panel the cursor 
> stuck at (0, 0). 

What is the reason behind that? Is the device 'multi-input' one? I.e. 
would HID_QUIRK_MULTI_INPUT be sufficient to fix that?

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
