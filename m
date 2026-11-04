Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793773538;
	b=ipjaJMycHHi2/EOLNd/YFJZutOlTRkGaPSKX5Jxo+YhRnMIBS6lmxKzvHUaq3uFi8SN9
	 xSUzLggfbkQSVRiT1GKI+s5pyubx/Ir6R3t0GH08rzQU9eatGbFEW//TZIf3F++mA40c3
	 B43QeRFIXdfw/hm3ISk6xgf4w9M510eNVhP7GWTzBOB6hUZ1GXN6XMGGGHN5xUjggE7LP
	 KVJB9rudgoFXpnV+oloa3+sWM9vM1ypmGX2myPGxt7eH7SiAJOuEGVqFfkl5KYarrekQ9
	 oiqueiuIuQSUrtW+7QrK37VqmnFsTtEpbBeUhdzkSVLmB3OHVccUeWp0w9c2QC6ieQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793773538;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=6Bro8ntEtQu6vWViYeKCn76sAWO+684KhhtMVx+kfV0=;
	b=aD6XTnHss8hwqYJiuiO9GenGwINzJfHZDct2blFPy9IB5p5jfspgUQiGOGD4p46RjASz
	 MzpwAO7wem7rUxjVYKPg2ATafDWwsSrA4w4Bqb/NY1i54iuAzPZ7I75DMjZAOuGJNUqbm
	 8cGtCFXze69uhpjcqoLJgOH7RuKlvOpadKcSjHo/9Kur0kkvLsnGBZRYVuRCC6eghgDaF
	 K4uJ4a0/5ewtfQwDH6kRu1a0wKUl5a19pwPiXtNov6nIJhVt72dWOtr9zhfkftm7tS9lG
	 SBZA4j9ZI8RiXeW9CiCHWmqUnvpgiqq17s0O1uZlH5/RIBD+24kKL8D11ggNfBZzhFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TQal1hNR;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710EF606A326
	for <linux-input@vger.kernel.org>; Wed,  4 Nov 2026 06:25:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 710EF606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TQal1hNR
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3b07db03f41so248642a91.2
        for <linux-input@vger.kernel.org>; Tue, 03 Nov 2026 22:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793773538; x=1794378338; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6Bro8ntEtQu6vWViYeKCn76sAWO+684KhhtMVx+kfV0=;
        b=TQal1hNR+hyBkIra71sM3lO9IN4+z7XvE72XGbDcv0VAhbjZQJI+mpfau6p7BL5FtZ
         iDl09A8oHw7o/mnCJjKjeiYCmTW8NHeqVrCkok0tgaCQhK5pOqYP2rdNsXSlU+bgqhUg
         wtXejGlXwXTOczlx5jxBwLGc5F4IYouER+eAKEIKZ6B4nqtTOD+GgdkLmsGzW2cr3WP2
         ZN610PP6yl80b1fwwbYWEw7JisvMp+Mn6opAI0G552JPaoTbhyhx7xNUmKko/zMpgBNQ
         uHTXbBizaFPzIaYThNLuvjjt34lKp4N2qe6/dWhcaiPYsTrKWd+F687ys+Rf+DHfezFF
         Hs1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793773538; x=1794378338;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6Bro8ntEtQu6vWViYeKCn76sAWO+684KhhtMVx+kfV0=;
        b=wcjP9ZVq/j5VpLUCXwjYAi6xE8Q31RrHkXPtY1OuY4bUqWfVp5+AWlc9JYcs+mVs+E
         VdskEZYHRkxAw07xE49qJrGbYmiwn02K3MbBCQfupmOs12zLCL/Zn+EHT4PCVb/3LIzE
         MPNcJ+vU5jAwb3XfUAye0B8Cd+0gH29AuQOdxTASCSHuEmeuVWVOTEFGcJzkUoMjhake
         J5nV6dYXA4BfAs2jpujXnrLswXsUpnq0KHZAdWFif10PJS6c7WrjO/fJAIuYU9VAuaDz
         1tgirUlb/QC/mntIIrh4N8HSIbg1+Bfh6e/y8BiBFlZZc3NtAWCUOxGpFAhTqxhaGGho
         8iJA==
X-Gm-Message-State: APuU4Z9SinGMem8vsIET/3wms+zOctkoI63pG+OqECKQCFbUTDuJw9q1
	KzM8fjq9Vr/YqXvjOi4kc4Hgy6miM829SzzNZw+9jgKpDyksXWBMCjCQ
