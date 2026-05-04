Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D00D37C930
	for <linux-input@vger.kernel.org>; Mon,  4 May 2026 22:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777935561; cv=none; b=P+vQVuCSvU6wKajNMTpfTjCY/Z5VzRsyhedJBLC8HQLw3PPt/98/GQp5xaQtI9LxSo7zDmAQWKpwj/ubjPYPId8n7sNvCLQrWsoS7RkpCD3N6LELerI04H/FrKc+RjjW5OqsoXra/owaa7eIw8khAMuEWf17NBTxC5Ca7CaJiy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777935561; c=relaxed/simple;
	bh=DYXqtLPkW8GiozUA9ulomWRE1772fMlMeuQLWdk3w6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=atRmqPRjq3/HR/nYFU6phKVfv5ZYLmcgvs+yU7GB2S0R0ENW98SD4jVXXe35g9bfIrqB7mWyh+I3XdJfYuGFblecph1wnLsTmBhqiMGzyU1sr6pLsdPaZmi4M/MU1KRDrhqi1/s3NfCOQJHz5I7dFTeo015bcW3mY9xwfhu8ZtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VgrBE9Nx; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VgrBE9Nx"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1305908ae11so349086c88.1
        for <linux-input@vger.kernel.org>; Mon, 04 May 2026 15:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777935558; x=1778540358; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FjpnivPTd8dUU1OqTpo4s29OS+HjXTKGkTIY4MRmY14=;
        b=VgrBE9NxfjssdTQVblRcFQHm83G3QmZtUT3lBzq5GOmhuEkZACX0FnwnWfRLgjRC83
         yt3Wod5lnEWfKWTh2X7eprmGI8dpuKz9s3ayuc2g2LTaJICVeo1jukgLl6OKSL/BaZsq
         hotQLH1VtIlFCj2/g6R03BvYRbkgOD6WVqG4WVe6w8OTVVUfmciyDnLsW6uEfZPdtbMd
         a/V3ETZDdhzzsVU3q0XqISygUc4TZihhED6OE/7PKb+EkZe6Xggc3cP5FQD9OxYLHZOf
         fKNREXXf5jDV1XGQVZX9e0Dt+WycPtZuDaHwQs6lD3ehw/pNJcVRGKS8lgf6c7nCWoQ9
         lq9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777935558; x=1778540358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FjpnivPTd8dUU1OqTpo4s29OS+HjXTKGkTIY4MRmY14=;
        b=lO7dxwzbDGDFK8i1yzRV6ZPVXe9AuE6NzBuEQEto418OjEOAt3irFQJ3weiXIDWvkD
         wOzLYqIXnGfYB2bQ/L0EycjOkeenEKQV3Co1DCsYbyHvJvBGV6ylR/UrvWgL2kwJzr14
         3lEUATgzbvjs/FXZzQrXsdQKfa/ddozSrsIA+Mz8HstEs9I7tQd+lc+4VN8WEZ/W9sb3
         fZGxaW+stZXGjMzKgj6zD78DLWjnxKtX8uNFm6dzu1qUdY4kJ77H5VpMxAp93oXxxu5A
         EC6uBu+wqeLtxHnjFp9bqOXdynyY7mfSKyQfnSPmW3LDvRnRb46HxW2tnhvu5+Kjt6Jv
         Nfog==
X-Forwarded-Encrypted: i=1; AFNElJ/GiNtQBy6si9lHKSRnPG7ApqEFwwI5k+lKOcxNpzu+Js+J7XlnY1NUfHJEGHkbulumkzMgvZJYYl2zjQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn7R3gdg5N61+Hs865Ginb3+n4C5spXPdlB16T2GEJOKpXgmHw
	sSF8y1YajCLBeNA1qPqHK/bSO1R7W2vhCpeTpf9ODZsW4wWW4cXl4vHA
