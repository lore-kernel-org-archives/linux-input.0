From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] Input: add STMicroelectronics FingerTip touchscreen
 driver
Date: Tue, 17 Jan 2017 12:47:11 -0800
Message-ID: <20170117204711.GB6888@dtor-ws>
References: <20170117135441.31450-1-andi.shyti@samsung.com>
 <CGME20170117135456epcas5p2e303f0c5fa642b43fde543d5d6098dc2@epcas5p2.samsung.com>
 <20170117135441.31450-2-andi.shyti@samsung.com>
 <20170117184332.6ne4ercemll6qrbm@kozik-lap>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170117184332.6ne4ercemll6qrbm@kozik-lap>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andi Shyti <andi.shyti@samsung.com>, Rob Herring <robh+dt@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Andi Shyti <andi@etezian.org>
List-Id: linux-input@vger.kernel.org

On Tue, Jan 17, 2017 at 08:43:32PM +0200, Krzysztof Kozlowski wrote:
> On Tue, Jan 17, 2017 at 10:54:39PM +0900, Andi Shyti wrote:
> > Add binding for the STMicroelectronics FingerTip (stmfts)
> > touchscreen driver.
> > 
> > Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> > ---
> >  .../bindings/input/touchscreen/st,stmfts.txt       | 43 ++++++++++++++++++++++
> >  1 file changed, 43 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/st,stmfts.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/input/touchscreen/st,stmfts.txt b/Documentation/devicetree/bindings/input/touchscreen/st,stmfts.txt
> > new file mode 100644
> > index 000000000000..788f4ba744db
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/input/touchscreen/st,stmfts.txt
> > @@ -0,0 +1,43 @@
> > +* ST-Microelectronics FingerTip touchscreen controller
> > +
> > +The ST-Microelectronics FingerTip device provides a basic touchscreen
> > +functionality. Along with it the user can enable the touchkey which can work as
> > +a basic HOME and BACK key for phones.
> > +
> > +The driver supports also hovering as an absolute single touch event with x, y, z
> > +coordinates.
> > +
> > +Required properties:
> > +- compatible		: must be "st,stmfts"
> > +- reg			: I2C slave address, (e.g. 0x49)
> > +- interrupt-parent	: the phandle to the interrupt controller which provides
> > +			  the interrupt
> > +- interrupts		: interrupt specification
> > +- avdd-supply		: analogic power supply
> > +- vdd-supply		: power supply
> > +- touchscreen-size-x	: see touchscreen.txt
> > +- touchscreen-size-y	: see touchscreen.txt
> > +
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

Also, is this really a regulator? Given you are testing whether it is on
or off to report LED state it feels to me it might be a GPIO pin, not
regulator...

Thanks.

-- 
Dmitry
