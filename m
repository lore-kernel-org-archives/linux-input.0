Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5074446ED;
	Thu, 23 Jul 2026 11:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784806855; cv=none; b=QZMJDFBasNpt96by26ZY0APQkfQ9S8qhBeMIh+n4pT1gZhr+kDa+lEIc0zrMEhgigzjGmzd5ooEdxJuWZQRX0DIZyrtM8uupVKtsqtM31mKjrXH59PJv+53q+Z/z5sxGOSYDqn3c/Hd9io493RVygnnUjMXtp5olSAjFeNX20zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784806855; c=relaxed/simple;
	bh=p3GWWajFcuX3bvngkIzxc7oGbp+qDNV+kswQXzKfvIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EYkUKNGL4/31pdhub9xEs8qpzTxw6RrayhUeK8UuRIofzqptVw7clrTILrJ5q0mrIiOFfuQqKvtgOGIqXPaXQWB8SpYYCVMAWlOI/z1VUgh9eEI3hKWLyH+ezPAnNeFCZb/Csxa9G51NX2i+xLxgOS5rYmhksvj9qGAWZdj1kvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kS5TGBFH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kS5TGBFH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 666921F000E9;
	Thu, 23 Jul 2026 11:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784806852;
	bh=yYwfUXVUZiK1Kk4sc//LAooyNI64snUO5+e++KmUDs4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kS5TGBFHBvVqmYzd5Y8AKCbYfgMdkx4ZD67Rmo3r9Xo6oy0SJZsF2izTJF99m3s1D
	 gnsw2y5HVmxAlfa7x6Js111fjC9hS8NrxDrniwZNyTpiRjRXtnUwRoPXTUFnQJjB44
	 GKxRDLnE2PE5ji90L6g8S21nSZ2VKpQ8g25F/f/dpDih9mSm1QN4PMxtAuTXH6ZwxR
	 fXYtBi2EolTv3+MukxYIyfbHiuXLn3lViXFMBHt0lGRRsPt3mx33TrvQFUnzH0P+zr
	 Jnn7R73TV7p7HIURwxsq4sBgpGTkpdKLqK8sumy/myysGZq8SLtK6rN6Jsxhuva6kb
	 n1aA5M392Tq4w==
Date: Thu, 23 Jul 2026 12:40:45 +0100
From: Lee Jones <lee@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-gpio@vger.kernel.org, Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Pavel Machek <pavel@kernel.org>, linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 3/6] [v6] leds: gpio: make legacy gpiolib interface
 optional
Message-ID: <20260723114045.GE3363113@google.com>
References: <20260710211854.1371746-1-arnd@kernel.org>
 <20260710211854.1371746-4-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710211854.1371746-4-arnd@kernel.org>

On Fri, 10 Jul 2026, Arnd Bergmann wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> There are still a handful of ancient mips/armv5/sh boards that use the
> gpio_led:gpio member to pass an old-style gpio number, but all modern
> users have been converted to gpio descriptors.
> 
> While the CONFIG_GPIOLIB_LEGACY option that guards devm_gpio_request_one()
> and related helpers is currently turned on in all kernel builds,
> the plan is to only enable it on the few platforms that actually
> pass gpio numbers in any platform_data.
> 
> Split out the legacy portion of the platform_data handling into a custom
> helper function that is guarded with in #ifdef block, to allow the
> the leds-gpio driver to compile cleanly when CONFIG_GPIOLIB_LEGACY
> gets turned off. Once the last user is converted, this function can
> be removed.
> 
> Link: https://lore.kernel.org/all/e9252384-a55c-4a91-9c61-06e05a0b2ce4@app.fastmail.com/
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com> # for input
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v5: no changes
> v4: whitespace changes only
> v3: simplify gpio_led_get_gpiod
> v2: rework a little bit to keep the legacy code path more separate,
>     extend changelog description
> ---
>  drivers/leds/leds-gpio.c | 52 +++++++++++++++++++++++++++-------------
>  include/linux/leds.h     |  2 ++
>  2 files changed, 37 insertions(+), 17 deletions(-)

Any deps?

-- 
Lee Jones
