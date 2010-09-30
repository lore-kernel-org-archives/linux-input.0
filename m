From: Alan Ott <alan@signal11.us>
Subject: Re: [PATCH v4 1/2] HID: Add Support for Setting and Getting Feature   Reports from hidraw
Date: Wed, 29 Sep 2010 23:37:41 -0400
Message-ID: <4CA40605.6080800@signal11.us>
References: <1281442367.12579.206.camel@localhost.localdomain>	<1281990059-3562-2-git-send-email-alan@signal11.us> <20100930015104.49fc5acf.ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from core.signal11.us ([64.251.29.136]:35202 "EHLO core.signal11.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752897Ab0I3Dhs (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Sep 2010 23:37:48 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by core.signal11.us (Postfix) with SMTP id 878CF1CCAA89
	for <linux-input@vger.kernel.org>; Wed, 29 Sep 2010 23:37:46 -0400 (EDT)
In-Reply-To: <20100930015104.49fc5acf.ospite@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

On 09/29/2010 07:51 PM, Antonio Ospite wrote:
> On Mon, 16 Aug 2010 16:20:58 -0400
> Alan Ott<alan@signal11.us>  wrote:
>
>    
>> Per the HID Specification, Feature reports must be sent and received on
>> the Configuration endpoint (EP 0) through the Set_Report/Get_Report
>> interfaces.  This patch adds two ioctls to hidraw to set and get feature
>> reports to and from the device.  Modifications were made to hidraw and
>> usbhid.
>>
>> New hidraw ioctls:
>>    HIDIOCSFEATURE - Perform a Set_Report transfer of a Feature report.
>>    HIDIOCGFEATURE - Perform a Get_Report transfer of a Feature report.
>>
>> Signed-off-by: Alan Ott<alan@signal11.us>
>> ---
>>      
> Some more testing with sixaxis and a question:
>
> HIDIOCGFEATURE on report 0xf5 returns:
> <-- 01 00 00 03 c9 87 34 fd
>            ^^ a hw addr from here
>    

Maybe I'm confused. Shouldn't the first byte of that be 0xf5? The report 
number should be the first byte of the returned buffer.

There's not a chance you're running an old version of this patch is there?

> with the latest six octets being a hw addr; now if I wanted to change
> this, *naively*, I'd send this report with HIDIOCSFEATURE:
> -->  f5 01 00 66 55 44 33 22 11
>      ^^ report ID _added_ in front of the whole previous buffer
>
> but then when I get the report again to see if the operation succeeded I
> get:
> <-- 01 00 00 66 55 44 33 22
>
> I can make it work if I send:
> -->  f5 00 66 55 44 33 22 11
>      ^^ report ID _replaced_ buf[0]
>
> then I get the expected:
> <-- 01 00 66 55 44 33 22 11
>
> Am I missing something about the differences about getting a feature
> report and setting it?
>
>    

Do you have patches 29129a98e6f and c29771c2d8ce applied? They are in 
2.6.36-rc6 (and some previous, but I'm note certain how far back). Those 
patches have to do with _sending_ the right bytes (in particular the 
report number) on the control endpoint. You seem to be having the 
opposite problem though. Let me know to be sure.

> In the HIDIOCGFEATURE doc I read:
> 	...
> 	The report will be returned starting at
> 	the first byte of the buffer (ie: the report number is not
> 	returned).
>
> Someone (/me whistling, with hands in pockets) could interpret this
> like a buf++ semantic on a quick read, even if this sentence means
> "only" that _actual_data_ is from buf[1]; but one question stands: what
> is that value returned in buf[0]? Is this unspecified?
>
>    

So that was written when I had an incorrect understanding of the 
standard. It is wrong. I had originally thought that Report ID's were 
not sent on the control endpoint as part of the payload (because it's 
redundant, since it's in wValue). I was wrong, and made those two 
patches above to correct it.

> Maybe the doc could be made even more explicit about buf[0] to overcame
> non native speakers deficiencies.
> And while at it, can we get rid of the ambiguity of "first byte" for
> "byte 1", the former can even mean buf[0], can't it?
>    

Your English is fine, my understanding was wrong :) .

Alan.



