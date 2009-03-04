From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH] generic driver for rotary encoders on GPIOs
Date: Wed, 4 Mar 2009 18:20:54 +0100
Message-ID: <20090304172054.GD12183@buzzloop.caiaq.de>
References: <20090303090317.GA14246@dtor-d630.eng.vmware.com> <1236074367-23172-1-git-send-email-daniel@caiaq.de> <20090304084851.GB7394@dtor-d630.eng.vmware.com> <20090304095053.GA6098@buzzloop.caiaq.de> <BD79186B4FD85F4B8E60E381CAEE190901349B98@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from buzzloop.caiaq.de ([212.112.241.133]:49596 "EHLO
	buzzloop.caiaq.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751945AbZCDRVA (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Mar 2009 12:21:00 -0500
Content-Disposition: inline
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190901349B98@mi8nycmail19.Mi8.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: hartleys <hartleys@visionengravers.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Hi Hartleys,

On Wed, Mar 04, 2009 at 12:02:47PM -0500, hartleys wrote:
> >> take a look and if you are still OK with it I will apply to 'next'.
> 
> Couple of comments, none should hold up committing this driver.
> 
> 1) For an absolute encoder shouldn't the position clamp to the
> minimum/maximum values?  Currently the driver is setup to report the
> events going from 0 to 'steps' then the count rolls over (in both
> directions).  Maybe this should be a platform optional flag?  Also,
> maybe the minimum/maximum of the axis should be platform configurable
> instead of just having the 'steps' of the encoder?

Depends on the user level software, I'd say - getting the absolute
position in degrees (which is what is reported, basically) should be
enough as hardware input, anything else is context related, right?

> 2) I have a patch to the driver that allows the axis to be a REL_* type.
> I will post this patch for review after the driver is committed.

Cool, that might be a good alternative for users.

> 3) Are both 'inverted_*' flags really needed?  It appears that the end
> effect of these just reverses the logical direction of the encoder.
> 
> 	inverted_a	inverted_b	result
> 	0		0		normal encoder
> 	0		1		backwards encoder
> 	1		0		backwards encoder
> 	1		1		normal encoder

Probably not. We just had the lines inverted due to some fancy other
logic on the board and hence I made it configurable.

> The same effect should be attainable with one flag to reverse the
> direction, or just reverse the wires on the encoder.

True. The other approache just seemed more straight-forward.

> 3) It might be possible to reconstruct the interrupt handler so that
> only one gpio needs to be interrupt capable.
> 
> Looking at the phase diagram you could consider one of the channel
> inputs as a 'step' interrupt and the other as the 'direction' of the
> step.  On the positive edge of any 'step' if the 'direction' is low it's
> going one way, high it's going the other way.

Hmm - what about the case you're not turning the encoder a full step
ahead but stop in the middle and let it flip back? Will it still detect
that correctly?

> This would double the effective number of encoders that could be
> connected.  And it removes the added overhead of the extra interrupt
> handler and needing to keep track of the 'armed' and 'dir' states.
> Actually with both interrupts sharing the same handler the 'armed' and
> 'dir' variables seem a little bit racy.
> 
> Once the driver is committed I will mess with the interrupt code and see
> if this is possible.

Ok, I'll happily take a look at that. If you flush the idea behind the
state machine, please remember to remove my colleague's name from the
header.

Best regards,
Daniel

