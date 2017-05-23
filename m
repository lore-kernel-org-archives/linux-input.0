From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] input: edt-ft5x06: increase allowed data range for
 threshold parameter
Date: Mon, 22 May 2017 17:20:07 -0700
Message-ID: <20170523002007.GE12016@dtor-ws>
References: <1493737259-26210-1-git-send-email-martin.kepplinger@ginzinger.com>
 <20170508161146.vkmaohiesjd6e6vq@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170508161146.vkmaohiesjd6e6vq@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Martin Kepplinger <martin.kepplinger-hfTNJOUbDMh54TAoqtyWWQ@public.gmane.org>, simon.budig-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org, daniel.wagener-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org, mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Schoefegger Stefan <stefan.schoefegger-hfTNJOUbDMh54TAoqtyWWQ@public.gmane.org>, Manfred Schlaegl <manfred.schlaegl-hfTNJOUbDMh54TAoqtyWWQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Mon, May 08, 2017 at 11:11:46AM -0500, Rob Herring wrote:
> On Tue, May 02, 2017 at 05:00:59PM +0200, Martin Kepplinger wrote:
> > The datasheet and application note does not mention an allowed range for
> > the M09_REGISTER_THRESHOLD parameter. One of our customers needs to set
> > lower values than 20 and they seem to work just fine on EDT EP0xx0M09 with
> > T5x06 touch.
> > 
> > So, lacking a known lower limit, we increase the range for thresholds,
> > and set the lower limit to 0. The documentation is updated accordingly.
> > 
> > Signed-off-by: Schoefegger Stefan <stefan.schoefegger-hfTNJOUbDMh54TAoqtyWWQ@public.gmane.org>
> > Signed-off-by: Manfred Schlaegl <manfred.schlaegl-hfTNJOUbDMh54TAoqtyWWQ@public.gmane.org>
> > Signed-off-by: Martin Kepplinger <martin.kepplinger-hfTNJOUbDMh54TAoqtyWWQ@public.gmane.org>
> > ---
> >  Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt | 2 +-
> >  Documentation/input/devices/edt-ft5x06.rst                         | 2 +-
> >  drivers/input/touchscreen/edt-ft5x06.c                             | 2 +-
> >  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Applied, thank you.


-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
