From: Boszormenyi Zoltan <zboszor@pr.hu>
Subject: Re: [PATCH] HID: core: assign usbhid to handle EETI PID=0x0001 HID
 device
Date: Fri, 22 Sep 2017 10:33:40 +0200
Message-ID: <31969c20-28ee-56b7-fe25-ccb5c0725794@pr.hu>
References: <20170811074201.2747-1-jam.chen.egalax@gmail.com>
 <20170822093319.GC25370@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail7.pr.hu ([87.242.0.7]:55925 "EHLO mail7.pr.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751810AbdIVI5I (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 22 Sep 2017 04:57:08 -0400
In-Reply-To: <20170822093319.GC25370@mail.corp.redhat.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, JamChen <jam.chen.egalax@gmail.com>
Cc: jikos@kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On 2017-08-22 11:33, Benjamin Tissoires wrote:
> On Aug 11 2017 or thereabouts, JamChen wrote:
>> From: Jam Chen <jam.chen.egalax@gmail.com>
>>
>> The vendor used the same PID(0x0001) for multiple touch IC controllers.
>> The newer ICs can support HID class and report the multitouch collection
>> in the descriptor. So they were handled by the hid-multitouch driver.
>> But some customized firmwares don't support multitouch protocol even if
>> driver have got the Win8 blob data.
>>
>> Actually, those ICs only support the single touch function, and report
>> the mouse protocol by default. We can assign usbhid to handle them all.
>>
>> Signed-off-by: Jam Chen <jam.chen.egalax@gmail.com>
>> ---
> 
> Him
> 
> FYI, I'd rather see a full working solution such as the one presented here:
> https://patchwork.kernel.org/patch/9876649/
> 
> Because this solution is half working as it regresses on some devices
> while solving others.
> 
> Cheers,
> Benjamin

is there any news about resolving this issue in the upstream kernel?

Thanks in advance,
Zoltán Böszörményi

> 
>>   drivers/hid/hid-core.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
>> index 9017dcc14502..df4696022488 100644
>> --- a/drivers/hid/hid-core.c
>> +++ b/drivers/hid/hid-core.c
>> @@ -828,6 +828,10 @@ static int hid_scan_report(struct hid_device *hid)
>>   				 */
>>   				hid->group = HID_GROUP_RMI;
>>   		break;
>> +	case USB_VENDOR_ID_DWAV:
>> +		if (hid->product == USB_DEVICE_ID_EGALAX_TOUCHCONTROLLER)
>> +			hid->group = HID_GROUP_GENERIC;
>> +		break;
>>   	}
>>   
>>   	/* fall back to generic driver in case specific driver doesn't exist */
>> -- 
>> 2.11.0
>>
> 

