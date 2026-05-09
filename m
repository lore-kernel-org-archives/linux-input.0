Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6148D38759C
	for <linux-input@vger.kernel.org>; Sat,  9 May 2026 09:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778320526; cv=none; b=uCdXgePA8RBsDiGHyIGkfgRW3ehiq/yMZqTd4D6Svgl8slQAjZ652btgae0Srf3olFeKOPOFqZDKZCXFS8TvDIiaxfqid+mQH2bgIm1sj6dRAuWI0wFfz+1DCACg3GbM9qMUA8pFmSX65pWq1sTnNdn9GDddOq0+QjkBx7TlJ+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778320526; c=relaxed/simple;
	bh=OsNMWoJsfFGNNzbdTZaiLLvQoneyS4qquVTcja2ipCE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ndH2zRfzVXVJ765c6hGk9pIqc7hM+mRVakyf3nRWstvfQJQpPT2IFMa9mCi+mT5Ud4wwsBv86T0eAdxjVSz9c9LEYwvVZHB/zuYwZ6z+3RpDQfn/86ngnXjzSrwckUwweRepTAAPSdd6X7NjgRM5nlYi+DK/Mire0I1M/SfI6uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bfqed6i4; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfqed6i4"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488b0046078so22329875e9.1
        for <linux-input@vger.kernel.org>; Sat, 09 May 2026 02:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778320523; x=1778925323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7DPOjtBC4y6QCDvgAajyqEeMTzsqYkeTN2dHg6bS6Wc=;
        b=bfqed6i4vIYa0uQq9QkXPZG/X1hv61gxkAIPTxueTV/eAzFU+CAu9yLFHTxGm37owX
         sNr6eVvc+UD0JnXIT8u9z5N5LWr1jW1GRJLABYeqJLUFmkXopadl4ThZaHPm3OpvCGmk
         09Vnzetub3DgDllcLrVDDAf7wPJJkz0HfQdzH/QnyAUUoLpFScYtvCQd4TJ/ICyMxc0h
         tniL8wP/UbyUwKgaoxu42LB18aIW4+pMz1LC05x8QAhLUCzhtaXalHi3EVZQspTqqgcE
         aNpOZk1DEqqDWonwmUN1y3Op54rm8DBSag2RzsadjJYvMr46eQJT6BvO4QlmarVK+rVD
         r0TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778320523; x=1778925323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7DPOjtBC4y6QCDvgAajyqEeMTzsqYkeTN2dHg6bS6Wc=;
        b=tDTJBmEBX+aCoefj7AxGbz4HRGooMN7CB8IU7pDBVmq27gz1rGLYnmbfLf5Qrhc0eZ
         0TY4csaFUaggLBoE4d8OvIYbWOMfNibVBdVkl5XFV75D5HFn0wKKN9Z2hXWarj402ncT
         uPJ/2wz7d51dKpQcv10rfu80DuzUvNTUxnrFrRgflbar2pgqLce+mXofp7Cz7nSWDG7c
         bvnCFSi9NqqD6XdPw1KTc4cT12UlKLB0wxp6Fl4ZAGTkKDWQpE42b3iaeecHX6JOoOl1
         mM4O5qMaOzOX9BCQtv0SX3e1+hFO63xSLiX420Kp+P6nRi33eSElo4wlTjVOe1ydYN8M
         WZbQ==
X-Forwarded-Encrypted: i=1; AFNElJ/8WOwFUffatgfJ+xDUSzVDaI9mwRagdYphFlrwfsXrYr02JgZv8MVY7ZgugjQQPVBn7ERgrLTiJQS86w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx63y5H1aP/mXVjBmeh9TQy7ne0X7eVqPkqBTPbnkpr0brQDCJ2
	EQzXUx4iL8XWNFp/kNRrwUIGgNpgsuhCigxqjGs8hND/Dyq/9KdqCaV1
