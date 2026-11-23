Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795415689;
	b=RPTncgUXE/OCDplfS+OnP4NymyuKBLKdOsYbkBRtGHFEkOUOZYcwR8jR+lOvivZ/UAOH
	 friaT06UbP1SAKDKpkbJLxSM+29U1njaCX2LOurZWH+l22Kl1DHXHvZzL8Ngh0f/TMTSk
	 D1dY2nExpNPsoDZ64L6RrIDHvNto07QhtHAbH17tmQ/7PeDgWOA7RLNTh5cJAITY/XWWK
	 +B/bpXnWDorh7NXBHfo87yvSM7Vrdizw0NNoA7oa+9zkgYgTiG6XriwVt+gE1yiELin7P
	 Eeul4ebz2ls4DtTAN7uQa78jF+5jnnE48OYOWcAqFDDNiJGbBh7rE2eJzDz213lWIRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795415689;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=3HpDDKl52SUVYCO2/8G27hNCaySa90diGhXb5D2z9z4=;
	b=ZXxmKB5pKvrE72jfmfqx70+RLB/fVxZTZ4VegTJ76YpLbk4ZW5Ab/l7JhFKAwPtpPdxH
	 4fe3bR4JmEU72WOBtPrc3w4Ee8APYHRmT87nql6+FOBSWFcIKZCL2NgI4ivpE+Q+wMisH
	 YgTbhyZdzDvE6VfsNileRkq4Y189ChTROPvY85Rimaes/LmluyWPw6nS6J8D7XghrJy3+
	 CKLYxESiEdnfVHTDx3jylsn5F1RM9cJV4+P+eHqZQLjAoI9v0yjKXeKukFc3p1mRF1DOa
	 j4GIRtsHF8Y3ncwFOO06ujpoSlZIqn4K5nc/Bz8T5tt1HNiDWTUGXKrn24XZpm9Ns1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aza7N45n;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CE7606A31F
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 06:34:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79CE7606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aza7N45n
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ae1da332bcso1401398a91.2
        for <linux-input@vger.kernel.org>; Sun, 22 Nov 2026 22:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795415688; x=1796020488; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3HpDDKl52SUVYCO2/8G27hNCaySa90diGhXb5D2z9z4=;
        b=aza7N45n9CiQzz9m8tpVIjYSs07UAJCpRB2fvl7Ngct0kR62UBlSz/NQnlmttnKbqI
         dPYq0Yc9BRhVQtwGuYi3ZY5WVlvAjMT+HnpeJ1bzwi880yJhnI9oeGTXZEfp3GxmgCWQ
         NDvZ+lMggBb/LZ/PlUBDeGJLt7DXirmr5dD1hWsbitsZGikT/vEzW6SxtNA/i8cTSFwh
         r3esnBe4GH1WXvvQfr8aJH7rmuAop0O3gn5454cxD+r5wqS72A2TZlKi4RMGBsxnZCNT
         RHOGIp5O0+oG4P01NTczYvi4wAjkULHK8p9BnWQv2bDgc1M5PxSlDXu1mjnyc59k664G
         KiAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795415688; x=1796020488;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3HpDDKl52SUVYCO2/8G27hNCaySa90diGhXb5D2z9z4=;
        b=AVyQ+yWVyoM385gLrrPub+vcKtjTBYJgvgkWZSIij9tGa7dRTNghwagn5FXLeRzC7j
         hla4nWoLGOEM9Hx/WM6znnjncbaT/0IsEwrXa69eyOehtbL01lDs7WgD/Ph+CC3TJXel
         1AKZOu0s8rNdEp6TNnfSC45/z2LJpt7cqUQjCDPJ8LFz/Cht0QwHbPDLcaVt8P33YTJ3
         LFVkhBo+Q2q83X2FqLrRyYXRD+F7Kur2tqqXISDutLCx7xMKhYa6bhBGyTuTWOwIUcsu
         HAtUuYExGnRNUgNR5//JZqi3wyMpxHlF1kCz1LtIBuB7FpyS7n/MWyejnG8DpMYro6ao
         iJZA==
X-Gm-Message-State: APuU4Z/D3IhdTHx/w2cAy2sONcOOKD2Ks9N8UjCaiTwVw9MZ98ARkIaS
	M/OnVfwHYm52NnpAQTtktz5WTd7SXBtIVkpY7oTqKNt24ad3XJFfVNMB
