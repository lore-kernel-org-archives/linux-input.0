From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 2/4] HID: magicmouse: properly account for scroll movement
 in state
Date: Wed, 16 Jun 2010 17:05:05 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1006161704240.12271@pobox.suse.cz>
References: <1275488908-23624-1-git-send-email-chase.douglas@canonical.com>  <1275488908-23624-3-git-send-email-chase.douglas@canonical.com>  <8739wvel0d.fsf@troilus.org> <1276700588.11355.8.camel@cndougla>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:53164 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754795Ab0FPPFJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Jun 2010 11:05:09 -0400
In-Reply-To: <1276700588.11355.8.camel@cndougla>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: linux-input@vger.kernel.org, Michael Poole <mdpoole@troilus.org>

On Wed, 16 Jun 2010, Chase Douglas wrote:

> > > Before this change, sequential scroll events would take a variable
> > > amount of movement due to incorrect accounting. This change ensures all
> > > scroll movements require a deterministic touch movement for an action to
> > > occur.
> > >
> > > Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
> > 
> > My apologies for the delay in reviewing this one.  I understand now, and
> > agree it's the right thing to do here.
> > 
> > Acked-by: Michael Poole <mdpoole@troilus.org>
> > 
> > (For the rest of the list, I acked the other three patches in this
> > series via private email earlier.)
> > 
> > Michael Poole
> 
> Jiri,
> 
> What's the status on the rest of these patches that need to be added in?

I wasn't aware of any magicmouse patches waiting for me ... if there are 
things that are destined to be applied on top of what we currently have, 
please be so kind and send them to me again.

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
