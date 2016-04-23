From: Manuel Reimer <mail+linux-input@m-reimer.de>
Subject: What's the difference between hid_hw_output_report and
 hid_hw_raw_request?
Date: Sat, 23 Apr 2016 16:05:45 +0200
Message-ID: <a0f08d24-0d11-7816-603d-2a198ee60caa@m-reimer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:59090 "EHLO mx2.mailbox.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751659AbcDWOFt (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 23 Apr 2016 10:05:49 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx2.mailbox.org (Postfix) with ESMTPS id ABFD243BF7
	for <linux-input@vger.kernel.org>; Sat, 23 Apr 2016 16:05:47 +0200 (CEST)
Received: from smtp1.mailbox.org ([80.241.60.240])
	by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
	with ESMTP id 6tDT_EB6OAi8 for <linux-input@vger.kernel.org>;
	Sat, 23 Apr 2016 16:05:46 +0200 (CEST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input <linux-input@vger.kernel.org>

Hello,

I want to enable the rumble motors on a PS4 controller using libusb.

The kernel code calls different functions depending on whether USB or 
Bluetooth is used:
https://github.com/torvalds/linux/blob/master/drivers/hid/hid-sony.c#L1901
This difference does not exist in the code for the PS3 controller.

So why is this difference in the kernel driver? What do I have to do to 
emulate "hid_hw_output_report" using libusb?

Thanks in advance.

Manuel


My current code, which does *not* work, follows. I also tried to not 
send the report ID as first byte in the command sequence, but this 
doesn't work either. The data seems to get sent without any problems, 
but the controller doesn't react in any way.

  uint8_t cmd[] = {
     0x05,
     0xFF, 0x00, 0x00, right, left,  // rumble values
     0xFF, 0xFF, 0xFF, 0x00, 0x00,  // Red, Green, Blue, TimeBright, 
TimeDark
     0x00, 0x00, 0x00, 0x00, 0x00,
     0x00, 0x00, 0x00, 0x00, 0x00,
     0x00, 0x00, 0x00, 0x00, 0x00,
     0x00, 0x00, 0x00, 0x00, 0x00,
     0x00
   };

   return libusb_control_transfer(usbdev,
                         LIBUSB_ENDPOINT_OUT | LIBUSB_REQUEST_TYPE_CLASS 
| LIBUSB_RECIPIENT_INTERFACE,
                         HID_REQ_SET_REPORT,
                         (HID_OUTPUT_REPORT<<8)|0x05,
                         0,
                         cmd,
                         sizeof(cmd),
                         USB_CTRL_GET_TIMEOUT);
