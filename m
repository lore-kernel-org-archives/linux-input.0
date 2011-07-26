From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [PATCH 7/9 v2] Input: synaptics - improved 2->3 finger transition
 handling
Date: Tue, 26 Jul 2011 16:14:46 -0700
Message-ID: <4E2F4A66.1020207@canonical.com>
References: <1311169146-20066-1-git-send-email-djkurtz@chromium.org> <1311169146-20066-8-git-send-email-djkurtz@chromium.org> <4E2A1ECD.3030302@canonical.com> <CAGS+omBCd=e0ACxxTwns8HVNitVOYF-xFrkVmhreOmHQTq_10A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:38112 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752159Ab1GZXOw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Jul 2011 19:14:52 -0400
In-Reply-To: <CAGS+omBCd=e0ACxxTwns8HVNitVOYF-xFrkVmhreOmHQTq_10A@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: dmitry.torokhov@gmail.com, rydberg@euromail.se, rubini@cvml.unipv.it, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, derek.foreman@collabora.co.uk, daniel.stone@collabora.co.uk, olofj@chromium.org

On 07/22/2011 09:36 PM, Daniel Kurtz wrote:
> On Sat, Jul 23, 2011 at 9:07 AM, Chase Douglas
> <chase.douglas@canonical.com> wrote:
>> On 07/20/2011 06:39 AM, djkurtz@chromium.org wrote:
>>> From: Daniel Kurtz <djkurtz@chromium.org>
>>> @@ -800,14 +803,32 @@ static void synaptics_image_sensor_3f(struct synaptics_data *priv,
>>>               break;
>>>       case 2:
>>>               /*
>>> -              * On 2->3 transitions, we are given no indication which finger
>>> -              * was added.
>>> -              * We don't even know what finger the current AGM packet
>>> -              * contained.
>>> +              * After some 3->1 and all 3->2 transitions, we lose track
>>> +              * of which slot is reported by sgm and agm.
>>>                *
>>> -              * So, empty all slots. They get filled on a subsequent 3->3
>>> +              * For 2->3 in this state, empty all slots, and we will guess
>>> +              * (0,1) on a subsequent 0->3.
>>> +              *
>>> +              * To userspace, the resulting transition will look like:
>>> +              *    2:[0,1] -> 0:[-1,-1] -> 3:[0,2]
>>
>> I don't think this should be allowed. We shouldn't be giving userspace
>> wrong information. One could argue that userspace could watch for these
>> transitions, but then I would argue that the driver should be handling
>> this :).
>>
>> I don't know what the best resolution to this issue is, but any
>> transition in the number of fingers must be accurate. In uTouch, we
>> watch for touch count transitions for "continuation" gestures.
> 
> So, you want the count to be accurate.
> But, during these transitions, there is not enough information to
> guarantee all of the following at the same time:
>  (1) finger count
>  (2) track_id
>  (3) finger position

If I had to pick one to give up, it would be the tracking id. It carries
the least useful information for a device that you may not get the whole
touch stream. Semi-mt devices already forsake the tracking id value,
IIRC. The id is always incremented when you create a new slot, but when
you go from 2->3 fingers the ids in the slots stay the same even if the
third finger expands the bounding box.

> Would you prefer an implementation that continued to report count (via
> BTN_TOUCH*) correctly, but dropped down to 0 or 1 MT-B slots when for
> these cases where it could not determine the correct position or track_id
> to report?

That may be doable, but I would prefer to just assume that tracking ids
are not valid when (tracked touches > reported touches).

> It seems like it would be more work for userspace to handle this new way
> than the simulated number-of-touch transitions, where the transient
> states are all normal valid states.

This harkens back to my earlier statements where I said this new
Synaptics protocol is worse than the previous one :).

I agree that the implementation you gave here might be trickier for
userspace, so I'd rather table it unless you feel that the "tracking ids
are meaningless!" solution won't work. If you think there are problems
with that approach, we can re-evaluate.

Thanks!

-- Chase
