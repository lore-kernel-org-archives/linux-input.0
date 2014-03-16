From: cbkehler@gmail.com
Subject: USB touchscreen pointer jumping
Date: Sat, 15 Mar 2014 22:54:38 -0400
Message-ID: <20140316025438.GA21819@belkar.kehler.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f194.google.com ([209.85.223.194]:43011 "EHLO
	mail-ie0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752877AbaCPCyY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 15 Mar 2014 22:54:24 -0400
Received: by mail-ie0-f194.google.com with SMTP id to1so1584575ieb.5
        for <linux-input@vger.kernel.org>; Sat, 15 Mar 2014 19:54:24 -0700 (PDT)
Received: from mail.kehler.dyndns.org (bas11-london14-1176213461.dsl.bell.ca. [70.27.151.213])
        by mx.google.com with ESMTPSA id sc8sm9694387igb.0.2014.03.15.19.53.54
        for <linux-input@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 15 Mar 2014 19:54:12 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.kehler.dyndns.org (Postfix) with ESMTP id AF8FA10A758
	for <linux-input@vger.kernel.org>; Sat, 15 Mar 2014 23:01:01 -0400 (EDT)
Received: from mail.kehler.dyndns.org ([127.0.0.1])
	by localhost (mail.kehler.dyndns.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PSauuBxHmQaA for <linux-input@vger.kernel.org>;
	Sat, 15 Mar 2014 23:01:00 -0400 (EDT)
Received: from belkar (belkar.kehler.dyndns.org [192.168.3.50])
	by mail.kehler.dyndns.org (Postfix) with SMTP id 3765D10A748
	for <linux-input@vger.kernel.org>; Sat, 15 Mar 2014 23:00:59 -0400 (EDT)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello all,

  I've got an HP laptop with a usb touchscreen.  I'm not sure it's a bug in X or the kernel but the
pointer will jump to a spot in the upper right corner at random intervals.  Sometimes it can go hours
between jumps and sometimes it jumps every second or two making the laptop virtually unusable.  The
kernel is 3.14.0-rc5, though this has been happening with every kernel since I got the laptop 4 months
ago.  

  I've included all the information that I could think of that might be relevant.

Thanks,
	/Chris

#evtest /dev/input/event15
Input driver version is 1.0.1
Input device ID: bus 0x3 vendor 0xeef product 0xa802 version 0x210
Input device name: "eGalax Inc. eGalaxTouch EXC7920-2003-11.03.02"
Supported events:
  Event type 0 (EV_SYN)
  Event type 1 (EV_KEY)
    Event code 330 (BTN_TOUCH)
  Event type 3 (EV_ABS)
    Event code 0 (ABS_X)
      Value   3979
      Min        0
      Max     4095
      Resolution      11
    Event code 1 (ABS_Y)
      Value    558
      Min        0
      Max     4095
      Resolution      19
    Event code 47 (ABS_MT_SLOT)
      Value      0
      Min        0
      Max        9
    Event code 53 (ABS_MT_POSITION_X)
      Value      0
      Min        0
      Max     4095
      Resolution      11
    Event code 54 (ABS_MT_POSITION_Y)
      Value      0
      Min        0
      Max     4095
      Resolution      19
    Event code 57 (ABS_MT_TRACKING_ID)
      Value      0
      Min        0
      Max    65535
Properties:
  Property type 1 (INPUT_PROP_DIRECT)
Testing ... (interrupt to exit)
Event: time 1394938209.404732, type 3 (EV_ABS), code 57 (ABS_MT_TRACKING_ID), value 943
Event: time 1394938209.404732, type 3 (EV_ABS), code 53 (ABS_MT_POSITION_X), value 3971
Event: time 1394938209.404732, type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 569
Event: time 1394938209.404732, type 1 (EV_KEY), code 330 (BTN_TOUCH), value 1
Event: time 1394938209.404732, type 3 (EV_ABS), code 0 (ABS_X), value 3971
Event: time 1394938209.404732, type 3 (EV_ABS), code 1 (ABS_Y), value 569
Event: time 1394938209.404732, -------------- SYN_REPORT ------------
Event: time 1394938209.437732, type 3 (EV_ABS), code 57 (ABS_MT_TRACKING_ID), value -1
Event: time 1394938209.437732, type 1 (EV_KEY), code 330 (BTN_TOUCH), value 0
Event: time 1394938209.437732, -------------- SYN_REPORT ------------
Event: time 1394938231.081763, type 3 (EV_ABS), code 57 (ABS_MT_TRACKING_ID), value 944
Event: time 1394938231.081763, type 3 (EV_ABS), code 53 (ABS_MT_POSITION_X), value 3972
Event: time 1394938231.081763, type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 563
Event: time 1394938231.081763, type 1 (EV_KEY), code 330 (BTN_TOUCH), value 1
Event: time 1394938231.081763, type 3 (EV_ABS), code 0 (ABS_X), value 3972
Event: time 1394938231.081763, type 3 (EV_ABS), code 1 (ABS_Y), value 563
Event: time 1394938231.081763, -------------- SYN_REPORT ------------
Event: time 1394938231.116762, type 3 (EV_ABS), code 57 (ABS_MT_TRACKING_ID), value -1
Event: time 1394938231.116762, type 1 (EV_KEY), code 330 (BTN_TOUCH), value 0
Event: time 1394938231.116762, -------------- SYN_REPORT ------------
^C

# lsusb
Bus 002 Device 002: ID 8087:8000 Intel Corp. 
Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 001 Device 002: ID 8087:8008 Intel Corp. 
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 003 Device 005: ID 05c8:0361 Cheng Uei Precision Industry Co., Ltd (Foxlink) 
Bus 003 Device 004: ID 8087:07da Intel Corp. 
Bus 003 Device 048: ID 058f:6254 Alcor Micro Corp. USB Hub
Bus 003 Device 007: ID 138a:0050 Validity Sensors, Inc. 
Bus 003 Device 052: ID 0eef:a802 D-WAV Scientific Co., Ltd 
Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

# lsusb -v -s 003:052

Bus 003 Device 052: ID 0eef:a802 D-WAV Scientific Co., Ltd 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0        64
  idVendor           0x0eef D-WAV Scientific Co., Ltd
  idProduct          0xa802 
  bcdDevice            3.03
  iManufacturer           1 eGalax Inc.
  iProduct                2 eGalaxTouch EXC7920-2003-11.03.02
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           34
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          1 eGalax Inc.
    bmAttributes         0xa0
      (Bus Powered)
      Remote Wakeup
    MaxPower              100mA
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
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               2.10
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength     494
         Report Descriptors: 
           ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               1
Device Status:     0x0003
  Self Powered
  Remote Wakeup Enabled

