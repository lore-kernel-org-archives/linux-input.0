From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] WeTab device ID
Date: Sat, 18 Dec 2010 01:06:03 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1012180105330.16569@pobox.suse.cz>
References: <4D0AA66F.6080506@plausible.org> <20101217120322.GA3873@polaris>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:47702 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756133Ab0LRAGG (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Dec 2010 19:06:06 -0500
In-Reply-To: <20101217120322.GA3873@polaris>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Andy Ross <andy@plausible.org>, "Dmitry Torokhov <dmitry.torokhov@gmail.com>"@suse.de, "Jiri Kosina <jkosina@suse.cz>"@suse.de, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 17 Dec 2010, Henrik Rydberg wrote:

> Hi Andy,
> 
> > > > Hi.  I'm looking at getting a WeTab running right now and just
> > > > found this patch set.  It's a few weeks old now and not upstream
> > > > yet, so before I start hacking at it I thought I should check with
> > > > you to make sure there isn't a more current one available.
> > >
> > > You find the tip of the mt work at
> > > git://git.kernel.org/pub/scm/linux/kernel/git/rydberg/input-mt.git
> > 
> > Thanks much.  It works great, though on our WeTab it's missing the
> > device ID of the part on the board.  Patch below:
> 
> Thanks for the patch. Does the one below work for you?
> 
> Henrik
> ---
> >From a8b4613b6d7e7cf04a7335930e9c5c2fb44302d0 Mon Sep 17 00:00:00 2001
> From: Andy Ross <andy@plausible.org>
> Date: Thu, 16 Dec 2010 15:53:19 -0800
> Subject: [PATCH] hid: egalax: Add support for Wetab (726b)
> 
> This patch adds support for another Wetab device (726b), and grabs it
> accordingly in hid-core.
> 
> [rydberg@euromail.se: rename and log message changes]
> Signed-off-by: Andy Ross <andy@plausible.org>
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>

Signed-off-by: Jiri Kosina <jkosina@suse.cz>

I guess you are going to take it together with your pile to Dmitry, right 
Henrik?

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
