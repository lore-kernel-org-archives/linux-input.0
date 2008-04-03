From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [patch]convert away from urb->status in xpad driver
Date: Thu, 3 Apr 2008 17:49:54 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0804031748330.32130@jikos.suse.cz>
References: <200804031326.00717.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200804031326.00717.oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Cc: jikos-AlSwsSmVLrQ@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jan Kratochvil <honza-wDf7oJUeT2I@public.gmane.org>
List-Id: linux-input@vger.kernel.org

[ added Dmitry ]

On Thu, 3 Apr 2008, Oliver Neukum wrote:

> USB is moving to transfering status as a parameter. To ease the transition
> urb->status is to be touched only once in a function. The xpad driver has
> been overlooked.
> Signed-off-by: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>

FWIW

Acked-by: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>

-- 
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
