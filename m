From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Input: usbtouchscreen - initialize eGalax devices
Date: Fri, 31 Aug 2012 16:10:47 -0700
Message-ID: <20120831231047.GA22142@core.coreip.homeip.net>
References: <20120831192632.GA30202@core.coreip.homeip.net>
 <Pine.LNX.4.44L0.1208311555140.1328-100000@iolanthe.rowland.org>
 <20120831225353.GE24820@alittletooquiet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120831225353.GE24820-B/PTSs0AgtP3p6jHtUh95NHuzzzSOjJt@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Forest Bond <forest-B/PTSs0AgtP3p6jHtUh95NHuzzzSOjJt@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>, Daniel Ritz <daniel.ritz-OI3hZJvNYWs@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Fri, Aug 31, 2012 at 06:53:53PM -0400, Forest Bond wrote:
> Hi,
> 
> On Fri, Aug 31, 2012 at 04:04:58PM -0400, Alan Stern wrote:
> > On Fri, 31 Aug 2012, Dmitry Torokhov wrote:
> > 
> > > > > +		/* Send a "check active" packet. The response will be read
> > > > > +		 * later and ignored. */
> > > > > +		ret = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
> > > > > +				      0,
> > > > > +				      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
> > > > > +				      0, 0, "\x0A\x01A", 0,
> > > > 
> > > >    You probably can't send data from the .const section (as well as off the
> > > > stack) -- they can be DMA'ed and there'll be issues with cache consistency on
> > > > non-x86 arches. You should allocate the data with kmalloc().
> > > >    Although, on the second thought, maybe I'm wrong in this case... not really
> > > > sure about sending -- receiving (to the .data section) could certainly be harmful...
> > > 
> > > Hmm, do we actually send anything here? The "size" passed to
> > > usb_control_msg() is 0 so I don't think we use that data at all...
> > 
> > Good point.  Perhaps the 0 is a typo, in which case data does get sent
> > and the buffer must be kmalloc'ed.  If the 0 is correct then the buffer
> > should be NULL, not "\x0A\x01A" (and what's the purpose of the leading
> > '0' in the second byte?).
> > 
> > In addition, although the bRequestType specifies USB_DIR_OUT, the pipe
> > value is usb_rcvctrlpipe.  Is this transfer meant to be IN or OUT?
> 
> Thanks again to all for the review.  My theory for why the previous patch worked
> in spite of its wrongness is that the device actually switches modes when it
> receives a control message with USB_TYPE_VENDOR even though the documentation
> suggests an actual diagnostic packet must be received.
> 
> Does this (untested) patch look more reasonable?

Yes, but we still need it tested, please.

> 
> 
> diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/touchscreen/usbtouchscreen.c
> index e32709e..64b4b17 100644
> --- a/drivers/input/touchscreen/usbtouchscreen.c
> +++ b/drivers/input/touchscreen/usbtouchscreen.c
> @@ -304,6 +304,41 @@ static int e2i_read_data(struct usbtouch_usb *dev, unsigned char *pkt)
>  #define EGALAX_PKT_TYPE_REPT		0x80
>  #define EGALAX_PKT_TYPE_DIAG		0x0A
>  
> +static int egalax_init(struct usbtouch_usb *usbtouch)
> +{
> +	int ret, i;
> +	unsigned char *buf;
> +	struct usb_device *udev = interface_to_usbdev(usbtouch->interface);
> +
> +	/* An eGalax diagnostic packet kicks the device into using the right
> +	 * protocol.  We send a "check active" packet.  The response will be
> +	 * read later and ignored.
> +	 */
> +
> +	buf = kmalloc(3, GFP_KERNEL);
> +	buf[0] = EGALAX_PKT_TYPE_DIAG;
> +	buf[1] = 1;	/* length */
> +	buf[2] = 'A';	/* command - check active */
> +
> +	for (i = 0; i < 3; i++) {
> +		ret = usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
> +				      0,
> +				      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
> +				      0, 0, buf, 3,
> +				      USB_CTRL_SET_TIMEOUT);
> +		if (ret >= 0) {
> +			ret = 0;
> +			break;
> +		}
> +		if (ret != -EPIPE)
> +			break;
> +	}
> +
> +	kfree(buf);
> +
> +	return ret;
> +}
> +
>  static int egalax_read_data(struct usbtouch_usb *dev, unsigned char *pkt)
>  {
>  	if ((pkt[0] & EGALAX_PKT_TYPE_MASK) != EGALAX_PKT_TYPE_REPT)
> @@ -1056,6 +1091,7 @@ static struct usbtouch_device_info usbtouch_dev_info[] = {
>  		.process_pkt	= usbtouch_process_multi,
>  		.get_pkt_len	= egalax_get_pkt_len,
>  		.read_data	= egalax_read_data,
> +		.init		= egalax_init,
>  	},
>  #endif
>  
> 
> Thanks,
> Forest
> -- 
> Forest Bond
> http://www.alittletooquiet.net
> http://www.rapidrollout.com



-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
