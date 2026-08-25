Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A611038F938
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 09:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787650351; cv=none; b=mF7GDXs8u8iJGqXhj3MNTOlyCRk8t3v6GB19/0f32bHvso3B4fXKGk7ZYXEchz9wfOfh1ipjpCMHyGM9XqkAV+M4ui7573rVCpotGd1qQ/pmb8PQPyClCJtkH/W7TuFQ1DiE+n5QmWoAaZUw7HXd2jTAR0OgBOcFPnIe4JP/CGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787650351; c=relaxed/simple;
	bh=KFIcdrvthWtSeTMYGVGWgkoXe9+HI2rPO/bELZDuY7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aMWUlsylwHHh7o9qxGAJ70GodYYhhSk8e+qgZpPJ8KcApvc7lBMyWNDMD1ALDQdUjaMWEYR13Yx6z1BDj8idonY17PBWORluXFq1nVTGvaKr+FZF2Np4Kmtqslo0KqI9O7DeAd38FpqjICgQW4KacreD2jOIeAvJrUhtrPNUXo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mE0woZzE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mE0woZzE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B641F000E9;
	Tue, 25 Aug 2026 09:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787650350;
	bh=h2ikIk6Y3dBWbOOsijpiLEaVxgdUdPupDumzg4UYu50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mE0woZzEaNpmUrk7718nCzInzPoBynPNA5dMgCp8IGzfIYLxLAKyU4j1t8GXhj8pm
	 fAJsA3L4ZgEveiMdCe42nqC2fO7kcpn/ib2AI+S2bhuMFSuQsODCIc5GXdgH5Iv1CE
	 3/ceuF9zsjqFPt0A9cQ4+UKG1IFrHmmEN+BrWeSd+XYjTUxNAcRgF6GvQqIDS0qHBi
	 o8Y+9Hh4KyTHWQjyqxRU7sFzMg5pkDCyVzlpKxOVtVJ3J3YYWCXTvdBskEM0VAmYVw
	 WFmRQUH1+vZH1fhkPefyDbTzvdvj5GDPJe9SdXf0BD0TnztjIgeJWBJSN0MG+ldLG0
	 wCsbBCzy46aZQ==
Date: Tue, 25 Aug 2026 11:32:27 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Dave Carey <carvsdriver@gmail.com>
Cc: linux-input@vger.kernel.org, jikos@kernel.org
Subject: Re: [PATCH v3] HID: multitouch: Fix stale MT slots when contact
 count drops to zero
Message-ID: <ao1eFuXAdIehpWUM@beelink>
References: <20260730124336.637339-1-carvsdriver@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260730124336.637339-1-carvsdriver@gmail.com>

Hi Dave,

On Jul 30 2026, Dave Carey wrote:
> The INGENIC 17EF:6161 touchscreen (Lenovo Yoga Book 9 14IAH10) reports
> HID_DG_CONTACTCOUNT=0 in the frame immediately following the last finger
> lift rather than omitting the frame entirely.  In mt_touch_report() the
> existing code only updates num_expected when contact_count is non-zero,
> so a zero contact count on the first packet of a new frame leaves
> num_expected at its previous value (e.g. 2 for a two-finger gesture).
> The sync check "num_received >= num_expected" then evaluates "0 >= 2"
> and never fires, preventing INPUT_MT_DROP_UNUSED from releasing the
> stale slots.  Those slots remain active in the kernel MT layer until the
> next touch, at which point they are released in a batch alongside the
> new contact — causing the userspace event consumer to miss the intervening
> finger-up sequence and corrupt its gesture session state.
> 
> Fix by resetting num_expected to 0 when contact_count is zero and
> num_received is still 0 (i.e., this is the first and only packet of the
> frame, not a continuation packet in a multi-packet sequence).  With
> num_expected=0 the sync check "0 >= 0" fires immediately, calling
> input_mt_sync_frame() which drops the stale slots via INPUT_MT_DROP_UNUSED.
> 
> The num_received==0 guard is critical: continuation packets in a
> multi-packet frame arrive after at least one contact has already been
> processed (num_received>0), so they are correctly excluded from this
> path and the existing multi-packet logic is unaffected.
> 
> Signed-off-by: Dave Carey <carvsdriver@gmail.com>
> Tested-by: Dave Carey <carvsdriver@gmail.com>
> ---
> v3:
> - Resend as standalone patch; v2 was sent with incorrect subject "2/5"
>   (as a ping reply to the original series) so it was not recognized as
>   a versioned respin by the maintainers.  No code changes from v2.
> 
> v2:
> - Restructured contact_count block per Benjamin Tissoires' v1 review:
>   replace three-branch if/else-if/else-if with a cleaner two-branch
>   form, dropping the outer if (contact_count >= 0) wrapper.
> - Add prev_scantime != scantime guard to the zero-contact sentinel case.
> 
>  drivers/hid/hid-multitouch.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index ec04dbafbd99..56a3f29d4938 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -1321,21 +1321,18 @@ static void mt_touch_report(struct hid_device *hid,
>  	 * Includes multi-packet support where subsequent
>  	 * packets are sent with zero contactcount.
>  	 */
> -	if (contact_count >= 0) {
> +	if (contact_count > 0)
> +		app->num_expected = contact_count;
> +	else if (app->num_received == 0 && app->prev_scantime != scantime) {

Sorry, I couldn't get back to you with this. I had second thoughts on
this patch, and ended up asking claude whether we were having any
potential issues. Turns out that we are fine according to all code path
it could find to one tiny exception: if there is no HID_DG_CONTACTCOUNT
in the report, contact_count is initialized to -1 but will not get a
positive or null value. So semantically, the code is misleading, but
it's harmless because num_expected would still stay at the value 0.

On the other hand, if the device reports a signed contact count and a
negative value, the code with your patch would fix the negative value to
be 0, so that's an improvement actually.

Cheers,
Benjamin

>  		/*
> +		 * New multi-report frame:
> +		 *
>  		 * For Win8 PTPs the first packet (td->num_received == 0) may
>  		 * have a contactcount of 0 if there only is a button event.
> -		 * We double check that this is not a continuation packet
> -		 * of a possible multi-packet frame be checking that the
> -		 * timestamp has changed.
> +		 *
> +		 * Some other devices use a sentinel frame with 0 to release all contacts
>  		 */
> -		if ((app->quirks & MT_QUIRK_WIN8_PTP_BUTTONS) &&
> -		    app->num_received == 0 &&
> -		    app->prev_scantime != scantime)
> -			app->num_expected = contact_count;
> -		/* A non 0 contact count always indicates a first packet */
> -		else if (contact_count)
> -			app->num_expected = contact_count;
> +		app->num_expected = 0;
>  	}
>  	app->prev_scantime = scantime;
>  
> -- 
> 2.55.0
> 
> 
