From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [LKML] Re: [PATCH v3] ad7877: keep dma rx buffers in seperate
	cache lines
Date: Wed, 12 May 2010 14:28:34 -0400
Message-ID: <AANLkTimi3hZ_v8bKDcNPqXzTz2r9LputwmN47uhsLf6V@mail.gmail.com>
References: <20100512030350.GJ15903@laptop> <20100512122323J.fujita.tomonori@lab.ntt.co.jp>
	<AANLkTine8JmtsUo3_z6Cwdgm3LINCkJ9jL21r9eQWRm8@mail.gmail.com>
	<20100512142904Z.fujita.tomonori@lab.ntt.co.jp> <AANLkTinztzZMBaSG4sTqPXw4qNjmkK6gI1KOYIDIOVVx@mail.gmail.com>
	<20100512181121.GA29366@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:42232 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754692Ab0ELS24 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 May 2010 14:28:56 -0400
In-Reply-To: <20100512181121.GA29366@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, npiggin@suse.de, marc@tensilica.com, jw@emlix.com, cl@linux.com, penberg@cs.helsinki.fi, mpm@selenic.com, akpm@linux-foundation.org, os@emlix.com, Michael.Hennerich@analog.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, dg@emlix.com, osw@emlix.com, rientjes@google.com, dbrownell@users.sourceforge.net, grant.likely@secretlab.ca, chris@zankel.net, Piet.Delaney@tensilica.com

On Wed, May 12, 2010 at 14:11, Dmitry Torokhov wrote:
> On Wed, May 12, 2010 at 10:37:05AM -0400, Mike Frysinger wrote:
>> On Wed, May 12, 2010 at 01:28, FUJITA Tomonori wrote:
>> > I guess that it would be better to start a new thread about this issue.
>>
>> will do
>
> In the mean time I will be applying the version of the patch with
> ___cacheline_aligned and buffers at the end, 'k?

i dont see a problem with it, and regardless of the route we choose to
go with kmalloc(), this change will be needed ...
-mike
