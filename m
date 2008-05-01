From: Anssi Hannula <anssi.hannula@gmail.com>
Subject: Re: USB mouse protocol,
Date: Thu, 01 May 2008 18:29:50 +0300
Message-ID: <4819E1EE.6010406@gmail.com>
References: <WorldClient-F200804301128.AA28590066@butn.net> <20080430111816.GA9876@suse.cz> <WorldClient-F200804301607.AA07060136@butn.net> <20080430141231.GA18693@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mta-out.inet.fi ([195.156.147.13]:44104 "EHLO
	kirsi2.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754273AbYEAP35 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 1 May 2008 11:29:57 -0400
In-Reply-To: <20080430141231.GA18693@suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: xerces8 <xerces8@butn.net>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org

Vojtech Pavlik wrote:
> On Wed, Apr 30, 2008 at 04:07:06PM +0200, xerces8 wrote:
>> Vojtech Pavlik wrote:
>>
>>> On Wed, Apr 30, 2008 at 11:28:59AM +0200, xerces8 wrote:
>>>> Hi!
>>>>
>>>> I'm curious about some details in the protocol used by USB mice.
>>>> A cursory look at the "Device Class Definition for HID 1.11" documents
>>>> tells me (note this is the first USB technical document I ever read)
>>>> that a mouse can tell the host the format (the protocol) used to report
>>>> data (movement, button state etc.).
>>>>
>>>> Also a quick look into linuxv2.6.25/drivers/hid/usbhid/usbmouse.c suggests
>>>> that 8 bits are used for position.
>>>>
>>>> So my questions are:
>>>>  - is the position data always 8 bits wide ?
>>> No. The driver you need to look at is usbhid.ko, not usbmouse - that
>>> only works for the static "HID Boot Protocol", and is only useful in
>>> embedded devices.
>> Pretty hard to read there... Can I activate some debug output, to see what
>> my mouse is sending ?
> 
> Yes, #define DEBUG and possibly also DEBUG_DATA will do the trick.

Not true anymore on recent kernels. You need to enable CONFIG_HID_DEBUG
and use the debug module parameter (/sys/module/hid/parameters/debug).

-- 
Anssi Hannula
