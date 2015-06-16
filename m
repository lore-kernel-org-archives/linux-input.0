From: Andrew Duggan <aduggan@synaptics.com>
Subject: Re: [PATCH] HID: rmi: Disable populating F30 when the touchpad has
 physical buttons
Date: Tue, 16 Jun 2015 14:38:01 -0700
Message-ID: <55809739.4000207@synaptics.com>
References: <1434488921-11839-1-git-send-email-aduggan@synaptics.com> <20150616212653.GA20909@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:19462 "EHLO
	us-mx1.synaptics.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753814AbbFPViD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Jun 2015 17:38:03 -0400
In-Reply-To: <20150616212653.GA20909@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Peter Hutterer <peter.hutterer@who-t.net>

On 06/16/2015 02:26 PM, Benjamin Tissoires wrote:
> Hi Andrew,
>
> On Jun 16 2015 or thereabouts, Andrew Duggan wrote:
>> Physical buttons do not use F30 to report their state and in some cases the
>> data reported in F30 is incorrect and inconsistent with what is reported by
>> the HID descriptor. When physical buttons are present, ignore F30 and let
>> hid-input report buttons based on what is defined in the HID descriptor.
>>
>> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
>> ---
> Thanks for the patch.
> This one is related to:
> https://bugzilla.redhat.com/show_bug.cgi?id=1227891
> and http://bugs.freedesktop.org/show_bug.cgi?id=90356
>
> Andrew, can you confirm that with this patch, INPUT_PROP_BUTTONPAD is not
> set for the Razer Blade touchpad?

Yes, I was able to reproduce the bug and confirm the fix on a Razer 
Blade system.

> If so, then this is:
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>
> Cheers,
> Benjamin
>
>>   drivers/hid/hid-rmi.c | 9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
>> index 368ffdf..721f7f9 100644
>> --- a/drivers/hid/hid-rmi.c
>> +++ b/drivers/hid/hid-rmi.c
>> @@ -1013,6 +1013,7 @@ static int rmi_populate_f30(struct hid_device *hdev)
>>   
>>   static int rmi_populate(struct hid_device *hdev)
>>   {
>> +	struct rmi_data *data = hid_get_drvdata(hdev);
>>   	int ret;
>>   
>>   	ret = rmi_scan_pdt(hdev);
>> @@ -1033,9 +1034,11 @@ static int rmi_populate(struct hid_device *hdev)
>>   		return ret;
>>   	}
>>   
>> -	ret = rmi_populate_f30(hdev);
>> -	if (ret)
>> -		hid_warn(hdev, "Error while initializing F30 (%d).\n", ret);
>> +	if (!(data->device_flags & RMI_DEVICE_HAS_PHYS_BUTTONS)) {
>> +		ret = rmi_populate_f30(hdev);
>> +		if (ret)
>> +			hid_warn(hdev, "Error while initializing F30 (%d).\n", ret);
>> +	}
>>   
>>   	return 0;
>>   }
>> -- 
>> 2.1.4
>>

