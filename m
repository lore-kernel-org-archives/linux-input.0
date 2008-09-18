From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH 1/5] HID: move pantherlord FF processing
Date: Thu, 18 Sep 2008 10:41:08 +0200
Message-ID: <48D21424.9030807@gmail.com>
References: <1220533187-21848-1-git-send-email-jirislaby@gmail.com> <alpine.LNX.1.10.0809171900030.19221@pegasus.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.190]:5734 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753209AbYIRIlP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Sep 2008 04:41:15 -0400
Received: by mu-out-0910.google.com with SMTP id g7so2683675muf.1
        for <linux-input@vger.kernel.org>; Thu, 18 Sep 2008 01:41:12 -0700 (PDT)
In-Reply-To: <alpine.LNX.1.10.0809171900030.19221@pegasus.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, Anssi Hannula <anssi.hannula@gmail.com>, linux-kernel@vger.kernel.org

On 09/17/2008 07:03 PM, Jiri Kosina wrote:
> On Thu, 4 Sep 2008, Jiri Slaby wrote:
> 
>> Move the force feedback precessing into a separate module.
>>
>> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
> 
>> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
>> index 0784a09..a4d9695 100644
>> --- a/drivers/hid/hid-ids.h
>> +++ b/drivers/hid/hid-ids.h
>> @@ -373,6 +373,8 @@
>>  #define USB_DEVICE_ID_QUAD_USB_JOYPAD	0x8800
>>  #define USB_DEVICE_ID_DUAL_USB_JOYPAD	0x8866
>>  
>> +#define USB_VENDOR_ID_GREENASIA		0x0e8f
>> +
>>  #define USB_VENDOR_ID_WISEGROUP_LTD	0x6666
>>  #define USB_VENDOR_ID_WISEGROUP_LTD2	0x6677
>>  #define USB_DEVICE_ID_SMARTJOY_DUAL_PLUS 0x8802
> 
> Could we please preserve alphabetical ordering in hid-ids.h file?

Oops, sorry for that, I tried to sort it numerically not noticing it's sorted
alphabetically.

> Otherwise the series looks good to me, and Anssi didn't complain as well. 
> Could you please rebase it on top of the current HID tree, fix the 
> ordering, and send it to me again, I will apply it?

No problem.

Thanks.
