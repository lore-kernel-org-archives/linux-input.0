From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH 10/12] Input: synaptics - decode AGM packet types
Date: Thu, 7 Jul 2011 00:53:24 +0800
Message-ID: <CAGS+omCdp6x99C1afmimw14Nnep+=Kg6aG0CqWYUKuMa9wt+6Q@mail.gmail.com>
References: <1309324042-22943-1-git-send-email-djkurtz@chromium.org>
 <1309324042-22943-11-git-send-email-djkurtz@chromium.org> <4E135553.3000408@canonical.com>
 <CAGzDe_Y5bK5GkMgKAffPGvcZEEd0Mg199R_8naKqEOGTo-T60w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:58058 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753652Ab1GFQxr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 Jul 2011 12:53:47 -0400
Received: from wpaz5.hot.corp.google.com (wpaz5.hot.corp.google.com [172.24.198.69])
	by smtp-out.google.com with ESMTP id p66Grlhn023090
	for <linux-input@vger.kernel.org>; Wed, 6 Jul 2011 09:53:47 -0700
Received: from gyg4 (gyg4.prod.google.com [10.243.50.132])
	by wpaz5.hot.corp.google.com with ESMTP id p66GrjjJ008403
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Wed, 6 Jul 2011 09:53:46 -0700
Received: by gyg4 with SMTP id 4so98772gyg.39
        for <linux-input@vger.kernel.org>; Wed, 06 Jul 2011 09:53:45 -0700 (PDT)
In-Reply-To: <CAGzDe_Y5bK5GkMgKAffPGvcZEEd0Mg199R_8naKqEOGTo-T60w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Bagwell <chris@cnpbagwell.com>
Cc: Chase Douglas <chase.douglas@canonical.com>, dmitry.torokhov@gmail.com, rydberg@euromail.se, rubini@cvml.unipv.it, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, derek.foreman@collabora.co.uk, daniel.stone@collabora.co.uk, olofj@chromium.org

On Wed, Jul 6, 2011 at 2:55 AM, Chris Bagwell <chris@cnpbagwell.com> wr=
ote:
> On Tue, Jul 5, 2011 at 1:17 PM, Chase Douglas
> <chase.douglas@canonical.com> wrote:
>> On 06/28/2011 10:07 PM, djkurtz@chromium.org wrote:
>>> From: Daniel Kurtz <djkurtz@chromium.org>
>>>
>>> A Synaptics image sensor tracks 5 fingers, but can only report 2.
>>> This behavior is called "T5R2" =3D Track 5 Report 2
>>>
>>> Algorithm for choosing which 2 fingers to report in which packet:
>>> =A0 Touchpad maintains 5 slots, numbered 0 to 4.
>>> =A0 Initially all slots are empty.
>>> =A0 As new fingers are detected, they are assigned the lowest avail=
able
>>> =A0 slot.
>>> =A0 Touchpad always reports:
>>> =A0 =A0 SGM: lowest numbered non-empty slot
>>> =A0 =A0 AGM: highest numbered non-empty slot, if there is one.
>>>
>>> In addition, T5R2 touchpads have a special AGM packet type which re=
ports
>>> the number of fingers currently being tracked, and which finger is =
in
>>> each of the two slots. =A0Unfortunately, these "TYPE=3D2" packets a=
re only used
>>> when more than 3 fingers are being tracked. =A0When less than 4 fin=
gers
>>> are present, the 'w' value must be used to track how many fingers a=
re
>>> present, and knowing which fingers are being reported is much more
>>> difficult, if not impossible.
>>>
>>> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
>>> ---
>>> =A0drivers/input/mouse/synaptics.c | =A0 39 +++++++++++++++++++++++=
+++++++++++-----
>>> =A0drivers/input/mouse/synaptics.h | =A0 =A07 ++++++-
>>> =A0include/linux/input.h =A0 =A0 =A0 =A0 =A0 | =A0 =A01 +
>>> =A03 files changed, 41 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/=
synaptics.c
>>> index 2d7ac0a..19a9b7f 100644
>>> --- a/drivers/input/mouse/synaptics.c
>>> +++ b/drivers/input/mouse/synaptics.c
>>> @@ -401,6 +401,14 @@ static void synaptics_pt_create(struct psmouse=
 *psmouse)
