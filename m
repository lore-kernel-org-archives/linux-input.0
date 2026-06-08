Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAE135E922
	for <linux-input@vger.kernel.org>; Mon,  8 Jun 2026 16:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780937395; cv=none; b=dceCkOmdcWHyWQJQ9l3TAWRCUG6ab6oaLjsRewL+y+1fX3E3Fsc5DEhkpRiKyP+1ZMwgk5Srcoq0dNQznkM9LEGud+CtOGhaXsyM9bgBmipIRxhFLbrZs9DzdJXukUysixQj3WA/ra5mGRXQ58cA/8jHGUGnme2wqNAXjXJAL18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780937395; c=relaxed/simple;
	bh=jZvmmH1uKvNZYOfEfT6p1tDpG6SsK3RrxXYTj7zVMOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dF/6wVKgCcgDj2m9eU35Gmvc3Oq7irrfz+F5WE6p/MpVZ71otMF/rdu4AW/7cRKMVGkTi1LUUzYxqvvupXnzz1UBk5KpLMp7SsQt3ErxQga5/60RfIYH32MIL62BQudfQv5kgCZMNuvEOGT+yjMfip4N8e6HmFYZqgEtEa+tsu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDL4WCAF; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDL4WCAF"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-137dd523634so7140795c88.1
        for <linux-input@vger.kernel.org>; Mon, 08 Jun 2026 09:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780937393; x=1781542193; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uFNq16ybtpJLrH2YCQxzG3Y0AWxx7vbMDrUovLcXEC0=;
        b=GDL4WCAFvFK1SPJrcaFDzfkZxVNjJJkoxjdZBMEQfHLAhJ+N3hViph1mT5h4WsAH5X
         3EiuetFTa3F3XEUq/dKQcNEebvA/Gnefr5brt/NFbCJwNrQjJ5mipiB4iuaQ+5xvgvUC
         mMD2sxajebXgkmqNe/M3hxVE2g4CXTDKpp0ALxhKTT3X/OQfn8z2V7NmY9vmOUsn1eyb
         2up6f0X35SakB9E3ZGDE6Qg7G2V9DP7aH2Hntpo37GbUrd1UViObtNu61C1vQnm6FTv3
         d/T6wnd1FZfSRAoYZTVWh/FpkdDN0/1FaCcCdxf5wiJSjldmgiOL3h9jbSGy1lv0lKFQ
         RHlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780937393; x=1781542193;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uFNq16ybtpJLrH2YCQxzG3Y0AWxx7vbMDrUovLcXEC0=;
        b=oGv4Y5ogpsIDuSidFvmOHLEk4oj7I8V2SFvRYeSbj8AdRM3RbDNXoJkJf350fVqlp/
         U7bFg0Yin2hZVGaKuoeMWbEHm5k5a35OyPaXs5vDisASOBiQwIbC4DcGic3U+S4xqW0O
         vmYmml4K660SwGvhKI6kB598gaVgNE7VhFdflNhyT0PREXAt1bNRpx9QQ8lXMincrS1D
         p8dJd7OkakqX6DYN1n01IilqkZvEOysaQfYAfK/THfQrU23JBs9MAba/+sAE4RaCbxi5
         jqKtKnJeBnt5DZMBUggbrg6IwwStpeDOUKIHh5sYQ+EL05x34ATQpNgOf+yBVT2w/eUV
         VLfA==
X-Gm-Message-State: AOJu0Yx+UPMXOOvMlZXDOgR8tJaYiUU0QhOUVkkSc0zWClJatoDGyt/i
	QRKJ352Yx5QMZ/7QdpG74y7UlbAUT8iqwqAoc1Y6mdKkX4FAuBluMdk4
X-Gm-Gg: Acq92OFv4udgwk52icWsKBSb2uAnEbSsBwO76Wx3eK0qx7WkQh8rwLqzbY/74JnCCy8
	oAEmo5xZk5JCsfiI+Qe06Dq1eXoKfKuz6sjAqDSRuVzlQ71Nk3+LxY5uwrr3UInQ84rfiapdIam
	nrluNF8BduTGJUaKwgMMZ9VaKwkAO3jb2yNNlEpq7USJ4gWmbyODicnj1atIsKmnyCa4x+sTIAk
	7nrVsjSxjgZLR5DLQD7WTCUae0Qq8vMgTtOgz3+xpvodJ2JaL4mjqtiSdblJACZ8EryEtwkNJ7z
	Qq9bCkQQaO3sWxJfLw7SS3FPkoMBud1AuA6F+PxfcOr73UUdAwKEbUm1/HGP811mXn3IDDkvMns
	l6cs8up6YBa2i2YhWsczRjyRXUhW/yp6+4Pz0GZR/VECO9jHKYTeuqIasSs+9XOdVyoqLZxnz6s
	P7AQWVDShC9bFDnr0XHxtyl25KFBpF7fnzs6nE4URstsWBlmUGGPA6hE+Gdi7t4cAhVSARjVmIf
	bI=
X-Received: by 2002:a05:7022:699d:b0:132:5d42:55ba with SMTP id a92af1059eb24-138066d8107mr7520419c88.16.1780937392714;
        Mon, 08 Jun 2026 09:49:52 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:355d:c69b:fe36:8969])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f5539432sm15053915c88.9.2026.06.08.09.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 09:49:51 -0700 (PDT)
Date: Mon, 8 Jun 2026 09:49:49 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-input@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] input: ipaq-micro-keys: simplify allocation
Message-ID: <aibx1y8ANiZoMHyY@google.com>
References: <20260608045041.4664-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608045041.4664-1-rosenp@gmail.com>

Hi Rosen,

On Sun, Jun 07, 2026 at 09:50:41PM -0700, Rosen Penev wrote:
> Use a flexible array member to have a single allocation.

Why does it have to be flexible? The size is known.

> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/input/keyboard/ipaq-micro-keys.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/input/keyboard/ipaq-micro-keys.c b/drivers/input/keyboard/ipaq-micro-keys.c
> index ca7ec054b1ce..0fc5b5dcdef5 100644
> --- a/drivers/input/keyboard/ipaq-micro-keys.c
> +++ b/drivers/input/keyboard/ipaq-micro-keys.c
> @@ -23,7 +23,7 @@
>  struct ipaq_micro_keys {
>  	struct ipaq_micro *micro;
>  	struct input_dev *input;
> -	u16 *codes;
> +	u16 codes[];
>  };
>  
>  static const u16 micro_keycodes[] = {
> @@ -90,10 +90,11 @@ static int micro_key_probe(struct platform_device *pdev)
>  	int error;
>  	int i;
>  
> -	keys = devm_kzalloc(&pdev->dev, sizeof(*keys), GFP_KERNEL);
> +	keys = devm_kzalloc(&pdev->dev, struct_size(keys, codes, ARRAY_SIZE(micro_keycodes)), GFP_KERNEL);

Please keep to the limits for the kernel. 100 columns is acceptable when
leads to better readability, but I prefer 80 when it makes sense.

checkpatch.pl would have warned you.

Thanks.

-- 
Dmitry
