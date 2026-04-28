Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB9F7404E;
	Tue, 28 Apr 2026 16:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777394242; cv=none; b=by0B9ckcEXucUO7mQesLfr3VTHH3mt3EBqDmjt82pz4/ynlXNOQABMbkIcOz4DTsmz1Vb2vlYnhlv9+Sa0fg7qconX40J2+hg+dptPG8iLtkhBqHZ9Cj4Ln09F29LfiX1901zSKRKd/+eIYCzkAFAhhrEO/oytfRMU4gb+UHLVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777394242; c=relaxed/simple;
	bh=TwEvXSh3hfsu3Rpsd7UjBtFwXM97rVOzevxacCRq1ng=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=E9fWEH9uZqHCdD4odcQqFA0M3hmlurrlNhS9g3NbNoKSXmbMU2Mj4XjHSC3xSDL3quc29MgUo3rfeWTYSwDJ36dbpDYDqGR0ASnJGj3NTUCw4+4EJlaR0laK8UL1i7xVcvUz+JrqTUIQZWftXAy4JwC32RxF+FcHaYY/D+i59Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CukzD5Dh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CukzD5Dh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86476C2BCAF;
	Tue, 28 Apr 2026 16:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777394241;
	bh=TwEvXSh3hfsu3Rpsd7UjBtFwXM97rVOzevxacCRq1ng=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=CukzD5DhUi+sZDVhV5W9ezV2vURE4wjlOafRwRsUQiQNWNf0oOUmqhiKxai7k4CNS
	 U0D57Wi7N7jagPlpga5wQZLr0+FkZClLfXq39xNY+iL96RhaQhpu2fFJK3OSJengv0
	 gwNvycm2DUvpUs6gJqgCFoq/+YlI2AU5hbvhey4WqeaPRlAmkM2czl+XvZ/5ka9TVq
	 1T2Bb5fPMPpJKPvLRf/9QaM5LNqpQqgHxkdNzhYIxJi9UQeS6NV3jrKWgKVzDnGaic
	 BJrK8ALs5fGAfndaF3VEIgVAylEu7GryQCW/U2HIGqsZANBrq5VIv88oHFMNIlCiwC
	 HbWDX3/FD6mew==
Date: Tue, 28 Apr 2026 18:37:19 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    Henry Martin <bsdhenrymartin@gmail.com>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: uclogic: Fix regression of input name assignment
In-Reply-To: <20260428083321.126674-1-tiwai@suse.de>
Message-ID: <7934or16-7o09-5753-roo2-pn20571n64ss@xreary.bet>
References: <20260428083321.126674-1-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 28 Apr 2026, Takashi Iwai wrote:

> The previous fix for adding the devm_kasprintf() return check in the
> commit bd07f751208b ("HID: uclogic: Add NULL check in
> uclogic_input_configured()") changed the condition of hi->input->name
> assignment, and it resulted in missing the proper input device name
> when no custom suffix is defined.
> 
> Restore the conditional to the original content to address the
> regression.
> 
> Fixes: bd07f751208b ("HID: uclogic: Add NULL check in uclogic_input_configured()")
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Applied to hid.git#for-7.1/upstream-fixes, thanks Takashi.

-- 
Jiri Kosina
SUSE Labs

