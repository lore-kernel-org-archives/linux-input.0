From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] input: touchscreen: ar1021_i2c: add support for
 AR1020
Date: Thu, 13 Apr 2017 15:35:32 -0500
Message-ID: <20170413203532.thktt4yhqsg34cvc@rob-hp-laptop>
References: <1491906479-17639-1-git-send-email-martin.kepplinger@ginzinger.com>
 <20170412154054.GB6297@dtor-ws>
 <fd7e784f-824c-1fff-4978-858c11971999@ginzinger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <fd7e784f-824c-1fff-4978-858c11971999-hfTNJOUbDMh54TAoqtyWWQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Kepplinger <martin.kepplinger-hfTNJOUbDMh54TAoqtyWWQ@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Thu, Apr 13, 2017 at 08:38:39AM +0200, Martin Kepplinger wrote:
> 
> 
> On 2017-04-12 17:40, Dmitry Torokhov wrote:
> > Hi Martin,
> > 
> > On Tue, Apr 11, 2017 at 12:27:57PM +0200, Martin Kepplinger wrote:
> >> ar1021_i2c simply also supports the ar1020 device we use. This is tested.
> >> They also share the same datasheet:
> >>
> >>    http://ww1.microchip.com/downloads/en/DeviceDoc/40001393C.pdf
> >>
> >> We differentiate not only to make it obvious that we support both devices,
> >> but also to be able to implement the few model specific things in the
> >> future.

[...]

> > 
> > I do not see where you handle ar1020 differently from ar1021. If devices
> > are compatible, you do not need to add a new compatible to the driver,
> > simply use it in the binding:
> > 
> > 	compatible = "microchip,ar1020-i2c", "microchip,ar1021-i2c";
> > 
> > Thanks.
> > 
> 
> Why would you use "microchip,ar1020-i2c" in the dts if it's not
> available? people don't obviously see, by grepping or reading,
> that they have a compatible driver. ... or did I get you wrong?
> 
> I don't handle anything differently now. Factory reset has to be done
> differntly though, as one example. So it'd be nice to have the option
> to add data.

Having both lets you use the current driver now and you can match on the 
more specific compatible string when and if you need to. That's exactly 
why we have multiple compatibles. I could imagine the driver never 
supports factory reset. Add both to comments or kconfig help if you want 
to make it clear that both devices are supported.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
