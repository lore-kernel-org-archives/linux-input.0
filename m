From: simon@mungewell.org
Subject: Re: [PATCH] Fix autocentering command in hid-lgff driver
Date: Mon, 27 Jun 2011 12:15:23 -0400
Message-ID: <86e0976ce588159c5b8edf14f914bf0c.squirrel@host171.canaca.com>
References: <2502891.N5kVV5at6b@qosmio-x300> <1908821.jaYXT1Nn2e@qosmio-x300>
    <da2b7e45ed001b587d49824944b802b8.squirrel@host171.canaca.com>
    <201106262207.23918.michael@m-bauer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:54218 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752495Ab1F0QP0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Jun 2011 12:15:26 -0400
In-Reply-To: <201106262207.23918.michael@m-bauer.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Bauer <michael@m-bauer.org>
Cc: linux-input@vger.kernel.org, =?iso-8859-1?Q?=22Michal_Mal=FD=22?= <madcatxster@gmail.com>

Hi Guys,
Just to summerise the situation as I see it, and try to get a feel where
we should/could go.

Michael B. has figured out all of the 'compatible->native' commands, which
cause the wheels to renegoiate their USB ID's and have extended features
(up to 900' turn) to made available.

Michal M. wrote up a little C script to exercise the various effects that
we have found (FF_AUTOCENTER, FF_CONSTANT, FF_SPRING, FF_FRICTION,
FF_INTERIA). I had to modify this a little to work with the Wii wheel and
haven't had confirmation that it still works with the other wheels.

I think that we need to build a list/matrix and confirm that _all_ wheels
are OK with a single set of commands (autocenter for the FX excluded).


I think that the way forward is to move all of the wheels to 'lg4ff' and
change that for a more complete FF support. I suggest that we drop the
link to 'ff-memless' and implement our own system to register effects into
1 of the 4 available slots as they are requested.

'lg4ff' could also take on the role of managing the switch between
'compat->native' as it should know the range (<200' or >200') for
correctly setting the spring location.

A resent patch (https://patchwork.kernel.org/patch/921052/) for the
WiiMote gives a good example how to implement '/sys/' files and we could
use these to control the wheel's modes, such as:

/sys/bus/hid/drivers/lg4ff/<dev>/native - write 1 to switch to native,
read to get current state
/sys/bus/hid/drivers/lg4ff/<dev>/range - write angular range, read to get
current range

(rampspeed, autocenter, gain should be handled within FF framework)

Q. Do we need the ability to switch between split/combined pedals?


I think that all of the above is relatively simple to implement and can't
see that it would cause any existing users a problem. So what do you guys
think?

Simon


