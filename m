From: Nestor Lopez Casado <nlopezcasad@logitech.com>
Subject: Re: [patch] HID: hid-logitech-dj: add some range checks
Date: Tue, 5 Mar 2013 17:34:08 +0100
Message-ID: <CAE7qMrouxdpjtBRpTUjKBdiAr-wwhy8x3M23Q_twP+kkTFFALA@mail.gmail.com>
References: <20130305130626.GA17801@longonot.mountain> <CAN+gG=E_b3ydgPpt1c0-5Z6Ktkzw1bN7Kro=WUC7UmJenPAfMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog135.obsmtp.com ([74.125.149.84]:51705 "EHLO
	na3sys009aog135.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751746Ab3CERDN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 5 Mar 2013 12:03:13 -0500
Received: by mail-ye0-f200.google.com with SMTP id r1so10058941yen.3
        for <linux-input@vger.kernel.org>; Tue, 05 Mar 2013 09:03:12 -0800 (PST)
In-Reply-To: <CAN+gG=E_b3ydgPpt1c0-5Z6Ktkzw1bN7Kro=WUC7UmJenPAfMg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Jiri Kosina <jkosina@suse.cz>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, kernel-janitors@vger.kernel.org

Hi Dan,


On Tue, Mar 5, 2013 at 3:47 PM, Benjamin Tissoires
<benjamin.tissoires@gmail.com> wrote:
> Hi Dan,
>
> On Tue, Mar 5, 2013 at 2:06 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>> We can't trust dj_report->device_index because it comes from the
>> user and hasn't been range checked.  It is used as an offset into
>> the djrcv_dev->paired_dj_devices[] array which has 7 elements.
>> There is one range check already in logi_dj_recv_add_djhid_device()
>> and I have copy and pasted that here.
>>
>> DJ_DEVICE_INDEX_MIN is 1.
>> DJ_DEVICE_INDEX_MAX is 6.
>>
>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>> ---
>> This is a static checker fix and I'm not certain it's correct,
>> please look it over carefully.
>>
>> I do not know this code well, so I don't know why a zero index is
>> invalid.
>>
>> diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
>> index 9500f2f..c01cd25 100644
>> --- a/drivers/hid/hid-logitech-dj.c
>> +++ b/drivers/hid/hid-logitech-dj.c
>> @@ -701,6 +701,13 @@ static int logi_dj_raw_event(struct hid_device *hdev,
>>          * anything else with it.
>>          */
>>
>> +       if ((dj_report->device_index < DJ_DEVICE_INDEX_MIN) ||
>> +           (dj_report->device_index > DJ_DEVICE_INDEX_MAX)) {
>> +               dev_err(&hdev->dev, "%s: invalid device index:%d\n", __func__,
>> +                       dj_report->device_index);
>> +               return true;
>> +       }
>> +
>
> Sorry, but it's a NACK in its current form:
> - device_index == 0 is the receiver. IIRC, the receiver sends the
> different REPORT_TYPE_NOTIF_*. So I would say that this patch blocks
> events from the receiver.
Correct. This would block notifications from the receiver.

> - the DJ protocol specifies that the device index is between 1 and 6
> and that 0 means the receiver. So unless there is a problem in the USB
> line from the receiver to the driver, device index will be between 1
> and 6 for input events. This is only true as long as with stay with
> real firmware from Logitech, not from events from uhid.
>
> If you want to add a check, it need to be in logi_dj_recv_forward_report().
> The current access to djrcv_dev->paired_dj_devices[] in
> delayedwork_callback() has been removed in latest HID tree:
> https://git.kernel.org/cgit/linux/kernel/git/jikos/hid.git/log/?h=for-3.10/logitech
The test could be added there. It would be quite defensive though, as
we should always get the right device indexes.
>
> Cheers,
> Benjamin
>
>>         spin_lock_irqsave(&djrcv_dev->lock, flags);
>>         if (dj_report->report_id == REPORT_ID_DJ_SHORT) {
>>                 switch (dj_report->report_type) {
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-input" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
