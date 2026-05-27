Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E52410D32
	for <linux-input@vger.kernel.org>; Wed, 27 May 2026 14:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779893900; cv=none; b=pzhNQ/ntCcM4vzHrYA5flbO9IahrsMB4tkWDKJ6yAJ5k+OYTQQXXcgfamAKWYb2wX4Q9of8+7Dpko7o3LwXQv6xNsXfSdv7FomZh6mMKrtXrIOf8BsLhXcMQtF/HgEgoddO/FxIjMFHNIiKLmlN0gOJkRIfcOBJfcUYFVAKRkBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779893900; c=relaxed/simple;
	bh=N56tIHcmdIR7lmzF9rwHF5pzRKaM8xM44z9hSu69BQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJlRDW2FP6ch0ZBJsLnaNpPfz61qMu7ztFVxwl/RM9wE2aJArN0h+u2VKQxQU++wJgVVsSeMTJAxGByYfjnfg6VdvDFHPTtdC8WYrQ8ibHQw2aHBDB347ioR+suabx4KuHfvopX5KbTCDH8MCoYO0VSe7O8fl+1FwvGhMLYw68k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/WQGZGP; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/WQGZGP"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-304545f5206so7594984eec.0
        for <linux-input@vger.kernel.org>; Wed, 27 May 2026 07:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779893898; x=1780498698; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JCe1ATARuyDV0VSOcsB3vUw4NCRZPUu5mXLwwUZOy3s=;
        b=U/WQGZGPkrsOB/yFYV0C2ZX00Am7qVxvKiYn2GmyJdq3auT6QVja85+zoa6ab6RzYC
         CH1QOtYzvC/8ieS1RPMNaJEM2drrVhca3tW0bI0ylrysaQTGR3/thJJWWSfwCS87t37Z
         +sn2uXyVdqhn/gyg5f01wmry1nvDXNzKVxajlYngtwADEi0LKMl+Ai8gOw5h9VNMcc9D
         JERTzJ8uyAZb9UqY0CHnp2MjH4iDSLVMOqrkFt20UierPFwbopQ/QOA8mrhDsqee0/2J
         K1+qLjWq8+aDdS1xgZODVmzjktwa86IaWncI44GqodhEPmENH6mdtIUXLIS3GtoQVo3V
         FQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779893898; x=1780498698;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JCe1ATARuyDV0VSOcsB3vUw4NCRZPUu5mXLwwUZOy3s=;
        b=ZDG5r2F6CiNSwt1cirOnQNRMwk/5M3v1Z7i9oV0d4OU2B4TfnHW9cxBYMTFs/loUEO
         gKqfKGEZ7A0iQkTFnPNIkOpr3TywreNOrnN3GHz8raggf32Sqy8j/Z/uD9+tmGWvoufI
         W91LeIAyqX+/7G0JTWEMaqwxBoKnQph883xibZHcZv0ohl/D0oHpQZEVrmGiUjNCXAxE
         qRFjWhqrMWy4XIa8NVSGPtiTXm1BonjAp+a495+GJ2xY8dKB//8NjwsVVw99/zOp4B8J
         4CmCsxy7W1OfMIgCKbGmtLW7Ef8NKWipB8v3l2HoV7I4me49yJEBaX3QMNUje9SOMB7U
         bOFg==
X-Gm-Message-State: AOJu0YwmvlEc83ggOes67Qkl2EuW4aWg17dl9v4aCcKbFUDKoTg9ddko
	sDHlv2p22n1Mw6ID8TROLGTTde0R+/n3Lj94Ljcfuy4PtkQ2Q4gpZMIu
X-Gm-Gg: Acq92OG8qScmYdzHGJ+9cmwJB+2pgcXMVrvV0UrxfKFFLiPMPXG0gIsF2vyi8sRkaVa
	M5JYPqAfxN1PyfzlVPGK3YRWanjyzsbjyrKoIcb07oe4qTXo3Qyn6h3leBKnMn80OOJj6W020Xn
	u8hv+9bOWM8NLX5G6yNSNmWk3djPvPUhSE1IiGHr7O47ekb4imB2LXHWoYDrilI3RpkjWIgvvrF
	MfoUO9LTFUr0wpnm3fcvkwAkVUZZzXb33LohhAknJuTvUlrA+k/7Hidv9s98A1wKUYsTH1AZUHp
	ZLwB66zZeycjNGvQsbSgO7k5IQJwydPkOKIaWC7GtqzGmeL+XcaDXWHKnyUeXVkSqaAmmDJeRoy
	tf/Kr1LM/Uz5jUVosOb0v3fx1ENelWetbSh7PfgrnmivpeJkq2Pb+zzla9/p/FOa3lxrWGeei/J
	ibaY3k1N+EpJFHkKut006j2HIvtDWqYQoLJc6LNq1eM8ac4JpjR0FDrC6xM19mLzt3W6YfEE/sp
	z8=
X-Received: by 2002:a05:7301:3809:b0:304:ab8:f89a with SMTP id 5a478bee46e88-30448fd5c6amr11255647eec.1.1779893897577;
        Wed, 27 May 2026 07:58:17 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:912f:eb49:d713:7401])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30451ef4afdsm13181418eec.5.2026.05.27.07.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 07:58:16 -0700 (PDT)
Date: Wed, 27 May 2026 07:58:13 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Zhian Liang <liangzhan5dev@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] Input: ims-pcu - fix use-after-free in probe error path
Message-ID: <ahcGUQDnudj6A6Qd@google.com>
References: <20260525151410.42750-1-liangzhan5dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525151410.42750-1-liangzhan5dev@gmail.com>

On Mon, May 25, 2026 at 11:14:10PM +0800, Zhian Liang wrote:
> If the driver fails during init (e.g. in ims_pcu_init_application_mode),the error path frees the pcu struct without clearing the interface data.
> 
> If the device is disconnected while in this state, the disconnect handler will retrieve the stale pointer from
> usb_get_intfdata() and trigger a use-after-free

This does not make sense. How will disconnect handler run if probe has
not completed?

> 
> Fix this by setting the interface data to NULL in the probe before freeing the pcu struct.
> 
> Fixes: 628329d52474 ("Input: add IMS Passenger Control Unit driver")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Zhian Liang <liangzhan5dev@gmail.com>
> ---
>  drivers/input/misc/ims-pcu.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
> index 4c022a36dbe8..fce3232ebf07 100644
> --- a/drivers/input/misc/ims-pcu.c
> +++ b/drivers/input/misc/ims-pcu.c
> @@ -2063,6 +2063,10 @@ static int ims_pcu_probe(struct usb_interface *intf,
>  	ims_pcu_buffers_free(pcu);
>  err_unclaim_intf:
>  	usb_driver_release_interface(&ims_pcu_driver, pcu->data_intf);
> +	goto err_clear_intfdata;
> +err_clear_intfdata:
> +	if (pcu->ctrl_intf)
> +		usb_set_intfdata(pcu->ctrl_intf, NULL);
>  err_free_mem:
>  	kfree(pcu);
>  	return error;

Thanks.

-- 
Dmitry
