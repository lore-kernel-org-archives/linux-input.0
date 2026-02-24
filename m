Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9CF3806B8;
	Tue, 24 Feb 2026 16:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771949560; cv=none; b=m841RuiKYULhHPc6E+7SgPlDdb6NM01jiN08h/QghpbPgGXpkiSgGVIG2ND+QvDCZ3DdIU9llMcMfTR3XueHpziH5Ztd8Y6ds/7VaTjqlHc4Dp3Doh18JyJLgLGs16YabO9UY2pdL4jnFqznTiw9tanl5oGzt+PDfnhq2DN6X0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771949560; c=relaxed/simple;
	bh=5E0qT8mDGaw2I+EpER6p5r5QiqwYmfMaK2tnZ5m34mk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=iV7mnNNmK1Jgvx29LElBIdV4ho5AFhJK+hWIAC/IMyWVz4mAiG95MnQgGJ1IUzxro2C/9NjZTHv2XSGqsWpreH0L6u5OytiVhV+HIT3KHE9ZR8JJb3aI2QZJYVTZxRLCW/MP6kWHTIOnLcJlDrO9qshWQm1q97wqu5qeaF6RXOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmxnEmZp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmxnEmZp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E63E2C116D0;
	Tue, 24 Feb 2026 16:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771949560;
	bh=5E0qT8mDGaw2I+EpER6p5r5QiqwYmfMaK2tnZ5m34mk=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=NmxnEmZpsr7UbZ6DjMLih5uSxezCzyRPBQW+nZgj85AGoG1/KuYj59d1esgvsO2gn
	 1ayFQKWXt1YpJGILrmQP7F2Tg8evgiiyYl0h/JYA7L+bG6EPJP0xaNkMBvnUzwEd1w
	 xzWI7ffsnn5ZfwiFPtEWwkF0aLEcZx6J/7Ng+WNLiUFLDkQjH+srDnD2/xfLB3HntU
	 Sa4vwkK+C7+n8y6lcVNAADF+QdGBxZrzdUuGq+U68HoaGSAy2OEoqXPTh14ZmWXoQf
	 6Xj01ez9Wu16vqT9xjALHhCpgcdDjGIxWTigYVErTfQdUMXhr8GQ+Ncwp6POXIXosW
	 Ywvn3pMsS8LrA==
Date: Tue, 24 Feb 2026 17:12:37 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Benjamin Tissoires <bentiss@kernel.org>
cc: Lee Jones <lee@kernel.org>, David Rheinsberg <david@readahead.eu>, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
    stable@vger.kernel.org
Subject: Re: [PATCH 1/1] HID: uhid: Fix out-of-bounds write caused by raw
 events mismanagement
In-Reply-To: <aZ3IKiL91Ya7_iIM@plouf>
Message-ID: <r6574n79-563r-9rrp-0n92-784532r67o63@xreary.bet>
References: <20260211164025.171242-1-lee@kernel.org> <aZmsTQeeGf26FqvY@plouf> <172q4775-616s-p7s4-7n80-p8579n0r3516@xreary.bet> <47ro00po-r74n-870q-q178-67s8rpsss12q@xreary.bet> <aZ3IKiL91Ya7_iIM@plouf>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 24 Feb 2026, Benjamin Tissoires wrote:

> Long story short: that patch is too intrusive as it makes assumption on
> the behavior of the device. We need to understand where/if the bug was
> spotted and fix the caller of hid_hw_raw_request, not the uhid
> implementation.

Thanks a lot for the analysis, Benjamin!

I asked about that here:

	https://lore.kernel.org/all/172q4775-616s-p7s4-7n80-p8579n0r3516@xreary.bet/

So let's wait for Lee to clarify. Until that, the patch stays out of the 
branch.

Thanks,

-- 
Jiri Kosina
SUSE Labs

