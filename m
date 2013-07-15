From: David Herrmann <dh.herrmann@gmail.com>
Subject: [RFC 0/8] HID: Transport Driver Cleanup
Date: Mon, 15 Jul 2013 19:10:09 +0200
Message-ID: <1373908217-16748-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:36609 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219Ab3GORKe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Jul 2013 13:10:34 -0400
Received: by mail-ea0-f174.google.com with SMTP id o10so7838516eaj.5
        for <linux-input@vger.kernel.org>; Mon, 15 Jul 2013 10:10:33 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Oliver Neukum <oliver@neukum.org>, David Herrmann <dh.herrmann@gmail.com>

Hi

This series provides some cleanups for HID transport drivers:
 Patch #1: Cleanup which can be picked up
 Patch #2-#6: Provide generic hidinput_input_event() helpers
 Patch #7-#8: Transport-driver Cleanup

Patch #7-#8 is an attempt to clean up the transport driver callbacks. Lets look
at how the following hooks are currently implemented:
 1) GET_REPORT: Issue a synchronous GET_REPORT via the ctrl-channel
 2) SET_REPORT: Issue a synchronous SET_REPORT via the ctrl-channel
 3) OUTPUT: Issue an asynchronous OUTPUT report on the intr-channel

USB-HID:
 1) GET_REPORT can be issued via ->hid_get_raw_report() for all three report
    types correctly.
 2) SET_REPORT can only be issued for FEATURE reports via
    ->hid_output_raw_report(). INPUT and OUTPUT reports on the same callback
    cause an asynchronous report on the intr channel.
 3) OUTPUT reports can be issued via ->hid_output_raw_report() as described
    above in SET_REPORT.

HIDP:
 1) GET_REPORT: same as for USB-HID
 2) SET_REPORT can only be issued for FEATURE reports via
    ->hid_output_raw_report(). SET_REPORT for INPUT reports is forbidden (why?)
    and SET_REPORT for OUTPUT reports is actually implemented as 3)
 3) OUTPUT reports can be issued via ->hid_output_raw_report().

I2C:
 1) GET_REPORT implemented for INPUT and FEATURE via ->hid_get_raw_report().
    Forbidden for OUTPUT reports (why?).
 2) SET_REPORT can be issued for OUTPUT and FEATURE reports via
    ->hid_output_raw_report() but is forbidden for INPUT reports (why?).
 3) OUTPUT reports cannot be issued at all.

UHID:
 1) GET_REPORT only supported for FEATURE via ->hid_get_raw_report()
 2) SET_REPORT not supported at all
 3) OUTPUT supported via ->hid_output_raw_report()


As this is all very inconsistent, I added two new callbacks:
 ->raw_request() is the same as ->request() but with a raw buffer. It should be
 implemented by the transport drivers as SET/GET_REPORT calls in the
 ctrl-channel.

 ->output_report() is supposed to send an OUTPUT report on the intr-channel
 (same channel asynchronous input reports are received from).

Please see the hid-transport.txt for a description. The last patch tries to
implement them. I have no idea how to implement it for i2c, it seems that i2c
multiplexes ctrl and intr channels on a single i2c channel. I don't know how to
send raw output reports at all.. Help welcome!


If there is more interest in this work, I will clean it up, try to convert the
other hid_ll_driver drivers and resend as a proper patchset.

Cheers
David

David Herrmann (8):
  HID: usbhid: make usbhid_set_leds() static
  HID: usbhid: update LED fields unlocked
  HID: input: generic hidinput_input_event handler
  HID: usbhid: use generic hidinput_input_event()
  HID: i2c: use generic hidinput_input_event()
  HID: uhid: use generic hidinput_input_event()
  HID: add transport driver documentation
  HID: implement new transport-driver callbacks

 Documentation/hid/hid-transport.txt | 299 ++++++++++++++++++++++++++++++++++++
 Documentation/hid/uhid.txt          |   4 +-
 drivers/hid/hid-input.c             |  80 +++++++++-
 drivers/hid/i2c-hid/i2c-hid.c       |  24 ---
 drivers/hid/uhid.c                  |  52 ++++---
 drivers/hid/usbhid/hid-core.c       | 144 +++++++++--------
 drivers/hid/usbhid/usbhid.h         |   3 -
 include/linux/hid.h                 |  10 +-
 include/uapi/linux/uhid.h           |   4 +-
 net/bluetooth/hidp/core.c           |  90 +++++++++++
 10 files changed, 590 insertions(+), 120 deletions(-)
 create mode 100644 Documentation/hid/hid-transport.txt

-- 
1.8.3.2

