From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: Re: [LKML] Re: [PATCH v3] ad7877: keep dma rx buffers in seperate
 cache lines
Date: Thu, 20 May 2010 13:42:51 +0900
Message-ID: <20100520134455W.fujita.tomonori@lab.ntt.co.jp>
References: <20100519135226.GZ2516@laptop>
	<20100519234049C.fujita.tomonori@lab.ntt.co.jp>
	<1274281117.6930.10190.camel@macbook.infradead.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from sh.osrg.net ([192.16.179.4]:41292 "EHLO sh.osrg.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752171Ab0ETEsu (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 20 May 2010 00:48:50 -0400
In-Reply-To: <1274281117.6930.10190.camel@macbook.infradead.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dwmw2@infradead.org
Cc: fujita.tomonori@lab.ntt.co.jp, npiggin@suse.de, jw@emlix.com, marc@tensilica.com, vapier.adi@gmail.com, dmitry.torokhov@gmail.com, cl@linux.com, penberg@cs.helsinki.fi, mpm@selenic.com, akpm@linux-foundation.org, os@emlix.com, Michael.Hennerich@analog.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, dg@emlix.com, osw@emlix.com, rientjes@google.com, dbrownell@users.sourceforge.net, grant.likely@secretlab.ca, chris@zankel.net, Piet.Delaney@tensilica.com

On Wed, 19 May 2010 15:58:37 +0100
David Woodhouse <dwmw2@infradead.org> wrote:

> On Wed, 2010-05-19 at 23:38 +0900, FUJITA Tomonori wrote:
> > 
> > > I don't think we need to hide the fact that some platforms have
> > > specific alignment restrictions for DMA. So if any drivers make use
> > > of the alignment, I see no problem with __dma_aligned.
> > 
> > IIRC, such was proposed several times:
> > 
> > http://www.mail-archive.com/linux-scsi@vger.kernel.org/msg12633.html
> > 
> > I guess that we agreed that it's better to tell driver writers to just
> > use kmalloc. 
> 
> Perhaps -- but only a few days ago in this thread, they were being
> advised to use ____cacheline_aligned instead!

Hmm, driver writers should read DMA-API and DMA-API-HOWTO docs.


> And for this case it really does seem to make sense to keep the buffer
> in the parent structure rather than allocating it separately. The DMA
> buffers are tiny and on cache-coherent architectures it's _much_ more
> efficient just to have them in the original structure and use
> __dma_aligned.

Yeah, I think that that's a valid point (which was also discussed in
the past). However, I tend to agree on:

http://lwn.net/Articles/2270/

I think that forcing kmalloc is not that bad. Surely more code, but
the performance is not notable in most cases. IMHO, exporting cache
line thing everywhere is worse than it.
