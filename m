From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 3/3] input: wacom: Add support for the Bamboo Touch trackpad
 (rev2)
Date: Thu, 02 Sep 2010 23:08:36 +0200
Message-ID: <4C801254.5030605@euromail.se>
References: <1283451517-1711-1-git-send-email-rydberg@euromail.se>	<1283451517-1711-4-git-send-email-rydberg@euromail.se> <AANLkTimBFwXyBDJdaMOyR9OrvZvMD6jtybvLqRqrFWV6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:46612 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757580Ab0IBVKk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 2 Sep 2010 17:10:40 -0400
In-Reply-To: <AANLkTimBFwXyBDJdaMOyR9OrvZvMD6jtybvLqRqrFWV6@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ping Cheng <pingc@wacom.com>, Chris Bagwell <chris@cnpbagwell.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On 09/02/2010 11:02 PM, Ping Cheng wrote:
[...]
>> @@ -1079,6 +1134,31 @@ void wacom_setup_input_capabilities(struct input_dev
*input_dev,

>>         case PENPARTNER:
>>                 __set_bit(BTN_TOOL_RUBBER, input_dev->keybit);
>>                 break;
>> +
>> +       case BAMBOO_PT:
>> +               __clear_bit(ABS_MISC, input_dev->absbit);
>> +
>> +               if (features->device_type != BTN_TOOL_TRIPLETAP)
>> +                       break;
>> +
>> +               __set_bit(BTN_LEFT, input_dev->keybit);
>> +               __set_bit(BTN_MIDDLE, input_dev->keybit);
>> +               __set_bit(BTN_RIGHT, input_dev->keybit);
> 
> An if-else is needed here instead of the break since there is a
> pen-only bamboo model in the market. If you don't have time to update
> it, you can leave it to Chris. He can make the changes when he work on
> the other models.


Thanks, I can see that will make subsequent patches nicer. There will most
likely be another round of patches, I will update it then, and leave the rest to
Chris.

Cheers,
Henrik
