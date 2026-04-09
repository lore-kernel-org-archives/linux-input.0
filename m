Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F38F3DE447;
	Thu,  9 Apr 2026 14:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775745771; cv=none; b=HN4Nij5khj/Cd1QLTRCJ+Zr3X/I2OLj+7DyQVEKRxw2O3YQgUNE85O/43fiyo+YlV58c/GaZYg0x1sG7gZ3IzDoL3b2S6etMaUU/s8LlB+9jXH8JbgA+E2OCXyyBQP8gyDv7FzCgV9kk37EEpaKTuW7b/d2Bj4mAO6Oos+ghRYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775745771; c=relaxed/simple;
	bh=dh1VmwNw5RKLhZDFPTzQiLei3vrKaAEXjGuDijtpGzI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Nc6HvqCdiYExvFsGHttQy2aMSQ4r91hVeNcP19+VK+g0bgwVFdxZeJvR7iohnF8KzqJT/c6iYx1pMzr5EwXl3VyDr5QJa3a8PjOqCav3bCalLeQLbAEMfz/o7HzfxFHOJ7y8GYuEuxNAV9p/gWLYf85BY4zXIXDK1H7ZKMNK86w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=lEQy9nUn; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="lEQy9nUn"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net DE09940B2D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1775745765; bh=LEYAMT+rPpWjNOIp1YpEbnzwcqEOCHHliFZsSLYG2y0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=lEQy9nUnC6x5tqu/A+GbNCOFNKT25vVwGJ3WDps3a4AdgmM3AKlYS/GYJIAP4NUnb
	 lUy8TUTiqBwCZ6nWmhsW4qcaLyT5E9+GS00TvgCIxNAu2JY70ty5QswM1VrkzpMUtk
	 ProQ1kC0luQtEbfc/BHOJa6s+tZmDap1Y2BhwaOh0HHIcfiFlZp3DWtihqoauqsK8g
	 26aUHKOEez0w+TfIMSN4RD0Dr5m/P9RttfZEtvHwRuFqkyrFzPWEfBM6bDZLSyBWHv
	 hs04Ngp5uMCwVvbYpYgzwEA+XkQHEqLfUbR9dzkSPAePTqOc8+7y53DX6NpxOtVdUJ
	 BwEjD0yt5aTqg==
Received: from localhost (c-71-229-227-126.hsd1.co.comcast.net [71.229.227.126])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id DE09940B2D;
	Thu,  9 Apr 2026 14:42:44 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, linux-input@vger.kernel.org, Shuah
 Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] Docs: hid: intel-ish-hid: make long URL usable
In-Reply-To: <20260321230934.435020-1-rdunlap@infradead.org>
References: <20260321230934.435020-1-rdunlap@infradead.org>
Date: Thu, 09 Apr 2026 08:42:44 -0600
Message-ID: <87jyugb3ff.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Randy Dunlap <rdunlap@infradead.org> writes:

> The '\' line continuation character in this long URL
> doesn't help anything. There is no documentation tooling that
> handles the line continuation character to join the 2 lines
> to make a usable URL. Web browsers terminate the URL just
> before the '\' character so that the second line of the URL
> is lost. See:
>   https://docs.kernel.org/hid/intel-ish-hid.html
>
> Join the 2 lines together so that the URL is usable.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Benjamin Tissoires <bentiss@kernel.org>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: linux-input@vger.kernel.org
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: linux-doc@vger.kernel.org
>
>  Documentation/hid/intel-ish-hid.rst |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> --- linux-next-20260320.orig/Documentation/hid/intel-ish-hid.rst
> +++ linux-next-20260320/Documentation/hid/intel-ish-hid.rst
> @@ -163,8 +163,8 @@ The transport layer is a bi-directional
>  - A flow control mechanism to avoid buffer overflows
>  
>  This protocol resembles bus messages described in the following document:
> -http://www.intel.com/content/dam/www/public/us/en/documents/technical-\
> -specifications/dcmi-hi-1-0-spec.pdf "Chapter 7: Bus Message Layer"
> +http://www.intel.com/content/dam/www/public/us/en/documents/technical-specifications/dcmi-hi-1-0-spec.pdf
> +"Chapter 7: Bus Message Layer".

Applied, thanks.

jon
