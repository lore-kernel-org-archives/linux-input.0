Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938F83AD51F
	for <linux-input@vger.kernel.org>; Fri, 29 May 2026 19:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780083076; cv=none; b=UHIGMswQlAFyrw/wQ+E+R0hKhU7UYLM5xpiKbHFAHbVYgD+bERUjiEWxE3/BgAFZ8A3dD0WA9YjczP2zXDsHuUj1BWrDrr8hvj4a/q7qb3bE0YDQIjR21UPPE/3viwObhKi+eGZKirmSzCUNMeLYGIEETQjDE7j2fBv6TlfKt38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780083076; c=relaxed/simple;
	bh=zSJ4kB4tDIOBKRki3ZLehnLNadR+84J/X2etwho5jMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYHFZmfsSVMwLAOnRlQTr//TgzLevwDtx+4RkJfHLjGyTWdrYUG4mBzYbUrDvIO4qBGniRLBDycU7wRxrOLJTaaASjplfFFemtjAyMcheaMC5NkOpxsoG6FkM6lC2deubW24XS5quOMCFNJy8Eqwj/v6cGN75fg/AtncFAAyDYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mjMYfz6w; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjMYfz6w"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-304e6c6464dso2913212eec.1
        for <linux-input@vger.kernel.org>; Fri, 29 May 2026 12:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780083074; x=1780687874; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6YZwbJmOdj/CzDOJRzvaxizYubzK8nMz96rk/mNhROM=;
        b=mjMYfz6wGEPLh7wkt52IxKisSFcuB9mEu76Jck4vDbmAOZEo+1NemqRNVfwAkvEEe1
         Ns9jLKmtUiVNOLMZ35dA8RqP7KqgzU5olzzh7IeLnRjdxh5EDUAT10UENKOYOeKIknEK
         07q2jKz/yGNHUhXrQHwTbBey3DPgxJviEmRXMRzE8DpK4E8/+PQ0Tf2LtuoWw5Ed7Ul5
         01RNE/99w2eVOgtw3yPwcRotMkgqAeodclzNac1AiNsGJnJVqhHIpigUxnlb3DZQdRR5
         ciFDvVL7++9YeTaBnt/W70ecwp74xYw4oiER03Xlvm+wtia4KzQA0sVJcEjPoKg0V6UT
         npwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780083074; x=1780687874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6YZwbJmOdj/CzDOJRzvaxizYubzK8nMz96rk/mNhROM=;
        b=WwdMQWBn+9/yF2EDWqEib/HRzdtCF3Bdsy/UjPIBsUs9ktnNuVqpZFF4jdgzgJE7LN
         Ri7czpDZUI+s6VCfK1/LOhv03zKPN7Lhk5qaDpJruKmlWHL7FYuu8YVF84wljVU0/PkK
         fIftd4VMKmnWAI78ZUjmYyvZ9KcfMjz/2C8TpN0o2ieUyrXKYLfsUofBtVdsG0HLtWeB
         B4bJt/LTSxVHaRsB4Kld3LN7TI5czrGXeUzcmDMzqPYik4fFBTkoieCQ9SakQgFemc3i
         8cMinTnvtirBb9BQX7zRnyA/16xOzuW8n36/J4Px345UtHFP6c+IG57cqEvrCQjByqNf
         a0lA==
X-Forwarded-Encrypted: i=1; AFNElJ+F1rxN/atMwY6C95auBObjMvEEhrXYfct719TELT1vinAJbZ/q9R/7Kfy/tGbfsNFIl/cELgbw7FSqRw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw25sN8rKK/8AsIZNIYZlL9ZfDHy9YtHB8D8Sdzl8Ve49E1Ut4s
	B0Qqq9u37xFrIaCu98MLjl0fAegw8Yk8dpvpXdC5fYdvGo92nMb3NcFT
