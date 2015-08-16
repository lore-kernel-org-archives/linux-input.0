From: Andreas Mohr <andi@lisas.de>
Subject: Re: [PATCH] Input: psmouse - add small delay for IBM trackpoint
 pass-through mode
Date: Sun, 16 Aug 2015 17:33:28 +0200
Message-ID: <20150816153328.GA15777@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rhlx01.hs-esslingen.de ([129.143.116.10]:43549 "EHLO
	rhlx01.hs-esslingen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752144AbbHPPnC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 16 Aug 2015 11:43:02 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stefan Assmann <sassmann@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi,

[rogue out-of-band reply, sorry - lkml.org mail info is broken]

> There are trackpoint devices that fail to respond to the PS2 command
> PSMOUSE_CMD_GETID if immediately queried after the parent device is
> deactivated. Add a small delay for the hardware to get in a sane state
> before sending any PS2 commands.

Hmm, "deactivated"?
Probably a parent needs to be "activated" for a passthrough device
(child device?)
to be able to communicate? (I don't know much about these things though...)


> +		usleep_range(10000, 15000);

Ah, used _range() API - strong bonus points
for caring about wakeup minimization! :)

(and I take it you surely cared to check proper device operation
at both cases of doing usleep()
with either upper or lower delay amount specified... ;)




In general it's somewhat sad
to see an unconditional implementation
via woefully imprecise delay-only operation here -
is there a way to have it implemented
as a properly *handshaked* protocol,
i.e. try (re-)doing some other query type
which would fail until init is ok or timeout?
OTOH in that case PSMOUSE_CMD_GETID probably happens to be
just that kind of "handshaked success" query type to be used here...


Or, IOW (pseudo code):

delay;
if (!query()) fail;

sounds rather worse from a handshaked-protocol POV than

while (retries_remaining)
    if (query()) break;
    delay;


This reasoning would probably suggest
that such a loop should be added *within* psmouse_probe(), at the first
check (i.e., PSMOUSE_CMD_GETID).

OTOH that handshaked loop is only feasible
if doing repeated PSMOUSE_CMD_GETID query attempts
is actually supported (tolerated) by devices
(vs. no-op delaying and *then* trying one time only),
i.e. that repeated PSMOUSE_CMD_GETID queries will succeed
rather than fail or even block...



BTW, to make it obvious why non-handshaked operation may easily end up worse:
certain devices (out of a couple thousands of different
China-made human interface device models
which will be relevant here ;)
might perhaps *require* getting queried immediately *without* any prior delay,
in which case the first (AND LAST!) PSMOUSE_CMD_GETID query
after the (your) delay
would now already fail for those devices...



HTH,

Andreas Mohr

-- 
GNU/Linux. It's not the software that's free, it's you.
