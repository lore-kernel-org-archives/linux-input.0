Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8A841D129
	for <linux-input@vger.kernel.org>; Mon, 10 Aug 2026 14:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786373419; cv=none; b=uJ/mRDVjN90sWG1KSI3kO/U+QqjXA7BueuOh8i+fejfq4/+ITbfS0IH8+6qjgsp2V2CA+JO+BMpJYFLpc1dkJYPZAEhVUXloHltx761egMAF4bspSy8ISON6sazf2lBtInV5joKwpQmPS8aaevDbjEOmQNXnkc2+E020d3CCTiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786373419; c=relaxed/simple;
	bh=w68VGJZ7WQ2fyfHcwbYCECGuHLKKADlAzifhTQgM/Cw=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=PFH4PLyaVjjSj3IFzOLkErEnM6m9harG/0/JaHB0bq+tnUeYBqS7iwCy3viG/yRwCyKVfq8sbqDPLVlsSJonuoPwrVkQJyJJNR5EPJjRSSPW8JU8xKX8QNc3ktCn8lAvsGOy4XoviW0MIJoitWdfGQw+OeSOUkwx3mTczwlR5rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JyQ9Ygkq; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyQ9Ygkq"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47f59f25ec4so664259f8f.2
        for <linux-input@vger.kernel.org>; Mon, 10 Aug 2026 07:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786373414; x=1786978214; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rRo2Sx1H6+ESUKn2FANX7h2iPuS1MLfy+OP/B4sfc5E=;
        b=JyQ9YgkqW/Bo0DIZ6CPi4YW5uk4o8UVs3yv+8AuyKdQ5WE0bbCRfE8lk8Z0VluBmRS
         XYceBXP7xJ3RASeNZJd4n/ZiyU7ixApjgs615n0UkaJpRfdHh9pgE7jH03/AbW3xW2vQ
         qorpqo9Cf/N+2jwhJAQCl06boKW+crNzjJA3UvlB2a5LIqq9ewcFWGwHG/WAk95FtoPE
         40iA3gYmtEwGSNom3ho6daGoQNq4AUOyaXwNpk7anfsUWw0AsSDEmUzoKuZXvFHadD/G
         5sVOLbPeYCDDnDtAml+hlwlhb4iFAJgQhfBJbH2peeLty9WCt66IwIaptXVUB/TcXil6
         b25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786373414; x=1786978214;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rRo2Sx1H6+ESUKn2FANX7h2iPuS1MLfy+OP/B4sfc5E=;
        b=U50uFSKOr5ZSa+1CSSNtBpDMR4Eq89W+xJag24wUJ8/gikC8eHQhVK61b94tUE1UNP
         jI27u3tYGadw7VpHlPNallSBVIxRxcxgdSQa1o5orNqBqEHI7XF5KL6kLYtiSWQWi1wW
         AYbt+fjnnJ3bl9femQMn5VOsrU9EQlzx3kts/3YydkUz21OxojboU3O2MgtMw3al5XMk
         KsF6N17KvELH4oa7sBoVF8TPqb+uEG7cZ3aH3gfPr1jnYeqU1woZpzcxpyrVcNkSPnFk
         9xP+UZf/l2bm/Np669j0Kk2PHd4SmfXoxZz6R6ig7PT9TPPqZSzE53pnm2LsnVnLpMjh
         XQiA==
X-Forwarded-Encrypted: i=1; AHgh+RqjmyX+MqSKVJmGF0lo/vJZFQwhMydQnyMOgACyObxaQ7C0wGmV680nL8M9ZGygE9rDnWU4jxlxGJkWqQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmRsdvt/TmeWuFbmAmgzbMm5icvVrcOeByqObDwV8w9Lu7alJc
	BxJIWJzOTxUmj2uYcpOCxBNUsq2ST4UfknrekEMK4R7BuWeAMOnnu4PTTJ1AVfAA
X-Gm-Gg: AR+sD12XaEAMnVKKZaFx2CyzMLJ6nsq+Ik2+k1znrqwR2ydJ3ThhzFSjQfCYafjTbXJ
	JjAegcUbk52hD28pauMX+EK1YnBcaN/XjuqRYZaJ2SoYBevlZbZ86Sjd2iNgWe1pyBOpbuvehfR
	PwKb1gj4kN76fepanMTg8SyFzCQJiieqVrteGFb8Ofh3ROeMBA9LLkjxHmPRshk/4ag0ow9S8vx
	YghXpBbqOPJDdg124CbBwWLPu4ODhYyt+KEOsG18HZEVEkyO023dxuIvFcXIUBarpP0XZPOx81Y
	OHCtZafyKbkyYZD3CN/qYv8jXE2G625q96Tm7NFOmV1GvZT0J5ZShSP5Rksa3+zoRs8xmKfug2f
	4faZ+7XWkIm85VkfBwnohlXpgoOMZnGzvZUS732o0PrKI5yVYJQk7yulvQCGylRaNcg1XhKHTQX
	kCTq0S78POggCHhr1B6t+kw0OeIdgbqV0w88Jpo+PikLGOZXCBjrn5jcYbQyeR3KfCrnb/NBx+U
	zmoa2DFSB7oGsLs6yAEv8HxvCrmM0aFc31R0TBj8iAobNGXhH171Vny
