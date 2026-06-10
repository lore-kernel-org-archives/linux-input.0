Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B37B33F5A8
	for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 16:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781108941; cv=none; b=KKbn35HG3MjU0NCDQmXo0Y7qrv2wKx9ZyRRDrSbPGWAGOXnXI1nTZe9W2x0UKCd/v2LPIb2zXN9RNnGLc0zUUBbayCVS4BVdtOP90gfhPfGYBaGuus4aPpLw64nCY3AlLukfvQGU/l8fXQ8czmXvh18u/PVKoYWJUaWlisONKM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781108941; c=relaxed/simple;
	bh=xLBOwQFV0Ymec+ZHZMgGmIy6s50r7+BmaQrPhUs0WBU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Zpez+Wu61iQaEXEC4UjUgoCrjcToIkXZTD3R/leN7kptBN2wTiiohPoQgQRQZBTV3IcGgWZkl5Yk80ipxtKIn7FdGUDcdYcrJhmhzEDBlWgnQrXGxA93Q/zHTef7wI2bEWhtSvzwz4oZ46oGpvSgpKP8HfOVKwUdNYP+Vsen2aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nM3iJBOn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nM3iJBOn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02DCA1F00893;
	Wed, 10 Jun 2026 16:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781108939;
	bh=HLEqEhVuYpEh310Ob04r2tFMtA42yB6Pxp/31aaTcvg=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=nM3iJBOn8gPV/aBbC3HJQ/2cSkSFCo3je7fhYAmjdq1cK1cUUn93QrWxQ1rKfs9KM
	 4Yy5tizS5PEAVn3N1+UWin9lR2E6aQrLEJTsMj7g+q+ODyYC7W2GPZt65ksBB5vPJE
	 JnQ4pgwFmDe3/hs3DywSY2j3tgtynvSm2+/ag0D+GWTaJF9Vbxqe5mOMsguhrmXxf5
	 zA+nAp0vxJ3XukabRGFiAUzVcQV5fP3CbFvq4LuSNSZzPFDtKDmmNMyeM3DeBFPyip
	 7Q1KGe1O9D1+r26zq1PVodweK2ZEpC7WKrmCHHncIuTFs/LFzkZ0Y9VPsVHGirqtD3
	 fvFzGdvSh5JzQ==
Date: Wed, 10 Jun 2026 18:28:56 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Dave Carey <carvsdriver@gmail.com>
cc: linux-input@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
Subject: Re: [PATCH] HID: multitouch: Honor ContactCount for Yoga Book 9 to
 suppress ghost contacts
In-Reply-To: <CALPvRORBFHpbos=_xpBVchK-oSZF9EnY6n5-sAQGr=qiL13FbQ@mail.gmail.com>
Message-ID: <597974r9-49qs-28s9-p73s-p09p8s4q9rr8@xreary.bet>
References: <CALPvRORBFHpbos=_xpBVchK-oSZF9EnY6n5-sAQGr=qiL13FbQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 14 May 2026, Dave Carey wrote:

> The INGENIC 17EF:6161 firmware on the Lenovo Yoga Book 9 14IAH10
> does not clear stale contact slots when fingers are lifted.  Each
> HID report contains up to 10 finger slots, but only the first
> ContactCount slots represent valid contacts; the remaining slots
> retain TipSwitch=1 with positions from previous touches.
> 
> Raw HID capture confirms this: across a 60-second capture with
> repeated multi-finger gestures, 90% of frames had more TipSwitch=1
> slots than the reported ContactCount.  The ContactCount field itself
> is always accurate.
> 
> Add MT_QUIRK_CONTACT_CNT_ACCURATE to the MT_CLS_YOGABOOK9I class so
> the driver stops processing slots once ContactCount valid contacts
> have been consumed, discarding the stale ghost entries per HID
> specification section 17.  MT_QUIRK_NOT_SEEN_MEANS_UP (already in
> the class) ensures that any slot skipped by this guard is released
> via INPUT_MT_DROP_UNUSED at frame sync.
> 
> Signed-off-by: Dave Carey <carvsdriver@gmail.com>
> Tested-by: Dave Carey <carvsdriver@gmail.com>
> ---
> This follows commit 108ac841 ("HID: multitouch: Fix Yoga Book 9 14IAH10
> touchscreen misclassification"), applied to hid/for-next on 2026-05-12,
> which established MT_CLS_YOGABOOK9I and added MT_QUIRK_NOT_SEEN_MEANS_UP.
> 
> That fix made the touchscreens fully functional.  With three or more
> fingers and repeated on/off gestures, ghost contacts then began appearing
> because the firmware leaves stale TipSwitch=1 data in slots beyond
> ContactCount.  The capture showed patterns like cc=1 with 7 active slots,
> or cc=3 with 8 active slots, consistently across all gesture cycles.
> ContactCount was always the correct count.  Verified ghost-free after this
> change across 6+ repeated three-finger swipe sequences.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

