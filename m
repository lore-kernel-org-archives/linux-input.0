From: Silvan Jegen <me@sillymon.ch>
Subject: Re: Getting a functional driver for Mad Catz Fightstick TE 2 (Xbox
 One version)
Date: Thu, 10 Mar 2016 09:48:10 +0100
Message-ID: <3477c829c2d757553331662c63cb271c@sillymon.ch>
References: <20160308214512.ls7d4rs4jrs6paiy@myarchbang>
 <56E00C4A.4000304@gmail.com>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx01.mykolab.com ([95.128.36.1]:42406 "EHLO
	mx-out02.mykolab.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752819AbcCJIsP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Mar 2016 03:48:15 -0500
In-Reply-To: <56E00C4A.4000304@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gregor Riepl <onitake@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Gregor

Am 2016-03-09 12:43, schrieb Gregor Riepl:
>> I realized that the stick does not conform to the USB HID interface
>> after looking more closely at the lsusb -v output (pasted below).
>> 
>> The Fightstick seems to use a "Vendor Specific Class" and not the HID
>> interface.
> 
> This may be because Xbox One controllers require a special 
> initialisation
> sequence to make them send input reports at all.
> 
> As far as I know, xpad does this for Xbox One pads, but the commands 
> sent may
> not be sufficient for the Mad Catz. This may also be the reason why it 
> doesn't
> show up as a HID device: It's possible that the device descriptor 
> changes as
> soon as initialisation is complete.

So thanks to this suggestion I looked at the xpad.c code again yesterday 
to see which initialisation bytes are being sent. When reading through 
it I realized that I did not add an entry for the fight stick in the 
xpad_table[] array. Adding an entry there using the XPAD_XBOXONE_VENDOR 
macro (whose .bInterfaceSubClass and .bInterfaceProtocol values 
correspond to what I found in the lsusb -v output) lets the driver find 
the stick and also lets me read input from it.

I am travelling till next week but as soon as I get back I will test the 
stick's functionality and check if I have to add a quirk. If I find the 
stick to be reasonably functional after some tweaking I will send a 
patch to the list.

Thanks for your help!


Cheers,

Silvan
