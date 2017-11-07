From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 2/3] HID: multitouch: Properly deal with reports with 0
 touches
Date: Tue, 7 Nov 2017 13:30:38 +0100
Message-ID: <28253a8b-b185-d7b6-a67f-f2a70d39e8f4@redhat.com>
References: <20171106150149.13986-1-hdegoede@redhat.com>
 <20171106150149.13986-2-hdegoede@redhat.com>
 <20171106175616.GO9728@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38596 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753626AbdKGMan (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 7 Nov 2017 07:30:43 -0500
In-Reply-To: <20171106175616.GO9728@mail.corp.redhat.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org

Hi,

On 06-11-17 18:56, Benjamin Tissoires wrote:
> On Nov 06 2017 or thereabouts, Hans de Goede wrote:
>> The Windows Precision Touchpad spec "Figure 4 Button Only Down and Up"
>> and "Table 9 Report Sequence for Button Only Down and Up" indicate
>> that the first packet of a (possibly hybrid mode multi-packet) report
>> may contain a contact-count of 0 if only a button is pressed and no
>> fingers are detected.
>>
>> This means that a value of 0 for contact-count is a valid value and
>> should be used as expected contact count when num_received == 0.
> 
> Please add something here that explains that num_received == 0 means
> that we are at the beginning of a multi-report frame. I had a hard time
> remembering that actually.
> 
>>
>> The only other case where we may get a contact count value of 0
>> when num_received == 0 is when we're somehow out of sync and in
>> that case setting num_expected to 0 so that we ignore contacts
>> until we're back in sync again also is the right thing to do.
> 
> Are you sure about that? I mean, if you set num_expected to 0, all
> incoming report will call mt_sync_frame(), which basically flushes all
> the events to the user space.
> 
> I am fine accepting a contact count value of 0 if we are at the
> beginning of a multi report frame, but I'd be more happy if you take
> into account the Scan Time HID field value into account instead of a
> computed value.

Ok, I've prepared a v3 which only sets num_expected to 0 for Win8 PTP
devices when both num_received == 0 and the timestamp has changed since
the previous report.

Regards,

Hans


> 
> Cheers,
> Benjamin
> 
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/hid/hid-multitouch.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
>> index bb939f6990f1..76a3e9e074ba 100644
>> --- a/drivers/hid/hid-multitouch.c
>> +++ b/drivers/hid/hid-multitouch.c
>> @@ -827,7 +827,7 @@ static void mt_touch_report(struct hid_device *hid, struct hid_report *report)
>>   	if (td->cc_index >= 0) {
>>   		struct hid_field *field = report->field[td->cc_index];
>>   		int value = field->value[td->cc_value_index];
>> -		if (value)
>> +		if (value || td->num_received == 0)
>>   			td->num_expected = value;
>>   	}
>>   
>> -- 
>> 2.14.3
>>
