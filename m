Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444473546DA;
	Thu, 21 May 2026 15:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779375781; cv=none; b=afGy7nTPlDhM6+sx6yGo1aWSK1lMHvHwjyRxXjzVSbtdGtyYOo0OYtYrScnyWhqGgM5Wzr7Zim4k2G5Y3kQNVFco0hgYBn45A34/X3kmPShhV5eoZLKN6eGbZJkhMH4x3HBJ+WIcdAk62+0kz5nL6bBerQ+2nZGylkkAqya13QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779375781; c=relaxed/simple;
	bh=CJRl0ToR0Q9ybY3jf4ZzFRmnxOLsvV8exSAf24M4hfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VpGLThW4gQUscL2s1gMASl2rZCO4GfiPCO3XhYYsy1/uybaSs+V08g4tcX8DFjKWBVx9Bv/j2o6Y+GZAe4NtUvIif68smpRfaqCjZqTpY+BIhvyKChJNybk+nlaIPIGgqGryhIwS0dfEPg/b1O2NzkVRTlPXITWwa7OXj7NNuD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqA52FhP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqA52FhP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C381D1F000E9;
	Thu, 21 May 2026 15:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779375780;
	bh=/cWuyUheiqgVupDqdADyXeMh2kdtlX/VJM8MCrldY8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DqA52FhPDpfGGkoLdXFCouBK+prDQoGjKp+tqS+/5qpCRS6AYLFrFLjMCVMcWnin8
	 ryTT5s0hV7vkvd6x4WrhFMIlhNEjI2esR2+9aDBjGB9Tjg2kYSPbJemWlXfuKLtOoy
	 h/w+kVZr7+xLMCfZOaiVfyKIbDfWQ8P7N5M5D7nD4Sy9T1un3XLKuNv/7KBP38a8Qs
	 X0gNbRpgm48/GGJNVqro5QIrihs/lstgsmcMw0m0hJkXwG753q1CCxWnSQL1nnwtHS
	 zcRejn0GNyBqMaCgAQBSqb9uTPEKV+MomDW27g4ARiJr7UzVjXcU2ennYwlNUTqaMg
	 y75OstU6ua0kg==
Date: Thu, 21 May 2026 17:02:56 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Kees Cook <kees@kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: wacom_w8001 - avoid double release of pen input
 device
Message-ID: <ag8ehxhfrGMPcakE@beelink>
References: <20260430071311.451957-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430071311.451957-1-lgs201920130244@gmail.com>

On Apr 30 2026, Guangshuo Li wrote:
> When registering the touch input device fails after the pen input device
> has already been registered, w8001_connect() jumps to fail4 and
> unregisters w8001->pen_dev.  It then falls through to fail1 where
> input_dev_pen is passed to input_free_device().
> 
> Once input_register_device() has succeeded, the device must be released
> with input_unregister_device(), and input_free_device() must not be used
> on the same object afterwards.  Since input_dev_pen still aliases
> w8001->pen_dev, this can result in a use-after-free or kref underflow.
> 
> Clear the local and container aliases after unregistering the pen device
> so that the common cleanup path does not try to free it again.
> 
> This issue was found by a static analysis tool I am developing.
> 
> Fixes: e0361b70175f0 ("Input: wacom_w8001 - split the touch and pen devices into two devices")
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Reviewed-by: Benjamin Tissoires <bentiss@kernel.org>

Cheers,
Benjamin

> ---
>  drivers/input/touchscreen/wacom_w8001.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/touchscreen/wacom_w8001.c
> index 45930d731873..a3b283c59cdd 100644
> --- a/drivers/input/touchscreen/wacom_w8001.c
> +++ b/drivers/input/touchscreen/wacom_w8001.c
> @@ -665,8 +665,11 @@ static int w8001_connect(struct serio *serio, struct serio_driver *drv)
>  	return 0;
>  
>  fail4:
> -	if (w8001->pen_dev)
> +	if (w8001->pen_dev) {
>  		input_unregister_device(w8001->pen_dev);
> +		input_dev_pen = NULL;
> +		w8001->pen_dev = NULL;
> +	}
>  fail3:
>  	serio_close(serio);
>  fail2:
> -- 
> 2.43.0
> 
> 
