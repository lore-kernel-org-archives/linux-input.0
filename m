From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: [PATCH] usb: Keep track of actual LED state
Date: Mon, 10 Oct 2011 18:14:40 +0100
Message-ID: <20111010171440.GA22288@srcf.ucam.org>
References: <1318262100-24166-1-git-send-email-mjg@redhat.com>
 <20111010171314.GA2089@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20111010171314.GA2089-cSxB8VliqGEUVQd64OLqbEB+6BGkLq7r@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Henrik Rydberg <rydberg-Hk7bIW8heu4wFerOooGFRg@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, oneukum-l3A5Bk7waGM@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Mon, Oct 10, 2011 at 07:13:14PM +0200, Henrik Rydberg wrote:

> > -		usbhid->ledcount--;
> > +		usbhid->ledstate &= ~(1 << code);
> 
> Could simply check for ledcount > 0 here instead, but it is even uglier.

That'd still fail if we had one led turned on and two turned off - 
depending on the order we'd potentially think that suspend was safe.

> Why not test the actual input_dev state here instead? Adding a set/get
> led state function to input core could resolve this cleanly.

That might well be a better approach.

-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
