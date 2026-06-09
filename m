Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63DB34F483
	for <linux-input@vger.kernel.org>; Tue,  9 Jun 2026 05:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780982302; cv=none; b=fu86M/mG1Hkige9k2WQRJrDqznOdZrn9b4ka/ijC90i6JubgjZh45v7LSWXPOJhzubyEIE7ZgqV7SKGWKw+J4Ujg+swz/7TmTuQVc5s3B4YOYG/USJS7GauVMRc1FoBH9Ox2URn6wEH9FC+L2tTROrUmh++RQ645FdCz5q1V0l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780982302; c=relaxed/simple;
	bh=P/2RscSnXVqnZndBim1MWV2fq9HQD9RDlfjdtFT+tE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C0MhbAeKB05W1rJYadKNL+sb4l4KW5BhkumjRTnfZZRIu3JXRLGnGbLihFm+4E0rgwIb6zpRw9WDjQWnoeWPAxlchLsyRZWhHDCYePolyK0CYVNwDXMLU++43IbjBF8VnPwVVL08MVbaap66GFWhzySc+/vCuMTq68IrnXxbFBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WUaabuZv; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUaabuZv"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-304d8362a58so3065871eec.1
        for <linux-input@vger.kernel.org>; Mon, 08 Jun 2026 22:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780982300; x=1781587100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eXhEHeMj1OOZvAsVlTdhmcNYzaLIWY0sNp+g7ckAPzw=;
        b=WUaabuZvHYUbDoOzjzqVpjoGv9Pdj/p/ENYbcvbK/xOaRnhnFhzf5rq6wUIikBfARm
         gyHm+qg6M7NgmQtUScFNbSHGt2CT1V9gn9HAhFDCdtqo0VkMC/BWTL5nMDPWzHyth5ir
         2aqtrRtO14jEfsqAn98lucdDQPSXexLN1DDB9HMqBzDyhnZdlVjqS94WYBbxd1FQ0q8x
         0+4VdYKPkzoVn5BLFdEv2bsR8HnuvIwJnDiEqJnNxqVQ9puiN6bY8Y9CNQcUeI7mj23m
         u23ob3r/0xUnHTgns1OTQqiGvRluyr1nZ9mlTgt+N9LNbSC1bf3AOxUqGgqrKLf8F0zg
         j2Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780982300; x=1781587100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eXhEHeMj1OOZvAsVlTdhmcNYzaLIWY0sNp+g7ckAPzw=;
        b=rIvCHo7yLPojZwdO1qnpx0XT9j1c/FOFqIDr2FH2Cv3fCwpmdQE6KoBaj7WzVmMJkV
         4oSoBj5Pm3dbuS3UDUDP3GlycbgSN+C+LZ8sOUEN5Ly+ib7Aup6DyQWUV1HNMQ5pNXOd
         U05W9rc1QISfwH9bZDPdLXkQwCnKGvIugQebHkxI6+2Oep9AIFYnjErM+I2ygcBx8Z1H
         vR6iwjSqaC3JuCOsMu05uGaR2AfrmbZb6cQl1hyaes7A00CruKhWi9s1P7qrCZ40//+H
         1nysWTlZfEerF0obBXGhmIMjmOTHDuT8b6A/m+6lPUxW0h4IbsravfxEYPzWjwvwpCg1
         J+Aw==
X-Forwarded-Encrypted: i=1; AFNElJ9tYi/QR+yHyG8MpHiM5d8N3cOiW2ZlsF8wdRLWeIEv16DAijDPK1LriAHYOqAuEtTGEEJsxHfpqmKxqQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YySj9JiI2t2gEf/+cyyfvcBFjUKgnxmjfaVGQ1FE9WY1BsYvPCP
	ssrzW2A/lV7BIuWCDe4ZU2sfLLSkL6ye28rqWKVK9tIh0S0rU9WfJ6Kg
