From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH v2] [input-hid] Add hid-egalax driver to the unified
 hid-multitouch framework.
Date: Tue, 8 Mar 2011 10:23:36 +0100
Message-ID: <AANLkTiko_mKgW6fXeAuBY4D5AT_9OHAJnk_mfQEPQVF9@mail.gmail.com>
References: <1299417912.9645.495.camel@itzy>
	<AANLkTimkYHPvn0PqcVyJv1rPTn3F7F8p3+3Y0-4F=MwW@mail.gmail.com>
	<1299564524.2306.18.camel@itzy>
	<20110308080414.GA2888@polaris.bitmath.org>
	<AANLkTimT9q8mo3uW0P7T0B=D4kkE83OB9ycgdJ_muZ2W@mail.gmail.com>
	<20110308091434.GA3282@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:47996 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752406Ab1CHJXi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Mar 2011 04:23:38 -0500
Received: by wwi17 with SMTP id 17so682427wwi.1
        for <linux-input@vger.kernel.org>; Tue, 08 Mar 2011 01:23:36 -0800 (PST)
In-Reply-To: <20110308091434.GA3282@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Richard Nauber <richard.nauber@googlemail.com>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>

On Tue, Mar 8, 2011 at 10:14, Henrik Rydberg <rydberg@euromail.se> wrot=
e:
>> >> =A0struct mt_slot {
>> >> =A0 =A0 =A0 __s32 x, y, p, w, h;
>> >> @@ -63,6 +64,9 @@ struct mt_class {
>> >> =A0 =A0 =A0 __s32 sn_move; =A0/* Signal/noise ratio for move even=
ts */
>> >> =A0 =A0 =A0 __s32 sn_pressure; =A0 =A0 =A0/* Signal/noise ratio f=
or pressure events */
>> >> =A0 =A0 =A0 __u8 maxcontacts;
>> >> + =A0 =A0 __u8 override_logical_limits; =A0/* correct the reporte=
d X/Y range */
>> >> + =A0 =A0 __u32 logical_min[2];
>> >> + =A0 =A0 __u32 logical_max[2];
>> >
>> > Please think about byte alignment here, keeping elements of the sa=
me
>> > size together. Also, the override needs a specific name, given tha=
t it
>> > applies to the whole class, not just the x and y positions. Perhap=
s
>> > the override should be triggered with a quirk instead?
>>
>> I'm not in favor of a quirk in this particular case: the information
>> is already here: max > 0.
>
> Only if min =3D=3D 0, which is far from always the case. And setting =
a
> special value for a special hardware does what a quirk does, so maybe
> it is a quirk after all.
>

I think there is a misunderstanding:
if the class provides max_x (so > 0), or min_x, that means that the
person in charge of adding the driver wants to replace the two values
min/max.
No need for a quirk that will be redundant with the hand-provided value=
s.

It won't change anything to other devices as they do not provide min/ma=
x.

Cheers,
Benjamin
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
