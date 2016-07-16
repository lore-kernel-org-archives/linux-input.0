From: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v4 1/2] input: adc-keys: add DT binding documentation
Date: Sun, 17 Jul 2016 00:41:27 +0200
Message-ID: <20160716224127.GB22202@piout.net>
References: <1468352186-14190-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20160716221139.GA3751@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160716221139.GA3751@rob-hp-laptop>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 16/07/2016 at 17:11:39 -0500, Rob Herring wrote :
> On Tue, Jul 12, 2016 at 09:36:25PM +0200, Alexandre Belloni wrote:
> > Add documentation for ADC keys
> > 
> > Signed-off-by: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> > ---
> > Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > 
> > Changes v2..v4:
> >  - Documented autorepeat and poll-interval
> > 
> > 
> >  .../devicetree/bindings/input/adc-keys.txt         | 50 ++++++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/input/adc-keys.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/input/adc-keys.txt b/Documentation/devicetree/bindings/input/adc-keys.txt
> > new file mode 100644
> > index 000000000000..6f26ad75ed2b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/input/adc-keys.txt
> > @@ -0,0 +1,50 @@
> > +ADC attached resistor ladder buttons
> > +------------------------------------
> > +
> > +Required properties:
> > + - compatible: "adc-keys"
> > + - io-channels: Phandle to an ADC channel
> > + - io-channel-names = "buttons";
> > + - keyup-threshold-mvolt: Voltage at which all the keys are considered up.
> 
> '-microvolt' is the standard suffix.
> 

Actually, it is milli volts. I wouls have use uvolt for microvolt.
Should I change that for '-millivolt'?

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
