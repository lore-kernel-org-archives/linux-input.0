From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] This adds support for keyboards on mid-2011 MacBook
 Airs
Date: Wed, 5 Oct 2011 19:28:31 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1110051927340.31654@pobox.suse.cz>
References: <efc66984043a292faa31fee381945d18@jefferai.org> <20111005090735.GA6840@polaris.bitmath.org> <alpine.LNX.2.00.1110051103140.31654@pobox.suse.cz> <20111005094851.GA7261@polaris.bitmath.org> <alpine.LNX.2.00.1110051212320.31654@pobox.suse.cz>
 <4E8C66C2.6010503@jefferai.org> <20111005172857.GA2195@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:34401 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934481Ab1JER2e (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 5 Oct 2011 13:28:34 -0400
In-Reply-To: <20111005172857.GA2195@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jeff Mitchell <jeff@jefferai.org>, linux-input@vger.kernel.org, jvdillon@gmail.com, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>

On Wed, 5 Oct 2011, Henrik Rydberg wrote:

> > To clear up an earlier point: AFAIK the new MBAs have the same keyboard
> > layout as normal MacBooks and hence uses the same table. An earlier
> > patch that was floating around added another table for the new MBAs but
> > if you looked at the mappings it was the exact same table as the normal
> > MacBook one.
> 
> I see. The current tree actually contains two identical tables. Yikes.
> Using your patch would have prevented this, but it might be too late
> now. If so, the (untested) patch below might fix things up. Does it
> still work for you?

I actually already have the very similar patch in my tree ... I really 
hope for soonish resurrection of kernel.org to avoid this duplication of 
work ...

You can check my tree on twin.jikos.cz to see the changes though.

Thanks guys,

-- 
Jiri Kosina
SUSE Labs
