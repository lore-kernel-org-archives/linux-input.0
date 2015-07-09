From: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Subject: Re: [PATCH v2] HID: cp2112: support large i2c transfers in hid-cp2112
Date: Thu, 09 Jul 2015 13:37:02 +0530
Message-ID: <559E2BA6.4020904@linaro.org>
References: <1436351118-3360-1-git-send-email-ellen@cumulusnetworks.com> <559D126B.6050505@linaro.org> <559D6738.1050003@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35285 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754041AbbGJLuM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Jul 2015 07:50:12 -0400
Received: by pactm7 with SMTP id tm7so167473881pac.2
        for <linux-input@vger.kernel.org>; Fri, 10 Jul 2015 04:50:11 -0700 (PDT)
In-Reply-To: <559D6738.1050003@cumulusnetworks.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ellen Wang <ellen@cumulusnetworks.com>, borneo.antonio@gmail.com, dbarksdale@uplogix.com, jkosina@suse.cz, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org



On Wednesday 08 July 2015 11:38 PM, Ellen Wang wrote:
>
>
> On 07/08/2015 05:07 AM, Vaibhav Hiremath wrote:
>>
>>
>> On Wednesday 08 July 2015 03:55 PM, Ellen Wang wrote:
>>> cp2112_i2c_xfer() only reads up to 61 bytes, returning EIO
>>> on longers reads.  The fix is to wrap a loop around
>>> cp2112_read() to pick up all the returned data.
>>>
>>> Signed-off-by: Ellen Wang <ellen@cumulusnetworks.com>
>>> ---
>>> This is the updated patch with a check for 0 return from
>>> cp2112_read().  I tested it with a suitable delay in the loop
>>> to trigger the cp2112_raw_event() overrun bug, which must
>>> be fixed before this patch is applied.
>>> ---
>>>   drivers/hid/hid-cp2112.c | 33 ++++++++++++++++++++++++++-------
>>>   1 file changed, 26 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
>>> index 3318de6..e2ffac0 100644
>>> --- a/drivers/hid/hid-cp2112.c
>>> +++ b/drivers/hid/hid-cp2112.c
>>> @@ -509,13 +509,32 @@ static int cp2112_i2c_xfer(struct i2c_adapter
>>> *adap, struct i2c_msg *msgs,
>>>       if (!(msgs->flags & I2C_M_RD))
>>>           goto finish;
>>>
>>> -    ret = cp2112_read(dev, msgs->buf, msgs->len);
>>> -    if (ret < 0)
>>> -        goto power_normal;
>>> -    if (ret != msgs->len) {
>>> -        hid_warn(hdev, "short read: %d < %d\n", ret, msgs->len);
>>> -        ret = -EIO;
>>> -        goto power_normal;
>>> +    for (count = 0; count < msgs->len;) {
>>> +        ret = cp2112_read(dev, msgs->buf + count, msgs->len - count);
>>> +        hid_warn(hdev, "read returned %d for %zd\n",
>>> +             ret, msgs->len - count);
>>
>> Do you always want to throw warning here, unconditionally ?
>
> Yeah.  Sorry.  I had debugging code in my workspace then ran git diff
> with the wrong options.  I'll resend.
>
>>> +        if (ret < 0)
>>> +            goto power_normal;
>>> +        if (ret == 0) {
>>> +            hid_err(hdev, "read returned 0\n");
>>> +            ret = -EIO;
>>> +            goto power_normal;
>>> +        }
>>
>> bit simplified, I guess :)
>>
>> if (ret < 0 || ret == 0) {
>>      hid_err(hdev, "read returned %d", ret);
>>      ret = ret == 0 ? -EIO : ret;
>>      goto power_normal;
>> }
>>
>>
>>> +        count += ret;
>>> +        if (count > msgs->len) {
>>> +            /*
>>> +             * The hardware returned too much data.
>>> +             * This is mostly harmless because cp2112_read()
>>> +             * has a limit check so didn't overrun our
>>> +             * buffer.  Nevertheless, we return an error
>>> +             * because something is seriously wrong and
>>> +             * it shouldn't go unnoticed.
>>> +             */
>>> +            hid_err(hdev, "long read: %d > %zd\n",
>>> +                ret, msgs->len - count + ret);
>>
>> You may want to take another look here.
>> 'ret' will be either,
>>
>>      - ret = msgs->len
>>          Not applicable
>>      - ret > msgs->len
>>          (count > msgs->len) will happen in one single
>>          iteration, and will
>>      - ret < msgs->len
>>          (count > msgs->len) will happen in multiple iterations
>>          where count keeps incrementing based on ret
>>
>> In the 2 scenarios above, I believe you would want to show,
>>
>>      actual read bytes > requested read bytes
>>
>>
>> Am I missing something here?
>
> (count > msgs->len) should never happen, so there's really no predicting
> it.  Or do you mean something else?
>


I meant the message which you are printing above seems wrong to me.

Thanks,
Vaibhav
>
>> Thanks,
>> Vaibhav
>
> Thank you.
