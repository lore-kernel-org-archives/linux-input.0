Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AFF3E92B9;
	Fri, 27 Mar 2026 13:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774617144; cv=none; b=i39FvKJR57ctiQovx339BUaPODvR7A25+I2JYHO5IDNI/EV1WEGDYolc7GBhSMtuLq5Pm0JKZPkiT3UckLJ8yiibVLQAcaJJGDI+QDbP9mP9RacOe/TjG+7tja7xBRITnpvypGhoLmSZf7CAEpIWriS1hXpjsKtN5PZ6ccYx8mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774617144; c=relaxed/simple;
	bh=k3SAw2g7JT+mE/Cmp85I5JBXMfIqK+Bt/Xl68OhvgLM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QPFlh1E+7T1J6bG7EMbqSFGCyicQkAgGFdQPfqbyCuJ2ysjdViyigp3eiKtRzHarNseNcfP+jwwJJ+YAwIuvDX3EoulTtuac04HeEsgYJIJ5uppq7LR96p6OPZ3d1KTbmNPU0xONvU4wqNZ78VDwzwmV82bjmHS0R1pLxYteDEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EePIbfSU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EePIbfSU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C084CC19423;
	Fri, 27 Mar 2026 13:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774617144;
	bh=k3SAw2g7JT+mE/Cmp85I5JBXMfIqK+Bt/Xl68OhvgLM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=EePIbfSUxz9tbZ5kxid8GvXsqAtbQAnlvh52QloHwDFsct3RPKAKRZTMWhEQ4U3Ln
	 V5yqwKJkA8vLPaE2ipuf6GrcMRt23SP/MJ6XIg+qQRO/jGSUdwnzwabQetjRe/i3Be
	 YcEL0xTEPL/azyTc27LyxaC/i0wOQpUqU85iV4QDr8Gv9Dd9vMJXrzuR8oOBjsGvMG
	 anArKN9NxLmQjKpAg3NQtvrOJsg+8Sg9Ao8p7FCU+AkgdeahcNyKn15RCvrv2/ZG/8
	 qZjDwhtGGcIH2An46jxrn9ow9lARWAxifsa2VgHS/pdYfzrVUVslxpoJomLN6RB+ZT
	 oMhmZ7ElaJP6g==
Date: Fri, 27 Mar 2026 14:12:21 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Maximilian Pezzullo <maximilianpezzullo@gmail.com>
cc: Basavaraj Natikar <basavaraj.natikar@amd.com>, 
    Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, Casey Croy <ccroy@bugzilla.kernel.org>
Subject: Re: [PATCH] HID: amd_sfh: don't log error when device discovery
 fails with -EOPNOTSUPP
In-Reply-To: <20260304-amd-sfh-suppress-eopnotsupp-err-v1-1-20214ca6a2f7@gmail.com>
Message-ID: <36n8949s-p24o-53nq-pros-734220454np6@xreary.bet>
References: <20260304-amd-sfh-suppress-eopnotsupp-err-v1-1-20214ca6a2f7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 4 Mar 2026, Maximilian Pezzullo via B4 Relay wrote:

> From: Maximilian Pezzullo <maximilianpezzullo@gmail.com>
> 
> When sensor discovery fails on systems without AMD SFH sensors, the
> code already emits a warning via dev_warn() in amd_sfh_hid_client_init().
> The subsequent dev_err() in sfh_init_work() for the same -EOPNOTSUPP
> return value is redundant and causes unnecessary alarm.
> 
> Suppress the dev_err() for -EOPNOTSUPP to avoid confusing users who
> have no AMD SFH sensors.
> 
> Fixes: 2105e8e00da4 ("HID: amd_sfh: Improve boot time when SFH is available")
> Reported-by: Casey Croy <ccroy@bugzilla.kernel.org>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221099
> Signed-off-by: Maximilian Pezzullo <maximilianpezzullo@gmail.com>

Applied to hid.git#for-7.0/upstream-fixes, thanks.

-- 
Jiri Kosina
SUSE Labs

