From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH 7/9 v2] Input: synaptics - improved 2->3 finger transition handling
Date: Sat, 23 Jul 2011 12:36:28 +0800
Message-ID: <CAGS+omBCd=e0ACxxTwns8HVNitVOYF-xFrkVmhreOmHQTq_10A@mail.gmail.com>
References: <1311169146-20066-1-git-send-email-djkurtz@chromium.org>
 <1311169146-20066-8-git-send-email-djkurtz@chromium.org> <4E2A1ECD.3030302@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:41290 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799Ab1GWEgx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 23 Jul 2011 00:36:53 -0400
Received: from hpaq1.eem.corp.google.com (hpaq1.eem.corp.google.com [172.25.149.1])
	by smtp-out.google.com with ESMTP id p6N4apxc011650
	for <linux-input@vger.kernel.org>; Fri, 22 Jul 2011 21:36:52 -0700
Received: from iyi20 (iyi20.prod.google.com [10.241.51.20])
	by hpaq1.eem.corp.google.com with ESMTP id p6N4anUS001083
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Fri, 22 Jul 2011 21:36:50 -0700
Received: by iyi20 with SMTP id 20so2615258iyi.7
        for <linux-input@vger.kernel.org>; Fri, 22 Jul 2011 21:36:49 -0700 (PDT)
In-Reply-To: <4E2A1ECD.3030302@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: dmitry.torokhov@gmail.com, rydberg@euromail.se, rubini@cvml.unipv.it, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, derek.foreman@collabora.co.uk, daniel.stone@collabora.co.uk, olofj@chromium.org

Hi Chase,

On Sat, Jul 23, 2011 at 9:07 AM, Chase Douglas
<chase.douglas@canonical.com> wrote:
> On 07/20/2011 06:39 AM, djkurtz@chromium.org wrote:
>> From: Daniel Kurtz <djkurtz@chromium.org>
>>
>> As long as we know which slots are currently contained in SGM and AG=
M
>> packets, it is possible to track the slot 0 finger when transitionin=
g from
>> 2->3 fingers. =A0This is the case when fingers are being added one a=
t a
>> time, 1->2->3.
>>
>> However, when fingers are removed, we sometimes lose track of which =
slots
>> are contained in SGM and AGM. In particular, when transitioning from=
 3->2
>> and sometimes 3->1. =A0In both of these cases, we can no longer trac=
k slot 0
>> during 2->3 transitions.
>>
>> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
>> ---
>> =A0drivers/input/mouse/synaptics.c | =A0 33 ++++++++++++++++++++++++=
+++------
>> =A0drivers/input/mouse/synaptics.h | =A0 =A01 +
>> =A02 files changed, 28 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/s=
ynaptics.c
>> index b626b98..893e567 100644
>> --- a/drivers/input/mouse/synaptics.c
>> +++ b/drivers/input/mouse/synaptics.c
>> @@ -659,6 +659,7 @@ static void synaptics_image_sensor_0f(struct syn=
aptics_data *priv,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 struct synaptics_mt_state *mt_state)
>> =A0{
>> =A0 =A0 =A0 synaptics_mt_state_set(mt_state, 0, -1, -1);
>> + =A0 =A0 priv->mt_state_lost =3D false;
>> =A0}
>>
>> =A0/* Handle case where mt_state->count =3D 1 */
>> @@ -726,6 +727,7 @@ static void synaptics_image_sensor_1f(struct syn=
aptics_data *priv,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* So, empty all slots. We will guess =
slot 0 on subsequent 1->1
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 synaptics_mt_state_set(mt_state, 0, -1, =
-1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 priv->mt_state_lost =3D true;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 }
>> =A0}
>> @@ -771,6 +773,7 @@ static void synaptics_image_sensor_2f(struct syn=
aptics_data *priv,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* subsequent 2->2
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 synaptics_mt_state_set(mt_state, 0, -1, =
-1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 priv->mt_state_lost =3D true;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 }
>> =A0}
>> @@ -800,14 +803,32 @@ static void synaptics_image_sensor_3f(struct s=
ynaptics_data *priv,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 case 2:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0* On 2->3 transitions, we are given no =
indication which finger
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0* was added.
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0* We don't even know what finger the cu=
rrent AGM packet
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0* contained.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* After some 3->1 and all 3->2 transiti=
ons, we lose track
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* of which slot is reported by sgm and =
agm.
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0* So, empty all slots. They get filled =
on a subsequent 3->3
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* For 2->3 in this state, empty all slo=
ts, and we will guess
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* (0,1) on a subsequent 0->3.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* To userspace, the resulting transitio=
n will look like:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* =A0 =A02:[0,1] -> 0:[-1,-1] -> 3:[0,2=
]
>
> I don't think this should be allowed. We shouldn't be giving userspac=
e
> wrong information. One could argue that userspace could watch for the=
se
> transitions, but then I would argue that the driver should be handlin=
g
> this :).
>
> I don't know what the best resolution to this issue is, but any
> transition in the number of fingers must be accurate. In uTouch, we
> watch for touch count transitions for "continuation" gestures.

So, you want the count to be accurate.
But, during these transitions, there is not enough information to
guarantee all of the following at the same time:
 (1) finger count
 (2) track_id
 (3) finger position

Would you prefer an implementation that continued to report count (via
BTN_TOUCH*) correctly, but dropped down to 0 or 1 MT-B slots when for
these cases where it could not determine the correct position or track_=
id
to report?

It seems like it would be more work for userspace to handle this new wa=
y
than the simulated number-of-touch transitions, where the transient
states are all normal valid states.

-Daniel

>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> - =A0 =A0 =A0 =A0 =A0 =A0 synaptics_mt_state_set(mt_state, 0, -1, -1=
);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (priv->mt_state_lost) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 synaptics_mt_state_set(mt_=
state, 0, -1, -1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* If the (SGM,AGM) really previously co=
ntained slots (0, 1),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* then we cannot know what slot was jus=
t reported by the AGM,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* because the 2->3 transition can occur=
 either before or after
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* the AGM packet. Thus, this most recen=
t AGM could contain
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* either the same old slot 1 or the new=
 slot 2.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* Subsequent AGMs will be reporting slo=
t 2.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* To userspace, the resulting transitio=
n will look like:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* =A0 =A02:[0,1] -> 1:[0,-1] -> 3:[0,2]
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 synaptics_mt_state_set(mt_state, 1, 0, -1)=
;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 case 3:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> diff --git a/drivers/input/mouse/synaptics.h b/drivers/input/mouse/s=
ynaptics.h
>> index 87be1fe..e3edfea 100644
>> --- a/drivers/input/mouse/synaptics.h
>> +++ b/drivers/input/mouse/synaptics.h
>> @@ -162,6 +162,7 @@ struct synaptics_data {
>> =A0 =A0 =A0 struct serio *pt_port; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
/* Pass-through serio port */
>>
>> =A0 =A0 =A0 struct synaptics_mt_state mt_state; =A0 =A0 /* Current m=
t finger state */
>> + =A0 =A0 bool mt_state_lost; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 /* mt_state may be incorrect */
>>
>> =A0 =A0 =A0 /*
>> =A0 =A0 =A0 =A0* Last received Advanced Gesture Mode (AGM) packet. A=
n AGM packet
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
