From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 3/5 v3] drivers/hid/hid-roccat.c: eliminate a null pointer
 dereference
Date: Tue, 1 Nov 2011 15:14:16 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1111011513510.348@pobox.suse.cz>
References: <1319846297-2985-3-git-send-email-julia@diku.dk> <20111029062412.GG14881@longonot.mountain> <4EABC937.60600@broadcom.com> <CANq1E4QJoM+NYub9hfs3KnL1w212FK0MHo8ez2p1nyGmNVb-=A@mail.gmail.com> <Pine.LNX.4.64.1110291411150.17700@ask.diku.dk>
 <alpine.LNX.2.00.1110291857310.3541@pobox.suse.cz> <Pine.LNX.4.64.1110292045180.10808@ask.diku.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:46665 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753391Ab1KAOOS (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 1 Nov 2011 10:14:18 -0400
In-Reply-To: <Pine.LNX.4.64.1110292045180.10808@ask.diku.dk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Julia Lawall <julia@diku.dk>
Cc: David Herrmann <dh.herrmann@googlemail.com>, Arend van Spriel <arend@broadcom.com>, Dan Carpenter <dan.carpenter@oracle.com>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Sat, 29 Oct 2011, Julia Lawall wrote:

> It is not possible to take the lock in device if device is NULL.
> The mutex_lock is thus moved after the NULL test.  New error handling
> labels are added at the end to differentiate between the cases where
> different sets of locks should be unlocks, and between whether or not
> reader should be freed (only on error).
> 
> The semantic match that finds this problem is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @r@
> expression E, E1;
> identifier f;
> statement S1,S2,S3;
> @@
> 
> if (E == NULL)
> {
>   ... when != if (E == NULL || ...) S1 else S2
>       when != E = E1
> *E->f
>   ... when any
>   return ...;
> }
> else S3
> // </smpl>
> 
> Signed-off-by: Julia Lawall <julia@diku.dk>

Applied, thank you.

-- 
Jiri Kosina
SUSE Labs
