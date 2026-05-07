Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357AF38238F
	for <linux-input@vger.kernel.org>; Thu,  7 May 2026 17:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778173248; cv=none; b=INqh5BGGHgOAmUbBen110BYuhVnQen/QXS7KpmKRlJ6siSMgbBWHYOEmYff9Uc3IxqvS3FBKmD9SmvgyHVs3VcoHFuAF1QmfVFrw96LsQvHFtHI//TSmjMHEbswpeuDVXwVbUTPa7atdutb/Iq/lissCu9dUDUb+LF79E0ihxcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778173248; c=relaxed/simple;
	bh=1MY0S1NrSLlFDa5YncGRvWO886u0CmCXtc+ubK184a4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eguAt8QTrApvDpXV/b7DBV50z7Ykq6kAdCKmDMEofq8xtK0eBRdLZmXz1ItUhwjQzV0xvHqoggaH8rpuXqVFpfK2uG6kX950tcRtu+CoMTkfHt5wHzRxj/UwOu4Z1ye4va7P/i20I+JA3w419NQyx4iE+bVyRgJVZYnDjS5bOSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KX6y4fyq; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KX6y4fyq"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2f00a567cfaso1465471eec.0
        for <linux-input@vger.kernel.org>; Thu, 07 May 2026 10:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778173246; x=1778778046; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q/aYnHghjmowXqI8WvBgOLTVpcMJSrTJbA0f1MMN/YE=;
        b=KX6y4fyqfKkHyQc6K7ULhpWbbVfPJhJlxv6uPVaQ8hT1h2mYzcH8oT9XN+tbtWotx2
         f0X/fH95iXPKFwQDnOUHTYNtoT4+2TToD6i+ubDCMdjI3RvRjayaHWjDjAt4e9d7FUpM
         E4abof6w/KGpVOsetQWvClOr1OOrEujWW50afAi5Ly3v3XhitYcv7oFR7VWzM3MEmFPd
         rj7EKFNJG9bybbKbqiQugMkSTkxEN3f2JI7nhbxtN4TCM9c7OQ1UZoQRhxO/fXMXtTqR
         /0QvXB3rzP+urjYRT6OtA2MeZtS4Q/aL30+2K+V/B3VAliW9qeA+28jOMKt/3eYauGf5
         g+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778173246; x=1778778046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q/aYnHghjmowXqI8WvBgOLTVpcMJSrTJbA0f1MMN/YE=;
        b=HGH7nC8ADdd+oIROyUgg2awiKJU/Y4L4dmiqt6jXrYK0Qo+GffJs43i64Yu8xgbbgs
         vb/gU6BOIEMAGQZLdemHb/JeYaPMleSgK1ulFoPxJu3ZkdCJrws1xn4oI3VbHyRlZWL1
         GQ3f0TOh0lzZum0XFiuSLZHPOZ8n+hNxZ+pLJ8OgXqvte8ynggTd0Ip8Fr+jtcj0XHnu
         rfuVk4fILlAgpwpegXVr5VOOCmK9HK4T6LJ8T/+El8F7j7JtvxhZAZDFc3mdA/BrDyYh
         2MztVUcdTQlMYyPVtqXdXwwBNn0TkuSAyVyB1H3lWPQrArVBQJOJMmlKRF2sxArlhn2p
         sR/Q==
X-Forwarded-Encrypted: i=1; AFNElJ8p6RoAaImg3RUDdvoh1gsVYKbwe/aA7shLpTWdMI17ZLiTNdrUAuAzDpdP0QRNb1h25spjM+xG09lFCg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPaUweQonFNGKHoW2kzvtOcOM+e8C6IZ0pXo8i+NnaglAGwp+R
	G712RcU9MmP/7cAcssiSrQnj7b5Q+aBA6A2bKZvz7+5TmlYNGPJInp6+
