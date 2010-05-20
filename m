From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH 2/2] input: mt: Document the MT event slot protocol (rev2)
Date: Wed, 19 May 2010 17:13:34 -0700
Message-ID: <AANLkTinLNuyDDR0ISjOcXDatdXWEN4RIyuXc-3aSz2b3@mail.gmail.com>
References: <1274213429-22667-1-git-send-email-rydberg@euromail.se>
	 <1274213429-22667-2-git-send-email-rydberg@euromail.se>
	 <AANLkTikpmYwEYh5Dh-p3478cDMVo9hXOsDkt54ltHW6J@mail.gmail.com>
	 <4BF4756C.8030204@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:61386 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752810Ab0ETATJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 19 May 2010 20:19:09 -0400
In-Reply-To: <4BF4756C.8030204@seas.upenn.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rafi Rubin <rafi@seas.upenn.edu>
Cc: Henrik Rydberg <rydberg@euromail.se>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Mika Kuoppala <mika.kuoppala@nokia.com>, Peter Hutterer <peter.hutterer@who-t.net>, Benjamin Tissoires <tissoire@cena.fr>, Stephane Chatty <chatty@enac.fr>, Michael Poole <mdpoole@troilus.org>

On Wed, May 19, 2010 at 4:34 PM, Rafi Rubin <rafi@seas.upenn.edu> wrote=
:
> My understanding is that it would be more like
> + =A0 SYN_MT_SLOT 0
> + =A0 ABS_MT_POSITION_X x
> + =A0 ABS_MT_POSITION_Y y
> + =A0 SYN_REPORT
> + =A0 SYN_MT_SLOT 0
> + =A0 ABS_MT_POSITION_X x
> + =A0 ABS_MT_POSITION_Y y
> + =A0 SYN_REPORT
> + =A0 SYN_MT_SLOT 0
> + =A0 ABS_MT_POSITION_X x
> + =A0 ABS_MT_POSITION_Y y
> + =A0 SYN_MT_SLOT 1
> + =A0 ABS_MT_POSITION_X x
> + =A0 ABS_MT_POSITION_Y y
> + =A0 SYN_REPORT

You are right if one slot only has or is only allowed to have one
point. My scenario is that one slot can have more than one point.
Basically, my intention is to utilize the MT_SLOT and MT_TRACKING_ID
in such a way that it avoids as much overlap as possible.

And hopefully it makes sesne in the reality too.

> (2 events from 1 finger, followed by 1 event with both).
>
>
> On 05/19/2010 06:43 PM, Ping Cheng wrote:
>>
>> Hi Henrik,
>>
>> I am trying to link the protocol to the actual multi-touch devices i=
n
>> my "mind". Hope it helps you to point out the mismatch between my
>> imagination and the protocol. =A0Please see details in line.
>>
>> Ping
>>
>> On Tue, May 18, 2010 at 1:10 PM, Henrik Rydberg<rydberg@euromail.se>
>> =A0wrote:
>>>
>>> This patch adds documentation for the SYN_MT_SLOT event and
>>> gives examples of how to use the event slot protocol.
>>
>> Am I right in thinking that SYN_MT_SLOT represents to the actual tou=
ch
>> area/finger on the surface? There could be more than one (x,y) (a fe=
w
>> points that form an irregular shape) that represents one finger. =A0=
The
>> following example shows that slot 0 (finger 1) touched three points =
on
>> the surface while slot 1 (finger 2) only has one point reported:
>>
>> + =A0 SYN_MT_SLOT 0
>> + =A0 ABS_MT_TRACKING_ID 45
>> + =A0 ABS_MT_POSITION_X x[0]
>> + =A0 ABS_MT_POSITION_Y y[0]
>> + =A0 ABS_MT_TRACKING_ID 46
>> + =A0 ABS_MT_POSITION_X x[1]
>> + =A0 ABS_MT_POSITION_Y y[1]
>> + =A0 ABS_MT_TRACKING_ID 47
>> + =A0 ABS_MT_POSITION_X x[2]
>> + =A0 ABS_MT_POSITION_Y y[2]
>> + =A0 SYN_MT_SLOT 1
>> + =A0 ABS_MT_TRACKING_ID 30
>> + =A0 ABS_MT_POSITION_X x[3]
>> + =A0 ABS_MT_POSITION_Y y[3]
>> + =A0 SYN_REPORT
>>
>> If my assumption is correct, i.e., one slot can have more than one
>> point, I would think ABS_MT_TRACKING_ID may not have to be a require=
d
>> entry inside SYN_MT_SLOT. =A0To the user land clients/drivers,
>> SYN_MT_SLOT itself could serve as an ID. So, the following case is
>> also a type B ( we know there are two touch areas. But we don't keep
>> track of the points inside the areas):
>>
>> + =A0 SYN_MT_SLOT 0
>> + =A0 ABS_MT_POSITION_X x[0]
>> + =A0 ABS_MT_POSITION_Y y[0]
>> + =A0 ABS_MT_POSITION_X x[1]
>> + =A0 ABS_MT_POSITION_Y y[1]
>> + =A0 ABS_MT_POSITION_X x[2]
>> + =A0 ABS_MT_POSITION_Y y[2]
>> + =A0 SYN_MT_SLOT 1
>> + =A0 ABS_MT_POSITION_X x[3]
>> + =A0 ABS_MT_POSITION_Y y[3]
>> + =A0 SYN_REPORT
>>
>> So, an EVIO for X driver to retrieve the number of SLOTs would be ve=
ry
>> helpful. =A0Something like the following would do the work:
>>
>> input_set_abs_params(input_dev, ABS_MT_SLOT, 0, 12, 0, 0);
>>
>> which tells the user land clients that they can expect up to 13 touc=
h
>> areas.
>>
>>> +The main difference between the raw type A protocol and the higher=
 level
>>> +type B slot protocol lies in the usage of identifiable contacts. T=
he
>>> slot
>>> +protocol requires the use of the ABS_MT_TRACKING_ID,
>>
>> With what I said above, I think ABS_MT_TRACKING_ID is not the unique
>> identifier for type B protocol. It is the fact that we can identify
>> individual touch areas and use ABS_MT_SLOT to report them that makes
>> it a type B event.
>>
>>> ABS_MT_TRACKING_ID, either provided by the
>>> +hardware of computed from the raw data [5].
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0^^ or =A0(is it?)
>>
>> I agree with this ABS_MT_TRACKING_ID definition. =A0I would think so=
mething
>> like:
>>
>> input_set_abs_params(input_dev, ABS_MT_TRACKING_ID, 0, 47, 0, 0);
>>
>> which tells the clients that total of 48 points are tracked, would b=
e
>> helpful.
>>
>> Another topic that may be irrelevant to this patch is the filter. Wi=
th
>> the use of ABS_MT_TRACKING_ID, a filter can be applied to discard th=
e
>> useless repeated points or less than a certain number of points
>> movement.
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
