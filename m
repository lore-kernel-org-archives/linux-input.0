Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BA43793B1
	for <linux-input@vger.kernel.org>; Mon, 23 Feb 2026 21:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771883925; cv=none; b=lZvlEJWWSYpkNd6ogb0mOGKeKBCRuMzzdNLG6PJPRKIRwEW8apzQjK04b8hwlpSLpNbQCu0uKuUxQ0TDxWI9Onuz5UawIo8kVBaSGjFCRo2cXj2nJWQePowcsAvccmeeen0Ry6PtDMYeZpEy03gP8mfoUbZDCrdZcCVCg9vKJHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771883925; c=relaxed/simple;
	bh=U+932Mn0YgfKAD/xkm1bX1zAHmzcoChHibGTIzZrHrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2t9EJ3q+V+J9xhFCcs6WVYtOpqc565LWSu42xSD72ESE5j2UB3/3mqZChbTQZgqwmgXklLU8CU6hmMSe7iFfwX0BmloZ2EXOnHf7cDjdjysJGD7hBD0sNFR4GUR60sO++uxkexyf3qzmA1asVGzvE7XOxwsd6tMTRpqOaRcChI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PoXjqQ7U; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PoXjqQ7U"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-126ea4e9694so1409088c88.1
        for <linux-input@vger.kernel.org>; Mon, 23 Feb 2026 13:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771883923; x=1772488723; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O/HprNfkw3exbVeNB8hHbkDBLyIxN5yp9J024tunG0I=;
        b=PoXjqQ7UqW5F8e3chOEfA8WGJIAccBa0BUt6FK5f0pZ79mu0HAMzyKd4qvDyrqAMkC
         2nC2bvJP2itjdMEf33+lpEazD1wFZuS3a2bRIv5BOM3lwV3UwIF/IqLANVPzze7nKHYw
         4KTN+gU4GbRj0+sXiS5Kd/Jn+ukGpSp5enYQcNrRH3Xk6O/Xv6i95haLj1AxtrvRNmbA
         iPnmJXjVSvyMs5ByhbVysBlssg5FSmmZRP/rWF/sEllDqqtZF7tt4qhsdq8x9VEeZV/I
         y7mCRZqgpgr78+PnBIEBcQ2TWXhccXsgpTXs5SAMd7bSABinCQqr+lG3PtmIUVOTU8DR
         SG6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771883923; x=1772488723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O/HprNfkw3exbVeNB8hHbkDBLyIxN5yp9J024tunG0I=;
        b=OLsdSbVOknvVELY4bXlVLEJXbEtvtqye37goepVgnMWb1lDS55jL5Fw7BMnggnPtjv
         6YDGLJKkbrLY5KVLXbOSRl0ChnZrCeZNXdtrel2Ec8KHPaEAKcQIWMB2vnyRQNGOR8zh
         qb/FpmO8Kkm2j7Sf6Z2TV7c6+jic1RK31cGTOCHYRFHCS0IgS8cFc/+RdKGvhd1SIkTt
         jKDw4AM/hJHpTNeTA6/E4X7vtikUIlarWgMt/jDfSGT9IqG16/DtFWMmJgOenz/HjQnx
         IJR3DZnJfRbtOjVN1TpcoBS5DygC5X+0y2+Bq6TO0dKpHMohVUIK2uLmHLlHaN6edZTA
         VQMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaWAbi+zT9sgTUhDduOOemHMcrWQK6M/aFYWOiO9trKHMbTO5jT4MgPvevGUkR3YsTpZ60XCOUiMyhLw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdPosWHxuqtKuOyS6C8YJZLI/liAA5Di2CN0PH7vtsYmMc6k49
	7ZaZ/dG2Uwli9IEbNYlRjQBCCqGNvRp3dDOkc93IKg3vpAzyE3O0Ao+W
