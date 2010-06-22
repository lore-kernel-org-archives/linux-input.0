From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 3/3] HID: magicmouse: enable horizontal scrolling
Date: Tue, 22 Jun 2010 11:10:19 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1006221049540.13809@pobox.suse.cz>
References: <1277083951-29137-1-git-send-email-chase.douglas@canonical.com>  <1277083951-29137-4-git-send-email-chase.douglas@canonical.com>  <87eifzdfdn.fsf@troilus.org> <1277176133.3242.237.camel@mini>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:45135 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932077Ab0FVJKr (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Jun 2010 05:10:47 -0400
In-Reply-To: <1277176133.3242.237.camel@mini>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: Michael Poole <mdpoole@troilus.org>, linux-input@vger.kernel.org

On Mon, 21 Jun 2010, Chase Douglas wrote:

> > > Mimicks OS X behavior.
> > >
> > > Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
> > > ---
> > >  drivers/hid/hid-magicmouse.c |   25 +++++++++++++++++++------
> > >  1 files changed, 19 insertions(+), 6 deletions(-)
> > 
> > I like this general idea, but Dmitry Torokhov didn't like my previous
> > patch to achieve a similar effect:
> > https://patchwork.kernel.org/patch/84201/
> 
> To be fair, that patch had a lot more in it. I'm not sure that appending
> horizontal scroll to what's already in the driver is too much to ask.

I agree here. Horizontal scrolling support itself is fine.

I have the patches in my to-review queue, will process them shortly.

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
