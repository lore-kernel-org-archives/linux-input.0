Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954F22BAF7
	for <linux-input@vger.kernel.org>; Wed,  8 Apr 2026 04:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775624216; cv=none; b=Uh+baCexoUVRiiiSeBg+QKxKoFh1FiR3C00rbZcHUjJHWRtOlF7dL4zQaNWHbS0MDlsmSXnarkStKTCEgvRf865HzKGth2usRDGzi9qZrkhd/cBocLpHHVdzCouLTLiM3iX7if6m9zv3XZDFG1S/YC5j/dsFxJP5Yf/aeJZYswI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775624216; c=relaxed/simple;
	bh=XEkNsmWLejJaEAa2btyI+2+LS9nihG6p+YzF1yRW+TQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EXk04eNAn+sqp4+0TuJCGA6A1jxFfDpGctOMaZipRmB1Jakf6dEHzhU2TKJAQpnfs4cXTy+McOwYQ0voMCK6mK+EbMx/Qm3wsd9fOAJcCOwfclAowhJtRLAhiqyp6HRJT084OHN/VZcWWWSl5yi0SJL8r+3a/3UjY32v63+B+Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWotXj7H; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWotXj7H"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12c0b72dac7so3520760c88.0
        for <linux-input@vger.kernel.org>; Tue, 07 Apr 2026 21:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775624215; x=1776229015; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+jJXI3O21KfFgoB4qZzgO2BFty+d1rzq3Wn8c+oB3WA=;
        b=FWotXj7HuNUUpOTdkd/qKRj0CfbTZDwXp2EzSNlvFHEAS8da3TCLr/rJI15COOTn6t
         pzQXnvMYE09u2yaZkl//WhQmmY35cO8hJeL6xcGNcvnmQ18NK8RPsbm3kKiz38IM9b8k
         +VHaU5UbYmkSGYJvIN5mYRGxJ/YQM6nN5jdVMlwgO7Bq6kz/Kef7kXCsqeOiyQe8u06F
         5s4IMtPV5MFof4hA7i8GFd6jI3ZC6yEg/276WCQiQD6NYduAWT0ZT7zHi/++4x68v8U0
         uAPeYbL/PZTNhtHsB0KrBBQbId2b+oApnPb98aqFmHS3wganPrLUHYkf9rcJ4QbqWM90
         yh+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775624215; x=1776229015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+jJXI3O21KfFgoB4qZzgO2BFty+d1rzq3Wn8c+oB3WA=;
        b=OWTVtMPhnYlygKdJvEVomvt5dLJlWvmU65YcDEEI2rW1XNixREQU228dSn6ped0uhM
         hZPFDvXEsPDxcOaEZn0Caq8PO4eiLXbkAwQgb7AbzXJWMovsBM4Px741B1h6JyR0L5R/
         ER+dgn2AEdcjbLOCbuAa/9LP4G/fffUeFupuIL/tjCNgiBtvEDTJhPEtmCKYC9TbNCOR
         TQvM+4ZvgMAbDAsnnycPG1buW3IE6Mjv0PZeeRnZm5/YWU9tdtxtNnmNFMjsi0Nvgh3+
         iM6qNjhKRh14FIiY1nsmNj4VT+T0lo/d5RoOVoNE3RKYKt2HRMZD13JLMQ+GxWS0TDEG
         2NgA==
X-Gm-Message-State: AOJu0Yzn1XTUOgppswruyFOKf1jpM2zdX68u5NSuJWO43a0PESHDLf3C
	9S0sjwI4CxDO6wHKKHpBijBLZmZ0ON8DjcI8+rwKI/6ulkbZx/13Z98k
