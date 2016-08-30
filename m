From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6] input: add ADC resistor ladder driver
Date: Mon, 29 Aug 2016 20:00:34 -0700
Message-ID: <20160830030034.GA2150@dtor-ws>
References: <1471954696-11897-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20160829003328.GA19426@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160829003328.GA19426@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Sun, Aug 28, 2016 at 07:33:28PM -0500, Rob Herring wrote:
> On Tue, Aug 23, 2016 at 02:18:16PM +0200, Alexandre Belloni wrote:
> > A common way of multiplexing buttons on a single input in cheap devices is
> > to use a resistor ladder on an ADC. This driver supports that configuration
> > by polling an ADC channel provided by IIO.
> > 
> > Acked-by: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > Signed-off-by: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> > ---
> > Changes in v6:
> >  - switched to microvolts
> > 
> > Changes in v5:
> >  - Dmitry's changes
> >  - s/mvolt/millivolt/
> > 
> > 
> >  .../devicetree/bindings/input/adc-keys.txt         |  49 +++++
> 
> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Applied, thank you.

> 
> >  drivers/input/keyboard/Kconfig                     |  15 ++
> >  drivers/input/keyboard/Makefile                    |   1 +
> >  drivers/input/keyboard/adc-keys.c                  | 210 +++++++++++++++++++++
> >  4 files changed, 275 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/input/adc-keys.txt
> >  create mode 100644 drivers/input/keyboard/adc-keys.c

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
