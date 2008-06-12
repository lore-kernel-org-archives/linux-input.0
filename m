From: Paul Collins <paul-dsjeNyW6Qm/D+ROgJ3VA+kB+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH] [RESEND] fix HID quirks for aluminium apple wireless keyboards
Date: Fri, 13 Jun 2008 02:55:43 +1200
Message-ID: <87prqmk8i8.fsf@burly.wgtn.ondioline.org>
References: <874p7ylsj0.fsf@burly.wgtn.ondioline.org>
	<1213276636216@dmwebmail.dmwebmail.chezphil.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1213276636216-YnoLgZYwwYuCbKHnblo0pmrPP3OPMK55cpQHUIT47Ck@public.gmane.org> (Phil Endecott's
	message of "Thu, 12 Jun 2008 14:17:16 +0100")
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Phil Endecott <phil_tuhck_endecott-wZDNlLIRyE5g9hUCZPvPmw@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org
List-Id: linux-input@vger.kernel.org

"Phil Endecott" <phil_tuhck_endecott-wZDNlLIRyE5g9hUCZPvPmw@public.gmane.org> writes:

> Did you see my messages about this a few weeks ago?  
> http://thread.gmane.org/gmane.linux.kernel.input/4984

Alas, no!  That would have been very helpful.

> I didn't post a patch because I believe that this stuff has all moved
> as a result of Jiri Slaby's patch "HID: move apple quirks" posted to
> linux-input on 2008-05-16.  One of us should prepare a patch against
> the tree after that patch.

I'm happy to do this, although the only tree I track closely is Linus's.

> Do you know what happens if you have a USB bluetooth dongle with HID
> proxy mode?  My assumption was that the vendor and product IDs from
> the keyboard would then appear to the kernel as USB IDs.  If this is
> true, then you should keep the existing entries for these devices in
> the USB quirks tables.  Does anyone know if HID proxy dongles actually
> do this?  In any case, leaving the existing entries in the USB quirks
> table can't do any harm.

Hmm, no idea.  Absent confirmation I guess I'll drop the USB HID changes
to be on the safe side.

> I wrote this up at http://chezphil.org/apple-alu-bluetooth-kb-linux/
> and I'll just post that URL again to help the search engines...

Nice writeup!  Small correction: when the quirk is active, you can
generate forward delete by pressing Fn-backspace.

-- 
Paul Collins
Wellington, New Zealand

Dag vijandelijk luchtschip de huismeester is dood
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
