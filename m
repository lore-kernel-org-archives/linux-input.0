From: Stefan Assmann <sassmann@kpanic.de>
Subject: Re: [PATCH] Input: psmouse - add small delay for IBM trackpoint
 pass-through mode
Date: Mon, 17 Aug 2015 09:35:08 +0200
Message-ID: <55D18EAC.70603@kpanic.de>
References: <20150816153328.GA15777@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mysql.app1.xlhost.de ([84.200.252.164]:60792 "EHLO
	app1b.xlhost.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750775AbbHQHfQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Aug 2015 03:35:16 -0400
In-Reply-To: <20150816153328.GA15777@rhlx01.hs-esslingen.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andreas Mohr <andi@lisas.de>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On 16.08.2015 17:33, Andreas Mohr wrote:
> Hi,
> 
> [rogue out-of-band reply, sorry - lkml.org mail info is broken]

Hi Andreas,

> 
>> There are trackpoint devices that fail to respond to the PS2 command
>> PSMOUSE_CMD_GETID if immediately queried after the parent device is
>> deactivated. Add a small delay for the hardware to get in a sane state
>> before sending any PS2 commands.
> 
> Hmm, "deactivated"?
> Probably a parent needs to be "activated" for a passthrough device
> (child device?)
> to be able to communicate? (I don't know much about these things though...)

Comment from few lines above where I put the code.
/*
 * If this is a pass-through port deactivate parent so the device
 * connected to this port can be successfully identified
 */

> 
> 
>> +		usleep_range(10000, 15000);
> 
> Ah, used _range() API - strong bonus points
> for caring about wakeup minimization! :)
> 
> (and I take it you surely cared to check proper device operation
> at both cases of doing usleep()
> with either upper or lower delay amount specified... ;)

Yes, I went as low as 10ms and figured it still works. Then I added
another 5ms if the kernel wants to wake up at a later time. If that's
too much we can decrease the upper limit, although this should only
happen once per boot.

> 
> 
> 
> 
> In general it's somewhat sad
> to see an unconditional implementation
> via woefully imprecise delay-only operation here -
> is there a way to have it implemented
> as a properly *handshaked* protocol,
> i.e. try (re-)doing some other query type
> which would fail until init is ok or timeout?
> OTOH in that case PSMOUSE_CMD_GETID probably happens to be
> just that kind of "handshaked success" query type to be used here...

Thought about that too, but I know too little about the hardware to give
you a proper answer. I'm not even sure why PSMOUSE_CMD_GETID sometimes
fails at all. I assume that hardware needs some time to settle down
after the parent gets deactivated to accept commands.

> 
> 
> Or, IOW (pseudo code):
> 
> delay;
> if (!query()) fail;
> 
> sounds rather worse from a handshaked-protocol POV than
> 
> while (retries_remaining)
>     if (query()) break;
>     delay;
> 
> 
> This reasoning would probably suggest
> that such a loop should be added *within* psmouse_probe(), at the first
> check (i.e., PSMOUSE_CMD_GETID).
> 
> OTOH that handshaked loop is only feasible
> if doing repeated PSMOUSE_CMD_GETID query attempts
> is actually supported (tolerated) by devices
> (vs. no-op delaying and *then* trying one time only),
> i.e. that repeated PSMOUSE_CMD_GETID queries will succeed
> rather than fail or even block...
> 
> 
> 
> BTW, to make it obvious why non-handshaked operation may easily end up worse:
> certain devices (out of a couple thousands of different
> China-made human interface device models
> which will be relevant here ;)
> might perhaps *require* getting queried immediately *without* any prior delay,
> in which case the first (AND LAST!) PSMOUSE_CMD_GETID query
> after the (your) delay
> would now already fail for those devices...

All you're saying is correct. Please note that I carefully limited the
sleep to only SERIO_PS_PSTHRU devices, so the majority of devices out
there is not going to see this at all. IIRC, PSMOUSE_CMD_GETID is the
initial command to be sent to a PS2 device, so a delay before that
should not do any harm. Of course I cannot prove that this will not have
any side-effect on some random hardware, but I'm really trying to narrow
down the number of affected devices to those who may profit from the
change.

Thanks for the feedback.

  Stefan
