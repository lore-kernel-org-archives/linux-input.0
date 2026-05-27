Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8278C388899
	for <linux-input@vger.kernel.org>; Wed, 27 May 2026 19:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779910499; cv=none; b=CNr0HLmC0Erk3jI8xihh9OfyP3TyHXprY0XN4nMxdO1ivk8dvty7H+LFsQayH+1I7QAGCPZPFVV6PWdZpsLYLmMGvOyXRC+gx4oh/T0aSeSVxL1tXnSnqAW+9/1qyhhYGpDq2i9BbfuhyaXfCmsvxWnBHov6eELOjnoxCms2hgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779910499; c=relaxed/simple;
	bh=gNtu3I8dan5PtJoijFcBOSVKlBDemQlQMVY7dWwaBXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kIiz3BJvXCECaWFsMBfW9xp+3wVsw3SkUmk/rBFlAA4+yncmWqsjqEdQKCeYRNGzdMRGeaN2NFPyrL25VYyG7QhC63W20WJ9iOaKFzKZI9M9V1zwQyNeXMbHkiOHQt9wsAu5+V0d31jNNlXDujrk7dvUtwCWhpPa+b8gtwT6Xdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sJa0tRAT; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sJa0tRAT"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2f0ad52830cso15395140eec.1
        for <linux-input@vger.kernel.org>; Wed, 27 May 2026 12:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779910486; x=1780515286; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JTNqcC36SPBRRdFnrJ/yAEkzgUWymNhZiWM/17f+GfM=;
        b=sJa0tRAToHWmztCbhBLAZtOZPSAPZDxvFd7cXV5tYfWVx1gPxMimGz6hgvxjY9AYv/
         j0wkYVubL1rnelar+UvbNtkKuBRs461rg8YyMBzAKbkzb8OH3AhcU89QPa9NuzRI1Mau
         K2LYiMi8WpR1YYWG8AbxOEGbihX2MqrO0jzsDXvPGyQKBNzBgQO6m2nPySAcX8srnZNX
         SchObzcDz9MgU08n7WPU7Ga+bgNaHDu0JNiE+lqjqX1pzqV6diVcvXxDATy7SNac1wNy
         NF3Nq0yUlDTDgYCxgWXE9d7JzscSyS+7GaNaKI8q4ILUBtfWBVR6On3kyh/WIIYFCLcN
         fZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779910486; x=1780515286;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JTNqcC36SPBRRdFnrJ/yAEkzgUWymNhZiWM/17f+GfM=;
        b=Cy5D/GoCKusDl36QIS9a4tfVPj6xGOWNldZ3xNMLYlz0yRSw4ohG5FGpeTbUx19+fp
         Gd6UOrgReT9BDg7Va4yPmlIAo9YD2POdFbyZNxqiBL+OXV3BYXghg+bKs2do/KKJihXt
         4h1l+SxZxJgm6O2glwTtR23nWfo3rkR7ip6cbr9J+APOgzDTJDi+RlfyJsfBTolTZyR/
         UHVva+EaU+7OKLf+puTB3GBKkmfEkK6HrAb37h+NaThgJMDnn4jkAz1O/MYLAL9wVW1y
         9zk29sVtXSA0/txOIfWDt6wppR1/SwWXJrQEdcqVhmgdJSLiGlPKlNCCdfwgv1nGmPqv
         Dpbw==
X-Forwarded-Encrypted: i=1; AFNElJ/Xy3lHiVxE0SJfiknhsySEFDcn3D1KrNAPsIwqsuMhs9vPHe68ZdZ8SqNSojzSoe9apJk8mVePx6DyBw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxtWzSVCa4A502DR7VDLefJo3/clBVMPLT9D1EjmOAnxoJJy5qU
	Ae/WTZwuc73LIgzvvFjWpRWN25wMI8coISL//kLnFRqPetcwKPZ7rLLj
X-Gm-Gg: Acq92OHNm9lWRlY1KmuBe4GL7+a/z49Cib8CjCEm6OpzSmZBHAtT0vgy5l6/1ll+O9E
	XAAmEmREmNQWH7nJBGd2ryY4GR+TkZczw0/BcmMYG7WKUPF7j1qWlzT06aJbi4gZA1p+ToRpEay
	7vTYwUFCGV4Oo9ONsXWZREIiTldsUp1ztFMpdrb04MgA4cXpZ/9SoI6b84kFkktjUQUjBwhFn1M
	M3mbkxXZNhkF31QSKnqrdGjHaAlu71IHxKxDJf6MO36e5D1uiXFMRslw8vkjC6KbOqoMKtURnYj
	SSoHbalaNxS2xkbH0vxxzOfyOpCCY0LdUOtGZ0+GxPWXLJjadpADxJGkR1LpSEHi6m5wJapeTNB
	kVUDzJXPygNlzaMC2AYsLT6DSZ/OHdsL/3T02SHYVcEwE/O2Z6nP0GmzgQPbGBUxOTEcqsnX2Pn
	/1TX7Qf75OdljoH6bvR5xkV5xu83sdcv0J62w975hMkDf/FE7Jvo095HiVO6IEANlZSV9LJ1Jj7
	sA=
X-Received: by 2002:a05:7300:ef89:b0:2ed:23cd:babf with SMTP id 5a478bee46e88-304490906d0mr10929946eec.12.1779910485730;
        Wed, 27 May 2026 12:34:45 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:ca8d:7a6a:7fd3:5948])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304524610f7sm13502866eec.29.2026.05.27.12.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 12:34:44 -0700 (PDT)
Date: Wed, 27 May 2026 12:34:42 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Ping Cheng <ping.cheng@wacom.com>, 
	Jason Gerecke <jason.gerecke@wacom.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Subject: Re: [PATCH] HID: wacom: stop hardware after post-start probe failures
Message-ID: <ahdE9G8I7kd_OoGW@google.com>
References: <20260524175552.1973-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260524175552.1973-1-mhun512@gmail.com>

Hi Myeonghun,

On Mon, May 25, 2026 at 02:53:33AM +0900, Myeonghun Pak wrote:
> wacom_parse_and_register() starts HID hardware before registering inputs
> and initializing pad LEDs/remotes. Those later steps can fail, but their
> error paths currently release Wacom resources without stopping the HID
> hardware.
> 
> Route post-hid_hw_start() failures through hid_hw_stop() before
> releasing driver resources.
> 
> This issue was identified during our ongoing static-analysis research while
> reviewing kernel code.
> 
> Fixes: c1d6708bf0d3 ("HID: wacom: Do not register input devices until after hid_hw_start")
> Cc: stable@vger.kernel.org
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
>  drivers/hid/wacom_sys.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 0d1c6d90fe..c824d9c224 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -2456,16 +2456,16 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
>  
>  	error = wacom_register_inputs(wacom);
>  	if (error)
> -		goto fail;
> +		goto fail_hw_stop;
>  
>  	if (wacom->wacom_wac.features.device_type & WACOM_DEVICETYPE_PAD) {
>  		error = wacom_initialize_leds(wacom);
>  		if (error)
> -			goto fail;
> +			goto fail_hw_stop;
>  
>  		error = wacom_initialize_remotes(wacom);
>  		if (error)
> -			goto fail;
> +			goto fail_hw_stop;
>  	}
>  
>  	if (!wireless) {
> @@ -2496,6 +2496,7 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
>  	return 0;
>  
>  fail_quirks:
> +fail_hw_stop:
>  	hid_hw_stop(hdev);
>  fail:
>  	wacom_release_resources(wacom);

I'd get rid of 'fail_quirks' and use 'fail_hw_stop' everywhere,
otherwise:

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry
