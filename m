From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: usbtouchscreen - initialize eGalax devices
Date: Fri, 31 Aug 2012 12:26:32 -0700
Message-ID: <20120831192632.GA30202@core.coreip.homeip.net>
References: <20120831135658.GC24820@alittletooquiet.net>
 <5041077E.8070405@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:35301 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754678Ab2HaT0i (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 31 Aug 2012 15:26:38 -0400
Content-Disposition: inline
In-Reply-To: <5041077E.8070405@mvista.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Forest Bond <forest@alittletooquiet.net>, Daniel Ritz <daniel.ritz@gmx.ch>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org

On Fri, Aug 31, 2012 at 10:50:38PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 08/31/2012 05:56 PM, Forest Bond wrote:
> 
> > From: Forest Bond <forest.bond@rapidrollout.com>
> 
> > Certain eGalax devices expose an interface with class HID and protocol
> > None.  Some work with usbhid and some work with usbtouchscreen, but
> > there is no easy way to differentiate.  Sending an eGalax diagnostic
> > packet seems to kick them all into using the right protocol for
> > usbtouchscreen, so we can continue to bind them all there (as opposed to
> > handing some off to usbhid).
> 
> > This fixes a regression for devices that were claimed by (and worked
> > with) usbhid prior to commit 139ebe8dc80dd74cb2ac9f5603d18fbf5cff049f,
> 
>    Please also specify that commit's summary ion parens.
> 
> > which made usbtouchscreen claim them instead.  With this patch they will
> > still be claimed by usbtouchscreen, but they will actually report events
> > usbtouchscreen can understand.  Note that these devices will be limited
> > to the usbtouchscreen feature set so e.g. dual touch features are not
> > supported.
> 
> > I have the distinct pleasure of needing to support devices of both types
> > and have tested accordingly.
> 
> > Signed-off-by: Forest Bond <forest.bond@rapidrollout.com>
> > ---
> >  drivers/input/touchscreen/usbtouchscreen.c |   25 +++++++++++++++++++++++++
> >  1 files changed, 25 insertions(+), 0 deletions(-)
> 
> > diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/touchscreen/usbtouchscreen.c
> > index e32709e..2ce5308 100644
> > --- a/drivers/input/touchscreen/usbtouchscreen.c
> > +++ b/drivers/input/touchscreen/usbtouchscreen.c
> > @@ -304,6 +304,30 @@ static int e2i_read_data(struct usbtouch_usb *dev, unsigned char *pkt)
> >  #define EGALAX_PKT_TYPE_REPT		0x80
> >  #define EGALAX_PKT_TYPE_DIAG		0x0A
> >  
> > +static int egalax_init(struct usbtouch_usb *usbtouch)
> > +{
> > +	int ret, i;
> > +	struct usb_device *udev = interface_to_usbdev(usbtouch->interface);
> > +
> > +	/* An eGalax diagnostic packet kicks the device into using the right
> > +	 * protocol. */
> 
>    The preferred multi-line comment style is:
> 
> /*
>  * bla
>  * bla
>  */
> 
> > +	for (i = 0; i < 3; i++) {
> > +		/* Send a "check active" packet. The response will be read
> > +		 * later and ignored. */
> > +		ret = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
> > +				      0,
> > +				      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
> > +				      0, 0, "\x0A\x01A", 0,
> 
>    You probably can't send data from the .const section (as well as off the
> stack) -- they can be DMA'ed and there'll be issues with cache consistency on
> non-x86 arches. You should allocate the data with kmalloc().
>    Although, on the second thought, maybe I'm wrong in this case... not really
> sure about sending -- receiving (to the .data section) could certainly be harmful...

Hmm, do we actually send anything here? The "size" passed to
usb_control_msg() is 0 so I don't think we use that data at all...

Thanks.

-- 
Dmitry
