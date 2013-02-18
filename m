From: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH 3/3] USB: cdc-acm - blacklist IMS PCU device
Date: Mon, 18 Feb 2013 11:10:07 -0800
Message-ID: <20130218191007.GA10077@kroah.com>
References: <1361214357-21205-1-git-send-email-dmitry.torokhov@gmail.com>
 <1361214357-21205-4-git-send-email-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1361214357-21205-4-git-send-email-dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>, Chris Healy <chealy-KRR2zmvM+DFWk0Htik3J/w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Mon, Feb 18, 2013 at 11:05:57AM -0800, Dmitry Torokhov wrote:
> The IMS PCU (Passenger Control Unit) device used custom protocol over serial
> line, so it is presenting itself as CDC ACM device.
> 
> Now that we have proper in-kernel driver for it we need to black-list the
> device in cdc-acm driver.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Acked-by: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
