From: loody <miloody@gmail.com>
Subject: about input/hid
Date: Thu, 24 May 2012 21:38:51 +0800
Message-ID: <CANudz+v1RNDDwDLMWX-AbCUwagXrBH3xP5+-kimZuBsgCafkWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:59461 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752221Ab2EXNiw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 May 2012 09:38:52 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-usb@vger.kernel.org

hi all:
I have some questions about input/hid devices.
1. it seems only usb hid has reports_desc, why don't we put hid parse
in usbhid/hid-core.c instead of hid/hid-core.c?
2. at the end of mail is the report from mouse hid.
    i. where is the "USAGE_PAGE (Button) " defined, I cannot find
Button id in usage table.
    ii. REPORT_SIZE (1) always mean the unit is bit?
3. Spec seems only describe the value of the item mean, where I can
find the rules of the layout of the descriptor?

char ReportDescriptor[50] = {
02     0x05, 0x01,                    // USAGE_PAGE (Generic Desktop)
03     0x09, 0x02,                    // USAGE (Mouse)
04     0xa1, 0x01,                    // COLLECTION (Application)
05     0x09, 0x01,                    //   USAGE (Pointer)
06     0xa1, 0x00,                    //   COLLECTION (Physical)
07     0x05, 0x09,                    //     USAGE_PAGE (Button)
08     0x19, 0x01,                    //     USAGE_MINIMUM (Button 1)
09     0x29, 0x03,                    //     USAGE_MAXIMUM (Button 3)
10     0x15, 0x00,                    //     LOGICAL_MINIMUM (0)
11     0x25, 0x01,                    //     LOGICAL_MAXIMUM (1)
12     0x95, 0x03,                    //     REPORT_COUNT (3)
13     0x75, 0x01,                    //     REPORT_SIZE (1)
14     0x81, 0x02,                    //     INPUT (Data,Var,Abs)
15     0x95, 0x01,                    //     REPORT_COUNT (1)
16     0x75, 0x05,                    //     REPORT_SIZE (5)
17     0x81, 0x03,                    //     INPUT (Cnst,Var,Abs)
18     0x05, 0x01,                    //     USAGE_PAGE (Generic Desktop)
19     0x09, 0x30,                    //     USAGE (X)
20     0x09, 0x31,                    //     USAGE (Y)
21     0x15, 0x81,                    //     LOGICAL_MINIMUM (-127)
22     0x25, 0x7f,                    //     LOGICAL_MAXIMUM (127)
23     0x75, 0x08,                    //     REPORT_SIZE (8)
24     0x95, 0x02,                    //     REPORT_COUNT (2)
25     0x81, 0x06,                    //     INPUT (Data,Var,Rel)
26     0xc0,                          //   END_COLLECTION
27     0xc0                           // END_COLLECTION
28 };

Thanks for your help in advance,
