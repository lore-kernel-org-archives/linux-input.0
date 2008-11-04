From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Subject: Re: cleanup of hiddev
Date: Tue, 4 Nov 2008 15:19:51 +0100
Message-ID: <200811041519.52565.oliver@neukum.org>
References: <200811031731.38055.oliver@neukum.org> <490F57D3.6060503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <490F57D3.6060503-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Slaby <jirislaby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jiri Kosina <jikos-wDf7oJUeT2I@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Am Montag, 3. November 2008 20:58:11 schrieb Jiri Slaby:
> Hi.
> 
> > this is the cleanup of hiddev against current vanilla. What do you think?
> 
> See my comments below.

Hi,

there still is a race of disconnect() with ioctl(). It seems like that
code still operates under the assumption that both methods take
BKL. Do you prefer a conservative fix with selective application of BKL
or introduction of a new mutex?

	Regards
		Oliver

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