X-Gm-Gg: AZFdTZcGhAVAs1IRaQK8TWiCbDXjrbut7M5cynUNnVYwxVMKbVsfb3VYN9kGFdz0AAl
	5kYPRVAHW5uxwUnr8Px9JMD8lBd2Kv2yqs56YWWg8+qVFzFvNK2JhCz9unQ9oxqn0OE7/3WnFAN
	7oRpUytPb/wqOwsyuRKMJOGz4lYjzaluJdH64ceg1SpQzIJ2X3ndb2wY9gAExy1qh8R6w4mzkv3
	X1+YaSefBuOUoqNGrtHodE0o6cnF8X+T2z4TfKrKhC1dOmVGgonogS2/iO0/EfcObiyiWLxu29T
	OLeZM1/g870lVemoFLkeQQKPGh4zD9uJSgyc97+QSsK/UyAQH19m4FqmQDdGbtySugvJmVO8o4t
	7u6vz9Rcj0AzOlJk7vCdZ4DGh47MmaL6D4A7LuGSa7HeOjOQX3PTwNaJRrxJ+XxyDa3MUWGfo9D
	7F0Ni8Vd9CeCwxnCKtOry+kyvFAm8NgeFVsCAI4uNRhqoG+SMD12N7g+y5ou4gsIjX95Oj9aSag
	dRz2TxYtohOTwsF2SanTZS9iamo+RmvKypXwUiCKm2n+D2ufn2pT38AO4AXSJzbTE+C2Sj8AS7P
	9qvY1N/AmPoQFuJKEfW/usbFkJYdy1XE7fPB/iPFcJC67L9yqL851uS3azPoD6zdlidHKUQ=
X-Received: by 2002:a17:90b:48d1:b0:3b1:832b:bb3d with SMTP id 98e67ed59e1d1-3b41c9817dfmr9391990a91.57.1795415687786;
        Sun, 22 Nov 2026 22:34:47 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:4121:d698:201c:9274])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d135e9sm18943151a91.4.2026.11.22.22.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 22:34:47 -0800 (PST)
Date: Sun, 22 Nov 2026 22:34:44 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: mpr121 - propagate suspend and resume write errors
Message-ID: <awPeWz0BrERX1YOA@google.com>
References: <20261112071728.154571-1-zhujun2@cmss.chinamobile.com>
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
In-Reply-To: <20261112071728.154571-1-zhujun2@cmss.chinamobile.com>

Hi Zhu,

On Thu, Nov 12, 2026 at 03:17:27PM +0800, Zhu Jun wrote:
> The power management callbacks ignore failures when disabling and
> re-enabling the touch electrodes. A failed resume write can leave
> the keyboard disabled while the PM core is told that resume succeeded.
> 
> Return the SMBus write result from both callbacks.

How does it improve system behavior in practical terms?

> 
> Fixes: 36682b81de32 ("Input: add driver FSL MPR121 capacitive touch sensor")
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
> ---
>  drivers/input/keyboard/mpr121_touchkey.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/input/keyboard/mpr121_touchkey.c b/drivers/input/keyboard/mpr121_touchkey.c
> index 06329cf5c749..973fbc5521a8 100644
> --- a/drivers/input/keyboard/mpr121_touchkey.c
> +++ b/drivers/input/keyboard/mpr121_touchkey.c
> @@ -302,9 +302,7 @@ static int mpr_suspend(struct device *dev)
>  {
>  	struct i2c_client *client = to_i2c_client(dev);
>  
> -	i2c_smbus_write_byte_data(client, ELECTRODE_CONF_ADDR, 0x00);
> -
> -	return 0;
> +	return i2c_smbus_write_byte_data(client, ELECTRODE_CONF_ADDR, 0x00);
>  }
>  
>  static int mpr_resume(struct device *dev)
> @@ -312,10 +310,8 @@ static int mpr_resume(struct device *dev)
>  	struct i2c_client *client = to_i2c_client(dev);
>  	struct mpr121_touchkey *mpr121 = i2c_get_clientdata(client);
>  
> -	i2c_smbus_write_byte_data(client, ELECTRODE_CONF_ADDR,
> +	return i2c_smbus_write_byte_data(client, ELECTRODE_CONF_ADDR,
>  				  mpr121->keycount);
> -
> -	return 0;
>  }
>  
>  static DEFINE_SIMPLE_DEV_PM_OPS(mpr121_touchkey_pm_ops, mpr_suspend, mpr_resume);

Thanks.

-- 
Dmitry
