Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BBA23C4E9
	for <linux-input@vger.kernel.org>; Sun, 14 Jun 2026 21:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781472922; cv=none; b=VyrN+CpyfLoDYzBd0wJeLnjz0KsDSTipqIcOOFvZOdmz8qyCKLCuGT+arl47cLJYbk96nt/PL67tj+e7ZVDJoKvl/0ZnWjPOLX8P6RhsAIs5KJutADkH3W12D+EIqrgr1WeVOS71x0MV3Bi5cBJoFbsZjGexZzNnmi3AI5Wgq3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781472922; c=relaxed/simple;
	bh=NTlpPwHGxbQOUuH6LSKYMjXD7cqvqDF26OtT4i9SrMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0IlsdL3+UF1uld3/9prQrD+r/fLiVNbbZxQvIMguuhsB1aH1xTb9PwYzsmUG/LqLlWenKlhkGat3BI4DN9f0IjIEONgKok5HAwEfnJEqpyZXbY+yUQvnN6Koj3xwEDcXcvXgPP5E0cR36E9aFOWbqxWHnGXRw2fk5yBTM9oAxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFu2UKXr; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFu2UKXr"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-137dd4cc208so1413562c88.1
        for <linux-input@vger.kernel.org>; Sun, 14 Jun 2026 14:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781472920; x=1782077720; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1MW0ZjG8vB1FPedvEzSZlBi25skp+ZtX2ykLQQ0uGHk=;
        b=VFu2UKXrClEHn4tK01LeMV5ybW4+/iwMSuWefzPl5pKlvDhcU3fc7wPkrco1gcnO05
         Q5Fe7fphaQpSPyCJDGQmJmVTOu0afbqttcAUJJ/Sz0oDVQmJ/ztfwc0Z5yt/tnZYQaRc
         BLc3cCqjRRr9T3NSUMjQ+LX937PtmfdBn0q+Kb00ZLpAgIdREZ5xAeB0Wk31dU6IzEfx
         l0K9tK/nAibISc5L58avNYVzbzFxeyXdtOBxREn8G3DoRvzxU4eAQA4ktzmjx6RxqUB/
         sRFn4if1JVD4gkE7UGJ5XIep4ECqjYNjrokXqe8wn1EC11hfQxIF6O1+TDkpVYxdeBY3
         6SWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781472920; x=1782077720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1MW0ZjG8vB1FPedvEzSZlBi25skp+ZtX2ykLQQ0uGHk=;
        b=fGaljMEZ4cCv4GVVKladbRzERqTVyvsgREoBWAgqXAwsGZiKIbHoUMXUCyhvbEVuhf
         YvLrSubpduTdJ/eN+qKwaXzgdo1C02JbQwzgbCfeSOjaU7S6lCDftov166TjrsqZIPe7
         FJM3Duy+B/nuhKuE8yVq0uSrQFDX2DLUNOEqcEQLWSoPsrUkvSsX3Px64EWxjRxD2g5H
         4/Loop7tcYXblwV13WW0HXc6MgJiZRd0Jt5IewAox8QhrJspQDLzE41HpTBsYUJt+h7n
         06MA4YAcp+gA33DiJsmgtHIiYa7DnHkOw9l4wSSr5dSL2LhjRpB1PDSziOv8VHtDJAlZ
         uHIQ==
X-Forwarded-Encrypted: i=1; AFNElJ/wXsaKDIsV3KucEjTBzG8iEOVP670jYA98U5HGuXNTCd84Xniy0N8DvB+vxGfHyE/gtzVhF649+tgZpw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxpD6O6lRySzkSrlHvmwd7mkyOV4R0i1yCEt5DHiLSjK3T/IWly
	tIhgITUfw/sJs2oO/Gw0RoSdbfnWtoA80GhlPjup8Nbmj2G6EpjJ9x4g
