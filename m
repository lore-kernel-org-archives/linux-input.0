Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951CB2475D0
	for <linux-input@vger.kernel.org>; Sat,  4 Jul 2026 15:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783180105; cv=none; b=clIMGNpYiWh/YDGXid3NP5FVF2Zzv1l/Gj+dxqGS9jquIDas+Z6bplmgYespQl55Zp8fkKPGd3dIlv/JolkvduYLVDK1rIqRHYsOnElnBts4UGo0/f+qxBShOp3cqJN4FLDEdD51UQkFMHkRmltY5ajEdTGQZvJXDsCni0oZhaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783180105; c=relaxed/simple;
	bh=Vo0/uthTCA9t/S1uhiavK6qelh2NJYHHNcX+iaTVo1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KpLOAG1fed0vtkAJn2aDdg83cV23HY968g2+oCaWf9yXIb+D/nkiPDacDV2QJBdpkpRwK/GYwlutmjde9ESEZrKoloyC2pGZfd5fgBowA6auPflCGPgWcRl+0Zy2X8B/worX8D+nLt3/81l4cFzEoIfyYNg9h7FFfvQjtRL21ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/++k5es; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/++k5es"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493b779003fso7337745e9.3
        for <linux-input@vger.kernel.org>; Sat, 04 Jul 2026 08:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783180102; x=1783784902; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VYulFp3SO5/MbqdqSCJYzK/afw2ecrlo9KeAU+Q8Zjg=;
        b=k/++k5eshOcbx+SUqawdsrMdhiduEMBZbcWBd6iYkQ9ptN3lHZ3nn6OfvgpZ3Y3Ibr
         eBTc9Wb48dGIFmyT9ipaqgDMmclvuU9nM5LFJgxnRxENUeKzpXcFlNH21orXTloEmGC0
         3MGiA8HWhhkVD7cyVBP/KJo6Z+BldeFSHdP+Ltccz7rj5mn0QLLrwsJ7uS6SPzyG/G2l
         v7j2utBE1x9yOZYwqZswVPwa0hSUyJTlsGhvpQ1P9qBJbH/dG/7QJ9iyWcMQawC0BL7a
         r3lCxubu03uW5YRFSz3CiUzJ1nJANaMcwjRayNeoJ5/ITD/dMngImHuuGiN1Rvis3R14
         5AfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783180102; x=1783784902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VYulFp3SO5/MbqdqSCJYzK/afw2ecrlo9KeAU+Q8Zjg=;
        b=lOhqfwpZKKCnAcKUNcdjwBJ1CoKwt3pp5tLHL8Pey1tmmeX8s/+4/fDiGR4CX2cjUC
         hpB3E+/rALB9Enb9KWJOAe1doiM32Y5B6vmIwIcCa10Yw6T95XfOhiM0yhXQJzJEgs3o
         n7Ojj4uHf7v42637jLb4RMstJo8j5tN/+tKaJkoBUjUurWJfwy9XGeZ5ZSssqQP79WQG
         VOCfx6t6FaEVe8YrU4KX2scm3Kk2F0e+G+32z4IioDyW++GLffEwlxt1vzkQFXToy7ut
         qUyVBXHHaYg1eCroB2lZUd59R9mu/iCZHZe1UAsi14bVvSYfCRl7w96Yu9Go5euay/9N
         vQyA==
X-Forwarded-Encrypted: i=1; AFNElJ+1HcwblCUXe60caMd0yo1IcaFUFU7wukc/ixU1Zr0p0myDJh7K17bDcKeK79nEArXblcAW1g6Yf6anZg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7OjK+MpQ2zD2h4oc1pOfUrmrdbbb8M8H9SfC2Lp/5Sk1JVXob
	O53g3fz19bhfRE827ikOb6NUAA+yJEsN6T0CTj+3MDDUmZ9q9zCUaIA=
X-Gm-Gg: AfdE7cld/6VvHEIShinBxy0DQuRPDLMleOyTsuHojPt22ZIhg3pqRrF/t2C7LLlw4iV
	0X46XF0DnLb0dAKP7PRTHBJcNesel4Bw7AV6LMP8l1HvrbLE2PWPKVtRYMLQZIlixlQhliuvnEs
	InhMxjv8ePEWqBDjO7m/K8Syfxxm1Y3x/S2626I7JLzqhSg9J/EL9U+XTaD/3IHSKKHaEKdJeGN
	iBhXhkBYfqo5XE1IeCMoAYlzNGRDezHg8UurNq2/e2fR0c6IosTmrADsqZGLoJLeJWzePexD+3g
	Qx6KGtZ812ApIrAnzA/9ODggn/eWea7TBQiBNyluhCpOoBVnwCjFVs4fs9KipVAscaB3sNkWpSw
	VOjrUXNrGz3suqh9gebWCvh6AWn73ruTHwCgAEcXzQoX3ZVFhHGstqWDdSGoDcEn4fSrKlxFDk/
	JwabHFZ2Vt+r4zmBL5deBQ1RvTC9tA8i+7P2MzFIfN7u9Orxn2vmiLTm7qQ+FpOVhstQ==
