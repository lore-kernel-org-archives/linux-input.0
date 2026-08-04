Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B8C2E22B5
	for <linux-input@vger.kernel.org>; Tue,  4 Aug 2026 04:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785817110; cv=none; b=lBHrWYgg15DY8VJpKexm8hFWv1uxUeCKaPkvEaL9OBkM0q+a4i+eQcG9afwqG+MJgWRKN0u7EMu+ymO12xVzG5v1hhdlFChl2fIov8nP2pQ9ZhRhAw+SEThB+uBL0cjsmNrdW32bLA5QYypYWsIqUl9Am2/K5N6FVbcSQnzTI6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785817110; c=relaxed/simple;
	bh=Pzc+stFIC47bcug9qLJKtKBL7CSfTEjOdrZmzZctNpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OiTPshDJIX/0ULlI3o7hh2vUdO+o5/ob42YinpsIbgu3mVxA5C0k7mrTuXwn/ZuVD9uMXYVrBiUFaa97DaKg03TM6ZgWFzb95vk+/uDd0B9xWHXCHvuw+9HtnqOd/IQJMUMREjR0azpC0B/TAVgey6mlY0qn6lJma21t14ST3SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nuCFP+u+; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nuCFP+u+"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38deea72eebso3938957a91.1
        for <linux-input@vger.kernel.org>; Mon, 03 Aug 2026 21:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785817108; x=1786421908; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HNpfIZ0OfydC6fKax55kUfhD/gOfTNbtFad2cCOF1NQ=;
        b=nuCFP+u+wcAdadL2TIyJBLawPW0lAhOfn5XHEoOiTK9xYDqPrMPZE7eps6eDI2harx
         jjT7KyeS5rtun/nrdKaxlvMXVEPeKHM9kzGYntdbXZAYLrIh+nRN9VzChCiVoI8J2WiU
         /58EUMB/WU2S5YBm3cIXk+gaNmJRprjfXJ7NcIUBtdcAPJQ9nfWmi8IhWpljIN++J2Z0
         TzXMgLaR1dl5fJiCVJhFk/VxZ/Qf8Ju7a82Nwh2s30jZX2LCvIK6h63FxBfpT4JbQSix
         ge1BXyE6S/0en5RtYpDE2F52DDs0M58f2pyxciSpLz1SEcyDHmd/PUgFdU53wj/GMK20
         ErTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785817108; x=1786421908;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HNpfIZ0OfydC6fKax55kUfhD/gOfTNbtFad2cCOF1NQ=;
        b=hbg0NwNb/h9iXi4egcTfTe2/W0+mwV9fJx88LLxunba9bBwZIGx0SjwDP1+DUtQRT9
         qDQbI0xlAtq+L5acP04EJztH5Xd7gLTvSD37LU9e6G3x8ZDAd3NCCoMcK3pGhCO1skrv
         bX3EXaJL0gZCk46vrSEoQk825Y+phSsHusTFuYSDo+aslnugILLK91btRfkXMAOkFDBr
         TzGOX+81Dr6vRRb1gEKJUwqHC6b2exiDCNli4py0rwvhKSJA44sqPoHJAy5H8C+oH+g1
         LtsntQTKyt1/LAZIc29m9rurPetusQYBwwXLNaqwSec89H9WNJHKw6v9jg/LdnrybSLm
         zfHQ==
X-Gm-Message-State: AOJu0Yzfq4xHHB+LG6SmJnvAX2T7siIyBGMcaxkk2Kz5Q8GjXA+2VZMf
	ZGrEA6QgpNCrr4MzzAIKSBcvAQBSDyPikFbcyG7SyaMAE0kWUXlqKHO6
X-Gm-Gg: AR+sD11KMBfdrGmOSa3UMA0DCkRz8rWpBi3s9TrEecOdVnqY2LKNgsUN0uqpGFcPAlA
	QqNzrzK95N7zNcT6DcJOqgc3lQyhHDrlZWxJEoWXcjJsbUepwK/Uzmyp2HGXDBUtcG2WrxfD58z
	FEg5UZtBwLfsL9ucrjPpTPKSeD97VjXqRIXtKVKrvbiMX0OCOiB6tvrWEimwpxwPM+C+7poxHbm
	kvnUOtViwBbOpWsusZXnAMWQbiwUKJLdAXnx14ExkKwYhVWcHkUFwvZtsTDnw2WmKMXs7b9imjx
	tS6Ufyfm8fAdmQZptSxksQYBR7NQM5WYH2QZkuJ9VsDQlbFVovYhCArCfFEWoU9hTzaSW04/s0T
	wpA42sE+OdWCm+R2gD1afarXZXiLkVY4x+p82Ma5IknjfLswyAPayGdRls5LHmB69Xulwu2xJKt
	PiLT6dTbBZd6b/FKBImDGVaSiepFFxkLzBz+ysya69PnyHgYZ/O1NhBQfrhnanvUzCU4gG7vvZF
	lMCVDPsbe6RLgRZ6fUKPfsKtrrTxg==
