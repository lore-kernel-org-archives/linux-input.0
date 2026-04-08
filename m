Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4C93D9025;
	Wed,  8 Apr 2026 19:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775677684; cv=none; b=RAFm5IQeksrOKXCcEtGnHDIxEKHgMaskAAVDyz0QifUgNL74XOxm9KeqRQZAkSm/RYrvKRtl9EI7GeaiEI2APENjoiwZXWhZH6FZJgfRxG3C5a1V4RmvD3crXQrRGXA44sx1Vq6AwMtW2VDBLdUF83XHHSqQNyEmjMpGts+sd4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775677684; c=relaxed/simple;
	bh=3CVVOy4rJq9P788JGenumBRfJ9lUzFMwXLkO0/vx9p0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KWXbf3FaPodjTKA3t0Bxhsj5KeDRm3xmsoR58h3Naay02LyXNkarRqbgDy9bx3ytSwuf1c3qulPyC6LSeh2rNjaMTgq1/7GduBFHtaQZXLq8L7gOg0ExW6k/O96vBFtVyPZ7JuSL3L5WMM6TsZl+a98I1gu8ZmZdipga+xX+Ydg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EKoXHBIX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKoXHBIX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D7B8C19421;
	Wed,  8 Apr 2026 19:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775677683;
	bh=3CVVOy4rJq9P788JGenumBRfJ9lUzFMwXLkO0/vx9p0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=EKoXHBIXOCSf+JVp2IANj1cNDRBbuBYJpAFakptcpEAEkNZXi8HLI+6bTPCI9GbZf
	 +OrK4vW2A8tVZMY1BkIvd/1btXyUInfMeZRN2vh59WsqqfKUt+7IxdQpPzSaaw5hrn
	 PrkQz46voSfZWOeqIRww6GDzrTKq9wufT2rghh43/1D1BQ4UL8vKcygHXYqGPT4YNj
	 ClT9Z29roabudPWd888oiLjr/AI/judRmvbxvfJcArrupiVmOKLx5TO19bYplyQs2v
	 OLjKtboqi/h+Pp7xoqEF8jYeslMuPRJo+gY6eZSjtfYI/81PBdhmMQzo4/UDlRIGrv
	 opB0g+13AcOvA==
Date: Wed, 8 Apr 2026 21:48:01 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Benjamin Tissoires <bentiss@kernel.org>
cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
    muhammed Rishal <muhammedrishal7777777@gmail.com>
Subject: Re: [PATCH 8/8] bpf: Add fix for Trust Philips SPK6327 (145f:024b)
 modifier keys
In-Reply-To: <ac_nblOZD_DwTYKb@beelink>
Message-ID: <1572prq2-rp66-22or-q8so-ns9098o4r9qs@xreary.bet>
References: <20260403-wip-sync-udev-hid-bpf-2026-04-v1-0-978cedb9a074@kernel.org> <20260403-wip-sync-udev-hid-bpf-2026-04-v1-8-978cedb9a074@kernel.org> <ac_nblOZD_DwTYKb@beelink>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 3 Apr 2026, Benjamin Tissoires wrote:

> Of course, you hit send and you realize the commit message is missing
> the 'HID:' marker. Sorry Jiri.
> 
> Also, this commit should probably be tagged with:
> From: muhammed Rishal <muhammedrishal7777777@gmail.com>

I have fixed that manually and queued the series now in 
hid.git#for-7.1/hid-bpf. Thanks,

-- 
Jiri Kosina
SUSE Labs

