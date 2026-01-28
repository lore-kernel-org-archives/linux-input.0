Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F44430FC35;
	Wed, 28 Jan 2026 18:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769624224; cv=none; b=SpxTg1/pL97tYk9h/MQGNjZN0QRe69XvmufAiqzgUZlK+IYCykyt/prbBl6X53A9MbVsjcfpjMv68Ejd5U1wCJ4D0g4kdp3tcjtJ54p41N5isc8ucnvGNvBIgltsrCVlfEWvFvu7AAymkDBjz5dyuHSrKOOI3F0l1ZsRl1S5iq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769624224; c=relaxed/simple;
	bh=IhrC60d2eQG/L7IP2IRrVOv7oygW1nChVhQPLpqW3ac=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CO9NWGLMUbYJ4yuVR9jk8j6jkOyT+UuNnVKleYH1Ncza8BR00rIuRUL0AUSCWQjimOBsT6t9s10l9Gh2VBRLk2Li/s+YyAT0g8pM4jDxEnAU+G9ihzS+rhEP+Aa7C93PTOtEQgF12jubYHGbFdQ/hBx/+nRtOJ73d0nfTsj1jaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2ryUl2o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2ryUl2o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF038C4CEF1;
	Wed, 28 Jan 2026 18:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769624224;
	bh=IhrC60d2eQG/L7IP2IRrVOv7oygW1nChVhQPLpqW3ac=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=h2ryUl2oXyoN84EfNtLDQdkGvD72ir6IPKg5WzWzQwwkQwkCwMPQYq23t3piwG2Ij
	 WSLiAgDkhbogaFhe9F3ms4Aw5uLzi1SiysTpkJxkwSt4I8l80Y1oby7bzzKsMu/Y0B
	 VCk91QfaT0mTz+k1WUhHJPrLCzuOGmtp0cVXR49on8q973AvC9eJyJJG2yIsOYAw9C
	 8aTeIySUjNWw4Ig9RbIhv8StNi+0CdRRhVxiTq7r5wlUprP7Vn9qxozZCF0+AEBCmG
	 Re5D7lXS+9dBwAMXQ68ktBMRgohNq9+SC4t1hrbxuGCRZnkKitOdH6NGdaGI2usEIG
	 nZowcGFYWogLw==
Date: Wed, 28 Jan 2026 19:17:01 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Bastien Nocera <hadess@hadess.net>
cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev, 
    linux-input@vger.kernel.org
Subject: Re: [hid:for-6.20/pm_ptr 7/12] drivers/hid/hid-picolcd_core.c:651:33:
 error: 'picolcd_suspend' undeclared here (not in a function); did you mean
 'picolcd_reset'?
In-Reply-To: <n7o7o70s-3pp0-r590-p65n-2175r761q79p@xreary.bet>
Message-ID: <s71059o2-162q-n425-1qpp-8o8838q38rqq@xreary.bet>
References: <202601260353.Dk5ekiee-lkp@intel.com> <4ecf6a790596c4814c6666805b53aa7b1dd5a793.camel@hadess.net> <n7o7o70s-3pp0-r590-p65n-2175r761q79p@xreary.bet>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 28 Jan 2026, Jiri Kosina wrote:

> > The branch has v1 of the patch:
> > https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git/commit/?h=for-6.20/pm_ptr&id=318f7b0f1bea13d3aa0506fe6f40399f11c4ae52
> > 
> > This is what v2 looks like:
> > https://patchwork.kernel.org/project/linux-input/patch/20260113092546.265734-8-hadess@hadess.net/
> > which should fix the problem.
> > 
> > Note that my v2 patchset also dropped
> > "HID: surface: Use pm_ptr_sleep instead of #ifdef CONFIG_PM_SLEEP"
> > which is still in that branch.
> 
> Hm, something went wrong with my b4 workflow then, sorry for the noise.
> 
> I'll take a look and ensure that the correct version gets queued.

Now in hid.git#for-6.20/pm_ptr-v3. Sorry for the noise again,

-- 
Jiri Kosina
SUSE Labs

