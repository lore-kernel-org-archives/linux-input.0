From: Jiri Kosina <jkosina-IBi9RG/b67k@public.gmane.org>
Subject: Re: [PATCH][RFC] usbhid: enable autosuspend for internal devices
Date: Mon, 29 Jun 2015 14:00:59 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1506291400270.10183@pobox.suse.cz>
References: <20150626221517.GB2761@kroah.com>   <Pine.LNX.4.44L0.1506262113240.31192-100000@netrider.rowland.org>   <20150627012959.GA15207@kroah.com>   <alpine.LNX.2.00.1506270825010.10183@pobox.suse.cz>  <1435571292.1805.4.camel@suse.com>
 <alpine.LNX.2.00.1506291315360.10183@pobox.suse.cz> <1435577839.1805.10.camel@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1435577839.1805.10.camel-l3A5Bk7waGM@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
Cc: Tom Gundersen <teg-B22kvLQNl6c@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Mon, 29 Jun 2015, Oliver Neukum wrote:

> > This is a HW property and nothing kernel can do about. I am not saying it 
> > doesn't bring the LEDs up to a proper state again once auto-resumed. But I 
> > hate the LEDs going off a few seconds after I stop typing (i.e. once the 
> > keyboard gets auto-suspended).
> 
> That is the point. Unless you give the option to override, they
> shouldn't autosuspend.

Ah, you're right, I completely forgot about the logic we've put into 
hidinput_count_leds() quite some time ago. Sorry for the noise,

-- 
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
