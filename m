Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B6D2D97A6;
	Tue, 28 Apr 2026 16:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777393557; cv=none; b=mfcbBXi6NJ9+Al9wQ50jw7pEdYLYevUpDKBwYhmI5NBs4UxyhUq6kNK379tZstzMBJRWPjS1dWhmEG+81wsJOb/+KoCDslNxJ5e8mWb4RDVkBNe6Vo3h4YyXYo96KtNYOxQYN2A7ZgQXIENzyo9dZsmhPpcAQbZR+2fTTUs1pnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777393557; c=relaxed/simple;
	bh=z9C4NiuQr3JOxH1xjxISfkpqjw/LvzrYBva8ZBR8KbM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=f6LGtHaC0WA6J3xeHgEJYCbZeWHDlk/7uiMAiHtyAxIsOv5TemKGrg19qN0HdEGrcm55vAJ2XatMbTYD5OzThGiuUgRxqGUePpmu6Re4fTqiYdBUMBVXvxTLXVLdSenxvhV2zQuYeuxu7yhtN+wrpzfyv8IoIcPTLqeeXg74Iq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EkCGAfAa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EkCGAfAa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28111C2BCAF;
	Tue, 28 Apr 2026 16:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777393557;
	bh=z9C4NiuQr3JOxH1xjxISfkpqjw/LvzrYBva8ZBR8KbM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=EkCGAfAaAK78wO6U2Tg8zG+kAKSPxZNhUy6egzgjiBn3Jpffd47TtVISqq162CxsE
	 Jx5eUOsq8LcfK/a6bZCkIH1ASf4FkLrosG76FZaazwHJLCfC/L6VkL/HefAi782xEH
	 3wj3iMWtVoN5fjdHGHoyfQUkTktTd/Mav6rqMZAEWHsKMYwSU/6eWvqsFTZwTQ60sJ
	 aWFoSsT1z8MFOePiQA3yBccXLMfaHJjpT6T/EZ8pLZZ/FiYkXp0tPAtgWeZKtpJWAs
	 fdB/NTsob2pya5wN0zf+VDXJwyPevRotV0U1r/QPcqq635zSWbFTAgmqq24QFGubH6
	 p062wUDcqv7fg==
Date: Tue, 28 Apr 2026 18:25:55 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Rosalie Wanders <rosalie@mailbox.org>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: sony: remove unneeded WARN_ON() in
 sony_leds_init()
In-Reply-To: <20260411153247.5920-2-rosalie@mailbox.org>
Message-ID: <443p5qnn-79q1-2161-o6ps-nn4qq5q7oooq@xreary.bet>
References: <20260411153247.5920-2-rosalie@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 11 Apr 2026, Rosalie Wanders wrote:

> This commit removes the unneeded WARN_ON() macro usage in
> sony_leds_init(), this is unneeded because the sony_leds_init() function
> call is already gated behind a SONY_LED_SUPPORT check in
> sony_input_configured()
> 
> Signed-off-by: Rosalie Wanders <rosalie@mailbox.org>

Applied to hid.git#for-7.1/upstream-fixes, thanks.

-- 
Jiri Kosina
SUSE Labs

