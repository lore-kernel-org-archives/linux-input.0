From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: linux kernel HID problem with Saitek X52 Pro Flight System
Date: Wed, 23 Dec 2009 10:55:47 -0800
Message-ID: <20091223185546.GA4525@core.coreip.homeip.net>
References: <20091212044425.GA2956@core.coreip.homeip.net> <4B261412.6090409@canonical.com> <20091214173631.GC2373@core.coreip.homeip.net> <alpine.LNX.2.00.0912151357210.3755@pobox.suse.cz> <4B278C67.5050505@canonical.com> <alpine.LNX.2.00.0912170229340.3755@pobox.suse.cz> <20091217013831.GF6800@core.coreip.homeip.net> <alpine.LNX.2.00.0912181609310.3755@pobox.suse.cz> <20091218174905.GA23450@core.coreip.homeip.net> <alpine.LNX.2.00.0912221430500.3755@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f188.google.com ([209.85.222.188]:56435 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751046AbZLWS4H (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Dec 2009 13:56:07 -0500
Received: by pzk26 with SMTP id 26so4506898pzk.4
        for <linux-input@vger.kernel.org>; Wed, 23 Dec 2009 10:56:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0912221430500.3755@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Stefan Bader <stefan.bader@canonical.com>, Anssi Hannula <anssi.hannula@iki.fi>, Tim Cole <tim.cole@canonical.com>, Sergey Kolesnikov <rockingdemon@gmail.com>, linux-input@vger.kernel.org

On Tue, Dec 22, 2009 at 02:31:49PM +0100, Jiri Kosina wrote:
> On Fri, 18 Dec 2009, Dmitry Torokhov wrote:
> 
> > > > > > #define BTN_TRIGGER_HAPPY01	0x210
> > > > > > ...
> > > > > > #define BTN_TRIGGER_HAPPY40	0x238
> > > > > > 
> > > > > > :-P Assuming 40 additional buttons should be crazy enough (but I know
> > > > > > this has been said before about other things).
> > > > > 
> > > > > Dmitry, do you have any preference here yourself?
> > > > 
> > > > "Trigger happy" sounds fine.
> > > 
> > > OK, so how about something along the lines below?
> > 
> > How about we move trigger happy further towards the 0x2ff limit?
> 
> Sure, no problem. Just tell me the range you'd be comfortable with, and 
> I'll apply a patch using that range.
> 

How about we start with 0x2c0 - it will give us a buffer of another 20
to pad with and if that range is not enough that means we need to come
up with a new story for supporing such joysticks...

-- 
Dmitry
