Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F53C4332F
	for <linux-input@archiver.kernel.org>; Sat, 23 Apr 2022 01:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiDWB2i (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 22 Apr 2022 21:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiDWB2i (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 22 Apr 2022 21:28:38 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACA8249302;
        Fri, 22 Apr 2022 18:25:42 -0700 (PDT)
Date:   Fri, 22 Apr 2022 18:25:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1650677140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=12Aii0jWw/m/a/Ftf0Ul3RDKgJHLmfcJr6TYwlkHk18=;
        b=LgGXXyUCPiF5DAduAqYEHY34GgdGKvApqAY8LkDtSQR+EirE20cxkNSXZLjhg0cfEgTTqZ
        jHVO/j1Pj8LMS1RXoHtPVkftzxQg1QhJpCDs7Xq0NmxMkLS3qx0Fo373cMjI3Nqf7HJfNk
        yMUgGGzRsAee2PuBVAKxuI8Bbt458y0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hch@lst.de,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-input@vger.kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v2 8/8] mm: Centralize & improve oom reporting in
 show_mem.c
Message-ID: <YmNVjiVv0fKXYjIF@carbon>
References: <20220421234837.3629927-1-kent.overstreet@gmail.com>
 <20220421234837.3629927-14-kent.overstreet@gmail.com>
 <YmKma/1WUvjjbcO4@dhcp22.suse.cz>
 <YmLFPJTyoE4GYWp4@carbon>
 <20220422234820.plusgyixgybebfmi@moria.home.lan>
 <YmNH/fh8OwTJ6ASC@carbon>
 <20220423004607.q4lbz2mplkhlbyhm@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220423004607.q4lbz2mplkhlbyhm@moria.home.lan>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Fri, Apr 22, 2022 at 08:46:07PM -0400, Kent Overstreet wrote:
> On Fri, Apr 22, 2022 at 05:27:41PM -0700, Roman Gushchin wrote:
> > You're scanning over a small portion of all shrinker lists (on a machine with
> > cgroups), so the top-10 list has little value.
> > Global ->count_objects() return the number of objects on the system/root_mem_cgroup
> > level, not the shrinker's total.
> 
> Not quite following what you're saying here...?
> 
> If you're complaining that my current top-10-shrinker report isn't memcg aware,
> that's valid - I can fix that.

For memcg-aware shrinkers each memcg has it's own LRU (per node).
If you want to print top-10 system-wide lists you need to call
->count_objects() for each shrinker for each memcg for each node.
It's quite a lot of work for an oom context.

> 
> > > In my experience, it's rare to be _so_ out of memory that small kmalloc
> > > allocations are failing - we'll be triggering the show_mem() report before that
> > > happens.
> > 
> > I agree. However the OOM killer _has_ to make the progress even in such rare
> > circumstances.
> 
> Oh, and the concern is allocator recursion? Yeah, that's a good point.

Yes, but not the only problem.

> 
> Do you know if using memalloc_noreclaim_(save|restore) is sufficient for that,
> or do we want GFP_ATOMIC? I'm already using GFP_ATOMIC for allocations when we
> generate the report on slabs, since we're taking the slab mutex there.

And this is another problem: grabbing _any_ locks from the oom context is asking
for trouble: you can potentially enter the oom path doing any allocation, so
now you have to check that no allocations are ever made holding this lock.
And I'm not aware of any reasonable way to test it, so most likely it ends up
introducing some very subtle bags, which will be triggered once a year.

Thanks!
