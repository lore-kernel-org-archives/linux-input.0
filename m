From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 3/4] leds: Let the binding document example for
 leds-gpio follow the gpio bindings
Date: Mon, 2 Mar 2015 12:24:43 +0100
Message-ID: <CACRpkdZGXQ0ktwLu80ALaQuwB_RFQjpHitiEp+vcnnb0Hv1mKg@mail.gmail.com>
References: <1421876028-22799-1-git-send-email-o.schinagl@ultimaker.com>
	<1421876028-22799-4-git-send-email-o.schinagl@ultimaker.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <1421876028-22799-4-git-send-email-o.schinagl@ultimaker.com>
Sender: linux-leds-owner@vger.kernel.org
To: Olliver Schinagl <o.schinagl@ultimaker.com>, Bryan Wu <cooloney@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Olliver Schinagl <oliver@schinagl.nl>, Robin Gong <b38343@freescale.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Aaron Lu <aaron.lu@intel.com>, Grant Likely <grant.likely@linaro.org>, Jingoo Han <jg1.han@samsung.com>, Alexander Shiyan <shc_work@mail.ru>, Wolfram Sang <wsa@the-dreams.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, "linux-leds@vger.kernel.org" <linux-leds@vger.ke>
List-Id: linux-input@vger.kernel.org

On Wed, Jan 21, 2015 at 10:33 PM, Olliver Schinagl
<o.schinagl@ultimaker.com> wrote:

> From: Olliver Schinagl <oliver@schinagl.nl>
>
> In the gpio bindings documents it is requested to use the marco's in
> include/dt-bindings/gpio/gpio.h whenever possible. The gpios in the led
> drivers don't seem to form an exception, so update the example in the
> document bindings.
>
> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> Acked-by: Rob Herring <robh@kernel.org>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Bryan: please merge this patch to the LED git tree.

Yours,
Linus Walleij
