From: Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] HID: usbhid: Use pr_<level> and remove unnecessary OOM
 messages
Date: Mon, 6 Mar 2017 14:40:58 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1703061440490.31814@cbobk.fhfr.pm>
References: <17564e41463d71d65783b11cb0b337363f90eecc.1488418441.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <17564e41463d71d65783b11cb0b337363f90eecc.1488418441.git.joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Cc: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, 1 Mar 2017, Joe Perches wrote:

> Use a more common logging style and remove the unnecessary
> OOM messages as there is default dump_stack when OOM.
> 
> Miscellanea:
> 
> o Hoist an assignment in an if
> o Realign arguments
> o Realign a deeply indented if descendent above a printk
> 
> Signed-off-by: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>

Applied to for-4.12/upstream. Thanks,

-- 
Jiri Kosina
SUSE Labs

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
