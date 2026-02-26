Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16538313293;
	Thu, 26 Feb 2026 15:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772118084; cv=none; b=o4IA39m+QXKJmfBWv+vjJ1/0B74N8ZmVNa42gOzXvzPZeeU3Dd5xlNBKZQjLDnLkAmc7KCl8bQDUinou3mA+EJizVZMXXedrOJzladOZzbQuvY5asvkXaFcrteyheaCrIh29JMFkZFZPTHOxvS2PJzrqjm6cMc/OUCdOWGVgS08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772118084; c=relaxed/simple;
	bh=LifbC9eXqjyvgz/qyI3yipShRxzms/ASN2m/aMsXJ1g=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jRWqVA4XARXq5INAtbn01Awc670ORtCSq9207tNxCG+C4EyicjyhbsYM+i5HOTrm9uHtobuWmnqXY7lSFJqWNTVo62wHK07T1wsUmjYcB59Pkx/PkGItcn2Mian4Lu24z1R/Oohwq5BE2VLdEE3qDIJUJnwZ5t+wtqGij1L2wIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUvG6u2e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUvG6u2e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42AA2C116C6;
	Thu, 26 Feb 2026 15:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772118083;
	bh=LifbC9eXqjyvgz/qyI3yipShRxzms/ASN2m/aMsXJ1g=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=XUvG6u2eaLMv5tMJ/KJrGepMFbpVAF+RRIp1zh8iZs2kSUMUZ1zHINswN5rn28Nyz
	 7jomOGov79oiulOsv7bxhm50IYhA8e441zGaUiNN/o/k73v0M5/Rebgxcn92/YrRSy
	 rGZ8niIgKXcX7p7YcS568H5sGY4WvyKS2aKQwCnjfClwKfo2PEHuiLbOjJwIzj5JpF
	 hvhDjfCdk7GXcwjtzfU5VwY/9rl8XQ6awuYLnCIyX4NACRlc4lRksIRsVPeObJ5cXl
	 ZfqTjzYANgvF9c4W3uMcNjXPhSWo3/B5RBkmORnBGx0PyGibQL+KNEsxLlPOwb/QO/
	 iLYzvBrobHASQ==
Date: Thu, 26 Feb 2026 16:01:21 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
cc: linux-input@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: apple: Add EPOMAKER TH87 to the non-apple keyboards
 list
In-Reply-To: <20260224090004.73980-1-tiwai@suse.de>
Message-ID: <1q0494rq-48s5-737r-4o45-407q8036or29@xreary.bet>
References: <20260224090004.73980-1-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 24 Feb 2026, Takashi Iwai wrote:

> EPOMAKER TH87 has the very same ID as Apple Aluminum keyboard
> (05ac:024f) although it doesn't work as expected in compatible way.
> 
> Put three entries to the non-apple keyboards list to exclude this
> device: one for BT ("TH87"), one for USB ("HFD Epomaker TH87") and one
> for dongle ("2.4G Wireless Receiver").

Applied to hid.git#for-7.0/upstream-fixes, thanks Takashi.

-- 
Jiri Kosina
SUSE Labs

