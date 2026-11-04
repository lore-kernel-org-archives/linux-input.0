Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793812131;
	b=BPCktwWpUR9HDuWbIKFCTihz9J+VCQUoLAHmhrBAXaUHlHIgPgpZSjuudwPQ4p5WAHJ1
	 K4KonO5nH93w8MMJBq8s9kWK5yFF5VdKimd77PxZGzzZ93cMrI9eCE4+w9nOh2LOzyy18
	 hFc1kFrW1yrsUFZSGMGJ3PM8/W8UUrYUPmq1rR+eJQxD/QvkoblGwj9dXXVRefcbNT3kR
	 m4eS9afwK3Snne+oIfzaFOvPo0J/Y29ovDUQIRFzoU5yBwSSUyjRQ9aZTNE6FbLuk2GNg
	 eq7N4QQLCB/vzELQP9GYPbLIKhV1RzqIr6zudgcm1lF5AfNCO55TMMgOkwl5k3F15rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793812131;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:Message-ID:From:
	 To:Cc:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Content-Disposition;
	bh=BggNDxA9KgGk5xDWclBWYSnVWHuMCkK7nhX4rgf+QMg=;
	b=X6g0dm6zawch6PMdWu5ae1skdEl5Z0Z3aynPIkf6DlYQie/xrqKTHvNd6YhrvkkbFYYB
	 w7t3B01yMvtpCHTnglgWOGuyJMS9oVZgPYc76reb3iEhBdXcm5F9HsGxmT4JFnKRgyMX6
	 kZdG587C2fwIYQjJPgNRsJA9adtQP1Z2u+6ZGp2TeBFKTUHHkW2wjTs33s/15Vnhc47Cf
	 Bz6qQQ5q/RrHHZCxrwehI36CaaUrLF/cXv+EmoNKpBNqwRgh9UBo6m8qVWpnx6YShz2Pq
	 /AMAtJ5bw9TopcGsL3iOLqJ1IT/7fKtQVnxoGrHNhO/m0n9llp+C8XyuR32RdRuSzzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cMiaVy+p;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E0D606A329
	for <linux-input@vger.kernel.org>; Wed,  4 Nov 2026 17:08:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5E0D606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cMiaVy+p
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1a3c08d6928so1478712c88.0
        for <linux-input@vger.kernel.org>; Wed, 04 Nov 2026 09:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793812130; x=1794416930; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BggNDxA9KgGk5xDWclBWYSnVWHuMCkK7nhX4rgf+QMg=;
        b=cMiaVy+pSe19pMljL1uhjFq4kEbCEUt/o/Iz6C2dTV176m5rucfND0PEf2SEpbbZxc
         PlE025Nm9PTscRp/p6IR7dB+llIsWQ/RxTRQ9DMb3zak2OfQIiH4AzmBia7njqIOqfv7
         +6UkapzksH/qN5zgpwwEDIiJP5Zra4K5wMOpP9dnw6Ut8jFNBtafU9CP3+QcghOfWyuS
         VRs1slNBsFhglrZ5hpyjHicvAlB1cY4yMXpAHrE91rIxMDuYxleL7z7x1/StDrDduXTF
         /8oMWy7fE10gZwzPJXEvuhfC6tma6uCe3q0HDDPSHNL+iHzw782M8oIMqk9jJLuN1MeJ
         mURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793812130; x=1794416930;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BggNDxA9KgGk5xDWclBWYSnVWHuMCkK7nhX4rgf+QMg=;
        b=QFTKcTaTrlErtZ8MK9ySclN0Fe9mbEGB1GFi9//WaeTabu8nXMej6vnr+2u9ARxUxM
         O/E2Pb+htB/h2dnYk/wacQhDcFHCmwgOdzBGWDY9+u+sL93+c9oQ2DyIqavz5e30nRQv
         o3R4hLkh+CR2/6NlI8AJt49cH6AKmaudSt4afmeDbaRUulx3Gk9/gE8LkPuHuUg8tVQI
         2k1prrbRmf2U9WflqW8s9yU9G6tzbwWD7qHrNC2f4BEPEL+Syf169vwbhi8KvwQ5e1L3
         NZKYFE/5FXJiR6bbsuOyy8XDv9h6zNznreRqwgxHbmpciJ8xQmvTRKYBj/zjAMGSCQUn
         Lr8A==
X-Gm-Message-State: APuU4Z/3oz15Ufxdmf2rW3tA+tkeIO5mAIJuJbZIX5nIssa8sbXzS8hc
	bqLdE4izUpS7AAMN/Z7JEz6fi4b2r8RTHSmCz9bZQlLXjfgT6IdUgxFt
