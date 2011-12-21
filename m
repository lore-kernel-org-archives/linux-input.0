From: Daniel Kurtz <djkurtz@google.com>
Subject: Re: [RFC][PATCH] Input: Use monotonic time for event time stamps.
Date: Wed, 21 Dec 2011 10:11:13 +0800
Message-ID: <CAGS+omABqM84X=uoY1bGnAD-9DSR6qjrod8Teksm3qeiG2YGew@mail.gmail.com>
References: <1324429303.30527.92.camel@work-vm> <4EF1395E.405@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:53178 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752189Ab1LUCLf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Dec 2011 21:11:35 -0500
Received: by iaeh11 with SMTP id h11so11114121iae.19
        for <linux-input@vger.kernel.org>; Tue, 20 Dec 2011 18:11:34 -0800 (PST)
In-Reply-To: <4EF1395E.405@cn.fujitsu.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: gaowanlong@cn.fujitsu.com
Cc: john stultz <johnstul@us.ibm.com>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>

On Wed, Dec 21, 2011 at 9:41 AM, Wanlong Gao <gaowanlong@cn.fujitsu.com=
> wrote:
> On 12/21/2011 09:01 AM, john stultz wrote:
>
>> Hi
>> =A0 =A0 =A0 In reviewing the Android patch set, I noticed the follow=
ing patch from
>> Arve which looks like it resolves a reasonable issue (events using
>> CLOCK_REALTIME timestamps, which can jump forwards or backwards via
>> settimeofday()).
>>
>> I'm not very familiar with the evdev interface, so I'm not sure if
>> changing the timestamps to CLOCK_MONOTONIC could cause an ABI proble=
m
>> with legacy apps. Even so, I wanted to send the patch out for review=
 and
>> consideration as it seems like a reasonable fix.

Maybe you will have more luck this time.  You can read the previous
thread on this exact topic, here:
https://lkml.org/lkml/2011/10/3/37

The previous attempt got bogged down when people wanted more data on
use cases and how this patch would promote world peace.  I strongly
support the concept, but we found other ways to address our major
concern at the time, so didn't invest more effort to get that patch
accepted.

Just a question though, why ktime_get_ts() and not getrawmonotonic()?

Thanks!

>>
>> thanks
>> -john
>>
>>
>>
>>>From 20950b728f120cd808965c1a20b024aa79706d8d Mon Sep 17 00:00:00 20=
01
>> From: =3D?UTF-8?q?=3D3D=3D3FUTF-8=3D3Fq=3D3FArve=3D3D20Hj=3D3DC3=3D3=
DB8nnev=3D3DC3=3D3DA5g=3D3F=3D3D?=3D <arve@android.com>
>> Date: Fri, 2 Dec 2011 13:59:05 +0800
>> Subject: [PATCH] Input: Use monotonic time for event time stamps.
>> MIME-Version: 1.0
>> Content-Type: text/plain; charset=3DUTF-8
>> Content-Transfer-Encoding: 8bit
>>
>> Since wall time can jump backwards, it cannot be used to determine i=
f one
>> event occured before another or for how long a key was pressed.
>
> seems reasonable.
>
>>
>> CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> CC: linux-input@vger.kernel.org
>> Signed-off-by: Arve Hj=F8nnev=E5g <arve@android.com>
>> Signed-off-by: John Stultz <john.stultz@linaro.org>
>> ---
>> =A0drivers/input/evdev.c | =A0 =A05 ++++-
>> =A01 files changed, 4 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
>> index 4cf2534..ec329b4 100644
>> --- a/drivers/input/evdev.c
>> +++ b/drivers/input/evdev.c
>> @@ -94,8 +94,11 @@ static void evdev_event(struct input_handle *hand=
le,
>> =A0 =A0 =A0 struct evdev *evdev =3D handle->private;
>> =A0 =A0 =A0 struct evdev_client *client;
>> =A0 =A0 =A0 struct input_event event;
>> + =A0 =A0 struct timespec ts;
>>
>> - =A0 =A0 do_gettimeofday(&event.time);
>> + =A0 =A0 ktime_get_ts(&ts);
>> + =A0 =A0 event.time.tv_sec =3D ts.tv_sec;
>> + =A0 =A0 event.time.tv_usec =3D ts.tv_nsec / NSEC_PER_USEC;
>> =A0 =A0 =A0 event.type =3D type;
>> =A0 =A0 =A0 event.code =3D code;
>> =A0 =A0 =A0 event.value =3D value;
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
