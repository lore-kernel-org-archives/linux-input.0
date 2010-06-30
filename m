From: Alan Ott <alan@signal11.us>
Subject: Re: Report ID problem with HID-RAW interface usage
Date: Wed, 30 Jun 2010 10:10:03 -0400
Message-ID: <4C2B503B.7020209@signal11.us>
References: <AANLkTinrmRsB39gj7Ie4xCr3fhP3jU1dfYuVrkiKv347@mail.gmail.com>	<4C2A1FA0.6020704@signal11.us>	<alpine.LNX.2.00.1006301126130.13809@pobox.suse.cz>	<AANLkTilf1JU_GPlqE-FeaRon6IMqgA68WZ964PJfLpSP@mail.gmail.com>	<alpine.LNX.2.00.1006301252380.13809@pobox.suse.cz>	<AANLkTil-hNWeWbLQqE0ezlmZhO1w402NClaT_tayPJra@mail.gmail.com>	<4C2B3E6B.7060703@signal11.us>	<AANLkTilzYu3mA3vDzuVyxngTcltgKEoNKYrdenz1Z-VG@mail.gmail.com>	<20100630151358.d9c9f043.ospite@studenti.unina.it> <AANLkTimpiuADYMRmPNWO_qWjQj1LKyjmh3JncuK9Fa4I@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from core.signal11.us ([64.251.29.136]:48087 "EHLO core.signal11.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756074Ab0F3OKF (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Jun 2010 10:10:05 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by core.signal11.us (Postfix) with SMTP id 6E11F10406F
	for <linux-input@vger.kernel.org>; Wed, 30 Jun 2010 10:10:04 -0400 (EDT)
In-Reply-To: <AANLkTimpiuADYMRmPNWO_qWjQj1LKyjmh3JncuK9Fa4I@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Xiaofan Chen <xiaofanc@gmail.com>
Cc: Antonio Ospite <ospite@studenti.unina.it>, Amit Nagal <helloin.amit@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

On 06/30/2010 10:02 AM, Xiaofan Chen wrote:
> On Wed, Jun 30, 2010 at 9:13 PM, Antonio Ospite
> <ospite@studenti.unina.it>  wrote:
>    
>> One of the advantages in the usb case is that you do not have to
>> _detach_ the kernel driver bound to the device in order to set/get
>> raw hid reports. With libusb this is needed.
>>
>>      
> To me this is not that much an advantage. Actually libusb-1.0
> has the API to re-attach the kernel driver under Linux. And we make
> use of this in the new libusb-1.0 example program xusb.
> http://libusb.sourceforge.net/api-1.0/group__dev.html#ga9de769d3aeb45a07f5559c8a0597cbcc
> http://git.libusb.org/?p=libusb-pbatard.git;a=blob;f=examples/xusb.c;h=e260153aa50234f1c994db521969b7f0e84aebb6;hb=HEAD
>    

Another advantage of hidraw is that the API does not depend on the 
transport. As Jiri said, it supports multiple hardware types, but beyond 
that, one does not have to worry about whether to send data over the 
control endpoint vs. interrupt endpoints, whether the report number gets 
added properly (in theory, when there aren't bugs :) ), etc.

The theory is that one can throw data at hidraw using simple read() and 
write() commands, and it comes out on the device side, without the 
client program having to know too much about USB or Bluetooth.

That's an advantage to me anyway. It's true that libusb is more flexible 
for USB devices as it handles custom class, and non-HID class devices, 
and can send data on any endpoint directly. The HID is supposed to be a 
simplified interface (limited endpoints, well-structured data, etc), so 
it makes sense to have a simplified API to communicate with it.

Think of hidraw as analogous to the Windows hid.dll API. The concepts 
are similar.

Alan.


