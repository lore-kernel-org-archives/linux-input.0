Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F046E3E0245
	for <linux-input@vger.kernel.org>; Thu, 21 May 2026 13:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779369454; cv=none; b=MPrMFLDuIPWAwn1Vncq9atc0ciG4VjwI3ol87kcan9Pp5n3CcLmESBy8blgtsdSHLgeBuygtOGShAM+sDRYVhAY5OpyE5TBk+RRl5li4IoXh7EcbcpMWNL8wIXHsZgMEySl65/Lo5fK8omZFuUUMccVBWz9ircXtGPcfEbCyX+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779369454; c=relaxed/simple;
	bh=Yp5BU1Qd1fn0gqqI9MjMuLG5Z5fp8Qb1HwOCTvkekpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OpfgNGH75yWZTAsKCNxc62WJQqC10lf+dq2x9l/JkVtKSFxEnuDTCY1FO3VRgcEHkI/iCXKmRQmwdIpfr2rMt3ygatE/Sp2oXGAyTfGSo1w+tkqH/R+U3bfrQXYwuJkhZahqs1eUBNTVfVMrT8jSwVCnR0S9ADGgPkNFvMS5Coo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EN9VvypH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EN9VvypH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7BE61F000E9;
	Thu, 21 May 2026 13:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779369452;
	bh=e6o8nebn9T/WQnDX7gaduz2Ag1SatwlpAc5Cvoza3AA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EN9VvypHNVyIH/qrg4FzXnzYdDQU4K5Ajl23l08YBW+MtzeAqT/1FNUPy+yPgQOX7
	 gId98wWerZF7x4kHa+xlBZJ5HHepvSGZvKQP9PyJNcOUDDZByXX3tZGhXDweI6IZnC
	 vYf7X05VMNvlJzkNor81h9VqG9woCHHdv6BSWQgNxSpQfbQEQ+Ke0nqqeds8+shvol
	 Xpd+IRu+rJPrCjk/lYSdnY28tjRZ0Qleir/7cOjer+/d2ToldYB7bTR47YXbI/95NJ
	 R975hFd28oMsosFUK+4oVZ0wYU24q6gd1BoR0P4QT59/7+OIPekavd9tsW+Y3DXTNz
	 n202MHxjUVg2g==
Date: Thu, 21 May 2026 15:17:29 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Dave Carey <carvsdriver@gmail.com>
Cc: linux-input@vger.kernel.org, jikos@kernel.org
Subject: Re: [PATCH] HID: multitouch: Fix stale MT slots when contact count
 drops to zero
Message-ID: <ag7FhOx4kuT9QpW3@beelink>
References: <20260515175253.873796-1-carvsdriver@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260515175253.873796-1-carvsdriver@gmail.com>

On May 15 2026, Dave Carey wrote:
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

I've just tested the change, and the testsuite seem to still be happy
and I can't find a flaw in the design.
However: (inlined comment)

> 
> Signed-off-by: Dave Carey <carvsdriver@gmail.com>
> Tested-by: Dave Carey <carvsdriver@gmail.com>
> ---
> This follows commit 108ac841 ("HID: multitouch: Fix Yoga Book 9 14IAH10
> touchscreen misclassification"), applied to hid/for-next on 2026-05-12.
> That commit established MT_CLS_YOGABOOK9I.
> 
> This fix is independent of the companion ghost-contacts patch ("HID:
> multitouch: Honor ContactCount for Yoga Book 9 to suppress ghost contacts",
> sent 2026-05-14), which adds MT_QUIRK_CONTACT_CNT_ACCURATE to the same
> class.  Both apply cleanly on top of 108ac841.
> 
> Tested on Lenovo Yoga Book 9 14IAH10 (83KJ).
> 
>  drivers/hid/hid-multitouch.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index ec04dba..e91ba89 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -1336,6 +1336,18 @@ static void mt_touch_report(struct hid_device *hid,
>  		/* A non 0 contact count always indicates a first packet */
>  		else if (contact_count)
>  			app->num_expected = contact_count;
> +		/*
> +		 * contact_count == 0 on the first packet of a new frame means
> +		 * all contacts have lifted (the firmware sends an explicit zero
> +		 * to signal all-up rather than simply omitting the frame).
> +		 * Reset num_expected so that the sync check below fires and
> +		 * INPUT_MT_DROP_UNUSED releases any stale slots.  This is safe
> +		 * for multi-packet continuation frames because those arrive with
> +		 * num_received > 0 (at least one contact was already processed
> +		 * from the preceding first-packet in the same frame).
> +		 */
> +		else if (app->num_received == 0)
> +			app->num_expected = 0;

this succession of if/else if makes the code harder to understand,
especially with long blocks of comments.

How about this instead (wouldn't mind a second pair of eyes):

        /*
         * Includes multi-packet support where subsequent
         * packets are sent with zero contactcount.
         */
        if (contact_count > 0)
                app->num_expected = contact_count;
        else if (!contact_count && app->num_received == 0 &&  app->prev_scantime != scantime) {
                /*
                 * New multi-report frame:
                 *
                 * For Win8 PTPs the first packet (td->num_received == 0) may
                 * have a contactcount of 0 if there only is a button event.
                 *
                 * Some other devices use a sentinel frame with 0 to release all contacts
                 */
                app->num_expected = 0;
        }

At least the test-suite is happy with this change.

Cheers,
Benjamin

>  	}
>  	app->prev_scantime = scantime;
>  
> -- 
> 2.54.0
> 
> 
