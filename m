Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252091448E0;
	Fri, 27 Mar 2026 12:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774614745; cv=none; b=DL6enMsEfvBkb/oZwq9gU3mRuEi97iqybql1NmOtxSbmrkTwqPlwdst5BTM9eUN+QFrQAmXK6fXNKV66+ksJ/FXvVA1n9buNYgy6eoNIWhAnT3qsc38DJF0DUK1gJQi+zdAci2ZWH9ehVAthKKD8eZUtWSSNGcJON8KR2XyDkbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774614745; c=relaxed/simple;
	bh=3NpkiXQRwsGFPey0rfH1abEb/umNZQC+7h/nQokFmXw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=G2SsF/t4sp55vPiB1gApmfBq8S1z6eONx66KXJKMaieX426v5CRQBXiHj024MSOcBG2I6d5xC0TFUg4NpH9avbRjyTnx5E+yQeyYvkTCZvCxvJh/t6KTxNnrTtBxaQrZtMTC6F1gJ0Xa28oBv3dFNd1dMz+umrY7J6ovbeZg7A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TY/UUA1x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TY/UUA1x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 580FBC19423;
	Fri, 27 Mar 2026 12:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774614744;
	bh=3NpkiXQRwsGFPey0rfH1abEb/umNZQC+7h/nQokFmXw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=TY/UUA1xzmnPmH7934tlQ9kLCmEmSc7GP8wsEgjvUMQT0oaM3knCrkWGmR9yss8aT
	 hwhxavaOZkvbiP1nqu0A2JFTcRq+3Adb53IBkG2lfUhOvFQ8SXEz/Mh5a53z55ajHM
	 hYZJ0JfwvY46W3oqCphpqlxXk19w9THtpXYJPI4MLe5WWZIMxZezBMF5rJ/utc+Dbg
	 MuZk41nu9hBWxEGJ8agUI5n3lWU3bnuGou8KC2A+xnDfpGzfc4Dg+zstE+cyYTHFGU
	 WLXKs2gzN+VQSIhhpgPMlFPNpeaEnmAbqKdxHbxUQucESlL2iiSvW4H7TKFniVOk/6
	 E53qB2cHC0AfQ==
Date: Fri, 27 Mar 2026 13:32:22 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Even Xu <even.xu@intel.com>
cc: bentiss@kernel.org, srinivas.pandruvada@linux.intel.com, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
    Rui Zhang <rui1.zhang@intel.com>
Subject: Re: [PATCH] Hid: Intel-thc-hid: Intel-quickspi: Improve power
 management for touch devices
In-Reply-To: <20260318032547.839686-1-even.xu@intel.com>
Message-ID: <471oqs4r-2sps-so2r-rs37-rr9s24n3826s@xreary.bet>
References: <20260318032547.839686-1-even.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 18 Mar 2026, Even Xu wrote:

> Enhance power management with two key improvements:
> 1. Hibernate support: Send POWER_OFF command when entering hibernate
>    mode.
> 2. Conditional sleep commands: Only send POWER_SLEEP/POWER_ON commands
>    during system suspend/resume when the touch device is not configured
>    as a wake source, preserving Wake-on-Touch (WoT) functionality. This
>    ensures proper power states while maintaining expected wake behavior.
> 
> Signed-off-by: Even Xu <even.xu@intel.com>
> Tested-by: Rui Zhang <rui1.zhang@intel.com>

Applied to hid.git#for-7.1/intel-thc, thanks.

-- 
Jiri Kosina
SUSE Labs