X-Received: by 2002:a17:90b:3985:b0:38e:9045:babe with SMTP id 98e67ed59e1d1-38fbc4053d7mr10826936a91.7.1785817108418;
        Mon, 03 Aug 2026 21:18:28 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:d109:cdba:8a20:74ad])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e04491dsm58433183eec.16.2026.08.03.21.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 21:18:27 -0700 (PDT)
Date: Mon, 3 Aug 2026 21:18:24 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org
Subject: Re: [PATCH] Input: evdev - sanitize event type index when fetching
 event masks
Message-ID: <anFmI06p-i0vusxe@google.com>
References: <anFCAfvxwXB5eJF1@google.com>
 <20260804015414.E04CA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804015414.E04CA1F000E9@smtp.kernel.org>

On Tue, Aug 04, 2026 at 01:54:13AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Incomplete Spectre v1 mitigation due to misunderstanding of speculative execution on branches.
> --
> 
> --- Patch [1]: [PATCH] Input: evdev - sanitize event type index when fetching event masks ---
> commit e9eb78cd8dbba1d32ef31f1eec9a5c00e54b5aad
> Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> Input: evdev - sanitize event type index when fetching event masks
> 
> This commit uses array_index_mask_nospec() in evdev_get_mask_cnt() to clamp 
> out-of-bounds event types to 0. It asserts that this is sufficient to prevent 
> speculative out-of-bounds memory accesses in functions like evdev_get_mask() 
> because the returned count is speculatively forced to 0.
> 
> > We do not need additional array_index_nospec() calls in evdev_get_mask()
> > because evdev_get_mask_cnt() speculatively forces the count (and
> > resulting xfer_size) to 0 for out-of-bounds types, preventing any
> > speculative memory access to client evmasks array.
> 
> [Severity: High]
> This is a pre-existing issue, but does relying on the returned count being 0 
> fully prevent speculative out-of-bounds accesses in callers like 
> evdev_get_mask() and evdev_set_mask()?
> 
> When CPU branch predictors mispredict the conditions checking the count, they
> do not wait for the condition to evaluate. 
> 
> For example, if the if (cnt > 0) branch in evdev_get_mask() is mispredicted:
> 
> drivers/input/evdev.c:evdev_get_mask() {
>     ...
>     cnt = evdev_get_mask_cnt(type);
>     ...
>     if (cnt > 0) {
>         mask = client->evmasks[type];
>     ...
> }
> 
> The branch predictor will speculatively execute the block using the 
> original, unclamped type variable, performing an out-of-bounds read on 
> client->evmasks[type]. The retrieved pointer is then accessed by 
> bits_to_user().

No it will not because xfer_size will be 0 and bits_to_user
(copy_to_user) will not dereference the pointer at all.

> 
> A similar pattern exists in evdev_set_mask(), where a mispredicted if (!cnt) 
> branch can lead to using the unclamped type:
> 
> drivers/input/evdev.c:evdev_set_mask() {
>     ...
>     cnt = evdev_get_mask_cnt(type);
>     if (!cnt)
>         return 0;
>     ...
>     oldmask = client->evmasks[type];
>     ...
>     bitmap_free(oldmask);
> }
> 
> The speculative read of oldmask is followed by a dereference in bitmap_free(),
> which creates an exploitable side-channel gadget.

kfree() can not serve as a side-channel gadget. Additionally there are
speculation barriers in copy_from_user() and when taking the spinlock.

> 
> This pattern also appears in __evdev_is_filtered(). A mispredicted bounds 
> check can lead to speculative out-of-bounds accesses for test_bit(type, mask) 
> or mask = client->evmasks[type].

This is internal kernel function and is not user-controlled.

> 
> Do we still need to explicitly use array_index_nospec(type, EV_CNT) inside
> these caller functions to prevent the unclamped type from being used during 
> speculative execution?

So no.

Thanks.

-- 
Dmitry
