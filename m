From: Roderick Colenbrander <thunderbird2k@gmail.com>
Subject: Re: Handling of non-positional data through evdev
Date: Wed, 16 Mar 2016 12:00:19 -0700
Message-ID: <CAEc3jaB6q4OtZd4dkOg5wNgzCia06=ggS2vy+c3jd9Y1qRRRMg@mail.gmail.com>
References: <CAEc3jaB2KOUoymz3BL6Bc7_vv3bTHadBqGM9YLHyt_GeVkOtng@mail.gmail.com>
	<1458082753.4785.27.camel@hadess.net>
	<CAEc3jaA_EnhbNChXAStdqDik9YMfWYXzfHQbOgEb=TXmuNR_5w@mail.gmail.com>
	<1458141032.29084.0.camel@hadess.net>
	<CANq1E4TCTzZomCCWeSqsfmLM93ZVBwASgdy48bprddOtmBwhRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:36670 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752216AbcCPTAd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Mar 2016 15:00:33 -0400
Received: by mail-pf0-f171.google.com with SMTP id u190so85693061pfb.3
        for <linux-input@vger.kernel.org>; Wed, 16 Mar 2016 12:00:20 -0700 (PDT)
In-Reply-To: <CANq1E4TCTzZomCCWeSqsfmLM93ZVBwASgdy48bprddOtmBwhRg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: Bastien Nocera <hadess@hadess.net>, linux-input <linux-input@vger.kernel.org>

Hi David,

On Wed, Mar 16, 2016 at 8:26 AM, David Herrmann <dh.herrmann@gmail.com> wrote:
> Hi
>
> On Wed, Mar 16, 2016 at 4:10 PM, Bastien Nocera <hadess@hadess.net> wrote:
>> On Tue, 2016-03-15 at 17:17 -0700, Roderick Colenbrander wrote:
>>> Hi Bastien,
>>>
>>> Thanks for providing this suggestion. I can see this approach work
>>> for
>>> situations like screen rotation on tablets. The device I'm involved
>>> with is an input device, which needs a high poll rate for
>>> acceleration
>>> / velocity and needs to be paired with the button / axes data. Evdev
>>> would be most appropriate.
>>
>> So more like a Wiimote than a builtin sensor. What will consume events
>> in user-space? A specialised application?
>
> I really think evdev is the right place to put any of those devices.
> The real problem is that the current set of ABS types is very limited
> and strongly overloaded. We didn't do this for other types, but
> somehow ABS turned out that way.
>
> In general, Dmitry was ok with introducing new ABS types, properly
> representing those types. I sent an RFC some years ago, which also
> introduces gyro and accelerometer types (see patch #4):
>
> https://lists.freedesktop.org/archives/input-tools/2013-December/000612.html
>
> The problem is, however, that the current ABS_* namespace is
> exhausted. That is, we have to introduce some new way to add new ABS
> types (the series introduced ABS2 for that). No-one continued that
> effort so far, so we are stuck with the current ABS types. Feel free
> to pick this up. It might be a lengthy effort, though. You might be
> better off doing it the wiimote way: pick you ABS types and make
> user-space recognize them depending on the device name/etc.
>
> Thanks
> David

Your work was definitely interesting and exactly what I would have
needed. It felt like a reasonable path forward. What was ultimately
the main blocker? There was no interest?

Thanks,
Roderick
