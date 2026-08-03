Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94106349CE2;
	Mon,  3 Aug 2026 17:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785778009; cv=none; b=kQPLwyW3l0pvq8pbLLKftDfZW0rrevUv9TjMCXLLYLM+8XJ/xVgdHsy//baYNn3D9Ty5g14B/CtZvRJsybu96bjDKPkElD6u+nJe8haHHOao1oY8ujL/dCL5h3K1LwsRJflaHk+lnkQApFtKpTp/lGu2994NRi0jtzL0E4QDu5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785778009; c=relaxed/simple;
	bh=mEwqpaQENJKZmMEdWh2XpO3uzYVwZsLRbxgpvVy8tvg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rf9Nf7+q67Ef0KOw8pG7UJLdhyfny9txtB9BGHBWgs5vhfVx4ubUBTWffYK2UPNNLBJ1Q7fJ3pxE0W5gdnYyjGQnahUiiMR50nDLRKZ96rLyEYp85JWbdiITBFqw+9dmlFThAgHukcBRHwFYoDRIDHg3uyTpHMHNdFuS+OxXkDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mnbSZIl+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mnbSZIl+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E6421F000E9;
	Mon,  3 Aug 2026 17:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785778007;
	bh=G9ryhG3xu0NW3UUua0rjppSvks2ce0Dpy4YxfJZpDLE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=mnbSZIl+H3IRyLAutSJfh47yVomM3jPds6BBA0bUfe0V/PMbRqikRKseISXFUp8+x
	 1vsUv03Xk8osdizlsYqVn9q31RBf0IYrx2KfU1bSt1SkcYr9Lfm8rUXgCbN4LR0BdT
	 BRkTDtorQo05E45z6bd5qOgw5lBuqd2lrk4as4EfYLc03GX1Q2wH9VaiG1WwpKmMjj
	 YjcrLvpxoQvtEDhyOuEoDwv7nt312fwpND/0VybdXvWo2O/aRQ5OIwzz1w9H3V3GpA
	 dYhicDL3fhMWJq0RsVtqf6gWdMVdALP86EO+/woOHIJW5Kuwz2TAsWKWVYaxuIagWg
	 S1Rx1/zrU79oA==
Date: Mon, 3 Aug 2026 19:26:45 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Haoxiang Li <haoxiang_li2024@163.com>
cc: lains@riseup.net, hadess@hadess.net, bentiss@kernel.org, e.velds@gmail.com, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: logitech-hidpp: Fix FF device cleanup on init
 failure
In-Reply-To: <20260623065200.1966629-1-haoxiang_li2024@163.com>
Message-ID: <o5on5186-ps86-1020-9p3n-0oqp3nq1poo6@xreary.bet>
References: <20260623065200.1966629-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 23 Jun 2026, Haoxiang Li wrote:

> hidpp_ff_init() creates the input force-feedback device with
> input_ff_create(), then allocates the HID++ FF private data,
> effect ID array, and workqueue.
> 
> If any of those allocations fail after input_ff_create() succeeds,
> the function returns an error without destroying the FF device.
> Add an unwind path that frees the private allocations made by
> hidpp_ff_init() and calls input_ff_destroy() for failures after
> input_ff_create() succeeds.
> 
> Fixes: ff21a635dd1a ("HID: logitech-hidpp: Force feedback support for the Logitech G920")
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

