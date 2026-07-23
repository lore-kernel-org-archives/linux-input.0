Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B243A439004;
	Thu, 23 Jul 2026 13:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784812132; cv=none; b=c5qWIDoPZVoCqF05JNT+j7TYCGfZQW+XBPjeWvK9LYlTT+UwlqP9Gc+HfPFwDUlMxd8VFGj+ro7UxYbIOOXlBwhAilUGngEu0/3L7IExM2Eeui0z9VfzGsw2NJ7rFkuMltsn6bgFzkM9tqtdZSQNBmuqxc3krsCS/hboVS9nU1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784812132; c=relaxed/simple;
	bh=w9AIHzf7LFF59gxBCBHzIraohlYaZHVMBRfXRZKzW8w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RO240lNCDjAmpN4J4LQ42PjJlrB2umx0YKTSjBZ2sgUcJXqLh6ZdvOuWm25fdFFbbf+h0HcKYSynVmaeQAdstXDuGAB1wEtp6vQL18RFmv92471pYomCudCTmAY6mwCeOgYqNbXPgFQHRLNNoEld+KHoIUXSlbrCKvJTeppH97o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKSsPoFM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKSsPoFM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A6F51F000E9;
	Thu, 23 Jul 2026 13:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784812131;
	bh=wad4Pd8/YVNnivX2PPnlTUYq3rt95UA1cJctIX6KXhQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=oKSsPoFMGIAz2QwZ4sgl1uImujsUSAr92lYs7/sRMp1RnaABmQUvbg1kQC2/5E+8C
	 0cZY/4yFd8/NYTw8lP8tqCVI5niiCobHz1pCqZh/1rQ5XVOqDBmBB76990m0wfXJYv
	 0UH5pEoJZQ/E1mpnyGpduULD2GEm0qhckOeUMiyeyTu0F6VLh4bn+aSwOMbvFTk+r1
	 W7fl811ItHFurMft7QWdKbvRDnEK3vj0ACIZu3/IJ1TQXBi4TSHeXDoqMkhj+8xLjJ
	 tv91qgeHGp8j6p9zUSt0B9yBeGR4BjoecI14mvsukiLN3iVaJVNQ0WLAEovF7ZOz4Z
	 bXZMsw6pKUXdw==
From: Lee Jones <lee@kernel.org>
To: linux-gpio@vger.kernel.org, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, linux-sh@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-leds@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20260710211854.1371746-4-arnd@kernel.org>
References: <20260710211854.1371746-4-arnd@kernel.org>
Subject: Re: (subset) [PATCH 3/6] [v6] leds: gpio: make legacy gpiolib
 interface optional
Message-Id: <178481212701.3434788.4491931763676610326.b4-ty@b4>
Date: Thu, 23 Jul 2026 14:08:47 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Fri, 10 Jul 2026 23:18:51 +0200, Arnd Bergmann wrote:
> There are still a handful of ancient mips/armv5/sh boards that use the
> gpio_led:gpio member to pass an old-style gpio number, but all modern
> users have been converted to gpio descriptors.
> 
> While the CONFIG_GPIOLIB_LEGACY option that guards devm_gpio_request_one()
> and related helpers is currently turned on in all kernel builds,
> the plan is to only enable it on the few platforms that actually
> pass gpio numbers in any platform_data.
> 
> [...]

Applied, thanks!

[3/6] leds: gpio: make legacy gpiolib interface optional
      commit: 98c5c7b0d4269ecabfc86b8b49ffcfa47979e99d

--
Lee Jones [李琼斯]

