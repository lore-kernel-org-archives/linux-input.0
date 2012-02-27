From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [PATCH 1/1] HID: kye: Add support for 3 tablets
Date: Mon, 27 Feb 2012 15:54:03 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1202271549000.31150@pobox.suse.cz>
References: <1329985774-4123-1-git-send-email-spbnick@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1329985774-4123-1-git-send-email-spbnick-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nikolai Kondrashov <spbnick-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-usb <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Thu, 23 Feb 2012, Nikolai Kondrashov wrote:

> Add support for three KYE tablets: EasyPen i405X, MousePen i608X, EasyPen M610X.
> Update Kconfig entry accordingly, remove EXPERT dependency.
> 
> Signed-off-by: Nikolai Kondrashov <spbnick-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Nikolai,

thanks a lot for the patch.

> I'm not sure if the Kconfig entry is changed correctly, 

As it now becomes more mature and stand-alone driver than a trivial quirk 
for one simple device, it's correct.

> and maybe it's not worth citing these huge original report descriptors. 

That's actually something I have been considering for quite some time 
already.

Would you strongly object to dropping all those you have added into 
various hid drivers already? I think the new rdesc + a few words of 
comment why we had to change the descriptor would be enough.

So I am not applying this patch now, and I'd like to ask you to respin it 
with the original rdesc comment removed and send a followup patch that 
does the substitution/removal in the other drivers.

Sounds ok?

Thanks,

-- 
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
