From: Daniel Mack <daniel@caiaq.de>
Subject: Re: ABS_MAX incrementation?
Date: Sun, 2 May 2010 14:13:31 +0200
Message-ID: <20100502121331.GH30801@buzzloop.caiaq.de>
References: <20100419171412.GH30801@buzzloop.caiaq.de>
 <20100419174924.GB22295@core.coreip.homeip.net>
 <20100419180606.GI30801@buzzloop.caiaq.de>
 <20100421062929.GH4364@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from buzzloop.caiaq.de ([212.112.241.133]:45937 "EHLO
	buzzloop.caiaq.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752352Ab0EBMNg (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 2 May 2010 08:13:36 -0400
Content-Disposition: inline
In-Reply-To: <20100421062929.GH4364@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Dmitry,

On Tue, Apr 20, 2010 at 11:29:29PM -0700, Dmitry Torokhov wrote:
> On Mon, Apr 19, 2010 at 08:06:06PM +0200, Daniel Mack wrote:

...

> > As we're on it - I'm quite unhappy with the allocation of the buttons
> > in the snd-usb-caiaq driver. I merely abuse valid values from enums
> > that are defined in input.h and leave it to the userspace to map things
> > back to their original meaning. Is there any change to introduce a more
> > dynamic model which describes buttons by given strings rather than
> > enums? Such an interface could also well be be used for ABS entities,
> > and that would also solve the problem I currently have. Userspace should
> > then have a way to query an entity's name for these special cases.
> 
> Unfortunately input layer is not well-suited for device-specific data. I
> understand that some devices are pretty domain-specific and do not fit
> into standard model of event describing intended useage for everyone. I
> am open to sugggestions/RFC-style patches.

Well, I can live with the fact that enum members are abused so that
their name doesn't have to do much with the actual meaning, even though
that's not optimal. However, in this specific case, the problem is
that I have more axis than available element types, so I'm stuck. But
instead of heacking my way around it using other transport methods down
to userspace, we might also clean up legacy-style limitations once for
good.

> > > Another issue is that ABS data is pretty large, it would be nice if we
> > > moved from this data being always present ininput device structure to
> > > having drivers allocate it when needed.
> > 
> > Ah, the struct has ABS_MAX as length for a fix-sized array, I see. Hmm.
> > Then we shouldn't make that bigger for such reasons, I agree.
> >
> 
> Alocating data dynamically was on my todo list forever. Maybe someone
> will beat me to it *wink, wink*

Hmm, maybe I could also help with that. Could you outline where this
should go? I guess a linked list is not very suitable as it doesn't
allow instant access of specific members. So we need a fixed-size bitmap
to indicate active members at least?

Would that also make sense for all other information than ABS?

Daniel
