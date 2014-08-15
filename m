From: loody <miloody@gmail.com>
Subject: Re: test program to check usb hid devices
Date: Fri, 15 Aug 2014 22:31:13 +0800
Message-ID: <CANudz+tUuopx=HT0FcKJ8Ak6_K0yz-nRf7=FwtcMDH9WW1MfbA@mail.gmail.com>
References: <CANudz+s-2QFtpxDqj2O-tJkhEM0oWoFvjWb=xrt+F_eUmPXaog@mail.gmail.com>
	<063D6719AE5E284EB5DD2968C1650D6D17478786@AcuExch.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f172.google.com ([74.125.82.172]:49993 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846AbaHOObP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Aug 2014 10:31:15 -0400
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D17478786@AcuExch.aculab.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Laight <David.Laight@aculab.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

hi David:

2014-08-15 20:54 GMT+08:00 David Laight <David.Laight@aculab.com>:
> From: loody
>> Is there any test program we can use to capture input data send from
>> usb keyboard/mouse?
>
> google usbmon
Sorry for making you confused.
What I need is not monitor usb bus data.
What I need is some user mode program, and when I execute it, it will
driver usb HID keyboard/mouse to work.
And I can print out the hex value those device send once user press
any key on keyboard or moving mouse around.

It should be like I think
hid_device=hid_open(xxx);
while(1){
      data = get input data(hid_device);
      printf("0x%x\n",data);
}

Appreciate your kind help,
