From: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 3/3] HID: usbhid: defer LED setting to a workqueue
Date: Wed, 14 Dec 2011 18:33:03 +0800
Message-ID: <CAGS+omA=9qfqDYtaLp67Xz+WhcpW_=jn9hoiaad43Z+oexjsFQ@mail.gmail.com>
References: <1321529030-7845-1-git-send-email-djkurtz@chromium.org>
 <1321529030-7845-4-git-send-email-djkurtz@chromium.org> <201112140901.35203.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201112140901.35203.oneukum-l3A5Bk7waGM@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
Cc: jkosina-AlSwsSmVLrQ@public.gmane.org, bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, olofj-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, Dec 14, 2011 at 4:01 PM, Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org> wrote:
> Am Donnerstag, 17. November 2011, 12:23:50 schrieb Daniel Kurtz:
>> Defer LED setting action to a workqueue.
>> This is more likely to send all LED change events in a single URB.
>
> Hi,
>
> I hope I am looking at the correct version of this patch.
> But as far as I can see the work for handling LEDs is not delayed
> while a reset is going on. That is wrong.

Actually, I'm not sure why this is wrong.  I find the reset handling
quite confusing in this driver.
Can you point out what will fail, and recommend how to fix it?

Thanks & Best Regards
-Daniel

>
> =A0 =A0 =A0 =A0Regards
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Oliver
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
