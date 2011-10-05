From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH] This adds support for keyboards on mid-2011 MacBook Airs
Date: Wed, 5 Oct 2011 19:43:47 +0200
Message-ID: <20111005174347.GA28287@polaris.bitmath.org>
References: <efc66984043a292faa31fee381945d18@jefferai.org>
 <20111005090735.GA6840@polaris.bitmath.org>
 <alpine.LNX.2.00.1110051103140.31654@pobox.suse.cz>
 <20111005094851.GA7261@polaris.bitmath.org>
 <alpine.LNX.2.00.1110051212320.31654@pobox.suse.cz>
 <4E8C66C2.6010503@jefferai.org>
 <20111005172857.GA2195@polaris.bitmath.org>
 <alpine.LNX.2.00.1110051927340.31654@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b12.telenor.se ([62.127.194.21]:56771 "EHLO
	smtprelay-b12.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935027Ab1JERhj (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Oct 2011 13:37:39 -0400
Received: from iph2.telenor.se (iph2.telenor.se [195.54.127.133])
	by smtprelay-b12.telenor.se (Postfix) with ESMTP id 10053EB45D
	for <linux-input@vger.kernel.org>; Wed,  5 Oct 2011 19:37:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1110051927340.31654@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Jeff Mitchell <jeff@jefferai.org>, linux-input@vger.kernel.org, jvdillon@gmail.com, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>

On Wed, Oct 05, 2011 at 07:28:31PM +0200, Jiri Kosina wrote:
> On Wed, 5 Oct 2011, Henrik Rydberg wrote:
> 
> > > To clear up an earlier point: AFAIK the new MBAs have the same keyboard
> > > layout as normal MacBooks and hence uses the same table. An earlier
> > > patch that was floating around added another table for the new MBAs but
> > > if you looked at the mappings it was the exact same table as the normal
> > > MacBook one.
> > 
> > I see. The current tree actually contains two identical tables. Yikes.
> > Using your patch would have prevented this, but it might be too late
> > now. If so, the (untested) patch below might fix things up. Does it
> > still work for you?
> 
> I actually already have the very similar patch in my tree ...

Identical, in fact. Doh! :-)

> I really hope for soonish resurrection of kernel.org to avoid this
> duplication of work ...

Hear, hear.

Cheers,
Henrik
