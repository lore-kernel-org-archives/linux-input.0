From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Subject: Re: [rft]powermate runtime pm
Date: Fri, 4 Jul 2008 00:13:53 +0200
Message-ID: <200807040013.54237.oliver@neukum.org>
References: <200807031753.16960.oliver@neukum.org> <20080703134107.ZZRA012@mailhub.coreip.homeip.net> <200807040008.50174.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200807040008.50174.oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, will-ffEBwZeNOFERmelmmXo44Q@public.gmane.org
List-Id: linux-input@vger.kernel.org

Am Freitag 04 Juli 2008 00:08:49 schrieb Oliver Neukum:
> Mutual exclusion is a very good idea. And telling input devices that
> they are open is also a good idea. But this will be difficult, as open()
> will almost certainly wish to do as memory allocations can trigger
> an autoresume.

Sorry, it is late.

Again, in clear language.

You will face a deadlock problem, as open can call into resume,
due to
a) usb_autopm_get_interface()
b) any memory allocation that triggers autoresumption of another
    interface of the same device

	Regards
		Oliver

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
