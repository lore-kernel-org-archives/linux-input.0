From: Antonio Borneo <borneo.antonio-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v1] HID: support multiple and large i2c transfers in hid-cp2112
Date: Sat, 30 May 2015 13:23:42 +0800
Message-ID: <CAAj6DX0tUto6fBp4okFQNjL66UtktEZSH+VDmRYszsA=rjR5HQ@mail.gmail.com>
References: <1429825766-19594-1-git-send-email-ellen@cumulusnetworks.com>
	<CAAj6DX38Op1NkF==6L5Y=Fcm5puOgK7N=aK4NQ9u8G1gK-KB_w@mail.gmail.com>
	<5568A2A7.5090203@cumulusnetworks.com>
	<CAAj6DX2LC8EP8niRPgwXuehGqmOySSuPMe88Aa+hTqr7ry+eXQ@mail.gmail.com>
	<55694361.4000404@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55694361.4000404-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ellen Wang <ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
Cc: David Barksdale <dbarksdale-2SNLKkHU5xRBDgjK7y7TUQ@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Sat, May 30, 2015 at 12:58 PM, Ellen Wang <ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org> wrote:
> On 05/29/2015 08:38 PM, Antonio Borneo wrote:
>>
>> On Sat, May 30, 2015 at 1:32 AM, Ellen Wang <ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
>> wrote:
>>>
>>>
>>> On 05/29/2015 09:28 AM, Antonio Borneo wrote:
>>>>
>>>>
>>>> CP2112 is not able to combine messages since unable to repeat the start
>>>> bits.
>>>> It can only send simple transfers or a combined read-after-write.
>>>>
>>>> Here you cannot simply loop on all the messages and send them one by
>>>> one because there is no way to force the repeated start bit in
>>>> between.
>>>> You can find more details in this thread about CP2112
>>>> https://lkml.org/lkml/2015/3/15/64
>>>> and here info about the repeated start bit under "Combined transactions"
>>>> Documentation/i2c/i2c-protocol
>>>>
>>>> Anyway your idea to introduce read-after-write is valid.
>>>> I suggest you to check the drivers i2c-opal.c and i2c-pmcmsp.c ; at a
>>>> quick check I think they have similar limitation as CP2112.
>>>> You could replicate the same check, supporting only num==1 (always)
>>>> and num==2 (only if msg[0] is write and msg[1] is read).
>>>>
>>>> Best Regards,
>>>> Antonio
>>>
>>>
>>>
>>> It don't think the code attempts to generate repeated start.  It simply
>>> issues and completes each message as separate transfers.  It's not
>>> different
>>> from calling cp2112_i2c_xfer() repeatedly with single messages, except in
>>> the bracketing hid_hw_power().
>>
>>
>> cp2112_i2c_xfer() is the lower level side of i2c_transfer().
>> i2c_transfer() requires that only one Stop bit is sent at the end of
>> last message. Between messages a repeated start is mandatory.
>> In general case, CP2112 cannot do that, that's why the original code
>> returns error if num != 1
>>
>> It's not correct to issue each message as separate transfer inside
>> cp2112_i2c_xfer(); the caller of i2c_transfer() expects the messages
>> to be sent with repeated start.
>>
>> With you patch you highlight that there is another case that should be
>> implemented.
>> CP2112 can handle the case of num==2 when msg[0] is write and msg[1] is
>> read.
>> There are other devices with similar limitations, as I pointed above.
>>
>> Extending cp2112_i2c_xfer() to support a combined read-after-write is
>> ok, while issuing each message without forcing repeated start is
>> incorrect.
>>
>> Best Regards,
>> Antonio
>
>
> OK.  I neglected to read the later messages in the thread you pointed me to.
> Oddly, I submitted my patch weeks before that thread, and was given exactly
> the opposite feedback, which was that the fix was fine in principle (but I
> should separate out some unrelated bug fixes).  And I agreed to using the
> quirks mechanism in a later patch.
>
> Do you already have a patch that addresses the whole issue?  I just rewrote
> my code to handle single messages and the write-read case, as you suggested.

No, I don't have any other patches for cp2112. Would we great to
receive a V2 from you.

Thanks
Antonio
