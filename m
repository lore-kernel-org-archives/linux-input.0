From: simon@mungewell.org
Subject: Re: [PATCH] HID: hid-sony: Prevent LED overrun
Date: Wed, 18 Feb 2015 11:24:18 -0500
Message-ID: <3fcd6100a16927033c5f10ce424fbf17.squirrel@mungewell.org>
References: <1424229290-32089-1-git-send-email-simon@mungewell.org>
    <54E41BA3.7060107@gmail.com>
    <8852fc05431a5ac60b02cfb5bea480d3.squirrel@mungewell.org>
    <CAH+9E3pSOb7GwGChVzSPjgq0j2B_1Ge4dcJKFRnj3WN9yTreDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:57950 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751596AbbBRQYU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Feb 2015 11:24:20 -0500
In-Reply-To: <CAH+9E3pSOb7GwGChVzSPjgq0j2B_1Ge4dcJKFRnj3WN9yTreDA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@gmail.com>
Cc: Simon Wood <simon@mungewell.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, "open list:HID CORE LAYER <linux-input@vger.kernel.org>, Jiri Kosina" <jkosina@suse.cz>

> On Feb 18, 2015 12:32 AM, <simon@mungewell.org> wrote:
>>
>>
>> > I think this was a bug in the LED system itself fixed by this commit:
>> >
>> >
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/leds/leds.h?id=56d06fdee534124f79b51ff92232373b783cddc2
>> >
>> > In kernel 3.19 the brightness values are clamped correctly and I can't
>> > replicate your bug.
>>
>> I guess it's possible, I am running 3.19.0rc5. I'll build 3.19 and see
>> if it's showing the bug.
>>
>
> Ah, my mistake.  That fix wasn't pulled in until 3.20 so you'll need to
> grab the latest working version to try it.
>

Well I did a 'git pull' and left it building overnight, and only just saw
this email...

A quick test this morning shows that the bug does not occur with the new
build, so it looks like my patch is not required after all (and fixing in
LED subsystem makes far more sense).

I am, however, confused about what I pulled and built. It definately had
the patch (I looked in drivers/leds/leds.h before building) but built as
3.19.... guess I'll just have a confused expression for the rest of the
day.

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/log/drivers/leds/leds.h

Simon.

