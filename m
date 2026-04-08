Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A5420E702
	for <linux-input@vger.kernel.org>; Wed,  8 Apr 2026 04:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775623896; cv=none; b=R9WPlXhRQTeiGaaS4bp82mXy4iIBgcfR4OmgD4x4nEBp0ByL/lNJp+IoQbbIIPRV5oq40i4fYQcxojc35qVgq0mk5dYPxjJTQYqtT0Ve13E20IMT5Ia37hvWoaSS4WhhMnbyHqZ1fZ2QbBgcG/zzZ0FEeH/8EAwIwfP61JZW0fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775623896; c=relaxed/simple;
	bh=5T06DdpHhxcZN6fmyOXkxiFLXjwIljbkBQB2xGEcibk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kmg7z7HBRA935YV6PCxB0EkstV0z86JjsNN9IHe+ks6hhUwBzHHt70bkWNUCJGv52X95HMA1luu8xWsJE+riJjNnfrj5/uXr0mD7ot8dggnnP4h5EK6pfmaTVuAorLars/NuF4FieakR1y303rQne2x/InhC6pSzBx7jsYX8OoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFTOGiIK; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFTOGiIK"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2c7d8bbad06so12130908eec.1
        for <linux-input@vger.kernel.org>; Tue, 07 Apr 2026 21:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775623894; x=1776228694; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JcG6yinoMfklnE0U6L6Pa9p8EXxTbMMYMHSNsdrsQM8=;
        b=YFTOGiIKv0Kyg1weHeFVocNAukWn1mOXa6yG3B70lJcpPlEkYE0l3ojTGL5zHRSCz9
         x1EaFmXvvCe3/Y5hZvk6XChSzLf7DcMEzroZSl1AazZadrRyv4Ne1Z1jvyPZ5zKXGcxD
         Pg6hv5zmgy0Qs3bfxup7t+dTvKqdW3MmGIbk+oySiTj7ZsNg7c+3N0r20wRtnsSwM0Pn
         QnQ9yTDvEPvzZXhOoZw4GeuqZjCsVS1f9ZKb6yhTtBi2HMphrA2E3sDYrLAwF5MRAaJp
         WGmnefGygvJ8j9xS7+r3jwgnTA6CsBo2RgrsOQ4FzoEdBIZXVlVnWPZ6YU9Ecj85hsUm
         Guhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775623894; x=1776228694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JcG6yinoMfklnE0U6L6Pa9p8EXxTbMMYMHSNsdrsQM8=;
        b=OqzgwNLGrjZpyiPXCV/aDwb2fdg/0wH7v1tkdNNmubL+hKwKLh/fjWT4eWXEVKBgqX
         PE7LX3ABc/CwtUWL6xzSbDWq8I7+i2krA+hHeygF2m7H3aH/fM95K/8/cblPWzBKPurE
         47Tl0QKYOwnL9dh3m+OVrQaDL49YZsJrF8vlREirncZH+lPc9N5UEgsx4oSkqlAy9SXd
         799waQk7UWkOFQ2Qcdn0vXBS9mO2IjSi71cR8b9XYSUUGMOEHi/kJzVwEEDT9SjMgpn8
         QNMtilkpC9GJ2hbF4uUaeO3AAQmowb0NY0bewtI1+rA0T8wHF4ULNNp16zVhh88eBg7U
         ob5Q==
X-Gm-Message-State: AOJu0YzH4DoXRgUnxPdRI6EFdHRX4Auk0e8ERuvkuTQqb7NBDfPufdvQ
	K4jux1LcFX2qEMIkEWHwVuINEusK8p1Kyi+IG5ghkKK/osX4oyKy9tmA
X-Gm-Gg: AeBDieu9zM3mNpl/ORoxBmSspccIWbL+JX0Z1oE/MuVUyVMRH0EDWEWgLbzoV1QQwdm
	DhBRXTryJXz3U6d7Uu076cRR7t54EhO9MHJCNAiTHTd0L1TMc54FgSKhUgY6pU6sl9lvc2eUz1d
	PE9TTisHSRzmIDMza96YVpe78hvNBA5Uv5nz6LpOAgCgsZh0o8rEa5dmJicVYf8y5aZiI1NQiaO
	kI+WObY4P9z1fNLcled+YSpfLGYgo05ewB7nFE8I8DFwvrxpLJ9R6EeEX5+A5On32MqKQpKtsae
	Pxju9K1FBZK7HykRJiAvfMNWdBXDtH5NmqT5PLz/22kjdboaYBLl6BHVYHkv0SvkaxYNim/VbIR
	tf9U7ewjn6/udMgHi/RbcDOKoVzO3wp4P5vMODWfkgDpZjrbEpVZjug1CTGIc+aJSMgKZutGEn9
	+nw2hHi7HiaLqpLk/xcrewwj30ZsJjp+rCSjeP8he0TTjp2+4FXatj79DS+iqbtWSz
