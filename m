From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] Input: introduce 'notimeout' blacklist for Dell Vostro
 V13 (was Re: Synaptics touchpad on Dell Vostro V13)
Date: Fri, 7 Jan 2011 23:30:03 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1101072329170.26685@pobox.suse.cz>
References: <8583070.26.1294325869588.JavaMail.root@butch.jtdata.net> <alpine.LNX.2.00.1101071105350.26685@pobox.suse.cz> <20110107172847.GA28785@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:38788 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753264Ab1AGWaE (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 7 Jan 2011 17:30:04 -0500
In-Reply-To: <20110107172847.GA28785@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "James T. Dickson" <james.dickson@jtdata.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 7 Jan 2011, Dmitry Torokhov wrote:

> > > Placing it in /etc/pm/sleeps.d/ .
> > > 
> > > #!/bin/sh
> > > #
> > > # Reload the AT keyboard interface.
> > > 
> > > case "$1" in
> > >         hibernate|suspend)
> > >                 rmmod psmouse
> > >                 ;;
> > >         thaw|resume)
> > >                 modprobe psmouse
> > >                 ;;
> > >         *)
> > >                 ;;
> > > esac
> > 
> > I have already came across reports of this being needed for synaptics 
> > touchpads on several different machines already, so this seems to be 
> > rather unrelated problem to me.
> 
> Right, but it would be nice if we could find the problem...

Definitely, working on this is with the original reporter is on my TODO 
list (I don't know yet whether that particular machine is affected or 
not). Will keep you updated.

> > Dmitry, what is your current plan with the notimeout thing for V13, 
> > please? Still .38 material?
> 
> Yeah, especially given that not all V13 seem to suffer from
> suspend/resume issue.

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
