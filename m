Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9126435DD1F
	for <linux-input@vger.kernel.org>; Mon,  2 Feb 2026 11:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770030255; cv=none; b=vEfuMwT1a9HQIlNK7NXuydiYAu229JuzprBbgDDgs8nD6x5y6Czc70FA1PyHjaUun4guFxntfvOptQvyAGGPvRqm5G/TPkwhKOHvf4CegMm9rI1n74iGBRCoEtTzpmLGxGkiTKMcsiE90eILzKyHtIO3PuKB2ToVyWS+nJ6cW6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770030255; c=relaxed/simple;
	bh=Loys3V60w4/i089Z65xNUXkI9S+P9TwJDpkBw4scIF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XeDkpK7oAEtYmfPS05+oCKEucwisQKeOYr/2JhKC2fB3IdBD+vtmTyj+/6s9dUi4DJ2gxAEV/E95I7OhbWloKIfODzd+pbdYDWNAniLYg6AX1hkZc7VqJjkiTUUnttm/8CYhAJXVGDyQiM2zfBqi9mOKtVuDZvcEcnxLh1tw3NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ncC1Dr6k; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncC1Dr6k"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2b72e49776eso7983843eec.1
        for <linux-input@vger.kernel.org>; Mon, 02 Feb 2026 03:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770030253; x=1770635053; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XpnvG6a+X8idDiHgSW6vo1XR9f+nMb7ZNZHPlBThMwg=;
        b=ncC1Dr6kZdAZXOJFQGyUyj8n19L42Nfze2MUVNAwlVnCcpJXzQ9EkkbxOkxzbG7jcX
         oshktc2x1UuniOOMt1O2ScGJOeq0z+YYfmbsfkWvQYvcMzybhHbYUXcX1bpaAtdf611l
         hae1guQ09kLAV8BRnVbhahMJwNHU777HrjLNjGBzq9g8K7k6wawVOE9+r37rkxcHWgE0
         TYRQvBLa6McGqUEP8bp20Icgk3QH1Xf091CSZ6g3aQllRfKstCaFhBfaymDcrrHQrlVf
         3+2ck2qLMx0JUtwrqWWO8NZ1D4BS4f+KFT7+iKh+Te9OSGdJegypDN5uMb2DXT2YwbFL
         46jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770030253; x=1770635053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XpnvG6a+X8idDiHgSW6vo1XR9f+nMb7ZNZHPlBThMwg=;
        b=Rek82SeuuPpGgCjdzUUHUDMRh99v1gE5nDKKDLQUSr/Ek1DNvf3/gsAFf/xW9cTXfd
         UmP4apQE5CjgkOczWO3CJsAfV1ZFsY647JYdB5gVOqtTJ0y89Utqt3vPIkNwJuMjjndh
         XMY9JnSwBfhcDinw+jBUQOiUYy9DeblBtZOCfwrSZP2TjAhF0IYpgjDL3/b3isogkgUd
         QUfsZvj5kdvgHG4vFcUehqG7x6qbFIQOFV9XdffiTXUu05Yf4gaPZsCR7LjxO3+2bW4M
         cIigJfcu2DCCaidMd/0h6F7v8l/mx975Y5hNq6JdRQ7gYl7cI0LFU1UJXEmZq/kJcIQa
         gb7g==
X-Forwarded-Encrypted: i=1; AJvYcCUPbI8AM7Yna4+Hb5FT5DMHC2Br6vKpG6Twjogy+VQoPw02S18I+h/FzEE6m3enlId+BITlBRODKhnjLQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzSWfuX+nsz7Cv3chgpNUW9i44fkriTUIYikGxs3etDYicAKynn
	4oE5OeIl8DpZ4ouOCs5HoxGiRVw3BP7R2MPfC+rP43yNGuRHgdF50cmR
