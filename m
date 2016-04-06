From: Sedat Dilek <sedat.dilek-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Linux-v4.6-rc2] atkbd serio0: Unknown key pressed (translated
 set 2, code 0xa8 on isa0060/serio0).
Date: Wed, 6 Apr 2016 12:43:11 +0200
Message-ID: <CA+icZUVMT2gSBCMrSkCQX6zhJWLKPZav1kuayQwxVa+CBZZfFw@mail.gmail.com>
References: <CA+icZUV0MGYme3EvLwYaW7HaAdKq7KQm6jgbcy58z4Vk3+n7qg@mail.gmail.com>
	<CA+icZUVZ05ri=Vs6UGWN0ks74_R2Q48u0=xoh2LSFwSLhpfabg@mail.gmail.com>
	<CA+icZUW0MFrV5gcVy=R6Jh+Fr7=5cr-ns0_ZXUjuY=LuiduLYw@mail.gmail.com>
	<alpine.LNX.2.00.1604061233270.27368@cbobk.fhfr.pm>
Reply-To: sedat.dilek-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LNX.2.00.1604061233270.27368-YHPUNQjx9ReKbouaWp301Q@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, Apr 6, 2016 at 12:33 PM, Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Wed, 6 Apr 2016, Sedat Dilek wrote:
>
>> >> I cannot use cursor up and down on my notebook and see this in my dmesg.
>> >>
>> >> [  685.425634] atkbd serio0: Unknown key pressed (translated set 2,
>> >> code 0xa8 on isa0060/serio0).
>> >> [  685.425648] atkbd serio0: Use 'setkeycodes e028 <keycode>' to make it known.
>> >>
>> >> Known issue?
>> >>
>> >> Do you need more input?
>> >>
>> >> Linux-config and dmesg-output attached.
>> >>
>> >> Regards,
>> >> - Sedat Dilek -
>> >
>> > Attached is output of...
>> >
>> >    $ xmodmap -pke > /tmp/xmodmap-pke.txt
>> >
>>
>> [ CC (USB)HID folks ]
>>
>> I forgot to tell that I have some patches on top of vanilla Linux v4.6-rc2.
>>
>> Dropping the patches from <jikos/hid.git#for-4.6/upstream-fixes> makes
>> the issue go away.
>
> Thanks for the useful report!
>
>> Unsure what is the cause. On the way, try to look this evening or
>> tommorrow into this.
>
> I don't seem to see the beginning of this thread anywhere.
>
> What hardware is this?
>

OK, OK.
As said I am on the run - my train is going in 40mins-
I try to write some better report.

- Sedat -
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
