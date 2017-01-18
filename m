From: Andi Shyti <andi.shyti@samsung.com>
Subject: Re: [PATCH 1/3] Input: add STMicroelectronics FingerTip touchscreen
 driver
Date: Wed, 18 Jan 2017 10:16:39 +0900
Message-ID: <20170118011639.rkhaoh7xkh2szju3@gangnam.samsung>
References: <20170117135441.31450-1-andi.shyti@samsung.com>
 <CGME20170117135456epcas5p2e303f0c5fa642b43fde543d5d6098dc2@epcas5p2.samsung.com>
 <20170117135441.31450-2-andi.shyti@samsung.com>
 <20170117184332.6ne4ercemll6qrbm@kozik-lap> <20170117204711.GB6888@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-disposition: inline
In-reply-to: <20170117204711.GB6888@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh+dt@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Andi Shyti <andi@etezian.org>
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

> > > +- ledvdd-supply		: power supply to the touch key leds
> > 
> > Is this really optional? If yes... how it gets the power when not
> > provided?
> 
> Also, is this really a regulator? Given you are testing whether it is on
> or off to report LED state it feels to me it might be a GPIO pin, not
> regulator...

In this case it's a real regulator, not a GPIO. But even if it
was a GPIO, I still could use gpio-regulator[*] which handles
gpio using the regulator framework. In this case, depending on
how the leds are enabled on the DTS, in the driver I would use
only one api (regulators indeed) for both the cases.

Thanks,
Andi

[*] Documentation/devicetree/bindings/regulator/gpio-regulator.txt
