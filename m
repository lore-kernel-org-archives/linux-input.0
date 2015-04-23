From: Ellen Wang <ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCH v1] HID: bug fixes in hid-cp2112 driver
Date: Thu, 23 Apr 2015 14:46:03 -0700
Message-ID: <5539681B.2030700@cumulusnetworks.com>
References: <1429143746-16967-1-git-send-email-ellen@cumulusnetworks.com> <20150416074158.GA913@katana> <552F73A8.5060605@cumulusnetworks.com> <20150422080327.GG1511@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150422080327.GG1511@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: dbarksdale-2SNLKkHU5xRBDgjK7y7TUQ@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

I've separated out the cp2112_i2c_xfer() bug fix from the patch.  Should 
I submit it as v2 or a new patch altogether?

Thanks.

On 4/22/2015 1:03 AM, Wolfram Sang wrote:
>
>>> Well, at24 detects how many bytes it got and continues from there.
>>
>> That's true, but instead of returning short, the old
>> cp2112_i2c_xfer() fails out (with EIO) when the first USB operation
>> doesn't return all the bytes.  Look for "short read: %d < %d" in
>> the original version.  That's just broken.
>
> Yes.
>
>>> This shows the drawback of having I2C master drivers not in the
>>> i2c-directory: It easily misses updates to the i2c-core.
>>> We now have the i2c-quirk infrastructure (2187f03a9576c4) which this
>>> driver should make use of. It can describe this...
>>>
>>>> +    for (m = msgs; m < msgs + num; m++) {
>>>> +        /*
>>>> +         * If the top two messages are a write followed by a read,
>>>> +         * then we do them together as CP2112_DATA_WRITE_READ_REQUEST.
>>>> +         * Otherwise, process one message.
>>>> +         */
>>>> +
>>>
>>> and this and the core will check the messages for you. It should
>>> simplify your code, too.
>>
>> I didn't know about that.  Cumulus Linux is based on 3.2.something
>> (debian wheezy) and i2c-quirk came in after that.
>
> Well, actually, it came with this merge window :)
>
>> I can update the driver to use the quirk mechanism, but I would
>> prefer to do that as a separate checkin, so Cumulus can use
>> a version of hid-cp2112.c that exists somewhere in mainline
>> even if it's not the latest.
>
> Fine with me if you do the i2c-quirk update as a seperate patch.
>
