Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792673C8C44
	for <linux-input@vger.kernel.org>; Tue, 12 May 2026 16:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778601987; cv=none; b=Qu96g03GbgxUvO79LFMjUb+UW+77YeL0BEc86mRbsycIkaEPLw1Y1XA1XXoYbqVHK3M3QWe+2Gs0TgNr9lTi9srMf7OdfFW3WPEVfESEmqkk9nAbO0P38vwYTc5z9BTburxkEK2PqoVKMpSzZr3jZVyne4aDCG77awxsWMHR6SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778601987; c=relaxed/simple;
	bh=1Y5sJ9Eb6+iSmbCF8iTMfMRhMeYvwvjtBBon+q7JLE8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WcYCpJ1WMV+qatWIE3KSXn01n0T3eAt0VI7e4YJ8csyXuFuGLqFZ8lh1j0y4FG/D/pR60ppI1mGpROzwsAKnBVXcViaDr7ZMx6iXp31zGBAn5AwYodC1s8SVX+nUpGlC24LXFzEAHp2e2rojEYgDBFwGcAafVYPjA5NnZ9ltSAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLUen63t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLUen63t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B201DC2BCB0;
	Tue, 12 May 2026 16:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778601987;
	bh=1Y5sJ9Eb6+iSmbCF8iTMfMRhMeYvwvjtBBon+q7JLE8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=jLUen63txajJO3ZV1HY3Hd5Ua2XlgorBzV5slLHokoRAocfl5JstpbrGCpM0HnO5l
	 TS4gftFE5o5mGziYiJYOTX9iHSkUUT7yPDiUZ8MH1Ce1UQL78Z8QRuN3YRa15FgMaJ
	 lCsNYvlKwYmclJBWqrknrdhDT2WOhhpT8FN77DfNnQRX1o6ICmtBEQMm0Z9EywIjhA
	 wkJHVmoEcR28gXLx+fiJNEgL95mSOpOKMdx7rJV17nbfBqRvAiEDEuwQOpNUN5bLUq
	 5AJfEsCjiw00DSAt73lmPryXpR1xS5XPGU+43Ssf7eSSlU/mEMubSU7tU32I6lA4Qm
	 Zb60z1HwW2dpg==
Date: Tue, 12 May 2026 18:06:24 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Helge Bahmann <hcb@chaoticmind.net>
cc: Nehal Bakulchandra Shah <Nehal-Bakulchandra.Shah@amd.com>, 
    Sandeep Singh <Sandeep.singh@amd.com>, 
    Basavaraj Natikar <Basavaraj.Natikar@amd.com>, bentiss@kernel.org, 
    linux-hid@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH] amd-sfh-hid: tablet mode switch and asus quirk
In-Reply-To: <6879487.lOV4Wx5bFT@lothlorien>
Message-ID: <n0s5q66s-p747-612p-o743-pqr0q2r79448@xreary.bet>
References: <6879487.lOV4Wx5bFT@lothlorien>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 27 Apr 2026, Helge Bahmann wrote:

> Add an input driver that interprets the "operation mode" sensor offered
> by the amd sfh on some laptop models.
> 
> Add a quirk to make the driver work again with the Asus VivoBook
> VivoBook (turn off the "disable interrupts" flag).
> 
> Expose the intr_disable flag as a module parameter in case it turns out
> to be needed on further laptop models.
> 
> Signed-off-by: Helge Bahmann <hcb@chaoticmind.net>

Basavaraj, can you please review this one?

Thanks,

-- 
Jiri Kosina
SUSE Labs

