From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: kernel Oops: 0003 on usbhid_submit_report
Date: Fri, 23 Aug 2013 14:49:53 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1308231447440.11021@pobox.suse.cz>
References: <9921350AD19C46EFA70EA181A0C1F7E9@sqhead.com> <20130813184056.GH7740@kroah.com> <16FA42AC8F654C3B81924591E607B342@sqhead.com> <20130815063736.GF25754@kroah.com> <26E21BF00B944AB6B8F48B5E59B0442D@sqhead.com>
 <CAN+gG=FJSMyQNHcq=0cO1srVpRb_83YihUH0WuAPTcKAJHhv4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAN+gG=FJSMyQNHcq=0cO1srVpRb_83YihUH0WuAPTcKAJHhv4g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benjamin Tissoires <benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: =?ISO-8859-15?Q?Andreas_Lilleb=F8_Holm?= <andreas-nr7O5T6ryCTQT0dZR+AlfA@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Fri, 23 Aug 2013, Benjamin Tissoires wrote:

> IIRC, Jiri fixed some paging requests with the two following patches:
> http://git.kernel.org/cgit/linux/kernel/git/jikos/hid.git/commit/?h=for-next&id=27ce405039bfe6d3f4143415c638f56a3df77dca
> http://git.kernel.org/cgit/linux/kernel/git/jikos/hid.git/commit/?h=for-next&id=bc197eedef1ae082ec662c64c3f4aa302821fb7a
> 
> At least, these two patches are related to hid_output_report(). I
> think they are scheduled for 3.12, so I can not find them in Linus'
> tree.
> 
> It would worth trying them :)

All three reported oopses happened on page boundary exactly, so this 
pretty much looks like my implement() fix is the one.

Andreas, could you please apply

	http://git.kernel.org/cgit/linux/kernel/git/jikos/hid.git/commit/?h=for-next&id=27ce405039bfe6d3f4143415c638f56a3df77dca

and report back whether it makes your problem go away?

Thanks,

-- 
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
