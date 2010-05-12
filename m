From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [LKML] Re: [PATCH v3] ad7877: keep dma rx buffers in seperate
	cache lines
Date: Wed, 12 May 2010 10:36:39 -0400
Message-ID: <AANLkTin2Kz0rdecwMlu6DU5y4b_okl4gdXCcF2c1ZlT4@mail.gmail.com>
References: <AANLkTimm7bOmIz2sdODgHwtCk26kdHgZt7PvceM6gjS3@mail.gmail.com>
	<522C1DF17AF50042AD8AE87F7887BD3D0163549554@exch.hq.tensilica.com>
	<20100512030350.GJ15903@laptop> <20100512122323J.fujita.tomonori@lab.ntt.co.jp>
	<AANLkTine8JmtsUo3_z6Cwdgm3LINCkJ9jL21r9eQWRm8@mail.gmail.com>
	<522C1DF17AF50042AD8AE87F7887BD3D01635495D3@exch.hq.tensilica.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:49715 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753901Ab0ELOhA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 May 2010 10:37:00 -0400
In-Reply-To: <522C1DF17AF50042AD8AE87F7887BD3D01635495D3@exch.hq.tensilica.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marc Gauthier <marc@tensilica.com>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, "npiggin@suse.de" <npiggin@suse.de>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "jw@emlix.com" <jw@emlix.com>, "cl@linux.com" <cl@linux.com>, "penberg@cs.helsinki.fi" <penberg@cs.helsinki.fi>, "mpm@selenic.com" <mpm@selenic.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "os@emlix.com" <os@emlix.com>, "Michael.Hennerich@analog.com" <Michael.Hennerich@analog.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dg@emlix.com" <dg@emlix.com>, "osw@emlix.com" <osw@emlix.com>, "rientjes@google.com" <rientjes@google.com>, "dbrownell@users.sourceforge.net" <dbrownell@users.sourceforge.net>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "chris@zankel.net" <chris@zankel.net>, Piet Delaney <Piet.Delaney@tensilica.c>

On Wed, May 12, 2010 at 08:35, Marc Gauthier wrote:
> Mike Frysinger wrote:
>> On Tue, May 11, 2010 at 23:23, FUJITA Tomonori wrote:
>>> Seems that kmalloc is not cacheline aligned on some architectures b=
ut
>>> they works. Probably, we might be just lucky because in general the=
y
>>> allocate larger buffers than 64 for DMA via kmalloc and the buffers
>>> are aligned on the size?
>>
>> i think the magic combo is:
>> =C2=A0- DMA buffer is written to (receive)
> [...]
>> =C2=A0- only on arches that need software cache coherency
>
> In particular, when the architecture port uses cache invalidates that
> throw away dirty lines. =C2=A0They're equivalent to writing old data =
to a
> cache line, so an unrelated kmalloc allocation in the same cache line
> gets corrupted.

true; i was thinking of the Blackfin implementation that only has a
=46LUSH+INV insn (i complain about the lack of a pure INV insn every no=
w
and again)
-mike
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
