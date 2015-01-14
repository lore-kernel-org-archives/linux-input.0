From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/4] gpio:gpiolib: use static const char const * for a
 suffixes array
Date: Wed, 14 Jan 2015 13:35:12 +0100
Message-ID: <CACRpkdYyaK5JjXEwJxzLgd_-0ccTjb1wEFxVUSdLsppcmTMDoA@mail.gmail.com>
References: <1420621722-7428-1-git-send-email-oliver+list@schinagl.nl>
	<1420621722-7428-2-git-send-email-oliver+list@schinagl.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:61815 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752020AbbANMfM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Jan 2015 07:35:12 -0500
Received: by mail-ie0-f178.google.com with SMTP id vy18so8433048iec.9
        for <linux-input@vger.kernel.org>; Wed, 14 Jan 2015 04:35:12 -0800 (PST)
In-Reply-To: <1420621722-7428-2-git-send-email-oliver+list@schinagl.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Olliver Schinagl <oliver+list@schinagl.nl>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Olliver Schinagl <oliver@schinagl.nl>, Robin Gong <b38343@freescale.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Aaron Lu <aaron.lu@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Grant Likely <grant.likely@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Alexander Shiyan <shc_work@mail.ru>, Jingoo Han <jg1.han@samsung.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux

On Wed, Jan 7, 2015 at 10:08 AM, Olliver Schinagl
<oliver+list@schinagl.nl> wrote:

> From: Olliver Schinagl <oliver@schinagl.nl>
>
> Checkpatch complains, and probably with good reason that we should use
> const char const * for the static constant array that never gets
> changed.
>
> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>

Patch applied.

Yours,
Linus Walleij
