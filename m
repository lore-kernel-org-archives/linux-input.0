Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2FC2D8393;
	Tue, 17 Feb 2026 18:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771353411; cv=none; b=TEX6SoRBA/daE52FDQCEWNrpqcDPrMxR0C35CjDn4RVuTNwc7vvMVRMNJVR8bSywenqFjQ9sLNBFhlPz7O4T2XtIGwL8CDPxtZen7xsgl3s2G1uqE5xthYCBVE3pgl7bjEncSZLxf5zbNqsciwNpUfo2cQ+cbBXvDB5DFs7tg+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771353411; c=relaxed/simple;
	bh=sDqOJwmbKwu3rv1JLp98v1lToV6xEbXw+k5wH0Xcw1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+L5zCTQX4hEYmpQn9qhobGkhG7yBQSnVGYJgOWQez2rsHT0Ry+KWxDtWE42RCyhYbMSMyV1s1Ou6ijDTR8wcWrSiE9kKC8BBz9gZMr6Fa9RiO+bRS7o6FcAEZ9xFYK1IiEkDZ3HXdrovty/IZjSqVYqPvu/YoqfTinwsuAx7AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJ2zYsen; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJ2zYsen"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87470C19421;
	Tue, 17 Feb 2026 18:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771353410;
	bh=sDqOJwmbKwu3rv1JLp98v1lToV6xEbXw+k5wH0Xcw1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gJ2zYsenm+dWMHu9kH7k+SSf0t5fS51p6hQrYDTKtGsfNjjApmtkN7ZFbiQ5sWqu9
	 qasUxnuJ3of/v2EDo7DhvngiPMxeaAjmqJa1ORrW+4kiZLC2FWhuWg1IWoA5j5EG19
	 5TZqYwjIGTKNvboGgYJsGFXA8pMUwj56v2aaPJidsiRoYVPOvPLhiZm+eGEkFN6Ssz
	 hWvMNsmUmHq/MBjYHXExL0azB1ausCmZOzdP0Z+BLKnzu2aqKqVKnSrDHchTqpmX+d
	 07HSWWFLft0Vde4OmeeZLCQ24fKoXHNMFWNoMyTzMKPIu1svTFScmv6WMxt1xzA6dY
	 4U6vQUuQ+Gxuw==
Date: Tue, 17 Feb 2026 19:36:46 +0100
From: Benjamin Tissoires <bentiss@kernel.org>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] HID: Fix some memory leaks in drivers/hid
Message-ID: <aZS0OAaSPhX2pJ6l@plouf>
References: <20260217160125.1097578-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260217160125.1097578-1-gnoack@google.com>

On Feb 17 2026, Günther Noack wrote:
> Hello!
> 
> These patches fix a few memory leaks in HID report descriptor fixups.
> 
> FWIW, a good ad-hoc way to look for usages of allocation functions in
> these is:
> 
>   awk '/static.*report_fixup.*/,/^}/ { print FILENAME, $0 }' drivers/hid/hid-*.c \
>     | grep -E '(malloc|kzalloc|kcalloc|kmemdup)'
> 
> The devm_* variants are safe in this context, because they tie the
> allocated memory to the lifetime of the driver.

No. Look at hid_close_report() in drivers/hid/hid-core.c.

HID still hasn't fully migrated to devm, so as a rule of thumb, if you
change a kzalloc into a devm_kzalloc, you are getting into troubles
unless you fix the all the kfree path.

> 
> For transparency, I generated these commits with Gemini-CLI,
> starting with this prompt:
> 
>     We are working in the Linux kernel. In the HID drivers in
>     `drivers/hid/hid-*.c`, the `report_fixup` driver hook is a function
>     that gets a byte buffer (with size) as input and that may modify that
>     byte buffer, and optionally return a pointer to a new byte buffer and
>     update the size.  The returned value is *not* memory-managed by the
>     caller though and will not be freed subsequently.  When the

If the memory is *not* managed, why would gemini converts kzalloc into
devm variants without changing the kfree paths????

>     `report_fixup` implementation allocates a new buffer and returns that,
>     that will not get freed by the caller.  

This is wrong. See hid_close_report(): if the new rdesc (after fixup)
differs from the one initially set, there is an explicit call to
kfree().

-> there is no memleak AFAICT, and your prompt is wrong.

Cheers,
Benjamin

> Validate this assessment and
>     fix up all HID drivers where that mistake is made.
> 
> (and then a little bit of additional nudging for the details).
> 
> —Günther
> 
> 
> Günther Noack (3):
>   HID: apple: avoid memory leak in apple_report_fixup()
>   HID: magicmouse: avoid memory leak in magicmouse_report_fixup()
>   HID: asus: avoid memory leak in asus_report_fixup()
> 
>  drivers/hid/hid-apple.c      |  4 +---
>  drivers/hid/hid-asus.c       | 15 +++++++++++----
>  drivers/hid/hid-magicmouse.c |  4 +---
>  3 files changed, 13 insertions(+), 10 deletions(-)
> 
> -- 
> 2.53.0.335.g19a08e0c02-goog
> 
