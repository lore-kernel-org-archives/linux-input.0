From: loody <miloody@gmail.com>
Subject: Why my usb mouse don't have report/physical descriptors
Date: Mon, 26 Jul 2010 00:18:18 +0800
Message-ID: <AANLkTi=iKJRXE8SczRA=hdPB64zkXbm5tGfYCM_RyZhT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:60057 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751206Ab0GYQST (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 25 Jul 2010 12:18:19 -0400
Received: by gxk23 with SMTP id 23so615139gxk.19
        for <linux-input@vger.kernel.org>; Sun, 25 Jul 2010 09:18:18 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Dear all:
I see there are report and physical descriptrs in hid spec.
But when I dump my HID device, a mouse, I cannot see these 2 descriptors.
How could I see these 2 descriptors on my HID device?
attach the content of my HID device at the end of letter.
Appreciate your help,
miloody

Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Device
      bInterfaceSubClass      1 Boot Interface Subclass
      bInterfaceProtocol      2 Mouse
      iInterface              0
      ** UNRECOGNIZED:  09 21 10 01 00 01 22 34 00
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0004  1x 4 bytes
        bInterval              10
Device Status:     0x0000
  (Bus Powered)