X-Gm-Gg: Acq92OHO+rCV2TWUp7mGUrdqHGQ1eJ2EIKV8FLjq4RjBRTxd/q2bit6BxJ3aq7Ixg7G
	iV2Q8n0xdMkhgKeLY/UyO89BmYHnkGOdNWk4niIf4v5aWmxDm1xlC8UBBc2+wBJ/+lLHf80MX3t
	CDp4W8mYnCVv3nyTkIoLTGuRGiC6e7beudKsKUTlqbQgsWt2au3XhQC+wYkYxLeS1v5TcIheBbo
	7ulYc/zZS5cUBy7pUGkdFpf7dI8DThUm0/YKyuSav3Q8Y6sun7LrWkgW9hDRo//KbNJ4I1/zQPM
	qxqUOy+6OYJuInV6xMifEeSvGz6K0ekB8qn6wA3cGzU1aTr6JFY0HexsshM4AXJugZYIbCH8Km8
	maRbfjY2OKqnPq0VG10qbaBzvlE6g/2vfEnPAisixwovp709MAN0IJMdiXJ7nYlLRmITvY6aSOk
	Vxt1ScwrIu+QYNYht06T3NO/ffPFSSkjQFvHsbXs08nOLBuk57ttbFaJI9lwOnPv/KBjtJU5Llh
	EE=
X-Received: by 2002:a05:7300:5726:b0:2e2:3381:2fba with SMTP id 5a478bee46e88-304fa523d3amr696259eec.3.1780083073492;
        Fri, 29 May 2026 12:31:13 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:307d:2a52:8823:4a01])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed2efb4esm2188760eec.8.2026.05.29.12.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 12:31:12 -0700 (PDT)
Date: Fri, 29 May 2026 12:31:09 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Tianchu Chen <tianchu.chen@linux.dev>
Cc: jikos@kernel.org, bentiss@kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] HID: hid-goodix-spi: validate report size to prevent
 stack buffer overflow
Message-ID: <ahnn8iPJP5nbN2rS@google.com>
References: <f7e444a3facbe5fb2627167ab205771476e46bc8@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7e444a3facbe5fb2627167ab205771476e46bc8@linux.dev>

On Fri, May 29, 2026 at 01:42:47PM +0000, Tianchu Chen wrote:
> From: Tianchu Chen <flynnnchen@tencent.com>
> 
> goodix_hid_set_raw_report() builds a protocol frame in a 128-byte stack
> buffer (tmp_buf), writing an 11-12 byte header followed by the
> caller-supplied report data.  The HID core caps report size at
> HID_MAX_BUFFER_SIZE (16384) by default, while the driver does not set
> hid_ll_driver.max_buffer_size and performs no bounds checking before
> copying the payload:
> 
>     memcpy(tmp_buf + tx_len, buf, len);
> 
> A hidraw SET_REPORT ioctl with a report larger than ~116 bytes
> overflows the stack buffer.
> 
> Add a size check after constructing the header, rejecting reports that
> would exceed the buffer capacity.
> 
> Discovered by Atuin - Automated Vulnerability Discovery Engine.
> 
> Fixes: 75e16c8ce283 ("HID: hid-goodix: Add Goodix HID-over-SPI driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tianchu Chen <flynnnchen@tencent.com>
> ---
>  drivers/hid/hid-goodix-spi.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/hid/hid-goodix-spi.c b/drivers/hid/hid-goodix-spi.c
> index 80c0288a3..288cb827e 100644
> --- a/drivers/hid/hid-goodix-spi.c
> +++ b/drivers/hid/hid-goodix-spi.c
> @@ -520,6 +520,9 @@ static int goodix_hid_set_raw_report(struct hid_device *hid,
>  	memcpy(tmp_buf + tx_len, args, args_len);
>  	tx_len += args_len;
>  
> +	if (tx_len + len > sizeof(tmp_buf))
> +		return -EINVAL;
> +

We can also consider returning -E2BIG here.

>  	memcpy(tmp_buf + tx_len, buf, len);
>  	tx_len += len;
>  

In any case:

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

I think we can ignore Sashiko's ramblings on this patch, it needs some
instructions detailing order of operations/timing of callbacks in HID
subsystem.

Thanks.

-- 
Dmitry
