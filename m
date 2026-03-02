Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9FA3FD14D;
	Mon,  2 Mar 2026 14:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772461820; cv=none; b=YAnotq9IL8w0eESTAwoNOf/rRdq9JgoXf9BXmLBy0jq+RbSI+8/5dkJcCyJOhlUc8+vIGQH+3+6w+Hor0RxiM+obXBr/5S/w2Ed95MIbZP8T/aEhA7xOEXLpbWvcQ4rwu+FLbOrtucTwdfRCHjoeFIc1KNpx7TetRkyajuXPWuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772461820; c=relaxed/simple;
	bh=IVGtlB0Pd4oa2Diw37Dwj2AEzvjPcJcTWSuQtFH1Dc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SKkRZL1oeiUUWMTVSULxNi8GrYJPV4i3rxjFFUudEDdvvPTknzZED6gAo5ZoaHmahqXSEcsJ/272dhYrSzXL0oQ/en3yQ7m7hsJ6kQHAwo9sPWflHExoO6GwZrdr5Y/m8Aow1sPQtc3yU7vjKIgqhUA76IJ49rOqUYQxw1AIE1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwjceL43; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwjceL43"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3188DC19423;
	Mon,  2 Mar 2026 14:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772461820;
	bh=IVGtlB0Pd4oa2Diw37Dwj2AEzvjPcJcTWSuQtFH1Dc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dwjceL43/bT8WHgM6gUYGBaSomDOc0KK67ShaNGF6CBYgCQKpABR3WHxv/T+Cr22t
	 tIa5D1m/jKl1tOHq1qAGOJQrwVrdzhKFb50rFqQMmu5rmOcsXfPcOPVZFJBVnjy6y4
	 ZjRzBxdpYxB9anA0gtT7E440nYyvkfhu5XcEYY5UQ8eeb/txe2uCwzveRo4PjOKUGy
	 VIxaklAJtOmWHjYarUhnA08pzyGWAxjqJgbAXfEY9kW1RZpSdre0LnDZ8SV2Pt+GRX
	 mw28MJyd6KYemIC0SS2B3zpxymAG5ZeTqB+pkmfnBdUz56DLaSAt+nY4h5jAV0C0qi
	 xtltLSzdi885w==
Date: Mon, 2 Mar 2026 15:29:53 +0100
From: Benjamin Tissoires <bentiss@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] HID: core: Mitigate potential OOB by removing bogus
 memset()
Message-ID: <aaWYS3QhaCPLBfzH@beelink>
References: <20260227163031.1166560-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227163031.1166560-1-lee@kernel.org>

On Feb 27 2026, Lee Jones wrote:
> The memset() in hid_report_raw_event() has the good intention of
> clearing out bogus data by zeroing the area from the end of the incoming
> data string to the assumed end of the buffer.  However, as we have
> recently seen, the size of the report buffer isn't always correct which
> can culminate in OOB writes.
> 
> The current suggestion from one of the HID maintainers is to remove the
> attempt completely.  The subsequent handling should be able to simply
> use the data size provided to prevent any potential overruns.
> 
> Suggested-by Benjamin Tissoires <bentiss@kernel.org>
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  drivers/hid/hid-core.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index a5b3a8ca2fcb..1d51042e4b1f 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -2056,12 +2056,6 @@ int hid_report_raw_event(struct hid_device *hid, enum hid_report_type type, u8 *
>  	else if (rsize > max_buffer_size)
>  		rsize = max_buffer_size;
>  
> -	if (csize < rsize) {
> -		dbg_hid("report %d is too short, (%d < %d)\n", report->id,
> -				csize, rsize);
> -		memset(cdata + csize, 0, rsize - csize);
> -	}
> -

Simply removing this check is not enough.

later we have a call to `hid_process_report(hid, report, cdata,
interrupt);`` which loses the size information and which will make an
OOB read while calling hid_input_fetch_field().

I think we should drop here the processing with a warning (maybe rate
limnited), and hope for the best.

Cheers,
Benjamin

>  	if ((hid->claimed & HID_CLAIMED_HIDDEV) && hid->hiddev_report_event)
>  		hid->hiddev_report_event(hid, report);
>  	if (hid->claimed & HID_CLAIMED_HIDRAW) {
> -- 
> 2.53.0.473.g4a7958ca14-goog
> 
