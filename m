From: =?ISO-8859-1?Q?R=E9mi_Cattiau?= <remi@cattiau.com>
Subject: Re: [Bugme-new] [Bug 13411] New: Barscanner (USB HID Keyboard) stopped
 functioning in kernels >= 2.6.28
Date: Tue, 01 Dec 2009 21:07:14 +0100
Message-ID: <4B157772.1050207@cattiau.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from sd-5685.dedibox.fr ([88.191.36.166]:39954 "EHLO
	sd-5685.dedibox.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751352AbZLAUC4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Dec 2009 15:02:56 -0500
Received: from [192.168.2.171] (home.loopingz.com [88.169.47.23])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by sd-5685.dedibox.fr (Postfix) with ESMTP id 176349E015A
	for <linux-input@vger.kernel.org>; Wed,  2 Dec 2009 01:37:24 +0100 (CET)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

  Hello all,

Here my lsusb :
Bus 001 Device 006: ID 1130:0001 Tenx Technology, Inc.

Bus 001 Device 006: ID 1130:0001 Tenx Technology, Inc.
Device Descriptor:
   bLength                18
   bDescriptorType         1
   bcdUSB               1.10
   bDeviceClass            0 (Defined at Interface level)
   bDeviceSubClass         0
   bDeviceProtocol         0
   bMaxPacketSize0         8
   idVendor           0x1130 Tenx Technology, Inc.
   idProduct          0x0001
   bcdDevice            1.00
   iManufacturer           0
   iProduct                2
   iSerial                 0
   bNumConfigurations      1
   Configuration Descriptor:
     bLength                 9
     bDescriptorType         2
     wTotalLength           59
     bNumInterfaces          2
     bConfigurationValue     1
     iConfiguration          0
     bmAttributes         0x80
       (Bus Powered)
     MaxPower              100mA
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        0
       bAlternateSetting       0
       bNumEndpoints           1
       bInterfaceClass         3 Human Interface Device
       bInterfaceSubClass      0 No Subclass
       bInterfaceProtocol      0 None
       iInterface              0
       ** UNRECOGNIZED:  09 21 10 01 00 01 22 29 00
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x81  EP 1 IN
         bmAttributes            3
           Transfer Type            Interrupt
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0008  1x 8 bytes
         bInterval              10
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        1
       bAlternateSetting       0
       bNumEndpoints           1
       bInterfaceClass         3 Human Interface Device
       bInterfaceSubClass      0 No Subclass
       bInterfaceProtocol      0 None
       iInterface              0
       ** UNRECOGNIZED:  09 21 10 01 21 01 22 17 00
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x82  EP 2 IN
         bmAttributes            3
           Transfer Type            Interrupt
           Synch Type               None
           Usage Type               Data
         wMaxPacketSize     0x0008  1x 8 bytes
         bInterval              10


I'll send an email to admin@usb.org <mailto:admin@usb.org>  to know=20
which one is a valid member.
Let me know if any trouble

R=E9mi

Le 01/12/2009 11:40, Jiri Kosina a =E9crit :
> On Sat, 28 Nov 2009, Guido Dorssers wrote:
>
>   =20
>>> The problem apparently [1] is, that the vendor has been super-creat=
ive and
>>> assigned the same combination of idVendor/idProduct to completely
>>> different devices. Oh well.
>>>
>>> Remi, could you please check your device against the lsusb data pro=
vided
>>> in bugzilla to check whether there is any possibility to distinguis=
h these
>>> devices, so that we could put some ugly check in place probably?
>>>
>>> Thanks.
>>>
>>> [1]http://lkml.org/lkml/2009/2/10/434
>>>
>>>       =20
>> Hi all,
>>
>> A belated thanks for having pointed me into the right direction to g=
et my
>> barcodescanner operational. However, as a thought since the bug is s=
till
>> present, why not solve it with something as simple as making the bla=
cklisting
>> user-configurable instead of blacklisting valid HID devices on purpo=
se?
>>     =20
> Hi,
>
> actually, my current plan is to remove the blacklist entry for this
> combination of VID/PID completely, and let the user decide and unbind=
 the
> driver via sysfs eventually, if needed (maybe together with warning i=
n
> dmesg).
>
> As the vendor apparently messed up horribly, as far as I understand, =
I
> don't really see another option.
>
>   =20


--=20
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
