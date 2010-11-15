From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/2] sysfs: Introducing sysfs_create_bin_group()
Date: Mon, 15 Nov 2010 14:49:06 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1011151447070.7420@pobox.suse.cz>
References: <1289585918.2629.12.camel@neuromancer> <20101112192958.GA22233@suse.de> <20101112193817.GA1299@core.coreip.homeip.net> <20101112195010.GA23000@suse.de> <20101112200215.GD1299@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:35851 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755612Ab0KONtJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Nov 2010 08:49:09 -0500
In-Reply-To: <20101112200215.GD1299@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Greg KH <gregkh@suse.de>, Stefan Achatz <stefan_achatz@web.de>, "Eric W. Biederman" <ebiederm@aristanetworks.com>, "Serge E. Hallyn" <serue@us.ibm.com>, Tejun Heo <tj@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Thery <benjamin.thery@bull.net>

On Fri, 12 Nov 2010, Dmitry Torokhov wrote:

> > > > > Implemented group functions for easier creation of multiple binary sysfs
> > > > > attributes similar to existing attribute_group handling functions.
> > > > > The code reuses struct attribute_group instead of inventing a new struct
> > > > > binary_attribute_group.
> > > > > 
> > > > > Signed-off-by: Stefan Achatz <erazor_de@users.sourceforge.net>
> > > > 
> > > > Looks good to me, nice job.
> > > > 
> > > > Dmitry, do you want to take this through your tree as the mouse driver
> > > > change needs it?  If so, feel free to do so and add a:
> > > > 	Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
> > > > 
> > > > to the patch.
> > > > 
> > > > If not, I'll be glad to take it, and the mouse driver change through my
> > > > tree if needed.
> > > > 
> > > > Just let me know which is easier for you.
> > > > 
> > > 
> > > Actually the driver lives in hid so it's up to Jiri how he wants to
> > > handle this.
> > 
> > Ah.  He's on vacation for a few weeks so I guess I'll take this for now.
> > 
> 
> Those Europeans with their long vacations, geeze... Well, I hope he's
> having fun ;)

Oh definitely. We haven't expected snow and ice already being there in 
White Mountain :) Quite a fun.

sysfs_create_bin_group() definitely looks like an improvement. I'd like to 
take it together with the Roccat driver patch, as it depends on it. Greg 
-- would you mind me taking it through my tree with your signoff?

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
