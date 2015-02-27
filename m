From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: Inactive keyboard on Acer Aspire Switch 11
Date: Thu, 26 Feb 2015 19:46:34 -0500
Message-ID: <CAN+gG=Fsu5rPFGMtKyOtQsCazL4MZgYX6bx1WsybH5Zj-Hg=ZQ@mail.gmail.com>
References: <54EFA9CF.6000100@butterbrot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qa0-f48.google.com ([209.85.216.48]:54387 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752169AbbB0Aqf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Feb 2015 19:46:35 -0500
Received: by mail-qa0-f48.google.com with SMTP id dc16so10578056qab.7
        for <linux-input@vger.kernel.org>; Thu, 26 Feb 2015 16:46:35 -0800 (PST)
In-Reply-To: <54EFA9CF.6000100@butterbrot.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Florian Echtler <floe@butterbrot.org>
Cc: linux-input <linux-input@vger.kernel.org>

On Thu, Feb 26, 2015 at 6:18 PM, Florian Echtler <floe@butterbrot.org> wrote:
> Hello everyone,
>
> I've recently bought an Acer Aspire Switch 11 convertible
> tablet/notebook hybrid device. Ubuntu 14.04.2 with kernel 3.16 runs
> almost perfectly, with one notable exception: on the keyboard dock, only
> the touchpad works, not the keyboard itself. I've done a bit of digging
> in the logs, and found the following error messages relating to HID:
>
> [    8.790574] hidraw: raw HID events driver (C) Jiri Kosina
> [    8.796341] hid (null): usage index exceeded
> [    8.845668] usbcore: registered new interface driver usbhid
> [    8.845671] usbhid: USB HID core driver
> [   19.593717] hid-multitouch 0003:06CB:2991.0002:
> input,hiddev0,hidraw0: USB HID v1.10 Mouse [ITE Tech. Inc. ITE
> Device(8595)] on usb-0000:00:14.0-4.3/input1
> [   19.594268] hid-rmi 0003:06CB:2991.0001: usage index exceeded
> [   19.594274] hid-rmi 0003:06CB:2991.0001: item 0 2 2 2 parsing failed
> [   19.594288] hid-rmi 0003:06CB:2991.0001: parse failed
> [   19.594301] hid-rmi: probe of 0003:06CB:2991.0001 failed with error -22
> [   19.609228] hid-multitouch 0018:06CB:77B2.0004: input,hidraw1:
> <UNKNOWN> HID v1.00 Mouse [SYNA7508:00 06CB:77B2] on
> [   19.924619] i2c_hid i2c-ITE8380:00: error in i2c_hid_init_report
> size:19 / ret_size:18
>
> The device in question has two endpoints:
>
> T:  Bus=02 Lev=02 Prnt=04 Port=02 Cnt=01 Dev#=  7 Spd=12  MxCh= 0
> D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
> P:  Vendor=06cb ProdID=2991 Rev=00.06
> S:  Manufacturer=ITE Tech. Inc.
> S:  Product=ITE Device(8595)
> C:  #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
> I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=01 Driver=usbhid
> I:  If#= 1 Alt= 0 #EPs= 2 Cls=03(HID  ) Sub=01 Prot=02 Driver=usbhid
>
> According to lsusb, the second one is a mouse (= touchpad), while the
> first one is a keyboard (see attached lsusb.txt). Judging from the
> dmesg, this is also the one which fails to initialize. Can anyone
> suggest any quirks/fixes to try here?

Hi Florian,

This was a known bug which has been fixed in a more recent kernel than
3.16. I think a 3.17 might work, but I think a 3.18 would be a better
choice.
cf: e19ff99f256aeeff6c07b373e01883b72e049552 in Linus' tree

Cheers,
Benjamin

>
> Thanks & best regards, Florian
> --
> SENT FROM MY DEC VT50 TERMINAL
