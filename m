From: Kalle Jokiniemi <kalle.jokiniemi@jolla.com>
Subject: Re: [PATCH 1/1] input: ff-memless: Change FF_ENVELOPE_INTERVAL to
 a module parameter.
Date: Mon, 31 Aug 2015 11:47:06 +0300
Message-ID: <55E4148A.5050109@jolla.com>
References: <1440762993-31329-1-git-send-email-kalle.jokiniemi@jolla.com> <20150829002925.GA8298@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp72.ord1c.emailsrvr.com ([108.166.43.72]:55914 "EHLO
	smtp72.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752656AbbHaIrK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 31 Aug 2015 04:47:10 -0400
In-Reply-To: <20150829002925.GA8298@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi,

On 29.08.2015 03:29, Dmitry Torokhov wrote:
> Hi Kalle,
>
> On Fri, Aug 28, 2015 at 02:56:33PM +0300, Kalle Jokiniemi wrote:
>> Sometimes you need to have tighter control over the ff-memless
>> effects. E.g. when creating short button / VKB press effects,
>> the effect duration is typically <= 40ms, and you want to have
>> a short acceleration period in beginning and fade out the end
>> to avoid "electric tooth brush" effect. With 50ms envelope
>> interval this control is not possible.
>>
>> To allow this control without patching over ff-memless, change the
>> FF_ENVELOPE_INTERVAL macro to a module parameter that can be modified
>> via kernel command line or during runtime from
>> /sys/module/ff_memless/parameters/ff_envelope_interval sysfs file.
>
> How would users know that they need to change this parameter? Could we
> maybe adjust sampling time dynamically, based on the attack length of
> the envelope?

Well, I'm looking after some parts of the Sailfish OS haptics / vibrator 
parts, and consider myself a user. For haptic effects (e.g. the VKB 
example above), I know I need as short as I can get to be able to tune 
those effects to work best with the Hardware I'm working with. Then for 
long alarm vibrations, the interval doesn't matter that much. But 
typically I would just set it to the smallest I can get with HZ setting 
the kernel has.

I've been thinking the "user" for this setting more as a system 
administrator / OS maintainer / device maker setting. But your idea 
could maybe work. Top of my head the downside would be added complexity, 
and slight "unpredictability" of the function if the timing changes 
dynamically. Would we then again need a user space setting for the 
threshold where to start using longer timers?

BTW, how would you feel about hr timers instead of jiffy based timing in 
ff-memless? That is a bit of a bottle neck for me (I see some jitter on 
the first event and typical 100Hz kernel only gives 10ms control interval).

- Kalle

>
> Thanks.
>
