From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH 4/4] input - wacom: Support 2FGT in MT format
Date: Fri, 11 Feb 2011 13:07:44 -0800
Message-ID: <AANLkTinmUVW+cK1PJnCxiLSv1DiMQC-KkkeoAHVyckZe@mail.gmail.com>
References: <1297387983-13761-1-git-send-email-pinglinux@gmail.com>
	<20110211202010.GB2287@polaris.bitmath.org>
	<AANLkTimBPBDCBzw0fbDpLf8F7N_zG+ceKJAC9Li15g5P@mail.gmail.com>
	<20110211204742.GD2287@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:52400 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758107Ab1BKVHp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Feb 2011 16:07:45 -0500
Received: by wwa36 with SMTP id 36so3023030wwa.1
        for <linux-input@vger.kernel.org>; Fri, 11 Feb 2011 13:07:44 -0800 (PST)
In-Reply-To: <20110211204742.GD2287@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: linux-input@vger.kernel.org

On Fri, Feb 11, 2011 at 12:47 PM, Henrik Rydberg <rydberg@euromail.se> =
wrote:
>> >> +static int wacom_tpc_mt_touch(struct wacom_wac *wacom)
>> >> +{
>> >> + =A0 =A0 struct input_dev *input =3D wacom->input;
>> >> + =A0 =A0 unsigned char *data =3D wacom->data;
>> >> + =A0 =A0 int i;
>> >> +
>> >> + =A0 =A0 if (wacom->shared->stylus_in_proximity && !wacom->share=
d->touch_down)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> >
>> > Seeing one case handled out of four possible always makes me nervo=
us.
>>
>> The above statement is to avoid going through the input_mt_slot and
>> input_mt_report_slot_state routines without posting any meaningful
>> events. I guess it could be considered as a performance enhancement?
>
> It won't be posting events unless something changed.

But it still go through the  input_mt_slot and
input_mt_report_slot_state routines, which is unnecessary. If we know
up front there is no events posting, what benefit do we get to go
through the routines?

>> Which case makes you nervous? I'll take care of it ;).
>
> Well, removing the logic above would suffice. :-)

Yeah, I see one benefit here ;). I can remove that if others see the sa=
me issue.

>> > So only false->true is possible here.
>>
>> Yeah, both are bools. What else can they take?
>
> Only the transition false-to-true, that is.
>
>> > What I can see from the patchset, only wacom_tpc_single_touch() wi=
ll ever set touch_down to
>> > false. Is that sufficient?
>>
>> No, =A0wacom_tpc_mt_touch can set touch_down to false too. When touc=
h is
>> false, touch_down will be false. This happens when pen in prox or wh=
en
>> both fingers are up.
>
> Now, that is what cannot happen, because of the max() function.

This time is real. How about this one?


diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wa=
com_wac.c
index 39c289d..3cdafb9 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -699,7 +699,10 @@ static int wacom_tpc_mt_touch(struct wacom_wac *wa=
com)
                }

                /* keep touch bit to send proper touch up event */
-               wacom->shared->touch_down =3D max(touch,
wacom->shared->touch_down);
+               if (i =3D=3D 1)
+                       wacom->shared->touch_down =3D max(touch,
wacom->shared->touch_down);
+               else
+                       wacom->shared->touch_down =3D touch;
        }

        input_mt_report_pointer_emulation(input, true);

---------

Thank you.

Ping
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
