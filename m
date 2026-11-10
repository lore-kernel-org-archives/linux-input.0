Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794313533;
	b=myf9LpHz78mn06VUM9GfX++RTHklBJALeY+7/sTq/6p4lS3Q957p9hoLDycQUr9tc2m9
	 LbVFytoxvhVvSfKTEdui8X7bjSh/TrEAqXzGeve6OB4L5R8SAGi8ghyYZJfFuL/PxuT0F
	 5gv3+LgPKA2zibZ4ckqt4Ehjv9diNc4Uxm+UhMMidZHibgP5ilTOIPQESCtdW6+27q3kE
	 7VEpRQBeA7+DzZj/ThtSgpJZhWv2TR0Gj7fH3I9NLBchdi/W1yin8YUmrRMqOSWnb9Xc4
	 RWedDtYIf/NzkwtLwaFoNk6+u5bgvstQOQuk7qg1oAl4Y9ZP5faZ3ByoiW7OJjcsKBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794313533;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:From:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=o8vOqPjQp+qIgT4SjBM1vuuP9NkLzsqzq4almCwh0ns=;
	b=oFQ1RvRXS406PJsCj+QZ3nmxN4FQMJSwNxDmPp6y0MI4P1A5rNsJpOXT7zMx1yhYn1aW
	 Ci3fTwyfSCCcjN+Ib0ST0u4abDM9kFBhWClJP9SipalzSk5A4awWWuN7lSY3tKe0M7lR0
	 lCmQCCHc1ZiijrSbRRx8ph3E/tCsQd9NTnKuIuqMZ/rJifKpCus2ssalM55pkKz2k5pfZ
	 uZFaEt4ZE3VcWZP/K76qrRY1b5QDNC90wsSWaMCo4F5Tr5q+ymQQ+aI6waPkb+wOeHxaJ
	 Hte7eSR3a3y/++xAGCiYdTr2mYxDhyRQh6JRw8xK3vw6YIGSfCDJG2cCI2AJVW/+29A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gr5nohgX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9AC606A32A;
	Tue, 10 Nov 2026 12:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gr5nohgX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A651F008A2;
	Tue, 10 Nov 2026 12:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794313532;
	bh=o8vOqPjQp+qIgT4SjBM1vuuP9NkLzsqzq4almCwh0ns=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=Gr5nohgXHm1YYyj6tvLEZ2lSM8AwTngl7Y9YhcAEKBH+Qk95txebAZ9NtKzrDhbMu
	 /kcVhI4wBuCa61a001FzAROnBPqNtiO/ytzlzOWo7XJ5chQlrrTZ0jAur7hkGa2Dea
	 9e8VcncC+5ovHWHZPm9Udas/YhDeQJz+/Hw/DgiFOKQphYC3tCbIwtuUfnQDwnkr0A
	 NlkNf0d03csKo9TcHJmIS39u4zkv/CzH2xeQIMrUlC8N+o3OuHRReJJo3cYKVKlsnW
	 Ok7Bxat5Tx0PnCcbiQSm1rkYigOOsx53IhuLC4CVONUmhMnelBCuvRRROviPHPq5B4
	 hzmGl2iyPjB0A==
Message-ID: <69a3552e-1fca-49e9-a9c0-66963319d2a9@kernel.org>
Date: Tue, 10 Nov 2026 13:25:23 +0100
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: Re: [PATCH 03/14] mfd: remove unused si476x driver
To: Arnd Bergmann <arnd@kernel.org>, Lee Jones <lee@kernel.org>,
 mfd@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Arnd Bergmann <arnd@arndb.de>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek
 <pavel@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>,
 Support Opensource <support.opensource@diasemi.com>,
 Sebastian Reichel <sre@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
 patches@opensource.cirrus.com, linux-watchdog@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-sound@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, llvm@lists.linux.dev
References: <20260909132153.1596191-1-arnd@kernel.org>
 <20260909132153.1596191-4-arnd@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20260909132153.1596191-4-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/09/2026 15:21, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The si476x driver was added in linux-3.9 without devicetree
> support, and has always failed the probe function in the
> absence of a si476x_platform_data definition.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

For drivers/media/radio, include/media/drv-intf/si476x.h,
Documentation/admin-guide/media and include/uapi/linux/v4l2-controls.h:

Acked-by: Hans Verkuil <hverkuil+cisco@kernel.org>

Regards,

	Hans

> ---
>  .../admin-guide/media/radio-cardlist.rst      |    1 -
>  Documentation/admin-guide/media/si476x.rst    |  160 --
>  .../admin-guide/media/v4l-drivers.rst         |    1 -
>  drivers/media/radio/Kconfig                   |   17 -
>  drivers/media/radio/Makefile                  |    1 -
>  drivers/media/radio/radio-si476x.c            | 1523 ----------------
>  drivers/mfd/Kconfig                           |   13 -
>  drivers/mfd/Makefile                          |    3 -
>  drivers/mfd/si476x-cmd.c                      | 1543 -----------------
>  drivers/mfd/si476x-i2c.c                      |  861 ---------
>  drivers/mfd/si476x-prop.c                     |  233 ---
>  include/linux/mfd/si476x-core.h               |  532 ------
>  include/linux/mfd/si476x-platform.h           |  256 ---
>  include/linux/mfd/si476x-reports.h            |  154 --
>  include/media/drv-intf/si476x.h               |   28 -
>  include/uapi/linux/v4l2-controls.h            |    4 +-
>  sound/soc/codecs/Kconfig                      |    5 -
>  sound/soc/codecs/Makefile                     |    2 -
>  sound/soc/codecs/si476x.c                     |  263 ---
>  sound/soc/fsl/fsl-asoc-card.c                 |    8 -
>  20 files changed, 2 insertions(+), 5606 deletions(-)
>  delete mode 100644 Documentation/admin-guide/media/si476x.rst
>  delete mode 100644 drivers/media/radio/radio-si476x.c
>  delete mode 100644 drivers/mfd/si476x-cmd.c
>  delete mode 100644 drivers/mfd/si476x-i2c.c
>  delete mode 100644 drivers/mfd/si476x-prop.c
>  delete mode 100644 include/linux/mfd/si476x-core.h
>  delete mode 100644 include/linux/mfd/si476x-platform.h
>  delete mode 100644 include/linux/mfd/si476x-reports.h
>  delete mode 100644 include/media/drv-intf/si476x.h
>  delete mode 100644 sound/soc/codecs/si476x.c
> 
