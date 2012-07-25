From: Tai-hwa Liang <avatar@sentelic.com>
Subject: Re: [PATCH] Input: sentelic - filtering out erratic movement
Date: Wed, 25 Jul 2012 18:22:26 +0800 (CST)
Message-ID: <1207251810289.28223@cnaqrzbavhz.fragryvp.pbz>
References: <1341553769-30324-1-git-send-email-avatar@sentelic.com>
 <20120725070837.GA15997@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hermod.sentelic.com ([203.69.18.19]:32896 "EHLO
	hermod.sentelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754192Ab2GYKWl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Jul 2012 06:22:41 -0400
In-Reply-To: <20120725070837.GA15997@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Wed, 25 Jul 2012, Dmitry Torokhov wrote:
> Hi Tai-hwa,
>
> On Fri, Jul 06, 2012 at 01:49:29PM +0800, Tai-hwa Liang wrote:
>> It turns out that certain hardware sometime generates unexpected movement
>> during normal operation. This patch tries to filter out these erratic
>> movements which will cause unexpected cursor jumping to the top-left corner.
>>
>> This patch also tries to fix jumpy(back and forth) scrolling in X11 by
>> accumulating both fingers' coordinates before reporting to the input-mt layer.
[...]
>> @@ -721,64 +721,100 @@ static psmouse_ret_t fsp_process_byte(struct psmouse *psmouse)
>>
>>  	switch (psmouse->packet[0] >> FSP_PKT_TYPE_SHIFT) {
>>  	case FSP_PKT_TYPE_ABS:
>> +		if ((packet[0] == 0x48 || packet[0] == 0x49) &&
>> +		    packet[1] == 0 && packet[2] == 0) {
>> +			/*
>> +			 * filtering out erratic movement which will cause
>> +			 * unexpected cursor jumping to the top-left corner
>> +			 */
>> +			packet[3] &= 0xf0;
>> +		}
>
> I am not sure if I understand this patch. According to the documentation
> the above values for the packet[0] have the 'valid' bit 0 which means
> that the touch data should be completely ignored instead of massaging
> data like you seem to be doing.

   I was thinking about keeping external button events for this case;
however, given that there is no input_report_key() for such events
(honestly, I don't even know any Real World setup for these),
a quick 'return PSMOUSE_FULL_PACKET;' should be enough.

> Overall I wonder if you want to increase the size of the buffer to hold
> both packets (for both fingers) and analyze both of them together...

   Would you please elaborate this a little more?  For now mfmc_[xy]1 are
used to store one finger such that driver can report both figners'
coordinates at once.  If you're referring to erratic movement packet like
the above, filtering one at a time should be enough since they can be
considered as sporadic noise input.

> It also appears that the patch does too many things at one and should be
> split into several addressing individual issues.

   Sure. I'll split jumping to top-left corner and jumpy X11 scrolling into
two different patches.

-- 
Thanks,

Tai-hwa Liang