X-Gm-Gg: AeBDievIY7bkvTS8FYIppBApPZSDLMTKJdtSRkmSRXK7li44S9SXtLU39+vtg/ccYay
	j9CDy4mI2qCv8WaHuv0uyoj/mGa5Yr4Y5HexFdCSO8tZOCtdMRHsS6s+YP5SXkuwKeRIDBAHIko
	AneOZ5htBplKFYXiy2frBI8JDr1m7KnTmvJI12S9nkLp/kZIeBixIj42yezhCJrRSBFCb/sI8qT
	HTJ1wAc5dLTkHcuZtJgA7KcuGtvWaxDPcYS0OLQOckAuNmDorct2kU1QycewO3HK9/Yu/Ve9Tgy
	acplAd3TZqIBKQ97/G/B3c+ylrfHRFZAZtykkJoqAGLlgfzjTlMN1l697BIKYcgAEtROdluXLog
	CvWLecQp1VO9LgYm7+6NogeVpNkosU6hpm0GPd3DNX0GZsdQ75Jycacmx0XN9cbPFw3/mAZ1Bzm
	ON8QsuuDgOCpPQGzq2yEbm+1HOP6yAfsLsmN75qUM74MHg4PmmqEcy+Mgkur5IrL5LyeW7TqLxy
	p8=
X-Received: by 2002:a05:7022:f94:b0:12d:f0e8:9696 with SMTP id a92af1059eb24-130b15419e8mr456572c88.4.1777935557665;
        Mon, 04 May 2026 15:59:17 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:5b87:9b19:32e2:2981])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee38e71bccsm17138842eec.11.2026.05.04.15.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 15:59:17 -0700 (PDT)
Date: Mon, 4 May 2026 15:59:14 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Nick Dyer <nick@shmanahar.org>, linux-input@vger.kernel.org
Cc: Ricardo Ribalda <ribalda@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] Input: atmel_mxt_ts - check mem_size before
 calculating config memory size
Message-ID: <afkko_we5fAgmKxg@google.com>
References: <20260504185448.4055973-1-dmitry.torokhov@gmail.com>
 <20260504185448.4055973-2-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504185448.4055973-2-dmitry.torokhov@gmail.com>

On Mon, May 04, 2026 at 11:54:46AM -0700, Dmitry Torokhov wrote:
> In mxt_update_cfg(), the driver calculates the memory size needed to store
> the configuration as data->mem_size - cfg.start_ofs. If data->mem_size is
> less than or equal to cfg.start_ofs, this calculation will underflow or
> result in a zero-size buffer, neither of which is valid for a configuration
> update.
> 
> Add a check to return -EINVAL if data->mem_size is too small. While at it,
> change the types of start_ofs and mem_size in struct mxt_cfg to u16 to
> match the device address space.
> 
> Assisted-by: Gemini:gemini-3.1-pro
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/touchscreen/atmel_mxt_ts.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> index 28b2bd889c70..d660cc5b5fe3 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -275,8 +275,8 @@ struct mxt_cfg {
>  	off_t raw_pos;
>  
>  	u8 *mem;
> -	size_t mem_size;
> -	int start_ofs;
> +	u16 mem_size;
> +	u16 start_ofs;
>  
>  	struct mxt_info info;
>  };
> @@ -1657,6 +1657,13 @@ static int mxt_update_cfg(struct mxt_data *data, const struct firmware *fw)
>  	cfg.start_ofs = MXT_OBJECT_START +
>  			data->info->object_num * sizeof(struct mxt_object) +
>  			MXT_INFO_CHECKSUM_SIZE;
> +
> +	if (data->mem_size < cfg.start_ofs) {

This is supposed to be "<=", like the commit message says.

> +		dev_err(dev, "Memory size too small: %u < %u\n",
> +			data->mem_size, cfg.start_ofs);
> +		return -EINVAL;
> +	}
> +
>  	cfg.mem_size = data->mem_size - cfg.start_ofs;
>  
>  	u8 *mem_buf __free(kfree) = cfg.mem = kzalloc(cfg.mem_size, GFP_KERNEL);

-- 
Dmitry
