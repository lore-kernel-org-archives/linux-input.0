Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A281646A60B;
	Fri, 16 Oct 2026 09:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792142651; cv=none; b=LMQaq47lhvJMY/4qP/d72wSX7HtqY797T6avoqHzpDNpLqA/CCiYFbv732tpE8W4wz+HvoT3cX3bb9/SbFLlcKSM8cSdAgP1/40zJUNDgCReurJKfLthe58P82lrwXVx1AdFMtaM6Mw/xfVnT2LwheFLyB9L5o9b9dh0m0KOEXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792142651; c=relaxed/simple;
	bh=m7O917i3uMzYQOMatvH4g7Czvk4m5ebtOFl+vKddw0w=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=oTAeX29vLaw8/lFgZAMGclOI/rcZVK+d0WLrp5xM9wrLVKP5+9ck3p+lX53y0af88Gs7h0zIYBsVe+ahF2rwx12XDcMRuT/DrPQTl41utt+a9evK7o4GpfFQ23aSOCQTzEo5gsbZp7Gaqnx0WN+l56GDVpURtElNfzRoZIvzqK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IEPf2gCu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IEPf2gCu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF30F1F000C4;
	Fri, 16 Oct 2026 09:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792142650;
	bh=KZv2cD1G2hG6yQhIbcKJOKql4RCb95L4YETh+BU5DTM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=IEPf2gCuKUpDtfh8WMdaZX+4jINZ2H63XBNZYkhTHyz0yVaX+2xqL6Dpm9D4KveX5
	 1V15WnPfA/BhfeCjvvucg20Nd2FUkMyQtUnRgOTukLJUWVv3nGdWYVOEenDOcCE0ap
	 UeuZCfY2TlFCB1KgqETF1+MZrEHVyGy8sKzLzjE46nqwyFjaTfQYoLEJho0LZKSYTI
	 +QRFMr9o37+NmGq091er0JI3AlfCkKn6oZw8IkRBYASFrpFX30uIkD7k6A1kStDGvA
	 fUVD6s8UeZiBIS85YdWvsFv9gMeu8QzHTMANh/NmpS+pVaw5aOWzFWFb7ThhhDzhzh
	 dFn5xRbdpCINw==
Date: Fri, 16 Oct 2026 11:24:07 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: DemonPlayer <a18165943161@gmail.com>
cc: linux-input@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: apple: Add GANSS GS3104T PRO to the non-Apple
 keyboard list
In-Reply-To: <20261003161508.22671-1-a18165943161@gmail.com>
Message-ID: <4n70rp7n-n662-o196-6046-869p96694011@xreary.bet>
References: <20261003161508.22671-1-a18165943161@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 4 Oct 2026, DemonPlayer wrote:

> The GANSS GS3104T PRO is a tri-mode mechanical keyboard that reports
> Apple's vendor and product IDs (05ac:024f) over USB, over its 2.4 GHz
> receiver and over Bluetooth, so that macOS recognises it without a
> vendor driver.  hid->name is built from the product string only and it
> differs per connection mode:
> 
>   USB:        "HFD GS3104T PRO"   (iManufacturer is "HFD")
>   2.4 GHz:    "GS3104T-PRO 2.4G"  (no iManufacturer)
>   Bluetooth:  "GS3104T PRO"
> 
> All three descriptors carry the Apple Fn key usage (Usage Page 0xFF00,
> Usage 0x03), so hid-apple claims the device in every mode and applies
> the Apple function key layout: with the default fnmode=3,
> hidinput_apple_event() resolves real_fnmode to 1 (fkeyslast), so the
> F-row sends the media keys and Fn has to be held down to get F1-F12.
> That is not the behaviour the keyboard has on other operating systems.
> 
> hid-apple already keeps a list of such keyboards and switches them to
> the fnmode=2 (fkeysfirst) behaviour, but the match is a case-sensitive
> strncmp() prefix test against hid->name and none of the three names
> matches an existing entry: the "GANSS" one misses because the brand does
> not appear in any of the descriptors, and "hfd.cn" does not match
> either.  The non-Apple handling is thus never enabled and users have to
> pass hid_apple.fnmode=2 on the kernel command line to get the expected
> default.
> 
> Add all three names to non_apple_keyboards[].

Applied to hid.git#for-7.3/upstream-fixes, thanks.

-- 
Jiri Kosina
SUSE Labs

