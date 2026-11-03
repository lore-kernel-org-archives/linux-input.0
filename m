Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793677343;
	b=mjeju4MRQTeW/U7AKHRI3N/CdNqDFZvdmPUJuxYtiwU8mKkLk7AyW/tGDGwiKLYeEVOK
	 8n/hAv/7xyio/rzF6TUBO0B411S8Su42ek7V/ZrcSm+g9qrUf6Q9L/PH20a60tTtG47Rx
	 XeGqZjju8CqTNGK81rbaqCjXB06yinQlmO6JdjronFQn4ZeFlcBuhr6OF2W0hf52Pi5U5
	 QSdD+JhnQ8OdDueYuCHiBbJaZ0m1WDmFzgif8yENgg+bk2+fW2GWtHp1nZBo6fpo6HQff
	 uURQo1t38/eJiIimxVVG+71Etbflwi+snySNJBRExeDmJE6l/p+BBVk88ITRHh6dXjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793677343;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=9nkGRrHXD/BoXl+3MQj+4Zo1U2lVyFqfiYCzSdzJCpo=;
	b=MPRsib6RP5bkTcPhU+uHKLxyt8T+CYg/trI1u5TFMl46w1IQ+vmO2467aevXBqut4ILi
	 CFefP0ByNCpEuPGZK6o+HVklyoiuOHhZl4o5FLYMQCs89RP1FsdlahLlyDVBnan2eJA4x
	 mpyl6sFA6zyieG3VcdZZoih0coflVeSpkHqQmPvHptrCbqNDXVmIAq1Qtv5DVgCRk/p5Q
	 tiRZhC6VDJTjKt582s3p2cgyxQBJj0KA3ODurzMZQROd46jZorpT5vJBbddSQBy13GBT5
	 6XSq9WPceZVQxzccfxa60nmGLpwPPVFwdfLCIaL3zXZZBOnzf45z13XR9kDsYtrstCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pmyHqbB4;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A08606A326
	for <linux-input@vger.kernel.org>; Tue,  3 Nov 2026 03:42:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1A08606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pmyHqbB4
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-14394530ec6so4832500c88.1
        for <linux-input@vger.kernel.org>; Mon, 02 Nov 2026 19:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793677342; x=1794282142; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9nkGRrHXD/BoXl+3MQj+4Zo1U2lVyFqfiYCzSdzJCpo=;
        b=pmyHqbB4phFEM9rB6LTdXiyDtOxPEHXzN9nbN0SL5w5gfwAmVa69eam3dUz1uGh46r
         SCRGXzRfQOnSI6+2tVlOLnUHs6B4GN653gnoy0OOvJmRAfFU2bWR2AuIFEYJYaxGOfPw
         F5pes3mhc0UJH9nfteaIEYhLBXTXrS+Im1ony2LGmlSo6PbEC5Lh1a3Ik1aSXTfBcFE3
         cz8S9m10aMTORCCIb+oBofUfywqEk6tDTeDPhd1Igi1ESzW00MqAW4W027zXnig06Vbe
         5JgceV7h4RlzAsZMplZHgztrlwyOahhI5GaefTixttCD9ThWiuX9iFF3h2mSxWog6zZg
         bGvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793677342; x=1794282142;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9nkGRrHXD/BoXl+3MQj+4Zo1U2lVyFqfiYCzSdzJCpo=;
        b=DHQJ339maiCm3YnTMog5x1jMpyMgeLkFejdp8OPCy1ZB9Suf0plwpJ5Lirz0pX4n/U
         r2IDMufEhc2XJw48p312oucheCrDKKZPDrD4EuCnvUs80M+5BS+BBAAGsd0wcDdOpmH/
         VfxLq0Owx6wfiOub89NxMQwEN7m5zQQ/bWxH3WwyKnoGQWGjsLwDmlptOrIhE5GbwDmX
         y+x0tLQjOZz1+f64v1Z596T2gOAT13euvzkdnMyzcWMrVYWt0jF16m4X6AQsjRvNeAE3
         63JizfjTHs/0sMQhunNwvUfN7IIgSaKYNys/icIpA0/RGxrKUS7aQD1bk4jHAO4YIRgd
         hdVQ==
X-Gm-Message-State: AFq9FYLC0fYtMZeYSBN81AzidWp5SWHgHbn48/q+fTI1sRfF1fgeG0eG
	mzfx93D1xbO+BkpCuxuuhcrhpt+unNtO0NNwJAu0Puddo2ZmOB68Hg7w
