From: Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] HID: usbhid: fix dead lock between open and disconect
Date: Thu, 2 Feb 2012 12:05:43 +0800
Message-ID: <CACVXFVPfZza5AWKnROs3fMzCzehw-d8aPc7ePZNqSGgpwzAc+Q@mail.gmail.com>
References: <1326361342-4141-1-git-send-email-tom.leiming@gmail.com>
	<201201121054.50083.oneukum@suse.de>
	<CACVXFVP5V88_cTcpDYnsTy-M9aCaZ5Yneo=yVfB4+2_YjjWFFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACVXFVP5V88_cTcpDYnsTy-M9aCaZ5Yneo=yVfB4+2_YjjWFFQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Gentle ping on this fix, :-)

On Thu, Jan 12, 2012 at 6:33 PM, Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hi,
>
> On Thu, Jan 12, 2012 at 5:54 PM, Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org> wrote:
>
>> you should however hold the lock while you unset hiddev->exist
>
> The patch doesn't change the rule.
>
>> and you should unset hiddev->exist before you call usb_deregister_dev().
>
> The lock is not hold before reading hiddev->exist and writing list->hiddev->open
> in hiddev_open, so I choose to put usb_deregister_dev before unsetting
> hiddev->exist in hiddev_disconnect to avoid possible race.
>
>
> thanks,
> --
> Ming Lei



-- 
Ming Lei
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
