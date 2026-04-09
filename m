Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C203D34A8;
	Thu,  9 Apr 2026 15:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775749540; cv=none; b=D3suIa8a4utEuOFMpvZoYm5dmHitivMnhvl5EMm56gIwBDzVAkyC4V+gdhhD1d/Hy2VWaGK1JQYk2L5UTMUV1xXUOLJE60xH311yw1ju+x/Iyodrmeg9xyiQq/B9Ingpsz0ebWRDzjeM3g6/QeR/8BLU7SuB9KyebpCWekk4NKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775749540; c=relaxed/simple;
	bh=acSSKfdjbJu+SJGT84w52d6DgdH8i1cbh1HK7OI2nnM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PjoqUUceECVFcl77PhKg81m68jNxUW5dcbT0fnkIUj2NcvglXndfkAQ+kQkCTzGm00Svhx10n4IQUqUFtkZOL3JmE34pDe3m9IT2sYOF9b17S6JZ15MYVO9KqoOILTPRq6XxSvE30rLG8ZbjU55bDQSroJGRMd5c2CCf3sf7qOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/UWnFdf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/UWnFdf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF404C116C6;
	Thu,  9 Apr 2026 15:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775749540;
	bh=acSSKfdjbJu+SJGT84w52d6DgdH8i1cbh1HK7OI2nnM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=s/UWnFdfiOh77pAzJBrAqYga3uRDVCgmo3MMKTV6y+t0g+pADfy6WWbwulz1jgju/
	 dF742joSdUnMx1tdDsUGVQJ88i7sn22InoelpvSQBc6R9/sTzJ9D1ybax9IiutE7oB
	 lSkQ9Dr4+KrzaflreMKQtlB8XXIYRWFrlzRtJnCHr6HAd27/Bzotg48XDN6heS+xL9
	 clwyxdQpYxW7253N6dpV7VNoIi2sD7NcdWtwQjS3VHWgKDDjcq3MWKmUFjCvsGFC8T
	 d+6E/zlwkWRh3VlJec6chMzKRtw9TZYK8MFoys1tmPuS3ynwmwRKs6nV96L0fXn8Du
	 BwxNd1OFBfK3g==
Date: Thu, 9 Apr 2026 17:45:37 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: =?ISO-8859-15?Q?N=EDcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, kernel@collabora.com, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: quirks: Set ALWAYS_POLL for
 LOGITECH_BOLT_RECEIVER
In-Reply-To: <20260407-logi-bolt-hid-quirk-always-poll-v1-1-4dae0fda344e@collabora.com>
Message-ID: <pnsp10o8-2q6o-64sq-90rp-nso9779o1623@xreary.bet>
References: <20260407-logi-bolt-hid-quirk-always-poll-v1-1-4dae0fda344e@collabora.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 7 Apr 2026, N=EDcolas F. R. A. Prado wrote:

> The Logitech Bolt receiver once connected to a wireless device will
> generate data on interface 2. If this data isn't polled, when the USB
> port it is connected to gets suspended (and if that happens within 5
> minutes of the last input from the wireless device), it will trigger a
> remote wakeup 3 seconds later, which will result in a spurious system
> wakeup if the port was suspended as part of system sleep.
>=20
> Set the ALWAYS_POLL quirk for this device to ensure interface 2 is
> always polled and this spurious wakeup never happens.
>=20
> With this change in place the system can be suspended with the receiver
> plugged in and the system can be woken up when an input is sent from the
> wireless device.
>=20
> Signed-off-by: N=EDcolas F. R. A. Prado <nfraprado@collabora.com>
> ---
> Hi,
>=20
> Given that the polling only needs to happen before the device goes into
> suspend, I wonder if it might make sense to introduce a new quirk type
> that only does a poll before the device goes into suspend (both for
> system sleep and runtime suspend). It would reduce the extra bit of USB
> traffic that ends up happening in this case with ALWAYS_POLL every time
> a wireless device connects to the receiver.

I don't think it's worth the hassle, but if you feel strongly about it, I=
=20
wouldn't object too strongly.

In the meantime, I am applying this one. Thanks,

--=20
Jiri Kosina
SUSE Labs

