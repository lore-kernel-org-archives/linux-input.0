From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 1/4] gpio: use sizeof() instead of hardcoded values
Date: Fri, 30 Jan 2015 14:43:30 +0100
Message-ID: <CACRpkdZHoeO1+mOhBh01i4D1KOCn2KAJO7v+UBQnHOXbZY_QKQ@mail.gmail.com>
References: <1421876028-22799-1-git-send-email-o.schinagl@ultimaker.com>
	<1421876028-22799-2-git-send-email-o.schinagl@ultimaker.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:61007 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753422AbbA3Nna (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Jan 2015 08:43:30 -0500
Received: by mail-ig0-f181.google.com with SMTP id hn18so2884541igb.2
        for <linux-input@vger.kernel.org>; Fri, 30 Jan 2015 05:43:30 -0800 (PST)
In-Reply-To: <1421876028-22799-2-git-send-email-o.schinagl@ultimaker.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Olliver Schinagl <o.schinagl@ultimaker.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Olliver Schinagl <oliver@schinagl.nl>, Robin Gong <b38343@freescale.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Aaron Lu <aaron.lu@intel.com>, Grant Likely <grant.likely@linaro.org>, Jingoo Han <jg1.han@samsung.com>, Alexander Shiyan <shc_work@mail.ru>, Wolfram Sang <wsa@the-dreams.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, linux-leds@vger

On Wed, Jan 21, 2015 at 10:33 PM, Olliver Schinagl
<o.schinagl@ultimaker.com> wrote:

> From: Olliver Schinagl <oliver@schinagl.nl>
>
> gpiolib uses a fixed string for the suffixes and defines it at 32 bytes.
> Later in the code snprintf is used with this fixed value of 32. Using
> sizeof() is safer in case the size for the suffixes is ever changed.
>
> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>

OK looks nice.

Patch applied.

Yours,
Linus Walleij
