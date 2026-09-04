Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1EE33688F;
	Fri,  4 Sep 2026 13:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788527433; cv=none; b=rY8c2LD3UY+69OHO4lwyA1p1uv1WQwvLMfFdT9D1UPcXiu1s1M8bZtCSgxr6XBpHp78pWfOuXN7m/0lVltNz/AiD5kqxJnrqp3HMTcpmKXSvl0XaTRFA6BAnzOiT8h9xwerTyn+7YORvZBcHH4yiXhzSLOiaGiG2MxNal9eTr7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788527433; c=relaxed/simple;
	bh=nTlrgklH3mOCPm7MrDgW4DDeHFvc7uvuyCOMTWxTzcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TM5a4+yB7FwnLCUwn8QRgY4OgG6ry3+FTVS+8mjH2PlgZGcwi40eGrTAFCHH9aKjhQ2N+1SSGz5dyWR/vpXXQSirrPTzJZF3EUrYy+NsWt4oVLEZ1a/6QCZ1Qln/tCDIggo5EoMwOUZtO76T3EOehVPATqJSjThw6pP555wNjf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IHelGb+P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IHelGb+P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D8D1F00A3E;
	Fri,  4 Sep 2026 13:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788527429;
	bh=BQGLMLQqG3+zMRdgVBKK1hPMCfuJAweCf+DWNkXjcWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IHelGb+PESLuWcft276tpaqlLrn4YTYOEs5B4e6UgD/cKdFDbOGMYNhf70xSH5Qqt
	 Y0gBjRjj+T1d5t++D2UOmHuflB5cx5Vx9ylw1MLTMVrIx/hc0Ru1JgKcKpVRzWz71I
	 uiPwjLbgkSqQrRX0BvBHuT2LNBJrEZoEHYMfW8ATQ9mUX2SaYRKd8sbB8DEj6KJ8/5
	 IkYxSyMljDc47Q/ZX+/Gv24c5rFlVCBgyVcCfvFka9r2IicvyIDCQplvZfLMfFe4SE
	 UY+g5dac68A5NRmHFu7Sfh7bn8InAp1Pfio7rqpL6eS5DShJ5F6v9Kg4FJbYsvZSpc
	 qI9/ViXZoWA4g==
Date: Fri, 4 Sep 2026 15:10:25 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Subject: Re: [PATCH 2/3] HID: bpf: fix __hid_bpf_hw_check_params report length
Message-ID: <aprC2jF63o7xADjX@beelink>
References: <20260904-wip-bpf-check_report-v1-0-efe9a2a1ed28@kernel.org>
 <20260904-wip-bpf-check_report-v1-2-efe9a2a1ed28@kernel.org>
 <20260904130354.A79471F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260904130354.A79471F00A3D@smtp.kernel.org>

On Sep 04 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [Medium] The logic to reserve an extra byte for the report ID incorrectly checks `report_enum->numbered == 0` instead of `report->id == 0`, leading to buffer truncation for unnumbered reports on devices that also declare numbered reports.
> 
> Pre-existing issues:
> - [High] An integer sign mismatch in `hid_bpf_hw_request` causes negative error codes returned by the transport driver to be cast to `size_t` and evaluated as large positive values, incorrectly converting hardware errors into a 'success' return value.
> --
> 
> commit 2abe2f741986f5f3130a3dadda6bf82df9cbea21
> Author: Benjamin Tissoires <bentiss@kernel.org>
> 
> HID: bpf: fix __hid_bpf_hw_check_params report length
>     
> This patch modifies __hid_bpf_hw_check_params to reserve an extra byte for
> the report ID during hardware requests on unnumbered reports. This ensures
> transport drivers do not strip the first byte of the payload and reject the
> request due to insufficient buffer size.
> 
> > diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
> > index 536f6d01fd14c..b1de1dd0f21d0 100644
> > --- a/drivers/hid/bpf/hid_bpf_dispatch.c
> > +++ b/drivers/hid/bpf/hid_bpf_dispatch.c
> [ ... ]
> > @@ -388,6 +388,10 @@ __hid_bpf_hw_check_params(struct hid_bpf_ctx *ctx, __u8 *buf, size_t *buf__sz,
> >  
> >  	report_len = hid_report_len(report);
> >  
> > +	/* unnumbered reports need to have a report ID reserved in the first byte */
> > +	if (hw_request && report_enum->numbered == 0)
> > +		report_len += 1;
> > +
> 
> [Severity: Medium]
> Does this correctly handle devices that declare both unnumbered and numbered
> reports?
> 
> If a non-compliant HID device declares an unnumbered report where the report
> ID is 0, but also declares other numbered reports, report_enum->numbered
> will be set to 1.

Sashiko is wrong here. If a HID device declares a device with a report
ID of 0, the report will be tagged as numbered. The report *will* have
space for the report ID, and so there won't be any issues.

> 
> When a BPF program attempts a hardware request for the unnumbered report on
> such a device, the report_enum->numbered == 0 check will evaluate to false
> and skip the +1 padding. The BPF-provided buffer size is then clamped, but
> the transport driver will still strip the first byte before transmission,
> leading to buffer truncation.
> 
> Would it be safer to check if report->id == 0 instead?
> 
> >  	if (*buf__sz > report_len)
> >  		*buf__sz = report_len;
> >  
> [ ... ]
> > @@ -420,7 +424,7 @@ hid_bpf_hw_request(struct hid_bpf_ctx *ctx, __u8 *buf, size_t buf__sz,
> >  		return -EDEADLOCK;
> >  
> >  	/* check arguments */
> > -	ret = __hid_bpf_hw_check_params(ctx, buf, &size, rtype);
> > +	ret = __hid_bpf_hw_check_params(ctx, buf, &size, rtype, true);
> >  	if (ret)
> >  		return ret;
> >  
> 
> [Severity: High]
> This is a pre-existing issue, but I noticed a potential integer sign mismatch
> in hid_bpf_hw_request involving the size variable passed here.
> 
> In hid_bpf_hw_request, size is defined as a size_t, while ret is an int.
> Later in the function, after hid_hw_raw_request returns its status into ret,
> the code checks:
> 
>     if (ret > size)
>         ret = size;
>     if (ret > 0)
>         memcpy(buf, dma_data, ret);
> 
> If a transport driver encounters a hardware error and returns a negative
> error code such as -EPIPE, ret is implicitly promoted to size_t when compared
> against size. This causes the negative error code to evaluate as a large
> positive number, making the (ret > size) condition true.
> 
> This silently converts the hardware error into a success return value and
> copies the unmodified buffer back, which could leave BPF programs operating
> on uninitialized or stale data.
> 
> Can this be addressed by casting size to an ssize_t during the comparison, or
> by handling negative values in ret before the comparison?

Damn, this one seems correct.

Cheers,
Benjamin

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260904-wip-bpf-check_report-v1-0-efe9a2a1ed28@kernel.org?part=2
> 
