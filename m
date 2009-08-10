From: Alessandro Suardi <alessandro.suardi@gmail.com>
Subject: Re: touchpad stuck sometimes
Date: Mon, 10 Aug 2009 10:23:22 +0200
Message-ID: <5a4c581d0908100123t7d68c751kfb4f70d68852e2cb@mail.gmail.com>
References: <20090802081612.GA14646@darkstar>
	 <a8e1da0908072003j1267ec89p366dc62c271663b7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:63486 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305AbZHJIXX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Aug 2009 04:23:23 -0400
In-Reply-To: <a8e1da0908072003j1267ec89p366dc62c271663b7@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dave Young <hidave.darkstar@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Sat, Aug 8, 2009 at 5:03 AM, Dave Young <hidave.darkstar@gmail.com> =
wrote:
>
> On Sun, Aug 2, 2009 at 4:16 PM, Dave Young<hidave.darkstar@gmail.com>=
 wrote:
> > Hi,
> >
> > My touchpad sometimes will stuck for a while, and then it will be o=
k.
> >
> > I can see kernel message like this:
> >
> > [ 1293.426227] psmouse.c: GlidePoint at isa0060/serio1/input0 lost =
synchronization, throwing 2 bytes away.
> > [ 1293.969357] psmouse.c: resync failed, issuing reconnect request
> >
> > Hardware is dell e5400, kernel version: 2.6.31-rc5
> >
> > --
> > Regards
> > dave
> >

[apologies for the dup, my GMail compose window was somehow
 stuck on HTML and the vger lists bounced my message - here
 it is in plain text]

Sort of a "me too" - on my Dell E6400 I get the touchpad stuck or not
 moving correctly (almost stuck, or way too fast) - in those cases it's
 enough to take fingers off touchpad and use the stick for a second,
 everything resumes its normal operation.

I have these in the logs, not sure it's the same issue as the one I am
 describing, but likely the same as Dave's submission:

2.6.31-rc3-git2:

Jul 22 11:04:51 duff kernel: 0000:00:19.0: eth0: 10/100 speed: disablin=
g TSO
Jul 22 12:03:28 duff kernel: psmouse.c: DualPoint TouchPad at
isa0060/serio1/input0 lost sync at byte 1
Jul 22 12:03:28 duff kernel: psmouse.c: DualPoint TouchPad at
isa0060/serio1/input0 lost sync at byte 1
Jul 22 12:03:28 duff kernel: psmouse.c: DualPoint TouchPad at
isa0060/serio1/input0 lost sync at byte 1
Jul 22 12:03:28 duff kernel: psmouse.c: DualPoint TouchPad at
isa0060/serio1/input0 - driver resynched.

2.6.31-rc5-git3:

Aug  7 10:12:01 duff nm-system-settings:    ifcfg-rh:     read
connection 'System eth0'
Aug  7 16:42:29 duff kernel: psmouse.c: DualPoint TouchPad at
isa0060/serio1/input0 lost sync at byte 1
Aug  7 16:42:29 duff kernel: psmouse.c: DualPoint TouchPad at
isa0060/serio1/input0 - driver resynched.
Aug  7 16:42:29 duff kernel: psmouse.c: DualPoint TouchPad at
isa0060/serio1/input0 lost sync at byte 1
Aug  7 16:42:29 duff kernel: psmouse.c: DualPoint TouchPad at
isa0060/serio1/input0 lost sync at byte 1
Aug  7 16:42:29 duff kernel: psmouse.c: DualPoint TouchPad at
isa0060/serio1/input0 - driver resynched.


cheers,

--alessandro

"And if a God will lay to rest anywhere we want to go
=A0In your house I long to be, room by room, patiently"

=A0 (Audioslave, "Like A Stone")
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
