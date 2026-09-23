Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D42135F602;
	Wed, 23 Sep 2026 16:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790179413; cv=none; b=DgObZbqwpSbolraLrhjPAAbr8yFEMyCb0TN9Bsvu/bokRC9vrQOH/WVHYHl4li23MwcMuWYr2y3eUCsk1TF87594XmKeVkv2YKFTyvTop7i35awUOo82nx+8PfpGjK+jPNasjbRfWBG5fRUWrwMIGBfq4rxBx6ttvTbIgrbKTho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790179413; c=relaxed/simple;
	bh=sSolexZbsuB9tNfv97cnepy9xgce4a4f1k94uZbjpS8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Vo4Gy/YdLd4oME2czNt7S8jfFsa+oDPjeELpERSk4lXnW1w/q41zmGegvXlm0fFCRJE3fucJTCDu/dRDNiRQts7IX5M3vkQ8z4d/Mhtqnuik0fE8EXB72uEWlunaRRuXaYRWBrauI9O5DJT2tDOThtPsKAlwIqng2ZAbUlPrCXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EN0HopW4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EN0HopW4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FB611F00893;
	Wed, 23 Sep 2026 16:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790179411;
	bh=g5Fv+yEG41HduDGnG4sryMTkuxvY3xnXaSyQYICyGuo=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=EN0HopW4xlqEEcZoD9ky8/ZaC82ITn+0peDzPlu9Uwp85UHXDadHWuADyOddBkg5k
	 XjWHSW6Q3/gjCe4dLlL+JOp55guQpctoRHiDTKmEKnbaId2huSmzw4AkfmrwzEvxrU
	 rBn25fC9JA7E/bBD6DAe9g3BQpoUzQS/m+2hbYL5qoDlVMxEfdnsSC5fKRirw2MJ77
	 Ghb0+8X2hqdesXQU8AzMvzUF6857NII6Ym0Z7n17VDZ/bh20rwdSAY4eJ1W2tz9InT
	 AxJcHNA6M6gvXVUZGQZ5fdQXb7zBrclUlTJbiZ++AXq9NZVskxL0+HUd4URbhO0U1e
	 kGgX8gaOtEgHQ==
Date: Wed, 23 Sep 2026 18:03:29 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Benjamin Tissoires <bentiss@kernel.org>
cc: Shuah Khan <shuah@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/2] selftest/hid: add test for negative return codes
 for hid_bpf_hw_request
In-Reply-To: <20260915-wip-bpf-signed_size-v1-2-6bc8f3d09f5b@kernel.org>
Message-ID: <2n351nss-p588-5nop-r58o-5n4p9q728q11@xreary.bet>
References: <20260915-wip-bpf-signed_size-v1-0-6bc8f3d09f5b@kernel.org> <20260915-wip-bpf-signed_size-v1-2-6bc8f3d09f5b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 15 Sep 2026, Benjamin Tissoires wrote:

> If the transport driver returns an error, we should ensure we actually
> get the error, not a success value.
> 
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

Acked-by: Jiri Kosina <jkosina@suse.com>

-- 
Jiri Kosina
SUSE Labs

