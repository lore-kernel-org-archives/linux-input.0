From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 00/16] HID: uhid: User-space HID I/O driver
Date: Sun, 10 Jun 2012 15:16:12 +0200
Message-ID: <1339334188-21766-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:65521 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754047Ab2FJNQl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 10 Jun 2012 09:16:41 -0400
Received: by wibhm6 with SMTP id hm6so2577629wib.1
        for <linux-input@vger.kernel.org>; Sun, 10 Jun 2012 06:16:40 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, David Herrmann <dh.herrmann@googlemail.com>

This adds a new low-level HID driver that allows user-space to implement the
transport-layer. This is needed by HOGP (HID over Gatt on Bluetooth Low Energy).
There is already an implementation of HOGP, see the
linux-bluetooth@vger.kernel.org mailing list for this.

I've split this into multiple patches to make review easier. This patchset is
already working for several months for the HOGP developers but there may still
be some issues with it. Please review.

The uhid_*() functions implement the basic module functionality. The
uhid_char_*() functions handle character-device related functionality. The
uhid_dev_*() functions handle the uhid-device object and the uhid_hid_*()
functions are HID-callbacks.

I am open for any suggestions.

Regards
David

David Herrmann (16):
  HID: uhid: introduce user-space I/O driver support for HID
  HID: uhid: add internal message buffer
  HID: uhid: allow poll()'ing on uhid devices
  HID: uhid: implement read() on uhid devices
  HID: uhid: implement write() on uhid devices
  HID: uhid: add UHID_CREATE and UHID_DESTROY events
  HID: uhid: allow feeding input data into uhid devices
  HID: uhid: forward hid report-descriptor to hid core
  HID: uhid: add UHID_START and UHID_STOP events
  HID: uhid: forward open/close events to user-space
  HID: uhid: forward output request to user-space
  HID: uhid: forward raw output reports to user-space
  HID: uhid: implement feature requests
  HID: uhid: add documentation
  HID: uhid: add example program
  MAINTAINERS: add UHID entry

 Documentation/hid/uhid.txt  |  169 +++++++++++++
 MAINTAINERS                 |    7 +
 drivers/hid/Kconfig         |   21 ++
 drivers/hid/Makefile        |    1 +
 drivers/hid/uhid.c          |  572 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/Kbuild        |    1 +
 include/linux/uhid.h        |  104 ++++++++
 samples/uhid/Makefile       |   10 +
 samples/uhid/uhid-example.c |  381 ++++++++++++++++++++++++++++
 9 files changed, 1266 insertions(+)
 create mode 100644 Documentation/hid/uhid.txt
 create mode 100644 drivers/hid/uhid.c
 create mode 100644 include/linux/uhid.h
 create mode 100644 samples/uhid/Makefile
 create mode 100644 samples/uhid/uhid-example.c

-- 
1.7.10.4

