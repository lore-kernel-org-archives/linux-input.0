From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: PATCH [1/6] HID: lg4ff - Move handling of Logitech wheels to
 lg4ff driver
Date: Thu, 4 Aug 2011 15:23:40 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1108041522550.32288@pobox.suse.cz>
References: <1436421.MlUiXUhh2P@qosmio-x300> <a5844f7bbd833b88460daeecabbe59d8.squirrel@host171.canaca.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:46539 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753196Ab1HDNXm (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 4 Aug 2011 09:23:42 -0400
In-Reply-To: <a5844f7bbd833b88460daeecabbe59d8.squirrel@host171.canaca.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon@mungewell.org
Cc: =?ISO-8859-15?Q?=22Michal_Mal=FD=22?= <madcatxster@gmail.com>, linux-input@vger.kernel.org

On Sat, 30 Jul 2011, simon@mungewell.org wrote:

> > This is the first out of five patches me and Simon Wood (CC'd) have been
> > working on.
> 
> As a formality I should state that I support this series of patches. I
> think moving the FF code from 'hid-lgff.c' to 'hid-lg4ff' will enable us
> to implement more features in the future without risk of inadverantly
> affecting other (non-wheel) devices.
> 
> I have tested this code against the WiiWheel and DrivingForcePro.
> 
> signed-off-by: simon@mungewell.org

Michal, thanks a lot for resending with the UTF-8 stuff in printk() 
removed.

I am going to apply it, but the whole series has been line wrapped by your 
client. Could you please fix that up and resend, so that I could apply it?

Thanks,

-- 
Jiri Kosina
SUSE Labs
