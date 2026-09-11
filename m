Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D67232C92A;
	Fri, 11 Sep 2026 14:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789135747; cv=none; b=AQ37sFAgPwt8ztWWWNu9DvbADIsrA2VcFdvD5uhXsbwvOEQY/a5/+8/vHWwSBE6VSkvokF3i9CBldmokDIWFNp4cZzK/67iNYCHHAqZfV6Oy+IHK7yKcZMmnJBWYn9oWOsHlIn/ZzzHH1i8TpWMD9leA8S5tufHbaDdhhaiq1vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789135747; c=relaxed/simple;
	bh=smf7gLQ0IUtqRpUYNkEksCaPFG3mU+m+oVAPN80Law0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AlPIN5jDZqwRCk9egQdED07XjoaXJViv0awzg6/Oza31srbk9l9dibpZnyNsroD+nMo34vWNmF4wh1e9Bo7XqUAFFven+uSWr89FGiZ4WrziUMDTm7eZ5gOPFoAi9bLL8CvlxU5Nwq89UThuPyO20mTOO/rIH3AyujdnRw7drAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfUR+zkP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfUR+zkP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8931F000FF;
	Fri, 11 Sep 2026 14:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789135745;
	bh=sI8+dEMb+UGJ0vpgiZvtZPKfwEtPD6hpL/FLA54/Kfs=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=MfUR+zkPl2VggUnpjhVG85lIw0moQgDH+xYaPHsOTqfapI2aVe8pTzUBXTvP271Zt
	 lQQhL2G6bpmnKeziOU3r1QTYQDdvEuyPQ7MZ2pmZ+a1cYmuIxSNV5T7r4svLVxhNYF
	 faqnR7igQNfj/VeNfRD3pRgFFw/w/3E0FgAX1pZtIU8JPSdOh+Yen1a4Vtv8mArAwV
	 bnIz01EOm5A6DEOCk4XBYaXD/2F6IXbMMsPdKcNhV3bLfBa2rKxN+2Guv//FYUSjs4
	 7+iy9vfOwgX5zLIvcs7n1NKkuWsDtITu8oWzHg52I7hFvEAMQSfPZ6r/pKG139mNsC
	 GOyOfDtC+rqrA==
Date: Fri, 11 Sep 2026 16:09:02 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Andre Eikmeyer <dev@deq.rocks>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: apple-touchbar: avoid nested runtime PM in PM
 callbacks
In-Reply-To: <20260810140352.35866-1-dev@deq.rocks>
Message-ID: <qs64s8o5-ns32-s4o7-01sn-n39q6rq83or0@xreary.bet>
References: <20260810140352.35866-1-dev@deq.rocks>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 10 Aug 2026, Andre Eikmeyer wrote:

> Hello everyone,
> 
> Runtime suspend of the Touch Bar display stalls because its HID suspend
> callback requests a runtime PM resume while already running as part of the
> same USB PM transition. The nested request waits for the transition that
> invoked the callback to finish.
> 
> The matching resume callback has the same problem. It can stall after the
> virtual host controller has successfully resumed the port.
> 
> The mode update is therefore split into an active-device helper and a
> runtime-PM-managed wrapper. Both PM callbacks call the active-device
> helper and no longer acquire a nested runtime PM reference.
> 
> We maintain the apple-bce/t2bce virtual host controller used on these
> systems. Although that module is not yet upstream, its runtime PM path has
> already been adjusted so the complete suspend and resume cycle works with
> this change.
> 
> Thanks for your time and work.
> 
> Signed-off-by: Andre Eikmeyer <dev@deq.rocks>

I have removed the "Hello" and "thanks" from the changelog :) and applied.

Thanks, and sorry for the delay.

-- 
Jiri Kosina
SUSE Labs