X-Received: by 2002:a05:600c:4e8a:b0:493:a960:a0bf with SMTP id 5b1f17b1804b1-493d11f3296mr44682275e9.21.1783180101792;
        Sat, 04 Jul 2026 08:48:21 -0700 (PDT)
Received: from lithos ([2a02:810d:4a94:b300:ccc7:6431:13a2:5d53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c63172fesm381717435e9.0.2026.07.04.08.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 08:48:21 -0700 (PDT)
Date: Sat, 4 Jul 2026 17:48:16 +0200
From: Florian Fuchs <fuchsfl@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Adrian McMenamin <adrianmcmenamin@gmail.com>,
	linux-kernel@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>,
	linux-input@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-sh@vger.kernel.org
Subject: Re: [PATCH 18/26] sh: maple: introduce callback_mutex in maple_device
Message-ID: <akkrQJfxSCvUptC4@lithos>
References: <20260703-b4-maple-cleanup-v1-0-41e424964da5@gmail.com>
 <20260703-b4-maple-cleanup-v1-18-41e424964da5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703-b4-maple-cleanup-v1-18-41e424964da5@gmail.com>

Hi Dmitry,

On 03 Jul 22:57, Dmitry Torokhov wrote:
> The Maple bus core invokes client callbacks asynchronously from a
> workqueue (maple_dma_handler). If a device is removed (or closed) while
> a callback is in flight, it can lead to UAF bugs if the driver's private
> data is freed.
> 
> Introduce callback_mutex in struct maple_device to synchronize
> callback registration/modification and callback invocation.
> 
> Assisted-by: Antigravity:gemini-3.5-flash
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/sh/maple/maple.c | 9 +++++++--
>  include/linux/maple.h    | 2 ++
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/sh/maple/maple.c b/drivers/sh/maple/maple.c
> index c0715e3ace6f..7c82b7a8a280 100644
> --- a/drivers/sh/maple/maple.c
> +++ b/drivers/sh/maple/maple.c
> @@ -121,6 +121,7 @@ void maple_getcond_callback(struct maple_device *dev,
>  			void (*callback) (struct mapleq *mq),
>  			unsigned long interval, unsigned long function)
>  {
> +	guard(mutex)(&dev->callback_mutex);
>  	dev->callback = callback;
>  	dev->interval = interval;
>  	dev->function = cpu_to_be32(function);
> @@ -230,11 +231,13 @@ static struct maple_device *maple_alloc_dev(int port, int unit)
>  	mdev->dev.bus = &maple_bus_type;
>  	mdev->dev.parent = &maple_bus;
>  	init_waitqueue_head(&mdev->maple_wait);
> +	mutex_init(&mdev->callback_mutex);
>  	return mdev;
>  }
>  
>  static void maple_free_dev(struct maple_device *mdev)
>  {
> +	mutex_destroy(&mdev->callback_mutex);
>  	kmem_cache_free(maple_queue_cache, mdev->mq->recvbuf);
>  	kfree(mdev->mq);
>  	kfree(mdev);
> @@ -655,8 +658,10 @@ static void maple_dma_handler(struct work_struct *work)
>  				break;
>  
>  			case MAPLE_RESPONSE_DATATRF:
> -				if (mdev->callback)
> -					mdev->callback(mq);
> +				scoped_guard(mutex, &mdev->callback_mutex) {
> +					if (mdev->callback)
> +						mdev->callback(mq);
> +				}
>  				atomic_set(&mdev->busy, 0);
>  				wake_up(&mdev->maple_wait);
>  				break;
> diff --git a/include/linux/maple.h b/include/linux/maple.h
> index 641cf3330409..48ed7558b8ab 100644
> --- a/include/linux/maple.h
> +++ b/include/linux/maple.h
> @@ -3,6 +3,7 @@
>  #define __LINUX_MAPLE_H
>  
>  #include <linux/device.h>
> +#include <linux/mutex.h>
>  #include <mach/maple.h>
>  
>  /* Maple Bus command and response codes */
> @@ -75,6 +76,7 @@ struct maple_device {
>  	char product_licence[64];
>  	atomic_t busy;
>  	wait_queue_head_t maple_wait;
> +	struct mutex callback_mutex;
>  	struct device dev;
>  };
>  
> 
> -- 
> 2.55.0.rc0.799.gd6f94ed593-goog
> 

Thank you so much for your efforts. I can confirm sashikos finding in my
test (that I saw later), that this patch hangs the bus if a VMU memcard
is inserted. So that the peripherals don't work anymore after insertion
of the memcard. With a last log like:
Dreamcast_visual_memory 3:01.E: VMU at (3, 1) is busy

Regards
Florian