X-Gm-Gg: AYBFou26Xdun28qybyZMTCW7dR4quYtrSk6ZLrj93KEE/KioiE/Ah0FLgxqgbZd9yfe
	V7TqHK6m+MwVF970SbS1FzygnlZ6RIBCrwiIDZ1VpXABjv1WNlgwqdVIDk1V0pwoigi+XG2xhaz
	uIYaxQ8idLTpZo50Zo8pQ2OedPCPqtFerSimbMbflbIbN8G+th8rqvm2XhkZSUmDub+LmCHTdHN
	uaRALo0w7t73k9hkASn8giBhPb3XLiq1rzL3B9kYInPMa0qkO3qgoq5O0lCjJlxiKjVUKDfgxYG
	KW/F665bCgmSiFaeZm3OR8VQsYjxHVYgx0IHlOQU01/w8+0rZhOeF3EmWSsduMt7PnuaMMsdmq5
	b6oW+6EA8RO+ygKa7aCYIDOWKblKZ8h9BIkvHjNN3qPgsSz7UwC42rLnPtKxizVVb8Gul1pGaWX
	IJEhMddw3o7kBWzwiTYn9Zh7Q/Dm8JwqFxuMeh7JZxxyrBdjteXjKNS0ugG/czU5nAgZH6T9udb
	WV3M1aSnHE4EEy7x8NtWXTtA9wHbcPZonCN9KouY8te4Zc1D3sYWT3ryUyOqQ4eXgTZIGtkyqXR
	yD1OkMdItYM2VdfW7JfEqLUKQZ++XSSF8kquRSyooqSAELlar3lcJs5aTZ2SX5HAFYbr7SSxG6u
	rc00e3zy1Bbzhow==
X-Received: by 2002:a05:7022:7f0f:b0:1a7:d426:6dd2 with SMTP id a92af1059eb24-1ac5e31fb9dmr16576074c88.26.1793677341918;
        Mon, 02 Nov 2026 19:42:21 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:98f:6bcd:858b:7a64])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac19f4b08bsm44418457c88.16.2026.11.02.19.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 19:42:21 -0800 (PST)
Date: Mon, 2 Nov 2026 19:42:18 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Kornel =?utf-8?Q?Dul=C4=99ba?= <korneld@google.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] input: evdev: Read clock directly in
 __evdev_queue_syn_dropped()
Message-ID: <aulWqwWvx1Q1DAeL@google.com>
References: <20261022-evdev_syndropped_fix-v1-0-b5400740e1f7@google.com>
 <20261022-evdev_syndropped_fix-v1-2-b5400740e1f7@google.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261022-evdev_syndropped_fix-v1-2-b5400740e1f7@google.com>

Hi Kornel,

On Thu, Oct 22, 2026 at 01:39:13PM +0000, Kornel Dulęba wrote:
> Currently, __evdev_queue_syn_dropped() calls input_get_timestamp() on
> the underlying input_dev to obtain the event timestamp. If no timestamp
> is set, input_get_timestamp() caches the current time and returns it;
> otherwise, it returns the cached value.
> 
> There are two problems with this approach:
> 
> 1. Locking. The timestamp is obtained in the same way in
>    evdev_events(), which is called with dev->event_lock held. Calls to
>    __evdev_queue_syn_dropped() are only serialized with
>    client->buffer_lock. This makes both accesses likely racy.

handler->events() is called under dev->event_lock. I'd love to stop
doing this, this is how it is now.

> 2. If no timestamp is cached yet, the subsequent hardware event
>    generated after __evdev_queue_syn_dropped() is called will receive
>    the stale cached timestamp.
> 
> Fix this by reading the current time directly based on the value of
> client->clk_type. Open-coding this is not the prettiest solution, but I
> couldn't figure out anything better.
> 
> I initially thought about fixing this by resetting the input timestamp
> in this function instead, similarly to how INPUT_FLUSH handles it.
> However, I decided against it, as that would require non-trivial
> locking changes.

I wonder if we care about timing on the SYN_DROPPED events? Can we just
grab the dev->timestamp and if it is 0 that's fine. Or not even set the
timestamp at all on SYN_DROPPED and have it always at 0.

What do you think?

Thanks.

-- 
Dmitry
