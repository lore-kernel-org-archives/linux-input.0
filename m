From: Terry Lambert <tlambert@chromium.org>
Subject: Re: [PATCH] Input: fixed EVIOCGRAB iterative grab/release.
Date: Fri, 11 Feb 2011 09:55:53 -0800
Message-ID: <AANLkTikM3G5+KYXGe4hBL7LHg1-W0-dgN7jOGA2fbLvZ@mail.gmail.com>
References: <1297381370-16388-1-git-send-email-tlambert@chromium.org>
	<20110211100439.GA1938@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:31145 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757588Ab1BKRz4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Feb 2011 12:55:56 -0500
Received: from hpaq13.eem.corp.google.com (hpaq13.eem.corp.google.com [172.25.149.13])
	by smtp-out.google.com with ESMTP id p1BHtt4L026550
	for <linux-input@vger.kernel.org>; Fri, 11 Feb 2011 09:55:55 -0800
Received: from gxk25 (gxk25.prod.google.com [10.202.11.25])
	by hpaq13.eem.corp.google.com with ESMTP id p1BHtbd9032190
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Fri, 11 Feb 2011 09:55:53 -0800
Received: by gxk25 with SMTP id 25so1286836gxk.37
        for <linux-input@vger.kernel.org>; Fri, 11 Feb 2011 09:55:53 -0800 (PST)
In-Reply-To: <20110211100439.GA1938@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Henrik,

I'm in the middle of cutting down my failure case right now, so I
should be able to provide a stand-alone test case shortly.  This is my
top priority at work right now.

And you are correct about the race.  This is about back-to-back
operations of a tool in a script, on a relatively slow machine with
obstinate hardware, and a grabby Xorg driver (it's the closed source
one, so I can't make it non-grabby).  So technically a stress test.

You noted the evdev->mutex; the idempotence of the call for the two
pointer clears will be preserved by the mutex, so no one is going to
get in under it while it's grabbed in the evdev_* layer, and not
grabbed in the input_*_device layer, and get unhappy.

So at worst it's a no-op change that scratches my particularly weird it=
ch here.

PS: I supposed this use of the mutex is worthy of a comment in the
code?  Any guidance?

-- Terry

On Fri, Feb 11, 2011 at 2:04 AM, Henrik Rydberg <rydberg@euromail.se> w=
rote:
> Hi Terry,
>
>> Fixed order of calls in evdev_ungrab to allow iterative use of
>> code which grabs and releases input event devices.
>>
>> Signed-off-by: Terry Lambert <tlambert@chromium.org>
>> ---
>> =A0drivers/input/evdev.c | =A0 =A02 +-
>> =A01 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
>> index c8471a2..0bac8da 100644
>> --- a/drivers/input/evdev.c
>> +++ b/drivers/input/evdev.c
>> @@ -160,9 +160,9 @@ static int evdev_ungrab(struct evdev *evdev, str=
uct evdev_client *client)
>> =A0 =A0 =A0 if (evdev->grab !=3D client)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return =A0-EINVAL;
>>
>> + =A0 =A0 input_release_device(&evdev->handle);
>> =A0 =A0 =A0 rcu_assign_pointer(evdev->grab, NULL);
>> =A0 =A0 =A0 synchronize_rcu();
>> - =A0 =A0 input_release_device(&evdev->handle);
>
> I imagine the current code could lead to a race situation if there
> were no other locks involved. However, evdev_ungrab() is always calle=
d
> under evdev->mutex. As Dmitry hinted, grabbing "usually works", so
> perhaps you could device a tiny program which reproduces the problem?
>
> Thanks,
> Henrik
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
