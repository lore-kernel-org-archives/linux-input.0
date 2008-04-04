From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Subject: Re: suspend
Date: Fri, 4 Apr 2008 13:36:31 +0200
Message-ID: <200804041336.32457.oliver@neukum.org>
References: <200804032242.36493.oliver@neukum.org> <200804041059.10276.oliver@neukum.org> <e79639220804040220g560e94b4l418724ff1653780d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <e79639220804040220g560e94b4l418724ff1653780d-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stefan Schweizer <genstef-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Am Freitag, 4. April 2008 11:20:51 schrieb Stefan Schweizer:
> Yeah, I tested it with the combined patch. How can I test if
> autosuspend works? Seems to work fine so far but does not write in my
> logfile. No problems found when testing.

Please compile your kernel with CONFIG_PM_DEBUG and follow the
instructions in Documentation/usb. You should see something in the log.

	Regards
		Oliver
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
