Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68AC443AB1;
	Tue,  4 Aug 2026 10:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785837757; cv=none; b=RCzKE5HT0w7N/ub5vIquxn3B6yclGWs9Eet/hBYHgZDLbJwrwt5LcD4tu2wvG+E5zIe+K55UIPgPKu2FpRuVz3AMaFgLJyA2YlXJr+VGPv2sKmJv39ldmnh2yV43MJSUfKtSAlwxg2IywGkKKa42JUIXL2tz1OSN2eyoLH8GgLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785837757; c=relaxed/simple;
	bh=Pz4mZ0gWIYkb32TdekD39kCxXjdpkuSdjjoDfL7FFfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rjcf3iF21JMK3Q/+vIF8PSmUz7RBbAAFZb9ASo3pDdkH+ySLWl4X9RmUFbaIMHF/tJ4gdEOn+MELGeQc/60CsOcBFabs7yJ8bdhgk1o/TrlE6HOgw3t6iQ1G5j+BLLXkh3iequIP0msb/SivNJ9cslixDbNbQmKel9J06ypVzAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ADLbrD9a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ADLbrD9a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC4561F000E9;
	Tue,  4 Aug 2026 10:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785837755;
	bh=VxjTd4DMfSlIiscaLQ7eIc5oumgImZjg2if2c59j51s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ADLbrD9ahdT6+9xEsuuWTS+XOzeA6R8XnMv708Wwm3fncdv/WZtIKoyCs+FpSUg3u
	 u9oUu9Eqewj4dEOTMX/w1c+y22KtGHnCYOKh1NDBiPfsfH+d0qIc4oPx/ef9IaLLJP
	 gofdPT+PA0I9PtMWcBBtYe8T9paX88MasQNubdTQ=
Date: Tue, 4 Aug 2026 12:02:19 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	"Wagenaar, C.C.J. (Chris)" <c.c.j.wagenaar@vu.nl>
Subject: Re: [PATCH] Input: evdev - sanitize event type index when fetching
 event masks
Message-ID: <2026080412-camping-fringe-8219@gregkh>
References: <anFCAfvxwXB5eJF1@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anFCAfvxwXB5eJF1@google.com>

On Mon, Aug 03, 2026 at 06:41:49PM -0700, Dmitry Torokhov wrote:
> The user-supplied event type index passed to EVIOCGMASK / EVIOCSMASK
> ioctls is used to index the static counts array in evdev_get_mask_cnt()
> and client evmasks array in evdev_get_mask().
> 
> While the event type is architecturally bounded by EV_CNT, speculative
> execution may mispredict bounds checks and perform out-of-bounds loads.
> 
> Sanitize the event type index in evdev_get_mask_cnt() branchlessly using
> array_index_mask_nospec(). This clamps the index to 0 for safe array
> access and forces the returned count to 0 speculatively when the index
> is out of bounds.
> 
> We do not need additional array_index_nospec() calls in evdev_get_mask()
> because evdev_get_mask_cnt() speculatively forces the count (and
> resulting xfer_size) to 0 for out-of-bounds types, preventing any
> speculative memory access to client evmasks array.
> 
> Reported-by: "Wagenaar, C.C.J. (Chris)" <c.c.j.wagenaar@vu.nl>
> Cc: stable@vger.kernel.org
> Assisted-by: Antigravity:gemini-3.6-flash
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/evdev.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
> index 5764c98b4f1f..796ac7ac2b8c 100644
> --- a/drivers/input/evdev.c
> +++ b/drivers/input/evdev.c
> @@ -21,6 +21,7 @@
>  #include <linux/init.h>
>  #include <linux/input/mt.h>
>  #include <linux/major.h>
> +#include <linux/nospec.h>
>  #include <linux/device.h>
>  #include <linux/cdev.h>
>  #include "input-compat.h"
> @@ -67,8 +68,10 @@ static size_t evdev_get_mask_cnt(unsigned int type)
>  		[EV_SND]	= SND_CNT,
>  		[EV_FF]		= FF_CNT,
>  	};
> +	unsigned long mask = array_index_mask_nospec(type, EV_CNT);
>  
> -	return (type < EV_CNT) ? counts[type] : 0;
> +	/* Returns 0 for out-of-bounds types, including speculatively */
> +	return counts[type & mask] & mask;
>  }
>  
>  /* requires the buffer lock to be held */
> -- 
> 2.55.0.629.g250fe7f194-goog
> 
> 
> -- 
> Dmitry

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
