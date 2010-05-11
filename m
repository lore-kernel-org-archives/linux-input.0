From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] ad7877: keep dma rx buffers in seperate cache lines
Date: Tue, 11 May 2010 09:52:28 -0700
Message-ID: <20100511165228.GC7396@core.coreip.homeip.net>
References: <1273487642-2169-1-git-send-email-os@emlix.com>
 <1273488154-2993-1-git-send-email-os@emlix.com>
 <20100510142225.4bf215ef.akpm@linux-foundation.org>
 <20100511060547.GA9644@core.coreip.homeip.net>
 <AANLkTikA9s6lpO2uDuIup8BwGOYYHQ9yQxS36PBSIttX@mail.gmail.com>
 <20100511062110.GB9644@core.coreip.homeip.net>
 <AANLkTiktu7N5IXknkkJ9D5L4z5plhuGvD45IVqJm9zG1@mail.gmail.com>
 <20100511063309.GC9644@core.coreip.homeip.net>
 <y2k84144f021005102342m18bce930g53599c9112565f78@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f204.google.com ([209.85.222.204]:37508 "EHLO
	mail-pz0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155Ab0EKQwg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 May 2010 12:52:36 -0400
Content-Disposition: inline
In-Reply-To: <y2k84144f021005102342m18bce930g53599c9112565f78@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Mike Frysinger <vapier.adi@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Oskar Schirmer <os@emlix.com>, Michael Hennerich <Michael.Hennerich@analog.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Daniel =?iso-8859-1?Q?Gl=F6ckner?= <dg@emlix.com>, Oliver Schneidewind <osw@emlix.com>, Johannes Weiner <jw@emlix.com>, Christoph Lameter <cl@linux-foundation.org>, Nick Piggin <npiggin@suse.de>, David Rientjes <rientjes@google.com>, Matt Mackall <mpm@selenic.com>

On Tue, May 11, 2010 at 09:42:03AM +0300, Pekka Enberg wrote:
> Hi Dmitry,
> 
> On Tue, May 11, 2010 at 9:33 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >> what guarantee exactly do you have for that statement ?
> >
> > The data is kmalloced, kmalloc aligns on cacheline boundary AFAIK which
> > means that next kmalloc data chunk will not share "our" cacheline.
> 
> No, there are no such guarantees. kmalloc() aligns on
> ARCH_KMALLOC_MINALIGN or ARCH_SLAB_MINALIGN depending on which is
> bigger but beyond that, there are no guarantees. You can, of course,
> use kmem_cache_create() with SLAB_HWCACHE_ALIGN to align on cacheline
> boundary.
> 

The architectures that we are trying to deal with here should be forcing
kmalloc to the cache boundary already though - otherwise they would not
be able to used kmalloced memory for DMA buffers at all. Or am I utterly
lost here?

-- 
Dmitry
