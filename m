From: simon@mungewell.org
Subject: Re: [PATCH] Fix autocentering command in hid-lgff driver
Date: Wed, 29 Jun 2011 11:50:32 -0400
Message-ID: <b4f74749ffdf35c88a0523a6a5f1a31b.squirrel@host171.canaca.com>
References: <2502891.N5kVV5at6b@qosmio-x300>
    <201106262207.23918.michael@m-bauer.org>
    <86e0976ce588159c5b8edf14f914bf0c.squirrel@host171.canaca.com>
    <4765696.45GeP0TYaU@qosmio-x300> <4E0AF022.8020609@m-bauer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:33424 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753919Ab1F2Puf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Jun 2011 11:50:35 -0400
In-Reply-To: <4E0AF022.8020609@m-bauer.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Bauer <michael@m-bauer.org>
Cc: =?iso-8859-1?Q?=22Michal_Mal=FD=22?= <madcatxster@gmail.com>, simon@mungewell.org, linux-input@vger.kernel.org, peter@slim-one.de


>>> Q. Do we need the ability to switch between split/combined pedals?

> I am not sure on this - on the one hand i would love to provide all
> options to the user.

> On the other hand i am not sure how this could be done. I do not think
> it is possible to change the report descriptor of a connected device on
> the fly without (not necessarily physically) reconnecting it?

> And from my understanding the combined axes are just some kind of legacy
> stuff to support really old games which can not handle the separate axes.

Can you (someone?) clarify which wheels do not have a command to switch
into 'native mode' (which causes a USB ID change) and do these wheels use
a unified brake/acc.?

Do any wheels have a 'native mode' which stay with the generic USB ID?

Wouldn't the device descriptor only be re-written for the new USB ID's in
'native' mode.

Note: The Wii wheel does not have a 'native' command/mode, but has a
unique ID which is always used.


> Is there any reason the switch to native mode should not be done
> automatically by the driver? I would prefer to have it working
> out-of-the-box instead of having to wait for userspace interaction.
> (This could be done by some udev rule(s), but then this would need to be
> adopted by all distributions...)

> I do not see any point in using the wheel in restricted mode when native
> mode is possible...

If we force the 'native command' to be issued then we might affect/prevent
any 'old game' play.

Note 2: At present the re-writing of descriptor is done in 'hid-lg.c'
(based on USB ID), whereas we are proposing the 'native' command to be
issued by 'hid-lg4ff.c' which might not be complied/enabled.

Perhaps disabling/blacklisting 'hid-lg4ff' is a sufficient workaround to
get older games working... or a module option of 'no-native' could prevent
the command being sent.



Also I noticed that the second part of the 'DFP native command', is very
similar to a strong spring set to slot 4....

Simon