X-Gm-Gg: AYBFou02WndwMN9D2C95D1bEb67RfdwOYSOQgnRXT9CPNnJ7g63nr9oNrDUoiCv1r8V
	wooBMIPG86ysutT2Tz9AtUs2akOWl0qlplFCiSqZWhi+N5W6j5rS4Oxy0KW+zxhe9sNT1H2/hZk
	NSeJs7xHVw48XTxzbnVY9RPHUMiYY89LpYxqLBrb5W0c2QHyRXsT81KDb+dD7MX1Qjbbh7aGhxu
	JbwgNdEx8wtWETEBlCYIvuBrellfLJAswcmK5RqEAxgWpfvVqeQnHCnV7Sfvfgudsa5vYk9lMtJ
	GJ7tcWkWvtbkrvG/8rUQIJqyOdvA4kHAdo6IdtjzjWB9fS04DP+XaN90WsX6Yd22rBcsXtLsCGb
	+53l+IeIRVcxaXuO3P59gZfniXnG75v/KwBBSHZOlkH7FOLY24k5e27JNacWy5lbvrI4m1S1Kfh
	Fh16Rs2omHWoWApd7BcvVVH4hP5FrIxY33Aoq1ziyFQFJg+MZ/7Ji10l9JvknJWmOOWm90PUbxE
	G6XxQm27M8vvG4V24lexq4FvLwuWZb28csQChA1im1fTZIgRLgAWp8moUY4NAt/UeYr5/7dthtF
	lhyxeFrAmuSW2PlobjuJlmcC2GNiVXrSFUwyJnHI5lHcq1JjSnnLCFF8JG4c4PzPcP6Q
X-Received: by 2002:a05:7022:b0c8:b0:1ab:6b10:461 with SMTP id a92af1059eb24-1ac5e3231demr21369464c88.45.1793812128406;
        Wed, 04 Nov 2026 09:08:48 -0800 (PST)
Received: from localhost ([2a00:79e0:2ebe:8:88b4:22ec:d621:c1b])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c1c290sm9034336c88.5.2026.11.04.09.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 09:08:47 -0800 (PST)
Date: Wed, 04 Nov 2026 09:08:46 -0800
Message-ID: <219a70bd93416777ae88becb34d8cb72@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Guanglei Zhu <zhugl3@xiaopeng.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liuc63@xiaopeng.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] Input: tegra-kbc - check the pin numbers from the device tree
In-Reply-To: <20261103084135.426629-7-zhugl3@xiaopeng.com>
References: <20261103084135.426629-1-zhugl3@xiaopeng.com> <20261103084135.426629-7-zhugl3@xiaopeng.com>
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
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Guanglei,

On Tue, Nov 03, 2026 at 04:41:34PM +0800, Guanglei Zhu wrote:
> The row and column pin lists are read straight from the device tree
> and used to index the fixed pin configuration array:
> 
> 	num_rows = of_property_read_variable_u32_array(np, "nvidia,kbc-row-pins",
> 				rows_cfg, 1, KBC_MAX_GPIO);
> 	...
> 	for (i = 0; i < num_rows; i++) {
> 		kbc->pin_cfg[rows_cfg[i]].type = PIN_CFG_ROW;
> 		kbc->pin_cfg[rows_cfg[i]].num = i;
> 	}
> 
> The helper only limits how many entries it reads, not what they
> contain, and the pin_cfg array holds KBC_MAX_GPIO entries, so a pin
> number from the device tree indexes past the array into the rest
> of the driver data. The later configuration check validates the
> row and column counts stored this way, not the index itself, so it
> cannot undo the write.
> 
> Reject pin numbers the array does not have.
> 
> Fixes: 88390243a993 ("Input: tegra-kbc - add support for rows/columns configuration from dt")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
> ---
>  drivers/input/keyboard/tegra-kbc.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c
> index e6177f2bdf8d..f086ccf1a075 100644
> --- a/drivers/input/keyboard/tegra-kbc.c
> +++ b/drivers/input/keyboard/tegra-kbc.c
> @@ -522,6 +522,10 @@ static int tegra_kbc_parse_dt(struct tegra_kbc *kbc)
>  	}
>  
>  	for (i = 0; i < num_rows; i++) {
> +		if (rows_cfg[i] >= KBC_MAX_GPIO) {
> +			dev_err(kbc->dev, "invalid row pin %u\n", rows_cfg[i]);
> +			return -EINVAL;
> +		}
>  		kbc->pin_cfg[rows_cfg[i]].type = PIN_CFG_ROW;
>  		kbc->pin_cfg[rows_cfg[i]].num = i;
>  	}
> @@ -538,6 +542,10 @@ static int tegra_kbc_parse_dt(struct tegra_kbc *kbc)
>  	}
>  
>  	for (i = 0; i < num_cols; i++) {
> +		if (cols_cfg[i] >= KBC_MAX_GPIO) {
> +			dev_err(kbc->dev, "invalid col pin %u\n", cols_cfg[i]);
> +			return -EINVAL;
> +		}
>  		kbc->pin_cfg[cols_cfg[i]].type = PIN_CFG_COL;
>  		kbc->pin_cfg[cols_cfg[i]].num = i;
>  	}

Could you please check against kbc->num_rows_and_columns instead of
KBC_MAX_GPIO? Not all Tegra variants have 24 KBC pins (for example,
Tegra114 only has 11 rows + 8 columns = 19 pins), and the loop right
above only initializes kbc->pin_cfg[] up to kbc->num_rows_and_columns.

Thanks.

-- 
Dmitry
