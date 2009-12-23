From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] Add Driver for Logitech Flight System G940
Date: Wed, 23 Dec 2009 14:23:17 +0100 (CET)
Message-ID: <alpine.LRH.2.00.0912231422480.21496@twin.jikos.cz>
References: <fce72f9b0912081439ia797224xf05ed93771b5203d@mail.gmail.com>  <alpine.LNX.2.00.0912091416010.3755@pobox.suse.cz> <fce72f9b0912101237x5f38300bxcd0fbb815ad5ea9c@mail.gmail.com> <alpine.LNX.2.00.0912151451060.3755@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:50161 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751799AbZLWNXT (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Dec 2009 08:23:19 -0500
In-Reply-To: <alpine.LNX.2.00.0912151451060.3755@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gary Stein <lordcnidarian@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Tue, 15 Dec 2009, Jiri Kosina wrote:

> > This is a cleaned up and updated driver for the G940.  I followed most 
> > of the checkpatch notes except for some of the 80 column stuff, the 
> > sections of where most of that code is hid-core.c also doesn't seem to 
> > care about it.
> 
> Yup, that's OK, thanks.
> 
> Please also fix up a few comments on various places which are wrongly 
> intended, such as
> 
> > +       /* maxusage should be 63, maximum fields
> > +               likely a better way to ensure this data is clean */
> 
> which should rather be in a format more similar to
> 
> 	/* 
> 	 * first comment line
> 	 * second comment line
> 	 */

Hi Gary,

are you going to resend the driver with these minor things fixed so that I 
could queue it in my tree?

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.

