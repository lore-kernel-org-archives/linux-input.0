From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/4] acecad: stop saving struct usb_device
Date: Thu, 31 Mar 2016 11:03:42 -0700
Message-ID: <20160331180342.GG39098@dtor-ws>
References: <1458659097-8213-1-git-send-email-oneukum@suse.com>
 <1458659097-8213-2-git-send-email-oneukum@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1458659097-8213-2-git-send-email-oneukum-IBi9RG/b67k@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oneukum-IBi9RG/b67k@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, Mar 22, 2016 at 04:04:54PM +0100, Oliver Neukum wrote:
>  static int usb_acecad_open(struct input_dev *dev)
>  {
>  	struct usb_acecad *acecad = input_get_drvdata(dev);
>  
> -	acecad->irq->dev = acecad->usbdev;
> +	acecad->irq->dev = interface_to_usbdev(acecad->intf);

By the way, do we still need to do this assignment before submitting
urb?

>  	if (usb_submit_urb(acecad->irq, GFP_KERNEL))
>  		return -EIO;
>  

Thanks.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
