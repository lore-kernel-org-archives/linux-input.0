Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CB841D121
	for <linux-input@vger.kernel.org>; Wed, 26 Aug 2026 12:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787747381; cv=none; b=vDWO1RI/dYVZITAeiP16X65WT/fLxABXgRVtd0AOt/l66tyvAqTLBngEEHgdzo6KO83/Shks9H+clr5vIQCvr35Xe1L5JdZHgTTG1F0NnuWlALMw1uA46xiFkcuOPQsEiIpwjA9CjFuv7wrVl/QEqdceaqa41OnTeT/i9IontOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787747381; c=relaxed/simple;
	bh=1YEPH6fyCfdk+VtHwEVBmZ2Q4SPTrHVnUjJjwSGahC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OvJtk52EogthBmtst5rVr8MdwcOaa/q6HIUCJAmlsCEcdi8KLQTAu/6Png3zKe4aP44eQx9XGGZVMaZW16yBaMg+UwTTQxqWPQinnjwS2sRAVrDvWqOjq2iirlfRNQhFKJ1C7/PnDahwmEoYCmXbz2QxhFqy8WAouKVSzUjheFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Blt2pFoH; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Blt2pFoH"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2caea3f742bso14985455ad.0
        for <linux-input@vger.kernel.org>; Wed, 26 Aug 2026 05:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787747379; x=1788352179; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hz1GwVL5UrSeb6anZfq9UpCexQvVXd/F42ozF8YHT78=;
        b=Blt2pFoHDApAkYfIUel2bi4FCBKEo1d16ZQmqutPf6p4cQ96qT9hrqiUylOVBGB8qs
         1vcOiIxbgVTp6BE6K/325GnPuJXbSbvLzETdByTcMLHTXO0SYDFxqmX1+dXq7HxJ0kMF
         Nbuo7U9KSgGS/C8yuVdoRmG3iIrheHLCGcZbyV7NsOXYEjTvBWdIM34a6u7RWWLiisue
         ld9239DYuxeNS5vVefFCiBndJd5hhaWHz9muNBDNNb8RWmpNX47UewAHzPAcEccIiXp5
         lx0s199FWjAcTZLzdff1sbRy6LWfYPCROfdBB095xlVx6nfmgZALU3/mnM78R1dtksgz
         uG/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787747379; x=1788352179;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Hz1GwVL5UrSeb6anZfq9UpCexQvVXd/F42ozF8YHT78=;
        b=WbF8+WVQrr6RMAyUP6+4NaUPM4Z021zJJhmkwB0maBg/IQ+kw3mpzSlO6ZsgfqBixR
         lRrz7ZutjqFRtcp1/zTh8/ZwO9hZ5svoOFfTASGkisnK9zmQIh23tc0QZATPB0yR7Y+F
         w6oM93tA0/eYPawu+tSyaf+3ZvfWXDvwUKyzr8Ezo4RhRxzbMCGap8/36D8gh/vu4OKi
         pgl/OsG3Lr3tY41iXJhinw3soDMubofkRfXAzvRmfk2XNyJSGKKtBC0RFyNCXLOTRgXY
         nQ8t0qAKpIUr9Xn55C5Mo0xsmnN6m98+bGLY0TMKLA20VW68o5P6z3v30zxCtOGF40qF
         wzhA==
X-Forwarded-Encrypted: i=1; AHgh+RpwW+1zEcmXdTG1AB47/r+D1YQnB2mfxXyCYrqzj3LMr2XQGW4nmp49HZ4A1elt9lff5E/bTwwhi2FXPw==@vger.kernel.org
X-Gm-Message-State: AFuF++nAwcUiWUDLSNc5oW+VghhE5RZak3wqnIfKi/f/QHbVDIa4GT1a
	3Ypk5/+egMfY13ecKKatMerIji0yY2znHGQN/h1bhJkLwbbDfGgO0MAsFW3jNlbo
