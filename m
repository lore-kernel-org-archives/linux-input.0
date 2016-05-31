From: Cameron Gutman <aicommander@gmail.com>
Subject: Re: [PATCH] Input: xpad - fix rumble on Xbox One controllers with
 2015 firmware
Date: Tue, 31 May 2016 18:04:18 -0500
Message-ID: <574E1872.80906@gmail.com>
References: <574E0E07.9090303@gmail.com> <20160531223205.GA28457@dtor-ws>
 <574E14F8.6050605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33635 "EHLO
	mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813AbcEaXEU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 31 May 2016 19:04:20 -0400
Received: by mail-oi0-f68.google.com with SMTP id m198so402316oig.0
        for <linux-input@vger.kernel.org>; Tue, 31 May 2016 16:04:20 -0700 (PDT)
In-Reply-To: <574E14F8.6050605@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, rojtberg@gmail.com

Sorry, I realized I didn't directly answer the question you were asking.

To clarify my point,
Valve's rumble code was committed in 2014 for the original Xbox One controller
(before the 2015 firmware existed). It continues to work with the latest
firmware versions. It's our different implementation that isn't working
with the newer firmware.

Thanks,
Cameron


On 05/31/2016 05:49 PM, Cameron Gutman wrote:
> It looks like SteamOS has always used this rumble packet for Xbox One per [0].
> Commit 0604949ce3b9a59c ("Input: xpad - add rumble support for Xbox One
> controller") implemented a different rumble packet than Valve did in
> their fork. Pierre-Loup A. Griffais pushed some of their changes upstream in
> commit 2a6d7527b35cf987 ("Input: xpad - update Xbox One Force Feedback
> Support") but seemed to have missed these differences in the packet format.
> 
> 
> [0]: https://github.com/ValveSoftware/steamos_kernel/commit/f5f73eb889cac32cbabfc40362fe5635a2255836
> 
> On 05/31/2016 05:32 PM, Dmitry Torokhov wrote:
>> Hi Cameron,
>>
>> On Tue, May 31, 2016 at 05:19:51PM -0500, Cameron Gutman wrote:
>>> Xbox One controllers that shipped with or were upgraded to the 2015
>>> firmware discard the current rumble packets we send. This patch changes
>>> the Xbox One rumble packet to a form that the newer firmware will accept.
>>
>> But what do we do with the older devices?
>>
>> Thanks.
>>
>>>
>>> It is based on changes made to support newer Xbox One controllers in
>>> the SteamOS brewmaster-4.1 kernel branch.
>>>
>>> Signed-off-by: Cameron Gutman <aicommander@gmail.com>
>>> ---
>>>  drivers/input/joystick/xpad.c | 16 ++++++++--------
>>>  1 file changed, 8 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
>>> index 804dbcc..923c572 100644
>>> --- a/drivers/input/joystick/xpad.c
>>> +++ b/drivers/input/joystick/xpad.c
>>> @@ -1031,17 +1031,17 @@ static int xpad_play_effect(struct input_dev *dev, void *data, struct ff_effect
>>>  
>>>  	case XTYPE_XBOXONE:
>>>  		packet->data[0] = 0x09; /* activate rumble */
>>> -		packet->data[1] = 0x08;
>>> +		packet->data[1] = 0x00;
>>>  		packet->data[2] = xpad->odata_serial++;
>>> -		packet->data[3] = 0x08; /* continuous effect */
>>> -		packet->data[4] = 0x00; /* simple rumble mode */
>>> -		packet->data[5] = 0x03; /* L and R actuator only */
>>> -		packet->data[6] = 0x00; /* TODO: LT actuator */
>>> -		packet->data[7] = 0x00; /* TODO: RT actuator */
>>> +		packet->data[3] = 0x09;
>>> +		packet->data[4] = 0x00;
>>> +		packet->data[5] = 0x0F;
>>> +		packet->data[6] = 0x00;
>>> +		packet->data[7] = 0x00;
>>>  		packet->data[8] = strong / 512;	/* left actuator */
>>>  		packet->data[9] = weak / 512;	/* right actuator */
>>> -		packet->data[10] = 0x80;	/* length of pulse */
>>> -		packet->data[11] = 0x00;	/* stop period of pulse */
>>> +		packet->data[10] = 0xFF;
>>> +		packet->data[11] = 0x00;
>>>  		packet->data[12] = 0x00;
>>>  		packet->len = 13;
>>>  		packet->pending = true;
>>> -- 
>>> 2.7.4
>>
