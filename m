Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4223A5E6D;
	Mon, 16 Mar 2026 15:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674820; cv=none; b=pOsbBjB6SLoJbOKxE+HQURz/V2mTTHO8penAk4Fu7EiKZNm3XUG5diJSbOolNxZ+Pk5mDB+1iTiHTCZtE23zgk5239IXGnvxiCvQ/ZkRnkqm0z0jn6LBTz0/XWHcuwz/rp80zkz6YEMb+hDQicW0SKHjU0pR5xy0rP55YM46zHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674820; c=relaxed/simple;
	bh=ehXsqtJ7YasZufwAE2oxskuamvJPib4rbli9MVzfodQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uYrHLgrxgoChV9g/dh7dwso/kIR68Bpm4DbYxqk7K/1XpaMEUjFOv2EevfU80hLxlm7BaA4YEU6EFbehmqIuiMhPhdWvQXlEV9Gs+QpLpyY4RmC2FqM/scFfB/qjoxsTdpKDwKd/iQU+2WtGbDRFYB0zpSetdIco6D4LhimxeTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ck4DtVAJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ck4DtVAJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26965C19421;
	Mon, 16 Mar 2026 15:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773674820;
	bh=ehXsqtJ7YasZufwAE2oxskuamvJPib4rbli9MVzfodQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ck4DtVAJFEPH5xuvzcSVk1SBbswxAiWRs2+VPHvc1kQWuk+NIGgGIuUSJLBdu4LnT
	 HZVoeKYETOoAdSwURgBOyBp43lmfhZB04382Xg51SSdFHEeSEjAE9FwRH3oY+RjDeK
	 v0VkziuZTiWbGGxkKZvhLG4Km+vC2Tpsu1crt8L9JtPjHUQUCaLLuZJ5Wvho7MVUNN
	 eiE829p5CXdFQMhzo5Zpvxdo3SF5tmPvNSEE2X+OOzuKOB0ZhCUAdztGPlKGH19NP5
	 0r8e1KWuMEjWQW5TLWDkt500LFa+EkKNnK/08PSXfOFNo0BR/iiH+piD/+UQ/M2W3D
	 hpOdIcx9LM6Qw==
Date: Mon, 16 Mar 2026 16:26:14 +0100
From: Benjamin Tissoires <bentiss@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC v3 1/2] HID: core: Mitigate potential OOB by removing bogus
 memset()
Message-ID: <abggXH_EE-aJTgY6@beelink>
References: <20260309145942.1496072-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309145942.1496072-1-lee@kernel.org>

On Mar 09 2026, Lee Jones wrote:
> The memset() in hid_report_raw_event() has the good intention of
> clearing out bogus data by zeroing the area from the end of the incoming
> data string to the assumed end of the buffer.  However, as we have
> previously seen, doing so can easily result in OOB reads and writes in
> the subsequent thread of execution.
> 
> The current suggestion from one of the HID maintainers is to remove the
> memset() and simply return if the incoming event buffer size is not
> large enough to fill the associated report.
> 
> Suggested-by Benjamin Tissoires <bentiss@kernel.org>
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
> v2 -> v3: Instead of removing the check entirely, show a warning and return early
> 
> RFC query: Is it better to return SUCCESS or -EINVAL?

I'd say -EINVAL is better.

Also, one brain fart I had today was that this works in 99% of the cases
because the transport layer allocates a big enough buffer.

So that means that if this function, and hid_input_report() both have
the allocated size as parameter, we could make a smarter decision and
do the memset when we have enough space.

This would require an API change, and probably to keep things under
control adding a new API with the buffer_allocated_size that would be
used by uhid, usbhid, i2c-hid, and others when we can.

But let's go with the current state of the patch, and say sorry if we
break some devices later on. (patch is currently in my queue, no need to
resend it).

Cheers,
Benjamin

> 
>  drivers/hid/hid-core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index a5b3a8ca2fcb..da9231ca42bc 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -2057,9 +2057,9 @@ int hid_report_raw_event(struct hid_device *hid, enum hid_report_type type, u8 *
>  		rsize = max_buffer_size;
>  
>  	if (csize < rsize) {
> -		dbg_hid("report %d is too short, (%d < %d)\n", report->id,
> -				csize, rsize);
> -		memset(cdata + csize, 0, rsize - csize);
> +		hid_warn_ratelimited(hid, "Event data for report %d was too short (%d vs %d)\n",
> +				     report->id, rsize, csize);
> +		goto out;
>  	}
>  
>  	if ((hid->claimed & HID_CLAIMED_HIDDEV) && hid->hiddev_report_event)
> -- 
> 2.53.0.473.g4a7958ca14-goog
> 
> 
