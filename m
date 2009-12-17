From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: linux kernel HID problem with Saitek X52 Pro Flight System
Date: Wed, 16 Dec 2009 17:38:31 -0800
Message-ID: <20091217013831.GF6800@core.coreip.homeip.net>
References: <1260541128.3656.6.camel@bede> <4B225601.3080002@canonical.com> <1260572529.3656.12.camel@bede> <4B22F952.6070001@iki.fi> <20091212044425.GA2956@core.coreip.homeip.net> <4B261412.6090409@canonical.com> <20091214173631.GC2373@core.coreip.homeip.net> <alpine.LNX.2.00.0912151357210.3755@pobox.suse.cz> <4B278C67.5050505@canonical.com> <alpine.LNX.2.00.0912170229340.3755@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:59363 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763539AbZLQBit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Dec 2009 20:38:49 -0500
Received: by pzk1 with SMTP id 1so1127970pzk.33
        for <linux-input@vger.kernel.org>; Wed, 16 Dec 2009 17:38:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0912170229340.3755@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Stefan Bader <stefan.bader@canonical.com>, Anssi Hannula <anssi.hannula@iki.fi>, Tim Cole <tim.cole@canonical.com>, Sergey Kolesnikov <rockingdemon@gmail.com>, linux-input@vger.kernel.org

On Thu, Dec 17, 2009 at 02:29:55AM +0100, Jiri Kosina wrote:
> On Tue, 15 Dec 2009, Stefan Bader wrote:
> 
> > >>> This might be an overly naive approach (or call it thinking loudly)... 
> > >>> It would probably break a lot of stuff when the JOYSTICK/TRIGGER block 
> > >>> moved to the 0x210 region, but would it be a solution to have a block 
> > >>> of additional joystick buttons there and check on assigning buttons to 
> > >>> a joystick, whether it traverses over to GAMEPAD and in that case skip 
> > >>> to the additional block?
> > >> That's what we have to do I guess... I wonder how many keycodes will we
> > >> need so we won't have to split the region again? Will they come up with
> > >> 70 buttons next time?
> > > 
> > > Yup, I am not able to come up with anything more clever either.
> > > 
> > > I can do that easily ... any suggestions for button names? :)
> > > 
> > #define BTN_TRIGGER_HAPPY01	0x210
> > ...
> > #define BTN_TRIGGER_HAPPY40	0x238
> > 
> > :-P Assuming 40 additional buttons should be crazy enough (but I know
> > this has been said before about other things).
> 
> Dmitry, do you have any preference here yourself?
> 

"Trigger happy" sounds fine.

-- 
Dmitry
