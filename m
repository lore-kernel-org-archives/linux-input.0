From: Jarod Wilson <jarod@redhat.com>
Subject: Re: [PATCHes] Apple IR receiver driver
Date: Mon, 18 Jan 2010 11:39:54 -0500
Message-ID: <4B548EDA.2080601@redhat.com>
References: <1263824065.20565.2730.camel@localhost.localdomain>	 <20100118143412.GA9831@mac.home>	 <1263826271.20565.2769.camel@localhost.localdomain>	 <20100118154806.GA10298@mac.home>	 <1263830833.20565.2849.camel@localhost.localdomain>	 <20100118161933.GA10491@mac.home> <1263832564.20565.2884.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:63397 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751356Ab0ARQkR (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Jan 2010 11:40:17 -0500
In-Reply-To: <1263832564.20565.2884.camel@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Tino Keitel <tino.keitel@tikei.de>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Matthew Garrett <mjg@redhat.com>

On 1/18/10 11:36 AM, Bastien Nocera wrote:
> On Mon, 2010-01-18 at 17:19 +0100, Tino Keitel wrote:
>> On Mon, Jan 18, 2010 at 16:07:13 +0000, Bastien Nocera wrote:
>>> Pass something along those lines:
>>> usbhid.quirks=0xVID:0xPID:0xQUIRK
>>> on the kernel command-line, and the appleir won't pick up the device,
>>> and the current quirks would be restored.
>>
>> So I guess this would be usbhid.quirks=0x05ac:0x8240:0xsomething.
>>
>> The remaining question is what "something" should be.
> 
> The mask for HIDDEV and HIDINPUT_IGNORE (which I don't know on top of my
> head, and will only lookup if Dmitry thinks documentation is required).

HID_QUIRK_IGNORE, iirc, is 0x4.

>>> Given that I seriously doubt there's very many people interested in
>>> using "non-standard" remotes with those receivers, it would make most
>>> users' life easier (and I doubt that the people that have the hardware
>>> bothered setting up lirc on their systems...).
>>
>> IMHO "non-standard" remotes are interesting especially with this
>> remote, because the vendor supplied remote has only six keys.          
> 
> Yes, and I don't know of anyone using the non-standard remotes with this
> receiver, and they could still do it with a bit of tweaking (which would
> be necessary to setup the other keys anyway).

The most common non-standard remote I've heard of people using is a
Logitech Harmony remote, which they program 6 buttons at a time, then
cycle to the next code set, program 6 more, rinse, repeat, etc.

-- 
Jarod Wilson
jarod@redhat.com