X-Gm-Gg: AZuq6aLmlG8W8ypFgx8pbaVCfT4l80VSDHa3gwiGdgkl7j0BJnmPDTnRnaKKqI0K51T
	BRb4lKwqP1UikAGU5c7Eqeq9gDVf/t/01fJ2mcNJ21cx1uFhGmzh0lSItBWkfrRrY7JFxn6OXYF
	1E5UB+d7vbCtQJUQAZTA7yidNZBb2vZ9ZK3qQxmkSOJf+fou7wRwUsOZDhsRO1VcElF8exXzoW2
	YZTXz7IQlVM+xCCeOZpNZdDB3PiB4CC0kdwpwed6pQrUM34lSC9v4ndDDJXkx3vC5VVB9kixXfY
	4ojsOYSW73BeeteXO7J64U4MMZ9MHXYrw5kIAh4AqZv1pIc+jyvAC+LxHAlrrqDc/dnGezucPA2
	UWis8NICBoLs3u9MjMSr1rgYbZRpJzhluz3QIfI0fIGuYoCgoU3Tl/XtYt6RkZYUIm++AOJcd+Q
	54O2jwEJhlJx2rtOhIQOKgtTVAXDc03NUYdR5LfML9cD8Cxr3VQEbDvoQeVaTi9QM=
X-Received: by 2002:a05:7301:2f99:b0:2b7:c5d7:84bf with SMTP id 5a478bee46e88-2b7c86756ccmr5986307eec.19.1770030251139;
        Mon, 02 Feb 2026 03:04:11 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:2956:5cef:ff00:c68d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a1add4c2sm19657728eec.27.2026.02.02.03.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 03:04:10 -0800 (PST)
Date: Mon, 2 Feb 2026 03:04:07 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Luca Weiss <luca.weiss@fairphone.com>, 
	Griffin Kroah-Hartman <griffin.kroah@fairphone.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 2/3] Input: aw86938 - add driver for Awinic AW86938
Message-ID: <aYCCv6nI2QkvD8rb@google.com>
References: <20260128-aw86938-driver-v2-0-b51ee086aaf5@fairphone.com>
 <20260128-aw86938-driver-v2-2-b51ee086aaf5@fairphone.com>
 <aX6whqw7XyaKMd9m@google.com>
 <472d7db3-db34-4966-aa17-588e1153ba12@oss.qualcomm.com>
 <DG4EAYDXMGQS.2MKAJKDFQCFEG@fairphone.com>
 <34fa533c-b9ab-4025-b9ad-4041837e790c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34fa533c-b9ab-4025-b9ad-4041837e790c@oss.qualcomm.com>

On Mon, Feb 02, 2026 at 11:19:36AM +0100, Konrad Dybcio wrote:
> On 2/2/26 11:14 AM, Luca Weiss wrote:
> > Hi Konrad,
> > 
> > On Mon Feb 2, 2026 at 11:12 AM CET, Konrad Dybcio wrote:
> >> On 2/1/26 2:49 AM, Dmitry Torokhov wrote:
> >>> Hi Griffin,
> >>>
> >>> On Wed, Jan 28, 2026 at 04:51:14PM +0100, Griffin Kroah-Hartman wrote:
> >>>> @@ -717,9 +746,19 @@ static int aw86927_detect(struct aw86927_data *haptics)
> >>>>  
> >>>>  	chip_id = be16_to_cpu(read_buf);
> >>>>  
> >>>> -	if (chip_id != AW86927_CHIPID) {
> >>>> -		dev_err(haptics->dev, "Unexpected CHIPID value 0x%x\n", chip_id);
> >>>> -		return -ENODEV;
> >>>> +	switch (haptics->model) {
> >>>> +	case AW86927:
> >>>> +		if (chip_id != AW86927_CHIPID) {
> >>>> +			dev_err(haptics->dev, "Unexpected CHIPID value 0x%x\n", chip_id);
> >>>> +			return -ENODEV;
> >>>> +		}
> >>>
> >>> If we are able to query chip ID why do we need to have separate
> >>> compatibles? I would define chip data structure with differences between
> >>> variants and assign and use it instead of having separate compatible.
> >>
> >> dt-bindings guidelines explicitly call for this, a chipid comparison
> >> then works as a safety net
> > 
> > Are you saying, that
> > 
> > 1. we should enforce dt-bindings == CHIP_ID (what's currently done)
> 
> This

No. If there is a compatible chip with different ID (for whatever reason
- maybe there is additional functionality that either board does not
need or the driver does not implement) we absolutely should not refuse
to bind the driver.

Hint: this thing is called _compatible_ for a reason.

> 
> > 
> > or
> > 
> > 2. we should have both compatibles with no handling based on compatible,
> >    but only use CHIP_ID at runtime to change behavior
> 
> This is spaghetti

I really do not understand the aversion of DT maintainers to generic
compatibles. We see this in I2C HID where we keep adding compatibles
for what could be described via device properties.

Thanks.

-- 
Dmitry
