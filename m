From: Frank Praznik <frank.praznik@gmail.com>
Subject: Re: [PATCH 1/2] hid: sony: Refactor output report sending functions
Date: Mon, 9 Nov 2015 10:59:34 -0500
Message-ID: <5640C2E6.3090201@gmail.com>
References: <1446909130-9168-1-git-send-email-frank.praznik@gmail.com>
 <1446909130-9168-2-git-send-email-frank.praznik@gmail.com>
 <20151109150241.e8c09e8f6b5a319be38f604c@ao2.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:33059 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856AbbKIP7j (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Nov 2015 10:59:39 -0500
Received: by qkas77 with SMTP id s77so69140322qka.0
        for <linux-input@vger.kernel.org>; Mon, 09 Nov 2015 07:59:38 -0800 (PST)
In-Reply-To: <20151109150241.e8c09e8f6b5a319be38f604c@ao2.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ao2@ao2.it>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz

On 11/9/2015 09:02, Antonio Ospite wrote:
> On Sat,  7 Nov 2015 10:12:09 -0500
> Frank Praznik <frank.praznik@gmail.com> wrote:
>
>> Refactor output report sending functions to allow for the sending of
>> output reports without enqueing a work item.  Output reports for any device
>                           ^
>                           enqueuing or enqueueing :)
>
>> can now be sent by calling the sony_send_output_report function which will
>> automatically dispatch the request to the appropriate output function.  The
>> individual state worker functions have been replaced with a universal
>> sony_state_worker function which calls sony_send_output_report.
>>
>> Signed-off-by: Frank Praznik <frank.praznik@gmail.com>
> Looks good to me, just one comment below.
>
>> ---
>>   drivers/hid/hid-sony.c | 39 ++++++++++++++++++++++++++-------------
>>   1 file changed, 26 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
>> index 661f94f..b84b2ce 100644
>> --- a/drivers/hid/hid-sony.c
>> +++ b/drivers/hid/hid-sony.c
>> @@ -1782,7 +1782,7 @@ error_leds:
>>   	return ret;
>>   }
>>   
>> -static void sixaxis_state_worker(struct work_struct *work)
>> +static void sixaxis_send_output_report(struct sony_sc *sc)
>>   {
>>   	static const union sixaxis_output_report_01 default_report = {
>>   		.buf = {
>> @@ -1796,7 +1796,6 @@ static void sixaxis_state_worker(struct work_struct *work)
>>   			0x00, 0x00, 0x00, 0x00, 0x00
>>   		}
>>   	};
>> -	struct sony_sc *sc = container_of(work, struct sony_sc, state_worker);
>>   	struct sixaxis_output_report *report =
>>   		(struct sixaxis_output_report *)sc->output_report_dmabuf;
>>   	int n;
>> @@ -1839,9 +1838,8 @@ static void sixaxis_state_worker(struct work_struct *work)
>>   			HID_OUTPUT_REPORT, HID_REQ_SET_REPORT);
>>   }
>>   
>> -static void dualshock4_state_worker(struct work_struct *work)
>> +static void dualshock4_send_output_report(struct sony_sc *sc)
>>   {
>> -	struct sony_sc *sc = container_of(work, struct sony_sc, state_worker);
>>   	struct hid_device *hdev = sc->hdev;
>>   	__u8 *buf = sc->output_report_dmabuf;
>>   	int offset;
>> @@ -1886,9 +1884,8 @@ static void dualshock4_state_worker(struct work_struct *work)
>>   				HID_OUTPUT_REPORT, HID_REQ_SET_REPORT);
>>   }
>>   
>> -static void motion_state_worker(struct work_struct *work)
>> +static void motion_send_output_report(struct sony_sc *sc)
>>   {
>> -	struct sony_sc *sc = container_of(work, struct sony_sc, state_worker);
>>   	struct hid_device *hdev = sc->hdev;
>>   	struct motion_output_report_02 *report =
>>   		(struct motion_output_report_02 *)sc->output_report_dmabuf;
>> @@ -1907,6 +1904,23 @@ static void motion_state_worker(struct work_struct *work)
>>   	hid_hw_output_report(hdev, (__u8 *)report, MOTION_REPORT_0x02_SIZE);
>>   }
>>   
>> +static void sony_send_output_report(struct sony_sc *sc)
>> +{
>> +	if (sc->quirks & DUALSHOCK4_CONTROLLER)
>> +		dualshock4_send_output_report(sc);
>> +	else if ((sc->quirks & SIXAXIS_CONTROLLER) ||
>> +			(sc->quirks & NAVIGATION_CONTROLLER))
>> +		sixaxis_send_output_report(sc);
>> +	else if (sc->quirks & MOTION_CONTROLLER)
>> +		motion_send_output_report(sc);
>> +}
> We could have have a function pointer to a send_output_report callback
> in struct sony_sc, set the appropriate call back in sony_probe() once
> and for all and drop sony_send_output_report() which is identifying
> again the device, something we already did in sony_probe().
> Just an idea for a more declarative approach, but this way is OK too.
>
>> +
>> +static void sony_state_worker(struct work_struct *work)
>> +{
>> +	struct sony_sc *sc = container_of(work, struct sony_sc, state_worker);
>> +	sony_send_output_report(sc);
> this would become:
>
> 	sc->send_output_report(sc);
>
> same as in patch 2/2.
>
>
> Thanks,
>     Antonio
>

Hi Antonio,

I like your suggestion.  One pointer dereference vs several branches 
should be faster and cleaner.  I'll do a v2 which implements this and 
fixes the commit typos when I have some time in the next day or two.

Regards,
     Frank
