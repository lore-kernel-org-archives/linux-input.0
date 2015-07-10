From: Ellen Wang <ellen@cumulusnetworks.com>
Subject: Re: [PATCH v2] HID: cp2112: support large i2c transfers in hid-cp2112
Date: Fri, 10 Jul 2015 13:18:42 -0700
Message-ID: <55A028A2.3040204@cumulusnetworks.com>
References: <1436351118-3360-1-git-send-email-ellen@cumulusnetworks.com> <559D126B.6050505@linaro.org> <559D6738.1050003@cumulusnetworks.com> <559E2BA6.4020904@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:34994 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932612AbbGJUSp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Jul 2015 16:18:45 -0400
Received: by pdrg1 with SMTP id g1so57607749pdr.2
        for <linux-input@vger.kernel.org>; Fri, 10 Jul 2015 13:18:45 -0700 (PDT)
In-Reply-To: <559E2BA6.4020904@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>, borneo.antonio@gmail.com, dbarksdale@uplogix.com, jkosina@suse.cz, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org

On 07/09/2015 01:07 AM, Vaibhav Hiremath wrote:
> ...
>>>> +        count += ret;
>>>> +        if (count > msgs->len) {
>>>> +            /*
>>>> +             * The hardware returned too much data.
>>>> +             * This is mostly harmless because cp2112_read()
>>>> +             * has a limit check so didn't overrun our
>>>> +             * buffer.  Nevertheless, we return an error
>>>> +             * because something is seriously wrong and
>>>> +             * it shouldn't go unnoticed.
>>>> +             */
>>>> +            hid_err(hdev, "long read: %d > %zd\n",
>>>> +                ret, msgs->len - count + ret);
>>>
>>> You may want to take another look here.
>>> 'ret' will be either,
>>>
>>>      - ret = msgs->len
>>>          Not applicable
>>>      - ret > msgs->len
>>>          (count > msgs->len) will happen in one single
>>>          iteration, and will
>>>      - ret < msgs->len
>>>          (count > msgs->len) will happen in multiple iterations
>>>          where count keeps incrementing based on ret
>>>
>>> In the 2 scenarios above, I believe you would want to show,
>>>
>>>      actual read bytes > requested read bytes
>>>
>>>
>>> Am I missing something here?
>>
>> (count > msgs->len) should never happen, so there's really no predicting
>> it.  Or do you mean something else?
>>
>
> I meant the message which you are printing above seems wrong to me.

It does print the size of the read request.  I guess I could have 
written it as msgs->len - (count - ret).

Or I'm still missing what you mean.
