From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: usbtouchscreen: support bigger iNexio touchscreens
Date: Tue, 16 Mar 2010 14:26:15 +0100 (CET)
Message-ID: <alpine.LRH.2.00.1003161425480.26353@twin.jikos.cz>
References: <201003161423.54495.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201003161423.54495.linux-ZCIryABCsrmttCpgsWEBFmD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ondrej Zary <linux-ZCIryABCsrmttCpgsWEBFmD2FQJk+8+b@public.gmane.org>
Cc: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, daniel.ritz-OI3hZJvNYWs@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org


[ adding some more relevant CCs ]

On Tue, 16 Mar 2010, Ondrej Zary wrote:

> Bigger Nexio touchscreens not only send more data but also the header values
> are modified somehow. Fix the header somehow (it's a guesswork but it works
> at least on one 46" touchscreen with 2.00SMS firmware) and also increase
> rept_size.
> 
> Signed-off-by: Ondrej Zary <linux-ZCIryABCsrmttCpgsWEBFmD2FQJk+8+b@public.gmane.org>
> 
> --- linux-2.6.34-rc1-orig/drivers/input/touchscreen/usbtouchscreen.c	2010-03-16 13:34:51.000000000 +0100
> +++ linux-2.6.34-rc1/drivers/input/touchscreen/usbtouchscreen.c	2010-03-16 13:46:15.000000000 +0100
> @@ -858,6 +858,11 @@
>  	if ((pkt[0] & 0xe0) != 0xe0)
>  		return 0;
>  
> +	if (be16_to_cpu(packet->data_len) > 0xff)
> +		packet->data_len = cpu_to_be16(be16_to_cpu(packet->data_len) - 0x100);
> +	if (be16_to_cpu(packet->x_len) > 0xff)
> +		packet->x_len = cpu_to_be16(be16_to_cpu(packet->x_len) - 0x80);
> +
>  	/* send ACK */
>  	ret = usb_submit_urb(priv->ack, GFP_ATOMIC);
>  
> @@ -1113,7 +1118,7 @@
>  
>  #ifdef CONFIG_TOUCHSCREEN_USB_NEXIO
>  	[DEVTYPE_NEXIO] = {
> -		.rept_size	= 128,
> +		.rept_size	= 1024,
>  		.irq_always	= true,
>  		.read_data	= nexio_read_data,
>  		.init		= nexio_init,
> 
> 
> 

-- 
Jiri Kosina
SUSE Labs, Novell Inc.

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
