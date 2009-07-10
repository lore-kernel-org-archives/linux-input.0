From: Frans Pop <elendil-EIBgga6/0yRmR6Xm/wNWPw@public.gmane.org>
Subject: Re: usb mouse not responding after resume
Date: Fri, 10 Jul 2009 12:28:40 +0200
Message-ID: <200907101228.42047.elendil@planet.nl>
References: <E1MPCb9-0007w0-BK@pomaz-ex.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-To: <E1MPCb9-0007w0-BK-8f8m9JG5TPIdUIPVzhDTVZP2KDSNp7ea@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Miklos Szeredi <miklos-sUDqSbJrdHQHWmgEVkV9KA@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Miklos Szeredi wrote:
> Sometimes after resume the usb mouse plugged into my T60 notebook
> isn't working.  Unplugging and replugging it fixes the problem.  A
> keyboard is also plugged in, which works normally every time.
> 
> This has been happening on and off from about 2.6.30-rc* but in
> 2.6.31-rc* seems to be getting more frequent.
> 
> Here's the suspend-resume-replug part of the dmesg.  Not sure if it is
> enough, I'd be happy to provide more info.

The most obvious first question is: is there any difference in the 
messages between resumes where the mouse works and where it does not.

Cheers,
FJP
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