X-Gm-Gg: AZuq6aLAdkUearKyGNxGL76F8JjcmnYvnuGFCE7cOCdjYHj5UmefGCKwGwsOCqcyxOU
	5MloJiK6VQ+rfBaekeV6LUH1rhTgzZKoHsXEmzB4W8eZgUOJiC3ovhhy5pSLJ/pXDm/ZFedGrrz
	sCMw5j6r39Pkyn4gj0oHBpQ4JJxcfcrE2MeNt6jPoCRircm6Q0oOTaUUQtGUuiSvxh1Ya7/zD19
	OM17wTUxw3le2sSC4KfYZsXdaQhOCVN+f391mhDnKNTX+Sq4GMdpd4fCKf+lcQXOVY3+/20XoBq
	orZA7HMLy2z6X5o06KsGeoZqOaCaH6Xhgr1g5ABgRWRq37YY0EJr3wCfmeL6Pss7y9zTKwmXA+s
	7LoAzdX0zspd4R7ecWRT1ATmTxd3INIWi/0NjjLDEpOs++rLz/AJgF0LHKQjvQtrmFGs4meTvRC
	LidGPOOpnmCJ3FxSVEGCXnWcaaIK21V6yTm65mPbA+B8/z7Fq6wkBd8mweEY74JY5F
X-Received: by 2002:a05:7022:4a1:b0:11f:2c69:32 with SMTP id a92af1059eb24-1276acb1c7fmr3953940c88.7.1771883923048;
        Mon, 23 Feb 2026 13:58:43 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:1b48:5d6e:ab6e:5287])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1276af2ea06sm10322127c88.7.2026.02.23.13.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 13:58:42 -0800 (PST)
Date: Mon, 23 Feb 2026 13:58:39 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>, 
	linux-kernel@vger.kernel.org, Marco Elver <elver@google.com>, Christoph Hellwig <hch@lst.de>, 
	Steven Rostedt <rostedt@goodmis.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Nathan Chancellor <nathan@kernel.org>, Kees Cook <kees@kernel.org>, Jann Horn <jannh@google.com>, 
	Nick Dyer <nick@shmanahar.org>, linux-input@vger.kernel.org
Subject: Re: [PATCH 15/62] Input: synaptics-rmi4 - fix a locking bug in an
 error path
Message-ID: <aZzNSRIJdboXTV2-@google.com>
References: <20260223215118.2154194-1-bvanassche@acm.org>
 <20260223215118.2154194-16-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223215118.2154194-16-bvanassche@acm.org>

Hi Bart,

On Mon, Feb 23, 2026 at 01:50:30PM -0800, Bart Van Assche wrote:
> Lock f54->data_mutex before the first 'goto error' statement since
> jumping to the 'error' label causes that mutex to be unlocked.
> 
> This bug has been detected by the Clang thread-safety checker.
> 
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Nick Dyer <nick@shmanahar.org>
> Cc: linux-input@vger.kernel.org
> Fixes: 3a762dbd5347 ("[media] Input: synaptics-rmi4 - add support for F54 diagnostics")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/input/rmi4/rmi_f54.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/rmi4/rmi_f54.c b/drivers/input/rmi4/rmi_f54.c
> index ac4041a69fcd..fd57ebb1cb50 100644
> --- a/drivers/input/rmi4/rmi_f54.c
> +++ b/drivers/input/rmi4/rmi_f54.c
> @@ -539,6 +539,9 @@ static void rmi_f54_work(struct work_struct *work)
>  	int i;
>  
>  	report_size = rmi_f54_get_report_size(f54);
> +
> +	mutex_lock(&f54->data_mutex);
> +

Thank you for the patch. Do you mind if I move mutex_lock() above the
call to rmi_f54_get_report_size()? It does not extend critical section
by much, and I think logically makes more sense.

>  	if (report_size == 0) {
>  		dev_err(&fn->dev, "Bad report size, report type=%d\n",
>  				f54->report_type);
> @@ -546,8 +549,6 @@ static void rmi_f54_work(struct work_struct *work)
>  		goto error;     /* retry won't help */
>  	}
>  
> -	mutex_lock(&f54->data_mutex);
> -
>  	/*
>  	 * Need to check if command has completed.
>  	 * If not try again later.

Thanks.

-- 
Dmitry
