From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [LKML] Re: [PATCH v3] ad7877: keep dma rx buffers in seperate
	cache lines
Date: Wed, 12 May 2010 00:35:45 -0400
Message-ID: <AANLkTine8JmtsUo3_z6Cwdgm3LINCkJ9jL21r9eQWRm8@mail.gmail.com>
References: <AANLkTimm7bOmIz2sdODgHwtCk26kdHgZt7PvceM6gjS3@mail.gmail.com>
	<522C1DF17AF50042AD8AE87F7887BD3D0163549554@exch.hq.tensilica.com>
	<20100512030350.GJ15903@laptop> <20100512122323J.fujita.tomonori@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f198.google.com ([209.85.211.198]:34171 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910Ab0ELEgH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 May 2010 00:36:07 -0400
In-Reply-To: <20100512122323J.fujita.tomonori@lab.ntt.co.jp>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: npiggin@suse.de, marc@tensilica.com, dmitry.torokhov@gmail.com, jw@emlix.com, cl@linux.com, penberg@cs.helsinki.fi, mpm@selenic.com, akpm@linux-foundation.org, os@emlix.com, Michael.Hennerich@analog.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, dg@emlix.com, osw@emlix.com, rientjes@google.com, dbrownell@users.sourceforge.net, grant.likely@secretlab.ca, chris@zankel.net, Piet.Delaney@tensilica.com

On Tue, May 11, 2010 at 23:23, FUJITA Tomonori wrote:
> Seems that kmalloc is not cacheline aligned on some architectures but
> they works. Probably, we might be just lucky because in general they
> allocate larger buffers than 64 for DMA via kmalloc and the buffers
> are aligned on the size?

i think the magic combo is:
 - DMA buffer is written to (receive)
 - some driver state is in the same cacheline as the DMA buffer
 - that driver state is used after the flush but before the DMA finishes
 - only on arches that need software cache coherency

so i could see this not being an obvious issue for many people
-mike
