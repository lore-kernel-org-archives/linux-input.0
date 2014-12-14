From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [systemd-devel] Supporting U2F over HID on Linux?
Date: Sat, 13 Dec 2014 16:33:46 -0800
Message-ID: <CALCETrWxVmMSHwv5zJEBn7MMOX5qyQGW1S9FoSVxAGLh9_CKEw@mail.gmail.com>
References: <CALCETrXKcU1KaEjFUm9QkEhZRh9wFnoR=hV7O9pUJmYRqNCxpg@mail.gmail.com>
 <CANq1E4Sa=D_hvSp2SqHy4cV-oxd-kchsNVivcF54cBv8DK7gOQ@mail.gmail.com>
 <alpine.LNX.2.00.1411032115140.19451@pobox.suse.cz> <CALCETrVkZxc9G+B9jYYFmiE20VGcnugrB21_MRvjNhDTvP00zQ@mail.gmail.com>
 <CALCETrXf4wX5OoGJs2HWbzSLOz764XXg09mSHiTV=-GVCEUQuQ@mail.gmail.com>
 <CALCETrU9Nfpt0Zch5Swi+OaK=KTjJoOw7GAx4B7q1B56SqrUbA@mail.gmail.com>
 <CANq1E4Q8gTgMj+twRE3xjs1OfKUmbOmOatk_sDPPAW2BB4jscw@mail.gmail.com>
 <CALCETrXcHKwBuOA0wpFzgSe8Z9+t8LyaB7U+vdgVsR=YZc+GjQ@mail.gmail.com>
 <CANq1E4SVQAkyxJpiYsiLkjsET27QUK9PHTHTAqp4wQZVLKrMiw@mail.gmail.com>
 <CALCETrVfvK-BhaQMyfvLndfmX+gwAwshx3vdCFa7sOr+R1Jjpw@mail.gmail.com>
 <CANq1E4Q8+0_cLtwraK=gqFBovQoft9-0S4+ns_n9A7CinNTw7g@mail.gmail.com>
 <CALCETrW-Mt5Hqh353t3zm6Pq2kSUkw_16a2=DFHoEk=G92AU+w@mail.gmail.com>
 <CANq1E4QATOTs0ZtQF0mT645Z5u+vxYyphq8-UbqvNAc4iNz3iQ@mail.gmail.com>
 <CALCETrWD6w5QQSvnt=jkyHPNiBskQFxj5+LZey66LxXfyK_GcQ@mail.gmail.com>
 <alpine.LNX.2.00.1412132353500.9918@pobox.suse.cz> <CALCETrWd0AE+2GOj5NWcm0yDXWLZxeNg3caQYdKQ_m6s+jizjg@mail.gmail.com>
 <CAN+gG=F4GSe-jTGqu+73K_7QjRmkSQpwydn1ucEVKhwhWWoTYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:51400 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752435AbaLNAeJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 13 Dec 2014 19:34:09 -0500
Received: by mail-lb0-f182.google.com with SMTP id f15so8106389lbj.41
        for <linux-input@vger.kernel.org>; Sat, 13 Dec 2014 16:34:07 -0800 (PST)
In-Reply-To: <CAN+gG=F4GSe-jTGqu+73K_7QjRmkSQpwydn1ucEVKhwhWWoTYQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: David Herrmann <dh.herrmann@gmail.com>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

On Sat, Dec 13, 2014 at 4:06 PM, Benjamin Tissoires
<benjamin.tissoires@gmail.com> wrote:
>
> On Dec 13, 2014 6:28 PM, "Andy Lutomirski" <luto@amacapital.net> wrote:
>>
>> On Sat, Dec 13, 2014 at 2:56 PM, Jiri Kosina <jkosina@suse.cz> wrote:
>> > On Fri, 12 Dec 2014, Andy Lutomirski wrote:
>> >
>> >> It's roughly ISO7816-3.  For the uninitiated (and the ISO7816 standard
>> >> is amazingly vague), that means that the application sends a short
>> >> (<64kB) binary request to the device (with a type, two "parameters",
>> >> and a payload), and the device answers with exactly one reply packet
>> >> that has two bytes of status and a payload.  These requests and
>> >> replies are fragmented into multiple HID reports.
>> >
>> > Sorry for taking one (or maybe even more) step back, but what makes this
>> > thing even "HID device"?
>> >
>> > Yes, it interacts with human beings, but are the operations it's doing
>> > covered by HID specification (at least in a "does it have HID
>> > descriptor"
>> > sense)? It's not really completely clear to me at this point.
>>
>> It has a HID descriptor, it's recognized by the HID stack, it
>> understands SET_REPORT, and it generates async HID reports.  Hidraw is
>> willing to talk to it and, in fact, Chromium talks to it using hidraw
>> (ugh).
>>
>> It's also supposed to be *enumerated* by reading the HID descriptor.
>> There are multiple vendors of these things, and the USB descriptor
>> doesn't seem to have anything in it to identify the device.
>>
>> I think that's the full extent to which it's a HID device.
>
> And the most important, these devices have a button on them :)

Someone should have told the U2F committee that the device should send
a HID report, then :-/

(Also, at least one implementation is missing the button.  You "press
the button" by unplugging and replugging the whole device.)

--Andy

>
> Cheers,
> Benjamin
>
>>
>> --Andy
>>
>> >
>> > Thanks,
>> >
>> > --
>> > Jiri Kosina
>> > SUSE Labs
>>
>>
>>
>> --
>> Andy Lutomirski
>> AMA Capital Management, LLC



-- 
Andy Lutomirski
AMA Capital Management, LLC