X-Gm-Gg: AeBDieusUgUyPoI7W1NQyyvzX5PC/+6gPFBlBOI6I1tG9KoWPEyxKd9X6X3trJ89qDH
	wsGk3dm6CXdSChgsVdeAziLDS8M24+HetX7uo/AUnjK25GyVREzyXzuVtNOCuau9izT10zXG4zf
	qYBI9R3uHCh5uzN5svaJMAWMlzFi2bzhf/+N1pYwvVFv6OcrXJHjrkXYP7+KhJQjTdf4FvdNB0V
	8CAwZ0F09RZcG8lWAT4hRdgSOfPWl5HVQbtf5to2540Z48cpz+/AttJTin2puboF3YCztjfknBS
	q1cQFzb9+O508kJZMZiQc2qMgF5KBbqCGtqaEbjRjWwESU3A3tKR7ccHWzIhTE2EaE7GMXhHPfV
	MANLdIyXimNFDGr5Iq5sOUCeeenD2MQg3mZfwDKA5FST80A0dUwIz38AM5quIeiznkj8PPvacvr
	fRtsQIirZW9I63qpqlhBJv7QFMrHg9GZiJGARZE6eHr9Y8LvyinzVMZBeOgwODFxMccogvI1kzL
	OQ=
X-Received: by 2002:a05:7300:148c:b0:2c1:67e1:61a9 with SMTP id 5a478bee46e88-2f6e4374892mr1554113eec.13.1778173245923;
        Thu, 07 May 2026 10:00:45 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:6a50:9473:7750:56ef])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f56cec58efsm8840117eec.2.2026.05.07.10.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 10:00:45 -0700 (PDT)
Date: Thu, 7 May 2026 10:00:42 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Kris Bahnsen <kris@embeddedts.com>, Marek Vasut <marex@denx.de>
Cc: stable@vger.kernel.org, Mark Featherston <mark@embeddedts.com>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] Input: ads7846 - don't use scratch for tx_buf when
 clearing register
Message-ID: <afzE9QC-4KB6jUNF@google.com>
References: <20260507164943.760009-1-kris@embeddedTS.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507164943.760009-1-kris@embeddedTS.com>

On Thu, May 07, 2026 at 04:49:43PM +0000, Kris Bahnsen wrote:
> The workaround for XPT2046 clears the command register, giving the
> touchscreen controller a NOP. The change incorrectly re-uses the
> req->scratch variable which is used as rx_buf for xfer[5], so by
> the time xfer[6] occurs, the contents of req->scratch may not be
> 0. It was found that the touchscreen controller can end up in
> a completely unresponsive state due to it being given a command
> the driver does not expect.
> 
> Instead, rely on the spi_transfer behavior of tx_buf being NULL to
> transmit all 0 bits and use the scratch variable for the rx_buf for
> both the 1 byte command to and 2 byte response from the controller.
> 
> Also relocates the scratch member of struct ser_req to force it
> into a different cache line to prevent any potential issues of
> DMA stepping on unrelated data in other struct members due to
> sharing the same cache line.
> 
> This change was tested on real TSC2046 and ADS7843 controllers,
> but not the XPT2046 the workaround was originally created for.
> Confirming that the original modification to clear the command
> register does not impact either real controller.
> 
> Fixes: 781a07da9bb94 ("Input: ads7846 - add dummy command register clearing cycle")
> Cc: stable@vger.kernel.org
> Co-developed-by: Mark Featherston <mark@embeddedTS.com>
> Signed-off-by: Mark Featherston <mark@embeddedTS.com>
> Signed-off-by: Kris Bahnsen <kris@embeddedTS.com>
> ---
> 
> V1 -> V2: Don't use rx_buf when clearing command reg
> V2 -> V3: Modify original 2 xfer command to eliminate dev_err()
>           output on xfer with len and NULL buffers
> V3 -> V4: Move scratch to end of ser_req to force it to a new
>           cache line.
> 
> V4 Note:  Change to moving scratch was tested against an SPI
>           controller without DMA. We do not currently have a
>           platform using this controller on an SPI bus supporting
>           DMA.


Marek, any chance you could give it a quick spin?

Thanks!

-- 
Dmitry