X-Received: by 2002:a05:7300:e8a7:b0:2c6:31f0:a025 with SMTP id 5a478bee46e88-2cbfc4623eemr10121678eec.27.1775623894032;
        Tue, 07 Apr 2026 21:51:34 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:4faa:4b67:d989:bce2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2cc6e17e0bdsm15926942eec.31.2026.04.07.21.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 21:51:32 -0700 (PDT)
Date: Tue, 7 Apr 2026 21:51:30 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Thanh Nguyen <thanhnguyxn07@gmail.com>, 
	Linus Walleij <linusw@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: zinitix: don't use finger_mask as bitmask when
 reporting contacts
Message-ID: <adXdOjbr0zTiCBph@google.com>
References: <20260408031440.955-1-thanhnguyxn07@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408031440.955-1-thanhnguyxn07@gmail.com>

Hi Thanh,

On Tue, Apr 07, 2026 at 10:14:40PM -0500, Thanh Nguyen wrote:
> The zinitix touchscreen driver was treating touch_event.finger_mask as a
> 
> bitmask to iterate through finger slots. However, on some devices (e.g.,
> 
> Samsung Galaxy A3 2015), finger_mask behaves as a finger count rather than
> 
> a bitmask, causing multitouch to malfunction.
> 
> Instead of relying on finger_mask as a bitmask, iterate through all
> 
> possible finger slots and check if SUB_BIT_EXIST is set for each slot.
> 
> This restores proper multitouch functionality on affected devices.
> 
> Fixes: e941dc13fd (")

So this is effectively a revert of e941dc13fd37 ("Input: zinitix - do
not report shadow fingers") and Linus reported that on his device
ignoring finger count/mask field results in "shadow" contains being
reported, so we obviously can not apply this as is.

So the question is whether this is a mask or a count? Could it be that
it is actually a count of reported slots and we need to stop the loop
after we process the "count" number of slots because the rest is simply
on-stack garbage?

Cc-ing Linus who authored the commit in question...

> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=221278
> 
> Signed-off-by: Thanh Nguyen <thanhnguyxn07@gmail.com>
> ---
>  drivers/input/touchscreen/zinitix.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/zinitix.c b/drivers/input/touchscreen/zinitix.c
> index 716d6fa60..b80525443 100644
> --- a/drivers/input/touchscreen/zinitix.c
> +++ b/drivers/input/touchscreen/zinitix.c
> @@ -445,7 +445,6 @@ static irqreturn_t zinitix_ts_irq_handler(int irq, void *bt541_handler)
>  	struct bt541_ts_data *bt541 = bt541_handler;
>  	struct i2c_client *client = bt541->client;
>  	struct touch_event touch_event;
> -	unsigned long finger_mask;
>  	__le16 icon_events;
>  	int error;
>  	int i;
> @@ -470,11 +469,12 @@ static irqreturn_t zinitix_ts_irq_handler(int irq, void *bt541_handler)
>  		zinitix_report_keys(bt541, le16_to_cpu(icon_events));
>  	}
>  
> -	finger_mask = touch_event.finger_mask;
> -	for_each_set_bit(i, &finger_mask, MAX_SUPPORTED_FINGER_NUM) {
> +	/* Process all finger slots and check if they exist, rather than relying on finger_mask as a bitmask.
> +	 * On some devices (e.g., Samsung A3 2015), finger_mask behaves as finger count rather than bitmask.
> +	 * Only process contacts that are actually reported as existing. */
> +	for (i = 0; i < MAX_SUPPORTED_FINGER_NUM; i++) {
>  		const struct point_coord *p = &touch_event.point_coord[i];
>  
> -		/* Only process contacts that are actually reported */
>  		if (p->sub_status & SUB_BIT_EXIST)
>  			zinitix_report_finger(bt541, i, p);
>  	}

Thanks.

-- 
Dmitry
