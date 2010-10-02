From: Alan Ott <alan@signal11.us>
Subject: Re: [PATCH v4 1/2] HID: Add Support for Setting and Getting Feature     Reports from hidraw
Date: Fri, 01 Oct 2010 20:30:36 -0400
Message-ID: <4CA67D2C.6060505@signal11.us>
References: <1281442367.12579.206.camel@localhost.localdomain>	<1281990059-3562-2-git-send-email-alan@signal11.us>	<20100930015104.49fc5acf.ospite@studenti.unina.it>	<4CA40605.6080800@signal11.us> <20101001000309.9bb53de4.ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from core.signal11.us ([64.251.29.136]:48752 "EHLO core.signal11.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753509Ab0JBAaj (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 1 Oct 2010 20:30:39 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by core.signal11.us (Postfix) with SMTP id 5C3981CCAA8D
	for <linux-input@vger.kernel.org>; Fri,  1 Oct 2010 20:30:38 -0400 (EDT)
In-Reply-To: <20101001000309.9bb53de4.ospite@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

On 09/30/2010 06:03 PM, Antonio Ospite wrote:
>
> v4 it is. About the first byte, is it very clear now than when _setting_
> a report the first byte is the report descriptor even in the payload,
> but when we are _getting_ it from the usb device, could a non conformant
> device be mangling it?
>    

Very possible. The sixaxis as we already know is non-conforming in other 
ways. From my custom firmware, I can send back reports with pretty much 
anything in byte 0.

>
>    
>>> with the latest six octets being a hw addr; now if I wanted to change
>>> this, *naively*, I'd send this report with HIDIOCSFEATURE:
>>> -->   f5 01 00 66 55 44 33 22 11
>>>       ^^ report ID _added_ in front of the whole previous buffer
>>>
>>> but then when I get the report again to see if the operation succeeded I
>>> get:
>>> <-- 01 00 00 66 55 44 33 22
>>>
>>> I can make it work if I send:
>>> -->   f5 00 66 55 44 33 22 11
>>>       ^^ report ID _replaced_ buf[0]
>>>
>>> then I get the expected:
>>> <-- 01 00 66 55 44 33 22 11
>>>
>>> Am I missing something about the differences about getting a feature
>>> report and setting it?
>>>
>>>
>>>        
>> Do you have patches 29129a98e6f and c29771c2d8ce applied? They are in
>> 2.6.36-rc6 (and some previous, but I'm note certain how far back). Those
>> patches have to do with _sending_ the right bytes (in particular the
>> report number) on the control endpoint. You seem to be having the
>> opposite problem though. Let me know to be sure.
>>
>>      
> I confirm I have those changes applied, in fact I am working on top of
> 2.6.36-rc6, and yes, my doubt is about the buffer returned from a GET
> FEATURE REPORT.
>    

Yes, but I was wondering if the data that you sent in the SET report was 
maybe shifted by one, causing the data read back properly from the GET 
report to look shifted. It was just a theory.

>    
>>> In the HIDIOCGFEATURE doc I read:
>>> 	...
>>> 	The report will be returned starting at
>>> 	the first byte of the buffer (ie: the report number is not
>>> 	returned).
>>>
>>> Someone (/me whistling, with hands in pockets) could interpret this
>>> like a buf++ semantic on a quick read, even if this sentence means
>>> "only" that _actual_data_ is from buf[1]; but one question stands: what
>>> is that value returned in buf[0]? Is this unspecified?
>>>
>>>        
>> So that was written when I had an incorrect understanding of the
>> standard. It is wrong. I had originally thought that Report ID's were
>> not sent on the control endpoint as part of the payload (because it's
>> redundant, since it's in wValue). I was wrong, and made those two
>> patches above to correct it.
>>
>>      
> Alan I am still talking about GET_FEATURE here, not SET, the question
> here is what value the first byte (buf[0]) is expected to have in a
> buffer returned from a GET. If it has to be the report ID then I
> suspect my device is changing it behind our backs, maybe a failsafe
> measure like the following could do?
>
>    

Like I said above, just a theory that your SET data was setting the data 
incorrectly, and that the GET data was reading back from the device 
exactly what the device sent you (but of course the hardware ID was 
shifted because it wasn't SET correctly).

> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
> index df80532..83e1b48 100644
> --- a/drivers/hid/usbhid/hid-core.c
> +++ b/drivers/hid/usbhid/hid-core.c
> @@ -875,6 +875,9 @@ static int usbhid_output_raw_report(struct hid_device *hid, __u8 *buf, size_t co
>                          ((report_type + 1)<<  8) | report_id,
>                          interface->desc.bInterfaceNumber, buf, count,
>                          USB_CTRL_SET_TIMEOUT);
> +               /* restore report ID into the buffer, some non conformant usb
> +                * device could have mangled it */
> +               buf[0] = report_id;
>                  /* count also the report id, if this was a numbered report. */
>                  if (ret>  0&&  skipped_report_id)
>                          ret++;
>
>
> But I haven't even taken a look at the HID spec about this, so take it
> just for the sake of discussion. Anyone could run some tests with other
> devices?
>    

I actually don't like it (I did see your later email about how you 
really meant for it to be in usbhid_get_raw_report(), so consider this 
my response to that). I don't like it because hidraw is supposed to be 
raw. If the device sends back bogus stuff, then bogus stuff should be 
passed back to userspace. Likewise, if the host tries to send bogus 
stuff to the device, then it should be able to (or be able to try). The 
problem with enforcing rules here is determining which rules to enforce. 
For example, with hiddev, you can't get or set reports that aren't in 
the HID descriptor. That keeps you from being able to get report 0xf5 
which is required to use the sixaxis device. I think this goes against 
the idea of "raw," and could even mislead the user to think that a 
device is functioning properly (or has been implemented properly) when 
it is not.

Alan.


