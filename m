From: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Subject: Re: ad714x driver help and possible bug
Date: Mon, 2 May 2011 16:43:18 -0400
Message-ID: <8EAE2AA4-C5A9-411C-B7E9-BB74C0716421@gmail.com>
References: <62821D7C-1637-4F7E-A53A-F52AEB2A6C87@gmail.com> <4DBA8AFE.6080807@cam.ac.uk> <4DBAD0AC.3010608@analog.com> <4DBAD21F.7040406@analog.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:49549 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752965Ab1EBUnN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 May 2011 16:43:13 -0400
In-Reply-To: <4DBAD21F.7040406@analog.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Hennerich <michael.hennerich@analog.com>
Cc: Jonathan Cameron <jic23@cam.ac.uk>, Barry Song <21cnbao@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>


On Apr 29, 2011, at 10:58, Michael Hennerich wrote:

> On 04/29/2011 04:52 PM, Michael Hennerich wrote:
>> On 04/29/2011 11:55 AM, Jonathan Cameron wrote:
>>> Cc'd input, and analog devices driver list...
>>> 
>>> On 04/28/11 19:17, Jean-Francois Dagenais wrote:
>>> 
>>> 
>>>> I also had to change the request_threaded_irq flags to specify
>>>> IRQF_ONESHOT so the kernel keeps the interrupt masked while we are
>>>> running ad714x_interrupt_thread(). Otherwise we were getting storms
>>>> of interrupts each time only one was requested. I am wondering if
>>>> this should be pulled back to the mainline kernel?
>>>> 
>>>> Thanks for pointers and clues!
>>>> 
>>>> 
>> I assume this is due to the fact that the interrupt on the host is
>> level sensitive.
>> In this case you need to use the IRQF_ONESHOT flag.
>> The unmodified driver requests the IRQ as IRQF_TRIGGER_FALLING, so
>> this is not necessary.
I succeeded in making the ISR occur only once per real interrupt, the problem I explained earlier remains.
>> 
>> To my knowledge we regularly test the driver with the sliders, wheels
>> and buttons found on the
>> official evaluation board, and so far we haven't found oddities.
>> For an example platform file see: arch/blackfin/mach-bf537/boards/stamp.c
>> From top of my head I don't know whether we're testing with the SPI or
>> I2C interface.
>> 
>> http://wiki.analog.com/software/driver/linux/ad714x
>> 
> -- 
> 
> Greetings,
> Michael
> 
> --
> Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
> Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
> Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
> Margaret Seif
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

