Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DE448382D
	for <linux-input@vger.kernel.org>; Fri, 24 Jul 2026 23:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784936930; cv=none; b=R4R7W4ZZ5in62ukvJxx56n4/Vfzo+TUtkE2x5ZktKwD5Pn3fWwrxokGgM74I7N3lDtUVAfcNLu9froIuEoh7KngAqQZkUK43eoc+XUiwQYfHoNb5PEYzmXtAxxf1PbeTYsbht8MfTzrYerRN2YCvV+999qedori+ppwpa2zRWt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784936930; c=relaxed/simple;
	bh=5gdN6MbyupG4up2v3CNyc/2HhdKCpR12n0Nqn1/8SxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DSPZY4UcpMaBnYKtbNPQ3/oG9F2vHU5/Y27CyrHRDfxtXvNuTHNaZ+od3qAqSRdBjVXUq+KSkbve9GKveTkOlB5ldloQhOnNHXlsH6vv0ijRVW/UeDyB66/jY4Qf/zKjc4M0iwvPl2JGlRD7ZRVBCp1JWj9zMCu3AxHWIhHvK6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iycXByNc; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iycXByNc"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2caea3f742bso13020785ad.0
        for <linux-input@vger.kernel.org>; Fri, 24 Jul 2026 16:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784936924; x=1785541724; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=isHJkq5dJt9QVOk/Tc0QQ/ea7BPXsGmxmAavDSM2GtA=;
        b=iycXByNcCkV+Lca+jVCFyK2Rxx9DID1p4PNmB35s0uSRQswHqN6XbbKeN0hETemWf0
         wSFQ6NFYiande5nAMPgz8W1bf75o+NmWKSWhGxFNVo4lUqI53qzZWpXC49ERee+/IJis
         8LMdg0c0ZgTdLBn6xt/mG4MOZXqXpwSIeDje73Hybvpa+KG63IOWwrpUYHVdiGRTpAes
         ag/KoCW0DGdzsg/CDE5GSmgl0a35wvAlN8JLRCgsasiMHlmQyBPlxS1xPX1dwPtOlvCY
         1BsU2TGhjEY7tJZVvVC/I1SlGRUnkkG68o3vX/aTFoDRxTSh7GQBty9k9Lsy+dBa4V4V
         9s/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784936924; x=1785541724;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=isHJkq5dJt9QVOk/Tc0QQ/ea7BPXsGmxmAavDSM2GtA=;
        b=U/XgtLRHJy8BvKeRU3+iVMobP7bQLKwLYQrbL92oXU81TD/R3gechyqFbalUf6WFfY
         HFyHTgucEmRGadOAX4t5GCvJQukRYpmSmuQvzWaHS0wYz4n8lt91I+rkRJZraIhehg2Y
         lEJozEPlXMamR4a8L6d6RrhE1qhN6dZeqNUZWRfYCsjdtsla6kmcm2Bhzm5tmiR9qRV5
         AUDYLt2XioMUI6w5dEx3CxJzuUwnGmlKrfROAvWgcwPmG5xvb5qscRaRSpde9/BikeUn
         jFewrTu2RN1Oxke5V51mmvRyc9mJf/cpct+h3dCDQG+du/4hWhgyWmIGgHk0I2h1gTJY
         X0FA==
X-Forwarded-Encrypted: i=1; AHgh+RqKLX99sBccNFcJBpkME0Tlf6nxIDWJMm/lSb7J5RNxfwnzMlu0Elj6l6BNwYgcRCnE1LQ7dwt3kY5uWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYeeCc35CbZ05lOWtbe3R0I1/M6odNer7nfXJUNrX5G/deTOWy
	I5DRp4eTEtmMziumTc0tWzMPf+KqYYJER9qx8jIVDERVaG1SITJXibiS
