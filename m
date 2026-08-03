Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CB430E0F8
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 02:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785722922; cv=none; b=C+YHJDIGNoYLCNOP/iDyKWeeF/24xLrj+4RGHl840v0i1r6bEhWmpvOm9qjo8j8cYGMxkLt9/hSgdYEjbi0GVpXBeoh/s/omewmooRWUmTshvGxm2DwVgxt3kL8JhIBfM1RykOh2bYZxnDSVXmayvBvJL7CchK/7UGLUooZB/gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785722922; c=relaxed/simple;
	bh=AHJ3l8cp9/rS1XJ+TanSKKPtiX17734f95CEuX4Cmeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jDaMncbGxX7LiLkuSyTqTPKqsWqu9xV8jJF91x1UFAypp70q7skzEfgL+WQO2BMLZBAL+gdoKbFZWGMYHUbqMW2Tq+4IuSn+ak6Ist5QbKyjLBIWfbi7CssCKIM+RkLHMn2wRESR+eAYGu8ftCBGaJCRsa5/Fm8hLd+X3LYq2bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sR/O2O3O; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sR/O2O3O"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cbb8b54fcf8so2559919a12.0
        for <linux-input@vger.kernel.org>; Sun, 02 Aug 2026 19:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785722921; x=1786327721; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N4/bOpqWkvxOz9b8PfEg+piIEtGDMNuYW9DL+iKLTwE=;
        b=sR/O2O3OlGcPQNZEv1H4NJrxcAVJRrWhT/dmZsKMguqUV02VKdxEHdcCvE2cE6/6kF
         rpTXjZuMZ0Cl6LAOrVkPL/s9rom57FB0kEZqDB7gIJEktxaDGZ5nNuIlmgf6PqP65Gdi
         1MYFibEzyB+LJYXSbyqDlUirK2lwCHnGeR/YH0hzQiErNzYqFNQMfILpo8ZPtuutT9Ti
         iHafVwDqy1USVCZCVxaA9+DCZwE+V+4sRhQMYnDoNuiJUq8AF3gH5FXvr7EwE2zeKHU8
         NEE4ZocP9vTHzeiHKyIN4I1QexgNW5JKASWDfq88mBVexrdTK3kyJGoaOQipovvdPCzN
         lUpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785722921; x=1786327721;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N4/bOpqWkvxOz9b8PfEg+piIEtGDMNuYW9DL+iKLTwE=;
        b=ey7bNsNdvLC0irLsd9XeqgQTNYqztZpQFowY+VwD07T7ssbYahd8ufMSQkoPxHnjFy
         4aWRTk39fgrQkjSdzrMp+6VhaCDHaOjnTV9HC10MApgv7nrnu35kW7dHrMumGOqaa1Sv
         sYrgtWBDU8xYN977hLOVIS7s4LDcfS7beu4fmCqGdv5v0bDTQpDbxGdNXVZltnfcWOzU
         EYt0LRiFD1NxT6j1WR0tTIPbHTq0dLpSown2XnXdK1FV5qZDPwyp9ELDtJO1ml7XGUIY
         agmlpYpmry6Qm7W3SD7gzqw8LYDrAtZR5tGM4Z5CzKWfFU3HnXeZvGj/SDd5hA9aDfmF
         hPKw==
X-Gm-Message-State: AOJu0YzmbZpq7lMphhOKCkzsTwRFMC+GUehoL/ecwEHs+RGkCY2FzCWP
	OxYNRQKAqtdLRMrUSV46LP5B5TCtYma5Ih81+axLHhLerty04EVUt3nO
X-Gm-Gg: AR+sD10+RHZbEm2BKrsEsT3hLKPrVslVvWmyuMwADKf/+gLEQ4Ho3AiTIkTNZfhUnon
	B/vVSbOzm8tbAQV8ME+B1Go3wv6FYX9FwIUo+PwjJSCOmBBSa58KvpiaI3ViEApe1qVgihunjKB
	VxntXBfT84D44bgavQMlXegn5jTceXxj8OipPCsN2/j+4by88QlhiQ0zdkQyUZZM+VoWPEQpoBm
	zwWHSJahAU99niDvxwypXUMNLWU4NxbBkuUd+QQ2VGC+Swy9Kz5YfvxC+mw9D0R2CWb6Y+ZMTcB
	SqoTj7iAwLRy6+bFzvLMbozRy1K+tG+Z1Xe8FsEGuDvqbd5DdDWGATT/fS3prwuUoDtZ7J/yKAJ
	j6CY0ktS5IhkcWWi9GdwtPUGfPb2XGv8EzMvy9nYF8dB9ieCGbVmHoMT+odtFXW+afw48R4eWtC
	jX8ws7GiqjT+x2yxuvN2ENQwwlUDTIKbW1ec8tgNlhyy56SpP5/NjEwEf7WjQ8IoFh7SaiXiSLo
	dB0sKvvnMJPcYuOk9LlAGPnTJWwSw==
X-Received: by 2002:a05:6a21:4ed1:20b0:3c9:346f:c1fc with SMTP id adf61e73a8af0-3c9346fc2e6mr4947969637.61.1785722920771;
        Sun, 02 Aug 2026 19:08:40 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:4fff:876c:cdae:e53c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab14475asm24976908c88.5.2026.08.02.19.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 19:08:40 -0700 (PDT)
Date: Sun, 2 Aug 2026 19:08:37 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org
Subject: Re: [PATCH v2 2/4] Input: clear inhibited flag before re-opening
 device on uninhibit
Message-ID: <am_38bVYs932qXlh@google.com>
References: <20260803005210.1251102-1-dmitry.torokhov@gmail.com>
 <20260803005210.1251102-2-dmitry.torokhov@gmail.com>
 <20260803011832.A000D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803011832.A000D1F000E9@smtp.kernel.org>

On Mon, Aug 03, 2026 at 01:18:32AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] When `dev->open()` fails during uninhibiting, restoring `dev->inhibited = true` without holding `dev->event_lock` and without releasing active keys leaves events permanently stuck in userspace.
> --
> 
> --- Patch [2]: [PATCH v2 2/4] Input: clear inhibited flag before re-opening device on uninhibit ---
> commit f055731a6a02bc8698a040a5af7e51e9039340a7
> Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> Input: clear inhibited flag before re-opening device on uninhibit
> 
> This patch clears dev->inhibited before calling dev->open() when
> uninhibiting a device. It ensures initial events are delivered to handlers,
> and restores dev->inhibited if dev->open() fails.
> 
> > diff --git a/drivers/input/input.c b/drivers/input/input.c
> > --- a/drivers/input/input.c
> > +++ b/drivers/input/input.c
> > @@ -1813,24 +1813,26 @@ static int input_uninhibit_device(struct input_dev *dev)
> >  	if (!dev->inhibited)
> >  		return 0;
> >  
> > +	dev->inhibited = false;
> > +
> >  	if (dev->users) {
> >  		if (dev->open) {
> >  			error = dev->open(dev);
> > -			if (error)
> > +			if (error) {
> > +				dev->inhibited = true;
> 
> [Severity: Medium]
> When dev->open() fails and dev->inhibited is restored to true, is there a
> potential data race with concurrent input_handle_event() readers?
> 
> Since dev->inhibited was set to false earlier, the driver's open() method or
> interrupts could have emitted events before the failure. Does restoring
> dev->inhibited here without holding dev->event_lock and without synthesizing
> key releases via input_dev_release_keys() risk leaving events permanently
> stuck in userspace?

Userspace has to clean up its own state after a device disappears.

Thanks.

-- 
Dmitry
