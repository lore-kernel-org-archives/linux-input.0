Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FD5296BCD
	for <linux-input@vger.kernel.org>; Sun, 26 Apr 2026 04:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777179067; cv=none; b=QyJjX3pzvXpMbvCsCdXGTUU44Qlv+NWX+wzP1qPdOU7XxTlievFqiZByuSu+SrcXp3JrN8xzBM7KoTPJF9ddUe0oZo41046v/9XpjSVApwkHYPVzrZdNpO2h6n9xSFGIXJfvD0qo3MXL0hT3LiLb0p+m3hAKzgDni/NnstlSvPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777179067; c=relaxed/simple;
	bh=4/1dm9v2x6HqLfmARPOK2LRXOfRfLUHSz+Wlm2pqaJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H8MIYG5sw2cicWE/a3bOw8VU/zy4corx1aU2phC1MUGmiMzJEHPUF+h+zaAriX1Me+uTt5FjWvEJ42DJghVimEZdwG5mJeSE3yNijAWOK+t2bYq8Ct60hRuHeYJDQxhv1mX57gKHB4ydnO+fqu2zEm655CqXWSUBjU/0ca4okdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RPR+b6v8; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPR+b6v8"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12db7bf1541so5951192c88.0
        for <linux-input@vger.kernel.org>; Sat, 25 Apr 2026 21:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777179065; x=1777783865; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+vaOJDGyw3wxp09UGOcbQa5slZ7g91u9irMmTCg27/0=;
        b=RPR+b6v8QzBK5bG1zRpsnSK5Y3ivVVnBRnXexn1bqRrg9M+x62REsWb9rXm93ArfD0
         i3rF346hGODFIr2ajhhCx0PR49CWNMM5hhA74+FU+REzNPNLROb2SRcFB3S4Cq0DO0IJ
         l4J5IdoMy+hIa2eyvrxau3vFqJ+xh+AbehmfEKmLl/wF86zGzsQzOlQ55aGKXdr2cx7r
         tpG4+dHnxmgY6sEhL+8iTGybqVPQHcxfV+BpZ//NJGnKTM76Bq8gnIX0Y+KU2sINiBdf
         0miv3y6DGihN2leyxhiCo4ZXTmgFxWxHAlZ6UMffG4eRqBM7RICDdkSxk+iQju2A4unQ
         zeiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777179065; x=1777783865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+vaOJDGyw3wxp09UGOcbQa5slZ7g91u9irMmTCg27/0=;
        b=EP/ap9adqI4C5sqKpFGdm4ep7L/8RNHYmzkNWd1sROqh2ncdU+pGppJgS47SsbaGxB
         K498qKg/KqLPXy1HENjUf9jmniqJ9lGBxxLwS7PYiuf9eVTnD1Pp1Z/gvAXO8SbpHPzm
         ORfYQhtB/aDWtqyNh5vtgnpKhV+iJKqgTbsXfUsCWElh1MlvM8okwb3Wgonj5G07PWQk
         PQ2KRpoFHqkXuYadGAMn1HgI6XimvLosMxwtENVNELJVM9yGoCvbWCn5CZ8YnyJE+38i
         wkTKl1B4DVLlhbgdI7/wdecj86XWKsxuVMGiQlCEyUpUb7lIEyFGoAmG5FCulFRCsY26
         YuiA==
X-Forwarded-Encrypted: i=1; AFNElJ8i51QwxNvFgR0WVuL/fcSeAeTNcwhFvymov1qvCP8shf7JE+nwC9yMsJuXNkPM/dKB9asfUT0eM72RPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz1tr5zb7Z3k6Tn1Q1X7pwSBYqsolce+fWzdW2OE8Uv481/nOa
	2ZdqMAv/6gKDe7pLlGzxI8FwAH7HoeC8ZMWnlBUOxsx2g9ttNhyWkyqUbYCf/w==