X-Gm-Gg: AeBDieuXbyyNmSMwdcbMw7VoBrs7/JacH42uDcHOkYxPKkZn9pWuAY0Mu/Z9TRo3P0W
	79yNEiSo6d2hFeD9b9E4Xn1EqHC9p6OH8sTEhxhaOSf4lM4x0vJLRqYsaOlOGbjrBPu1IJFAwcb
	6EFbHhVRBXvBO2farto5Bs5DurvsfAqP/Dd25ryNqS9O9nLw4hAH5c1gbizEG6zubDRcrxYPQiq
	QTk9X5ACTd3PMebaRgL0znFW4H4yRA5hNeMPthQuzQZx1x93yxwqizBCbP8H/czLMvSt70sgxfz
	EYtUMV4m4AVJXaCxS9Xuo+ATgZiTDlqoBb0dRvYxhHiWfHs/4fvgae6tgdnG/+9VeJFFwTpbYLo
	+lUDn32j4lXlvGkCJKtj1rfzLu380uZXZZEAlVnqiOea23BYXjCt3WYTx5s4cWZ5tDkeJy+uV0I
	YRkErllKKw2ybbxzLs6wnutMkZWWh3JzNvzSH3JmYTW3/AGdjVz9OHxkLMx1BfyjZXIBm6aFkfv
	Ss=
X-Received: by 2002:a05:7022:b9c:b0:119:e56c:18ab with SMTP id a92af1059eb24-12bfb760b8cmr8584264c88.19.1775624214588;
        Tue, 07 Apr 2026 21:56:54 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:4faa:4b67:d989:bce2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2cc0c6ec215sm17449902eec.4.2026.04.07.21.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 21:56:52 -0700 (PDT)
Date: Tue, 7 Apr 2026 21:56:49 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2] Input: uinput - fix circular locking dependency with
 ff-core
Message-ID: <adXgDI9yOU5L-7D-@google.com>
References: <20260407075031.38351-1-mikhail.v.gavrilov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407075031.38351-1-mikhail.v.gavrilov@gmail.com>

On Tue, Apr 07, 2026 at 12:50:31PM +0500, Mikhail Gavrilov wrote:
> A lockdep circular locking dependency warning can be triggered
> reproducibly when using a force-feedback gamepad with uinput (for
> example, playing ELDEN RING under Wine with a Flydigi Vader 5
> controller):
> 
>   ff->mutex -> udev->mutex -> input_mutex -> dev->mutex -> ff->mutex
> 
> The cycle is caused by four lock acquisition paths:
> 
> 1. ff upload: input_ff_upload() holds ff->mutex and calls
>    uinput_dev_upload_effect() -> uinput_request_submit() ->
>    uinput_request_send(), which acquires udev->mutex.
> 
> 2. device create: uinput_ioctl_handler() holds udev->mutex and calls
>    uinput_create_device() -> input_register_device(), which acquires
>    input_mutex.
> 
> 3. device register: input_register_device() holds input_mutex and
>    calls kbd_connect() -> input_register_handle(), which acquires
>    dev->mutex.
> 
> 4. evdev release: evdev_release() calls input_flush_device() under
>    dev->mutex, which calls input_ff_flush() acquiring ff->mutex.
> 
> Fix this by introducing a new state_lock spinlock to protect
> udev->state and udev->dev access in uinput_request_send() instead of
> acquiring udev->mutex.  The function only needs to atomically check
> device state and queue an input event into the ring buffer via
> uinput_dev_event() -- both operations are safe under a spinlock
> (ktime_get_ts64() and wake_up_interruptible() do not sleep).  This
> breaks the ff->mutex -> udev->mutex link since a spinlock is a leaf in
> the lock ordering and cannot form cycles with mutexes.
> 
> To keep state transitions visible to uinput_request_send(), protect
> writes to udev->state in uinput_create_device() and
> uinput_destroy_device() with the same state_lock spinlock.
> 
> Additionally, move init_completion(&request->done) from
> uinput_request_send() to uinput_request_submit() before
> uinput_request_reserve_slot().  Once the slot is allocated,
> uinput_flush_requests() may call complete() on it at any time from
> the destroy path, so the completion must be initialised before the
> request becomes visible.
> 
> Lock ordering after the fix:
> 
>   ff->mutex -> state_lock (spinlock, leaf)
>   udev->mutex -> state_lock (spinlock, leaf)
>   udev->mutex -> input_mutex -> dev->mutex -> ff->mutex (no back-edge)
> 
> Fixes: ff462551235d ("Input: uinput - switch to the new FF interface")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/all/CABXGCsMoxag+kEwHhb7KqhuyxfmGGd0P=tHZyb1uKE0pLr8Hkg@mail.gmail.com/
> Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

Applied, thank you.

-- 
Dmitry