X-Gm-Gg: Acq92OHbUr9db19AcS8d/VIcb3tS8Rexzk/eEWBFH2QdBxt1J5NY38PM4BlgbOW4Kmy
	US+Ofzdt0O8bATwpRVbl39XsKK7JpoKfOpE/ENvf8bxrip8nrooWzVQXjvG6XtKcSBWvydI5/Qs
	bIEGkrD9GXwOtA3P2GNhjux0CELi9W/dZqYX8507gzOBRGZyAaFpfHPk4RBMKmnf+Flt3DmTeZX
	LMEz1kZRavNTEQEWfKdBTVfCP7+c5+6qQNRL+sQDVVyOuDzASCmPB3reyrc4YDccBzh/ejYG+h3
	Sh58q3H+/soDgJ8IjSv4SaBnh9T7yQy+E90AqW3hjrW5ospeemRiMF8I4+nBqbt8i1PJm3j7gqr
	WPjHYNW2DCxFhu6Px9W5xn0xo+UOzh3ZFf9ywHqcOkyHcB3G1Yu1ZJW069p3AyzYfx0Qb8nv+TT
	QlPVO6WDC66s74QewB59wDoyDU/iGOQyAz29Zm26iLpHHyMAPMp3TB9O5KG7Ue7qVYNaaRuVv1Z
	Uw=
X-Received: by 2002:a05:600c:4fc4:b0:48a:58ae:9938 with SMTP id 5b1f17b1804b1-48e706bd7bdmr27948155e9.19.1778320522459;
        Sat, 09 May 2026 02:55:22 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e702ec599sm35687645e9.11.2026.05.09.02.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 02:55:22 -0700 (PDT)
Date: Sat, 9 May 2026 10:55:20 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Akash Sukhavasi <akash.sukhavasi@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: analog: replace deprecated simple_strtoul() with
 kstrtouint()
Message-ID: <20260509105520.61f823a5@pumpkin>
In-Reply-To: <20260509024048.46132-1-akash.sukhavasi@gmail.com>
References: <20260509024048.46132-1-akash.sukhavasi@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  8 May 2026 21:40:48 -0500
Akash Sukhavasi <akash.sukhavasi@gmail.com> wrote:

> The simple_strtoul() function is deprecated because it ignores
> trailing garbage characters, which can mask typos in input.
> 
> Replace it with kstrtouint() in analog_parse_options() to enforce
> strict input parsing.
> 
> Note that this introduces a minor, intended behavior change: while
> the old code would silently parse a malformed string like "12abc"
> as 12, the new code will reject it entirely and fall back to the
> unconfigured state (0xff). This strict parsing is the preferred
> modern behavior for kernel parameters.

However that might break existing systems.
So I'm not at all sure it should be done.

	David

> 
> Signed-off-by: Akash Sukhavasi <akash.sukhavasi@gmail.com>
> ---
>  drivers/input/joystick/analog.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/joystick/analog.c b/drivers/input/joystick/analog.c
> index b6f7bce1c..07ad360f8 100644
> --- a/drivers/input/joystick/analog.c
> +++ b/drivers/input/joystick/analog.c
> @@ -653,7 +653,7 @@ static struct analog_types analog_types[] = {
>  static void analog_parse_options(void)
>  {
>  	int i, j;
> -	char *end;
> +	unsigned int parsed_val;
>  
>  	for (i = 0; i < js_nargs; i++) {
>  
> @@ -664,8 +664,10 @@ static void analog_parse_options(void)
>  			}
>  		if (analog_types[j].name) continue;
>  
> -		analog_options[i] = simple_strtoul(js[i], &end, 0);
> -		if (end != js[i]) continue;
> +		if (kstrtouint(js[i], 0, &parsed_val) == 0) {
> +			analog_options[i] = parsed_val;
> +			continue;
> +		}
>  
>  		analog_options[i] = 0xff;
>  		if (!strlen(js[i])) continue;

