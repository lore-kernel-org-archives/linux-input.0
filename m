From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 0/1] HID: User-space HID I/O driver (UHID)
Date: Mon, 30 Apr 2012 17:27:29 +0200
Message-ID: <1335799650-17597-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:61561 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753049Ab2D3P1t (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Apr 2012 11:27:49 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, marcel@holtmann.org, claudio.takahasi@openbossa.org, jprvita@openbossa.org, linux-bluetooth@vger.kernel.org, David Herrmann <dh.herrmann@googlemail.com>

Hi

This implements a hid_ll_driver user-space interface similar to uinput for the
input devices. It allows to implement the HID transport-layer in user-space as
required by Bluetooth Low-Energy (HoG).

This is my "first final revision" for the module. Please review and test.
Changes from the previous RFCs include:
 - The feature-report mechanism is now implemented
 - Several min_t() fixes
 - Minor coding-style issues

I did not change __attribute__((__packed__)) to __packed as the latter one is
not provided to user-space.

If there are any more issues, please tell me. And for the record, the HoG devs
told me that they are working since several months with it now so we have a real
user-space application that needs it ;)

If there are no more issues (which i doubt) I can also resend this splitted into
multiple patches.

Regards
David

David Herrmann (1):
  HID: User-space I/O driver support for HID subsystem

 Documentation/hid/uhid.txt  |  169 +++++++++++++
 drivers/hid/Kconfig         |   21 ++
 drivers/hid/Makefile        |    2 +-
 drivers/hid/uhid.c          |  572 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/Kbuild        |    1 +
 include/linux/uhid.h        |  104 ++++++++
 samples/uhid/Makefile       |   10 +
 samples/uhid/uhid-example.c |  381 ++++++++++++++++++++++++++++
 8 files changed, 1259 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/hid/uhid.txt
 create mode 100644 drivers/hid/uhid.c
 create mode 100644 include/linux/uhid.h
 create mode 100644 samples/uhid/Makefile
 create mode 100644 samples/uhid/uhid-example.c

-- 
1.7.10

