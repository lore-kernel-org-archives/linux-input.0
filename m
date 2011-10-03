From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [PATCH V3 1/3] Input: cyttsp - Cypress TTSP capacitive
 multi-touch screen support
Date: Mon, 3 Oct 2011 23:38:33 +0200
Message-ID: <CAAwP0s1hEOkidUK48cDf4DhSKN=PwxkLmHHpAVSZ6kPp7bhE=A@mail.gmail.com>
References: <1316311297-12765-1-git-send-email-martinez.javier@gmail.com>
 <1316311297-12765-2-git-send-email-martinez.javier@gmail.com> <20110927115207.GA3701@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:55083 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757157Ab1JCViy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Oct 2011 17:38:54 -0400
Received: by gyg10 with SMTP id 10so3849959gyg.19
        for <linux-input@vger.kernel.org>; Mon, 03 Oct 2011 14:38:54 -0700 (PDT)
In-Reply-To: <20110927115207.GA3701@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>, Kevin McNeely <kev@cypress.com>, Mohan Pallaka <mpallaka@codeaurora.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Tue, Sep 27, 2011 at 1:52 PM, Henrik Rydberg <rydberg@euromail.se> w=
rote:
> Hi Javier,
>
>> Cypress TrueTouch(tm) Standard Product controllers are found in
>> a wide range of embedded devices. This driver add support for a
>> variety of TTSP controllers.
>
> please find some comments below.
>

Hello Henrik,

I solved most of the issues you point me out, I have just a small
question about one of them:

>> + =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 for (i =3D 0; i < CY_MAX_ID; i++) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ts->slot_prev[i] =3D=
=3D CY_USED &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ts->slot_c=
urr[i] =3D=3D CY_UNUSED)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 cyttsp_report_slot_empty(ts->input, i);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ts->slot_prev[i] =3D ts-=
>slot_curr[i];
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ts->slot_curr[i] =3D CY_=
UNUSED;
>> + =C2=A0 =C2=A0 }
>
> Input core handles duplicate calls, so the above could be simplified.
>

That means that the input MT is able to handle duplicates and I can
send the state of all the contacts and it will be able to identify the
deltas to send to user-space? Or do I have to keep the deltas and only
call input_mt_report_slot_state() when I detect that a finger that was
previously down was lifted?

To be more precise, the correct approach is:

	for (i =3D 0; i < CY_MAX_ID; i++)
		if (!(used & (1 << i)))
			cyttsp_report_slot_empty(ts->input, i);

or

	for (i =3D 0; i < CY_MAX_ID; i++)
		if (previous & (1 << i) &&
		    !(used & (1 << i)))
			cyttsp_report_slot_empty(ts->input, i);

where used is a bitmask to store each contact state for this event and
previous is a bitmask to store the state for the previous event.

I looked at input_mt_report_slot_state() and it seems that it only
checks whether the active parameter to send an ABS_MT_TRACKING_ID -1
input event, so I think that I should use the latter.

Thank you and best regards,

--=20
Javier Mart=C3=ADnez Canillas
(+34) 682 39 81 69
Barcelona, Spain
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
