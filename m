Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB14347FC4
	for <linux-input@vger.kernel.org>; Fri, 29 May 2026 21:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780090422; cv=none; b=mroOJm8VpkoLSSgZbnJu28aULcVczPpinZB86y0oxqCX3O4Yw0SrmwnvHPPq49qLfFimnQludFdySuju9LdFt3+bmW5P/2KtmuSnp0+XAYuHf2ZN7BHDH9eJAaAmIypSmnKvl/P6FH/gsiMeF2wox7kGXoERmIoZwqJMDsrsjAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780090422; c=relaxed/simple;
	bh=E/02rMCLOCCTLx/MMkXKw4+cNdDOuDTCpreZlE9RoLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PehLiZyVCYpcpea43asdLDjOOYo1j2C4w7cUk+xuS3SLXDf/7PAEmDIEIxbwcKUmzn29sa9gaItIDAPwVg1G+/7pQIS3TpTJeFIwODcxm6taOkDjTug4U0DtyfjkWj6k6etdBH69r1IIhf8lpfkv6KuwW/yDo/QdYAiMcg9mKts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WeWvsZdK; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WeWvsZdK"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-304df7ff4c2so1258687eec.0
        for <linux-input@vger.kernel.org>; Fri, 29 May 2026 14:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780090421; x=1780695221; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sJ1D2otFLPuWEdsKwzPQvA/v2Ndyxa5XuPg8CM6LTTw=;
        b=WeWvsZdKdabjFea3nOwndFzWbjxGufigyIPAgl8ns1mCTTz45TJeDnqWGupw4mDZHH
         zhtc2GMsmXCaPmzFrjI9SlDqNeLbb8TayaUwPw8LYILUHLXoUBaGaTclgtMTgfNOg3Zm
         rk/dag0BfpgP2Xmx2FYzLPrN+ibj2lzyBoyrmeL1EYTZ7HoYOnV1lT295CCoOJY/7w6F
         xQVYsbFoKiPei9+Ed1z19dt4yLS3ZuhMkhBZFeLoJiK9tq4EEMaRi+c0mj1PFAPGlbCv
         jhvR+lVHZDEEAFfds/wcYeHJ8LXOvrjjapJwCsa06Zf3fLkeNMsEJvO6W2BvhtdEBDTM
         P//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780090421; x=1780695221;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sJ1D2otFLPuWEdsKwzPQvA/v2Ndyxa5XuPg8CM6LTTw=;
        b=S36ZUoFY/GA9tNA+4HKMzf0IP79SrRjxZaef6prwDeeIPz344pPFlUtHUrV4ZSJ5/w
         vYYBEW/XujPQcyOZAjUDEKL+b7/YiEGMiXMpD0OHJfG/F/enw1KA7ij9dr0viA4SQzZa
         Lr3z6ebYmzfkejnHRWQV0Fp0jR8xoNECIBCOtPevfOCzh2NnltM/SndxaAFvsFcDos/6
         MMuRFmauTFTM2ZCUvGyIuY1aclRhCQacUohni6BgoFbj01TehnmYaYG94ngIdazB4b4f
         T3LL0GH8UCeJXer+KdQvy7+E26Bv9iXz9oLwcsEy8XqqN15GKnqjgdHjHZKelrkCAYYM
         oqOA==
X-Forwarded-Encrypted: i=1; AFNElJ95A0kxBYkphhA08eF3V4jrjvuy75Rbe7UuA3tqVehEHdHA15233pwWGmuCry5sn0iIYGfNwksOOomrlQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxyePHjH4rMfkbVs0QXV1WO2DzUVbpJOH1uCptkGx1J/w1ePsAi
	QcH2jpqfLpeGpBqtaU3p+QgdRc2N3MkVMY4xykczUOEItdUuJGzA88f2
