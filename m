From: Andi Shyti <andi.shyti@samsung.com>
Subject: Re: [PATCH 1/3] Input: add STMicroelectronics FingerTip touchscreen
 driver
Date: Wed, 18 Jan 2017 10:12:48 +0900
Message-ID: <20170118011248.6wlcog5r4jkgaat4@gangnam.samsung>
References: <20170117135441.31450-1-andi.shyti@samsung.com>
 <CGME20170117135456epcas5p2e303f0c5fa642b43fde543d5d6098dc2@epcas5p2.samsung.com>
 <20170117135441.31450-2-andi.shyti@samsung.com>
 <20170117184332.6ne4ercemll6qrbm@kozik-lap>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-disposition: inline
In-reply-to: <20170117184332.6ne4ercemll6qrbm@kozik-lap>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Andi Shyti <andi@etezian.org>
List-Id: linux-input@vger.kernel.org

Hi Krzysztof,

> > +Optional properties:
> > +- touch-key-connected	: specifies whether the touchkey feature is connected
> 
> You are making it a generic property but it is specific to this device,
> so:
> 	st,touch-key-connected
> ?
> 
> > +- ledvdd-supply		: power supply to the touch key leds
> 
> Is this really optional? If yes... how it gets the power when not
> provided?

yes, it is. This is required only if (st,)touch-key-connected is
added, it's not required in any other case. Anyway, even if not
present, the device works, just without leds, which is fine for
me.

Thanks,
Andi
