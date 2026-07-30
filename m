Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F40E2BDC23
	for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 08:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785399768; cv=none; b=CoutBcCXgPJ7mMzo0IDPIFKxKAnoVozTgkmd2DzcmVC1nY1U3gp3S2/crwKO+URYYyUTeb0CsxRKcAn0WQB91h8z4Evldrn/Id4OQhCJw4dtG/YmCc671iYkYTuYo4QdUVkAFGhM0d5MV2MsEdGQX145FFTftoJdpU0JgxKi/vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785399768; c=relaxed/simple;
	bh=c7fk7n5Kzh7awhYhVlsJS03whAdVGqc75Avgoi7eTFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jV2Ws2xZctr7oZ4vpadtWSXSAucGYas8CY+ET5jfWBegqsyi+N6R7SCsTQ9hPY3kkkfevo1AYPyH/nQZ31gp8nyPvQa/sxj4NxZVyVNOh6Stua1eNLmwY/YwjlZwSiVEf895SBStVQ/8gP+gDfY0NbtbxbQ4OEEwu8OeZZNb6P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JkiFtI2p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JkiFtI2p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2789E1F00A3A;
	Thu, 30 Jul 2026 08:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785399766;
	bh=wfh8D0/UP7ZsBHm0wGqg/c1ZmdeJL+Ie0tZELNycZaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JkiFtI2p2J2DuvEwXrbkB5ViGHiMW7CeShPfA/7X8gpK7Ztlymkc/PCV+myB4u4ZQ
	 k+nnCEAoVnuIv5t9GSM1DEe1WrfkIljG/E+TDwiQknCU0P2UtAvi/G+oRwHn0HUl9S
	 ldYnKQJn2NcNSr7HD/ob452oZ4crV28LfgjT0UCcxwSBi7kDR4pUTFib9Pgnvsh2xm
	 qJl+dIAtdvtZjeO9reE1/vjDEIpZ3HQhUJT4eV6n45/Tu8gSNwoiYbfqu4kfOVU5xv
	 /jLiYl8eKQ49dTpcxBD6/34FEt9rRhUbSfSzOP4dJTKD/XImDxrAAZXnUhe39ztyVN
	 Ja7xdfSeHykxw==
Date: Thu, 30 Jul 2026 10:22:38 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Dave Carey <carvsdriver@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org
Subject: Re: [PATCH 2/5] HID: multitouch: Fix stale MT slots when contact
 count drops to zero
Message-ID: <amsJcWohgC8TJsYH@beelink>
References: <20260522111527.69428-1-carvsdriver@gmail.com>
 <20260715143312.32408-1-carvsdriver@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715143312.32408-1-carvsdriver@gmail.com>

Hi Dave,

On Jul 15 2026, Dave Carey wrote:
> Hi Jiri,
> 
> Gentle second ping on this patch, now about eight weeks since submission
> with no feedback.
> 
> For context, the other hid-multitouch patches for the same device are
> already in tree: the INPUT_PROP_BUTTONPAD misclassification fix merged
> to mainline 2026-05-28, and the ghost contacts fix (MT_QUIRK_CONTACT_CNT_ACCURATE)
> was applied to hid/for-next by Benjamin on 2026-06-10.  This stale-slots
> fix is the last remaining hid-multitouch patch for the Yoga Book 9 14IAH10.
> 
> Happy to rebase, respin, or address any concerns.

I'm very confused. I don't see any v2 in my mailbox nor on
lore.kernel.org. All I see is a reply to v1 with patch 2/5, which would
mean that patch is part of a series that I don't have any context.

Please resend a proper v2/v3 with the correct tags so we can actually
process them.

Cheers,
Benjamin

> 
> Thanks,
> Dave
> 
