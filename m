From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Linux joystick driver bugreport
Date: Fri, 26 Aug 2011 16:20:41 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1108261618530.13644@pobox.suse.cz>
References: <20110625011015.6f397f6f@Giskard> <20110627193814.GB13829@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:45234 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750899Ab1HZOUm (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 26 Aug 2011 10:20:42 -0400
In-Reply-To: <20110627193814.GB13829@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Pablo Cabrera <binchmod777@gmail.com>, Linux Input <linux-input@vger.kernel.org>

On Mon, 27 Jun 2011, Dmitry Torokhov wrote:

> > The joystick driver incorrectly maps axes for some devices.
> > 
> > I tried two different sticks on different computers with very similar
> > results. In both cases, the driver detects more axes which each
> > joystick has, and does not map the 'arrow buttons' correctly.
> > For device 0079:0011 DragonRise Inc. arrows buttons are mapped to axes 3
> > and 4.
> > For device 0e8f: 0002 GreenAsia Motion Inc. arrows buttons are mapped
> > to axes 2 and 3

Pablo,

could you please post report descriptor and HID debugging output for those 
devices?

You can obtain those from debugfs -- /sys/kernel/debug/hid/<device>/ on 
most systems (depending where you have debugfs mounted to).

There are two text files -- the 'rdesc' one never changes, and contains 
report descriptor as presented by the device. The 'events' one has new 
event every time event is triggered by the HID device, and presents view 
of the event from the HID core POV.

I'd be interested in those outputs for the affected devices.

Thanks,

-- 
Jiri Kosina
SUSE Labs
