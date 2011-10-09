From: Terry Lambert <tlambert-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: Busted keyboard, fix, and Question about default HID device plumbing
Date: Sat, 8 Oct 2011 17:31:00 -0700
Message-ID: <CAA_E9NHJYdy1JqMNMP7uXrT-SifhnJU_3gaBS8HqcQ+OVhXtHg@mail.gmail.com>
References: <CAA_E9NGQC1Jy-MqRbMEj1cetuFktknBmtU91N7gPv1_rApzX6Q@mail.gmail.com>
	<20111007220745.GA30273@core.coreip.homeip.net>
	<CAA_E9NEDVynFfVBfkXPW6viAsGT3_ffBVfD309eSAeqq6QGj3w@mail.gmail.com>
	<20111008002524.GB30273@core.coreip.homeip.net>
	<CAA_E9NEi_gxb4px1344ChsAMmTEkUGSP8Vj=X31fBnQgwJ4c0g@mail.gmail.com>
	<alpine.LNX.2.00.1110080812170.14901@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LNX.2.00.1110080812170.14901-ztGlSCb7Y1iN3ZZ/Hiejyg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Thanks!

Working on it now...

-- Terry

On Fri, Oct 7, 2011 at 11:19 PM, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org> wrote:
> On Fri, 7 Oct 2011, Terry Lambert wrote:
>
>> You make a very good point on the key remapping.
>>
>> ...
>>
>> Are we sure that there isn't a field in the keyboard information in
>> the USB that reports the keyboard does this?
>>
>> The only other alternative seems to be to quirk the keyboard as
>> reporting keys down when they are down, up when they are up, and
>> generating pseudo events for "keycode not present in report".
>>
>> I guess I'm willing to write a "hosed keyboard driver" driver if
>> necessary. =A0This apparently effects about 5-10% of keyboards,
>> predominantly laptops with internal USB (some dell inspiron, some
>> samsung), and the folding keyboards people like to use with android
>> tablets.
>>
>> I'm willing to take any advice about where I can get a handle on all
>> the keys in a given report to implement a general quirk on this
>> hardware.
>>
>> If necessary, we can always write a driver, I suppose, if you can
>> point me at an example?
>
> So if I understood the situation correctly (Dmitry, thanks for adding=
 me
> to CC), what you want to do is to write a very simple driver that has=
 a
> hook called every time HID event occurs on the keyboard, and have it =
do
> modifier magic before it's reported to the input subsystem.
>
> There are various existing drivers which are doing exactly this that =
can
> serve as an example. The simplest one probably is hid-microsoft, the =
more
> sophisticated one is hid-apple. These two are registering ->event
> callback, so they are obtaining already pre-parsed information.
>
> If you'd need to receive information that hasn't been parsed yet by t=
he
> HID parser, you'd rather register ->raw_event callback. There are var=
ious
> drivers that to this as well -- hid-zydacron being a really simple on=
e and
> hid-magicmouse being a sophisticated one.
>
> I believe those drivers should serve as a perfect example for what yo=
u
> need.
>
> --
> Jiri Kosina
> SUSE Labs
>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
