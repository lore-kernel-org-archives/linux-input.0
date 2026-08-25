Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59773F5BE3
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 10:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787653035; cv=none; b=GFCWzVRyNKbCvcsuQbqS3rbggsKppPgC7GzZcvi1oqCG9sRLXxeDLxYc4urr6BdWFgagun5fWd/LMQwMj0vDC7ocD0mf1L81mVGDblBnLU4gesSDwAiOWzsKFdNjAp8Uo6//MSjj8peFaS0qt14nJQipcyCM0h8SfBX1cbqjhf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787653035; c=relaxed/simple;
	bh=jFnadq8AT9ApwnrtTWm7icCdQRJi+3EyiIR9MWErZB0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SzFelg66zpIZWtDQW8alzkE7Ejwr4rEImW2KbUiWN7qZjmLSpZ1gY7QBC1e00Mvx2KwCR7SZvrC2fkoXK7q3NC1gyKUdoaP/hm7kqo9EByFfb7eO3zEhi1v8zGEoBF54e3aFoP1f17GBsSu7/qCXPriXdg+Z2D4K5jyiP0W8yjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jRKmqQFX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jRKmqQFX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2AC21F00A3A;
	Tue, 25 Aug 2026 10:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787653033;
	bh=YoNe4iIWskL5ZC6+hevxnQ/j7ut2zQBNy2+93R1Ni3g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=jRKmqQFX+B54g5ulxZKGlQUBHvAcUBmcF8pRtG00TB5y2JS2gtYwCEWzb1MqRwBB9
	 ZGukl583GbFRYRF+E2VQBut1xOu8cflN7MK43uYeLNs2g6scYcRXrQg9sthKDgcLkE
	 v0UNB802BZVOaqnDIvvWVCifxk7o7RZ0pmYiKHEgSSPxZXRLtiXl1trLx7ecIn+Eq6
	 JvLs8CtWWB9b183usOkgOpBrPXup0cszyhk8eNUNiYIdAahz2aGmYoj2D+qDhvveAL
	 MeLZuHlydIzjn8hslu7YeQz8icgVa6M5zxhQt2lKnxUhmviCAtVIrCi/FngFJpQmQ1
	 Hb9yn91F7uDDA==
From: Benjamin Tissoires <bentiss@kernel.org>
To: linux-input@vger.kernel.org, Dave Carey <carvsdriver@gmail.com>
Cc: jikos@kernel.org
In-Reply-To: <20260730124336.637339-1-carvsdriver@gmail.com>
References: <20260730124336.637339-1-carvsdriver@gmail.com>
Subject: Re: [PATCH v3] HID: multitouch: Fix stale MT slots when contact
 count drops to zero
Message-Id: <178765303253.1516012.14612905306483159720.b4-ty@b4>
Date: Tue, 25 Aug 2026 12:17:12 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2

On Thu, 30 Jul 2026 08:43:36 -0400, Dave Carey wrote:
> The INGENIC 17EF:6161 touchscreen (Lenovo Yoga Book 9 14IAH10) reports
> HID_DG_CONTACTCOUNT=0 in the frame immediately following the last finger
> lift rather than omitting the frame entirely.  In mt_touch_report() the
> existing code only updates num_expected when contact_count is non-zero,
> so a zero contact count on the first packet of a new frame leaves
> num_expected at its previous value (e.g. 2 for a two-finger gesture).
> The sync check "num_received >= num_expected" then evaluates "0 >= 2"
> and never fires, preventing INPUT_MT_DROP_UNUSED from releasing the
> stale slots.  Those slots remain active in the kernel MT layer until the
> next touch, at which point they are released in a batch alongside the
> new contact — causing the userspace event consumer to miss the intervening
> finger-up sequence and corrupt its gesture session state.
> 
> [...]

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git (for-7.3/upstream-fixes), thanks!

[1/1] HID: multitouch: Fix stale MT slots when contact count drops to zero
      https://git.kernel.org/hid/hid/c/e8e60b6439ee

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>

