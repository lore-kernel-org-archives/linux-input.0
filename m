From: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 1/2] input: adc-keys: add DT binding documentation
Date: Mon, 4 Jul 2016 18:29:49 +0200
Message-ID: <20160704162949.GL20045@piout.net>
References: <1467408602-16546-1-git-send-email-alexandre.belloni@free-electrons.com>
 <5d71d3a2-4d51-8dd5-0e4a-638ec1b5035a@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5d71d3a2-4d51-8dd5-0e4a-638ec1b5035a-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 03/07/2016 at 14:43:56 +0100, Jonathan Cameron wrote :
> On 01/07/16 22:30, Alexandre Belloni wrote:
> > Add documentation for ADC keys
> > 
> > Signed-off-by: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> Clean looking binding to me - one comment inline.
> 
> Jonathan
> > ---
> > Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > 
> >  .../devicetree/bindings/input/adc-keys.txt         | 45 ++++++++++++++++++++++
> >  1 file changed, 45 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/input/adc-keys.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/input/adc-keys.txt b/Documentation/devicetree/bindings/input/adc-keys.txt
> > new file mode 100644
> > index 000000000000..873476bb4eab
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/input/adc-keys.txt
> > @@ -0,0 +1,45 @@
> > +Allwinner sun4i low res adc attached tablet keys
> What is allwinner specific in here?  Looks pretty general purpose to me!

That's true, I forgot to change that after shamelessly copy pasting...

I was planning to use something like ADC attached resistor ladder
buttons, unless you have a better way to describe that.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
