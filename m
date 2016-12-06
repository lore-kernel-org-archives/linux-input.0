From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 1/2] devicetree: i2c-hid: Add Wacom digitizer +
 regulator support
Date: Mon, 5 Dec 2016 16:16:32 -0800
Message-ID: <20161206001632.GA37573@dtor-ws>
References: <1480555288-142791-1-git-send-email-briannorris@chromium.org>
 <20161201143434.GD1280@mail.corp.redhat.com>
 <20161201172448.GA46688@google.com>
 <20161205235908.rmiyd7io4kddple6@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161205235908.rmiyd7io4kddple6@rob-hp-laptop>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Mon, Dec 05, 2016 at 05:59:08PM -0600, Rob Herring wrote:
> On Thu, Dec 01, 2016 at 09:24:50AM -0800, Brian Norris wrote:
> > Hi Benjamin and Rob,
> > 
> > On Thu, Dec 01, 2016 at 03:34:34PM +0100, Benjamin Tissoires wrote:
> > > On Nov 30 2016 or thereabouts, Brian Norris wrote:
> > > > From: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> > > > 
> > > > Add a compatible string and regulator property for Wacom W9103
> > > > digitizer. Its VDD supply may need to be enabled before using it.
> > > > 
> > > > Signed-off-by: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> > > > Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > > > Cc: Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > > > Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > > > Signed-off-by: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> > > > ---
> > > > v1 was a few months back. I finally got around to rewriting it based on
> > > > DT binding feedback.
> > > > 
> > > > v2:
> > > >  * add compatible property for wacom
> > > >  * name the regulator property specifically (VDD)
> > > > 
> > > >  Documentation/devicetree/bindings/input/hid-over-i2c.txt | 6 +++++-
> > > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/input/hid-over-i2c.txt b/Documentation/devicetree/bindings/input/hid-over-i2c.txt
> > > > index 488edcb264c4..eb98054e60c9 100644
> > > > --- a/Documentation/devicetree/bindings/input/hid-over-i2c.txt
> > > > +++ b/Documentation/devicetree/bindings/input/hid-over-i2c.txt
> > > > @@ -11,12 +11,16 @@ If this binding is used, the kernel module i2c-hid will handle the communication
> > > >  with the device and the generic hid core layer will handle the protocol.
> > > >  
> > > >  Required properties:
> > > > -- compatible: must be "hid-over-i2c"
> > > > +- compatible: must be "hid-over-i2c", or a device-specific string like:
> > > > +    * "wacom,w9013"
> > > 
> > > NACK on this one.
> > > 
> > > After re-reading the v1 submission I realized Rob asked for this change,
> > > but I strongly disagree.
> > > 
> > > HID over I2C is a generic protocol, in the same way HID over USB is. We
> > > can not start adding device specifics here, this is opening the can of
> > > worms. If the device is a HID one, nothing else should matter. The rest
> > > (description of the device, name, etc...) is all provided by the
> > > protocol.
> > 
> > I should have spoken up when Rob made the suggestion, because I more or
> > less agree with Benjamin here. I don't really see why this needs to have
> > a specialized compatible string, as the property is still fairly
> > generic, and the entire device handling is via a generic protocol. The
> > fact that we manage its power via a regulator is not very
> > device-specific.
> 
> It doesn't matter that the protocol is generic. The device attached and 
> the implementation is not. Implementations have been known to have 
> bugs/quirks (generally speaking, not HID over I2C in particular). There 
> are also things outside the scope of what is 'hid-over-i2c' like what's 
> needed to power-on the device which this patch clearly show.
> 
> This is no different than a panel attached via LVDS, eDP, etc., or 
> USB/PCIe device hard-wired on a board. They all use standard protocols 
> and all need additional data to describe them. Of course, adding a 
> single property for a delay would not be a big deal, but it's never 
> ending. Next you need multiple supplies, GPIO controls, mutiple 
> delays... This has been discussed to death already. As Thierry Reding 
> said, you're not special[1].
> 
> Now if you want to make 'hid-over-i2c' a fallback to 'wacom,w9013', I'm 
> fine with that.

So if I understand it correctly the only change is to have DTS specify

	compatible = "wacom,w9013", "hid-over-i2c";

and no actual changes to the driver itself with regard to the new
compatible string, correct?

I wonder what, besides breaking module autoload, this really buys us?

Thanks.

-- 
Dmitry
