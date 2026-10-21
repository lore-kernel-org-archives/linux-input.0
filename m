Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792601581;
	b=5HnPjl4HGLXG26t0nLgL88O1/D1Ehe557+Blan6ud+AfU1mrPCFswoJ6IDKiD8eloeu0
	 KvH+htIDgpPghor36UWmNuavms2gIHJxZ3Xxf9ghlDaWAhczUJCElrbIn7SuCvevzc7YQ
	 Rx9pUJWZPJj+ieF8K0lFUMcmqWQYUbR9mm3ygVXHMGKgpzTJz7DSqkX+9xJ2u3BKRLBd1
	 CkRftbbHv59bhtbkHrVgoWjpYkn3jHnJROgvWk/1KKQK5bl92zqHOzdnbnQviS4EMOsEa
	 Lx0f9xHiGVB51qVVOE8aZo/BSTgfvMQNL6Q+WWKlchXdJnnJLjWurH4I6/5dbo1cgYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792601581;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=pKVlIvSF3bgj4NKmyst/GQOZtuCqamm6OCIrIl39yS8=;
	b=eCT8Hm+yIucgTylWRQjBFDrDzuSugf4FNWQVdhF1JN0l9g0ZlfQF/soSjkmNN1zIymKK
	 HMbuhm9jV7vL3nUK1cCrZ3//fZrp0h2BYDz7Fh5k5OhKyG4127R6rU/RFo0XVTFYrFO7j
	 lP2NeTQLLnt7ldB+PktYxEIfEPu8cEbmI1EMv1BVkU3ruHCDEqDiSBNjc0jYcqFjk9a/A
	 T+34ej+gKjyAidOT8TxSHPCYqldn+5M48w2KBjPYulrhI8+XEqzXUkhGmkSTLrjjETYu6
	 frFSfOuBu/BOwunyqglXzqyvaNqEPrBANVA9gybWVVQdufieJsggyqLqG31HBGvFZmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qmbwvlpD;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C45B606A31D
	for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 16:53:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C45B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qmbwvlpD
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-156cbe59622so662071c88.0
        for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 09:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792601580; x=1793206380; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pKVlIvSF3bgj4NKmyst/GQOZtuCqamm6OCIrIl39yS8=;
        b=qmbwvlpDjjnvN+ojyDVZMh4S/iXYFHextf/p4m9ZyuKDJw8yp4XS5IVGfxc7T0kIwz
         HBuaORpQGk3pTdC1lnVV0qHf/leap+KQONIw/DTJpmbK40VFfvr0Pq7U0GS+JIvTgXEG
         2YquSH2LTMrcpTsI3MreKRpqLGekFDCqH9eVgfchdHPNBQHlWsB+cGebsi/zY+9vSlo8
         rJJxdvmqHFAk1xm0RwcKaKhslv0n643FcuctDdz9lZgj6/Lu7IZjhMO6EW9HPjdXR7Rg
         HlFF9KYbxy96QZGw6Mrl1K7YoL5YKGEwyI/Rjfgqu/FynbzUzjspX2rWXDL4KgmmIyac
         Wx4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792601580; x=1793206380;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pKVlIvSF3bgj4NKmyst/GQOZtuCqamm6OCIrIl39yS8=;
        b=NencEqiy6UoOaSp/yUytCAiNGCox9N0w4QEToJCxo1Rb3hXvvAexN2iYzA7qSjF+kw
         3fOVaZWcF9bK4okMADwS+MYUIX1NQ2CJ3qbQqXsojEEthD2Qag3c5AjgDElb0QG1urxN
         QjLzdawoftY5zeVs5ZP5xt9qoKOTm85IEtiDPoEdfQ0arDEHbYs7mbJJTJlcjgLe2MH7
         XCoyqs6Qlo7tkD7lkbBkrdx2UQ0qylrjcpU07nz5+/cuBFP4c/uDN0EZvhKwb51n+9un
         OUiz6cO22qsZqCivIMwW8VuuI9inLa6Ywz5bo0Y6bJck2quhZj+DIkYUpyTIdKD3NmAi
         X3Uw==
X-Forwarded-Encrypted: i=1; AKwUvBx9knJp3DGs2jBnq4lpqa7FWAuzy1legQKDXR+r2ZG5rf/wUVqUaZPaThmxmqVQJ69Nxtu3qSu+BsVkDA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ1zoX/I3Mn8qEF3Bsqp53T8RV0GE944zIjI+eC965sfcEB5yU5
	azi/e7r6/e3ftx9I1lH6qjIAlc7J0PPWFGM7ODQYXpxHua8HABp5ryH3
X-Gm-Gg: AYBFou0CgvAPqdl9K8nrzo/n33mZE5NXxrciNKg38JLVRL/3UqIGs378JBZYmMU0YNh
	qff47t1fTStaNNuHeXBXN27pT4djAnf5lqBC1bw4LVWrZoJr4rZTHfsszi8aVVeY8n0z7psHDsV
	PDNtMqV+y62uYtmBEU+UuMe7r0bJCX81bAkfjQ5SLOPSl3n/LzcUlxQQGQ3Pj1h9jyGTS53McuA
	ESAkQijAByPowrh2Yw08QkbQOgZ3RCs3xgOolLAEUYJs00GXaC/UD78OZFEOWdva/LYKS7Grijh
	r0+MAd5a86Hok23HaYm32UlDv1VP5km94VCeJ/AmJY9MrWBOZiDfoSFzRFl7fljoyVnpscc/BBs
	aVKJvbDQhiBzQzjFjc6kiKo52SeR9BixGmKzrhqjyDKUp0aQXye9L73/m9glCtzGR7gn40nGVTk
	EqzXsxBnyLlrV/BnILK/UpXeBR644rb7l6D5OJ7MTUIa7EBsmsXIf4u18ZveHntdxHXws3Xo/uf
	IRBEvz67MyTnNafRY2jLtNIYsWXqirQRGVmu7CHl5hqh/xhxX5TWiT3kcz2W4ixBqtI0oBsAs84
	EHK8GocNUOQxZNboTy36zg==
X-Received: by 2002:a05:701b:260c:b0:18a:6c40:1a35 with SMTP id a92af1059eb24-190a4e0f52emr2922497c88.20.1792601580385;
        Wed, 21 Oct 2026 09:53:00 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:92d1:8038:c4e7:1f0c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903e02901fsm7779991c88.22.2026.10.21.09.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 09:52:59 -0700 (PDT)
Date: Wed, 21 Oct 2026 09:52:56 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Lee Jones <lee@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Shi Hao <i.shihao.999@gmail.com>, Rachna Patil <rachna@ti.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	mfd@lists.linux.dev
Subject: Re: [PATCH 28/28] mfd: ti_am335x_tscadc: Remove redundant
 ti_tscadc_dev_get() helper
Message-ID: <atjtywLzWKxoddD7@google.com>
References: <20261021121245.3111563-1-lee@kernel.org>
 <20261021121245.3111563-28-lee@kernel.org>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021121245.3111563-28-lee@kernel.org>

On Wed, Oct 21, 2026 at 12:09:50PM +0000, Lee Jones wrote:
> Now that ti_tscadc_dev_get() is a single-line wrapper around
> dev_get_drvdata(p->dev.parent), remove the bespoke helper and retrieve
> the parent driver data directly in the child ADC and touchscreen
> drivers.
> 
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  drivers/iio/adc/ti_am335x_adc.c           | 2 +-
>  drivers/input/touchscreen/ti_am335x_tsc.c | 2 +-

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com> # for input

Thanks.

-- 
Dmitry