X-Gm-Gg: AYBFou1grp2CWYIN+mvJmKCp9YJ5YR8Ox6u32zlbt/vRwOSXKhpkmUiizjRhYF12SQt
	1xW/sRtAFGdV4mACfMseuMCpz1U18tggh7mQTEJ+e0iCjtxeG48QhxRSRJ+sXXdxK0JpvdYeMk5
	Fbaslgqvo5WL5pFxCEcVLuGiQkCt4zPmE4gV5z/JrRTfmJci41mxpGB7K73Bxvj0xAxfxu0SROD
	jLT0589nYWjvzGltTawoc4ou/lNV4Wi8hdRMWgslFU66q/U2HtgN3AKuVcAGss3fgCEferBDmj+
	Bic5genK0UxjoCMCvvQ7QOlCfzGE7Pdk2hlM/nylzVsi5KCPlTAzkzWxsptXlhb35vygMy6m2OV
	FvIl40Ek8sTfekuoPR+Hx8uYCzOx5AN8VijRl5oqQ/su9AFfdhNyu9WFIA6MWGcsyPLyaQ46jei
	mfL8sPDnt0DpbU2Fgnp/Kiw9AQDbmWk2wsrZPnPX6o7DV/QPkh6CI4GXjBSnxuj4YRoLxjFkDXL
	bVtBxpjxtTL3d+nNfPStaOzCAoU9/QqOwWn9ogh2hI0vELhYiU7KmE+PujdLFsrka1FksVCZJOI
	YOANyWBMN+eE4AptHTgBKB8sUzk4+C1lQt1WHGhIpj9K5pidkAff4ixcExA687i5dM0DMc2Uj0X
	PTxK1svIeIdMYjg==
X-Received: by 2002:a17:90b:4a8f:b0:3ab:413:49b6 with SMTP id 98e67ed59e1d1-3ae89787ee3mr12721065a91.41.1793773537530;
        Tue, 03 Nov 2026 22:25:37 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:88b4:22ec:d621:c1b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0944ea360sm2741863a91.14.2026.11.03.22.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 22:25:36 -0800 (PST)
Date: Tue, 3 Nov 2026 22:25:33 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Guanglei Zhu <zhugl3@xiaopeng.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	liuc63@xiaopeng.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] Input: lpc32xx-keys - reject matrices bigger than the
 hardware has
Message-ID: <aurPvymSFACa_kXH@google.com>
References: <auos7TgVNv7EWnbj@google.com>
 <20261104030709.791761-1-zhugl3@xiaopeng.com>
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
In-Reply-To: <20261104030709.791761-1-zhugl3@xiaopeng.com>

On Wed, Nov 04, 2026 at 11:07:09AM +0800, Guanglei Zhu wrote:
> The scanner state array holds the last state of eight matrix
> columns, and the interrupt handler walks the matrix size that the
> device tree declared:
> 
> 	u8 lastkeystates[8];
> 	...
> 	for (i = 0; i < kscandat->matrix_sz; i++)
> 		lpc32xx_mod_states(kscandat, i);
> 
> The probe path only checks that rows and columns match; the
> hardware supports square matrices from 1x1 up to 8x8, but nothing
> stops a device tree from declaring more, which makes the state
> array index run past the field into the rest of the driver data -
> including the keymap pointer the same code dereferences.
> 
> Reject matrices larger than the hardware supports.
> 
> Fixes: 69690bec400e ("Input: add support for key scan interface of the LPC32xx SoC")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
> ---
> v2: use LPC32XX_MAX_MATRIX_SIZE for the state array and the new
>     check instead of a literal 8, per review.
> 
>  drivers/input/keyboard/lpc32xx-keys.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/lpc32xx-keys.c b/drivers/input/keyboard/lpc32xx-keys.c
> index 2392e7e..429a3eb 100644
> --- a/drivers/input/keyboard/lpc32xx-keys.c
> +++ b/drivers/input/keyboard/lpc32xx-keys.c
> @@ -65,7 +65,7 @@ struct lpc32xx_kscan_drv {
>  	unsigned int row_shift;
>  	unsigned short *keymap;	/* Pointer to key map for the scan matrix */
>  
> -	u8 lastkeystates[8];
> +	u8 lastkeystates[LPC32XX_MAX_MATRIX_SIZE];

Compiling this would be helpful...

>  };
>  
>  static void lpc32xx_mod_states(struct lpc32xx_kscan_drv *kscandat, int col)
> @@ -141,6 +141,12 @@ static int lpc32xx_parse_dt(struct device *dev,
>  		dev_err(dev, "rows and columns must be equal!\n");
>  		return -EINVAL;
>  	}
> +	if (rows > LPC32XX_MAX_MATRIX_SIZE) {
> +		dev_err(dev, "rows and columns must be at most %d!\n",
> +			LPC32XX_MAX_MATRIX_SIZE);
> +		return -EINVAL;
> +	}
> +
>  
>  	kscandat->matrix_sz = rows;
>  	kscandat->row_shift = get_count_order(columns);

-- 
Dmitry
