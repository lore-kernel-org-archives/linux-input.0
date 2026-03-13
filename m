Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98C634D3A9;
	Fri, 13 Mar 2026 15:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773417539; cv=none; b=JUv8RkwyaO1Qum+9j+LpC7461ynCPnQRbXCdj1ukTDc8cQjm9HNMfjWJhbg1Z2528KM4acdEyl8K8t1TBqIUUNcQt6xBVXD0TavRERvbTzRCckLdDx1ePWS4aHU4ve35W6mesoyBj/U9rlqKC2quNaCk211n+LmxjrMLkHARiq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773417539; c=relaxed/simple;
	bh=P2uvBqGU/NQqrLW4csY/AEZWik/8GJNqQEz5zwpWgoo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=aog8lwtUPyfkdg30e3ZhIdW1+yHUYP5MBDvn5AcAzMWKYCsLvKGqa7low7sNdxKYHutDa8CSnN16UfQQDU40yzRF+1pKbunaqC79sFpeTl3muZ609rytRd2DVfLPG0o95UE7lZG/obgTlfqhQmip1kbFVSN2FrHvQ0pSkIpPrJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PuOC9wZr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PuOC9wZr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10E0AC19421;
	Fri, 13 Mar 2026 15:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773417539;
	bh=P2uvBqGU/NQqrLW4csY/AEZWik/8GJNqQEz5zwpWgoo=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=PuOC9wZrpsSUtep8G0CF+iYmbwEzKs5UhEJGf5RiMGc1wxtE/Y6Q5M97DgskyqzXh
	 96F6OqN4Vttq8F7//VPeaJVTQdOU+AHuCHS8rATqA76IUoITk66oYyvrKonC3TZYJJ
	 SJkB/yc/zXvqhkQevwVr4WbVsFkyYSbl+TJ54ARhC96W2MHj3UREyrNPAtvwQdjU0w
	 Q1m/oBeP3NSDzet9Bly93nf4X6/wgiQ4WGHmjzmvkwBhNsLaGhxdGJQPWq9ZyTHKzT
	 Mmqieb8xyr5v7646SjumQagBLVVIIY+TOg6la8pGvivHSlaz03gBGANt4STPA0SnT0
	 4KCUcrBV7FZzw==
Date: Fri, 13 Mar 2026 16:58:56 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Benjamin Tissoires <bentiss@kernel.org>
cc: Shuah Khan <shuah@kernel.org>, linux-input@vger.kernel.org, 
    linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
    stable@vger.kernel.org
Subject: Re: [PATCH 2/4] HID: bpf: prevent buffer overflow in
 hid_hw_request
In-Reply-To: <20260313-wip-bpf-fixes-v1-2-74b860315060@kernel.org>
Message-ID: <0124o497-743s-7pno-6187-368r62sr2976@xreary.bet>
References: <20260313-wip-bpf-fixes-v1-0-74b860315060@kernel.org> <20260313-wip-bpf-fixes-v1-2-74b860315060@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 13 Mar 2026, Benjamin Tissoires wrote:

> right now the returned value is considered to be always valid. However,
> when playing with HID-BPF, the return value can be arbitrary big,
> because it's the return value of dispatch_hid_bpf_raw_requests(), which
> calls the struct_ops and we have no guarantees that the value makes
> sense.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

Acked-by: Jiri Kosina <jkosina@suse.com>

-- 
Jiri Kosina
SUSE Labs

