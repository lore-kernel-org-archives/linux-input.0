From: Miguel Aguilar <miguel.aguilar@ridgerun.com>
Subject: Re: [PATCH 1/3] Input: DaVinci Key Scan Driver
Date: Wed, 30 Sep 2009 07:40:24 -0600
Message-ID: <4AC35FC8.9010108@ridgerun.com>
References: <1253811202-21407-1-git-send-email-miguel.aguilar@ridgerun.com>	<B85A65D85D7EB246BE421B3FB0FBB59301DDAB3271@dbde02.ent.ti.com>	<4ABCD1E8.5000200@ridgerun.com>	<B85A65D85D7EB246BE421B3FB0FBB59301DDAB36C3@dbde02.ent.ti.com>	<0554BEF07D437848AF01B9C9B5F0BC5D92C8EBC0@dlee01.ent.ti.com>	<4ABCD78B.5050605@ridgerun.com>	<20090928170231.GD21455@core.coreip.homeip.net>	<0554BEF07D437848AF01B9C9B5F0BC5D92D13959@dlee01.ent.ti.com> <87iqf1v3zb.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.navvo.net ([74.208.67.6]:47345 "EHLO mail.navvo.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751697AbZI3NkV (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Sep 2009 09:40:21 -0400
In-Reply-To: <87iqf1v3zb.fsf@deeprootsystems.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Paulraj, Sandeep" <s-paulraj@ti.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "clark.becker@ridgerun.com" <clark.becker@ridgerun.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "santiago.nunez@ridgerun.com" <santiago.nunez@ridgerun.com>, "todd.fischer@ridgerun.com" <todd.fischer@ridgerun.com>

Kevin Hilman wrote:
> "Paulraj, Sandeep" <s-paulraj@ti.com> writes:
> 
>>> On Fri, Sep 25, 2009 at 08:45:31AM -0600, Miguel Aguilar wrote:
>>>>>>>>> +     /* Enable Keyscan module and enable */
>>>>>>>>> +     davinci_ks_write(davinci_ks, DAVINCI_KEYSCAN_AUTODET |
>>>>>> DAVINCI_KEYSCAN_KEYEN,
>>>>>>>>> +                     DAVINCI_KEYSCAN_KEYCTRL);
>>>>>>>> We seem to be hardcoded to the 4x4 matrix type here.
>>>>>>>> Some DM365 boards could use 5x3 matrix.
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Sekhar
>>>>>>>>
>>>>>>> [MA] I will add a platform option for matrix type to choose 4x4 or
>>> 5x3
>>>>>> matrix.
>>>>>>> What do think about this?
>>>>>>>
>>>>>> Sounds good. I am not sure if any other piece of code
>>>>>> needs to change though.
>>>>> The strobe and interval have to change.  Afcourse that change comes
>>> into the picture only when the mode is changed from 4x4 to 5x3.
>>>>> I can see that there are options given for this in board specific code.
>>>>>> Thanks,
>>>>>> Sekhar
>>>>> Thanks,
>>>>> Sandeep
>>>>>
>>>> struct davinci_ks_platform_data {
>>>> 	unsigned short	*keymap;
>>>> 	u32		keymapsize;
>>>> 	u32		rep:1;
>>>> 	u32		strobe;
>>>> 	u32		interval;
>>>> +	u32		matrix_type;
>>>> };
>>>>
>>>> I will add something like this, so from the board specific code you can
>>>> define strobe, interval and matrix type.
>>> Make it enum at least. BTW, is it possible to add u8 rows, cols instead
>>> and be able to handle more matrix variations?
>> The IP can handle only 4x4 or 5x3.
>>
> 
> Even so, the rows, cols approach is more readable IMO.
>
The key sacan mode is set just by one bit 4X4 or 5X3, Is it really necessary use 
rows and cols in this case?
> Kevin
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


