From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v10] leds: USB: HID: Add support for MSI GT683R led panels
Date: Mon, 23 Jun 2014 14:23:24 -0400
Message-ID: <20140623182324.GA30831@kroah.com>
References: <20140623161723.GA20421@kroah.com>
 <1403543808-8228-1-git-send-email-janne.kanniainen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1403543808-8228-1-git-send-email-janne.kanniainen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Janne Kanniainen <janne.kanniainen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org, cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Mon, Jun 23, 2014 at 08:16:48PM +0300, Janne Kanniainen wrote:
> +	ret = sysfs_create_group(&led->hdev->dev.kobj, &gt683r_attribute_group);
> +	if (ret) {
> +		hid_err(hdev, "failed to create sysfs attributes\n");
> +		goto fail;
> +	}

No, you need to set the attribute group _before_ you call
led_classdev_register, as that is where the device will be created in
sysfs.  Surely the other led drivers already do this?  I'm almost afraid
to go look...

You also have to document your sysfs file in Documentation/ABI/

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
