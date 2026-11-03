Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793731524;
	b=LCypiDpK94mSfONDZpqDGkKIHVaf2M+pE7ySz/URCkMhf5Xuq2RxlnE+UUkJT2MOJ+ht
	 BHU9wrTyAL0ORDZWyzwZo9ooJVq5AojPTVwg9Rh2ipLG4PFBaSswVQwhNX8m5ycB7wOpJ
	 FcumNpiGFeD9sJCrfxkN+29MeFQKJWsbCEO2FD5WylcF/Kq4eSvbv/9MTHYQt7GRtA1Nl
	 QFq1DLH9GxiwgNX44QfW89ft0NbofkypEomb0o9LfSYRW+aPc96bvWrxpgp60zMIEl1B5
	 Z5ksqlhtjVwMjArbrEUROK1BMgfNBxCGIibmQFk77Twf+5+pkHzRaoYdgof74ZWTKwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793731524;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=dxl6974/XeNGL3VGfuMejNoLR+R+5VwHaUl0w+woIxw=;
	b=sAWr6MU8YuWHFvwIY32KkiLT3uo2XrShDaUQAb0fVAXBSeD/5kWgK2vrot1pUv1+D7fv
	 dtXS8zvXW9N/aKDMn1z/aG6ybmQvfnDxmp432N9XE0GUxnMB0q9IEecj7l727JUfsiqR9
	 p9G5f6RHx43Hoy5qaNhWXY1rm2JbUz7qm/AU0WraVMsJb7FpMHIgpGBVqeuBiPUNTx8+N
	 wj7ifO1MozQYfy2unTp5/Cnm8jpWK9TYi8+eDN20gClLcz6lCqXpDBSeAoKj+BmkUUVS9
	 3V9bdIqU9eOrsrgEl5x6nxX/fPq4MhnTGZLYejvk8ZvzxdQlRrQ7R9cBIyM8FKeF9+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="bRn/Owv1";
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14014606A324
	for <linux-input@vger.kernel.org>; Tue,  3 Nov 2026 18:45:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14014606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bRn/Owv1
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-36a18fc7a38so8649912eec.1
        for <linux-input@vger.kernel.org>; Tue, 03 Nov 2026 10:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793731523; x=1794336323; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dxl6974/XeNGL3VGfuMejNoLR+R+5VwHaUl0w+woIxw=;
        b=bRn/Owv1Hbfs4AmSN8ZJ7uUv/i0z0jsI2n/FSJWVnU6sdNs5Vsb6Xm0EVSeeyfd25e
         s08GRHSnBiw1wt2ZJ57iKnFkzIRWVkEfnnoHjWhJR6uaMXyzdi2V1uY1dCOJnvcLcAGa
         tOl46D5H4NCfA8pH4ty8mpstLEBI841odDGE8iZL288BlhkJoNYgWzNsmV3/wZQvJ+Wd
         b1IW+EwkaujwJlpUkvjFTkIXOHtGxTisL8ZYCyaQVlXAw4Nhu+h4ZNRpfaPBcmrbx2YY
         dlot7YrLO0aHSIq4qsDCn2RGmFQI/dsYji3caC76+BjaLIBiVvV1Oes6fIIA41IYUj8V
         x01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793731523; x=1794336323;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dxl6974/XeNGL3VGfuMejNoLR+R+5VwHaUl0w+woIxw=;
        b=wPXZoSumj2QxJacUpcy4ibdTTeUultYhNAQTvZ80q+tFuuy8aVEECJ623hK5GLSpco
         B/H8HdNwrobk+yEVnvfj4WSsBSAQnNoFCUW81HrK/M/8SQquB3kf53mXkrgCFTYM2ILd
         BLHBbhagkUURFRMj/Rsy5Q5pF9vqEdDgNPDN+mSiyGBWVltuQgbPj/c42dDemW6W8PjX
         uvP31ML7MCqLJN4hsV79nZ/it4M0L39WgvLXyezp+Ey5zNA3E2i0nNT6QH4rm03OyPCr
         zXA7vwFeZ7cGA3i2hfrouFm9rjzew+kV5tDF1Go7loxcyTtO+BNO+PepJYro19p4hhVF
         a9MA==
X-Gm-Message-State: APuU4Z9inc8cgnR5dsuad/wLuqI80NbhTExiFE4wH8uBxJqORX9+NFUd
	N0PXyBKjm/op5CTUUNba5f2IERYWkzb69EMlJpWOF5XkvIUV8TtM2BNpJ4Wmjg==
