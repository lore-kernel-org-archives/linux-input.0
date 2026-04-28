Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEA77404E;
	Tue, 28 Apr 2026 16:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777394147; cv=none; b=aZIOXxWxDWupRMWiwGdJXAKg+vaOn/ghzRYXTfvVKCDiKuwx6WETeSCdrfRJSbXXCnP0gz14daLS1uWIB+bDVKM/Um6pIY3rrH9fOJzWlLNhb4F85jou2/oE2i6XElHvdjQkI0KjcFah5ZvpiAo+HyD0KpXEynjm1vRuoxjBSFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777394147; c=relaxed/simple;
	bh=vKSVASRFLQ3MG2GalYx0pMDCH9UUEVKrfTQl0PyoDig=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=g3zy8bNZ+zNAQBF/iPnViAtO5lCP47x0kgZD/VTwaIsINPMYnwTaJOCdBkSCIw58iSexMaDFVk9EK801OE7laRa2oKHHB0BJBc6cd4m+B/Oa6YO+E7i21hHwo8HBy1vxH2WcghM/6I30WGOkc3Mlb7gKf+bX/0tYBgtiKMFxCHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdzan+iU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdzan+iU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA7E2C2BCB5;
	Tue, 28 Apr 2026 16:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777394147;
	bh=vKSVASRFLQ3MG2GalYx0pMDCH9UUEVKrfTQl0PyoDig=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=mdzan+iUewh9qkgEQHvxEozf+djhH4P52spqsx7cXI+Yf34X2Re5csuc8jKae/n2U
	 AlisnM/+RYxYZ7+7Kxws1ZN14xt7zDp6NPc0DfsIY07GWoW8elxkVD+3ILVvHJNQmj
	 kfpu3jwHDwDVBS+YF4OZDS63ie6/Ni+/vq9JsvR4yluTSjk0UAPlR8eFLaIM/i20qX
	 3hKkCyh4O2+QBuD0rmWbdjUt18GGvr2Q5OSxhOOfMLmu5JwsHaRM8iE/sgqauysIVd
	 E1xQjbv6x4irLMiBhxKIVkbJMOHXTg8w55e1h+PRf31FWzdP7IwxxjdW1Y9WbcomkK
	 5j9ih/02inHYA==
Date: Tue, 28 Apr 2026 18:35:44 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Dan Carpenter <error27@gmail.com>
cc: Even Xu <even.xu@intel.com>, Xinpeng Sun <xinpeng.sun@intel.com>, 
    Benjamin Tissoires <bentiss@kernel.org>, 
    Mark Pearson <mpearson-lenovo@squebb.ca>, 
    Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
    kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] HID: intel-thc-hid: Intel-quickspi: Fix some error
 codes
In-Reply-To: <aenFyk36rTnrD9s3@stanley.mountain>
Message-ID: <52rss264-650p-p6p8-9q47-4o41q8r15o76@xreary.bet>
References: <aenFyk36rTnrD9s3@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 23 Apr 2026, Dan Carpenter wrote:

> If we have a partial read that is supposed to be treated as failure but
> in this code we forgot to set the error code.  Return -EINVAL.
> 
> Fixes: 9d8d51735a3a ("HID: intel-thc-hid: intel-quickspi: Add HIDSPI protocol implementation")
> Signed-off-by: Dan Carpenter <error27@gmail.com>

Applied to hid.git#for-7.1/upstream-fixes, thanks Dan.

-- 
Jiri Kosina
SUSE Labs

