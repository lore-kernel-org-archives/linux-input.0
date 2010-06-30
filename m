From: Xiaofan Chen <xiaofanc@gmail.com>
Subject: Re: Report ID problem with HID-RAW interface usage
Date: Wed, 30 Jun 2010 22:02:00 +0800
Message-ID: <AANLkTimpiuADYMRmPNWO_qWjQj1LKyjmh3JncuK9Fa4I@mail.gmail.com>
References: <AANLkTinrmRsB39gj7Ie4xCr3fhP3jU1dfYuVrkiKv347@mail.gmail.com>
	<4C2A1FA0.6020704@signal11.us>
	<alpine.LNX.2.00.1006301126130.13809@pobox.suse.cz>
	<AANLkTilf1JU_GPlqE-FeaRon6IMqgA68WZ964PJfLpSP@mail.gmail.com>
	<alpine.LNX.2.00.1006301252380.13809@pobox.suse.cz>
	<AANLkTil-hNWeWbLQqE0ezlmZhO1w402NClaT_tayPJra@mail.gmail.com>
	<4C2B3E6B.7060703@signal11.us>
	<AANLkTilzYu3mA3vDzuVyxngTcltgKEoNKYrdenz1Z-VG@mail.gmail.com>
	<20100630151358.d9c9f043.ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:60085 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754824Ab0F3OCC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Jun 2010 10:02:02 -0400
In-Reply-To: <20100630151358.d9c9f043.ospite@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: Alan Ott <alan@signal11.us>, Amit Nagal <helloin.amit@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

On Wed, Jun 30, 2010 at 9:13 PM, Antonio Ospite
<ospite@studenti.unina.it> wrote:
>
> One of the advantages in the usb case is that you do not have to
> _detach_ the kernel driver bound to the device in order to set/get
> raw hid reports. With libusb this is needed.
>

To me this is not that much an advantage. Actually libusb-1.0
has the API to re-attach the kernel driver under Linux. And we make
use of this in the new libusb-1.0 example program xusb.
http://libusb.sourceforge.net/api-1.0/group__dev.html#ga9de769d3aeb45a07f5559c8a0597cbcc
http://git.libusb.org/?p=libusb-pbatard.git;a=blob;f=examples/xusb.c;h=e260153aa50234f1c994db521969b7f0e84aebb6;hb=HEAD


-- 
Xiaofan
