From: Johannes Weiner <jw@emlix.com>
Subject: Re: [LKML] Re: [PATCH v3] ad7877: keep dma rx buffers in seperate
 cache lines
Date: Wed, 12 May 2010 12:36:58 +0200
Message-ID: <20100512103658.GB2635@emlix.com>
References: <AANLkTimm7bOmIz2sdODgHwtCk26kdHgZt7PvceM6gjS3@mail.gmail.com>
 <522C1DF17AF50042AD8AE87F7887BD3D0163549554@exch.hq.tensilica.com>
 <20100512030350.GJ15903@laptop>
 <20100512122323J.fujita.tomonori@lab.ntt.co.jp>
 <AANLkTine8JmtsUo3_z6Cwdgm3LINCkJ9jL21r9eQWRm8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.emlix.com ([193.175.82.87]:36578 "EHLO mx1.emlix.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751669Ab0ELKiB (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 12 May 2010 06:38:01 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTine8JmtsUo3_z6Cwdgm3LINCkJ9jL21r9eQWRm8@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, npiggin@suse.de, marc@tensilica.com, dmitry.torokhov@gmail.com, cl@linux.com, penberg@cs.helsinki.fi, mpm@selenic.com, akpm@linux-foundation.org, os@emlix.com, Michael.Hennerich@analog.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, dg@emlix.com, osw@emlix.com, rientjes@google.com, dbrownell@users.sourceforge.net, grant.likely@secretlab.ca, chris@zankel.net, Piet.Delaney@tensilica.com

On Wed, May 12, 2010 at 12:35:45AM -0400, Mike Frysinger wrote:
> On Tue, May 11, 2010 at 23:23, FUJITA Tomonori wrote:
> > Seems that kmalloc is not cacheline aligned on some architectures but
> > they works. Probably, we might be just lucky because in general they
> > allocate larger buffers than 64 for DMA via kmalloc and the buffers
> > are aligned on the size?
> 
> i think the magic combo is:
>  - DMA buffer is written to (receive)

Check.

>  - some driver state is in the same cacheline as the DMA buffer
>  - that driver state is used after the flush but before the DMA finishes

The kmalloc caches are system-wide.  Any other kmalloc(samesize) user
could interfer when touching its object between dma_map_single() on
the neighbor object and the end of the transfer.

>  - only on arches that need software cache coherency
> 
> so i could see this not being an obvious issue for many people
> -mike
