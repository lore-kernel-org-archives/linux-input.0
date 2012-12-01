From: Andre Guedes <andre.guedes@openbossa.org>
Subject: [RFC v2 0/4] uhid LED input events handling
Date: Sat,  1 Dec 2012 16:07:17 -0300
Message-ID: <1354388841-23854-1-git-send-email-andre.guedes@openbossa.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:34342 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752297Ab2LATHj (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 1 Dec 2012 14:07:39 -0500
Received: by mail-vc0-f174.google.com with SMTP id d16so688953vcd.19
        for <linux-input@vger.kernel.org>; Sat, 01 Dec 2012 11:07:38 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dh.herrmann@googlemail.com

Hi all,

This patchset implements the support for handling LED input events in uhid
driver.

As requested in the previous RFC, it was introduced a new helper in hid-input.c
to carry out a generic LED input events handling (hidinput_led_output_report).
The helper is used by uhid driver.

The helper can also be used in i2c-hid driver since it does a very simply
handling of LED events too. I have no i2c device to test the i2c-hid patch,
so it requires some testing before applying it.

As long as the helper relies on device's .hid_output_raw_report() and
hid-logitech-dj driver doesn't properly implement this callback, the helper is
not used in hid-logitech-dj driver.

Also, this helper is not used in usbhid driver as long as it does a more
sophisticated handling than what hidinput_led_output_report helper does. For
further information about usbhid LEDs handling see comments in the patchset [1].

This patchset is rebased on Jiri's for-next branch.

Best regards,

Andre Guedes

[1] - http://marc.info/?l=linux-usb&m=132013970108623&w=2


Andre Guedes (4):
  HID: Add generic handler for LED input events
  HID: uhid: Handle LED input events
  HID: uhid: Use GFP_ATOMIC in uhid_hid_output_raw
  HID: i2c-hid: LED input events handling

 drivers/hid/hid-input.c       | 51 +++++++++++++++++++++++++++++++++++++++++++
 drivers/hid/i2c-hid/i2c-hid.c | 11 +---------
 drivers/hid/uhid.c            | 34 +++++++++++++++++++----------
 include/linux/hid.h           |  2 ++
 4 files changed, 76 insertions(+), 22 deletions(-)

-- 
1.8.0.1