>>> =A0/***************************************************************=
**************
>>> =A0 * =A0 Functions to interpret the absolute mode packets
>>> =A0 ***************************************************************=
*************/
>>> +/* Set AGM-CONTACT finger state */
>>> +static void synaptics_agm_finger_update(struct synaptics_data *pri=
v, int count,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 int sgm, int agm)
>>> +{
>>> + =A0 =A0 priv->agm.finger_count =3D count;
>>> + =A0 =A0 priv->agm.finger_sgm =3D sgm;
>>> + =A0 =A0 priv->agm.finger_agm =3D agm;
>>> +}
>>>
>>> =A0static int synaptics_parse_hw_state(const unsigned char buf[],
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 struct synaptics_data *priv,
>>> @@ -438,11 +446,31 @@ static int synaptics_parse_hw_state(const uns=
igned char buf[],
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((SYN_CAP_ADV_GESTURE(priv->ext_cap_=
0c)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 || SYN_=
CAP_IMAGE_SENSOR(priv->ext_cap_0c))
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && hw->=
w =3D=3D 2) {
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Gesture packet: (x, y,=
 z) at half resolution */
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 priv->agm.x =3D (((buf[4]=
 & 0x0f) << 8) | buf[1]) << 1;
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 priv->agm.y =3D INVERT_Y(=
(((buf[4] & 0xf0) << 4)
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 | buf[2]) << 1);
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 priv->agm.z =3D ((buf[3] =
& 0x30) | (buf[5] & 0x0f)) << 1;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int type; /* Packet type =
*/
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 type =3D (buf[5] & 0x30) =
>> 4;
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (type) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 1:
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Gestur=
e packet: (x, y, z) half resolution */
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 priv->agm=
=2Ew =3D hw->w;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 priv->agm=
=2Ex =3D (((buf[4] & 0x0f) << 8)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 | buf[1]) << 1;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 priv->agm=
=2Ey =3D INVERT_Y((((buf[4] & 0xf0) << 4)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| buf[2]) << 1);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 priv->agm=
=2Ez =3D ((buf[3] & 0x30)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 | (buf[5] & 0x0f)) << 1;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 2:
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Finger=
 slot update */
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 synaptics=
_agm_finger_update(priv, buf[1],
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf[2], buf[4]);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 default:
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hw->x =3D (((buf[3] & 0=
x10) << 8) |
>>> @@ -804,6 +832,7 @@ static void set_input_params(struct input_dev *=
dev, struct synaptics_data *priv)
>>> =A0 =A0 =A0 input_set_abs_params(dev, ABS_PRESSURE, 0, 255, 0, 0);
>>>
>>> =A0 =A0 =A0 if (SYN_CAP_IMAGE_SENSOR(priv->ext_cap_0c)) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(INPUT_PROP_SYNAPTICS_T5R2, dev-=
>propbit);
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_mt_init_slots(dev, SYN_TRACK_SLOT=
_COUNT);
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(dev, ABS_MT_POSITI=
ON_X, XMIN_NOMINAL,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0priv->x_max ?: XMAX_NOMINAL, fuzz, 0);
>>> diff --git a/drivers/input/mouse/synaptics.h b/drivers/input/mouse/=
synaptics.h
>>> index 1de2256..2214af6 100644
>>> --- a/drivers/input/mouse/synaptics.h
>>> +++ b/drivers/input/mouse/synaptics.h
>>> @@ -122,7 +122,7 @@
>>> =A0#define SYN_SLOT_AGM =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 2
>>>
>>> =A0/* number of tracking slots for Image Sensor firmware */
>>> -#define SYN_TRACK_SLOT_COUNT =A0 =A0 =A0 =A0 2
>>> +#define SYN_TRACK_SLOT_COUNT =A0 =A0 =A0 =A0 5
>>>
>>> =A0/*
>>> =A0 * A structure to describe the state of the touchpad hardware (b=
uttons and pad)
>>> @@ -140,6 +140,11 @@ struct synaptics_hw_state {
>>> =A0 =A0 =A0 unsigned int down:1;
>>> =A0 =A0 =A0 unsigned char ext_buttons;
>>> =A0 =A0 =A0 signed char scroll;
>>> +
>>> + =A0 =A0 /* Reported in AGM-CONTACT packets */
>>> + =A0 =A0 unsigned int finger_count; =A0 =A0 =A0 =A0 =A0 =A0 =A0/* =
num fingers being tracked */
>>> + =A0 =A0 unsigned int finger_sgm; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/=
* finger described by sgm */
>>> + =A0 =A0 unsigned int finger_agm; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/=
* finger described by agm */
>>> =A0};
>>>
>>> =A0struct synaptics_data {
>>> diff --git a/include/linux/input.h b/include/linux/input.h
>>> index 771d6d8..732c14e 100644
>>> --- a/include/linux/input.h
>>> +++ b/include/linux/input.h
>>> @@ -137,6 +137,7 @@ struct input_keymap_entry {
>>> =A0#define INPUT_PROP_DIRECT =A0 =A0 =A0 =A0 =A0 =A00x01 =A0 =A0/* =
direct input devices */
>>> =A0#define INPUT_PROP_BUTTONPAD =A0 =A0 =A0 =A0 0x02 =A0 =A0/* has =
button(s) under pad */
>>> =A0#define INPUT_PROP_SEMI_MT =A0 =A0 =A0 =A0 =A0 0x03 =A0 =A0/* to=
uch rectangle only */
>>> +#define INPUT_PROP_SYNAPTICS_T5R2 =A0 =A00x04 =A0 =A0/* synaptics =
track 5 report 2 */
>>>
>>> =A0#define INPUT_PROP_MAX =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 0x1f
>>> =A0#define INPUT_PROP_CNT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 (INPUT_PROP_MAX + 1)
>>
>> I'm trying to understand these later patches for T5R2. There are
>> "hidden" touch slots now. How does userspace tell whether a touch sl=
ot
>> is a hidden touch?
>>
>
> I'm trying to understand as well. =A0If I was a consumer of events an=
d I
> knew touchpad supports 2 touch tracking but 5 finger detection, I'd
> assume:
>
> * ABS_X/Y reports oldest touch and
> BTN_TOOL_DOUBLETAP/TRIPLETAP/QUADTAP reports # of fingers touching
> (ignoring lost of 5 finger for now).
> * ABS_MT_* only contains 2 slots and without SEMI_MT declared.
> BTN_TOOL_* could be used to detect greater than 2 finger touches.
>
> I'm not sure I could guess what to do with 5 slots and how to expect
> touch data to come over them.
>
> Where you saying in the other thread that the 5 slots are to help use=
r
> detect finger transitions and re-act bounces in X/Y accordingly? =A0I=
'm
> assuming they could react in same way to BTN_TOOL_* changes if we can
> extend to 5 finger case?

The "number of active slots" (ie slots with tracking_id !=3D -1) can
also always be used to determine the number of touches.

Given 5 slots, each assigned a slot_id: {0, 1, 2, 3, 4}.
Then:
  (a) the active slot with lowest slot_id contains one valid position
(contact from SGM packet).
  (b) the active slot with highest slot_id contains the other valid
position (contact from AGM packet).
  (c) any active slots between these are "hidden", meaning that their
position data is stale, but they count towards the finger count, and
their tracking_ids stay valid.

The real benefit is what happens when fingers are removed.   Let's say
there are 4 touches: {0, 1, 2, 4}.  Now, if a subset of fingers was
removed {1, 4}, then the T5R2 method could actually identify that
fingers {0, 2} were still being reported.

Curiously if another finger were to get added at this point, it would
become the new hidden finger 1.  This is just how the image sensor
works.

This patchset deduces what the firmware is doing in the kernel, and
T5R2 allows us to use the MT-B protocol to express this state up to
userspace.

Thanks,
-Dan

>
> Chris
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
