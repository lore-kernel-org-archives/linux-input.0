Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939D021FF2A
	for <linux-input@vger.kernel.org>; Wed, 15 Apr 2026 08:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776241477; cv=none; b=PtSZTBxvsqsIVOXThGphTt36hjrFEKYF99EDhOK6TjtqK0k464FF6qVr9McpTeDJQYkvoxbtc3v8M5ydxbhFV1uB0ig57u+zZnvbMKQO0AmlqiWYSKXhGDyQF12/vLJB6Zj69QaQSZEs2eEAhvOqXXtmUQcMr/HVRcv7NYyKF3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776241477; c=relaxed/simple;
	bh=cTu4EC4uFqnvjWFlnKBhPv8AyIq5pAk+qm9FFhHaM8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3LXMkkR7ZcoqGo+dAint/EQfL5HCujYanPfbggzNgUiCXZaW6el+ust6ZUyf1PW40Z73Mqmdh1ph9+K3xwHkWjYyopEDMEtKbAbsTMklSGozfVj3zITJSHxTkHy2Ov9WxshevLX9lfHoFfc1mWbM27UjTbt25VDLHZD2fU/6/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqMxcuHE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqMxcuHE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4D94C19424;
	Wed, 15 Apr 2026 08:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776241477;
	bh=cTu4EC4uFqnvjWFlnKBhPv8AyIq5pAk+qm9FFhHaM8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aqMxcuHEsgs8ktRZZ9zJLn1HDJJ1cDdu4vhQBaq82qeC4LLt1VNEQYcMx8SD+ilA0
	 b2vdkS3BkFRiVp8tGnFNJvKnOgFkQ3obVpaCEsbyGyDloUoxrsgObcoZxNjHOVNhB5
	 BO4T25Mrdf1GMqwyYmLe/eDZA0glQO/NkkHBcfgnGqVxxBdAtrWgvAvv8Jnh7gRDtZ
	 wFOD70MO0XXamIBUrpJPUjXJsHswUDSBE/DfQ974fKC7zHdN87LQznpRlKp+4xADow
	 vsdBB6olyPdrDZUHMvFHoAV75mTxmSPmOsgrqVE0UmKPc5AhefWp68fHCI3Huk6D7h
	 xlR5YSXDWD9Ww==
Date: Wed, 15 Apr 2026 10:24:33 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: linux-input@vger.kernel.org, Anj Duvnjak <avian@extremenerds.net>, 
	benjamin.tissoires@redhat.com, lee@kernel.org, jikos@kernel.org
Subject: Re: [PATCH] HID: core: downgrade short report warning to debug level
Message-ID: <ad9LBakFHEHD-K9C@beelink>
References: <20260414214143.23796-1-avian@extremenerds.net>
 <5062517.GXAFRqVoOG@natalenko.name>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5062517.GXAFRqVoOG@natalenko.name>

On Apr 14 2026, Oleksandr Natalenko wrote:
> Hello.
> 
> Thank you for the submission. Please see comments inline.
> 
> On úterý 14. dubna 2026 23:41:43, středoevropský letní čas Anj Duvnjak wrote:
> > Commit 0a3fe972a7cb ("HID: core: Mitigate potential OOB by removing bogus
> > memset()") replaced the silent memset() with hid_warn_ratelimited(), which
> > causes dmesg flooding on devices that legitimately send short reports,
> > such as the APC UPS (051D:0002).
> > 
> > Downgrade to dbg_hid() to restore the previous behaviour of only
> > reporting under HID_DEBUG, while preserving the security fix of
> > removing the bogus memset().
> > 
> > Reported-by: Anj Duvnjak <avian@extremenerds.net>
> > Closes: https://lore.kernel.org/linux-input/MW5PR84MB135613E7947113897DD9FDA4C7272@MW5PR84MB1356.NAMPRD84.PROD.OUTLOOK.COM/
> > Reported-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> > Closes: https://lore.kernel.org/linux-input/6256259.lOV4Wx5bFT@natalenko.name/
> 
> I think these Closes: should be Link: instead. And probably Fixes: should be added as follows:
> 
> Fixes: 0a3fe972a7cb14 ("HID: core: Mitigate potential OOB by removing bogus memset()")
> 
> > Signed-off-by: Anj Duvnjak <avian@extremenerds.net>
> > ---
> >  drivers/hid/hid-core.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> > index 833df14ef68f..de8a179347ec 100644
> > --- a/drivers/hid/hid-core.c
> > +++ b/drivers/hid/hid-core.c
> > @@ -2057,8 +2057,8 @@ int hid_report_raw_event(struct hid_device *hid, enum hid_report_type type, u8 *
> >  		rsize = max_buffer_size;
> >  
> >  	if (csize < rsize) {
> > -		hid_warn_ratelimited(hid, "Event data for report %d was too short (%d vs %d)\n",
> > -				     report->id, rsize, csize);
> > +		dbg_hid("Event data for report %d was too short (%d vs %d)\n",
> > +			report->id, rsize, csize);
> 
> Ratelimiting is good to keep, IMO. There's a separate macro for that, hid_dbg_ratelimited(), which is surprisingly not used anywhere at the moment as far as I can grep, but it should do the job.

Thanks for the bug and the review.

However, I've got a proper fix which restores the original behavior
while still preventing the OOWM write. It should be out today or
tomorrow.

Cheers,
Benjamin

> 
> >  		ret = -EINVAL;
> >  		goto out;
> >  	}
> > 
> 
> 
> -- 
> Oleksandr Natalenko, MSE


