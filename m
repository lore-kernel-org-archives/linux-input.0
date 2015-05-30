From: Ellen Wang <ellen@cumulusnetworks.com>
Subject: Re: [PATCH v1] HID: support multiple and large i2c transfers in hid-cp2112
Date: Fri, 29 May 2015 21:58:09 -0700
Message-ID: <55694361.4000404@cumulusnetworks.com>
References: <1429825766-19594-1-git-send-email-ellen@cumulusnetworks.com>	<CAAj6DX38Op1NkF==6L5Y=Fcm5puOgK7N=aK4NQ9u8G1gK-KB_w@mail.gmail.com>	<5568A2A7.5090203@cumulusnetworks.com> <CAAj6DX2LC8EP8niRPgwXuehGqmOySSuPMe88Aa+hTqr7ry+eXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:34763 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877AbbE3E6M (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 30 May 2015 00:58:12 -0400
Received: by pdbki1 with SMTP id ki1so67853881pdb.1
        for <linux-input@vger.kernel.org>; Fri, 29 May 2015 21:58:11 -0700 (PDT)
In-Reply-To: <CAAj6DX2LC8EP8niRPgwXuehGqmOySSuPMe88Aa+hTqr7ry+eXQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Borneo <borneo.antonio@gmail.com>
Cc: David Barksdale <dbarksdale@uplogix.com>, Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>

On 05/29/2015 08:38 PM, Antonio Borneo wrote:
> On Sat, May 30, 2015 at 1:32 AM, Ellen Wang <ellen@cumulusnetworks.com> wrote:
>>
>> On 05/29/2015 09:28 AM, Antonio Borneo wrote:
>>>
>>> CP2112 is not able to combine messages since unable to repeat the start
>>> bits.
>>> It can only send simple transfers or a combined read-after-write.
>>>
>>> Here you cannot simply loop on all the messages and send them one by
>>> one because there is no way to force the repeated start bit in
>>> between.
>>> You can find more details in this thread about CP2112
>>> https://lkml.org/lkml/2015/3/15/64
>>> and here info about the repeated start bit under "Combined transactions"
>>> Documentation/i2c/i2c-protocol
>>>
>>> Anyway your idea to introduce read-after-write is valid.
>>> I suggest you to check the drivers i2c-opal.c and i2c-pmcmsp.c ; at a
>>> quick check I think they have similar limitation as CP2112.
>>> You could replicate the same check, supporting only num==1 (always)
>>> and num==2 (only if msg[0] is write and msg[1] is read).
>>>
>>> Best Regards,
>>> Antonio
>>
>>
>> It don't think the code attempts to generate repeated start.  It simply
>> issues and completes each message as separate transfers.  It's not different
>> from calling cp2112_i2c_xfer() repeatedly with single messages, except in
>> the bracketing hid_hw_power().
>
> cp2112_i2c_xfer() is the lower level side of i2c_transfer().
> i2c_transfer() requires that only one Stop bit is sent at the end of
> last message. Between messages a repeated start is mandatory.
> In general case, CP2112 cannot do that, that's why the original code
> returns error if num != 1
>
> It's not correct to issue each message as separate transfer inside
> cp2112_i2c_xfer(); the caller of i2c_transfer() expects the messages
> to be sent with repeated start.
>
> With you patch you highlight that there is another case that should be
> implemented.
> CP2112 can handle the case of num==2 when msg[0] is write and msg[1] is read.
> There are other devices with similar limitations, as I pointed above.
>
> Extending cp2112_i2c_xfer() to support a combined read-after-write is
> ok, while issuing each message without forcing repeated start is
> incorrect.
>
> Best Regards,
> Antonio

OK.  I neglected to read the later messages in the thread you pointed me 
to.  Oddly, I submitted my patch weeks before that thread, and was given 
exactly the opposite feedback, which was that the fix was fine in 
principle (but I should separate out some unrelated bug fixes).  And I 
agreed to using the quirks mechanism in a later patch.

Do you already have a patch that addresses the whole issue?  I just 
rewrote my code to handle single messages and the write-read case, as 
you suggested.

Thanks