X-Gm-Gg: AR+sD13IaBS0RQl60tfqJeYtxu2Gy7exv+94pJWXn/4D/H9blv1dYIyVswclyV9013j
	mQfT0X4gbqcSJafHmchLqmVckaUNvB/FU0MOHffwf9HdKPC+gjVcqQSP5ICgHYQlLXnviI2dDYa
	agESyiA7P+LCGVm+DTYgCutjXkyy4zrkGX8kXua1+HVBHcp/g6sQc5sp37fKwO17lgniVBPJdOV
	lpGlqrl5WbXDsNmq/bQ1Yn2k0QzGblPzGzU2rStKvcNzIuqnm5szPYA6CmBgFpuBxt+250L7oFo
	r4jdsLs+bfucYx6FMnsnsDmkWkVzfjPKUPwayDisjfwymgfgneSEwHbh+Z5P3IrSsrflyrr4Gio
	qVOos3tmNFI26V6Y5dGRRuacKdqfigF8V80lwqq/vaX0mMaOolIA0uYdnPwA2ArZzdavoAKWphY
	HgQr2K8H/xClDixOZmQQXnXpsPPC49nmYmg5+tWHnNMmneBVeWxvFlMQ==
X-Received: by 2002:a17:903:46cc:b0:2c6:9f66:d573 with SMTP id d9443c01a7336-2cfde67beebmr4779085ad.2.1784936924553;
        Fri, 24 Jul 2026 16:48:44 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:40e1:40e4:dabe:543e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc548f5dsm3900707eec.17.2026.07.24.16.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 16:48:43 -0700 (PDT)
Date: Fri, 24 Jul 2026 16:48:40 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: HyeongJun An <sammiee5311@gmail.com>
Cc: James Ogletree <jogletre@opensource.cirrus.com>, 
	Fred Treven <fred.treven@cirrus.com>, Ben Bright <ben.bright@cirrus.com>, 
	patches@opensource.cirrus.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] Input: cs40l50-vibra - validate custom data from user
 space
Message-ID: <amP5s-Dzp9_qWxAd@google.com>
References: <20260718074032.1864861-1-sammiee5311@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260718074032.1864861-1-sammiee5311@gmail.com>

On Sat, Jul 18, 2026 at 04:40:32PM +0900, HyeongJun An wrote:
> cs40l50_add() copies the custom data of an FF_PERIODIC/FF_CUSTOM effect
> straight from the ff_effect the user passed to EVIOCSFF, without
> requiring it to hold anything:
> 
>     work_data.custom_data = memdup_array_user(periodic->custom_data,
>                                               periodic->custom_len,
>                                               sizeof(s16));
>     work_data.custom_len = periodic->custom_len;
> 
> The driver then reads two words out of that buffer: custom_data[0] as the
> waveform bank in cs40l50_effect_bank_set(), and custom_data[1] as the
> index within the bank in cs40l50_effect_index_set().  Neither read is
> covered by a length check, and custom_len is fully user controlled:
> 
>   - custom_len == 0 makes memdup_array_user() call memdup_user() with a
>     length of zero, which returns ZERO_SIZE_PTR rather than an error, so
>     custom_data[0] dereferences it.
> 
>   - custom_len == 1 allocates two bytes.  A bank of ROM or RAM keeps
>     effect->type out of the OWT case, and custom_data[1] is then read one
>     word past the allocation.
> 
> The bank value itself is also mishandled.  It is masked with
> CS40L50_CUSTOM_DATA_MASK (0xffff) but stored in an s16, so a
> custom_data[0] of 0x8000 or above wraps to a negative value that passes
> the "bank_type >= CS40L50_WVFRM_BANK_NUM" test.
> cs40l50_effect_index_set() indexes vib->dsp.banks[] with it before the
> switch statement's default case gets a chance to reject it:
> 
>     base_index = vib->dsp.banks[effect->type].base_index;
>     max_index = vib->dsp.banks[effect->type].max_index;
> 
> Require the two words the driver reads to be present, and hold the masked
> bank in a u32 so the existing upper-bound test covers the whole range.
> The da7280 haptic driver already range checks custom_len this way.
> 
> Fixes: c38fe1bb5d21 ("Input: cs40l50 - Add support for the CS40L50 haptic driver")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: HyeongJun An <sammiee5311@gmail.com>

Applied, thank you.

-- 
Dmitry
