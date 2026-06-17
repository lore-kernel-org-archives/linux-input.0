Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0A3381AF1;
	Wed, 17 Jun 2026 08:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781684902; cv=none; b=Twd62SEBG8rJztCNOB6Te4eFHwghK92OA4vAHIM1uV5wIV963rAMUSAZIrOAPBV0x4c1iRz+nwhOPTrg4cg8fMQRmdJanlrWK+S4BFY/ScX1LzQOS1eiJ+QWDDSX+zYghrHLjPaP6wcdY3wZTpOXLRLZ+dyZ1FWiq3BvB8Cl1uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781684902; c=relaxed/simple;
	bh=WqL7U+S2Iy4uX59QoAT3Vhwoou+EBlmkapsajA+3AYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4xqwiR4cbUhT2NMpYHosX9DF/QexiVeaEOgSjwfjyszATqdhhLI2xH106a2vm9w0Z24BZE311qSmEG/Ry7f9s5+/WDe3BVDHLqMHFso2OTUjqUcVX9ClreaqEKu/gf2gRKnxMUngipuHkQyQ98ohX4srFXRpwDAUFoOfmrxz1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5YAacGI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5YAacGI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22FBB1F000E9;
	Wed, 17 Jun 2026 08:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781684901;
	bh=aliNvZtAnIZtiREEorpctDPgcyLLhMKE6RdQ2zxEaUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=h5YAacGIuJ+WASJQJTtqLRaD4DKdWhqss/76klQ9WrKGLMn+aWGInNVNBFDkvY2KR
	 OM5SwYrugNLBbPmFYnLo+ebODUZezbZ34NGMCBqpq6HYv+dcFlr3vIXdy7VdvUT3wn
	 lv9QlXTUD0PAL5JRwIoP413GWiQ/L71/OjFEi1KZyb3CXbqfCRKGj/PgqPsW2mLtuc
	 T+NRbuBomTAUMDKG0LH99U8RxG2XCBNeNDqrsTqqGXrTXX7+IDDhBjESVCFeXroQen
	 Mv86GES8dGjzrY5UkUVHoX1yBIUXrUFgQGgC7vX2qAcctvU97P4iU5pz8CvdDx07rA
	 Ghm3L/UHGydZQ==
Date: Wed, 17 Jun 2026 09:28:17 +0100
From: Lee Jones <lee@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Subject: Re: [PATCH v4 1/3] HID: wacom: Fix Use-After-Free in wacom_intuos_pad
Message-ID: <20260617082817.GC10056@google.com>
References: <20260616092658.1714548-1-lee@kernel.org>
 <20260616094526.D380A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616094526.D380A1F000E9@smtp.kernel.org>

On Tue, 16 Jun 2026, sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Use-After-Free in `wacom_mode_change_work()` due to unprotected lockless access of sibling device pointers.

Note that the issues found on this set are all pre-existing.

-- 
Lee Jones
