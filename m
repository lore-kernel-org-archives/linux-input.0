Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6ED30EF80;
	Sun, 12 Jul 2026 12:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783859250; cv=none; b=AGWuvvYStXo2pW+9qaPLRvcjq4nkQE5iYv5JVe12Il7OKts5gcYtl/M+QfI7RwvqFRbMsIAIOIqoHfObvfN4IedyZRF9q4BPfxeEaG0Ly8J4PhlPbsWVZTHpQqcSLhrf6eUSBxiNhkC3BDqY5IyV6fgvZ0AaTN9upGewcggpVIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783859250; c=relaxed/simple;
	bh=L/n4SezSWQATpwU6IRgOEvEHHHUBkOmPMdj879cIAIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cUQMPxh0avTP81eeAkmrlBuBq5EAhX/pAR1Su3Xw1/C2rB2SvGKn9pUk6Y7x4ydWHbY3cHGfeLQ9xOtDIXXUEPgm2Bq3trfu7oebV6YCq5Kef9NuSQO+ChWLV41CIikbYXp2uPSZ30HcfDua6IA/pB17roL3ioJASf+b9VREZLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C37F81F000E9;
	Sun, 12 Jul 2026 12:27:21 +0000 (UTC)
Message-ID: <ec9e62c8-3c1d-4493-a876-82432575b381@linux-m68k.org>
Date: Sun, 12 Jul 2026 22:27:19 +1000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/10] m68k/coldfire: replace linux/gpio.h inclusions
To: Arnd Bergmann <arnd@kernel.org>, linux-gpio@vger.kernel.org,
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Gregory Clement <gregory.clement@bootlin.com>, Frank Li <Frank.Li@nxp.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Hauke Mehrtens <hauke@hauke-m.de>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <zajec5@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Dominik Brodowski <linux@dominikbrodowski.net>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, patches@opensource.cirrus.com,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-input@vger.kernel.org,
 linux-sunxi@lists.linux.dev, linux-phy@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-sound@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
References: <20260710211954.1373336-1-arnd@kernel.org>
 <20260710211954.1373336-3-arnd@kernel.org>
Content-Language: en-US
From: Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <20260710211954.1373336-3-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Arnd,

On 11/7/26 07:19, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> linux/gpio.h should no longer be used, convert these instead to
> linux/gpio/legacy.h for coldfire.
> 
> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I have applied this one to the for-next branch of the m68knommu git tree.

Thanks
Greg


> ---
>   arch/m68k/coldfire/device.c     | 2 +-
>   arch/m68k/include/asm/mcfgpio.h | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/m68k/coldfire/device.c b/arch/m68k/coldfire/device.c
> index 1420bae0964f..9a0258acd998 100644
> --- a/arch/m68k/coldfire/device.c
> +++ b/arch/m68k/coldfire/device.c
> @@ -12,7 +12,7 @@
>   #include <linux/init.h>
>   #include <linux/io.h>
>   #include <linux/spi/spi.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/legacy.h>
>   #include <linux/fec.h>
>   #include <linux/dmaengine.h>
>   #include <asm/traps.h>
> diff --git a/arch/m68k/include/asm/mcfgpio.h b/arch/m68k/include/asm/mcfgpio.h
> index 7103cfa4edb6..29726aa40eb6 100644
> --- a/arch/m68k/include/asm/mcfgpio.h
> +++ b/arch/m68k/include/asm/mcfgpio.h
> @@ -16,7 +16,7 @@ int __mcfgpio_request(unsigned gpio);
>   void __mcfgpio_free(unsigned gpio);
>   
>   #ifdef CONFIG_GPIOLIB
> -#include <linux/gpio.h>
> +#include <linux/gpio/legacy.h>
>   #else
>   
>   /* our alternate 'gpiolib' functions */

