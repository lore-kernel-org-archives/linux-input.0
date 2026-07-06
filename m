Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC388430CEA
	for <linux-input@vger.kernel.org>; Mon,  6 Jul 2026 15:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783353547; cv=none; b=UvCpyC67wi58vA8gTFI/44IDsASZ5wB5F2YpFtRLl0kJLliwVmS4GRQXJG70WaZWbwDe+HVEz4+jhoS3vAVaG5EenDrYu6YZEXcg4zF+7dp28lqf2py0lPrITrjVy5bqI1Y2HjymA4xhg+kF1yBPWRy1AO+02QuVz1G8mvyEWVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783353547; c=relaxed/simple;
	bh=YeGw0QmsYPIjhG9a8P98Xx40MANLGXam7XN2+wLB6X8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=Etr5C1h9Brm1NGzPTxDzbGjbZ+H8HxPwefkKOUaUk/VHjBNCTVJyj9tJ7etKY/TYvN+l/bIaKQufONClt9f19qnVAZJsAzt3IMDj9XBcYbZhuP9q0g8D/WK6A9YL9e4uDkREkk+hiEEBjQnaxXwlsxa0k2nJeGIFVo4/GP5k8q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=QIpe7gKG; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="QIpe7gKG"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84592b55832so3120778b3a.3
        for <linux-input@vger.kernel.org>; Mon, 06 Jul 2026 08:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1783353541; x=1783958341; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bfTNHn8nmnL90dO9UUPWhLKbfieV4dy5YrFHzXy4ENA=;
        b=QIpe7gKGNYSDsBU6JE9PlJgvpN6oiuyYPn6XYvxkRWEvVmOK4w+m3bVwbTZDmdHRxZ
         5SbGXHG34HkMJyIiczuiRBlpJY/KFO8/ALhREAzW3/ikWXrTB4bZrecYCZMfF+tJEYtr
         OJEa6BPH6waHmNUpKnOB6tazWINKEsk/JriC1ppYm+mO2CIXtpELosnKhAHm91NG6IPq
         2HoxGVrPHB64G53s/eCYen3YpbJ0xqo8k8tqOGTcazKEKEDfKqNVXbnBBD5q/5aJbXkK
         Eo4aeAEEp1+us0KUnTT816oWpx1Hhg3KQbjg/6Q0RMSTz6LaclQvXGWkUSvBzwE/dNvB
         sGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783353541; x=1783958341;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bfTNHn8nmnL90dO9UUPWhLKbfieV4dy5YrFHzXy4ENA=;
        b=EsE9sJnUFsz8Uo17aX7UYJA7rgMhlIH/GpzkU1vzaM0miVPWi8g/Mw1cVjtuXNl0Ev
         zJ7taf3j+U47qAitsi23Y/VWKzv5SZeRq9+xXkivLjvyjLRyGVbXcPqtAILjOIkn0Zi2
         OwLMl2E5RgxZ9Up8X3m0FwYmJdwqK/+Kd+2xvoI+f+fVch4ZfiCJbnE7Vv8Lwmf5bc6s
         mPTPEFYprlizs1oM3YngJy500mR7JSDij6VEA9Fa7SKB5CSs3/NRpv+9Be4+zFKkH0mR
         iJKooLWaLODgJhvVLjVJ4VPWqGs0JbUCD6s6c3VfqRWjqNMBGy9ljm+cEf5u8eJCgjEe
         8nQA==
X-Forwarded-Encrypted: i=1; AHgh+Rrl5WGHzMkkEu2/PqmC5nYjw5StFyx4W+3gLZol9NesGkJnnD4oWPl/NG4BZiZxH7v2WcjL5WN7ySCT9A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVQwuFK1yDiJUypn0plcAf+NXQhs8iENTzfx29VcM9WL/1Bzmo
	OlmOAHgQdTQLNZ6nzFbqIw3f8jtP8hpzklX0Js4gwkgT4QBIMROkokFygX/uDv+BWxE=
