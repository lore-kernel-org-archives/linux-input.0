From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] hid: Add custom driver for Lenovo ThinkPad Compact
 Bluetooth Keyboard
Date: Tue, 20 May 2014 17:31:09 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1405201726040.1615@pobox.suse.cz>
References: <1395786407-11273-1-git-send-email-jm@lentin.co.uk> <alpine.LNX.2.00.1405201644230.1615@pobox.suse.cz> <alpine.DEB.2.02.1405201555110.4059@marmot.wormnet.eu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.02.1405201555110.4059@marmot.wormnet.eu>
Sender: linux-kernel-owner@vger.kernel.org
To: Jamie Lentin <jm@lentin.co.uk>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 20 May 2014, Jamie Lentin wrote:

> > I think it'd make more sense if this could be folded into 
> > hid-lenovo-tpkbd driver. Could you please do that and resubmit?
> 
> I can do if required, although I didn't originally since there would be no
> common code whatsoever between the keyboards. 

That's not a problem really. I am trying to have the functionality mostly 
grouped together by vendor, and not pollute the tree by gazillion of tiny 
single-function driver.

> I have both the USB and the Bluetooth versions of this keyboard now, once I
> have finished support for both[0] I will resubmit support for both.

Thanks,

-- 
Jiri Kosina
SUSE Labs
