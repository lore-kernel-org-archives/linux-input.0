Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BA240B6F4
	for <linux-input@vger.kernel.org>; Tue, 26 May 2026 17:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779816987; cv=none; b=bpvdsWc+MT+FfBlwyNHX5S7+Vx2VqU+c9m629ZyeuT8jSVV59JW1QBcQFaOmds3Fym5Q817wJc16fT2Gxp1lWFiK0hk4eHxX8wrRTiHmzh93YC8G3XHvAht58bVYtE3shYwXuox5P0cWQNts+i/jSjebJPm1qI4Ogc9k8RKZytw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779816987; c=relaxed/simple;
	bh=itptXuNe4ygUJvTHoay1T9eFRWRgrelgdM2TdraIkac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9JDpLQvxs06pNwj+1Pltnzj9x0z+hC0/FFu0qbJQVQCK/CBKPvytbA2lHg72iXg5sYLpksvQxbf89LWHagezGaWMPF0mKKpFtP6b59Nvr9k8oIAJ3lgS/cVa4cWp+b+DozOYtTlWlvMTEoGDrYsd0vtM04LZqN/THU1bLYqgOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E52GbOQe; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E52GbOQe"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1363e78746eso6224657c88.1
        for <linux-input@vger.kernel.org>; Tue, 26 May 2026 10:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779816985; x=1780421785; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y6BSuOR6NYcvyJ2FNhs6DvFNJ6pd+/sZduNctzVkyME=;
        b=E52GbOQevGEBxOQPl1qxQB0dUsn97zS5LR9l+3oZBlol4j1ufFoX8qVQMWTVPTpSTi
         Wxvthh2TON2z7OYKaP7g8y8xSB3tH+LjSS0e/chjZ5e71JxKpNA/+h/oborbyd/IMy5P
         32zDvu+5Ulf+giwNWsUceGWHmKfz0/cwdp7LFOA9kGIfyfXSwj+UFWWcfhuPpfwjUojx
         rTzweKTQzHpQngjSflXX16ZHFWKaG4MTldw5zlHALSa/ekPldrIXlOWoOw2i0fjyD6cq
         IlLoDvRxSRoEOxAzzPQCW78Wp3yvqovumqpMWEv7tPdHTdBsEvBH15mhjNGyyiNh2EUH
         7oYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779816985; x=1780421785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y6BSuOR6NYcvyJ2FNhs6DvFNJ6pd+/sZduNctzVkyME=;
        b=M2Mg9HQhPAR2HpcJJqPUAoybl7cm5yjGqXE4sOzFTrhfHYqgDS7Jf2DNAPb70njdd7
         stp3aaZOY/WDnPajY2Je2FGifMzvjPJ6k6c3mZEBkBG6JpgYQ2ho+fb5eTTKnuCsr+go
         KKMGTKD3uTc6YiVPXo5vl647Hlp1hSGTGQHkYhdrGj7LR6hpCtqro90sRbwIt7KbM31I
         PL7sHizXQ/GngujC6CEXHCNlaFk+tOUK/NFOM8VMTdofWyfbA97D5dll+NEHD3CJAeG+
         QTFH04x47A8cBzvafnC6zeZCLsogVDYsR2g+EBrg11f1WUCQefd6zhRjIrl9TWKMjZ8h
         O1hQ==
X-Gm-Message-State: AOJu0Yzc2lIJ+wiPGAulyG/0HZ2YSVLTheiR66ZHIMBPxgS6nWviPbUB
	Kgqjr0eDBdwUdhiLQh/k6FMdQERYK0zIJ4MGGH+6u7AQr2GSWCG+lH9j
X-Gm-Gg: Acq92OHeTKKlDNzgZsoflMztx9O9if01jEctpF15wnQPtv73fG8qg3xXRVe10MSi95y
	2XK+IXwvVT8RbXwdBU18ByyYekSoASCvA1yzmZg3pE9h1MfAcJMxesNukUU7A1ittcSpzkO3k5B
	gjr7FpZm2HJhaI8pc2EePpW1DZUN7q73exnysxEOpnlElv1icrlJsgbTmHiJvOnHCXg4e7gt7Vu
	W25BNtzVuj1T8q4XkysFApxaa1GhwSPdsfyZ4I20NaMT/dyEsppupLoIIES2nXOMgyA9sskrwcw
	OfjXGN1Ked+2bk2yfdntQWhoiS9pQwLvCC98GcpRHe7bzAhtLh/qgwlB2Mnjvyn1FnZHuFtbza9
	/2+5ZXgEZucuZbkB0TQMtEFIOxp4fnGL8JIwkSikqnxdXjDOXmnbh4XL+rlDWfJowkJWEwjcXZ2
	oMGPFxJcXPLXG8Iub3weFVjLlgY+7gnpvelyEn8xHoNgZV2zBefavC1MPE0sDY68mv
X-Received: by 2002:a05:7022:f206:b0:136:e639:9c14 with SMTP id a92af1059eb24-136e6399e60mr2835502c88.30.1779816984904;
        Tue, 26 May 2026 10:36:24 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:912f:eb49:d713:7401])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-136b3706ad6sm6655781c88.13.2026.05.26.10.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 10:36:24 -0700 (PDT)
Date: Tue, 26 May 2026 10:36:08 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Myeonghun Pak <mhun512@gmail.com>, Hans Verkuil <hverkuil@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Subject: Re: [PATCH] Input: rmi4 - release F54 queue on video registration
 failure
Message-ID: <ahXYreASLGSPuIe_@google.com>
References: <20260524182351.27658-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260524182351.27658-1-mhun512@gmail.com>

On Mon, May 25, 2026 at 03:23:45AM +0900, Myeonghun Pak wrote:
> rmi_f54_probe() initializes the videobuf2 queue before registering the
> video device. If video_register_device() fails, probe only unregisters
> the V4L2 device and leaves the initialized queue unwound by neither
> remove nor file release paths.
> 
> Release the queue before continuing through the existing probe error
> path.
> 
> This issue was identified during our ongoing static-analysis research while
> reviewing kernel code.
> 
> Fixes: 3a762dbd5347 ("[media] Input: synaptics-rmi4 - add support for F54 diagnostics")
> Cc: stable@vger.kernel.org
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
>  drivers/input/rmi4/rmi_f54.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/rmi4/rmi_f54.c b/drivers/input/rmi4/rmi_f54.c
> index 61909e1a39..fca7b9fec5 100644
> --- a/drivers/input/rmi4/rmi_f54.c
> +++ b/drivers/input/rmi4/rmi_f54.c
> @@ -722,6 +722,7 @@ static int rmi_f54_probe(struct rmi_function *fn)
>  	ret = video_register_device(&f54->vdev, VFL_TYPE_TOUCH, -1);
>  	if (ret) {
>  		dev_err(&fn->dev, "Unable to register video subdevice.");
> +		vb2_queue_release(&f54->queue);
>  		goto remove_v4l2;
>  	}
>  

Hans, could you please Ack or Nak it? It is unclear to me if this
cleanup is mandatory and whether it is also needed in rmi_f54_remove().

Thanks.

-- 
Dmitry
