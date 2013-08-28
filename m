From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: kernel Oops: 0003 on usbhid_submit_report
Date: Wed, 28 Aug 2013 14:42:46 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1308281441300.4557@pobox.suse.cz>
References: <9921350AD19C46EFA70EA181A0C1F7E9@sqhead.com> <20130813184056.GH7740@kroah.com> <16FA42AC8F654C3B81924591E607B342@sqhead.com> <20130815063736.GF25754@kroah.com> <26E21BF00B944AB6B8F48B5E59B0442D@sqhead.com> <CAN+gG=FJSMyQNHcq=0cO1srVpRb_83YihUH0WuAPTcKAJHhv4g@mail.gmail.com>
 <alpine.LNX.2.00.1308231447440.11021@pobox.suse.cz> <7851429DDA1F498899F023F32CC33483@sqhead.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <7851429DDA1F498899F023F32CC33483-nr7O5T6ryCTQT0dZR+AlfA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?ISO-8859-15?Q?Andreas_Lilleb=F8_Holm?= <andreas-nr7O5T6ryCTQT0dZR+AlfA@public.gmane.org>
Cc: Benjamin Tissoires <benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Mon, 26 Aug 2013, Andreas Lilleb=C3=B8 Holm wrote:

> You are my hero Jiri :-) These two patches fixes the issues I was see=
ing=20
> and I can no longer reproduce them.

Thanks a lot for confirmation.

This has been a very long-standing bug, but for some reasons I have=20
started to see devices actually triggering it only now.

My plan is to push it to Linus in the upcoming merge window, and once i=
t=20
proves to be stable, I'll do a -stable backport.

Thanks again,

--=20
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
