From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Fwd: [Bug 87991] New: hid-sony uses non-DMA-capable transfer buffer, fails
Date: Mon, 10 Nov 2014 10:37:38 -0800
Message-ID: <CAKdAkRQrxKxYTf7eqZWCxrxR9spk6x_zUCF6ZegG51vwt940eg@mail.gmail.com>
References: <bug-87991-3268@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:55408 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751930AbaKJShl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Nov 2014 13:37:41 -0500
Received: by mail-la0-f47.google.com with SMTP id gd6so8285369lab.34
        for <linux-input@vger.kernel.org>; Mon, 10 Nov 2014 10:37:39 -0800 (PST)
In-Reply-To: <bug-87991-3268@https.bugzilla.kernel.org/>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@oh.rr.com>
Cc: Jiri Kosina <jkosina@suse.cz>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

FYI

---------- Forwarded message ----------
From:  <bugzilla-daemon@bugzilla.kernel.org>
Date: Mon, Nov 10, 2014 at 5:43 AM
Subject: [Bug 87991] New: hid-sony uses non-DMA-capable transfer buffer, fails
To: dmitry.torokhov@gmail.com


https://bugzilla.kernel.org/show_bug.cgi?id=87991

            Bug ID: 87991
           Summary: hid-sony uses non-DMA-capable transfer buffer, fails
           Product: Drivers
           Version: 2.5
    Kernel Version: 3.17.1
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Input Devices
          Assignee: drivers_input-devices@kernel-bugs.osdl.org
          Reporter: hector@marcansoft.com
        Regression: No

The kernel itself complains:

input: Sony PLAYSTATION(R)3 Controller as
/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.2/1-1.2.2/1-1.2.2.4/1-1.2.2.4:1.0/0003:054C:0268.000A/input/input51
sony 0003:054C:0268.000A: input,hiddev0,hidraw3: USB HID v1.11 Joystick [Sony
PLAYSTATION(R)3 Controller] on usb-0000:00:1a.0-1.2.2.4/input0
------------[ cut here ]------------
WARNING: CPU: 1 PID: 27497 at drivers/usb/core/hcd.c:1503
usb_hcd_map_urb_for_dma+0x588/0x5a0 [usbcore]()
transfer buffer not dma capable
<snip>
sony 0003:054C:0268.000A: failed to retrieve feature report 0xf2 with the
Sixaxis MAC address
sony: probe of 0003:054C:0268.000A failed with error -11

Looks like the code just uses a stack-allocated buffer (from
drivers/hid/hid-sony.c):
        __u8 buf[18];
<snip comment>
        ret = hid_hw_raw_request(sc->hdev, 0xf2, buf, sizeof(buf),
                HID_FEATURE_REPORT, HID_REQ_GET_REPORT);

--
You are receiving this mail because:
You are watching the assignee of the bug.


-- 
Dmitry
