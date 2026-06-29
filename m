Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D893E0C4D
	for <linux-input@vger.kernel.org>; Mon, 29 Jun 2026 08:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782723469; cv=none; b=Qls/r0jSXLgIyQZcrUDbFot+z/7kwHbRb+a3ychvc8wVsvzfNOhIXlNT0PwQUDfHbX29bGxP0od6IZ7M06msYvbETWlhE78FwxFDBFbnta81iwCq3gyJC3ea0RbYsQGi+y8a9v4qj0eEx1BJ+/KYdJECs2GMTzSoIcKwO9qn5Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782723469; c=relaxed/simple;
	bh=2vBn03X2K69oRLfJJl3CBntTXhHtXcln+6rPXq1AAf8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Dquucn9OVu816BiHnKh9J9C7tSLIvbkLCY4I2PvM9aIP3c33B0U8CxLZS9E0RYMKXVqF72yMEXGjifx0xTMDf8H7zuS4vUkYSRdLwadIn2npumPZT2GMux5MmNK7jpg/a5UL7H1hGrQqJcrdwBARAbKzi8owd6amBy/unNCbA4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDG3IuUh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDG3IuUh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDDE31F000E9;
	Mon, 29 Jun 2026 08:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782723468;
	bh=GPhjVfwvb7jA8FoXSQMaYAbVh1sGjqEV731i8rTBMWM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=LDG3IuUhlTbhKTUpp02RLM6/pl2unyCaSrUMQsJ2SG67yhkjyucEYex9nO/0zram+
	 MaMb9FrbLCTCTnxQzprTd+9mzO8of0vAcECh53m2xIhPC1SH1AVAUrJ5Kyl8tCIKzM
	 LfNuMSJfTCXprDjjdqIjuFq/4TbdHFuhPosadjD9/2J1c0u5BEwGuQIY72yKfVWS7p
	 dnxmiBv2n8KMPj6jXxmDthyIJ/Yp1fBBJgQdpDAHWsm0Cs1GWwqALcN4JN0La6RFQ4
	 eFx9RaHlrzRj2bYLmOPdwS0y4DUbTK3ES0jzRM08Tv6awBX8b744U+t4FBBptc/Di+
	 i/QfSJ0uQGGGw==
Date: Mon, 29 Jun 2026 10:57:45 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Christos Maragkos <whitetowersoftware@gmail.com>
cc: linux-input@vger.kernel.org, djogorchock@gmail.com, bentiss@kernel.org
Subject: Re: [PATCH] HID: nintendo: Fix imu_timestamp_us double increment
 per report
In-Reply-To: <20260603152134.94439-1-whitetowersoftware@gmail.com>
Message-ID: <6451313p-s00o-3s0p-55qq-481oo2rq94s9@xreary.bet>
References: <20260603152134.94439-1-whitetowersoftware@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 3 Jun 2026, Christos Maragkos wrote:

> Previously, the imu_timestamp_us variable was incremented twice per
> report, causing it to advance by two times the desired amount.
> 
> This resulted in incorrect jumps in IMU timestamps reported using
> MSC_TIMESTAMP, so userspace applications saw corrupted timing on
> functions such as gyroscope-based aim and motion controls.
> 
> This is fixed by removing the redundant increment at the start of the
> report handling so the remaining can account for the full report
> interval.
> 
> Fixes: 4ff5b10840a88 ("HID: nintendo: add IMU support")
> Signed-off-by: Christos Maragkos <whitetowersoftware@gmail.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