X-Gm-Gg: Acq92OH+nFlZb4WqK3JzB9ZvM9TFK75jfL2fULfwnLIP5TRhIWc5MSph0aQsqEE9RsN
	nSablaqMnU2d4vMKuRyGsfwqaT1DK3lOiJ9zIqSiFCe+lr7MPmTKrPZuKoOeQ8M9NqkKNHo9CwJ
	8E/O6281MEnHHpce92CpZ39ZHj3CGcVF2NewsI1uymkDLRtwQY6xCR1vSwA1e0PslAfaxeW4JfZ
	+C24QG8QVV4ORqv/w2scTpoqjlNiYloXCwHnf+Q6+DjHFSnDEsmTrF/6S0Wr6zWU7KQ00i5pyac
	eza6/D8vsrCE01EQuVez9KHOgY3zdJo8d3BORXVnHcsYAV0DUkVZdJQr49NzrWxYYw2wAojMj2Y
	TTGLzroXTnlMC+UCaYlB+1xMgyil79KIcc9Dydv+GrG5QqYRIyZyOoWT0ncIik3qCz48mKghyKz
	9qg9RbPgxTAeJRMBtH1aMZ57RXYVlD1YsTESFB6o52yu8EA5qR8lLoz1RNGeHoya6D/d8ssL+3W
	+U=
X-Received: by 2002:a05:693c:20d1:10b0:2ee:7b2e:8a3e with SMTP id 5a478bee46e88-3077fd76cc3mr4847201eec.1.1780982299950;
        Mon, 08 Jun 2026 22:18:19 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:355d:c69b:fe36:8969])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30791f9da69sm11936730eec.31.2026.06.08.22.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 22:18:19 -0700 (PDT)
Date: Mon, 8 Jun 2026 22:18:16 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Ranjan Kumar <kumarranja@chromium.org>
Cc: bleung@chromium.org, bentiss@kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Input: elan_i2c - prevent division by zero on invalid
 device parameters
Message-ID: <aiefjOflOlbUiWDa@google.com>
References: <20260515071052.7DDA0C2BCB0@smtp.kernel.org>
 <20260518062624.1147959-1-kumarranja@chromium.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518062624.1147959-1-kumarranja@chromium.org>

Hi Ranjan,

On Mon, May 18, 2026 at 06:26:24AM +0000, Ranjan Kumar wrote:
> The Elan I2C touchpad driver queries the device for its physical
> dimensions and trace counts to calculate the device resolution and width.
> However, if the device firmware or device tree provides invalid zero
> values for x_traces, y_traces, x_mm, or y_mm, it results in a fatal
> division-by-zero exception leading to a kernel panic during device probe.
> 
> Add sanity checks to ensure these physical parameters are non-zero
> before performing the division. If invalid trace values are detected,
> log a warning and fall back to ETP_FWIDTH_REDUCE to prevent arithmetic
> underflow during touch reporting.

I would define some defaults that are not necessarily the same as
ETP_FWIDTH_REDUCE. The arithmetic overflow should be handled separately,
as it may still happen if we read (or set up via device tree) some small
(but non-zero) values.

> For invalid physical dimensions, fall
> back to a safe default of 1.
> 
> This prevents the kernel panic while allowing the probe to complete
> successfully. Completing the probe ensures the sysfs nodes are created,
> keeping the firmware update path intact so a recovery firmware can be
> flashed to the device.
> 
> Fixes: 6696777c6506 ("Input: add driver for Elan I2C/SMbus touchpad")
> Fixes: e3a9a1290688 ("Input: elan_i2c - do not query the info if they are provided")
> Signed-off-by: Ranjan Kumar <kumarranja@chromium.org>
> ---
> Changes in v3:
>  - Changed trace fallback values from 1 to ETP_FWIDTH_REDUCE to prevent 
>    an unsigned integer underflow in elan_report_absolute(). 
>  Changes in v2:
>  - Changed error handling from aborting probe with -EINVAL to logging a
>    warning and falling back to default values.
> 
>  drivers/input/mouse/elan_i2c_core.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
> index fee1796da3d0..c64e1dd1e60b 100644
> --- a/drivers/input/mouse/elan_i2c_core.c
> +++ b/drivers/input/mouse/elan_i2c_core.c
> @@ -425,8 +425,17 @@ static int elan_query_device_parameters(struct elan_tp_data *data)
>  		if (error)
>  			return error;
>  	}
> -	data->width_x = data->max_x / x_traces;
> -	data->width_y = data->max_y / y_traces;
> +
> +	if (unlikely(x_traces == 0 || y_traces == 0)) {

I'd say "if (!x_traces || !y_traces) ...". This is not hot path so
annotating with unlikely does not buy us anything.

I wonder if we should be comparing with some threshold instead of 0.
Something above 90 I guess.

Thanks.

-- 
Dmitry