X-Gm-Gg: Acq92OGqzW+52bdNStw8TujRqSX0ZptnqMfU0/HXNVktp9QC/K32jF78ksXWFsSUmsF
	qH747jKBPfQjts6w0yeInFZzmuZH0B9JIsdVojj8gyYoaWncKGN46DNBLYMRlItjePBsloQFajW
	6Md/dPMMMKix6YAimZJN9xLoe3NBRcxt/rul+D+LTQjRwGjMLTiRAdBjCTbilr2ukeSdM8RwpVs
	BYHWsqB7bBpoBH48192SAxDp88aBDLynP3pGtLwckbhWvAfpW++yCIpobSojv+dtZ4hxkCGZxAb
	4qgUtw0JyI4Tsf1E+FY13QGf8AGyy74CpWEZUQiiw2wA+ckECIqLsJ3zSyIrDalH8+czswNbFOL
	vChIv/IOyc8V8rShCAbCRJY737Vm4jI6sTd8HLhuDUnVOruaYWVhrAWU+ABz0r1dSf0KvYBVSfE
	a6UryNMGSfxLWZzJznAK99w6Pz9mLjJdhXoBRC9zrCyYJrVGMyWzo027APkIy9gf+/oHOW3k0uZ
	Ixhe6yzSA4ZZg==
X-Received: by 2002:a05:7300:a10c:b0:2ed:a58c:942 with SMTP id 5a478bee46e88-304fb1df763mr494445eec.8.1780090420516;
        Fri, 29 May 2026 14:33:40 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:307d:2a52:8823:4a01])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed2f2904sm2450179eec.9.2026.05.29.14.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 14:33:39 -0700 (PDT)
Date: Fri, 29 May 2026 14:33:36 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: Jinmo Yang <jinmo44.yang@gmail.com>, linux-input@vger.kernel.org
Subject: Re: [PATCH v2] HID: wacom: fix slab-out-of-bounds write in
 wacom_wac_queue_insert
Message-ID: <ahoFk5Ox-TMtgKHM@google.com>
References: <20260528175945.2987781-1-jinmo44.yang@gmail.com>
 <20260528184231.1F0581F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528184231.1F0581F000E9@smtp.kernel.org>

On Thu, May 28, 2026 at 06:42:29PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] wacom_wac_queue_flush() allocates memory with GFP_KERNEL while executing in an atomic context, leading to a 'scheduling while atomic' panic.
> --
> 
> commit 70e9615b93de485ba1816f95e27e25b054df4b6a
> Author: Jinmo Yang <jinmo44.yang@gmail.com>
> 
> HID: wacom: fix slab-out-of-bounds write in wacom_wac_queue_insert
> 
> This commit fixes a slab-out-of-bounds write in wacom_wac_queue_insert().
> It prevents kfifo_skip() from operating on an empty fifo and validates
> the return value of kfifo_in().
> 
> > diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> > index a32320b351e3e..489ca68f1560f 100644
> > --- a/drivers/hid/wacom_sys.c
> > +++ b/drivers/hid/wacom_sys.c
> 
> [ ... ]
> 
> > @@ -62,7 +62,9 @@ static void wacom_wac_queue_insert(struct hid_device *hdev,
> >  		kfifo_skip(fifo);
> >  	}
> >  
> > -	kfifo_in(fifo, raw_data, size);
> > +	if (!kfifo_in(fifo, raw_data, size))
> > +		hid_warn_ratelimited(hdev, "%s: report is too large (%d)\n",
> > +				     __func__, size);
> >  }
> >  
> >  static void wacom_wac_queue_flush(struct hid_device *hdev,
> >  				  struct kfifo_rec_ptr_2 *fifo)
> >  {
> >  	while (!kfifo_is_empty(fifo)) {
> >  		int size = kfifo_peek_len(fifo);
> >  		u8 *buf;
> >  		unsigned int count;
> >  		int err;
> >  
> >  		buf = kzalloc(size, GFP_KERNEL);
> 
> [Severity: High]
> This is a pre-existing issue, but is it safe to use GFP_KERNEL here?
> 
> Looking at the call chain, wacom_wac_queue_flush() is invoked via
> wacom_wac_pen_serial_enforce() from the driver's .raw_event callback,
> wacom_raw_event().
> 
> For USB HID devices, this callback is typically triggered by hid_irq_in(),
> which is an URB completion handler that runs in an atomic context.
> 
> Since using GFP_KERNEL allows the allocator to sleep, could this lead to a
> scheduling while atomic panic? Would it be better to use GFP_ATOMIC instead?
> 

This looks like valid analysis. Would you be willing to send a
[completely separate] patch?

Thanks.

-- 
Dmitry
