From: Hartmut Knaack <knaack.h@gmx.de>
Subject: [RFC] enumeration of "composite devices" using v-usb
Date: Fri, 18 Jan 2013 23:56:19 +0100
Message-ID: <50F9D313.4070803@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:54940 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754549Ab3ARW4X (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Jan 2013 17:56:23 -0500
Received: from mailout-de.gmx.net ([10.1.76.31]) by mrigmx.server.lan
 (mrigmx001) with ESMTP (Nemesis) id 0MGUOc-1Tj9a13t5s-00DHNM for
 <linux-input@vger.kernel.org>; Fri, 18 Jan 2013 23:56:21 +0100
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,
I've built myself a joystick adapter (project website: http://www.hexagons.de/index.php/USB_Joystickadapter), which has the purpose of connecting up to 2 Atari style joysticks (the ones with db9 connectors, found on 80's home computers like C64, Amiga,...) via USB. Current situation is: on Windows XP, 2 joystick devices get created with 2 axis and 2 buttons each (as intended); while on Linux, just one joystick device (/dev/input/js0) gets created, but with 4 axis and 4 buttons.
This device provides one interface with one Interrupt-in Endpoint. The division into two joystick devices is done using an HID descriptor [1] with two configurations and the REPORT_ID tag.
What I would like to know is, is there a problem in the Linux HID parser, or is its behavior intentional and those composite devices more like a dirty solution around the standards?
Thanks

Hartmut Knaack

[1]
char usbHidReportDescriptor[102] PROGMEM = {
   
    // Joystick Port 1

    0x05, 0x01,                    // USAGE_PAGE (Generic Desktop)
    0x09, 0x04,                    // USAGE (Joystick)
    0xa1, 0x01,                    // COLLECTION (Application)
    0x85, 0x01,                    // REPORT_ID (1)
    0x09, 0x01,                    //   USAGE (Pointer)
    0xa1, 0x00,                    //   COLLECTION (Physical)
    0x09, 0x30,                    //     USAGE (X)
    0x09, 0x31,                    //     USAGE (Y)
    0x15, 0x00,                    //   LOGICAL_MINIMUM (0)
    0x26, 0xff, 0x00,               //   LOGICAL_MAXIMUM (255)
    0x75, 0x08,                    //   REPORT_SIZE (8)
    0x95, 0x02,                    //   REPORT_COUNT (2)
    0x81, 0x02,                    //   INPUT (Data,Var,Abs)
    0xc0,                          // END_COLLECTION
    0x05, 0x09,                    // USAGE_PAGE (Button)
    0x19, 0x01,                    //   USAGE_MINIMUM (Button 1)
    0x29, 0x02,                    //   USAGE_MAXIMUM (Button 2)
    0x15, 0x00,                    //   LOGICAL_MINIMUM (0)
    0x25, 0x01,                    //   LOGICAL_MAXIMUM (1)
    0x75, 0x01,                    // REPORT_SIZE (1)
    0x95, 0x02,                    // REPORT_COUNT (2)
    0x81, 0x02,                    // INPUT (Data,Var,Abs)
    0x75, 0x06,                    // REPORT_SIZE (6)
    0x95, 0x01,                    // REPORT_COUNT (1)
    0x81, 0x03,                    // INPUT (Constant,Var,Abs)
    0xc0,                          // END_COLLECTION

    // Joystick Port 2
   
    0x05, 0x01,                    // USAGE_PAGE (Generic Desktop)
    0x09, 0x04,                    // USAGE (Joystick)
    0xa1, 0x01,                    // COLLECTION (Application)
    0x85, 0x02,                    // REPORT_ID (2)
    0x09, 0x01,                    //   USAGE (Pointer)
    0xa1, 0x00,                    //   COLLECTION (Physical)
    0x09, 0x30,                    //     USAGE (X)
    0x09, 0x31,                    //     USAGE (Y)
    0x15, 0x00,                    //   LOGICAL_MINIMUM (0)
    0x26, 0xff, 0x00,               //   LOGICAL_MAXIMUM (255)
    0x75, 0x08,                    //   REPORT_SIZE (8)
    0x95, 0x02,                    //   REPORT_COUNT (2)
    0x81, 0x02,                    //   INPUT (Data,Var,Abs)
    0xc0,                          // END_COLLECTION
    0x05, 0x09,                    // USAGE_PAGE (Button)
    0x19, 0x01,                    //   USAGE_MINIMUM (Button 1)
    0x29, 0x02,                    //   USAGE_MAXIMUM (Button 2)
    0x15, 0x00,                    //   LOGICAL_MINIMUM (0)
    0x25, 0x01,                    //   LOGICAL_MAXIMUM (1)
    0x75, 0x01,                    // REPORT_SIZE (1)
    0x95, 0x02,                    // REPORT_COUNT (2)
    0x81, 0x02,                    // INPUT (Data,Var,Abs)
    0x75, 0x06,                    // REPORT_SIZE (6)
    0x95, 0x01,                    // REPORT_COUNT (1)
    0x81, 0x03,                    // INPUT (Constant,Var,Abs)
    0xc0                           // END_COLLECTION
};
