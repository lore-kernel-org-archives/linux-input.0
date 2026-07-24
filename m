Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874C4456E1D
	for <linux-input@vger.kernel.org>; Fri, 24 Jul 2026 19:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784921442; cv=none; b=iKazXdePa880PxswEtnI7NSARpU5pyuFybEYgBaQYXFnhKqCHivOHiak2nqder4DsB1kjcvPmaERQwvEGOAdj2UKdu9f+rPpDo3gsy430ZjO3h7cXNxfDBCK8jyvZbwUm4mNV4X7obuRlwjEkWo8jp8xrZFbGhOe+8PAeRQx2ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784921442; c=relaxed/simple;
	bh=x9t1K0trkHASSg++otRH3aFra+mFYlWBldAGwuMVpRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZGkW5wnATuVs5jiCoLsgj8ahMRwXnMdDUDQfm2GucXu44lv8mIwRIVmRDFntSUI2orssFum48tz664ScqmVbAHNfsgWicUsr+KJQQlEvZl4Kk1Ivej6UGIEXtE2lu3MFlCqyuwYBfuWUssUEKGYizxEsch/6Uc8Y5z3/OxJbV1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N77AC5b1; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N77AC5b1"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3811f512167so766162a91.3
        for <linux-input@vger.kernel.org>; Fri, 24 Jul 2026 12:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784921429; x=1785526229; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dU6h0G7oXQdk5MdfE/YxhUvukc34BGEGg+/bm4XFaKo=;
        b=N77AC5b1nY7fXhwV5pOkcGUdkX0GdLtwo4h+psMpLp1ItZIHmFpcxdoclq+JT6/Lw9
         Ldm8KbtUf6+DTImtU2/c0CPsZDRgPFKnpRt41bvRBCtLRxTo2108GQFeScMPsoTLBzaY
         2M7mRXfRTT9+TmDT20t6GnyjXHRv4oFqbzevXeYhqBcOVF75Fqdj/GqdTeWUGfzlNAOv
         4w9FLuhDiu6i4C0L7RG007r9183e0oWoXb2E9V/tvVWSsJlsWqhjdReeIW3t4tvAR56p
         X6R3xoBFRfFG4FkW7/cQ3vUFlTQAbij7srpVIgsJqy6Vj1E5L3NOXEQZYSSw2aYtwGDu
         y7HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784921429; x=1785526229;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dU6h0G7oXQdk5MdfE/YxhUvukc34BGEGg+/bm4XFaKo=;
        b=C75Kv4XxyGAo8mXWjFZ72YHfB/3ZrHYLhZ4qkQ7WvCSCg1YzpPybdE8qAXkznmIxVA
         cyuaUN74wg9eCdo2wYMyjVQikbkwO2yzaL7Mr26MsbXBVhIAhd7+uVVpaHK6fSHc3j5+
         EfYZ8Eh69yyBIgSkaLY4b9nvOAGQAlMHoyn0oj9sVM28agIEZKL8T4a0PQIxpa6+yvpR
         rSDGOgGeTdlpkt0wZNe56KP74vT7sLQCAin9fh5WIiEef0AqcsJ04D1nDtiChLAuRRTz
         e6mceBCNmIIlrG7lKko903Pw7+WriDBTqIklXokPXqiCiDekm7vdJ1FaV30+S4TVOQu4
         mMVw==
X-Forwarded-Encrypted: i=1; AHgh+RqAFaUwV+rQ85VuYuISY4/dKElAh1dRZBqKHTJ1JrLz7G7dyl/NTjLLc6v5Q/Qx7uQB/LDC/dG3c94WuA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzlEstoWV9U2+frYS+PLZzuwuxCBGOfyJ+TZPlozwi4Ao5YJfLX
	ck0o1bK/kz5F1rc2Of4/ChIHPttuzn7hNtiIhENk9VgIW7l/rJqqePh5
X-Gm-Gg: AR+sD11lzy+RY30/WIb8le5p8K5SeH4yA42pIJDPo3ezbDMDXjX2N4gmo6TAVeMVHpX
	ROXoz60Uvu66GM4fnVSwCidkOZFg8TKh4gQs9FPqhqPpdOEKRYsZaisw8w+FM0SP9uq38EEsAlZ
	sBvnVQhAd5rtG37gmNPbZy1U0Zgo6ap2lKzrF+Bl/FNQVizq9B+N6E1kMU5Nl9pksHzBB/LxqI5
	jaUtxI0k2sPvZ9616PO/oRSwODwJwxb0hoGm65dDnO3Q2wqsONVbXR5eBbNouRdGhOKA3UekEir
	+JIlND+Ki47yalnjRjArZgX31WX0+2AqqoJxapkvqFRVRioaGBsaGXqTPgvBHQrmZkstp/AkH6s
	ocJP/NPcGlpGiyPTnyNFvliOKtGoyURJSniv/YMbdpj8/qkq9aukYGOd262RwrNk8vHT/H+5HB2
	EkOkB80HpcUG8nL+gkyo3RqeuQwXKtoJFnJxIwgTz/1RY=