X-Gm-Gg: AfdE7ckMtSUcCXcy33Iu+XtBkfuiIQNMvBnwOLtZcHpfXACMKJ3T0YEFLlOblykavHk
	3zcItn0T/4ZIA1ncDMJ7xmsX5YKuBJFadk2aQXmqvOMgIUjxkWzHerTMf+uzL9HLT3a5AlB3sfT
	Ez0DyXRTS3+Yi4Csd1ZmMYMEjzXtUq5Ln47lG5uizZHjQ9FJfwMnGSqbimTcmUUz5n3CuxNEWtB
	IOIrwVIk48ye2lxX9SbVGVD3ozN8TfhDvLmR7SOa7TzD0YL7+Sfj005RbGX51LiFcpybnKB/D+f
	jgrVfbY9TPvk4jsc+p0iv4o47VkVWsPq6HwnllfN0pmZ5D0zcDJjvuxh1Vt+M7jj40YkxjbToQg
	crJJr8V0If2lAhSjJd79eSVTCNT4/esKMzwxYKZtM//m24GQ84uQ1C6tzC5GmM4nj1/J/KFgUNv
	kTZAcwsUeEEHCDrA==
X-Received: by 2002:a05:6a00:f94:b0:842:5b63:6116 with SMTP id d2e1a72fcca58-84826bb3a1dmr1207945b3a.7.1783353541199;
        Mon, 06 Jul 2026 08:59:01 -0700 (PDT)
Received: from localhost ([2605:8d80:5c40:4f71:1131:e194:34df:ee9e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b9a832sm4069020b3a.18.2026.07.06.08.59.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 08:59:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Jul 2026 11:58:59 -0400
Message-Id: <DJRM2I1EFNCS.2GMT8JFORLO0T@etsalapatis.com>
Subject: Re: [PATCH] HID: bpf: Fix signedness bug in hid_bpf_hw_request
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Guangshuo Li" <lgs201920130244@gmail.com>, "Jiri Kosina"
 <jikos@kernel.org>, "Benjamin Tissoires" <bentiss@kernel.org>, "Kees Cook"
 <kees@kernel.org>, "Puranjay Mohan" <puranjay@kernel.org>, "Johan Hovold"
 <johan@kernel.org>, <linux-input@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260704160703.156298-1-lgs201920130244@gmail.com>
In-Reply-To: <20260704160703.156298-1-lgs201920130244@gmail.com>

On Sat Jul 4, 2026 at 12:07 PM EDT, Guangshuo Li wrote:
> hid_bpf_hw_request() clamps the return value of hid_hw_raw_request() to
> the size of the caller supplied buffer before copying data back to the
> BPF buffer.
>
> However, ret is signed while size is unsigned. If hid_hw_raw_request()
> returns a negative error code, the comparison promotes ret to size_t.
> This makes the negative value look like a very large positive value, so
> the error is clamped to size. The following memcpy() then treats the
> failed request as a successful transfer and copies stale data back to
> the caller.
>
> Only clamp positive return values. This preserves negative error codes
> while still preventing oversized successful returns from overflowing the
> caller supplied buffer.
>
> Fixes: 2b658c1c442e ("HID: bpf: prevent buffer overflow in hid_hw_request=
")
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/hid/bpf/hid_bpf_dispatch.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf=
_dispatch.c
> index d0130658091b..b13f911e5944 100644
> --- a/drivers/hid/bpf/hid_bpf_dispatch.c
> +++ b/drivers/hid/bpf/hid_bpf_dispatch.c
> @@ -446,7 +446,7 @@ hid_bpf_hw_request(struct hid_bpf_ctx *ctx, __u8 *buf=
, size_t buf__sz,
>  					      (u64)(long)ctx,
>  					      true); /* prevent infinite recursions */
> =20
> -	if (ret > size)
> +	if (ret > 0 && ret > size)
>  		ret =3D size;

I think this is making the code more difficult to write. Why not add a
label right before the cleanup at the end of the function, then
jump to it on error like so:

	if (ret < 0)
		goto done;

	if (ret > size)
		ret =3D size;

	if (ret > 0)
		memcpy(...);

done:
	kfree(dma_data);
	return ret;


>  	if (ret > 0)
>  		memcpy(buf, dma_data, ret);

