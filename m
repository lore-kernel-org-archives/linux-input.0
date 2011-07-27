From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH 7/9 v2] Input: synaptics - improved 2->3 finger transition handling
Date: Wed, 27 Jul 2011 12:48:34 +0800
Message-ID: <CAGS+omAwrXMC=U2Hx7EoJzUM+=PYyR4di0tDhq0oVnR_AAdEhQ@mail.gmail.com>
References: <1311169146-20066-1-git-send-email-djkurtz@chromium.org>
 <1311169146-20066-8-git-send-email-djkurtz@chromium.org> <4E2A1ECD.3030302@canonical.com>
 <CAGS+omBCd=e0ACxxTwns8HVNitVOYF-xFrkVmhreOmHQTq_10A@mail.gmail.com> <4E2F4A66.1020207@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:49701 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750909Ab1G0Es6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 27 Jul 2011 00:48:58 -0400
Received: from wpaz5.hot.corp.google.com (wpaz5.hot.corp.google.com [172.24.198.69])
	by smtp-out.google.com with ESMTP id p6R4mu7W010774
	for <linux-input@vger.kernel.org>; Tue, 26 Jul 2011 21:48:56 -0700
Received: from iyi20 (iyi20.prod.google.com [10.241.51.20])
	by wpaz5.hot.corp.google.com with ESMTP id p6R4mSOB015019
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Tue, 26 Jul 2011 21:48:55 -0700
Received: by iyi20 with SMTP id 20so1466187iyi.7
        for <linux-input@vger.kernel.org>; Tue, 26 Jul 2011 21:48:54 -0700 (PDT)
In-Reply-To: <4E2F4A66.1020207@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: dmitry.torokhov@gmail.com, rydberg@euromail.se, rubini@cvml.unipv.it, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, derek.foreman@collabora.co.uk, daniel.stone@collabora.co.uk, olofj@chromium.org

On Wed, Jul 27, 2011 at 7:14 AM, Chase Douglas
<chase.douglas@canonical.com> wrote:
> On 07/22/2011 09:36 PM, Daniel Kurtz wrote:
>> On Sat, Jul 23, 2011 at 9:07 AM, Chase Douglas
>> <chase.douglas@canonical.com> wrote:
>>> On 07/20/2011 06:39 AM, djkurtz@chromium.org wrote:
>>>> From: Daniel Kurtz <djkurtz@chromium.org>
>>>> @@ -800,14 +803,32 @@ static void synaptics_image_sensor_3f(struct=
 synaptics_data *priv,
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>>> =A0 =A0 =A0 case 2:
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0* On 2->3 transitions, we are given n=
o indication which finger
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0* was added.
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0* We don't even know what finger the =
current AGM packet
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0* contained.
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* After some 3->1 and all 3->2 transi=
tions, we lose track
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* of which slot is reported by sgm an=
d agm.
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0* So, empty all slots. They get fille=
d on a subsequent 3->3
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* For 2->3 in this state, empty all s=
lots, and we will guess
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* (0,1) on a subsequent 0->3.
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* To userspace, the resulting transit=
ion will look like:
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* =A0 =A02:[0,1] -> 0:[-1,-1] -> 3:[0=
,2]
>>>
>>> I don't think this should be allowed. We shouldn't be giving usersp=
ace
>>> wrong information. One could argue that userspace could watch for t=
hese
>>> transitions, but then I would argue that the driver should be handl=
ing
>>> this :).
>>>
>>> I don't know what the best resolution to this issue is, but any
>>> transition in the number of fingers must be accurate. In uTouch, we
>>> watch for touch count transitions for "continuation" gestures.
>>
>> So, you want the count to be accurate.
>> But, during these transitions, there is not enough information to
>> guarantee all of the following at the same time:
>> =A0(1) finger count
>> =A0(2) track_id
>> =A0(3) finger position
>
> If I had to pick one to give up, it would be the tracking id. It carr=
ies
> the least useful information for a device that you may not get the wh=
ole
> touch stream. Semi-mt devices already forsake the tracking id value,
> IIRC. The id is always incremented when you create a new slot, but wh=
en
> you go from 2->3 fingers the ids in the slots stay the same even if t=
he
> third finger expands the bounding box.

=46or synaptics profile sensors, adding additional fingers does not
change which fingers are reported.
You always get the first two fingers.
AFAICT, you cannot "expand the bounding box" by adding new fingers.
Thus, throwing away the track_id is irrelevant, since once the semi-mt
driver starts reporting 2+ fingers, the track_ids are fixed.

The image sensor does not work that way.
As you add new fingers, the trackpad will, under certain conditions,
switch to reporting the locations of these new fingers.
Changing track_id is how we report this to userspace.

>
>> Would you prefer an implementation that continued to report count (v=
ia
>> BTN_TOUCH*) correctly, but dropped down to 0 or 1 MT-B slots when fo=
r
>> these cases where it could not determine the correct position or tra=
ck_id
>> to report?
>
> That may be doable, but I would prefer to just assume that tracking i=
ds
> are not valid when (tracked touches > reported touches).

Userspace is free to make this assumption, of course, but, in fact,
the image sensor trackpad actually does a pretty good job of tracking
the fingers - it just has serious issues reporting them!
Since a track_id change is how userspace is told that the identity of
the reported finger is changing, if the track_id of a finger position
datum is unknowable, I'd rather just discard it in the kernel than
report it to userspace with the wrong track_id.
Otherwise, the heuristics used in the userspace finger tracking
algorithms would need to be overly aggressively tuned to handle this
known error cases:
  2->3 and 3->2 finger transitions look like 2nd finger motion,
instead of reported finger changes.

>
>> It seems like it would be more work for userspace to handle this new=
 way
>> than the simulated number-of-touch transitions, where the transient
>> states are all normal valid states.
>
> This harkens back to my earlier statements where I said this new
> Synaptics protocol is worse than the previous one :).
>
> I agree that the implementation you gave here might be trickier for
> userspace, so I'd rather table it unless you feel that the "tracking =
ids
> are meaningless!" solution won't work. If you think there are problem=
s
> with that approach, we can re-evaluate.
>
> Thanks!
>
> -- Chase

Yes, I feel there are problems with this approach, as I tried to explai=
n above.
Can you explain why you 'continuation gestures' can't handle 1->2->3
finger transitions looking like 1->2->1->3, and 3->2->3 looking like
3->2->0->3?

I think the only real point left to decide is what BTN_* events should
signify during these rare transition states:
  (a) the actually number of fingers on the pad,
  (b) the number of fingers being reported via the slots

The current patchset does (a).
We could do (b), if that would get these patches accepted sooner :)

Thanks!
-Dan
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
