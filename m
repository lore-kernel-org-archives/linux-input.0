From: Ellen Wang <ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCH v1] HID: cp2112: support large i2c transfers in hid-cp2112
Date: Tue, 30 Jun 2015 23:16:58 -0700
Message-ID: <559385DA.6040406@cumulusnetworks.com>
References: <1434587656-2359-1-git-send-email-ellen@cumulusnetworks.com>	<CAAj6DX0dvoL8RJtEtjE-+SPstLkvRGwgqSfsonDgG_Vgn8dKEQ@mail.gmail.com> <CAAj6DX2OzKnf280dC_b3YSiP9Z7S1da2=Xiv80q6e_krXVFGFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAAj6DX2OzKnf280dC_b3YSiP9Z7S1da2=Xiv80q6e_krXVFGFg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Antonio Borneo <borneo.antonio-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: David Barksdale <dbarksdale-2SNLKkHU5xRBDgjK7y7TUQ@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Sorry this fell off my todo list for a while.

On 06/20/2015 11:30 PM, Antonio Borneo wrote:
> On Sat, Jun 20, 2015 at 11:10 PM, Antonio Borneo
> <borneo.antonio-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> On Thu, Jun 18, 2015 at 8:34 AM, Ellen Wang <ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org> wrote:
>>> cp2112_i2c_xfer() only reads up to 61 bytes, returning EIO
>>> on longers reads.  The fix is to wrap a loop around
>>> cp2112_read() to pick up all the returned data.
>>>
>>> Signed-off-by: Ellen Wang <ellen-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
>>
>> Hi Ellen,
>>
>> with this patch the driver occasionally enters in an infinite loop.
>> I spent some time to understand the reason.
>>
>> The sequence for a data read in cp2112_i2c_xfer() is:
>> 1) send report CP2112_DATA_READ_REQUEST (no reply is expected)
>> 2) send report CP2112_TRANSFER_STATUS_REQUEST
>> 3) wait for reply report CP2112_TRANSFER_STATUS_RESPONSE to indicate
>> i2c read completed
>> 4) send report CP2112_DATA_READ_FORCE_SEND
>> 5) wait for reply report CP2112_DATA_READ_RESPONSE containing the data just read
>>
>> Your patch repeats step 4) and 5) until all data are received.
>>
>> Every report CP2112_DATA_READ_RESPONSE can carry max 61 bytes of data.
>> It is not reported in Silab documentation (or maybe I failed to find
>> it), but if you send a request CP2112_DATA_READ_FORCE_SEND for _more_
>> than 61 bytes then cp2112 replies with a sequence of reports
>> CP2112_DATA_READ_RESPONSE, each report carrying 61 bytes max.
>>
>> To get only one report as reply, the request in 4) should not exceed 61 bytes!
>>
>> The current code in cp2112_raw_event() is very simple and can only
>> handle receiving one data report at a time; it's not designed to
>> handle a sequence of reports.
>> If a new incoming report arrives while we are still consuming a
>> previous report, the new data will overwrite the older one.
>>
>> If the loop over 4) and 5) is not fast enough (e.g. CPU overloaded,
>> interrupts) then you get reports overwritten.
>> Once one report is overwritten, we fail to get the whole data, the
>> loop will not reach the upper limit and will never exit!
>>
>> I got this case just adding a hid_info() inside the loop.
>> If you want, you can check by adding a msleep(100) inside the loop.
>> Enough to get infinite loop at almost every execution.

Sigh.  I just reread the documentation 
(https://www.silabs.com/Support%20Documents/TechnicalDocs/AN495.pdf). 
It doesn't say one way or the other but it does seem to imply one 
CP2112_DATA_READ_RESPONSE is returned for each 
CP2112_DATA_READ_FORCE_SEND.  Sorry about the bug.

>> Hints in the code below:
>>
>>> ---
>>> This is like the previous patch but with the controversial
>>> part left out.
>>> ---
>>>   drivers/hid/hid-cp2112.c |   26 +++++++++++++++++++-------
>>>   1 file changed, 19 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
>>> index 3318de6..5a72819 100644
>>> --- a/drivers/hid/hid-cp2112.c
>>> +++ b/drivers/hid/hid-cp2112.c
>>> @@ -509,13 +509,25 @@ static int cp2112_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
>>>          if (!(msgs->flags & I2C_M_RD))
>>>                  goto finish;
>>>
>>> -       ret = cp2112_read(dev, msgs->buf, msgs->len);
>>> -       if (ret < 0)
>>> -               goto power_normal;
>>> -       if (ret != msgs->len) {
>>> -               hid_warn(hdev, "short read: %d < %d\n", ret, msgs->len);
>>> -               ret = -EIO;
>>> -               goto power_normal;
>>> +       for (count = 0; count < msgs->len;) {
>>> +               ret = cp2112_read(dev, msgs->buf + count, msgs->len - count);
>>
>> Limit the read to 61 bytes with a check like
>>          if (size > 61)
>>                  size = 61;
>>          ret = cp2112_read(..., size);
>> This guarantees we get back only one report at a time.
>> Instead of the magic number 61, you can use sizeof(dev->read_data).
>>
>> Or, better, put the check inside cp2112_read(). We are not supposed to
>> use this function for more than 61 bytes due to current simple
>> cp2112_raw_event(). Please also comment the change in cp2112_read().
>> The code in cp2112_read() expects only one report of data. Seams the
>> proper place to limit the amount of data requested.
>
> Hi Ellen,
>
> at last I changed mind!
> The multi-report issus is a bug of current code and must be fixed separately.
> I just sent out a patch for it, tagging it for linux-stable too.
>
> Regarding you patch.
> No need to handle the case of size > 61, supposed already fixed. Just
> keep your code as is.
> But please rise an error in case of ret == 0 to avoid infinite loop.
>
> Best Regards,
> Antonio
>
>>
>>> +               if (ret < 0)
>>> +                       goto power_normal;
>>
>> If ret == 0 it means we have lost one report and the operation should
>> be aborted.
>> I cannot imagine what could cause it (maybe weak USB contacts or line
>> noise), but for sure this return value is unexpected.
>> Please generate error for ret == 0 so we never get infinite loop.

Absolutely.  The loop should always make progress.  I will send an 
updated patch.  I should have handled that case in the first place.

Also, I took a look at cp2112_raw_event() and cp2112_read().  There's 
really no fundamental reason the code can't get all the data with a 
single CP2112_DATA_READ_FORCE_SEND.  It just has to arrange for 
cp2112_raw_event() to fill the i2c_msg buffer directly.

For that matter, it can probably set auto_send_read and do away with 
CP2112_DATA_READ_FORCE_SEND all together.

There are some complications (like the wait timeout value may have to 
change) and it will take a lot of testing so I should do the safe fix first.

>> Thanks,
>> Antonio

Thanks!
