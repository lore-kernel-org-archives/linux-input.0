From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [LKML] Re: [PATCH v3] ad7877: keep dma rx buffers in seperate
 cache lines
Date: Wed, 12 May 2010 11:11:21 -0700
Message-ID: <20100512181121.GA29366@core.coreip.homeip.net>
References: <20100512030350.GJ15903@laptop>
 <20100512122323J.fujita.tomonori@lab.ntt.co.jp>
 <AANLkTine8JmtsUo3_z6Cwdgm3LINCkJ9jL21r9eQWRm8@mail.gmail.com>
 <20100512142904Z.fujita.tomonori@lab.ntt.co.jp>
 <AANLkTinztzZMBaSG4sTqPXw4qNjmkK6gI1KOYIDIOVVx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:63488 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751849Ab0ELSLm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 May 2010 14:11:42 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTinztzZMBaSG4sTqPXw4qNjmkK6gI1KOYIDIOVVx@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, npiggin@suse.de, marc@tensilica.com, jw@emlix.com, cl@linux.com, penberg@cs.helsinki.fi, mpm@selenic.com, akpm@linux-foundation.org, os@emlix.com, Michael.Hennerich@analog.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, dg@emlix.com, osw@emlix.com, rientjes@google.com, dbrownell@users.sourceforge.net, grant.likely@secretlab.ca, chris@zankel.net, Piet.Delaney@tensilica.com

On Wed, May 12, 2010 at 10:37:05AM -0400, Mike Frysinger wrote:
> On Wed, May 12, 2010 at 01:28, FUJITA Tomonori wrote:
> > I guess that it would be better to start a new thread about this issue.
> 
> will do

In the mean time I will be applying the version of the patch with
___cacheline_aligned and buffers at the end, 'k?

-- 
Dmitry
