Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B19A427FA9;
	Mon,  3 Aug 2026 18:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785780284; cv=none; b=qLdicSO7iiUV0ga4qUXmxOBUpw6WO/hD79OXUHd3WMqPviSBD7iGLKOL1grHZS+cTbJbQ0nqH6rsortAtqjFrKm1OCcGgZGOeE3uLfenXaeoND9YcGPlzBl0ZHVAIui7pfe+9qrXnK5IAtTD6OSTKD6PLlk+UQAU63c5TQboHCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785780284; c=relaxed/simple;
	bh=bgs+vrRE2bas4JDMXeynS+ayRA8a8ZXT4tFG7FCxcS0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=EkIcEOfNDBPAE3IgCHD/QgtOZwklmdZhsREqBKaIW4ltHShRs5r4WJrHdm5qxpGujztJxpXCOgzdVj56GguZ3Ld1Cr7noLQ74NB9LNJgU4pnHZMzavDjw2KiSh+0tehYcg8XC+cLGKbnrMbRUBM1AxFT8bwwR0bkCwUUjLdZdAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZz6m3eH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZz6m3eH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 315521F000E9;
	Mon,  3 Aug 2026 18:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785780281;
	bh=fl6hJdsienU67gAbtfxfdRkpX+319qi7kN5o44Na9Go=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=CZz6m3eH8sk+kavGxJWhHsoLsiF/3Dou7pHZvieV930Cd3omPQUnyNMdHKmRS5XQc
	 T5nhtAsyNoWMkze7SHcozegTG1nxJ2XgIsq5dAPlQ/DHxMuqH7WYNImnsZ/xFAg6Vk
	 BsEcjeEJf4VqJjmbTyl4WyWScJE9DEPYGjDk5kWakeJDlkR4syTjk7anan976uBeaj
	 ++EGktR9OY1yjuYmDVoHczMQRF6atxpCeoFTnnrD/AeOfb9sKrcNewJLGTQlnpuUnM
	 i4TZzLAiLnggwRN9yo5ScRmufQSg0WyjaB6Gpbg6dwHmE0IV7VLy/zlbSwaAj70Mf0
	 z2Z4qtwRxbgKg==
Date: Mon, 3 Aug 2026 20:04:38 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Alexandre Derumier <aderumier@gmail.com>
cc: "Daniel J . Ogorchock" <djogorchock@gmail.com>, 
    Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: nintendo: fix rumble starved by the input report
 cadence gate
In-Reply-To: <20260801090059.1349535-1-aderumier@gmail.com>
Message-ID: <8q45nos3-s5q2-0028-7o72-po920q5892q3@xreary.bet>
References: <20260801090059.1349535-1-aderumier@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 1 Aug 2026, Alexandre Derumier wrote:

> Rumble on third-party controllers speaking the Switch protocol is weak
> and intermittent over bluetooth, and absent on some units.
> 
> Since commit d750d1480362 ("HID: nintendo: fix rumble rate limiter"),
> joycon_enforce_subcmd_rate() requires JC_SUBCMD_VALID_DELTA_REQ (3)
> consecutive input reports spaced 8-17ms apart before releasing a
> subcommand. That window is the official Pro Controller's bluetooth
> cadence, and controllers that do not report on it cannot pass the gate,
> so their rumble is starved.
> 
> Measured over bluetooth on one host, reading the controller directly,
> fraction of reports at which the requirement is met:
> 
>   official Pro Controller     95%
>   Datafrog clone              46-52%
>   8BitDo Pro 2                2.5-4%
> 
> The Pro 2 delivers reports in pairs, so 11-19% of its deltas are 0ms and
> reset the counter. Affected controllers report Nintendo's USB IDs, and
> the MAC is no better: the Datafrog clone reports an OUI registered to
> Nintendo, so identifying them by vendor would misclassify it.
> 
> Instead, notice when the requirement cannot be met: after
> JC_SUBCMD_RATE_MAX_FAILURES exhaustions of the limiter, fall back to the
> pre-d750d1480362 throttle, which keeps the 25ms spacing and the
> transmit-after-receive synchronisation from commit e93363f716a2 ("HID:
> nintendo: ratelimit subcommands and rumble") and drops only the cadence
> requirement. Exhaustions are counted cumulatively, as an affected
> controller meets the requirement occasionally and a consecutive count
> would never be reached.
> 
> Signed-off-by: Alexandre Derumier <aderumier@gmail.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

