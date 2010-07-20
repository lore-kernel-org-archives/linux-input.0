From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: ACRUX gamepads not happy with autosuspend?
Date: Tue, 20 Jul 2010 10:58:50 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1007201058190.4741@pobox.suse.cz>
References: <4C3F8A90.3020308@dv-life.ru> <4C44E3A2.8080301@dv-life.ru> <20100720001745.GA17910@core.coreip.homeip.net> <201007201007.04518.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201007201007.04518.oneukum-l3A5Bk7waGM@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, x0r <x0r-MmyNGb77m7ovJsYlp49lxw@public.gmane.org>, Linux Input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux USB <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Tue, 20 Jul 2010, Oliver Neukum wrote:

> > It looks like ACRUX game controllers do not like autopm. There is
> > a bug report over at Ubuntu's launchpad:
> > 
> > 	https://bugs.launchpad.net/ubuntu/+source/joystick/+bug/448446
> 
> That report shows that the symptoms are consistent with autosuspend,
> but it doesn't show that autosuspend was on.

That would be my first question -- who enabled autosuspend, if it was 
really on? I thought it should be still off by default, shouldn't it?

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
