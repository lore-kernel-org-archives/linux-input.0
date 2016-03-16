From: Roderick Colenbrander <thunderbird2k@gmail.com>
Subject: Re: Handling of non-positional data through evdev
Date: Wed, 16 Mar 2016 11:39:35 -0700
Message-ID: <CAEc3jaAUmhzVwCMWWwWADCwz22Q8sFQP5qN5H8+Gb2Exf3GRcQ@mail.gmail.com>
References: <CAEc3jaB2KOUoymz3BL6Bc7_vv3bTHadBqGM9YLHyt_GeVkOtng@mail.gmail.com>
	<1458082753.4785.27.camel@hadess.net>
	<CAEc3jaA_EnhbNChXAStdqDik9YMfWYXzfHQbOgEb=TXmuNR_5w@mail.gmail.com>
	<1458141032.29084.0.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33005 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935107AbcCPSjg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Mar 2016 14:39:36 -0400
Received: by mail-pf0-f172.google.com with SMTP id 124so85332674pfg.0
        for <linux-input@vger.kernel.org>; Wed, 16 Mar 2016 11:39:36 -0700 (PDT)
In-Reply-To: <1458141032.29084.0.camel@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-input <linux-input@vger.kernel.org>

On Wed, Mar 16, 2016 at 8:10 AM, Bastien Nocera <hadess@hadess.net> wrote:
> On Tue, 2016-03-15 at 17:17 -0700, Roderick Colenbrander wrote:
>> Hi Bastien,
>>
>> Thanks for providing this suggestion. I can see this approach work
>> for
>> situations like screen rotation on tablets. The device I'm involved
>> with is an input device, which needs a high poll rate for
>> acceleration
>> / velocity and needs to be paired with the button / axes data. Evdev
>> would be most appropriate.
>
> So more like a Wiimote than a builtin sensor. What will consume events
> in user-space? A specialised application?

Correct see it more like a wiimote-like device. I expect many
userspace applications (desktop or embedded) to ultimately support
this device and many existing applications could already use the
device except they can't utilize the motion sensors.
