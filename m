From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/3] Davinci: DM365: Enable DaVinci Key Scan support
	for DM365 EVM
Date: Mon, 28 Sep 2009 10:02:10 -0700
Message-ID: <20090928170210.GB21455@core.coreip.homeip.net>
References: <1253811240-21437-1-git-send-email-miguel.aguilar@ridgerun.com> <20090925040146.GB416@core.coreip.homeip.net> <4ABCCF30.2090802@ridgerun.com> <4ABCD318.5080307@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:17606 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329AbZI1RCP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Sep 2009 13:02:15 -0400
Received: by fg-out-1718.google.com with SMTP id 22so810994fge.1
        for <linux-input@vger.kernel.org>; Mon, 28 Sep 2009 10:02:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4ABCD318.5080307@ridgerun.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Miguel Aguilar <miguel.aguilar@ridgerun.com>
Cc: nsnehaprabha@ti.com, davinci-linux-open-source@linux.davincidsp.com, linux-input@vger.kernel.org, todd.fischer@ridgerun.com, diego.dompe@ridgerun.com, clark.becker@ridgerun.com, santiago.nunez@ridgerun.com

On Fri, Sep 25, 2009 at 08:26:32AM -0600, Miguel Aguilar wrote:
> Miguel Aguilar wrote:
>> Dmitry Torokhov wrote:
>>> On Thu, Sep 24, 2009 at 10:54:00AM -0600, miguel.aguilar@ridgerun.com 
>>> wrote:
>>>>  +/* Masks for the various keys on the DM365 EVM */
>>>> +#define KEY_DM365_KEY2        0
>>>> +#define KEY_DM365_LEFT        1
>>>> +#define KEY_DM365_EXIT        2
>>>> +#define KEY_DM365_DOWN        3
>>>> +#define KEY_DM365_ENTER        4
>>>> +#define KEY_DM365_UP        5
>>>> +#define KEY_DM365_KEY1        6
>>>> +#define KEY_DM365_RIGHT        7
>>>> +#define KEY_DM365_MENU        8
>>>> +#define KEY_DM365_REC        9
>>>> +#define KEY_DM365_REW        10
>>>> +#define KEY_DM365_SKIPMINUS    11
>>>> +#define KEY_DM365_STOP        12
>>>> +#define KEY_DM365_FF        13
>>>> +#define KEY_DM365_SKIPPLUL    14
>>>> +#define KEY_DM365_PLAYPAUSE    15
>>>> +
>>>> +#ifdef CONFIG_KEYBOARD_DAVINCI
>>>> +static unsigned short dm365evm_keymap[] = {
>>>> +    KEY_DM365_KEY2,
>>>> +    KEY_DM365_LEFT,
>>>> +    KEY_DM365_EXIT,
>>>> +    KEY_DM365_DOWN,
>>>> +    KEY_DM365_ENTER,
>>>> +    KEY_DM365_UP,
>>>> +    KEY_DM365_KEY1,
>>>> +    KEY_DM365_RIGHT,
>>>> +    KEY_DM365_MENU,
>>>> +    KEY_DM365_REC,
>>>> +    KEY_DM365_REW,
>>>> +    KEY_DM365_SKIPMINUS,
>>>> +    KEY_DM365_STOP,
>>>> +    KEY_DM365_FF,
>>>> +    KEY_DM365_SKIPPLUL,
>>>> +    KEY_DM365_PLAYPAUSE,
>>>
>>> These are not standard key codes, why don't you use the ones defined in
>>> linux/input.h?
>>>
>>
>> These keys make sense for the DM365 EVM, they are defined in the board  
>> specific file which is the proper way to do that. Using the standard  
>> keys would be confusing for identifying the real key names defined in  
>> the board itself. Is it really necessary to use the standard keys?, if  
>> not lets keep the board specific names.

These are the codes you send to userspace, you don't want to rewrite it
if you switch to a slightly different keypad module, right? Plus, all
other userspace tools that are already there would be confused when you
present hardware-specific codes in place of standard input keycodes.

> In case that the standard keys should be used what are the proper key 
> codes for these 16 keys?

I am not sure what is the intended purpose of KEY1 and KEY2, the rest
can be mapped easily to input codes (start with removing 'DM365' from
your defines, you'll get most of them correct right there ;) ).

-- 
Dmitry
