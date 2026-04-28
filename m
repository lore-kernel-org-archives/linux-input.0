Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036E7327C13;
	Tue, 28 Apr 2026 16:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777394091; cv=none; b=a4thJ5YvYhNEwVZTBm/xvIcBNhBvBpwoEoHsyHEgRbfuZXrCGJaAixTBMMT1WrDHdFzR4Zg2KWAxi8vzTh5ECj+83OeDJNG/L8ZvuwbSDk3Qs9xOujMAUfjgmMkQhzI2k4yrth9+sHg5MvDZ8iwnBUaU047vpf92yBOlCumOWK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777394091; c=relaxed/simple;
	bh=aTlDh0YB3vv8cn6y68mU+mMiwS7obCHQHGbfc7BKUT4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Husg0/2r3AX0tkqO6rEVuXyG3j8QyiN6nHAmJFqh+c5tC+YvmrvZNBlllYi+ar6KPPkdKu/25txJOL/hz5sTmcWPo7qRvpcdfhHkelCPNwoA/ebJopUxjMGMpcvnXysdssaSafqZBaRNzwtkN4OwCQ+3Ux1K5KnczORgGp9wSqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=It3yY0Or; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="It3yY0Or"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5444AC2BCAF;
	Tue, 28 Apr 2026 16:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777394090;
	bh=aTlDh0YB3vv8cn6y68mU+mMiwS7obCHQHGbfc7BKUT4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=It3yY0Or2USUdV2g57kFdqZJrY46PO36PiFj2Fb7PCHP22Fvf/j4Vw9fGNRTmKKGC
	 vO5J9FtbFoKh1uR7eNTbZJ1gToTDcmGDwJv6LceQp/R5eRQkCGMqzFjBtFkKs4JvkE
	 hJuH9HPtf2X16n4H3VE8ziwL9m4jFB+7PQ2KGzpBzu5fp0h4TjrdMoby7wrpMNcfAj
	 4LUKFkJfxBE8VxlGtGPru64S0HQA22lWbUuXulGGw6OFqMKY0cOfTZNYgDiKbiJwqQ
	 eMS/f/+WgADue/9vuRWU9oon9vCMQsqp/0ZFXE9M9Mtv+x/O+Ct0kX2gGCQzFYEG8V
	 wf2JUZc+JL4eA==
Date: Tue, 28 Apr 2026 18:34:48 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Matthew Schwartz <matthew.schwartz@linux.dev>
cc: derekjohn.clark@gmail.com, bentiss@kernel.org, mpearson-lenovo@squebb.ca, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: hid-lenovo-go-s: restore OS_TYPE after resume from
 s2idle
In-Reply-To: <20260420181522.521627-1-matthew.schwartz@linux.dev>
Message-ID: <1q6937r9-s694-qpq5-p412-761n62629181@xreary.bet>
References: <20260420181522.521627-1-matthew.schwartz@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 20 Apr 2026, Matthew Schwartz wrote:

> The controller MCU does not persist OS_TYPE across power cycles. During
> s2idle resume, the USB device may be power-cycled, causing the OS_TYPE
> setting to revert to the default Windows value.
> 
> Add a reset_resume callback so that this is correctly restored after
> resume.
> 
> Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
> Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>

Applied, thanks. Next time, please don't forget to add Fixes: tag as well.

-- 
Jiri Kosina
SUSE Labs

