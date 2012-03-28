From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [RFC v2 0/1] User-space HID I/O Driver
Date: Wed, 28 Mar 2012 12:50:16 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1203281243180.25526@pobox.suse.cz>
References: <1332793209-2950-1-git-send-email-dh.herrmann@googlemail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1332793209-2950-1-git-send-email-dh.herrmann-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Herrmann <dh.herrmann-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, chen.ganir-l0cyMroinI0@public.gmane.org, claudio.takahasi-430g2QfJUUCGglJvpFV4uA@public.gmane.org, jprvita-430g2QfJUUCGglJvpFV4uA@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, anderson.lizardo-430g2QfJUUCGglJvpFV4uA@public.gmane.org, marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Mon, 26 Mar 2012, David Herrmann wrote:

> This is the second revision of the UHID driver. It basically allows to register
> hid_ll_drivers in user-space. This is needed to implement Bluetooth HoG (HID
> over GATT) as discussed earlier.
> 
> Changes:
>  - Improved documentation
>  - Added example which emulates a 3-button mouse with wheel in user-space
>  - Fixed some remaining bugs
> 
> I didn't change any major parts. I checked that writev/readv work correctly and
> I documented how to use it in ./Documentation/hid/uhid.txt.
> 
> For a full example please see ./samples/uhid/uhid-example.c.
> 
> While developing it I also considered moving HIDP to user-space. If we do BT-HoG
> in user-space, it should be easier to also move HIDP to user-space. The current
> in-kernel HIDP is buggy, anyway.
> 
> Still open points:
>  - How do I get a proper "parent" pointer for uhid->hid->dev.parent? I could use
>    the uhid misc device as parent or is there some device-struct inside "struct
>    file"?

Misc device sounds like the best we could get. You can't really use 
anything else from struct file than private_data and pointer to dentry 
(but that's likely not something you'd like to be using here).

>  - Should user-space be able to provide "uniq" and "phys" names for HID-devices?

I think so ... it would corelate with the in-kernel implementation, where 
those are derived from real devices in the in-kernel driver.

>  - uhid_event is quite big (>4KB) which makes uhid_device really big (~70KB).
>    Should I allocate the ring-buffer dynamically to avoid this?

Yes, please.

>  - Should I provide the quirks field to user-space? Probably as part of
>    UHID_START?

In order to have the situation mirroring what we already have, it might 
make sense. On the other hand -- how about adding the propagation only 
when it turns out that it's actually needed? (i.e. by finding out the 
first device, for which we need that).

>  - Could someone review x32 COMPAT stuff? I tried to align all the public
>    structures correctly so I could even remove the __packed attribute. Anyway, I
>    thought keeping it is probably better for future extensions.

Will look into it.

> I spent some time on the locks and they seem all fine. I couldn't find any
> races.
> 
> Jiri, Marcel, could you review the design and tell me what you think?

Generally, I like it. Thanks a lot for the effort. I will be going 
through the code in a more detailed way hopefully by the end of this week 
and will send you some comments (if any).

Thanks,

-- 
Jiri Kosina
SUSE Labs