X-Gm-Gg: AR+sD13lsgErqT3paYREibuAito2BJUJUKt+w58hVRW4Yj8g9qgSXQMDPtmczlcL9G7
	KLkKKcn2NuM25HAF7+3eSxs/8T5ITBlASC86e4UW1Sz+AeV9YtbbuKOmGdTDs00qxYBMUM0iuoo
	JqYKtp8E9mNy4ZlAuo+uTfCsR/+18awPupVd5Z8HOWL8qhpNw9Gn9ROTf3P5/FsG7S8l15IRblZ
	KEJn2545krLN7/nERrlT3BD9DAyEBeyYe4mR4DDkBre3UFkNtLnZag7MUseyt0pc5xNZJnrxfeH
	6V4iYlZNkvoPaSm12aGWqWYwPqqlyCaE1BORpz9X0UzuGdHD4zT9FgIgqYN77h89nWLbQ/rrN4g
	YyZmlgDNyxEw6a01MZZd0NqNChYFRQicDMaHX108Qtn4QWNX4cHeJP6lGvR8ogYMUcfCjpXQuBr
	oHqnGHmQJFqIZ1ecwgA2beudJOWu1VOBV52HQ2+UZxevXrF6rjpQEyspfryw2RPHBCdnr8YlHvP
	VQarPf5MhjMhXeolJqyPQqfLkea
X-Received: by 2002:a17:903:1b43:b0:2d1:1d3d:97b2 with SMTP id d9443c01a7336-2d707b4638emr127553445ad.11.1787747379127;
        Wed, 26 Aug 2026 05:29:39 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:5877:641:857b:1318])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d8861d3sm13158441eec.18.2026.08.26.05.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 05:29:38 -0700 (PDT)
Date: Wed, 26 Aug 2026 05:29:35 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin.sipraga@analog.com>
Cc: sashiko-reviews@lists.linux.dev, linux-input@vger.kernel.org
Subject: Re: [PATCH] Input: adp5588-keys - cache GPIO state before
 registering the gpiochip
Message-ID: <ao7bQHVDPObeaISA@google.com>
References: <20260818-adp5588-gpio-cache-v1-1-650a2674fc0d@analog.com>
 <20260818161119.E25A31F00A3A@smtp.kernel.org>
 <aoSFhKxPk-QPv2EQ@analog.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aoSFhKxPk-QPv2EQ@analog.com>

On Tue, Aug 18, 2026 at 06:27:21PM +0200, Alvin Šipraga wrote:
> Thanks for your review sashiko-bot,
> 
> On Tue, Aug 18, 2026 at 04:11:19PM +0000, sashiko-bot@kernel.org wrote:
> > [Severity: High]
> > This isn't a bug introduced by this patch, but this patch actively
> > exacerbates the consequences of a pre-existing issue with missing error
> > handling on I2C reads. 
> > 
> > If adp5588_read() fails due to a bus fault, it returns a negative error
> > code (e.g., -EIO). In adp5588_gpio_add(), these negative values are
> > silently truncated to 8-bit unsigned values and stored in the driver's
> > cached GPIO state (dat_out, dir, pull_dis). 
> > 
> > Because this patch moves this caching to occur before 
> > devm_gpiochip_add_data(), when a GPIO hog is subsequently applied, the
> > driver inadvertently clobbers the real hardware state by writing back this
> > error-corrupted cache. Can this actively undermine the patch's stated goal
> > of preserving bootloader GPIO configurations if an I2C read fails during
> > probe?
> 
> If the reads fail, I would not expect the driver to behave properly at
> all - neither before nor after this patch. It's true that this patch
> might trade some broken behavior for another type of broken behavior
> though. But only on systems where I2C reads are failing.
> 
> If the argument is that such a trade can be considered a regression, I
> would point out that the suggestion here - to add error checking and to
> fail probe on bus errors - would invariably cause probe failure on such
> systems with buggy I2C reads. That's also a regression.
> 
> > Additionally, this same missing error check causes severe issues elsewhere.
> > In adp5588_report_events(), the error is bitwise-ANDed with KEY_EV_MASK, 
> > resulting in an invalid, large key value. This yields a calculated code
> > index that exceeds the bounds of the kpad->keycode array, causing an
> > out-of-bounds heap read and leaking phantom key presses to userspace. 
> > 
> > Finally, in adp5588_gpio_get_value(), a negative error code evaluates to
> > true, incorrectly reporting the pin state as HIGH.
> > 
> > Would it be appropriate to add proper error checking to adp5588_read() or
> > its callers to prevent state corruption and out-of-bounds memory access
> > during I2C faults?
> 
> Sure the driver can be improved by adding error checking, but that would
> be a much larger change. I hope that is not an impediment to getting
> this particular issue fixed.

No, not at all. Especially something that was identified as a
pre-existing issue will not usually block the acceptance.

And please, take Sashiko's reviews with a grain of salt, not everything
that it identifies as an issue is actually correct finding.

Thanks.

-- 
Dmitry
