From: Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: ad714x driver help and possible bug
Date: Fri, 29 Apr 2011 16:58:39 +0200
Message-ID: <4DBAD21F.7040406@analog.com>
References: <62821D7C-1637-4F7E-A53A-F52AEB2A6C87@gmail.com> <4DBA8AFE.6080807@cam.ac.uk> <4DBAD0AC.3010608@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]:24358
	"EHLO VA3EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751697Ab1D2PIA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 29 Apr 2011 11:08:00 -0400
In-Reply-To: <4DBAD0AC.3010608@analog.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Cc: Jonathan Cameron <jic23@cam.ac.uk>, Barry Song <21cnbao@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On 04/29/2011 04:52 PM, Michael Hennerich wrote:
> On 04/29/2011 11:55 AM, Jonathan Cameron wrote:
>> Cc'd input, and analog devices driver list...
>>
>> On 04/28/11 19:17, Jean-Francois Dagenais wrote:
>>   
>>
>>> I also had to change the request_threaded_irq flags to specify
>>> IRQF_ONESHOT so the kernel keeps the interrupt masked while we are
>>> running ad714x_interrupt_thread(). Otherwise we were getting storms
>>> of interrupts each time only one was requested. I am wondering if
>>> this should be pulled back to the mainline kernel?
>>>
>>> Thanks for pointers and clues!
>>>
>>>     
> I assume this is due to the fact that the interrupt on the host is
> level sensitive.
> In this case you need to use the IRQF_ONESHOT flag.
> The unmodified driver requests the IRQ as IRQF_TRIGGER_FALLING, so
> this is not necessary.
>
> To my knowledge we regularly test the driver with the sliders, wheels
> and buttons found on the
> official evaluation board, and so far we haven't found oddities.
> For an example platform file see: arch/blackfin/mach-bf537/boards/stamp.c
> From top of my head I don't know whether we're testing with the SPI or
> I2C interface.
>
> http://wiki.analog.com/software/driver/linux/ad714x
>
-- 

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif


