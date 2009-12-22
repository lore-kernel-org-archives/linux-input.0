From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: linux kernel HID problem with Saitek X52 Pro Flight System
Date: Tue, 22 Dec 2009 14:31:49 +0100 (CET)
Message-ID: <alpine.LNX.2.00.0912221430500.3755@pobox.suse.cz>
References: <1260572529.3656.12.camel@bede> <4B22F952.6070001@iki.fi> <20091212044425.GA2956@core.coreip.homeip.net> <4B261412.6090409@canonical.com> <20091214173631.GC2373@core.coreip.homeip.net> <alpine.LNX.2.00.0912151357210.3755@pobox.suse.cz>
 <4B278C67.5050505@canonical.com> <alpine.LNX.2.00.0912170229340.3755@pobox.suse.cz> <20091217013831.GF6800@core.coreip.homeip.net> <alpine.LNX.2.00.0912181609310.3755@pobox.suse.cz> <20091218174905.GA23450@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:37876 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752893AbZLVNbu (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Dec 2009 08:31:50 -0500
In-Reply-To: <20091218174905.GA23450@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Stefan Bader <stefan.bader@canonical.com>, Anssi Hannula <anssi.hannula@iki.fi>, Tim Cole <tim.cole@canonical.com>, Sergey Kolesnikov <rockingdemon@gmail.com>, linux-input@vger.kernel.org

On Fri, 18 Dec 2009, Dmitry Torokhov wrote:

> > > > > #define BTN_TRIGGER_HAPPY01	0x210
> > > > > ...
> > > > > #define BTN_TRIGGER_HAPPY40	0x238
> > > > > 
> > > > > :-P Assuming 40 additional buttons should be crazy enough (but I know
> > > > > this has been said before about other things).
> > > > 
> > > > Dmitry, do you have any preference here yourself?
> > > 
> > > "Trigger happy" sounds fine.
> > 
> > OK, so how about something along the lines below?
> 
> How about we move trigger happy further towards the 0x2ff limit?

Sure, no problem. Just tell me the range you'd be comfortable with, and 
I'll apply a patch using that range.

> Also, do we clamp the bit numbers at KEY_MAX? 

Good point. I'll update all the map_*() macros in a separate patch and add 
range overflow checks.

> Otherwise looks good, please push through your tree.

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
