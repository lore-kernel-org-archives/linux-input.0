From: Michael Bauer <michael@m-bauer.org>
Subject: Re: [PATCH] Fix autocentering command in hid-lgff driver
Date: Wed, 29 Jun 2011 11:28:02 +0200
Message-ID: <4E0AF022.8020609@m-bauer.org>
References: <2502891.N5kVV5at6b@qosmio-x300> <201106262207.23918.michael@m-bauer.org> <86e0976ce588159c5b8edf14f914bf0c.squirrel@host171.canaca.com> <4765696.45GeP0TYaU@qosmio-x300>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay02.ispgateway.de ([80.67.29.24]:52348 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752916Ab1F2Jdn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Jun 2011 05:33:43 -0400
In-Reply-To: <4765696.45GeP0TYaU@qosmio-x300>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?Michal_Mal=FD?= <madcatxster@gmail.com>
Cc: simon@mungewell.org, linux-input@vger.kernel.org, peter@slim-one.de

Am 27.06.2011 22:58, schrieb Michal Mal=FD:
>> I think that we need to build a list/matrix and confirm that _all_ w=
heels
>> are OK with a single set of commands (autocenter for the FX excluded=
).
> I've tested your modded script and it worked fine with DFP. Peter who=
 asked to be CC'ed too (I added him to CC) tried it
> out in G27 and reported that all was OK.
DFP, G25 and Momo Racing also worked fine on my side.

>> A resent patch (https://patchwork.kernel.org/patch/921052/) for the
>> WiiMote gives a good example how to implement '/sys/' files and we c=
ould
>> use these to control the wheel's modes, such as:
>>
>> /sys/bus/hid/drivers/lg4ff/<dev>/native - write 1 to switch to nativ=
e,
>> read to get current state
>> /sys/bus/hid/drivers/lg4ff/<dev>/range - write angular range, read t=
o get
>> current range
Yes, i also vote for something like this. Just keep in mind that we=20
still need to find a reliable way to identify exactly the correct wheel=
,=20
as they all register initially with the same VID/PID but need different=
=20
commands for native mode and range.
This might be possible using the revision number - I am trying to get=20
this implemented in ltwheelconf soon to have some more users test if it=
=20
works.

>> Q. Do we need the ability to switch between split/combined pedals?
I am not sure on this - on the one hand i would love to provide all=20
options to the user.
On the other hand i am not sure how this could be done. I do not think=20
it is possible to change the report descriptor of a connected device on=
=20
the fly without (not necessarily physically) reconnecting it?
And from my understanding the combined axes are just some kind of legac=
y=20
stuff to support really old games which can not handle the separate axe=
s.
So from my opinion we should at least initially just provide separate=20
axes and don't try to implement complicated stuff to allow switching to=
=20
combined mode.

> I guess I answered that above, I'd absolutely love to get this into t=
he kernel. Using /sys sounds like the best way to me.
> There are two issues I can think of. First wheels actually simulate r=
econnect when they're switched to the native mode,
> so I guess we'd have to be careful and not cause any memory leaks and=
 stuff. Second all Logitech wheels short of
> G25/27 need a replaced HID descriptor to get separate pedals working,=
 so unless there's a reasonable way how to read
> the anonymous fields reported in the original descriptor, I say keep =
the pedals always separate for now.
I agree as stated above :-)

Best regards
Michael
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
