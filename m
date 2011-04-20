From: Minchan Kim <minchan.kim@gmail.com>
Subject: Re: [HELP] OOM:Page allocation fragment issue
Date: Wed, 20 Apr 2011 14:49:23 +0900
Message-ID: <BANLkTimLmOfCruREX8-FW-JVOgmXXbbfWg@mail.gmail.com>
References: <BANLkTinOV=tXcC-XipPzUhs-yODjnOu=8g@mail.gmail.com>
	<BANLkTik_wKoJ43XBPWd4tb9hMds-_7aVCg@mail.gmail.com>
	<BANLkTinCq22_JckA9XfOjYh3pozUWW1V1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38717 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617Ab1DTFtY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Apr 2011 01:49:24 -0400
Received: by iwn34 with SMTP id 34so334787iwn.19
        for <linux-input@vger.kernel.org>; Tue, 19 Apr 2011 22:49:23 -0700 (PDT)
In-Reply-To: <BANLkTinCq22_JckA9XfOjYh3pozUWW1V1Q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: TAO HU <tghk48@motorola.com>
Cc: linux-mm@kvack.org, linux-input@vger.kernel.org, Christoph Lameter <cl@linux-foundation.org>, Pekka Enberg <penberg@cs.helsinki.fi>, Matt Mackall <mpm@selenic.com>

On Wed, Apr 20, 2011 at 2:40 PM, TAO HU <tghk48@motorola.com> wrote:
> Hi, Minchan Kim
>
> Thanks for your analysis and suggestion!
>
> I'm not familiar with COMPACTION.

It's rather recent new feature of mm.

> Does it work with ARM?

Logically, It doesn't depends on architecture.
But I am not sure because ARM's ugly pfn_valid hole in sparsemem.
(I don't remember it well but there was some issue at that time)
I guess if you use FLATMEM, it works well.
If you have a trouble, please report it.

> Does it require specific MMU configuration? Notice that it depends on
> HUGETLB_PAGE
>

It doesn't depends on hugetlb. It is fixed [33a938774fdb: mm:
compaction: don't depend on HUGETLB_PAGE] recently. You can backport
it.

Thanks.

-- 
Kind regards,
Minchan Kim
