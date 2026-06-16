Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A963A7186
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 21:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781647116; cv=none; b=WRZuu0HjdM3Yla5uDRjn89NlTF6VGqPbbpl/0Ec5mSISKVQOIHkYCPo1VIsOdJE3LPzDP6gb7CgdNsqA96cqEX0acV6Vz6AZg8ctdKJdnTzszewJkdu6GVcVnZN/FIwMQXYnyL3JgRqMASKdmggi+zUmuQIAFwRZBKbhpMMvz/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781647116; c=relaxed/simple;
	bh=TUL2ScTsGCBuIW2spL9RwoyzEdmzcDOWEknnSt1OmXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GfFHKlzHasHFbyRvQraHGYoNF5zk+lcx5CBOyyrSCJk2xk6YWAnxxR0CPBYIVxtL/nU2WZjaEXj2M3yJ3ZAZfRBIeHX1CPd4emZ9AOIbWLwPkTZCMsO/phnvS/trk3wIgU8uq3Ka0PAwSWucjm9DKs+pzQ49KZHr5mBOw7NoKx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c1sMwJxU; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1sMwJxU"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1390f75d8bbso179560c88.0
        for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 14:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781647115; x=1782251915; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=roy+a2u4dACZbIrirt8cSDMEMY/YbV6SsjtIG8GRuJU=;
        b=c1sMwJxUTvvdoekqYBP8BgDIImNZsrFsBmd9Fhf4evnOtuoRVrYAQBumJzoVkQqvv7
         K2Tli5ijiodoMwWRQ6uuT5V8FMncvi8L7ezO6wmfCwi21o3NzC9WZENEj2Y9WbDgWYwR
         4ufaViyQmgjnZKvKDtHhW0/k9OcCXBfZpjiHoiQWRzztCpkvDujV5QUbHa0MjZ7Q1Md0
         XKZ3FbCo7dxvISs/A5ItD+t2VzUTQzXT9DkI9gkNN8FRY8RpP9khTdOh19urgGP1iubp
         hRJVUN+x9lqy8RCCLJHa9ePs3rysHre/L4dGuUVamUDPunsOrpN6Xsts39tkCdAtwiVc
         e6Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781647115; x=1782251915;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=roy+a2u4dACZbIrirt8cSDMEMY/YbV6SsjtIG8GRuJU=;
        b=d4GbdsXshFCxCPlrQKsM9Y5befgFmgrRITxwVNnWx0ZuJZhMHShvzK8jhOqspAmHD9
         rQbsL46vK72Nybq9igMdqK6UlLV4cqOdyImB86OhAnnMTuCEW9QV63MCKZMoz8pcJGqR
         zrrrRA6pBOHdaHFCzAb94t1NKxKRsKO11BePnlFDN7EwRdhg/6fGST0TZCYhkEh9AO7Q
         o3p4itYPqRE7v1gyz5DWf9eiPAarh/sjoI5JaR+6YeiwdVyFkLwyQ+mL/8eeG8+IboR5
         GWP8w6HA6bK7/n6VWuLbu9wBh2xzi6CHAIAwpOmwse8BxjHfwgB7nl8ARdtSlhW22zwh
         gXeA==
X-Gm-Message-State: AOJu0YxqUyAWy4Lz4GFZ8KJ2gzTqTr1tcJJkepb9QKhRaqajjr0r3qVB
	WBW6Ha9s1S4GKxweZ3ubjwxNBJONT+KnBliMoJ1qgW/xIksszIjs3YAv
X-Gm-Gg: Acq92OHwaHvO/zD1sZwFkR9NFc12X083DaPMD06KObn3GIQSXZh3+tSmA9T69Nl8K4K
	1C/NH1M+hXEAKEoywcGy+aoiNB6znhtusgdCEEM4QqgcK+9dIU1K3qKOxIF8FLTsLC4AsZfd/yD
	cWLX9pjCfOlZozI8W5N7l/lPS9sLqdXwO+Vc/XqptwhFLEbWGJK8aXyJ8ZeOlLd8TCBKODgpN/G
	UT+XHbNydhemnYS3lAqOYzjWGIAN3a4KKKdIzS1kO0S+26sdt/Waxl27qZhraWhMxWHd4N/EZPw
	8lBE1oCaw+/u2Rmk+yx+GzIOvGipQRymJCldNQkp2mFy/YjVyjv5xZ3YqwWllAVtGAdq07xsHkA
	+B20z+mY0NLOz4crO3is+2a287xEMF7oeGR+TF5IeGZ8m3qGpiuhCOT8WlZiyt7jheweqY2Yi3o
	m3agTMUyYpAaklSj1Km9JrHDW17lxAUu2mj5rSmfum7UtkIrW97b+YDb1zETC1/G+sWNluFBrGr
	g==
