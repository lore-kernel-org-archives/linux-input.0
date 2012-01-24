From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: Re: [PATCH v2 1/3] hid-multitouch: add support for trackpads
Date: Tue, 24 Jan 2012 15:34:12 +0100
Message-ID: <CAN+gG=HsiGyCMVHbWm1ri5q5_s8L0Af76B9R8gJVHhKMa8t1FQ@mail.gmail.com>
References: <1326887468-5148-1-git-send-email-benjamin.tissoires@enac.fr>
	<1326887468-5148-2-git-send-email-benjamin.tissoires@enac.fr>
	<20120120160948.GA18530@polaris.bitmath.org>
	<20120120164849.GA6520@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:55576 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756597Ab2AXOeN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Jan 2012 09:34:13 -0500
In-Reply-To: <20120120164849.GA6520@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, Mohamed Ikbel Boulabiar <boulabiar@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Dmitry and Henrik,

Thanks Dmitry for the comment.

I'll do the change as you mentioned and will also remove the
input_mt_report_finger_count call.

Cheers,
Benjamin

On Fri, Jan 20, 2012 at 17:48, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Fri, Jan 20, 2012 at 05:09:48PM +0100, Henrik Rydberg wrote:
>> Hi Benjamin,
>>
>> > @@ -389,9 +404,19 @@ static int mt_input_mapping(struct hid_device=
 *hdev, struct hid_input *hi,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->last_f=
ield_index =3D field->index;
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
>> > =A0 =A0 =A0 =A0 =A0 =A0 }
>> > + =A0 =A0 =A0 =A0 =A0 case HID_DG_TOUCH:
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Legacy devices use TIPSWI=
TCH and not TOUCH.
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Let's just ignore this =
field. */
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
>> > =A0 =A0 =A0 =A0 =A0 =A0 /* let hid-input decide for the others */
>> > =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> >
>> > + =A0 case HID_UP_BUTTON:
>> > + =A0 =A0 =A0 =A0 =A0 code =3D ((usage->hid - 1) & HID_USAGE) + BT=
N_MOUSE;
>>
>> Why '+' here instead of '|' is =A0beyond me...
>
> Because it is an offset for the range. The fact that it is on power 2
> boundary and we can use "|" is purely coincidential here.
>
> Maybe we should even write it as:
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0code =3D BTN_MOUSE + ((usage->hid - 1)=
 & HID_USAGE);
>
> Thanks,
> Dmitry
>
> --
> Dmitry
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
