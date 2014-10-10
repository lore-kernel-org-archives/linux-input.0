From: Andrew Duggan <aduggan@synaptics.com>
Subject: Re: Synaptics, CAP_FORCEPAD, bad behavior
Date: Thu, 9 Oct 2014 17:21:58 -0700
Message-ID: <543726A6.3020804@synaptics.com>
References: <543656A2.4080009@kernelconcepts.de> <20141009165246.GA18213@dtor-ws> <20141009172832.GB18213@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:29442 "EHLO
	us-mx1.synaptics.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751065AbaJJAWH (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Oct 2014 20:22:07 -0400
In-Reply-To: <20141009172832.GB18213@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Nicole Faerber <nicole.faerber@kernelconcepts.de>, Christopher Heiny <cheiny@synaptics.com>
Cc: linux-input <linux-input@vger.kernel.org>

On 10/09/2014 10:28 AM, Dmitry Torokhov wrote:
> On Thu, Oct 09, 2014 at 09:52:46AM -0700, Dmitry Torokhov wrote:
>> On Thu, Oct 09, 2014 at 11:34:26AM +0200, Nicole Faerber wrote:
>>> Hi!
>>> Just installed the just released 3.17 kernel and found a bad behavior of
>>> the new Synaptics driver on my Thinkpad Yoga which has the new Synaptics
>>> clickpad enabled touchpad:
>>>
>>> psmouse serio1: synaptics: Touchpad model: 1, fw: 8.1, id: 0x1e2b1,
>>> caps: 0xd002a3/0x940300/0x12f800, board id: 2911, fw id: 2560
>>>
>>> The issue is that now a button release is only issued after the finger
>>> has completely left the touchpad and not when releasing the physical
>>> button. Is this physical button now called FORCEPAD? Anyway, this is
>>> pretty annoying. Double clicking become a real pain.
>>> I did comment out the new
>>>
>>> 	if (SYN_CAP_FORCEPAD(priv->ext_cap_0c)) {
>>> 	...
>>>
>>> and everything is back to normal again, i.e. when I do release the pad
>>> physical button but keep the finger on the pad, the button release event
>>> is issued properly.
>> Hmm, the forcepad code should only activate if the devoice do4es not
>> have physical buttons at all. Let me see what's the diffference in
>> capabilities between your and mine touchpads...
> OK, so your extended caps are 0x12f800 while on my forcepad they are
> 0x12e800. The forcepad bit is supposed to be bit 15, so it is set for
> both our devices, but bit 12 (counting from 0) is different.
>
> Andrew, Chris, could you please tell us what bit 12 indicates? In fact,
> if you could share the updated description for all currently defined
> capability bits that would be awesome.
>
> Thanks!
>
Hmm, looks like I got incorrect information about the ForcePad 
capabilities bit and unfortunately there does not seem to be a 
capabilities bit for ForcePad on PS/2. Too bad that wasn't caught before 
3.17 was released. Bit 12 is for "uniform clickpad" which means that the 
whole clickpad moves when you press it as opposed to it being hinged at 
the top. That makes sense that a ForcePad would not have that capability.

Also, it's weird that the firmware ID printed above is not correct. I 
would expect a 7 digit number starting with 1.

Andrew
