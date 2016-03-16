From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH] Input: synaptics - checking Extbit when passing
 ext_buttons to pt_port
Date: Wed, 16 Mar 2016 07:29:01 +0100
Message-ID: <CAN+gG=H_Dj6JPXHbO0j2h0BXPt_NJu8ZppSUumEtyFquHGO9DQ@mail.gmail.com>
References: <1458013522-8139-1-git-send-email-hui.wang@canonical.com>
	<CAN+gG=HCjEtFeCwxmocpD6x1pKrKnxmpQ3GP0GAkhxQhiREo5g@mail.gmail.com>
	<56E8B7E1.7030807@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f53.google.com ([209.85.213.53]:33979 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754348AbcCPG3D (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Mar 2016 02:29:03 -0400
Received: by mail-vk0-f53.google.com with SMTP id e185so49873342vkb.1
        for <linux-input@vger.kernel.org>; Tue, 15 Mar 2016 23:29:03 -0700 (PDT)
In-Reply-To: <56E8B7E1.7030807@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hui Wang <hui.wang@canonical.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>

On Wed, Mar 16, 2016 at 2:33 AM, Hui Wang <hui.wang@canonical.com> wrote:
> On 03/15/2016 10:21 PM, Benjamin Tissoires wrote:
>>
>> Hi Hui,
>>
>> On Tue, Mar 15, 2016 at 4:45 AM, Hui Wang <hui.wang@canonical.com> wrote:
>>>
>>> We found a problem on couples of Lenovo laptop models, when we press
>>> down the extend button of trackstick (IBM trackpoint), the driver will
>>> report both key_down and key_up events to the userspace, while we
>>> release that button, the driver won't report any events to the
>>> userspace.
>>>
>>> Through debugging, we found when we press down or release the extend
>>> button, the hardware will report more than one packets to the driver,
>>> only one packet is valid (Extbit is set to 1), the rest of the
>>> packets only contain zero. The current driver won't drop those
>>> invalid packets but regard them as ext_button packets and pass them
>>> to the pt_port, unfortunately the zero means key release, as a
>>> result the userspace get the key_up event immediately following the
>>> key_down event.
>>>
>>> Adding an Extbit check before passing ext_buttons to pt_port can
>>> drop all invalid packets and fix this problem.
>>>
>>> Signed-off-by: Hui Wang <hui.wang@canonical.com>
>>
>> Could you check if the patch I posted this morning fixes your problem?:
>> https://patchwork.kernel.org/patch/8587101/
>>
>> The issue with yours is that it will change the behavior for all
>> generation of synaptics devices and might introduce regressions.
>>
>> Cheers,
>> Benjamin
>
>
> Yes, it can fix the problem on the machines I tested.
>
> By the way, according to the page 29 of Synaptics PS/2 TouchPad Interfacing
> Guide Rev. B, the extended button event is only reported when Extbit is set
> to 1, I think all generation firmware should follow this guide, why do we
> need to check the firmware version here?
>

That's what I first thought, but Dmitry showed me I was wrong. See
http://www.spinics.net/lists/linux-input/msg36349.html
If the bit is not set, there is no button pressed, so we should release them.

Synaptics was aware of the problem, promised to fix it but it looks
like it fells through the cracks.

Cheers,
Benjamin

>
> Thanks,
> Hui.
>
>
>>
>>> ---
>>>   drivers/input/mouse/synaptics.c | 6 ++++--
>>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/input/mouse/synaptics.c
>>> b/drivers/input/mouse/synaptics.c
>>> index 6025eb4..ad81140 100644
>>> --- a/drivers/input/mouse/synaptics.c
>>> +++ b/drivers/input/mouse/synaptics.c
>>> @@ -880,9 +880,11 @@ static void synaptics_report_ext_buttons(struct
>>> psmouse *psmouse,
>>>          /*
>>>           * This generation of touchpads has the trackstick buttons
>>>           * physically wired to the touchpad. Re-route them through
>>> -        * the pass-through interface.
>>> +        * the pass-through interface. And only pass extend button
>>> +        * events to pt_port when ExtBit is 1.
>>>           */
>>> -       if (!priv->pt_port)
>>> +       if (!priv->pt_port ||
>>> +           !((psmouse->packet[0] ^ psmouse->packet[3]) & 0x02))
>>>                  return;
>>>
>>>          /* The trackstick expects at most 3 buttons */
>>> --
>>> 1.9.1
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-input" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
