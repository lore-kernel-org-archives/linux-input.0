From: Ellen Wang <ellen@cumulusnetworks.com>
Subject: Re: [PATCH v2] HID: support i2c write-read and large transfers in
 hid-cp2112
Date: Wed, 17 Jun 2015 17:55:51 -0700
Message-ID: <55821717.2000609@cumulusnetworks.com>
References: <1434183990-2324-1-git-send-email-ellen@cumulusnetworks.com> <CAAj6DX0w2p0h_wS2_T2+kU-zLEDo+adCmosPaUHWPVJeEpsaTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:33237 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753799AbbFRAzy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Jun 2015 20:55:54 -0400
Received: by pdjn11 with SMTP id n11so53183829pdj.0
        for <linux-input@vger.kernel.org>; Wed, 17 Jun 2015 17:55:53 -0700 (PDT)
In-Reply-To: <CAAj6DX0w2p0h_wS2_T2+kU-zLEDo+adCmosPaUHWPVJeEpsaTw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Borneo <borneo.antonio@gmail.com>
Cc: David Barksdale <dbarksdale@uplogix.com>, Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>, linux-i2c@vger.kernel.org

On 06/15/2015 02:10 AM, Antonio Borneo wrote:
> On Sat, Jun 13, 2015 at 4:26 PM, Ellen Wang <ellen@cumulusnetworks.com> wrote:
>> cp2112_i2c_xfer() only supports a single i2c_msg and only
>> reads up to 61 bytes.  More than one message at a time
>> and longers reads just return errors.  This breaks certain
>> important cases.  For example, the at24 eeprom driver generates
>> paired write and read messages (for eeprom address and data).
>> And the reads can be larger than 61 bytes.
>>
>> Since the device doesn't support i2c repeated starts in general,
>> but does support a single write-repeated-start-read pair
>> (as CP2112_DATA_WRITE_READ_REQUEST), we recognize the latter
>> case and implement only that.
>>
>> To support large reads, we wrap a loop around cp2112_read()
>> to pick up all the returned data.
>
> Hi Ellen,
>
> to keep git log consistent, the subject should change to something like
> HID: cp2112: ...

OK.  Will fix.


> Actually you are adding two features.
> I think should be better to split them in two independent patches.
>
> ...
>
> The part above goes in a patch for write-read, the part below in
> another patch for large transfers.
>
> I have tested you patch and works fine; I can read an I2C eeprom.
>
> But I also check with an oscilloscope the I2C signals and I got
> disappointed. There is no repeated START.
> I can clearly see cp2112 generating a STOP immediately followed by a START.
> Datasheet of cp2112 in figure 8 reports the expected time diagram with
> repeated START, but it's not what I get on my HW.
> Your code seam ok. Maybe my device is outdated or broken.
> The errata document from Silabs does not report anythink relevant.
>
> Can you verify with a scope on your HW too?
>
> Thanks,
> Antonio
> ...

Since the the long-read fix is less controversial, I've split it out and 
sent it as a separate patch.

As for repeated start, it's not that easy for me to check it.  The chip 
is in a rack-mounted network switch.  However, if you really want me to 
verify it, I can pull the box out and hook it up on a bench.

The Silabs datasheet clearly states that the device is supposed to issue 
a repeated start (rev 1.2, 
http://www.silabs.com/Support%20Documents/TechnicalDocs/CP2112.pdf, 
figure 8 on page 15).

Is your chip an older rev?  Mine is rev 2 (but as you said, there would 
have been an erratum if they fixed a hardware bug).

usb 1-1.2.3: New USB device found, idVendor=10c4, idProduct=ea90
usb 1-1.2.3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 1-1.2.3: Product: CP2112 HID USB-to-SMBus Bridge
usb 1-1.2.3: Manufacturer: Silicon Laboratories
usb 1-1.2.3: SerialNumber: 00343E9A
cp2112 0003:10C4:EA90.0001: hidraw0: USB HID v1.01 Device [Silicon 
Laboratories
  CP2112 HID USB-to-SMBus Bridge] on usb-0000:00:16.0-1.2.3/input0
cp2112 0003:10C4:EA90.0001: Part Number: 0x0C Device Version: 0x02
