Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581996FC5;
	Mon, 16 Mar 2026 15:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674069; cv=none; b=t5WDPL8m4CjPlGbdWlrRBh1md8AxtZnoNKy9mcEfFA5XdOeE8irK3e/vt8aeNw3Opd4duItxSacyQIXsUa6O82Fg8j2W1DyvKNQEsYJj0EGmH1L8+qnX7WtGq03suU9xlgo7Px9mYSd6P93VdSI5NgidnZfZ0cfRACHM+jQgQ0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674069; c=relaxed/simple;
	bh=F3cAGNd9SB+0RBWZxCwdnNZtzcpDfFObfNmQ+6ybl2E=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0Q3XHfkYAVO5kjojteWLaBPl7zTOg9BJgq7OQbULivJpPSEXNRuGwmBgNwWU1Co4okJVl8TU+dUym3uLEHsEwgUTFYNlC9dWmcs10c7ZoxZEqCt4eaSeLoojBPb/UwVRfPttclJgecp+13ovL1mJdGSV4ul24122xDKkHKWbYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khYRuxX0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khYRuxX0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E97C2BC87;
	Mon, 16 Mar 2026 15:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773674069;
	bh=F3cAGNd9SB+0RBWZxCwdnNZtzcpDfFObfNmQ+6ybl2E=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=khYRuxX0bDLNDmT9b5GP/Xzd7UHoylUfyWSvpw5gdiKEyTdmz19LwEWOKcVHsLqRq
	 +FgaGl0TB9dtTsvPh+STfipYxuUeRQEHj16Vk5SGaX24azF3YpZM+Kere4w1DBri0Q
	 E4yHT5zxCk5VQ16iyFU/LI4HIrXdEi/zPc7woRDUwSX7ewC+dxEoiNCM0se8q1VL94
	 D4uKeyGm6jUGcom6n2mTSaXU7tH0F9S2zVnRaSCFa1b6gr9lX8azSMi66TziW1RFWs
	 D1TNP0Z6i+LCQAHegk/HusTYjjEdxvCbl57JpOKdr2Jmd27s6eLnvFEH6Ve3dAShTa
	 rd2rB+Y2LLrwQ==
Date: Mon, 16 Mar 2026 15:14:24 +0000
From: Lee Jones <lee@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v3 1/2] HID: core: Mitigate potential OOB by removing bogus
 memset()
Message-ID: <20260316151424.GC554736@google.com>
References: <20260309145942.1496072-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260309145942.1496072-1-lee@kernel.org>

On Mon, 09 Mar 2026, Lee Jones wrote:

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

Same here.  Are these still in your queue or would you like me to [RESEND]?

-- 
Lee Jones [李琼斯]
