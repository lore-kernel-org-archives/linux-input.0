From: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Subject: RE: about input/hid
Date: Thu, 24 May 2012 15:16:37 +0000
Message-ID: <4FA419E87744DF4DAECD5BCE1214B7A91930E332@ORSMSX104.amr.corp.intel.com>
References: <CANudz+v1RNDDwDLMWX-AbCUwagXrBH3xP5+-kimZuBsgCafkWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:30079 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753034Ab2EXPQj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 May 2012 11:16:39 -0400
In-Reply-To: <CANudz+v1RNDDwDLMWX-AbCUwagXrBH3xP5+-kimZuBsgCafkWw@mail.gmail.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: loody <miloody@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>

I think it should be independent of USB and should be part of hid-core.c.
There is a possibility that HID over I2C, proprietary specs used by Win8 can be a standard in future.

Thanks,
Srinivas


-----Original Message-----
From: linux-input-owner@vger.kernel.org [mailto:linux-input-owner@vger.kernel.org] On Behalf Of loody
Sent: Thursday, May 24, 2012 6:39 AM
To: linux-input@vger.kernel.org; linux-usb@vger.kernel.org
Subject: about input/hid

hi all:
I have some questions about input/hid devices.
1. it seems only usb hid has reports_desc, why don't we put hid parse in usbhid/hid-core.c instead of hid/hid-core.c?
2. at the end of mail is the report from mouse hid.
    i. where is the "USAGE_PAGE (Button) " defined, I cannot find Button id in usage table.
    ii. REPORT_SIZE (1) always mean the unit is bit?
3. Spec seems only describe the value of the item mean, where I can find the rules of the layout of the descriptor?

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
--
To unsubscribe from this list: send the line "unsubscribe linux-input" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
