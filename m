From: Martin Buck <mb-tmp-yvahk-vachg@gromit.dyndns.org>
Subject: Stuck buttons on ALPS touchpad
Date: Wed, 3 Mar 2010 23:07:35 +0100
Message-ID: <20100303220735.GC26412@gromit.at.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail17.bluewin.ch ([195.186.18.64]:20362 "EHLO
	mail17.bluewin.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756854Ab0CCWOo (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Mar 2010 17:14:44 -0500
Received: from mb by gromit.at.home with local (Exim 4.63)
	(envelope-from <mb-tmp-yvahk-vachg@gromit.dyndns.org>)
	id 1Nmwj9-0007y1-CK
	for linux-input@vger.kernel.org; Wed, 03 Mar 2010 23:07:35 +0100
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,

I've got a little problem with the ALPS touchpad in my Dell Inspiron 8200
(identified as E7 report: 32 02 14). Sometimes when pressing the touchpad
buttons, they get stuck (in the driver only, of course :-) and are released
only after moving the finger on the touchpad. This behaviour started after
upgrading to kernel 2.6.32.8. With the 2.6.26.5 kernel I was using
previously, it didn't occur.

I identified the change causing this to be the following one from Ulrich
Dangel:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=d7ed5d883c09c5474f842dcb148515dfaef2a567

> Input: ALPS - handle touchpoints buttons correctly
> 
> When pressing any button belonging to the touchpoint, the generated
> click events don't belong to the touchpoint but to the touchpad.
> This patch fixes this behaviour, the events will be sent via the
> correct device, so scrolling with touchpoint is possible.

On my machine, this seems to sometimes direct the touchpad button release
event to the touchpoint, causing the old touchpad button state to remain
until the next packet from the touchpad arrives. Looking at the packets
received, it's obvious why this happens:

Normal left button down/up sequence:
[  269.805058] ff 11 20 49 32 00
[  269.983019] ff 11 20 48 32 00

Broken left button down/up sequence:
[  273.947184] ff 11 20 49 32 00
[  274.106059] ff 11 20 49 32 00
[  274.262486] ff 00 00 08 00 7f

As you can see, when the button gets stuck, the touchpad sends the button
down event twice and instead of the normal button up event, it sends one
with z==127 which Ulrich's change interprets as belonging to the touchpoint.

Interestingly, kernel 2.6.32.8 already has all the code to fix this, it's
just not enabled for my touchpad. alps_report_buttons() checks the
ALPS_PS2_INTERLEAVED flag and if set, directs button up events to the
same device that got the button down event, regardless of the source derived
from the packet. Does anybody see a reason why this shouldn't be done
unconditionally regardless of the ALPS_PS2_INTERLEAVED flag? Or should there
be another flag that enables the workaround just for selected models?

Any other ideas how to fix this?

Thanks,
Martin