X-Gm-Gg: Acq92OHhUXZ8gKAB3azvs05EoCP4jgfo6xe1rPaJTJuUg74wGVf+3dUr19BaXqp/YWg
	G35C6Nf/upFx332JrRXGlYTVsx3EezYz4yJcG/99msNGkiiCfVl8ol0qvt5J28aDsJtapMQumV/
	oka6AJ82cjl8V4gu1hRMRMQjrMgG3B1ZDx4LJHxUhqJCp+j0nDp3HQhKHeSiE1cz+OrXs1Nh2ba
	D/yEOoHJ95ePuvOoyLrfq9V0OOXT2dgVWsoziPsSh0r0IGcrIbsEEHZIBE49xU8kO1GOmiZpPoQ
	g/YXPu0ufbcr7xUjpoYvr3lR+b1znTPx67HIGuaUB7zvrbsNNcFl8IoQ5/jh+EtlV4QLq36z453
	h5Hdge1kYmcvqxS8PvcUFYlfqlSvL0Yzd12kFQD8ZNUNgijf1WKcLUKVV/V5rbXs9QsOr9JdZ+2
	GkRDq8In2NkesBAAg+SOYSZRWJuyVEII+nthXZElpruj8tkhxCpcfZ+hv5ePNH8fuj
X-Received: by 2002:a05:7022:128c:b0:138:38c7:6adc with SMTP id a92af1059eb24-1384b2dfa97mr5512431c88.0.1781472919870;
        Sun, 14 Jun 2026 14:35:19 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:5d91:5c26:602d:6a99])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1384b96d6c4sm8662637c88.9.2026.06.14.14.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 14:35:19 -0700 (PDT)
Date: Sun, 14 Jun 2026 14:35:16 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: hexlabsecurity@proton.me
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	Joonyoung Shim <jy0922.shim@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>
Subject: Re: [PATCH] Input: mms114 - reject an oversized device packet size
Message-ID: <ai8eYpL5gK6Gwhn6@google.com>
References: <20260612-b4-disp-dc4b8dc4-v1-1-d7cb0a828d92@proton.me>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612-b4-disp-dc4b8dc4-v1-1-d7cb0a828d92@proton.me>

On Fri, Jun 12, 2026 at 11:21:14PM -0500, Bryam Vargas via B4 Relay wrote:
> From: Bryam Vargas <hexlabsecurity@proton.me>
> 
> mms114_interrupt() reads a packet of touch data from the device into a
> fixed-size on-stack buffer
> 
> 	struct mms114_touch touch[MMS114_MAX_TOUCH];
> 
> which holds MMS114_MAX_TOUCH (10) events of MMS114_EVENT_SIZE (8) bytes,
> i.e. 80 bytes. The length of the I2C read into it is taken verbatim from
> the device:
> 
> 	packet_size = mms114_read_reg(data, MMS114_PACKET_SIZE);
> 	if (packet_size <= 0)
> 		goto out;
> 	...
> 	error = __mms114_read_reg(data, MMS114_INFORMATION, packet_size,
> 			(u8 *)touch);
> 
> packet_size is a single device register byte (0x0F) and the only check
> is the lower bound packet_size <= 0; it is never bounded against the
> size of touch[]. A malfunctioning, malicious or counterfeit controller
> (or an attacker tampering with the I2C bus) can report a packet_size of
> up to 255, so __mms114_read_reg() writes up to 175 bytes past the end of
> touch[] on the IRQ-thread stack: a stack out-of-bounds write that can
> overwrite the stack canary, saved registers and the return address.
> 
> A well-formed device never reports more than the buffer holds, so reject
> an oversized packet and drop the report, consistent with the handler's
> other error paths, rather than reading past the buffer.
> 
> Fixes: 07b8481d4aff ("Input: add MELFAS mms114 touchscreen driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
> ---
>  drivers/input/touchscreen/mms114.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
> index af462086a65c..4c75f16c503d 100644
> --- a/drivers/input/touchscreen/mms114.c
> +++ b/drivers/input/touchscreen/mms114.c
> @@ -226,6 +226,13 @@ static irqreturn_t mms114_interrupt(int irq, void *dev_id)
>  	if (packet_size <= 0)
>  		goto out;
>  
> +	/* the device controls packet_size; reject anything too big for touch[] */
> +	if (packet_size > (int)sizeof(touch)) {

I gonna drop this cast (as thankfully we are not using -Wsign-compare)
and apply, thank you.

Thanks.

-- 
Dmitry
