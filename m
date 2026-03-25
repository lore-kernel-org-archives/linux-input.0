Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAFF200C2
	for <linux-input@vger.kernel.org>; Wed, 25 Mar 2026 03:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774408049; cv=none; b=BcMG04vzeZ95fHvRtnmr/PjSszG5HqyKnkfz+luD2K8EvJpNWI++paoVX5Pi+7Il5HdfziwqWh2Jcy7UiwEEWIwWNTpwZMpH0aWC1/vdGQR8PjMvtQjvaqpefDFlGLkKpoq3+chI82VqMoKGQh4jJZmQ8e3uShPBEqjKLyXsIoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774408049; c=relaxed/simple;
	bh=aUNlhbFyq1O+rHaQHtemCc59Hx+rwmDigNquGYw9NQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jpoSbxyzc0u4PdLyq9VxZcDapuwROTayX1O/0TEesGK3X67EJwYBF3jARTjBPzQBQyEBh78qT3rjIJHGwxnv1/4wxJxIDWV68YNCJPNzTMwSpHSxQhIVpmpUYZc1A/xl70UWlLwHACmQsI3N/p0mtyEoNEoo/Bm4903+SUZ+kT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKdBMd78; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKdBMd78"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2c0ea57fea7so7590157eec.0
        for <linux-input@vger.kernel.org>; Tue, 24 Mar 2026 20:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774408047; x=1775012847; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WA9CYNO4U2XeTWJ1VvL9JiIeO6k0ZE2Sw4Df5C/By2g=;
        b=JKdBMd78SnhCvg+matKFZy5eQ92JCdEuodMAhQGeelXzNU3hQdU4gkcT3kXJDwmyU4
         ZqmFl+90VndwDHUJz88w3qpfHp7sQiJqA9cMuErVTpJApNgVEaiv4TlSacAVkXSb+4rQ
         8FleVBKuDSzDarxTNKCwN7tK2hSofMmFSb4sdUMZHKfjdZbAh4fezt3q1wJFZJV/ecoM
         DixtI3vsnqZXVRkklQ164UXYBYwTZEJsmFs3mGjYbrlvQPBV7RfeVMYWFSK8SgQ8dQRM
         4eEXJTDP471HkA92kMShBFA2yl3rZeacq2xkK9FFLsN2bEmn2c2b0vuSfWmn/gcGpyxl
         cing==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774408047; x=1775012847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WA9CYNO4U2XeTWJ1VvL9JiIeO6k0ZE2Sw4Df5C/By2g=;
        b=JmSSKQA4IIGa6JxquvhTVvpY3CAttAqAl94F2ReFVj1o3MyBWpHINkWkOwVrBR1wcj
         5hiynsAv+dV9OW4otBMY1DqajRbTxrOYnvBIB4wSP2N3GSvy8F+Slt8VpM9JbFsWsesP
         yGVME7in9E19kq5ewUOVDHc2Z5zMMK7SvQw7O6G0JMHkAG4bQVX6tz3g6nSY2FsqyfqP
         615sNLVPZE5wq+0TiA8UcZcD28CWxkBi5j358EYMhqbgD2DyyKK108UJCxsUVpd9INJb
         F0uEPXqwdhVeD1Fxf/2zvXpTDM6mdAdpNSvVt2xX+Tj6hOKvZSV+tw0iJb05aBoVWZuP
         bAYg==
X-Gm-Message-State: AOJu0Yx/hvRhIoUZjathjx4n2WxAnc39V8wnNTYC+DZYdJ2aBicJNUFd
	UQ7ExOzx3zMOOMApBW0D90ms2c+pKgFnUyshRcmt+bFDmh2AKWYA8hsH
X-Gm-Gg: ATEYQzx0i35qch3BaghofYYYecRN3v1x9dN3ODwEFHoYgKHQoZ+NUiI3aBdK8nQVzHt
	wwQbj6eRb0mybQRWSD1eSsXSVxC+YER4o7Up75DmcjH2Fq8sRkKCBWwYTi8ahNJTv2dHuT3kUVT
	v+0gsPiDP+IX+9o6Et2mwKATmMdEYP3vOYc7U3v4EcWrqJF/1iCIPwjyqUxrWZzYtnpTD+n369J
	bLHff4O+JhP9+QMrqkXcZXu+mTSVQ6yWIyDYUlxgVLz+vWKUh8T7c4fV1UtccNyQaxLgabtNDJA
	uGPVuvOW5SvaqkAuRe0t+ufvqFH8XOUh1C1dgDUX/N53oWQmAn3bENw/JAvS3JoVIumV89rVkJN
	hp6KPYLqtApn4dyzt1lq6jm80ieXicPg0J3loytegRgUbbU8d2xLLkeldFVURs/vn5Ac9qFkvQQ
	HRJ/+ug5lsEmK5ubhxH5qdoryHThRYWmnWR4hAc5EWAtLiZDV1LX3SBZa5VNPsNo0g
X-Received: by 2002:a05:7300:e8a1:b0:2b8:26b8:3446 with SMTP id 5a478bee46e88-2c15d294bd1mr733329eec.2.1774408047292;
        Tue, 24 Mar 2026 20:07:27 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:a686:fd7f:70d3:9156])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c15517eaf6sm5158859eec.28.2026.03.24.20.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 20:07:26 -0700 (PDT)
Date: Tue, 24 Mar 2026 20:07:24 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kees@kernel.org
Subject: Re: [PATCH] Input: gf2k: clamp hat values to the lookup table
Message-ID: <acNRJWOt0_G8gJ5N@google.com>
References: <20260323074541.93413-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323074541.93413-1-pengpeng@iscas.ac.cn>

On Mon, Mar 23, 2026 at 03:45:41PM +0800, Pengpeng Hou wrote:
> gf2k_read() decodes the hat position from a 4-bit field and uses it
> directly to index gf2k_hat_to_axis[]. The lookup table only has nine
> entries, so malformed packets can read past the end of the fixed table.
> 
> Clamp invalid hat values to the neutral position before indexing the
> lookup table.
> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>  drivers/input/joystick/gf2k.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/input/joystick/gf2k.c b/drivers/input/joystick/gf2k.c
> index 5a1cdce0bc48..78fba36285dc 100644
> --- a/drivers/input/joystick/gf2k.c
> +++ b/drivers/input/joystick/gf2k.c
> @@ -164,6 +164,8 @@ static void gf2k_read(struct gf2k *gf2k, unsigned char *data)
>  		input_report_abs(dev, gf2k_abs[i], GB(i*9+60,8,0) | GB(i+54,1,9));
>  
>  	t = GB(40,4,0);
> +	if (t >= ARRAY_SIZE(gf2k_hat_to_axis))
> +		t = 0;

I think if "t" is too bug we should skip the loop instead of reporting
the first axis.

>  
>  	for (i = 0; i < gf2k_hats[gf2k->id]; i++)
>  		input_report_abs(dev, ABS_HAT0X + i, gf2k_hat_to_axis[t][i]);

Thanks.

-- 
Dmitry
