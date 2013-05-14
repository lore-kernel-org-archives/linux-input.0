From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Support of Genius mouse with huge max_usage
Date: Tue, 14 May 2013 16:21:55 +0200
Message-ID: <CAN+gG=FAPziNr7g54MUbw-yFm299Myi3Jnz_0HQRxTAjNB4XLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:65412 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754772Ab3ENOV4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 May 2013 10:21:56 -0400
Received: by mail-lb0-f178.google.com with SMTP id p10so692337lbv.9
        for <linux-input@vger.kernel.org>; Tue, 14 May 2013 07:21:55 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input <linux-input@vger.kernel.org>

Hi Jiri,

I have a bug from an owner of a Gila mouse from Genius which I'm not
sure how to handle it:
https://bugzilla.redhat.com/show_bug.cgi?id=959721

The user gave me the hid-replay traces and within the first trace (the
one from hidraw0), I can extract the culprit collection:

0x05, 0x0c,                    // Usage Page (Consumer Devices)       104
0x09, 0x01,                    // Usage (Consumer Control)            106
0xa1, 0x01,                    // Collection (Application)            108
0x85, 0x03,                    //   Report ID (3)                     110
0x19, 0x00,                    //   Usage Minimum (0)                 112
0x2a, 0xff, 0x7f,              //   Usage Maximum (32767)             114
0x15, 0x00,                    //   Logical Minimum (0)               117
0x26, 0xff, 0x7f,              //   Logical Maximum (32767)           119
0x75, 0x10,                    //   Report Size (16)                  122
0x95, 0x03,                    //   Report Count (3)                  124
0x81, 0x00,                    //   Input (Data,Arr,Abs)              126
0x75, 0x08,                    //   Report Size (8)                   128
0x95, 0x01,                    //   Report Count (1)                  130
0x81, 0x01,                    //   Input (Cnst,Arr,Abs)              132
0xc0,                          // End Collection                      134

This hid device declares an array of 32767 usages, but HID_MAX_USAGES
is set to 12288 as mentioned in the bug.
One solution (given in the bug) consists in setting HID_MAX_USAGES to
32767, but I'm not very comfortable with this large value which will
impact all the existing hid devices.

So what approach do you prefer:
- setting HID_MAX_USAGES to 32767
- writing a specific driver which fixes this unused collection through
a report fixup?
- a generic fix (to be written) within hid-core which detects and
prevents these huge max usage.

Cheers,
Benjamin
