From: Michal =?ISO-8859-1?Q?Mal=FD?= <madcatxster@gmail.com>
Subject: Re: [PATCH] Fix autocentering command in hid-lgff driver
Date: Wed, 29 Jun 2011 23:37:06 +0200
Message-ID: <10412007.kslt1z6EXa@qosmio-x300>
References: <2502891.N5kVV5at6b@qosmio-x300> <4E0AF022.8020609@m-bauer.org> <b4f74749ffdf35c88a0523a6a5f1a31b.squirrel@host171.canaca.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f52.google.com ([209.85.161.52]:41816 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757986Ab1F2VhL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Jun 2011 17:37:11 -0400
Received: by fxd18 with SMTP id 18so1595425fxd.11
        for <linux-input@vger.kernel.org>; Wed, 29 Jun 2011 14:37:10 -0700 (PDT)
In-Reply-To: <b4f74749ffdf35c88a0523a6a5f1a31b.squirrel@host171.canaca.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon@mungewell.org
Cc: Michael Bauer <michael@m-bauer.org>, linux-input@vger.kernel.org, peter@slim-one.de

> Can you (someone?) clarify which wheels do not have a command to switch
> into 'native mode' (which causes a USB ID change) and do these wheels use
> a unified brake/acc.?
> Do any wheels have a 'native mode' which stay with the generic USB ID?
To my knowledge all wheels except original Driving Force and Formula Force 
have the fallback and native mode. Every Logitech wheel in fallback mode 
reports PID 0x294 which is the PID of the original Driving Force wheel. If 
DFP/G25/G27/DFGT receives specific command, it simulates reconnect and reports 
its "real" PID upon reconnection. 

> Wouldn't the device descriptor only be re-written for the new USB ID's in
> 'native' mode.
DF/DFP/FEX hides the separate throttle and brake axes in the original 
descriptor so we definitely need to replace it. G25/27 don't need such a hack, 
I don't know how about DFGT or Momo, I'll try to find that out.
IMHO we need to replace the descriptor only if the wheel has PID 0x294 and is 
either DF or FEX. DFP has PID 0x298 and needs a fixed descriptor too.

> If we force the 'native command' to be issued then we might affect/prevent
> any 'old game' play.
Problem is that not all wheels actually have the native mode as I mentioned 
above, but all support separate pedal axes. Unless we somehow read the 
anonymous fields reported by the original descriptor, I guess we'll have to 
decide whether to have separate or combined pedal axes.
Another (rather hackish) way around this would be a "combined" value in /sys 
interface. When set to 1, we'd trigger reconnection (can we do that?) and not 
replace the descriptor (or replace it in case of G25/27).


I've given some thought bypassing the ff-memless driver and I don't think it's 
necessary. We can patch ff-memless and add support for the missing effects. I 
guess that passing the device-specific commands like effect reset, G27 leds and 
range setting could be done via /sys interface too.
However that's just a thought...

Michal
