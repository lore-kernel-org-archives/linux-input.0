From: Michal =?ISO-8859-1?Q?Mal=FD?= <madcatxster@gmail.com>
Subject: Re: [PATCH] Fix autocentering command in hid-lgff driver
Date: Mon, 27 Jun 2011 22:58:50 +0200
Message-ID: <4765696.45GeP0TYaU@qosmio-x300>
References: <2502891.N5kVV5at6b@qosmio-x300> <201106262207.23918.michael@m-bauer.org> <86e0976ce588159c5b8edf14f914bf0c.squirrel@host171.canaca.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f52.google.com ([209.85.161.52]:41183 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754251Ab1F0U6x (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Jun 2011 16:58:53 -0400
Received: by fxd18 with SMTP id 18so2147296fxd.11
        for <linux-input@vger.kernel.org>; Mon, 27 Jun 2011 13:58:51 -0700 (PDT)
In-Reply-To: <86e0976ce588159c5b8edf14f914bf0c.squirrel@host171.canaca.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon@mungewell.org
Cc: Michael Bauer <michael@m-bauer.org>, linux-input@vger.kernel.org, peter@slim-one.de

> I think that we need to build a list/matrix and confirm that _all_ wheels
> are OK with a single set of commands (autocenter for the FX excluded).
I've tested your modded script and it worked fine with DFP. Peter who asked to be CC'ed too (I added him to CC) tried it 
out in G27 and reported that all was OK.

> I think that the way forward is to move all of the wheels to 'lg4ff' and
> change that for a more complete FF support. I suggest that we drop the
> link to 'ff-memless' and implement our own system to register effects into
> 1 of the 4 available slots as they are requested.
I have mixed feelings about dropping ff-memless. Currently the ff-memless driver does all the dirty job for us, it also does 
some simple maths like calculating X and Y force strength for FF_CONSTANT effect so we'd be duplicating code here.
On the other hand there are Logitech-specific features that ff-memless can't possibly handle like the effect reset, range 
setting, even the leds on G27 are controlled by some sort of custom FF command. Can you foreshadow how we could 
drop the ff-memless without creating any unnecessary mess in the force feedback stack?

> 'lg4ff' could also take on the role of managing the switch between
> 'compat->native' as it should know the range (<200' or >200') for
> correctly setting the spring location.
> 
> A resent patch (https://patchwork.kernel.org/patch/921052/) for the
> WiiMote gives a good example how to implement '/sys/' files and we could
> use these to control the wheel's modes, such as:
> 
> /sys/bus/hid/drivers/lg4ff/<dev>/native - write 1 to switch to native,
> read to get current state
> /sys/bus/hid/drivers/lg4ff/<dev>/range - write angular range, read to get
> current range
> Q. Do we need the ability to switch between split/combined pedals?
> 
I guess I answered that above, I'd absolutely love to get this into the kernel. Using /sys sounds like the best way to me. 
There are two issues I can think of. First wheels actually simulate reconnect when they're switched to the native mode, 
so I guess we'd have to be careful and not cause any memory leaks and stuff. Second all Logitech wheels short of 
G25/27 need a replaced HID descriptor to get separate pedals working, so unless there's a reasonable way how to read 
the anonymous fields reported in the original descriptor, I say keep the pedals always separate for now.

To sum it up, I think we have a plan.

Michal
