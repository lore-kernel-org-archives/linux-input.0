Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538D737F75B
	for <linux-input@vger.kernel.org>; Wed,  8 Apr 2026 22:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775687085; cv=none; b=TKkrmX5WThUDleIcjhsvUznk/g+pp+ZcFEx7psdQJLraxHU9ttrrJXe/1viJzKN1cSE5O68QhkO9v7rHE6SyV+ElbaxfApzSHNtLxfGrea2JIOAbaERwtSYuvNA1iNEV2+FwQ7M3VokcnZlBChWoi+rPdTJKTvGTIomQXleNjJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775687085; c=relaxed/simple;
	bh=VMPTIugCSXhWJKcfPc2gio22OBCtYUfAHwdXEaKBGQE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OMH7yob+Nz3kCGHAKtKQnEF6Lp7AKNncbO42LmCRnvB87YxCIXa7oxLmlanLcCZAEFj3CSAOppFT89mkMk0Pzqd7HcaAlyD7zfcCT0XrNoNfBAHFTpHldHKp7eICigAswEPajr3B+pODtubEdbjwYOlSyyk5BbPhXcR2u04aDxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qJExUfDw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qJExUfDw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45682C19421;
	Wed,  8 Apr 2026 22:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775687084;
	bh=VMPTIugCSXhWJKcfPc2gio22OBCtYUfAHwdXEaKBGQE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=qJExUfDw8T5stmJIzrL5Degq07w9yg131Zp0yc6xx4aZ59sMs0DRvrqD1DiU/+r29
	 gNLtaeZw+95D5GFpxHL4ywrDiUKSqGLzRG+hDQsV9mAoyGneStIgiHKT1uRlhGd8dl
	 H+U0Hu2s7iFzlyUx+z5XVnYVZLEKZhTplxP3qLOE49A2hsRO0B5USI2Vb0peKWAUdH
	 IYx8Sfcfi+I43ZxgpyyDixmrS/l7yYzRJ9kgeW2jQIh8r7k2Gz/E2iAmwcbYGLRzOx
	 WMbOnfz8XKmk0AH6Lvr+yP32futDffNFxrGLeGqHw66N6mQ5uU73sSm+39RACj4Nni
	 FsHhdg6tw46DA==
Date: Thu, 9 Apr 2026 00:24:42 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: deqrocks <andre@negmaster.com>
cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org
Subject: Re: [PATCH 0/3] HID: apple: reinitialize T2 HID devices after
 resume
In-Reply-To: <20260403130620.91999-1-andre@negmaster.com>
Message-ID: <3n79q9p1-9n3r-4o52-r04p-9405160671q6@xreary.bet>
References: <20260403130620.91999-1-andre@negmaster.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 3 Apr 2026, deqrocks wrote:

> This series improves suspend and resume handling for Apple T2 based Macs.
> 
> On affected systems, Apple T2 HID-backed devices can disappear across suspend and resume and come back with freshly enumerated interfaces. Reusing the pre-suspend device state leaves parts of the stack non-functional after resume, especially keyboard backlight and Touch Bar related devices.
> 
> This series adds the required Apple T2 HID identifiers, wires up PM handling for the relevant Apple HID path, and reworks teardown and reprobe handling so stale state is discarded and devices are initialized again after resume.
> 
> Tested on: MacBookAir9,1, MacBookPro15,1, MacBookPro16,1, MacBookPro16,2, MacBookPro16,4

Thanks a lot for the patches.

I know that the kernel documentation is now a little bit more liberal 
about not having to use real names, but "well established identities" 
being fine, but stil ... would you mind submitting this under some more 
comprehensible authorship? (anonymous submissions are still not allowed, 
BTW).

deqrocks doesn't really sound too well established identity to me, 
unfortunately ... if it is, I'd be happy to stay corrected.

Thanks a lot,

-- 
Jiri Kosina
SUSE Labs

