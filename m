From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [LKML] Re: [PATCH v3] ad7877: keep dma rx buffers in seperate
	cache lines
Date: Wed, 12 May 2010 10:37:05 -0400
Message-ID: <AANLkTinztzZMBaSG4sTqPXw4qNjmkK6gI1KOYIDIOVVx@mail.gmail.com>
References: <20100512030350.GJ15903@laptop> <20100512122323J.fujita.tomonori@lab.ntt.co.jp>
	<AANLkTine8JmtsUo3_z6Cwdgm3LINCkJ9jL21r9eQWRm8@mail.gmail.com>
	<20100512142904Z.fujita.tomonori@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:49715 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755730Ab0ELOh3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 May 2010 10:37:29 -0400
In-Reply-To: <20100512142904Z.fujita.tomonori@lab.ntt.co.jp>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: npiggin@suse.de, marc@tensilica.com, dmitry.torokhov@gmail.com, jw@emlix.com, cl@linux.com, penberg@cs.helsinki.fi, mpm@selenic.com, akpm@linux-foundation.org, os@emlix.com, Michael.Hennerich@analog.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, dg@emlix.com, osw@emlix.com, rientjes@google.com, dbrownell@users.sourceforge.net, grant.likely@secretlab.ca, chris@zankel.net, Piet.Delaney@tensilica.com

On Wed, May 12, 2010 at 01:28, FUJITA Tomonori wrote:
> I guess that it would be better to start a new thread about this issue.

will do
-mike
