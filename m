From: Robert Schedel <r.schedel@yahoo.de>
Subject: Re: Logitech M705 thumb button
Date: Sun, 11 Apr 2010 17:56:00 +0200
Message-ID: <4BC1F110.4030203@yahoo.de>
References: <hoqak4$m6t$1@dough.gmane.org>	 <20100330065625.GC12764@core.coreip.homeip.net>	 <319012f1003300033k254715dao7f9a807615df36df@mail.gmail.com>	 <alpine.LRH.2.00.1003301418000.10181@twin.jikos.cz>	 <319012f1003300602q708563ebo90b30c8d8b15e938@mail.gmail.com>	 <alpine.LNX.2.00.1003311401230.24576@pobox.suse.cz>	 <i2m319012f1003310554gd0a6a9fej27838c2c63bac171@mail.gmail.com>	 <alpine.LNX.2.00.1004021204310.8345@pobox.suse.cz>	 <g2w319012f1004020328l36f7bc5t2a1c3932681a2ee6@mail.gmail.com> <v2x319012f1004020427t86509b85yb68e9fd7df50a5ef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp121.mail.ukl.yahoo.com ([77.238.184.52]:46156 "HELO
	smtp121.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751874Ab0DKQDG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 11 Apr 2010 12:03:06 -0400
In-Reply-To: <v2x319012f1004020427t86509b85yb68e9fd7df50a5ef@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Octoploid <cryptooctoploid@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Hello,

On 02.04.2010 13:27, Octoploid wrote:
[...]
>>> Could you please verify that there is indeed no USB event being triggered
>>> by the button press at all, with usbmon [1]?
>>
>> I already verified this, but forgot to mention it in my last mail.
>> There are indeed no USB events being triggered when I run
>> "cat /sys/kernel/debug/usb/usbmon/ou".
>>
>>> If it is the case, I am afraid the only option would be inspecting what
>>> initialization sequence does the driver for Another OS perform, so that it
>>> makes the button work.
> 
> OK, I have downloaded a trial version of a usb-monitor and
> recorded the following initialization sequence.
> Let me know it this helps.
> 
> http://pastebin.org/131184

You did not add info at which time you pressed which button, e.g. thumb button.

But, OK, init sequence is more important: Looking for "(DOWN)", there are several device-specific control blocks which resemble those sent by "lomoco" or other mouse tools for configuring Logitech features.

Example, request 0x9, value 0x210, sent downstream:

# 002448: Control Transfer (DOWN), 02.04.2010 11:14:55.341 +0.0
# Pipe Handle: 0x0
# Recipient: Interface
# Request Type: Class
# Direction: Host->Device
# Request: 0x9 (Unknown)
# Value: 0x210
# Index: 0x2
# Length: 0x7

My guess is, some new init trigger is required from a userspace tool (only) to enable thumb button, no kernel issue. This is difficult to analyze though w/o the device available and w/o spec. You might
a) fiddle with lomoco source code yourself, e.g. making the existing features work first + adding feature bits found in your protocol
b) get in touch with the developers
c) wait for someone more experienced to get the mouse and analyze

Regards,
Robert Schedel
