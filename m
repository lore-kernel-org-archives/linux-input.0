From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 1/1] Input - alps: Fix button reporting on the V2 Alps
 protocol
Date: Thu, 30 Jul 2015 16:18:47 +0200
Message-ID: <55BA3247.3000900@redhat.com>
References: <CANuv8QwPQ1aLvZkC522vmm+_kv7r+f3rwvc=SmjVOvx5XbQUzw@mail.gmail.com>
 <1438202726-5100-1-git-send-email-cpaul@redhat.com>
 <1438202726-5100-2-git-send-email-cpaul@redhat.com>
 <55BA2BDD.90108@redhat.com> <20150730141132.GC26714@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57115 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751287AbbG3OSu (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 30 Jul 2015 10:18:50 -0400
In-Reply-To: <20150730141132.GC26714@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>
Cc: cpaul@redhat.com, Douglas Christman <douglaschristman@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi,

On 30-07-15 16:11, Pali Roh=C3=A1r wrote:
> On Thursday 30 July 2015 15:51:25 Hans de Goede wrote:
>> Hi Chandler,
>>
>> On 29-07-15 22:45, cpaul@redhat.com wrote:
>>> From: Stephen Chandler Paul <cpaul@redhat.com>
>>>
>>> The data concerning which buttons on the touchpad are held down or =
not
>>> are in the fourth packet we receive from the mouse, not the first.
>>>
>>> Signed-off-by: Stephen Chandler Paul <cpaul@redhat.com>
>>> ---
>>>   drivers/input/mouse/alps.c | 6 +++---
>>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.=
c
>>> index 113d6f1..e2f9b25 100644
>>> --- a/drivers/input/mouse/alps.c
>>> +++ b/drivers/input/mouse/alps.c
>>> @@ -254,9 +254,9 @@ static void alps_process_packet_v1_v2(struct ps=
mouse *psmouse)
>>>   	/* Non interleaved V2 dualpoint has separate stick button bits *=
/
>>>   	if (priv->proto_version =3D=3D ALPS_PROTO_V2 &&
>>>   	    priv->flags =3D=3D (ALPS_PASS | ALPS_DUALPOINT)) {
>>> -		left |=3D packet[0] & 1;
>>> -		right |=3D packet[0] & 2;
>>> -		middle |=3D packet[0] & 4;
>>> +		left |=3D packet[3] & 1;
>>> +		right |=3D packet[3] & 2;
>>> +		middle |=3D packet[3] & 4;
>>>   	}
>>>
>>>   	alps_report_buttons(dev, dev2, left, right, middle);
>>
>> Thanks for taking a look at the recordings, but the above patch is w=
rong,
>> if you look slightly higher in the lps_process_packet_v1_v2() functi=
on there
>> is this:
>>
>> if (priv->proto_version =3D=3D ALPS_PROTO_V1) {
>> ...
>> } else {
>> 	left =3D packet[3] & 1;
>> 	right =3D packet[3] & 2;
>> 	middle =3D packet[3] & 4;
>> }
>>
>> So with your patch for the devices in question the entire code flow
>> becomes:
>>
>> 	left =3D packet[3] & 1;
>> 	right =3D packet[3] & 2;
>> 	middle =3D packet[3] & 4;
>> 	left |=3D packet[3] & 1;
>> 	right |=3D packet[3] & 2;
>> 	middle |=3D packet[3] & 4;
>>
>> Which is not really helpful for the devices for which I added
>> commit 92bac83dd:
>>
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/comm=
it/drivers/input/mouse/alps.c?id=3D92bac83dd79e60e65c475222e41a992a7043=
4beb
>>
>> and will cause these devices to regress.
>>
>> Since Hans de Bruin's laptop is a Dell Latitude D430 and I saw
>> the same problem and tested my patch on a Dell Latitude D630,
>> it seems the use of the low bits of packet[0] to report the
>> trackpoint buttons separately when the touchpad is active is
>> a Dell specific thing, so I believe that a patch to only
>> activate this code block on Dell's is the right solution for
>> the regression Douglas is seeing.
>>
>> I'll write such a patch and post it shortly.
>>
>> Regards,
>>
>> Hans
>>
>>
>>
>
> Hans, can you check ec and e7 registers if are same or if they differ=
s?

As Benjamin already pointed out Douglas' touchpad matches this
line in alps.c :

{ { 0x22, 0x02, 0x14 }, 0x00, { ALPS_PROTO_V2, 0xff, 0xff, ALPS_PASS | =
ALPS_DUALPOINT } },      /* Dell Latitude D600 */

This is a full match, and note the "Dell" in the comment after the line=
,
so it seems that going by the registers is not good enough here, wherea=
s
doing a vendor check is actually quite easy, so the patch I just
send.

Regards,

Hans


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
