Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2940238425B
	for <linux-input@vger.kernel.org>; Mon, 16 Mar 2026 10:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773656748; cv=none; b=WM3Gg8WAE1EXUDcSDhvUFWVHWsvBsM1qMWfNgduzydOMQhuxwEnRRexNM5hVpTd0uB7ZKFCHctT+4H1kF2e/7FfvzOI5Uc3F8SUTniVG294z3jNpVj1q9IJefIfpLu4u50fiiXBGYd5ww8zY5144uemp3iRYNXoRKYDbd5F/K2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773656748; c=relaxed/simple;
	bh=4jdH+35Tx+H1H0cd1Llm+yYIq7M45O2USUNx2KKt6oE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SRNH6gJl+kuPiq1bEmB2cdqdgqQjfGDWKlnCK44hSdtM3dCCTgp4v078xmLAExUDj9x4cCjsZElUS9Qcxr3WtaQ6ogYrVFAn+LsURQC9Hpx5hBiKdZtmN/n4hw+E+bBG9H5LNYzWAkuksFCVjEyKmXlLPqJdJkVWuhgr1V7qWPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FbkPsNFM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FbkPsNFM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64510C19421;
	Mon, 16 Mar 2026 10:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773656747;
	bh=4jdH+35Tx+H1H0cd1Llm+yYIq7M45O2USUNx2KKt6oE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=FbkPsNFMb9kZZGa6HJZR0GQghU5sVaJ9SwTnAvDzW/RidCHQKVTrPC9NjnlRNmWXB
	 BfRQYQyu0Ranfn+D8DxcRGbIRFmBVs8lIkz8q0AKGFe11lSLRiHczysojqkmyAgSgr
	 a+FqheJJZ+T3abAVhJ5zVdJpyrxRZZ2eZNcPLIiqNt02vAWRjoVbKuafGKDiZ6GU4I
	 j/h/aNAuBxwvr34sq8Gw8mG+15UFkGk+dlR6iFAccvIQE8mAmR07LW4x+JY4LCYYjy
	 HsV9FUllQnNeD+nAj6bDKY8pzxuLgicl/d5AHc4S0AeVw1CZdS0bgPQLskPzAP7RAg
	 kbtG4HvYlLnoQ==
Date: Mon, 16 Mar 2026 11:25:45 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Daniel Schaefer <git@danielschaefer.me>
cc: linux-input@vger.kernel.org, Even Xu <even.xu@intel.com>, 
    Xinpeng Sun <xinpeng.sun@intel.com>, 
    Benjamin Tissoires <bentiss@kernel.org>, 
    Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH] HID: intel-thc-hid: Set HID_PHYS with PCI BDF
In-Reply-To: <20260313133925.35740-1-git@danielschaefer.me>
Message-ID: <282op9p4-4534-3347-11r9-862915n11q87@xreary.bet>
References: <20260313133925.35740-1-git@danielschaefer.me>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 13 Mar 2026, Daniel Schaefer wrote:

> Currently HID_PHYS is empty, which means userspace tools (e.g. fwupd)
> that depend on it for distinguishing the devices, are unable to do so.
> Other drivers like i2c-hid, usbhid, surface-hid, all populate it.
> 
> With this change it's set to, for example: HID_PHYS=0000:00:10.0
> 
> Each function has just a single HID device, as far as I can tell, so
> there is no need to add a suffix.
> 
> Tested with fwupd 2.1.1, can avoid https://github.com/fwupd/fwupd/pull/9995
> 
> Cc: Even Xu <even.xu@intel.com>
> Cc: Xinpeng Sun <xinpeng.sun@intel.com>
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Benjamin Tissoires <bentiss@kernel.org>
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Signed-off-by: Daniel Schaefer <git@danielschaefer.me>

Applied to hid.git#for-7.0/upstream-fixes, thanks.

-- 
Jiri Kosina
SUSE Labs

