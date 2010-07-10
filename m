From: Kees Bakker <kees.bakker-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
Subject: Modified key codes in hid-topseed.c commit bf280628
Date: Sat, 10 Jul 2010 11:51:40 +0200
Message-ID: <798727E9-7E4C-4020-9924-F7796B7A7B53@xs4all.nl>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wayne Thomas <waynethomas69-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Wayne, Jiri,

In commit bf280628 support for a BTC was added to hid-topseed.c

But it was not a simple addition of BTC support. Also the mapping
of keycodes was changed. My question is: was deliberate? If not,
then the Topseed CYBERLINK remote will not work as before anymore.

In the meantime I have my own patches for a Conceptronic CLLRCMCE
remote control, which has almost identical keys as the (new) BTC.
So, I'm not complaining about the new mapping. It's just that I
noticed that change.

BTW What would be the best ML to discuss hid-topseed? I've now sent
this on both lists.
-- 
Kees

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