X-Gm-Gg: AeBDietXb1Qes2s8u6K7cAmpe4Jzctp5AGa1iKkA6z/z/Hdyy80IZxbyRBaXTcwF1O0
	Wk9Bv1xxDHaFkfY50JVGQu6s/mpORcmBshB97GV4KDTMOAfDqhRkqPje2gI8dlSJxrTsJWxlbYe
	gjOCJEJayVswYpsmAklomNFcLStsFuASnmoA/26pIB+MXERXYOLEIBoQb1q/iEQcOWh/HtBLkTu
	NegSydzkaKUwrIbdvvO9Htqf7oKDSV+Q9UuTGofsexcNrtj2i6bCmx3BQ0NBex1XI8qkKaD2Iq5
	jVdMZKDSFF8zpjiTDYLLFHtIM3LxgFr6w39CYW7QE2o0IR9XapLn0dBeDBkciTXklZnW11FbREM
	CTmhOEpQbZWRP8bD86BlekEXg0UfkGTUW7JZapffjpWu4BTzkux/YM0XTOH3yf06ZrzppL/Nwza
	etAVGuIlFGxL6JfMcAUqfEPMraeusASrVZ1V6IqZEJCnsw0iwzBIShN3vciTgd/so+p7723ZI0v
	5I=
X-Received: by 2002:a05:7022:ea2c:b0:128:dbbf:fd35 with SMTP id a92af1059eb24-12c73fa3c01mr20631223c88.28.1777179064969;
        Sat, 25 Apr 2026 21:51:04 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:f359:aa0c:530d:9dfd])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c919266f6sm38343163c88.1.2026.04.25.21.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 21:51:04 -0700 (PDT)
Date: Sat, 25 Apr 2026 21:51:01 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Kris Bahnsen <kris@embeddedts.com>
Cc: Marek Vasut <marex@denx.de>, stable@vger.kernel.org, 
	Mark Featherston <mark@embeddedts.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: ads7846 - don't use scratch for tx_buf when
 clearing register
Message-ID: <ae2YWxew6M03MFfN@google.com>
References: <20260424192534.3504976-1-kris@embeddedTS.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424192534.3504976-1-kris@embeddedTS.com>

Hi Kris,

On Fri, Apr 24, 2026 at 07:25:34PM +0000, Kris Bahnsen wrote:
> The workaround for XPT2046 clears the command register, giving the
> touchscreen controller a NOP. The change incorrectly re-uses the
> req->scratch variable which is used as rx_buf for xfer[5], so by
> the time xfer[6] occurs, the contents of req->scratch may not be
> 0. It was found that the touchscreen controller can end up in
> a completely unresponsive state due to it being given a command
> the driver does not expect.
> 
> Instead, rely on the spi_transfer behavior of tx_buf being NULL to
> transmit all 0 bits, moving the 3 bytes to a single message.
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
>  drivers/input/touchscreen/ads7846.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
> index 4b39f7212d35c..599793d27129e 100644
> --- a/drivers/input/touchscreen/ads7846.c
> +++ b/drivers/input/touchscreen/ads7846.c
> @@ -327,7 +327,7 @@ struct ser_req {
>  	u8			ref_off;
>  	u16			scratch;
>  	struct spi_message	msg;
> -	struct spi_transfer	xfer[8];
> +	struct spi_transfer	xfer[7];
>  	/*
>  	 * DMA (thus cache coherency maintenance) requires the
>  	 * transfer buffers to live in their own cache lines.
> @@ -403,16 +403,11 @@ static int ads7846_read12_ser(struct device *dev, unsigned command)
>  	spi_message_add_tail(&req->xfer[5], &req->msg);
>  
>  	/* clear the command register */
> -	req->scratch = 0;
> -	req->xfer[6].tx_buf = &req->scratch;
> -	req->xfer[6].len = 1;
> +	req->xfer[6].rx_buf = &req->scratch;
> +	req->xfer[6].len = 3;

Doesn't this overflow "scratch" which is only 2 bytes? I guess there is
a hole in ser_req between "scratch" and "msg" but I do not think we
should rely on this.

Can we also set rx_buf to NULL to discard incoming data?

[credit to sashiko].

Thanks.

-- 
Dmitry
