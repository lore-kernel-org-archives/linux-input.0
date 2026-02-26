Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7937B3D667F
	for <linux-input@vger.kernel.org>; Thu, 26 Feb 2026 14:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772117657; cv=none; b=g0R+YV+RBNNbq9fV0MHirZOxipOV+TcC4ECMa7roMK3353CCchjhL0OYGnQpOHcecUxFARe/h6L+YMk5lbg8QsULSR1rtvIuETVey2CQudwqlhUouZ14IvJ1k6b/qYTP8jYr/grptIrke43uaGQJP/upzyZkqURVeCQSkS2q2Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772117657; c=relaxed/simple;
	bh=2aXhWl0FQgvjzr7rcwR2ce39MRvbWvyPCzMhGaHhTzI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gXDPhXLiH/TzDgUCHpVcRUCfu8+3jJhtYFLw2f0N37TgSoBOb7BMiNooRquXI6qo0yJLzR5IxFhRVe714Ck6ce9qgFOySXx59N7y6yJqgQUhkhBSNqqe8lPueDl6Jq9EQgOxD+unrUEL2b1uxJ9UbVzk83PxnnZm4Q+lkk0j3wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gix1eArD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gix1eArD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE2CEC116C6;
	Thu, 26 Feb 2026 14:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772117657;
	bh=2aXhWl0FQgvjzr7rcwR2ce39MRvbWvyPCzMhGaHhTzI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=gix1eArD2VwXjYLb8xzy0dYbBPCpcH4m27Khngo3P+aXL77m6UdDIAEZv5bElGWcC
	 nA66CsKEL20jnkX11NWJd487cT4wItldT5d8XeBOydVbttshaxslKUV39/RY4zL+O4
	 AV9yyrbtBriZ0ESwV9rWVARCVoGCi3kFwIE7ZtwZxF/YQTEksyGeGwaBKeUqicnP4a
	 rfN6JObCdy+9eBgcL9eo6ke8nyxcXn/oJa7CmABA5qHcacXy+zkqhbhUg0T2FMtCM9
	 k/446IrmclG99BQvqT419GloZq4dHmTbEdNgQtob8QSqfEl1gXP+Rwt7XneKdLPPHQ
	 Du7OJXR4tR88A==
Date: Thu, 26 Feb 2026 15:54:14 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Zhang Lixu <lixu.zhang@intel.com>
cc: linux-input@vger.kernel.org, srinivas.pandruvada@linux.intel.com, 
    benjamin.tissoires@redhat.com, andriy.shevchenko@intel.com, 
    selina.wang@intel.com
Subject: Re: [PATCH] HID: intel-ish-hid: ipc: Add Nova Lake-H/S PCI device
 IDs
In-Reply-To: <20260203005507.44430-1-lixu.zhang@intel.com>
Message-ID: <r9164rro-p821-1n4s-0846-7r519npnn2so@xreary.bet>
References: <20260203005507.44430-1-lixu.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 3 Feb 2026, Zhang Lixu wrote:

> Add device IDs of Nova Lake-H and Nova Lake-S into ishtp support list.
> 
> Signed-off-by: Zhang Lixu <lixu.zhang@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Now in hid.git#for-7.0/upstream-fixes, thanks.

-- 
Jiri Kosina
SUSE Labs

