From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH resend2] Input: usbtouchscreen - initialize eGalax devices
Date: Tue, 4 Sep 2012 23:07:04 -0700
Message-ID: <20120905060704.GC25962@core.coreip.homeip.net>
References: <20120903132648.GC11919@newmaster.mivlgu.local>
 <20120903173349.GA18666@alittletooquiet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120903173349.GA18666-B/PTSs0AgtP3p6jHtUh95NHuzzzSOjJt@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Forest Bond <forest-B/PTSs0AgtP3p6jHtUh95NHuzzzSOjJt@public.gmane.org>
Cc: Daniel Ritz <daniel.ritz-OI3hZJvNYWs@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Mon, Sep 03, 2012 at 01:33:50PM -0400, Forest Bond wrote:
> From: Forest Bond <forest.bond-XbHmxybg72Wcj+tRJgl41g@public.gmane.org>
> 
> Certain eGalax devices expose an interface with class HID and protocol
> None.  Some work with usbhid and some work with usbtouchscreen, but
> there is no easy way to differentiate.  Sending an eGalax diagnostic
> packet seems to kick them all into using the right protocol for
> usbtouchscreen, so we can continue to bind them all there (as opposed to
> handing some off to usbhid).
> 
> This fixes a regression for devices that were claimed by (and worked
> with) usbhid prior to commit 139ebe8dc80dd74cb2ac9f5603d18fbf5cff049f
> ("Input: usbtouchscreen - fix eGalax HID ignoring"), which made
> usbtouchscreen claim them instead.  With this patch they will still be
> claimed by usbtouchscreen, but they will actually report events
> usbtouchscreen can understand.  Note that these devices will be limited
> to the usbtouchscreen feature set so e.g. dual touch features are not
> supported.
> 
> I have the distinct pleasure of needing to support devices of both types
> and have tested accordingly.
> 
> Signed-off-by: Forest Bond <forest.bond-XbHmxybg72Wcj+tRJgl41g@public.gmane.org>

Applied, thank you Forest.

> ---
>  drivers/input/touchscreen/usbtouchscreen.c |   39 ++++++++++++++++++++++++++++
>  1 files changed, 39 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/touchscreen/usbtouchscreen.c
> index e32709e..c5f4dc0 100644
> --- a/drivers/input/touchscreen/usbtouchscreen.c
> +++ b/drivers/input/touchscreen/usbtouchscreen.c
> @@ -304,6 +304,44 @@ static int e2i_read_data(struct usbtouch_usb *dev, unsigned char *pkt)
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
> +	if (!buf)
> +		return -ENOMEM;
> +
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
> @@ -1056,6 +1094,7 @@ static struct usbtouch_device_info usbtouch_dev_info[] = {
>  		.process_pkt	= usbtouch_process_multi,
>  		.get_pkt_len	= egalax_get_pkt_len,
>  		.read_data	= egalax_read_data,
> +		.init		= egalax_init,
>  	},
>  #endif
>  
> -- 
> 1.7.0.4

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
