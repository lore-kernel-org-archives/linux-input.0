From: Miguel Aguilar <miguel.aguilar@ridgerun.com>
Subject: Re: [PATCH 2/3] Davinci: DM365: Enable DaVinci Key Scan support	for
 DM365 EVM
Date: Fri, 25 Sep 2009 08:26:32 -0600
Message-ID: <4ABCD318.5080307@ridgerun.com>
References: <1253811240-21437-1-git-send-email-miguel.aguilar@ridgerun.com> <20090925040146.GB416@core.coreip.homeip.net> <4ABCCF30.2090802@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.navvo.net ([74.208.67.6]:36736 "EHLO mail.navvo.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752422AbZIYO0h (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Sep 2009 10:26:37 -0400
In-Reply-To: <4ABCCF30.2090802@ridgerun.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: nsnehaprabha@ti.com, davinci-linux-open-source@linux.davincidsp.com, linux-input@vger.kernel.org, todd.fischer@ridgerun.com, diego.dompe@ridgerun.com, clark.becker@ridgerun.com, santiago.nunez@ridgerun.com

Miguel Aguilar wrote:
> Dmitry Torokhov wrote:
>> On Thu, Sep 24, 2009 at 10:54:00AM -0600, miguel.aguilar@ridgerun.com 
>> wrote:
>>>  
>>> +/* Masks for the various keys on the DM365 EVM */
>>> +#define KEY_DM365_KEY2        0
>>> +#define KEY_DM365_LEFT        1
>>> +#define KEY_DM365_EXIT        2
>>> +#define KEY_DM365_DOWN        3
>>> +#define KEY_DM365_ENTER        4
>>> +#define KEY_DM365_UP        5
>>> +#define KEY_DM365_KEY1        6
>>> +#define KEY_DM365_RIGHT        7
>>> +#define KEY_DM365_MENU        8
>>> +#define KEY_DM365_REC        9
>>> +#define KEY_DM365_REW        10
>>> +#define KEY_DM365_SKIPMINUS    11
>>> +#define KEY_DM365_STOP        12
>>> +#define KEY_DM365_FF        13
>>> +#define KEY_DM365_SKIPPLUL    14
>>> +#define KEY_DM365_PLAYPAUSE    15
>>> +
>>> +#ifdef CONFIG_KEYBOARD_DAVINCI
>>> +static unsigned short dm365evm_keymap[] = {
>>> +    KEY_DM365_KEY2,
>>> +    KEY_DM365_LEFT,
>>> +    KEY_DM365_EXIT,
>>> +    KEY_DM365_DOWN,
>>> +    KEY_DM365_ENTER,
>>> +    KEY_DM365_UP,
>>> +    KEY_DM365_KEY1,
>>> +    KEY_DM365_RIGHT,
>>> +    KEY_DM365_MENU,
>>> +    KEY_DM365_REC,
>>> +    KEY_DM365_REW,
>>> +    KEY_DM365_SKIPMINUS,
>>> +    KEY_DM365_STOP,
>>> +    KEY_DM365_FF,
>>> +    KEY_DM365_SKIPPLUL,
>>> +    KEY_DM365_PLAYPAUSE,
>>
>> These are not standard key codes, why don't you use the ones defined in
>> linux/input.h?
>>
> 
> These keys make sense for the DM365 EVM, they are defined in the board 
> specific file which is the proper way to do that. Using the standard 
> keys would be confusing for identifying the real key names defined in 
> the board itself. Is it really necessary to use the standard keys?, if 
> not lets keep the board specific names.
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

In case that the standard keys should be used what are the proper key codes for 
these 16 keys?
