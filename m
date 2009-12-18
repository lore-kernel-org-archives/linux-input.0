From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: linux kernel HID problem with Saitek X52 Pro Flight System
Date: Fri, 18 Dec 2009 09:49:05 -0800
Message-ID: <20091218174905.GA23450@core.coreip.homeip.net>
References: <1260572529.3656.12.camel@bede> <4B22F952.6070001@iki.fi> <20091212044425.GA2956@core.coreip.homeip.net> <4B261412.6090409@canonical.com> <20091214173631.GC2373@core.coreip.homeip.net> <alpine.LNX.2.00.0912151357210.3755@pobox.suse.cz> <4B278C67.5050505@canonical.com> <alpine.LNX.2.00.0912170229340.3755@pobox.suse.cz> <20091217013831.GF6800@core.coreip.homeip.net> <alpine.LNX.2.00.0912181609310.3755@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:49894 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932367AbZLRRtS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Dec 2009 12:49:18 -0500
Received: by pzk1 with SMTP id 1so2374446pzk.33
        for <linux-input@vger.kernel.org>; Fri, 18 Dec 2009 09:49:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0912181609310.3755@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Stefan Bader <stefan.bader@canonical.com>, Anssi Hannula <anssi.hannula@iki.fi>, Tim Cole <tim.cole@canonical.com>, Sergey Kolesnikov <rockingdemon@gmail.com>, linux-input@vger.kernel.org

On Fri, Dec 18, 2009 at 04:10:21PM +0100, Jiri Kosina wrote:
> On Wed, 16 Dec 2009, Dmitry Torokhov wrote:
> 
> > > > #define BTN_TRIGGER_HAPPY01	0x210
> > > > ...
> > > > #define BTN_TRIGGER_HAPPY40	0x238
> > > > 
> > > > :-P Assuming 40 additional buttons should be crazy enough (but I know
> > > > this has been said before about other things).
> > > 
> > > Dmitry, do you have any preference here yourself?
> > 
> > "Trigger happy" sounds fine.
> 
> OK, so how about something along the lines below?
> 

How about we move trigger happy further towards the 0x2ff limit?
Also, do we clamp the bit numbers at KEY_MAX? Otherwise looks good,
please push through your tree.

Thanks.

-- 
Dmitry