X-Received: by 2002:a05:6000:22c9:b0:47f:e7c8:3fe9 with SMTP id ffacd0b85a97d-47ffd15cb0fmr45142325f8f.0.1786373414319;
        Mon, 10 Aug 2026 07:50:14 -0700 (PDT)
Received: from valmpani.valmpani (cgn-195-14-217-60.nc.de. [195.14.217.60])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021f90f8sm31804293f8f.26.2026.08.10.07.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 07:50:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] input: sur40: fix error recovery in sur40_probe()
From: Vasileios Almpanis <vasilisalmpanis@gmail.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 linux-input@vger.kernel.org, lvc-project@linuxtesting.org, 
 syzbot+2a123f6269da57ffefaa@syzkaller.appspotmail.com
In-Reply-To: <20260810141319.118259-1-dmantipov@yandex.ru>
References: <20260810141319.118259-1-dmantipov@yandex.ru>
Date: Mon, 10 Aug 2026 16:50:09 +0200
Message-Id: <178637340988.1434984.13114510500553043049.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786373413; l=2312;
 i=vasilisalmpanis@gmail.com; s=20260731; h=from:subject:message-id;
 bh=w68VGJZ7WQ2fyfHcwbYCECGuHLKKADlAzifhTQgM/Cw=;
 b=DoEeYFilqBGpqARkhKt5lyXyUVs1K2E9RZ1sQzAk+0tyhEqpznvV4eD8Ss2qCbb6A8uFGxdtl
 vVWVgtsSohwCVXVMx06X50y6LaZahjvKHZOjCet5Olgw9FxaSxwQWFn
X-Developer-Key: i=vasilisalmpanis@gmail.com; a=ed25519;
 pk=gn5Uo6yL8Tlpq5uATxA3nqoq+U8eWLRbjD+bOk0qSpU=

> Since an input device which has passed 'input_register_device()' should
> be released with 'input_unregister_device()', adjust 'sur40_probe()'
> to do so and call 'input_free_device()' to handle device register error
> only. To avoid V4L2 memory leak, ensure that 'v4l2_ctrl_handler_free()'
> is called on all error handling paths, including the one after
> 'video_register_device()' failure.
> 
> Reported-by: syzbot+2a123f6269da57ffefaa@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=2a123f6269da57ffefaa
> Fixes: 08b936012964 ("Input: sur40 - switch to using polled mode of input devices")
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
>
> diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscreen/sur40.c
> index fe63d53d56db..fe675b937b35 100644
> --- a/drivers/input/touchscreen/sur40.c
> +++ b/drivers/input/touchscreen/sur40.c
> @@ -730,6 +730,8 @@ static int sur40_probe(struct usb_interface *interface,
>  	if (error) {
>  		dev_err(&interface->dev,
>  			"Unable to register polled input device.");
> +		input_free_device(input);
> +		input = NULL;
>  		goto err_free_buffer;
>  	}
>  
> @@ -786,9 +788,8 @@ static int sur40_probe(struct usb_interface *interface,
>  	if (sur40->hdl.error) {
>  		dev_err(&interface->dev,
>  			"Unable to register video controls.");
> -		v4l2_ctrl_handler_free(&sur40->hdl);
>  		error = sur40->hdl.error;
> -		goto err_unreg_v4l2;
> +		goto err_unreg_ctrl;
>  	}
>  
>  	error = video_register_device(&sur40->vdev, VFL_TYPE_TOUCH, -1);
> @@ -806,12 +807,15 @@ static int sur40_probe(struct usb_interface *interface,
>  
>  err_unreg_video:
>  	video_unregister_device(&sur40->vdev);
> +err_unreg_ctrl:
> +	v4l2_ctrl_handler_free(&sur40->hdl);
>  err_unreg_v4l2:
>  	v4l2_device_unregister(&sur40->v4l2);
>  err_free_buffer:
>  	kfree(sur40->bulk_in_buffer);
>  err_free_input:
> -	input_free_device(input);
This label is shared by three other gotos which run before input_register_device.
So for example if kmalloc(sur40->bulk_in_size) fails we will go to err_free_input
which will call input_unregister_device with a device that was never registered,
and could potentially lead to some NULL-ptr deref.

-- 
Vasileios Almpanis <vasilisalmpanis@gmail.com>
