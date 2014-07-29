From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 00/12] HID: Convert UHID to new HID transport-layer
Date: Tue, 29 Jul 2014 17:14:14 +0200
Message-ID: <1406646866-999-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:34667 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752764AbaG2POr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Jul 2014 11:14:47 -0400
Received: by mail-wg0-f41.google.com with SMTP id z12so9290714wgg.24
        for <linux-input@vger.kernel.org>; Tue, 29 Jul 2014 08:14:44 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, David Herrmann <dh.herrmann@gmail.com>

Hi

When Benjamin cleanup up the transport layer, he left UHID mostly unconverted
due to ABI issues. I promised to take a look, so here're the patches.

Most of the patches are fairly straightforward. Comments welcome. I tested an
old uhid-sample.c build and it still works, so I think I didn't break
backwards-compatibility.

Thanks
David

David Herrmann (12):
  HID: uhid: simplify report-cb shutdown
  HID: uhid: forward create_req to create2_req
  HID: uhid: avoid dangling pointers in uhid context
  HID: uhid: avoid magic-numbers when setting strings
  HID: uhid: turn report_id into u32
  HID: uhid: invert report_done and make non-atomic
  HID: uhid: add ABI compatible UHID_GET_REPORT replacing UHID_FEATURE
  HID: uhid: keep legacy definitions at the bottom of uhid.h
  HID: uhid: rename uhid_raw_request to uhid_hid_raw_request
  HID: uhid: implement SET_REPORT
  HID: uhid: report to user-space whether reports are numbered
  HID: uhid: update documentation

 Documentation/hid/uhid.txt | 179 ++++++++++----------
 drivers/hid/uhid.c         | 394 +++++++++++++++++++++++++--------------------
 include/uapi/linux/uhid.h  | 120 +++++++++++---
 3 files changed, 408 insertions(+), 285 deletions(-)

-- 
2.0.3

