From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH v4] Input: evdev - add EVIOCREVOKE ioctl
Date: Sat, 7 Sep 2013 19:41:05 +0200
Message-ID: <CANq1E4QZ9tZT+OesteyCrC9xyYxPxwZ6QV81+RQD70N3dQfM=g@mail.gmail.com>
References: <1378044450-8327-1-git-send-email-dh.herrmann@gmail.com>
	<1378551653-805-1-git-send-email-dh.herrmann@gmail.com>
	<c552d883-34a3-4317-9053-be7ea190cebe@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:48933 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012Ab3IGRlH (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 7 Sep 2013 13:41:07 -0400
Received: by mail-la0-f44.google.com with SMTP id eo20so3759291lab.17
        for <linux-input@vger.kernel.org>; Sat, 07 Sep 2013 10:41:05 -0700 (PDT)
In-Reply-To: <c552d883-34a3-4317-9053-be7ea190cebe@email.android.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, =?ISO-8859-1?Q?Kristian_H=F8gsberg?= <hoegsberg@gmail.com>

Hi Dmitry

On Sat, Sep 7, 2013 at 7:16 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> David Herrmann <dh.herrmann@gmail.com> wrote:
>>Given the recent ABS_*-regression, I wrote a bunch of more aggressive
>>stress-tests for this. I didn't found any regressions if EVIOCREVOKE is
>>not
>>used, but one with revoke on an empty queue in evdev_read(). Now fixed.
>>Please
>>let me know what your plans for this patch are (-next or -rc1?) so we
>>can
>>schedule accordingly.
>
> I think this one is safer than extending axis numbers as there is no concerns about breaking stuff - it's brand new. So I think we can work it in -rc1.

Sounds good, thanks.
The ABS-fixes will take some time, yepp. We can retry these with the
guitar/drums ABS bits for 3.13. EVIOC[SG]ABS2 is probably the way to
go.

>> As a side note, will you attend LPC this year? We
>>have a
>>bunch of fancy stuff I'd like your opinion on (including
>>device-properties, device-detection, ABS_* bit extension).
>
> Yes. I'll get to new Orleans a couple days earlier (Sunday night) so if you are in town we could meet for drinks or such.

I'll arrive there on Saturday-evening, will drop you a message. See
you in New Orleans.

Thanks
David
