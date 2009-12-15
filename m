From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: linux kernel HID problem with Saitek X52 Pro Flight System
Date: Tue, 15 Dec 2009 13:58:00 +0100 (CET)
Message-ID: <alpine.LNX.2.00.0912151357210.3755@pobox.suse.cz>
References: <alpine.LNX.2.00.0909081931360.23856@wotan.suse.de> <bfb1bb1f0909081304y708b037bw1c82288d6457c254@mail.gmail.com> <alpine.LNX.2.00.0909090041410.23856@wotan.suse.de> <4B21308F.5070304@canonical.com> <1260541128.3656.6.camel@bede>
 <4B225601.3080002@canonical.com> <1260572529.3656.12.camel@bede> <4B22F952.6070001@iki.fi> <20091212044425.GA2956@core.coreip.homeip.net> <4B261412.6090409@canonical.com> <20091214173631.GC2373@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:59587 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753750AbZLOM6D (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Dec 2009 07:58:03 -0500
In-Reply-To: <20091214173631.GC2373@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Stefan Bader <stefan.bader@canonical.com>, Anssi Hannula <anssi.hannula@iki.fi>, Tim Cole <tim.cole@canonical.com>, Sergey Kolesnikov <rockingdemon@gmail.com>, linux-input@vger.kernel.org

On Mon, 14 Dec 2009, Dmitry Torokhov wrote:

> > This might be an overly naive approach (or call it thinking loudly)... 
> > It would probably break a lot of stuff when the JOYSTICK/TRIGGER block 
> > moved to the 0x210 region, but would it be a solution to have a block 
> > of additional joystick buttons there and check on assigning buttons to 
> > a joystick, whether it traverses over to GAMEPAD and in that case skip 
> > to the additional block?
> 
> That's what we have to do I guess... I wonder how many keycodes will we
> need so we won't have to split the region again? Will they come up with
> 70 buttons next time?

Yup, I am not able to come up with anything more clever either.

I can do that easily ... any suggestions for button names? :)

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
