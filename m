From: Benjamin Tissoires <benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3] i2c-hid: introduce HID over i2c specification implementation
Date: Tue, 4 Dec 2012 12:50:39 +0100
Message-ID: <CAN+gG=G+ymEdfAf3Ub6n8ErhPBz1BB3XYyEPixz9sWbNeRnPDQ@mail.gmail.com>
References: <1352731379-24683-1-git-send-email-benjamin.tissoires@gmail.com>
	<20121130155650.69407e9f@endymion.delvare>
	<CAN+gG=FjVswyx1W4y6NtbNnBu2AWgZZfxVr0h00ZYujCOz3v7Q@mail.gmail.com>
	<20121203140226.0fede51e@endymion.delvare>
	<CAN+gG=F5jae=UFDR4-zZY-dt6KGE22QgmWiF2RkVvqN0ySX-kQ@mail.gmail.com>
	<alpine.LNX.2.00.1212041129530.17055@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LNX.2.00.1212041129530.17055-ztGlSCb7Y1iN3ZZ/Hiejyg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stephane Chatty <chatty-rXV5z7KbLFk@public.gmane.org>, fabien.andre-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, scott.liu-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org, JJ Ding <jj_ding-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, Dec 4, 2012 at 11:31 AM, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org> wrote:
> On Mon, 3 Dec 2012, Benjamin Tissoires wrote:
>
>> >> I know that it already have been used by one Nvidia team and by Elan
>> >> for internal tests. So I don't know if it's possible to change it now
>> >> (though it's not a big deal).
>> >
>> > Yes it is possible, as long as the code isn't in Linus' tree (and I'd
>> > even say: as long as it is not in any kernel released by Linus.)
>> > Whoever is already using your driver will have to adjust their code.
>> > They'll certainly want to anyway, in order to get the bug fixes.
>> >
>> >> Anyway, "hid" is a little weird to me (but this is because I started
>> >> hacking the kernel from there), as it's really short and does not
>> >> contain i2c :)
>> >
>> > This is exactly my point: no other i2c client (to my knowledge) has
>> > "i2c" in its name, because it is redundant.
>> >
>> > I would agree that this is kind of a special case as this is a generic
>> > driver and not a device-specific driver. I would still prefer "hid" but
>> > if you don't feel like changing it, I guess I can live with that.
>>
>> Ok, I'll change the name.
>> My concerns were just because from my point of view, "hid" refers to
>> the core implementation. But for OEMs, they need to declare a "hid"
>> device, so it makes sense. Anyway, when I'll be able to get my hand on
>> an ACPI 5 device with hid over i2c, I'll be able to write the missing
>> autoloading code, and this name will be only used by a small part of
>> OEMs (I hope).
>
> If you are going to change the name, please either send me the patch
> before merge window for 3.8 opens, or explicitly ask me not to include
> this driver in pull request that goes to Linus yet.

Sure, I intend to send some patches today (with the change of the name
included). I'll send the patch related to the name in the first
position so that you can safely pick it up even if you are not
satisfied with the other changes.

Thanks,
Benjamin

>
> Once the driver is in Linus' tree, I'd rather not change the name.
>
> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs
