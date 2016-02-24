From: Richard Pospesel <pospeselr@gmail.com>
Subject: Re: [PATCH] Input: byd - enable absolute mode
Date: Tue, 23 Feb 2016 18:47:28 -0800
Message-ID: <56CD19C0.6090201@gmail.com>
References: <1455754072-16364-1-git-send-email-chris@diamand.org>
 <20160222200553.GC28343@dtor-ws> <56CBE3C3.9020008@gmail.com>
 <20160223180844.GB30638@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:33534 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236AbcBXCr3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Feb 2016 21:47:29 -0500
Received: by mail-pf0-f169.google.com with SMTP id q63so3863728pfb.0
        for <linux-input@vger.kernel.org>; Tue, 23 Feb 2016 18:47:29 -0800 (PST)
In-Reply-To: <20160223180844.GB30638@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Chris Diamand <chris@diamand.org>, linux-input@vger.kernel.org

Hi Dmitry,

On 02/23/2016 10:08 AM, Dmitry Torokhov wrote:
> Hi Richard,
>
> On Mon, Feb 22, 2016 at 08:44:51PM -0800, Richard Pospesel wrote:
>> Hi Dmitry,
>>
>>
>> On 02/22/2016 12:05 PM, Dmitry Torokhov wrote:
>>> Hi Chris,
>>>
>>> On Thu, Feb 18, 2016 at 12:07:52AM +0000, Chris Diamand wrote:
>>>> +
>>>> +	serio_continue_rx(psmouse->ps2dev.serio);
>>>>   }
>>>>
>>>>   static psmouse_ret_t byd_process_byte(struct psmouse *psmouse)
>>>>   {
>>>> -	struct input_dev *dev = psmouse->dev;
>>>> +	struct byd_data *priv = psmouse->private;
>>>> +	u32 now = jiffies_to_msecs(jiffies);
>>>>   	u8 *pkt = psmouse->packet;
>>>>
>>>>   	if (psmouse->pktcnt > 0 && !(pkt[0] & PS2_ALWAYS_1)) {
>>>> @@ -102,53 +292,33 @@ static psmouse_ret_t byd_process_byte(struct psmouse *psmouse)
>>>>
>>>>   	/* Otherwise, a full packet has been received */
>>>>   	switch (pkt[3]) {
>>>> -	case 0: {
>>>> +	case BYD_PACKET_ABSOLUTE:
>>>> +		/* Only use absolute packets for the start of movement. */
>>>> +		if (!priv->touch) {
>>>> +			priv->abs_x = pkt[1] * (BYD_PAD_WIDTH / 256);
>>>> +			priv->abs_y = (255 - pkt[2]) *
>>>> +				      (BYD_PAD_HEIGHT / 256);
>>>> +
>>>> +			/* needed to detect tap */
>>>> +			if (now - priv->last_touch_time > BYD_TOUCH_TIMEOUT_MS)
>>>> +				priv->touch = true;
>>>
>>> This is not correct: it will break when time wraps around. If you need
>>> to store/compare times do it in jiffies and use
>>> time_before()/time_after() API.
>>>
>>> But I am confused why you need this. Can you please explain?
>>>
>>> Thanks.
>>>
>>
>> This does work when time wraps around, unless I've misunderstood you (
>> see: https://ideone.com/OTnMH7 ).  However, I will change this to
>> jiffies since that seems to be the lingua franca for time in the
>> kernel.
>
> Please.
>
>>
>> I went over why this particular time delta check is required earlier
>> in this thread.  For brevity, I'll say this is required to allow
>> "two-finger" scenario where one finger navigates, while the other
>> clicks on the primary mouse button.  I can go into further detail if
>> you like.
>
> Please because I tried going back to earlier messages but I could not
> find detailed explanation for the delay in reporting touch.
>
> Thanks.
>

By default, with 1 finger touching and moving, the touchpad sends a stream of interleaved absolute position (ABS) and relative position (REL) packets.  When using two fingers (for instance, one to move and another to left/right click) the touchpad only sends REl packets.  When the 'navigating' finger stops moving and is lifted up their is only 1 finger touching the pad (but not moving), the touchpad resumes sending ABS packets (but no REL packets since there is  no movement).

This is why only REL packets are used to identify touch.  If both ABS and REL packets implied touch, then when using two fingers the 'touch' event would not end until both fingers are lifted.  However, when a user taps the touchpad, a couple of ABS packets will be received, but no REL packets (as there is no motion).  So, the above timeout logic must exist to detect taps correctly.

best,
-Richard

