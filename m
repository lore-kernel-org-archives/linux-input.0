From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH 4/4] input - wacom: Support 2FGT in MT format
Date: Fri, 11 Feb 2011 15:47:50 -0800
Message-ID: <AANLkTikZ3EMWkfqadaeHsNkQPtD8mZiZm+hNHeON+y8u@mail.gmail.com>
References: <1297387983-13761-1-git-send-email-pinglinux@gmail.com>
	<20110211202010.GB2287@polaris.bitmath.org>
	<AANLkTimBPBDCBzw0fbDpLf8F7N_zG+ceKJAC9Li15g5P@mail.gmail.com>
	<20110211204742.GD2287@polaris.bitmath.org>
	<AANLkTinmUVW+cK1PJnCxiLSv1DiMQC-KkkeoAHVyckZe@mail.gmail.com>
	<20110211220518.GB7375@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:47850 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756887Ab1BKXrw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Feb 2011 18:47:52 -0500
Received: by wwa36 with SMTP id 36so3146982wwa.1
        for <linux-input@vger.kernel.org>; Fri, 11 Feb 2011 15:47:51 -0800 (PST)
In-Reply-To: <20110211220518.GB7375@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: linux-input@vger.kernel.org

On Fri, Feb 11, 2011 at 2:05 PM, Henrik Rydberg <rydberg@euromail.se> w=
rote:
>> >> The above statement is to avoid going through the input_mt_slot a=
nd
>> >> input_mt_report_slot_state routines without posting any meaningfu=
l
>> >> events. I guess it could be considered as a performance enhanceme=
nt?
>> >
>> > It won't be posting events unless something changed.
>>
>> But it still go through the =A0input_mt_slot and
>> input_mt_report_slot_state routines, which is unnecessary. If we kno=
w
>> up front there is no events posting, what benefit do we get to go
>> through the routines?
>
> Clarity. :-)

Oh, that. We could add some comments to make it clear.

In fact, Chris has suggested to add more comments in general. But I
have seen review comments like "the code tells the others what you are
saying". So, we deferred.

How about this:

+
+       /* no touch events should be posted when pen is in proximity
and touch was up */
+       if (wacom->shared->stylus_in_proximity && !wacom->shared->touch=
_down)
+               return 0;

>> >> No, =A0wacom_tpc_mt_touch can set touch_down to false too. When t=
ouch is
>> >> false, touch_down will be false. This happens when pen in prox or=
 when
>> >> both fingers are up.
>> >
>> > Now, that is what cannot happen, because of the max() function.
>>
>> This time is real. How about this one?
>>
>>
>> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet=
/wacom_wac.c
>> index 39c289d..3cdafb9 100644
>> --- a/drivers/input/tablet/wacom_wac.c
>> +++ b/drivers/input/tablet/wacom_wac.c
>> @@ -699,7 +699,10 @@ static int wacom_tpc_mt_touch(struct wacom_wac =
*wacom)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* keep touch bit to send proper tou=
ch up event */
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom->shared->touch_down =3D max(touc=
h,
>> wacom->shared->touch_down);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (i =3D=3D 1)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom->shared->touch_d=
own =3D max(touch,
>> wacom->shared->touch_down);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom->shared->touch_d=
own =3D touch;
>> =A0 =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 =A0 input_mt_report_pointer_emulation(input, true);
>
> Well... it might help to return to what the main goal is here. If the
> purpose is to fix userspace, maybe it should actually be done in
> userspace instead.

The goal is to support legacy ST client. A clean support would be to
send pen data and pen data only whenever pen is in prox, no matter
touch is down or not; sending ST touch data only when pen is out-prox.
The concept of ST is that in any single moment, there would be only
one type of data in action.

In that sense, avoiding both pen and touch in action at the same time
is our (kernel's) responsibility. ST clients do not have the ability
to deal with dual types.

Can I put your reviewed-by if I make a v2 of this patch?

Thank you for your help.

Ping
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