X-Received: by 2002:a17:90b:5645:b0:387:e0cb:c8dc with SMTP id 98e67ed59e1d1-38ec663d2a5mr8479389a91.37.1784921428504;
        Fri, 24 Jul 2026 12:30:28 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:40e1:40e4:dabe:543e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d130f42bbsm30772866c88.14.2026.07.24.12.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 12:30:27 -0700 (PDT)
Date: Fri, 24 Jul 2026 12:30:24 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: Julia.Lawall@inria.fr, cocci@inria.fr, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/36] Input: remove conditional return with no effect
Message-ID: <amO8lj_0sqBFOqub@google.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
 <20260723184538.3888637-17-ekffu200098@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723184538.3888637-17-ekffu200098@gmail.com>

On Fri, Jul 24, 2026 at 03:45:18AM +0900, Sang-Heon Jeon wrote:
> Both branches of the check return the same value, so the check has
> no effect. Remove it and return the value directly.
> 
> This is the result of running the Coccinelle script from
> scripts/coccinelle/misc/cond_return_no_effect.cocci.
> 
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> ---
>  drivers/input/keyboard/pmic8xxx-keypad.c | 8 +-------
>  drivers/input/mouse/synaptics_i2c.c      | 6 +-----
>  drivers/input/rmi4/rmi_smbus.c           | 7 +------
>  3 files changed, 3 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/input/keyboard/pmic8xxx-keypad.c b/drivers/input/keyboard/pmic8xxx-keypad.c
> index 35d1aa2a22a5..c916e80e2f58 100644
> --- a/drivers/input/keyboard/pmic8xxx-keypad.c
> +++ b/drivers/input/keyboard/pmic8xxx-keypad.c
> @@ -462,15 +462,9 @@ static int pmic8xxx_kp_enable(struct pmic8xxx_kp *kp)
>  
>  static int pmic8xxx_kp_disable(struct pmic8xxx_kp *kp)
>  {
> -	int rc;
> -
>  	kp->ctrl_reg &= ~KEYP_CTRL_KEYP_EN;
>  
> -	rc = regmap_write(kp->regmap, KEYP_CTRL, kp->ctrl_reg);
> -	if (rc < 0)
> -		return rc;
> -
> -	return rc;
> +	return regmap_write(kp->regmap, KEYP_CTRL, kp->ctrl_reg);

This is fine.

>  }
>  
>  static int pmic8xxx_kp_open(struct input_dev *dev)
> diff --git a/drivers/input/mouse/synaptics_i2c.c b/drivers/input/mouse/synaptics_i2c.c
> index d4cf982f1263..85e37e2ce45b 100644
> --- a/drivers/input/mouse/synaptics_i2c.c
> +++ b/drivers/input/mouse/synaptics_i2c.c
> @@ -257,11 +257,7 @@ static s32 synaptics_i2c_reg_set(struct i2c_client *client, u16 reg, u8 val)
>  	if (error)
>  		return error;
>  
> -	error = i2c_smbus_write_byte_data(client, reg & 0xff, val);
> -	if (error)
> -		return error;
> -
> -	return error;
> +	return i2c_smbus_write_byte_data(client, reg & 0xff, val);

When there ate multiple failure points the preference is to explicitly
return 0 on success.

>  }
>  
>  static s32 synaptics_i2c_word_get(struct i2c_client *client, u16 reg)
> diff --git a/drivers/input/rmi4/rmi_smbus.c b/drivers/input/rmi4/rmi_smbus.c
> index 6de68c602558..3160714a514a 100644
> --- a/drivers/input/rmi4/rmi_smbus.c
> +++ b/drivers/input/rmi4/rmi_smbus.c
> @@ -177,13 +177,8 @@ static int smb_block_read(struct rmi_transport_dev *xport,
>  	struct rmi_smb_xport *rmi_smb =
>  		container_of(xport, struct rmi_smb_xport, xport);
>  	struct i2c_client *client = rmi_smb->client;
> -	int retval;
>  
> -	retval = i2c_smbus_read_block_data(client, commandcode, buf);
> -	if (retval < 0)
> -		return retval;
> -
> -	return retval;
> +	return i2c_smbus_read_block_data(client, commandcode, buf);

This is fine too...

>  }
>  
>  static int rmi_smb_read_block(struct rmi_transport_dev *xport, u16 rmiaddr,

Thanks.

-- 
Dmitry
