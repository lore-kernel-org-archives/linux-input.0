Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982D032B126;
	Mon,  3 Aug 2026 19:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785784939; cv=none; b=fULuX/HPWCrqjTD6qGyNRyg8YH/BKj0+pBcqzFENGTW9isZu6KNBIPv2MOunYNa8guWOqQqhF7mQBywMXc4ryQ8qfMnM0N006pdRUyvlQDqOVm2YIZxmAbqTaBq9xH89PEWazFS7nygR2rTGvkxc61xzp3IzbPs4/N4B4Hr4xOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785784939; c=relaxed/simple;
	bh=dWb0ncj3nMnvg5J6WNPp4tJGf+QjV8EXVhTxPqzQu/M=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Fgj7HsgRpvHGIigXO3fsfiHNweFnk1sWKtxuDc8GUjGoaTF+jxLybCcAxTvrhB3KTdd1YwnnCyYQnNqAGhTvI7Gjq46StKeuvWjNdKZOQ52EYj32xHH/SH2ZOqV9OQhPr93gAk/PFPrGYTeqq5CvMtjXwlHkmiY/+wYWsNKWPL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jgc4SPGz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jgc4SPGz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B06111F000E9;
	Mon,  3 Aug 2026 19:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785784938;
	bh=+f2unVeefjbrcbRqncCTc2U10yBsvE5IQYJJpEStB84=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=Jgc4SPGzBtGXWRJ7PKe4yRChkqL85mB++1am/VmIkDFD670lByK+O0EG+QnHl6K/K
	 Cm+KgpbYFA4Dtb+6aY3k6P2ZbPoeNLzl4cSRkU5Sy2o3nXx6oil3sr0OYIOAIEAppf
	 0CdWxpbWU7jVAMWWYetQ7G2tGlbMBpWKPZ2v6T/QrM7ZQhfYH+PDdG1Ez1IB9032pw
	 96ubqyDDTCiHG57d9lWg6XGKtGtWzVG+Jmf9LKzDNmaDdyyKIQp759fFSSbBo/drI3
	 M/zpEvSKb145Y8g7iTXWhVNrxGDVn82CCjMCUl+b6y+kv/K50V+EuyScT/gWUaFkXU
	 HkdMUHfK/WLew==
Date: Mon, 3 Aug 2026 21:22:15 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Chen Changcheng <chenchangcheng@kylinos.cn>
cc: bentiss@kernel.org, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] HID: corsair: fix two use-after-free bugs on device
 removal
In-Reply-To: <20260727013500.23435-1-chenchangcheng@kylinos.cn>
Message-ID: <89nso48r-rosn-1q20-ssp4-4p43s09285s8@xreary.bet>
References: <20260724091906.240588-1-chenchangcheng@kylinos.cn> <20260727013500.23435-1-chenchangcheng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 27 Jul 2026, Chen Changcheng wrote:

> This series fixes two use-after-free bugs in the Corsair HID driver
> found during code review.  The previous single-patch submission only
> addressed the first issue; the second was identified by Sashiko AI
> review.
> 
> v2:
>   - Split into 2 patches: event vs remove UAF, worker vs cleanup UAF
>   - Rewrote commit messages in plain ASCII
>   - Added drvdata->k90 = NULL as defensive measure (patch 1)
>   - Fixed LED worker ordering in both cleanup functions (patch 2)
> 
> Chen Changcheng (2):
>   HID: corsair: fix use-after-free by reordering remove sequence
>   HID: corsair: cancel worker before unregistering LED to fix
>     use-after-free

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

