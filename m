From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 2/4] gpio: add parameter to allow the use named gpios
Date: Fri, 30 Jan 2015 14:22:04 -0800
Message-ID: <20150130222204.GA23203@dtor-ws>
References: <1421876028-22799-1-git-send-email-o.schinagl@ultimaker.com>
 <1421876028-22799-3-git-send-email-o.schinagl@ultimaker.com>
 <CACRpkdbywy3Nrg+d8YAGTYH_Z-AB=UDB7zyq85rD8WoCwAk5eA@mail.gmail.com>
 <CAK5ve-KqC2gojeFx_hSwR6Riv1YPkhO49eqaa2bOxVhChLDtXw@mail.gmail.com>
 <20150130221600.GB11695@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:46851 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752558AbbA3WWK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Jan 2015 17:22:10 -0500
Content-Disposition: inline
In-Reply-To: <20150130221600.GB11695@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bryan Wu <cooloney@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Olliver Schinagl <o.schinagl@ultimaker.com>, Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Richard Purdie <rpurdie@rpsys.net>, Olliver Schinagl <oliver@schinagl.nl>, Robin Gong <b38343@freescale.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Aaron Lu <aaron.lu@intel.com>, Grant Likely <grant.likely@linaro.org>, Jingoo Han <jg1.han@samsung.com>, Alexander Shiyan <shc_work@mail.ru>, Wolfram Sang <wsa@the-dreams.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>lin

On Fri, Jan 30, 2015 at 02:16:00PM -0800, Dmitry Torokhov wrote:
> On Fri, Jan 30, 2015 at 11:12:53AM -0800, Bryan Wu wrote:
> > On Fri, Jan 30, 2015 at 5:46 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> > > On Wed, Jan 21, 2015 at 10:33 PM, Olliver Schinagl
> > > <o.schinagl@ultimaker.com> wrote:
> > >
> > >> From: Olliver Schinagl <oliver@schinagl.nl>
> > >>
> > >> The gpio binding document says that new code should always use named
> > >> gpios. Patch 40b73183 added support to parse a list of gpios from child
> > >> nodes, but does not make it possible to use named gpios. This patch adds
> > >> the con_id property and implements it is done in gpiolib.c, where the
> > >> old-style of using unnamed gpios still works.
> > >>
> > >> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> > >> ---
> > >>  drivers/gpio/devres.c                     | 18 +++++++++++++++++-
> > >>  drivers/input/keyboard/gpio_keys_polled.c |  2 +-
> > >>  drivers/leds/leds-gpio.c                  |  2 +-
> > >>  include/linux/gpio/consumer.h             |  1 +
> > >
> > > Alexandre: does this match your vision of how it should work, i.e. ACK?
> > >
> > > Bryan/Dmitry: can you ACK the oneliners in your subsystems?
> > 
> > Sure, please take my Ack
> > Acked-by: Bryan Wu <cooloney@gmail.com>
> 
> Mine as well:
> 
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Forgot to mention: the ack is for this patch only; the patch #4 is
NAKed because:

1. The logic of handling old and new name AFAICS is broken and
2. gpio_keys_polled-gpios as name is plain ugly.

Thanks.

-- 
Dmitry
