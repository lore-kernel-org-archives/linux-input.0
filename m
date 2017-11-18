From: Philippe Ombredanne <pombredanne@nexb.com>
Subject: Re: [PATCH] input: remove unneeded DRIVER_LICENSE #defines
Date: Sat, 18 Nov 2017 14:27:06 +0100
Message-ID: <CAOFm3uHrtTg=HRkuH+8S9T9B9DUYsTuiEw2UGh6Ly-nLvWX-kg@mail.gmail.com>
References: <20171117141720.GB17880@kroah.com> <20171117203313.l7lqzrun5bnuj2ht@dtor-ws>
 <20171118102724.GF8368@kroah.com> <CAOFm3uEScMh9PmQMuGvUY39sw=0iJhs0BezQHUhg2-KWZ1fRuQ@mail.gmail.com>
 <20171118124942.GA31864@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:45556 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1947238AbdKRN1s (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 18 Nov 2017 08:27:48 -0500
Received: by mail-wm0-f66.google.com with SMTP id 9so11109050wme.4
        for <linux-input@vger.kernel.org>; Sat, 18 Nov 2017 05:27:48 -0800 (PST)
In-Reply-To: <20171118124942.GA31864@kroah.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>

On Sat, Nov 18, 2017 at 1:49 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Sat, Nov 18, 2017 at 01:39:03PM +0100, Philippe Ombredanne wrote:
>> On Sat, Nov 18, 2017 at 11:27 AM, Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org> wrote:
>> >
>> > Please do, I got rid of all of the DRIVER_VERSION crap in the
>> > drivers/usb/ tree a release or so ago, as they make no sense at all.
>> > The other defines are also really silly and can be cleaned up too.
>> >
>> > Want me to do that for drivers/input/ for you?
>> >
>> > thanks,
>> >
>> > greg "I'm a janitor now" k-h
>>
>>
>> Thing could get worse: you could become a documentalist like tglx turned into.
>>
>> For the fun, another weird thingie that I once stumbled upon in an
>> out-of-tree third-party module:
>>
>> MODULE_LICENSE("\x47\x50\x4c\x20\x76\x32");
>>
>> ... which was most likely from a GPL-shy closet Free software
>> advocate: this is "GPL v2" in ASCII.
>
> Hah, we've seen worse with people trying to put '0x00' in the middle of
> the string to fake out the string checking logic.  Whenever stuff like
> that gets pointed out to the legal department of the company involved,
> stuff gets fixed fast,

Thanks!
FWIW, this was fixed fast alright when I pointed it to the software
team that had farted this.
This happened a couple years ago.

I have seen worse than using  '0x00' once: a combo of a patched insmod
to remove all the MODULE_LICENSE checks especially on "Proprietary"
AND a patched kernel adding a hook in module.[c,h] and some core net
patched code to make userspace,
"look-ma-kernelspace-gpl-will-not-apply-here" modules possible to do
network packet filtering in userspace. Which was also a nice try but
another baseless fart, beside being also terrible from a perf and
reliabiility point of view.

The squirrelly thing was that only a handful of line of code were
modified: a few needles hidden in a giant haystack.
If there were an award for "Sneakiest f*ck-the-gpl attempt", these
folks would have been winning the trophy hands down with special jury
congratulations.

> trying to 'circumvent' a license check is really
> frowned apon by almost all legal juristictions :)

In the US, in a weird twist of unintended consequences, this might be
likely a violation of the infamous DMCA.

-- 
Cordially
Philippe Ombredanne
