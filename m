From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] HID: microsoft: Add support for Surface Pro 4 Type Cover
Date: Fri, 30 Oct 2015 21:41:26 +0200
Message-ID: <CAHp75Vfsf89uWVsoGKDEz86JN4WmfCwZWTDz0oLech=S+8sF9w@mail.gmail.com>
References: <1445988816-15987-1-git-send-email-alex.deddo@daqri.com>
	<alpine.LNX.2.00.1510301453060.17538@pobox.suse.cz>
	<CAHp75VeAQssE3_Vj+buijt2au7Gjv0Hrs2G9=cnXqV4ii6jDcg@mail.gmail.com>
	<CAHp75Vfi8PkJ8ztCt_mPAkRR_q-UeEk4g4cLn0vEtPs_r-WkVw@mail.gmail.com>
	<CAJ+BiKoZruvQQFQG0sJgzOM-uFbWwNYrW8R1+MDjiv+Rxe1C2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yk0-f172.google.com ([209.85.160.172]:33103 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758403AbbJ3Tl0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Oct 2015 15:41:26 -0400
In-Reply-To: <CAJ+BiKoZruvQQFQG0sJgzOM-uFbWwNYrW8R1+MDjiv+Rxe1C2Q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kenny Speer <kenny.speer@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, savoca <alex.deddo@daqri.com>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, USB <linux-usb@vger.kernel.org>

On Fri, Oct 30, 2015 at 9:21 PM, Kenny Speer <kenny.speer@gmail.com> wrote:
> Hi All, what information would you like?

Just found many patches are flying around to support MS Surface 3 /
Pro 3 / Pro 4 / Book.
https://groups.google.com/forum/?hl=en#!topic/linux-surface/VlE9JGvxEyg

I'm actually interested in Book support. So, I think someone has to
sort this out and prepare series based on what is found.

>
> BTW, here is the same patch for the 4.3rc7 kernel which already contains the
> surface button driver.
>
> https://github.com/neoreeps/surface-pro-3/blob/master/4.3_surface.patch
>
> ~kenny
>
> On Fri, Oct 30, 2015 at 11:39 AM, Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>>
>> Summon author, Kenny, of the mentioned patch.
>>
>> On Fri, Oct 30, 2015 at 7:49 PM, Andy Shevchenko
>> <andy.shevchenko@gmail.com> wrote:
>> > On Fri, Oct 30, 2015 at 3:53 PM, Jiri Kosina <jikos@kernel.org> wrote:
>> >> On Tue, 27 Oct 2015, savoca wrote:
>> >>
>> >>> Adding support for device 0x07e8 (SP4 Type Cover)
>> >>>
>> >>> Signed-off-by: savoca <alex.deddo@daqri.com>
>> >>
>> >> Thanks for the patch.
>> >>
>> >> The authorship and signoffs should same real names though. Could you
>> >> please resend with that fixed?
>> >>
>> >
>> > Have you guys noticed the patch [1] to support Surface Book along with
>> > Surface Pro 3?
>> >
>> > [1]
>> > https://github.com/neoreeps/surface-pro-3/blob/master/wily_surface.patch
>> >
>> > --
>> > With Best Regards,
>> > Andy Shevchenko
>>
>>
>>
>> --
>> With Best Regards,
>> Andy Shevchenko
>
>



-- 
With Best Regards,
Andy Shevchenko
