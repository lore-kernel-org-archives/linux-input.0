From: "Rick L. Vinyard, Jr." <rvinyard-qcTL/1vZYtiVc3sceRu5cw@public.gmane.org>
Subject: Re: [PATCH] hid Logitech G13 Driver 0.0.5
Date: Wed, 23 Jun 2010 07:51:36 -0600
Message-ID: <40fb3584df99f83ffbf7633909412ea0.squirrel@intranet.cs.nmsu.edu>
References: <alpine.LNX.2.00.1006211442350.13809@pobox.suse.cz>
    <d1cda632f4cdb650a68119903473fbb4.squirrel@intranet.cs.nmsu.edu>
    <20100623122344.372e5f75@neptune.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100623122344.372e5f75-hY15tx4IgV39zxVx7UNMDg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bruno =?iso-8859-1?Q?Pr=C3=A9mont?= <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>
Cc: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Jaya Kumar <jayakumar.lkml-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, npavel-VxACSXvuqMTQT0dZR+AlfA@public.gmane.org, tomi.valkeinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, florianschandinat-Mmb7MZpHnFY@public.gmane.org, krzysztof.h1-5tc4TXWwyLM@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

> On Tue, 22 June 2010 "Rick L. Vinyard, Jr." <rvinyard-qcTL/1vZYtiVc3sceRu5cw@public.gmane.org> wr=
ote:
>> I've been waiting to resubmit until I get some of the userspace
>> libraries
>> and utilities a little more mature. There were some things I was
>> exposing
>> to sysfs that I didn't absolutely need, and some others that I neede=
d to
>> add.
>>
>> The cairo and papyrus libraries are (preliminarily) fully working. O=
nce
>> I
>> make sure I have everything the daemon will need I'll resubmit the
>> driver,
>> and once that is done I was planning on submitting the libs/utils to
>> Fedora.
>>
>> For now, I've been dropping Fedora 12/13 patches and kernel SRPMS he=
re:
>> http://miskatonic.cs.nmsu.edu/g13/
>>
>> And the userspace libraries/utilities are at:
>> http://g13.sourceforge.net
>>
>> As for the g13fb on the G15... I would imagine it could be done, but=
 I
>> don't have a G15 so I can't say for sure.
>>
>> If I had to guess I think you'll have to take the core functionality=
 of
>> the keyboard driver and extend it with the fb code in the _same_ dri=
ver
>> if
>> the keyboard and display use a similar design to the G13.
>>
>> The G13 uses the same endpoint for both keyboard input and display
>> messages, and since a USB endpoint can't be shared across drivers bo=
th
>> will have to reside in the same driver.
>>
> Bruno Pr=C3=A9mont wrote:
> Hi Rick,
>
> Please check how your driver behaves if the framebuffer is still in u=
se
> (open and/or mmapped) by some userspace process when you unplug the
> keyboard.
>
> Probably you will get hit be the same complaints from kernel I was se=
eing
> with PicoLCD driver (see my patch http://lkml.org/lkml/2010/5/30/15 t=
hat
> is expected to fix it on PicoLCD side, the refcounting part of the pa=
tch)
>

Will do. Thanks for the heads up.

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
