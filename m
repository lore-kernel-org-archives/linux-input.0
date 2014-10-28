From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: spear-keyboard - Add CONFIG_PM_SLEEP to suspend/resume functions
Date: Mon, 27 Oct 2014 18:08:41 -0700
Message-ID: <71CA30BA-E2BE-45D3-9FA8-6E1E9B1284A9@gmail.com>
References: <000801cff1e2$2427ba40$6c772ec0$%han@samsung.com> <20141027233744.GC7594@dtor-ws> <000001cff242$80476680$80d63380$%han@samsung.com> <20141028001100.GF7594@dtor-ws> <000701cff249$a700dde0$f50299a0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33319 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752658AbaJ1BIs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Oct 2014 21:08:48 -0400
Received: by mail-pa0-f49.google.com with SMTP id lj1so2449335pab.36
        for <linux-input@vger.kernel.org>; Mon, 27 Oct 2014 18:08:47 -0700 (PDT)
In-Reply-To: <000701cff249$a700dde0$f50299a0$%han@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: linux-input@vger.kernel.org, 'Viresh Kumar' <viresh.kumar@linaro.org>, 'Jingoo Han' <jg1.han@samsung.com>

On October 27, 2014 5:53:56 PM PDT, Jingoo Han <jg1.han@samsung.com> wrote:
>On Tuesday, October 28, 2014 9:11 AM, Dmitry Torokhov wrote:
>> On Tue, Oct 28, 2014 at 09:02:44AM +0900, Jingoo Han wrote:
>> > On Tuesday, October 28, 2014 8:38 AM, Dmitry Torokhov wrote:
>> > > On Mon, Oct 27, 2014 at 09:32:58PM +0900, Jingoo Han wrote:
>> > > > Add CONFIG_PM_SLEEP to suspend/resume functions
>> > > >
>> > > > Add CONFIG_PM_SLEEP to suspend/resume functions instead of
>> > > > CONFIG_PM to fix the following build warning when
>CONFIG_PM_SLEEP
>> > > > is not selected and CONFIG_PM is selected. This is because
>sleep
>> > > > PM callbacks defined by SIMPLE_DEV_PM_OPS are only used when
>the
>> > > > CONFIG_PM_SLEEP is enabled.
>> > >
>> > > Recently I've become a fan of __maybe_unused markings as they
>insulate
>> > > us from various CONFIG changes in unrelated subsystems, I'll
>transform
>> > > this patch to use them instead.
>> >
>> > OK, I see. I have no objection.
>> > Then, how about changing other usages of CONFIG_PM_SLEEP/CONFIG_PM
>> > to __maybe_unused annotation? Personally, I prefer to increase
>build
>> > coverage than using #ifdef guards. Someone, however, argued that
>#ifdef
>> > guards should be used in this case because the size of binary can
>be
>> > reduced. How about your opinion?
>> 
>> The optimizer is supposed to drop functions marked as
>'__maybe_unused'
>> if they are indeed unused so size of the binary should not change.
>
>Sorry for annoying you.
>I built 'spear-keyboard' and got the binaries as below.
>
>spear-keyboard.o 89500 bytes, <-- CONFIG_PM_SLEEP=n
>spear-keyboard.o 92352 bytes, <-- CONFIG_PM_SLEEP=y
>spear-keyboard.o 92352 bytes, <-- Marked as __maybe_unused
>
>As presented above, when CONFIG_PM_SLEEP is used instead of
>__maybe_unused, the size of binary is reduced. So, someone
>complained me to use #ifdef guards. But, I agree with your
>opinion. Personally, I DON'T want to use #ifdef guards,
>because I prefer to increase build coverage.

What about the final kernel image size/kernel module size?


Thanks.

-- 
Dmitry
