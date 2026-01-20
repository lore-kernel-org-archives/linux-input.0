Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6ED7365A0D
	for <linux-input@vger.kernel.org>; Tue, 20 Jan 2026 18:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768933369; cv=none; b=a38mFTQPhE/378yjFz5EIdZVL4HdlgyWpliyuzkTkU6wrMfhO35KWLlSTRJDpsX0gEmm/uijKkQovsKtlPX1hC4WSdUVy1x9U4cHu9NgEVHxBO/ted7ESAxNQ3iexG6lWsEJsId08KNsIn9QYhPCzWytGG4KZafgM5pwES+Q1ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768933369; c=relaxed/simple;
	bh=pEP9eLe/GDnDrSCGLmtl2yHgXgk28cPnvsDAl4wXXOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p0wkIxGyj6g2OTElhNuINkoy2lk2fLi/1oiSBPWOccOFQZl+s/KilG/DMg2Cz2xmcKXPYLoXHr5MmLpNCvBUsUYEZWSgAflWkAcJVskZji1KfB8YebTxtlleULpv2F51Q9+Fs+8gEf3H+jY7BlzuEBjp/tW0y7c9WSBcz/241zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2XknaBx; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2XknaBx"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-11f1fb91996so12817090c88.1
        for <linux-input@vger.kernel.org>; Tue, 20 Jan 2026 10:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768933366; x=1769538166; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Uh9uD1xg+0QqUfZPvUCdLR49DOiOBKC5FdnNCayiK+Y=;
        b=P2XknaBxYT2vVUNVzvfDa+jvVIurnxNT1+3CO+uyqE+pgzT20wnCB4frJaaYYPMLAI
         I3dDYCOPvrdco6FWGTN0YYm37HFJsXxCAwwc+/6YJGqva2f2M3JzPWcxtApl+dOk5fuS
         9fwq1MTtq+5LMgPm4EBSbXrJGAbdLNnR6GrZFBAAJY2yY+79qr7iU//zGeq3nsaItaaZ
         1hXFhLOip2snUQH9wiDI/JIz8g3XDAGcSFXoI7BrnEZ0Q1pJySrkck0PccsK83BqCq2G
         xCelJcVdlUklno/6wCX/BcwE8QuiwuBDWvGcfQwTgETdHBrUn0iqARTEp9UCdzqiBOTw
         JuFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768933366; x=1769538166;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uh9uD1xg+0QqUfZPvUCdLR49DOiOBKC5FdnNCayiK+Y=;
        b=Q+6M0C6CIZgQeHGpgkHc5B8k98GKvEpeMst5FgRoIvYyFcVbl/HI4BeHJZtXvI84LJ
         rtX53hn9X/lh465GviYSB7hbKAKWs/JjR4cX/kFXs6kCPpLgF3NmO/KkChX8x0mRmDX6
         uBtppzCwy832MXxNZ3FpZBEdAvKZknabbu6A5W2lEOsbnO8LuuzZPZB9CndWHvvFfTT8
         Y1V2LngpJN+XTS+yB564AkinSF7BHFzhxrWKCF00Al3Hdrl/nmsOYvFjsmGZ6TQ7xBwy
         P2D6KOfTGZEmzj+ux9Qj54+s0Ehwnp+1aUH1CA6KavRcYA8t9ckBHg0RySpn4NvXo6NZ
         0xCg==
X-Forwarded-Encrypted: i=1; AJvYcCVQt02RG3ImUh1wVgff04EHzp3YOcLzCxu4GA1/au39/mslP96hFtIns/1OV8dSmCzZmZez+m5a5lQ31Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwC+zruPp/HiunQGnqcPrDYJcweNMY1f42DqyAmsu8mLsTPYuBd
	YzRJa3R/0b2wWPe8xgYpOwy9G9PNKkW0NIUzmA7n2o008174QXz+DQQN
X-Gm-Gg: AY/fxX4DqVrERMiWZ2JZrTE7+XDvlY2V867l3LNbhg5BDwSmOiIeKIF5qgGPyumE21q
	4/obsY4bezs17VHJU/Ym3nhszlfTiTyIimMIvlzRR6OqVCKdwLY64cy50fCUjtLVdHlw5JK71aX
	/r+I9zNc0ZjjWJ111BSmtmsiT6vbrY+RO1uX1O3NJdi5MmyCLkXboAr1+ZqRzaIq1lSxDC0CAB/
	IVQkvDtk0A4nG1h6ndeiNw5+o+NhREihHmO6QiM3JgNcaQQ5kkf7UR5GxHqebztRBa0Vab+jt2K
	BxOk5YN4Jxdhu4OljxZUzJAr1qlKhBr7K7kNP1v5B5/CfGoxfrTb0ZxiL37uWDEqzxbEf/dA3y8
	b7KsXioRqAGl+yzezeMrEK6yx65sxzuMhpjcZdwtmn0857Ey1RvVjKq2+/yZUbTKF9dTlkJit0U
	/i+Sg8qNva+NHvlTfxvHOFpu8cv/MoEJUefL333hVo/LMn0aY2dO53
X-Received: by 2002:a05:7022:6284:b0:119:e569:f25f with SMTP id a92af1059eb24-1244b32a902mr11699566c88.8.1768933365816;
        Tue, 20 Jan 2026 10:22:45 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:d631:e554:f0bd:4106])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b34c11dasm20071031eec.2.2026.01.20.10.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 10:22:45 -0800 (PST)
Date: Tue, 20 Jan 2026 10:22:42 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: =?utf-8?B?6b2Q5p+v5a6H?= <qikeyu2017@gmail.com>
Cc: nick@shmanahar.org, rydberg@euromail.se, jy0922.shim@samsung.com, 
	bleung@chromium.org, ezequiel@vanguardiasur.com.ar, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: atmel_mxt_ts - fix NULL pointer dereference in
 mxt_object_show
Message-ID: <4mtpditwnavptpvstqphwa2auhb6wcd63gi76w2dekw7ryn2bp@au7dyelbvzmi>
References: <CALEuBan7Knm3G3eXPd8BZ37jVQFtRs7fAssts+picVKHBjGBqQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALEuBan7Knm3G3eXPd8BZ37jVQFtRs7fAssts+picVKHBjGBqQ@mail.gmail.com>

Hi,

On Thu, Jan 15, 2026 at 03:43:37AM +0800, 齐柯宇 wrote:
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c
> b/drivers/input/touchscreen/atmel_mxt_ts.c
> index dd0544cc1bc1..401fcae2264d 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -2859,6 +2859,10 @@ static ssize_t mxt_object_show(struct device *dev,
>   int error;
>   u8 *obuf;
> 
> + /* Check for NULL to prevent race condition during firmware update */
> + if (!data->info || !data->object_table)
> +   return -ENODEV;
> +

What stops the pointers from being invalidated right here?

>   /* Pre-allocate buffer large enough to hold max sized object. */
>   obuf = kmalloc(256, GFP_KERNEL);
>   if (!obuf)

Thanks.

-- 
Dmitry