X-Gm-Gg: AYBFou2H5SZLMxk1YF3g7/NnJs0xjCHw9rOztDu+lN6Tio4rDTZxdE/fOam8gWTDrEF
	PslWfIbPBEmjrQ8Uj3zr2lxl3N8OIccjqQKVaj3pEtuwxsPXW24gBcCVtWiCzpGZGRKSJaqopDG
	wO8SIuPzlNds+Sr95xkII0/vmvN5qPcoOgJnaTnAla8/vepDOhySeekEgrebqN5cHH3f2DigTFE
	BGSC+cfMl+BzHcTeOlukbMRdNE0Im104KjfVTtmnR4jN4QQfYiTuswm1mlV0sv0rJ2yhvYVH2I0
	veNl1V9tBEz0CvYJ37Yz7btkkNk67CUVzIsjv4J5799DPuHKAFAUqiVth1+uAMSnDZRIe/FzuUc
	Sjkl3wjZ5zPydPLv/GqWOrAl8OHSdIg22Q68IeerG/37EGkOmDPTfJHvqgXSec5FOjlQyi120+O
	6yI48m/gmMREHUlrutKsFEo2w/3gqu1SDiU0wQU9sdmrwAlYZ8aQiqye1HZSDBzCcOvHIRqpmpW
	chFhvzS8KkUpTfPQx6QHNK9rf/i3jYsK6FVkn3fzEmXHbUDJoC940ixQRM4wYe+mEHuxu69mCUO
	HNN42WnJrKFfCz22/tcLSGUWOsPnW8eopne32MmLUqLXMeMwoWvA+0Xfu98JuuHZrNAJD+ZOItQ
	67mNT9qd5RY7i8Q==
X-Received: by 2002:a05:7301:648a:b0:369:d793:328d with SMTP id 5a478bee46e88-36c9dd475camr1585502eec.31.1793731523122;
        Tue, 03 Nov 2026 10:45:23 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:88b4:22ec:d621:c1b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca3788bffsm102648eec.1.2026.11.03.10.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 10:45:22 -0800 (PST)
Date: Tue, 3 Nov 2026 10:45:18 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Guanglei Zhu <zhugl3@xiaopeng.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	liuc63@xiaopeng.com, stable@vger.kernel.org
Subject: Re: [PATCH] Input: joydev - avoid an undefined shift in the legacy
 0x read
Message-ID: <auorp8LgmW8Fr9tY@google.com>
References: <20261103084135.426629-1-zhugl3@xiaopeng.com>
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
In-Reply-To: <20261103084135.426629-1-zhugl3@xiaopeng.com>

Hi Guanglei,

On Tue, Nov 03, 2026 at 04:41:28PM +0800, Guanglei Zhu wrote:
> The legacy 0.x read path shifts the axis values by the calibration
> constants that JS_SET_CAL installs:
> 
> 	data.x = (joydev->abs[0] / 256 + 128) >> joydev->glue.JS_CORR.x;
> 	data.y = (joydev->abs[1] / 256 + 128) >> joydev->glue.JS_CORR.y;
> 
> JS_CORR is copied straight from userspace as three s32 values and
> never validated, so the shift count can be negative or wider than
> the type, which is undefined behavior: the shift compiles to
> whatever the architecture does with an out-of-range count, and the
> compiler is free to assume it cannot happen.
> 
> Clamp the shift count to the width of the shifted value.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org

Why do all these need to be in stable?

> Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
> ---
>  drivers/input/joydev.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
> index 32459fd8a7c1..4740099599bf 100644
> --- a/drivers/input/joydev.c
> +++ b/drivers/input/joydev.c
> @@ -353,8 +353,8 @@ static ssize_t joydev_0x_read(struct joydev_client *client,
>  	for (data.buttons = i = 0; i < 32 && i < joydev->nkey; i++)
>  		data.buttons |=
>  			test_bit(joydev->keypam[i], input->key) ? (1 << i) : 0;
> -	data.x = (joydev->abs[0] / 256 + 128) >> joydev->glue.JS_CORR.x;
> -	data.y = (joydev->abs[1] / 256 + 128) >> joydev->glue.JS_CORR.y;
> +	data.x = (joydev->abs[0] / 256 + 128) >> clamp(joydev->glue.JS_CORR.x, 0, 31);
> +	data.y = (joydev->abs[1] / 256 + 128) >> clamp(joydev->glue.JS_CORR.y, 0, 31);
>  
>  	/*
>  	 * Reset reader's event queue

Thanks.

-- 
Dmitry