X-Received: by 2002:a05:7022:fe05:b0:137:f58c:3cb5 with SMTP id a92af1059eb24-1398f6dd9dcmr473410c88.26.1781647114733;
        Tue, 16 Jun 2026 14:58:34 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:cbae:d24:189c:2cb9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1384b9815a6sm15110447c88.15.2026.06.16.14.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 14:58:33 -0700 (PDT)
Date: Tue, 16 Jun 2026 14:58:31 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Bryam Vargas <hexlabsecurity@proton.me>
Cc: linux-input@vger.kernel.org, Linus Walleij <linusw@kernel.org>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] Input: mms114 - fix touch indexing for MMS134S and
 MMS136
Message-ID: <ajHGfk7pCYltjOm3@google.com>
References: <20260616050912.1531241-1-dmitry.torokhov@gmail.com>
 <20260616070529.156342-1-hexlabsecurity@proton.me>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616070529.156342-1-hexlabsecurity@proton.me>

Hi Bryam,

On Tue, Jun 16, 2026 at 07:05:34AM +0000, Bryam Vargas wrote:
> Hi Dmitry,
> 
> The indexing fix looks correct -- deriving the byte offset from event_size
> instead of leaning on sizeof(struct mms114_touch) is the right call, and the
> cast is fine since the struct is __packed (no alignment issue at the 6-byte
> stride, and the consumers only touch bytes 0..5).
> 
> Two things that might be worth folding into the series:
> 
> 1) Fixes: tag.  The 6-byte event path for MMS136 -- and therefore this
>    stride-vs-index mismatch -- predates ab108678195f.  It was introduced in
> 
>        53fefdd1d3a3 ("Input: mms114 - support MMS136")
> 
>    which added MMS136_EVENT_SIZE and the "packet_size / MMS136_EVENT_SIZE"
>    branch while the loop already indexed with the 8-byte struct stride;
>    ab108678195f ("support MMS134S") only extended that branch to MMS134S.
>    So MMS136 hardware has mis-parsed multi-touch since v5.13.  Tagging
> 
>        Fixes: 53fefdd1d3a3 ("Input: mms114 - support MMS136")
> 
>    (in addition to, or instead of, ab108678195f) lets stable pick it up for
>    the MMS136 range as well.

Thanks, I'll update the tag.

> 
> 2) Unbounded packet_size.  Since 1/6 already rewrites this handler: packet_size
>    comes straight from the device's PACKET_SIZE register (a single byte, so
>    1..255 after the "<= 0" guard) and is then used unclamped both as the read
>    length
> 
>        __mms114_read_reg(data, MMS114_INFORMATION, packet_size, (u8 *)touch);
> 
>    into the 80-byte touch[MMS114_MAX_TOUCH] stack buffer, and as the divisor
>    for touch_size -- which is never bounded by MMS114_MAX_TOUCH.  A device that
>    reports packet_size > 80 overflows the stack buffer on the read, and even
>    with the indexing fix the loop still walks past it (touch_size > 10).  A
>    one-liner before the division closes both:
> 
>        if (packet_size <= 0)
>                goto out;
>    +   packet_size = min_t(int, packet_size, sizeof(touch));
> 
>    This one is pre-existing -- the unbounded read goes back to the original
>    driver -- so it is really a separate patch in the series rather than part
>    of the indexing fix, but it seemed worth raising while the code is in
>    flight.

This is fixed by the patch you sent earlier, right? It's been applied so
I did not send it out again with the series.

Thank you for looking at this, please do not hesitate to add your
Reviewed-by to any patches that you are satisfied with.

Thanks.

-- 
Dmitry
