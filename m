Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF53430CD85;
	Mon, 13 Jul 2026 11:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783941777; cv=none; b=Z4GkJSvtsH8d23WSvFoVKRhQUbVZHomedm2nz6xZFGCZg1de85sl6kISSaYM/wIoyXu6oB0JQU/GzFd5tqwbqw9k4jdxDHnRc3QFnmSknE4+eSJ/n9jX2t3UKpfRgc9/HemtfAH/7eUNXZ69iz8L65FLL89q73kAVZm4H6BhzzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783941777; c=relaxed/simple;
	bh=sjvsFnJ1745xk5H8KflhJEi2iCkShZqRfhJkhOXU/mU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W1z8gmpfmkZ6kteS7G8LptoqB9RK8b4t1hWBFw7p+uFqc7aCDWylJlaCr/VN6auVrI6ljW16d3TGR5e+IdB6w0X8nJkAm/Iy6dVTWg3lz3n1X1PVs5Rg8j8TqUHBZZ8d/BQKg8cUxr2m1W4aIZQmvZMe++SLtl6apY8e/HBo9IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kl43UGIZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kl43UGIZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED8F1F000E9;
	Mon, 13 Jul 2026 11:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783941776;
	bh=UGNflXcYWpUUtw4WqQXd2Oz4XTbsoE2fP1JOz72trJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kl43UGIZmR8TXAr4SAxALaFQuWMhL0qCJOfBC9d2jAJWvfzJIeAOtf3BnBJKi77AA
	 EH4cjO2S65VjqbHml14knu6uXnZ2OR/Sruz63J1UNzTjOyhIvOQapHCMHIlhwUgtBh
	 RKHd2ghtpszmmbxEbyhME6P3wPBnjJ8vFaxu3snvquWF0iFx3nLnD4dxMvE5oG+thz
	 5yRfwfwmGliUrlc0zFkip5YtSPwZicwQZeqM4WHnAuMGb2154DuMCmTjZbqyG0hPS/
	 cFaavDt//Bmswj3kzlzdekEsWG2zxFWq2zHuqqNd8jhpDLnkBiNb56nPtMgbjvmS6o
	 Uod5v0zwBtreQ==
Date: Mon, 13 Jul 2026 12:22:52 +0100
From: Lee Jones <lee@kernel.org>
To: FirstName LastName <bsevens@google.com>
Cc: Roderick Colenbrander <roderick.colenbrander@sony.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: playstation: validate num_touch_reports in
 DualShock 4 reports
Message-ID: <20260713112252.GA3774971@google.com>
References: <20260323124737.3223129-1-bsevens@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260323124737.3223129-1-bsevens@google.com>

Stable Team,

> From: Benoît Sevens <bsevens@google.com>
> 
> The DualShock 4 HID driver fails to validate the num_touch_reports field
> received from the device in both USB and Bluetooth input reports.
> A malicious device could set this field to a value larger than the
> allocated size of the touch_reports array (3 for USB, 4 for Bluetooth),
> leading to an out-of-bounds read in dualshock4_parse_report().
> 
> This can result in kernel memory disclosure when processing malicious
> HID reports.
> 
> Validate num_touch_reports against the array size for the respective
> connection types before processing the touch data.
> 
> Signed-off-by: Benoît Sevens <bsevens@google.com>
> ---
>  drivers/hid/hid-playstation.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Could we have this in all branches up to and including linux-6.6.y please?

Upstream commit:

  Fixes: 82a4fc463309 ("HID: playstation: validate num_touch_reports in DualShock 4 reports")

-- 
Lee Jones
