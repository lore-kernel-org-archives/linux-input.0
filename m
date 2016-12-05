From: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2 1/2] devicetree: i2c-hid: Add Wacom digitizer +
 regulator support
Date: Mon, 5 Dec 2016 15:54:09 -0800
Message-ID: <20161205235409.GA86586@google.com>
References: <1480555288-142791-1-git-send-email-briannorris@chromium.org>
 <20161205234248.tqnpruk442n4lgs5@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161205234248.tqnpruk442n4lgs5@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Rob,

On Mon, Dec 05, 2016 at 05:42:48PM -0600, Rob Herring wrote:
> On Wed, Nov 30, 2016 at 05:21:27PM -0800, Brian Norris wrote:
> > From: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> > 
> > Add a compatible string and regulator property for Wacom W9103
> > digitizer. Its VDD supply may need to be enabled before using it.
> > 
> > Signed-off-by: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> > Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > Cc: Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > Signed-off-by: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> > ---
> > v1 was a few months back. I finally got around to rewriting it based on
> > DT binding feedback.
> > 
> > v2:
> >  * add compatible property for wacom
> >  * name the regulator property specifically (VDD)
> > 
> >  Documentation/devicetree/bindings/input/hid-over-i2c.txt | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Thanks but (unfortunately) there've been 2 new versions since then.
Specifically, Benjamin NACK'ed this patch and requested we NOT include
device/manufacturer-specific compatible properties here. In fact, the
binding is still rather generic and IMO (and in Benjamin's opinion)
doesn't really need to be restricted to a specific device.

Please consider reviewing Benjamin's requests and my recent changes.
Benjamin has one small remaining comment on v4, and I plan to send the
5th (and final?) version once I'm confident you and Benjamin agree :)

Thanks,
Brian
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
