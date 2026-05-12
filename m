Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A44530674C;
	Tue, 12 May 2026 15:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778599747; cv=none; b=M65Kt2Ve+l5R+okE3XPgEBnwoUqh3/z97NpZN/19EJnqTcNrMQlswh1iCAkERn91jcBrkrYStFxiG/CatdDwybrjKOYipbqnEKZGkDYHnvoGdgIhSqOmYg9rIc8BiJv15WdLxjbQO0LAozPJIER4f/QClKU9JAl/Dat6pLrQhxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778599747; c=relaxed/simple;
	bh=VLlzTDKqENcf2nY/tZLWi3K6BDkHIlu04ZtK/m/xTZ0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=McYBf6lNCPwx1Tidh+gCPsqQtrgTfGm3k/KEX77D4RJl6mQxm2V/UuLRU07xuZ/xpcSnCmWsLjweOPxCZYaVOKDfYQh3exV2QHzjVsI4OuDPQiOIugVb7S25czQapbqgU6XchKL99ytmVWTbxozPPvcYPSWhXeT+1a91IauppCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hqv0fucY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hqv0fucY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FE16C2BCB0;
	Tue, 12 May 2026 15:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778599747;
	bh=VLlzTDKqENcf2nY/tZLWi3K6BDkHIlu04ZtK/m/xTZ0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=Hqv0fucYtqkikpabrT+b2wdp1tTi7Q2FKmY0mHokaKsBIQxHXTrdoApHG+5nbaJ8n
	 vo5d2Fv5gy4uohBeKSZ0h+64EDjhL+ZCj/xEsPZCgxy9eOoVhutZTwmwJqEwF7IB88
	 mISbjXolEg/WMsCGcmZbrL4f130ZK5FZgSUBuzZFcJczwSxmyA763q566E4BUVynxq
	 PKZnIVv7NJLGWQD0guS5Gki/ypf9buQMo+atnvhS0G+fDGNdLNor9UTIXUfRlbD2bO
	 Z46kJdUWGH4XuVSMK2jLfIe7ek327/ciH6TPrkymmhAaW5d7J3y1WDHYb88bq5wJDQ
	 0qMsH7ApkQpzA==
Date: Tue, 12 May 2026 17:29:04 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Karl Cayme <kcayme@gmail.com>
cc: bentiss@kernel.org, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linuxhid@cosmicgizmosystems.com
Subject: Re: [PATCH v2] HID: rakk: add support for Rakk Dasig X side
 buttons
In-Reply-To: <20260321124759.608492-1-kcayme@gmail.com>
Message-ID: <n647pn1p-o32o-68r1-ssnq-81sop7527onn@xreary.bet>
References: <3284f00a-bea0-4141-a009-b367f527c466@cosmicgizmosystems.com> <20260321124759.608492-1-kcayme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 21 Mar 2026, Karl Cayme wrote:

> The Rakk Dasig X gaming mouse has a faulty HID report descriptor that
> declares USAGE_MAXIMUM=3 (buttons 1-3) while actually sending 5 button
> bits (REPORT_COUNT=5). This causes the kernel to ignore side buttons
> (buttons 4 and 5).
> 
> Fix by patching the descriptor to set USAGE_MAXIMUM=5 in the
> report_fixup callback.
> 
> The mouse uses Telink vendor ID 0x248a with three product IDs for USB
> direct (0xfb01), wireless dongle (0xfa02), and Bluetooth (0x8266)
> connection modes. All three variants have the same bug at byte offset 17.
> 
> Suggested-by: Terry Junge <linuxhid@cosmicgizmosystems.com> 
> Signed-off-by: Karl Cayme <kcayme@gmail.com>
> ---
> Hi,
> 
> Thanks for the feedback. I updated the patch with your suggestion to
> check PIDs.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

