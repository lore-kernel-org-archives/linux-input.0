Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403343E0C49;
	Fri, 10 Apr 2026 15:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775834629; cv=none; b=HTvU8sPs/iA6RojRr++pv+H2BGERvtqj/Vbnowv41uNxQgmz2TJXRdm2ZO3MdAXjv7WAySgGIs698mJkpvgc04SMlaE2HYenkavjKhiX6waS3dK4VFv2zzV1D4c0+vq+XT7JmLpbNjO7LhoisTk78UXfHw4TO8sPdhPsDnBVNxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775834629; c=relaxed/simple;
	bh=YzOCSYHu178KLseWG3qA3bP7hShe7pQ/4iull4GeOgU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=JF8im54lsM10LRxqhaIgy2Q/rEGoGzHXrQ8n3vgkOQO+tiwN3yUQWc6ytj3anbo/WSicprLfKbrR6+xRdHAS1vBoiEM41j4LEJ7NeaP20v13Epoe5bPQvwutptNsRc9g0/dN+niNkJtUkVCzsgoaC1Vewn2STkmKIN5aTMEGVl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PIsdPiN+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PIsdPiN+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C2BDC2BC87;
	Fri, 10 Apr 2026 15:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775834628;
	bh=YzOCSYHu178KLseWG3qA3bP7hShe7pQ/4iull4GeOgU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=PIsdPiN+myYVn93MLhzmtfAl7IaZSVfK2uVkazpzb8+wfBcfhofALs8Cpv9ZbN8rN
	 N340pA08Un5wgnFTnvgHrHl28Rx87O5Sl0/T2zIUO3dPnzK9WAG1S4Epg5kW3kL8tr
	 cAofb3Jm2ScFwQWmkj54Ar5tpMKq3ilXTQ9AT4WdFnItZ13zcviujmA+dWxGsMvIzB
	 jaQmeSbPJVYeKEn01g57vI6f1qDSzN4EOO9pz0hHXxH6fKLg/ijOyMX0P3+PNm3OSe
	 RoL4PTs+5X8Sra7+x41X/1l7Y3BZhk7dMOUoYFk8Yt5r7CkWH4fOSmfgt1d31oPjCZ
	 +3f8jnJeG2vfw==
Date: Fri, 10 Apr 2026 17:23:46 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Benjamin Tissoires <bentiss@kernel.org>
cc: =?ISO-8859-15?Q?Filipe_La=EDns?= <lains@riseup.net>, 
    Lee Jones <lee@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: logitech-dj: fix wrong detection of bad DJ_SHORT
 output report
In-Reply-To: <20260410-fix-logitech-dj-v1-1-5533381f8d1b@kernel.org>
Message-ID: <2qo95np2-n977-9r09-p016-880q98025q44@xreary.bet>
References: <20260410-fix-logitech-dj-v1-1-5533381f8d1b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 10 Apr 2026, Benjamin Tissoires wrote:

> commit b6a57912854e ("HID: logitech-dj: Prevent REPORT_ID_DJ_SHORT
> related user initiated OOB write") assumed that all HID devices attached
> to the logitech-dj driver was having an output report of DJ_SHORT.
> 
> However, on the receiver itself, we have 2 other HID device we attach
> here: the mouse emulation and the keyboard emulation. For those devices
> the value of rep is NULL and we are triggered a segfault here.
> 
> This is doubly required because logitech-dj also handles non DJ devices
> that might not have the DJ collection.
> 
> Fixes: b6a57912854e ("HID: logitech-dj: Prevent REPORT_ID_DJ_SHORT related user initiated OOB write")
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

Thanks a lot Benjamin, your CI be praised!

Applied.

-- 
Jiri Kosina
SUSE Labs

