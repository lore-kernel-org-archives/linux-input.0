Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D66339099E
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 17:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785778107; cv=none; b=KodjnLw248VATtnWCfQ4BpFBu0rS26Sm6AELjpNN3OlSyL03vVwGpyqDpDQuFssM2XJd0S7XOFMDZyVdMqjkDw5eVAxznM1/7dEsj1GBO9sf1Bk4ViUK0t25aqV1/RF1A0ERlObugW4M1C7L60bE9UwgNBZ3hHdIYJkhkO+jNXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785778107; c=relaxed/simple;
	bh=oVAB/ivPy2s5l4xwJJlsG/ZCRjyoovYGN/HotPb+U2A=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lmJ3BdHPMJUVKthDTA2v1y8sz0w3A/+WPbeXv8/430C0mzYnYAekkp2seaphb108bsnWFUiwaAq3AA3PWqgJlf11QCdqp32AzHR4ztaB3U5QxrcNTm/1Eqz1QbnpYZwEovaIuQqQhGs2zFrznZLlUWHBJWxqRjQihvLVynC9fIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCvLswM3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCvLswM3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 219291F000E9;
	Mon,  3 Aug 2026 17:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785778105;
	bh=Je+C5GeuhG9ftnayMFQXnhdvImm+jvzi1TWiVWlAtNs=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=fCvLswM3NmvwSkJjQk6dKPPL/4UOhYijjjNVXlYwFuTqpeQZgRLO+OFAE7v0e1FyJ
	 /rUjYEVvcrtWWXep/nweBujGpaiH1gJr3gWfSY3uSM/jQb5fjoSkZ1C8AdbnX7joU9
	 TSEyk7UZiMqu7n9H0QOd6OkIGtjOSARv67+rpphkyy6KXsbrQKipLhJBHrFHSbvcne
	 0SqBUGGhYrD973uUZPSdxr/z2hhzV0z4KxXXRPHuStbNdhGlRI9B7ORFL5banTUM8a
	 uqy6FzFuSBtGDcRt6voHx7zu9Py5HjMHjqIPNKYw7uLRHX9fAT9KPKd2OffFyvwkZD
	 a4jp+P0/QAiDA==
Date: Mon, 3 Aug 2026 19:28:23 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Vicki Pfau <vi@endrift.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org
Subject: Re: [PATCH] HID: core: Expose id attributes in sysfs
In-Reply-To: <20260624023601.1197134-1-vi@endrift.com>
Message-ID: <nn95o475-4or8-115r-30ns-np4n641p39rq@xreary.bet>
References: <20260624023601.1197134-1-vi@endrift.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 23 Jun 2026, Vicki Pfau wrote:

> udev rules for handling input devices generally match on idVendor and
> idProduct for USB hidraw or id/vendor and id/product for evdev nodes.
> However, hidraw nodes that aren't created by the USB subsystem will only
> expose this information to udev via the kernel path itself. This leads to
> doing substring matching, which can be error-prone or overzealous. Instead,
> since the HID subsystem already has this information, we can expose it
> directly in the same format that evdev exposes it.

Applied, thank you.

-- 
Jiri Kosina
SUSE Labs

