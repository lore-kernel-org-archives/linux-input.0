From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH 05/12] Input: synaptics - process button bits in AGM packets
Date: Tue, 5 Jul 2011 12:38:16 +0800
Message-ID: <CAGS+omALkYhzS+rvWhsXCwuWMHWpJJJ7j9Z9cBQ1Gem5HnH_fg@mail.gmail.com>
References: <1309324042-22943-1-git-send-email-djkurtz@chromium.org>
 <1309324042-22943-6-git-send-email-djkurtz@chromium.org> <20110704212404.GC23915@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:18120 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753152Ab1GEEij convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Jul 2011 00:38:39 -0400
Received: from wpaz33.hot.corp.google.com (wpaz33.hot.corp.google.com [172.24.198.97])
	by smtp-out.google.com with ESMTP id p654cbOG013518
	for <linux-input@vger.kernel.org>; Mon, 4 Jul 2011 21:38:38 -0700
Received: from yxi13 (yxi13.prod.google.com [10.190.3.13])
	by wpaz33.hot.corp.google.com with ESMTP id p654cR75003558
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Mon, 4 Jul 2011 21:38:36 -0700
Received: by yxi13 with SMTP id 13so996237yxi.12
        for <linux-input@vger.kernel.org>; Mon, 04 Jul 2011 21:38:36 -0700 (PDT)
In-Reply-To: <20110704212404.GC23915@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: dmitry.torokhov@gmail.com, chase.douglas@canonical.com, rubini@cvml.unipv.it, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, derek.foreman@collabora.co.uk, daniel.stone@collabora.co.uk, olofj@chromium.org

Hi Henrik,

On Tue, Jul 5, 2011 at 5:24 AM, Henrik Rydberg <rydberg@euromail.se> wr=
ote:
> Hi Daniel,
>
>> AGM packets contain valid button bits, too.
>> This patch refactors packet processing to parse button bits in AGM p=
ackets.
>> However, they aren't actually used or reported.
>>
>> The point is to more completely process AGM packets,
>> and prepare for future patches that may actually use AGM packet butt=
on bits.
>>
>> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
>> ---
>> =A0drivers/input/mouse/synaptics.c | =A0 35 ++++++++++++++++++------=
-----------
>> =A01 files changed, 18 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/s=
ynaptics.c
>> index 1ce47b7..74b1222 100644
>> --- a/drivers/input/mouse/synaptics.c
>> +++ b/drivers/input/mouse/synaptics.c
>> @@ -408,27 +408,10 @@ static int synaptics_parse_hw_state(const unsi=
gned char buf[],
>> =A0 =A0 =A0 memset(hw, 0, sizeof(struct synaptics_hw_state));
>>
>> =A0 =A0 =A0 if (SYN_MODEL_NEWABS(priv->model_id)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 hw->x =3D (((buf[3] & 0x10) << 8) |
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0((buf[1] & 0x0f) << 8) =
|
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0buf[4]);
>> - =A0 =A0 =A0 =A0 =A0 =A0 hw->y =3D INVERT_Y((((buf[3] & 0x20) << 7)=
 |
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0((buf[1] & 0xf0) << 4) =
|
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0buf[5]));
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 hw->z =3D buf[2];
>
> Any particular reason to move these and leave them unassigned for cli=
ckpads?

Yes.  The current implementation incorrectly parses the x, y, z of AGM
packets and assigns junk values to the corresponding fields of the
temporary hw struct.  Luckily, this struct is then just discarded upon
return (synaptics_parse_hw_state returns 1 causing
synaptics_process_packet() to exit immediately).

Instead, this patch parses the w value first to determine the packet
type, and then use this packet type information to parse the remaining
position and pressure fields correctly...

Notice that the "else" clause is taken for SGM packets (w !=3D 2), even
for clickpads.

-Dan

>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 hw->w =3D (((buf[0] & 0x30) >> 2) |
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0((buf[0] & 0x04) >> 1=
) |
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0((buf[3] & 0x04) >> 2=
));
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (SYN_CAP_ADV_GESTURE(priv->ext_cap_0c) =
&& hw->w =3D=3D 2) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Gesture packet: (x, y, =
z) at half resolution */
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 priv->mt.x =3D (((buf[4] &=
 0x0f) << 8) | buf[1]) << 1;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 priv->mt.y =3D INVERT_Y(((=
(buf[4] & 0xf0) << 4)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 | buf[2]) << 1);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 priv->mt.z =3D ((buf[3] & =
0x30) | (buf[5] & 0x0f)) << 1;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> - =A0 =A0 =A0 =A0 =A0 =A0 }
>> -
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 hw->left =A0=3D (buf[0] & 0x01) ? 1 : 0;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 hw->right =3D (buf[0] & 0x02) ? 1 : 0;
>>
>> @@ -451,6 +434,24 @@ static int synaptics_parse_hw_state(const unsig=
ned char buf[],
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hw->down =3D ((buf[0] ^ =
buf[3]) & 0x02) ? 1 : 0;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (SYN_CAP_ADV_GESTURE(priv->ext_cap_0c) =
&& hw->w =3D=3D 2) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Gesture packet: (x, y, =
z) at half resolution */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 priv->mt.x =3D (((buf[4] &=
 0x0f) << 8) | buf[1]) << 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 priv->mt.y =3D INVERT_Y(((=
(buf[4] & 0xf0) << 4)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 | buf[2]) << 1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 priv->mt.z =3D ((buf[3] & =
0x30) | (buf[5] & 0x0f)) << 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hw->x =3D (((buf[3] & 0x10=
) << 8) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0((buf[1=
] & 0x0f) << 8) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0buf[4])=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hw->y =3D INVERT_Y((((buf[=
3] & 0x20) << 7) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0((buf[1] & 0xf0) << 4) |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0buf[5]));
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hw->z =3D buf[2];
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (SYN_CAP_MULTI_BUTTON_NO(priv->ext_ca=
p) &&
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((buf[0] ^ buf[3]) & 0x02)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (SYN_CAP_MULTI_BU=
TTON_NO(priv->ext_cap) & ~0x01) {
>> --
>> 1.7.3.1
>>
>
> Thanks,
> Henrik
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
