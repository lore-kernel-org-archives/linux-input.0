Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14ECD4734EE;
	Mon, 14 Sep 2026 12:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789390049; cv=none; b=PW79mLDfEx30Lq9xx2Jpyc9C7Put351soHmlXXMJyuOzw97KHOOzhIzBYFgTI2tw+Q/ITHE5nCSGaUbOiazaJ6iaa8lo4KAhhGcVhH2IBwvesbKinGfwwkPhEAeQiBFon2WlOc2tMB/QzSA/9HLeAl8Ns3DdDZeKpVACdSuvwS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789390049; c=relaxed/simple;
	bh=tAitsuw8AhTfq0t/nrA6tdTDDKbo4fsHdNAfm5Ayao4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FAl0b7pU8zLsqXlhHSZKo21tOwz7/iF6Ybsf5niaT1uYSPBsDqtb2CTo1pYlGsECQdnpq7jYRdN84eBhSVSMWOFvQNZSyo7uAy7+xk1Bk1/O8dhbq9p9kWxWCNWWvh3mAdTWJ6VwPBmMH5cnAvhry988bjLv1o6ANTyGWrcvIfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6t6LwG0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6t6LwG0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CF5E1F000FF;
	Mon, 14 Sep 2026 12:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789390047;
	bh=Qbn1yF0tYGuFadhEoqmLpUePi0zL5QxdV+SC90uJUXE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=e6t6LwG0i4bMoxvSUtH78uQBJ7WsjwTw5nG3gqHbH0h29fQwNs01YXjFO7QwuobmK
	 q7aCWB0+yrazF6S95XbcL2V76UJr+COAt2/qd9SNwYRKhNO5aepDtXi5XZXXcPD87H
	 lvNypY5wM7pv6FWrSusV1HaeIfwKhtQFwSMuHRBnTQNa0n/hSpAdfmLL+jhBsjkG+n
	 p9AUZ7eljPbVwRHT+MozcWkusPmlFfONG5t6EyHKO+DR6R/kTqLwJoDLUYs+j+cB8v
	 iZEO7gBtiw4WqWdNo3eqFo6bKl5FlAAycyLen0lRhnDE2lZ7vk5fFZljpihG/bkTzU
	 jEe9ywc8waGdg==
Date: Mon, 14 Sep 2026 14:47:25 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Aditya Garg <aditya.garg@linux.dev>
cc: Linux Input Mailing List <linux-input@vger.kernel.org>, 
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
    Andre Eikmeyer <dev@deq.rocks>
Subject: Re: [PATCH v5] HID: appletb-kbd: support layer switching on Fn double
 press
In-Reply-To: <20260911200019.17028-1-aditya.garg@linux.dev>
Message-ID: <32s6qs7o-p566-qq34-5qpr-796osr037r78@xreary.bet>
References: <20260911200019.17028-1-aditya.garg@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 11 Sep 2026, Aditya Garg wrote:

> Holding Fn temporarily switches the Touch Bar between media controls and
> function keys. Users who want to keep the alternate layer currently need
> to change the mode through sysfs.
> 
> An optional double_press_switch_time module parameter makes a double press
> persistently switch the default layer. Its value specifies the double-press
> interval in milliseconds, while zero leaves the behavior disabled.
> 
> Signed-off-by: Aditya Garg <aditya.garg@linux.dev>
> Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
> ---
> Changes in v2:
> - Added a check to ensure negative fn switch times are ignored.
> 
> Changes in v3:
> - Renamed the backing variable to match the module parameter.
> - Fixed the reported code style issues.
> 
> Changes in v4:
> - Added missing "break;" in case statements.
> - Change author's email to aditya.garg@linux.dev
> 
> Changes in v5:
> - Remove the break; statements added by mistake in v4.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

